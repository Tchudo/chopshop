// barcode scanner
import Quagga from 'quagga';

function order_by_occurrence(arr) {
  var counts = {};
  arr.forEach(function(value){
      if(!counts[value]) {
          counts[value] = 0;
      }
      counts[value]++;
  });

  return Object.keys(counts).sort(function(curKey,nextKey) {
      return counts[curKey] < counts[nextKey];
  });
};

function load_quagga(){
  console.log("start Quagga");
  if ($('#barcode-scanner').length > 0 && navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {

    var last_result = [];
    if (Quagga.initialized == undefined) {
      Quagga.onDetected(function(result) {
        var last_code = result.codeResult.code;
        last_result.push(last_code);
        console.log(last_result);


        if (last_result.length > 50) {
          console.log(order_by_occurrence(last_result));
          var results = order_by_occurrence(last_result);
          var code = results[results.length-1];
          console.log(results);
          console.log(code);
          last_result = [];
          Quagga.stop();
          console.log("ajax");
          window.location.href = `/products/get_barcode?upc=${code}`
          // $.ajax({
          //   type: "POST",
          //   url: '/products/get_barcode',
          //   data: { upc: code }
          // });
        }
      });
    };

    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        numOfWorkers: navigator.hardwareConcurrency,
        target: document.querySelector('#barcode-scanner')
      },
      decoder: {
          readers : ['ean_reader','ean_8_reader','code_39_reader','code_39_vin_reader','codabar_reader','upc_reader','upc_e_reader']
      }
    },function(err) {
        if (err) { console.log(err); return }
        Quagga.initialized = true;
        Quagga.start();
    });

  } else if (Quagga.initialized !== undefined) {
    Quagga.stop();
    };

};

export { load_quagga };

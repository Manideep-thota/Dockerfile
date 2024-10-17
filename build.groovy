@Library(['edp-library-stages', 'edp-library-pipelines']) _

Build()

// def recepients = 'anton_karasov@epam.com, anatolii_stoliarov@epam.com, viktor_gema@epam.com, borys_samsonov@epam.com'

// node {
//     try {
//         Build()
//     } catch (any) { 
//         currentBuild.result = 'FAILURE'
//     } finally {
//         if (currentBuild.result == "FAILURE") {
//             step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: recepients, sendToIndividuals: true])
//         }
//     }
// }

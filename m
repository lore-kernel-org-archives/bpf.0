Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A73C282DF
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94D420645
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfDSStv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:49:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:11707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfDSSts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 14:49:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 04:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,369,1549958400"; 
   d="scan'208";a="137141603"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Apr 2019 04:16:33 -0700
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 irsmsx105.ger.corp.intel.com (163.33.3.28) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 19 Apr 2019 12:16:32 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.31]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.53]) with mapi id 14.03.0415.000;
 Fri, 19 Apr 2019 12:16:32 +0100
From:   "Ananyev, Konstantin" <konstantin.ananyev@intel.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: FW: BPF_PSEUDO_CALL question
Thread-Topic: FW: BPF_PSEUDO_CALL question
Thread-Index: AdTvzEMj1sREBxpSRtWTDzCNV9r61ADt743gABjhvIAAHmjtsAABa1SAAI48uVA=
Date:   Fri, 19 Apr 2019 11:16:31 +0000
Message-ID: <2601191342CEEE43887BDE71AB9772580148A99F8B@irsmsx105.ger.corp.intel.com>
References: <2601191342CEEE43887BDE71AB9772580148A95A96@irsmsx105.ger.corp.intel.com>
 <2601191342CEEE43887BDE71AB9772580148A97E27@irsmsx105.ger.corp.intel.com>
 <CAADnVQJoo7vSaCCFGpTgrQmCw4Cq-FcLhPtzr=YNaZ7y31ahLg@mail.gmail.com>
 <2601191342CEEE43887BDE71AB9772580148A9869C@irsmsx105.ger.corp.intel.com>
 <CAADnVQKuwL2j7-gOB9fEJ3CQydkPPgr8fT7FT_pzrOTBE=b5Cg@mail.gmail.com>
In-Reply-To: <CAADnVQKuwL2j7-gOB9fEJ3CQydkPPgr8fT7FT_pzrOTBE=b5Cg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWJhYWUyYzEtMDVhNS00NzhmLWFlY2QtOWE4NjczZTllMGFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSlwvd1wvNWRKWjZnMzNhQ0dmdmdLWUVLbVJYVlwvbXNSS3BcL0xXcGhpQXJCZWVmczdFQURXTHZoaHphSVVmc1gzWVIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gPiA+ID4NCj4gPiA+ID4gSGkgQWxleGVpLA0KPiA+ID4gPiBJIHBvc3RlZCB0aGUgcXVl
c3Rpb24gYmVsb3cgb24gbGx2bS1kZXYgbWFpbGluZyBsaXN0LCBidXQgdGhlcmUgaXMgbm8gYW5z
d2VyIHNvIGZhci4NCj4gPiA+ID4gQXMgeW91IHNlZW1zIHRoZSBhdXRob3Igb2YgQlBGX1BTRVVE
T19DQUxMIGluIExMVk0gKGFuZCBsaW51eCBrZXJuZWwpIHRob3VnaHQgbWlnaHQNCj4gPiA+ID4g
YmUgeW91IGtub3cgdGhlIGFuc3dlcj8NCj4gPiA+ID4gSSBsb29rZWQgdGhyb3VnaCB0aGUgcGF0
Y2hlcywgYnV0IGRpZG4ndCBzcG90IGFueXRoaW5nIG15c2VsZi4NCj4gPiA+ID4gVGhhbmtzDQo+
ID4gPiA+IEtvbnN0YW50aW4NCj4gPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+ID4gRnJvbTogbGx2bS1kZXYgW21haWx0bzpsbHZtLWRldi1ib3VuY2VzQGxp
c3RzLmxsdm0ub3JnXSBPbiBCZWhhbGYgT2YgQW5hbnlldiwgS29uc3RhbnRpbiB2aWEgbGx2bS1k
ZXYNCj4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxMCwgMjAxOSA3OjM3IFBNDQo+ID4g
PiA+IFRvOiBsbHZtLWRldkBsaXN0cy5sbHZtLm9yZw0KPiA+ID4gPiBTdWJqZWN0OiBbbGx2bS1k
ZXZdIEJQRl9QU0VVRE9fQ0FMTCBxdWVzdGlvbg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBI
aSBldmVyeW9uZSwNCj4gPiA+ID4gd2l0aCBjbGFuZyA2LjAgYW5kIG9ud2FyZHMsIGZvciB0aGUg
Zm9sbG93aW5nIGNvZGU6DQo+ID4gPiA+ICQgY2F0IHQ2LmMNCj4gPiA+ID4NCj4gPiA+ID4gI2lu
Y2x1ZGUgPHN0ZGludC5oPg0KPiA+ID4gPg0KPiA+ID4gPiBleHRlcm4gaW50IGZmeDEoY29uc3Qg
dm9pZCAqcCk7DQo+ID4gPiA+DQo+ID4gPiA+IHVpbnQ2NF90IGVudHJ5KGNvbnN0IHZvaWQgKnAp
DQo+ID4gPiA+IHsNCj4gPiA+ID4gICAgICAgICByZXR1cm4gZmZ4MShwKTsNCj4gPiA+ID4gfQ0K
PiA+ID4gPg0KPiA+ID4gPiBjbGFuZyAtTzIgIC10YXJnZXQgYnBmZWwgLWMgdDYuYw0KPiA+ID4g
PiBnZW5lcmF0ZXMgZm9yIHRoZSBjYWxsIEJQRl9QU0VVRE9fQ0FMTCBpbnN0cnVjdGlvbjoNCj4g
PiA+ID4gZW50cnk6DQo+ID4gPiA+ICAgICAgICAwOiAgICAgICA4NSAxMCAwMCAwMCBmZiBmZiBm
ZiBmZiAgICAgICAgIGNhbGwgLTENCj4gPiA+ID4gICAgICAgIDE6ICAgICAgIDY3IDAwIDAwIDAw
IDIwIDAwIDAwIDAwICAgICAgICAgcjAgPDw9IDMyDQo+ID4gPiA+ICAgICAgICAyOiAgICAgICBj
NyAwMCAwMCAwMCAyMCAwMCAwMCAwMCAgICAgICAgIHIwIHM+Pj0gMzINCj4gPiA+ID4gICAgICAg
IDM6ICAgICAgIDk1IDAwIDAwIDAwIDAwIDAwIDAwIDAwICAgICAgICAgZXhpdA0KPiA+ID4gPg0K
PiA+ID4gPiBJcyB0aGVyZSBhbnkgd2F5IHRvIGZvcmNlIGNsYW5nIHRvIGdlbmVyYXRlIHByb3Bl
ciBCUEZfQ0FMTCBpbnN0cnVjdGlvbiwNCj4gPiA+ID4gaS5lOiA4NSAwMCAwMCAwMCBmZiBmZiBm
ZiBmZiAoYXMgaXQgZGlkIGluIG9sZGVyIHZlcnNpb25zKT8NCj4gPiA+DQo+ID4gPiBvbGRlciB2
ZXJzaW9uIG9mIGxsdm0gZ2VuZXJhdGVkIGJyb2tlbiBjb2RlLg0KPiA+ID4gdGhlcmUgYXJlIG9u
bHkgdHdvIGNhbGwgZmxhdm9yczoNCj4gPiA+IC0gY2FsbCBpbW0gLT4gY2FsbGluZyBwYXJ0aWN1
bGFyIGtlcm5lbCBoZWxwZXIgd2hlcmUgaW1tPT1oZWxwZXJfaWQNCj4gPg0KPiA+IE9rIGJ1dCBp
biB0aGUgZXhhbXBsZSBhYm92ZSwgaXMgaXQgcG9zc2libGUgdGVsbCB0byB0aGUgbGx2bSB0aGF0
DQo+ID4gZmZ4MSgpIGlzIGFjdHVhbGx5IGEga2VybmVsIGhlbHBlciB3aXRoIGlkPT1YPw0KPiAN
Cj4gaGVyZSBpcyBob3cgaXQgd29ya3MgZm9yIGhlbHBlcnM6DQo+IHN0YXRpYyB2b2lkICooKmJw
Zl9tYXBfbG9va3VwX2VsZW0pKHZvaWQgKm1hcCwgY29uc3Qgdm9pZCAqa2V5KSA9DQo+ICAgICAg
ICAgKHZvaWQgKikgQlBGX0ZVTkNfbWFwX2xvb2t1cF9lbGVtOw0KPiANCj4gVXNlciBzcGFjZSBj
YW4gaGFjayBzaW1pbGFyIHRoaW5nIGZvciBhbnkgaW50ZWdlciBhbmQgYW55IG5hbWUuDQoNClRo
YW5rcyBhIGxvdC4NClllcywgc3VjaCBhcHByb2FjaCB3b3VsZCB3b3JrLg0KVGhvdWdoIGl0IG1l
YW5zIHRoYXQgdXNlciB3aWxsIG5lZWQgdG8gZGVmaW5lIGV4YWN0IGlkIGZvciB0aGUgZWFjaCAg
aGVscGVyIGZ1bmN0aW9uDQphbmQga2VlcCBpdCBhbHdheXMgaW4gc3luYyBiZXR3ZWVuIGJwZiBw
cm9ncmFtcyBhbmQgYnBmIGV4ZWN1dGlvbiBlbnZpcm9ubWVudC4gDQpQcm9iYWJseSBub3QgYSBi
aWcgZGVhbCBmb3Iga2VybmVsIHdoZW4gYWxsIGhlbHBlcnMgYXJlIHdlbGwgZGVmaW5lZCBhbmQg
cmVzdHJpY3RlZCwNCmJ1dCBtaWdodCBiZWNvbWUgbWVzc3kgZm9yIHVzZXItc3BhY2Ugd2hlcmUg
ZWFjaCBhcHAgbWlnaHQgd2FudCB0byBoYXZlIGl0J3MNCm93biBzZXQgb2YgaGVscGVycy4NCk15
IHRob3VnaHQgd2FzIC0gbWlnaHQgYmUgaXQgaXMgcG9zc2libGUgdG8gc2F5IHRvIGxsdm0gdGhh
dCBpdCBpcyBhIGhlbHBlciBmdW5jdGlvbg0KYnV0IHdpdGggdW5rbm93biBpZCB0aGF0IHdpbGwg
YmUgcmVzb2x2ZWQgZHluYW1pY2FsbHkgYXQgYnBmIGxvYWQgdGltZS4NCkkgcHJlc3VtZSB0aGUg
YW5zd2VyIGlzICdubycsIGJ1dCB3YW50ZWQgdG8gZG91YmxlLWNoZWNrIHRoYXQgSSBhbSBub3Qg
bWlzc2luZw0Kc29tZXRoaW5nIG9idmlvdXMgaGVyZS4NCktvbnN0YW50aW4gIA0KDQo=

Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43FC282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 14:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FE920656
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 14:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfDPOeb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:34:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:34288 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbfDPOeb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 10:34:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 07:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="141146268"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2019 07:34:19 -0700
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.31]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.246]) with mapi id 14.03.0415.000;
 Tue, 16 Apr 2019 15:34:18 +0100
From:   "Ananyev, Konstantin" <konstantin.ananyev@intel.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: RE: FW: BPF_PSEUDO_CALL question
Thread-Topic: FW: BPF_PSEUDO_CALL question
Thread-Index: AdTvzEMj1sREBxpSRtWTDzCNV9r61ADt743gABjhvIAAHmjtsA==
Date:   Tue, 16 Apr 2019 14:34:17 +0000
Message-ID: <2601191342CEEE43887BDE71AB9772580148A9869C@irsmsx105.ger.corp.intel.com>
References: <2601191342CEEE43887BDE71AB9772580148A95A96@irsmsx105.ger.corp.intel.com>
 <2601191342CEEE43887BDE71AB9772580148A97E27@irsmsx105.ger.corp.intel.com>
 <CAADnVQJoo7vSaCCFGpTgrQmCw4Cq-FcLhPtzr=YNaZ7y31ahLg@mail.gmail.com>
In-Reply-To: <CAADnVQJoo7vSaCCFGpTgrQmCw4Cq-FcLhPtzr=YNaZ7y31ahLg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDdkYzkyMjUtNjg2Ni00NzQwLTkxNjAtMTcxYmVkZjhhYWEzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWHRQXC9wWGVsamtxQTZBb3pLYnhacURiYWx1RFlnd1JhZmtYeXRuT05kajlqSHAyZVBoaUNpTDVOaHNjWUNRVXgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGVpIFN0YXJvdm9p
dG92IFttYWlsdG86YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbV0NCj4gU2VudDogVHVlc2Rh
eSwgQXByaWwgMTYsIDIwMTkgMjowMSBBTQ0KPiBUbzogQW5hbnlldiwgS29uc3RhbnRpbiA8a29u
c3RhbnRpbi5hbmFueWV2QGludGVsLmNvbT47IGJwZiA8YnBmQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUmU6IEZXOiBCUEZfUFNFVURPX0NBTEwgcXVlc3Rpb24NCj4gDQo+IE9uIE1vbiwg
QXByIDE1LCAyMDE5IGF0IDU6MTMgQU0gQW5hbnlldiwgS29uc3RhbnRpbg0KPiA8a29uc3RhbnRp
bi5hbmFueWV2QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBBbGV4ZWksDQo+ID4gSSBw
b3N0ZWQgdGhlIHF1ZXN0aW9uIGJlbG93IG9uIGxsdm0tZGV2IG1haWxpbmcgbGlzdCwgYnV0IHRo
ZXJlIGlzIG5vIGFuc3dlciBzbyBmYXIuDQo+ID4gQXMgeW91IHNlZW1zIHRoZSBhdXRob3Igb2Yg
QlBGX1BTRVVET19DQUxMIGluIExMVk0gKGFuZCBsaW51eCBrZXJuZWwpIHRob3VnaHQgbWlnaHQN
Cj4gPiBiZSB5b3Uga25vdyB0aGUgYW5zd2VyPw0KPiA+IEkgbG9va2VkIHRocm91Z2ggdGhlIHBh
dGNoZXMsIGJ1dCBkaWRuJ3Qgc3BvdCBhbnl0aGluZyBteXNlbGYuDQo+ID4gVGhhbmtzDQo+ID4g
S29uc3RhbnRpbg0KPiA+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBsbHZtLWRldiBbbWFpbHRvOmxsdm0tZGV2LWJvdW5jZXNAbGlzdHMubGx2bS5vcmddIE9uIEJl
aGFsZiBPZiBBbmFueWV2LCBLb25zdGFudGluIHZpYSBsbHZtLWRldg0KPiA+IFNlbnQ6IFdlZG5l
c2RheSwgQXByaWwgMTAsIDIwMTkgNzozNyBQTQ0KPiA+IFRvOiBsbHZtLWRldkBsaXN0cy5sbHZt
Lm9yZw0KPiA+IFN1YmplY3Q6IFtsbHZtLWRldl0gQlBGX1BTRVVET19DQUxMIHF1ZXN0aW9uDQo+
ID4NCj4gPg0KPiA+IEhpIGV2ZXJ5b25lLA0KPiA+IHdpdGggY2xhbmcgNi4wIGFuZCBvbndhcmRz
LCBmb3IgdGhlIGZvbGxvd2luZyBjb2RlOg0KPiA+ICQgY2F0IHQ2LmMNCj4gPg0KPiA+ICNpbmNs
dWRlIDxzdGRpbnQuaD4NCj4gPg0KPiA+IGV4dGVybiBpbnQgZmZ4MShjb25zdCB2b2lkICpwKTsN
Cj4gPg0KPiA+IHVpbnQ2NF90IGVudHJ5KGNvbnN0IHZvaWQgKnApDQo+ID4gew0KPiA+ICAgICAg
ICAgcmV0dXJuIGZmeDEocCk7DQo+ID4gfQ0KPiA+DQo+ID4gY2xhbmcgLU8yICAtdGFyZ2V0IGJw
ZmVsIC1jIHQ2LmMNCj4gPiBnZW5lcmF0ZXMgZm9yIHRoZSBjYWxsIEJQRl9QU0VVRE9fQ0FMTCBp
bnN0cnVjdGlvbjoNCj4gPiBlbnRyeToNCj4gPiAgICAgICAgMDogICAgICAgODUgMTAgMDAgMDAg
ZmYgZmYgZmYgZmYgICAgICAgICBjYWxsIC0xDQo+ID4gICAgICAgIDE6ICAgICAgIDY3IDAwIDAw
IDAwIDIwIDAwIDAwIDAwICAgICAgICAgcjAgPDw9IDMyDQo+ID4gICAgICAgIDI6ICAgICAgIGM3
IDAwIDAwIDAwIDIwIDAwIDAwIDAwICAgICAgICAgcjAgcz4+PSAzMg0KPiA+ICAgICAgICAzOiAg
ICAgICA5NSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAgICAgIGV4aXQNCj4gPg0KPiA+IElzIHRo
ZXJlIGFueSB3YXkgdG8gZm9yY2UgY2xhbmcgdG8gZ2VuZXJhdGUgcHJvcGVyIEJQRl9DQUxMIGlu
c3RydWN0aW9uLA0KPiA+IGkuZTogODUgMDAgMDAgMDAgZmYgZmYgZmYgZmYgKGFzIGl0IGRpZCBp
biBvbGRlciB2ZXJzaW9ucyk/DQo+IA0KPiBvbGRlciB2ZXJzaW9uIG9mIGxsdm0gZ2VuZXJhdGVk
IGJyb2tlbiBjb2RlLg0KPiB0aGVyZSBhcmUgb25seSB0d28gY2FsbCBmbGF2b3JzOg0KPiAtIGNh
bGwgaW1tIC0+IGNhbGxpbmcgcGFydGljdWxhciBrZXJuZWwgaGVscGVyIHdoZXJlIGltbT09aGVs
cGVyX2lkDQoNCk9rIGJ1dCBpbiB0aGUgZXhhbXBsZSBhYm92ZSwgaXMgaXQgcG9zc2libGUgdGVs
bCB0byB0aGUgbGx2bSB0aGF0DQpmZngxKCkgaXMgYWN0dWFsbHkgYSBrZXJuZWwgaGVscGVyIHdp
dGggaWQ9PVg/DQoNCj4gLSBjYWxsIHBzZXVkbyArLW9mZiAtPiBjYWxsIGFub3RoZXIgYnBmIGZ1
bmN0aW9uDQo+IHRoZXJlIGlzIG5vIGFyYml0cmFyeSBjYWxsIHN1cHBvcnQgeWV0Lg0K

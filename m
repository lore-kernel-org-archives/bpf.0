Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CCBC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FC3218D0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SjA8e4kr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BVbd93gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfB1SwF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:52:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfB1SwF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 13:52:05 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SIpDD5005651;
        Thu, 28 Feb 2019 10:51:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pmCX5kc6143WxgrQoretnNsYKuH7WRSL3wA6uVafOv4=;
 b=SjA8e4kr3cu0NkNaTGAVyfkq5qQeoKZ8aXrM2LIKZIJvYWZymy/nwIENFGSVtmWWsAVi
 9NpS0oKwWBl6YaCDTM52K4QAfp52lQSKaxL+WaB66JEIxhZCsPNvomO07PRI3s8lomd6
 U/Q6bLvva42Sy6hkIF97eXajlIqnFjAv1EI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxj3x0sab-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 10:51:43 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 10:50:24 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 10:50:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmCX5kc6143WxgrQoretnNsYKuH7WRSL3wA6uVafOv4=;
 b=BVbd93gGNjHtHKbux8ZX2FzTrkjFHipauaRaU4+DoJCmZAixQ19qPXNRfL0yLv/eWE5yY5NAjDW96O+GxZHEHDpepfpTn9tECC82mf8eir2hc8lPj8+EpWrrmBtum0kWe7LHBkC7RkAyrV1GEYnOJsFkpGDQa3PRQe6EgDOnwis=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3447.namprd15.prod.outlook.com (20.179.59.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 18:50:23 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 18:50:23 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Jiong Wang <jiong.wang@netronome.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: [PATCH LLVM v2 0/3] bpf: improvements on XADD semantics check and
 code-gen
Thread-Topic: [PATCH LLVM v2 0/3] bpf: improvements on XADD semantics check
 and code-gen
Thread-Index: AQHUz0xVFzUo0p/HXEC+G5AUPepCZaX1jlEA
Date:   Thu, 28 Feb 2019 18:50:23 +0000
Message-ID: <1a4bf225-2f41-aa35-cf28-3ddf5cc23a9d@fb.com>
References: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e2ab]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c4734c-2b1d-4428-c119-08d69dad983f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3447;
x-ms-traffictypediagnostic: BYAPR15MB3447:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3447;20:g3WvXbo+aV92jnq47wRL65KhCbcD75eoGdaTqUttMEohfdVADsHmN7YIYuzATT2lHLD1zFeucaqZWGSBawEHZp7sd9JCQOOUDCKDHpJAxYGyqQTLmsv71wnjQKtDTWVnWa41no7bPe1OuXBxrPVOm+OeuDnO3xoTc5oxHC6x7MU=
x-microsoft-antispam-prvs: <BYAPR15MB3447C225A20B7C60FAAD2ED0D3750@BYAPR15MB3447.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(305945005)(36756003)(71200400001)(71190400001)(229853002)(446003)(6246003)(186003)(6506007)(386003)(53546011)(102836004)(7736002)(5660300002)(2501003)(6486002)(31696002)(6512007)(2616005)(8936002)(81166006)(97736004)(6346003)(110136005)(316002)(54906003)(8676002)(86362001)(81156014)(31686004)(476003)(6116002)(14454004)(99286004)(52116002)(478600001)(5024004)(106356001)(2906002)(486006)(256004)(11346002)(14444005)(46003)(53936002)(6436002)(4326008)(68736007)(25786009)(105586002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3447;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dFnNr/8oaA3FFpwRjF0aSDD8zliZq2HVKQGbaEm98lP2Ze8brC364LsgITVWrXrVt1amAZrdNVmG3HCF+Bo+hFv3UjGgbnZdmg7LVqnRmIlmQUpoFWoP+hSBj66aa/eywFMWGBv1BdEMogoTKsap9Sg4YJkMdGgbK9/4SkfzjtPyaRhmfstmttXtKaCcMBNFrzBHi1vLnFlqHXk8cEgvLSFGC5FlWZ881u6cqCRHmoid9tImUr/2c5DhzE/byWz3ejXVaJLMqofRga+PxCYoky0oHfTV/h3tSG9D6Yny2zddXj5CMyq0JtzDluH9B9vvJOcEzoudaNgpwcBEC5kpzHuXdyaeNJbqcM1h/0ccVvGCE0bfjc/XnLl0Xnt+b7Y9fsH5JSqdGwbETJU81U2oSdDban2zsuOv8JkmVStCqI4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1E288A23A57184AAD4999126E917D5A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c4734c-2b1d-4428-c119-08d69dad983f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 18:50:23.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3447
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjgvMTkgMTo1OSBBTSwgSmlvbmcgV2FuZyB3cm90ZToNCj4gdjEtPnYyOg0KPiAg
IC0gU2ltcGxpZmllZCBjb2RlIGxvZ2ljIGluc2lkZSBoYXNMaXZlRGVmcy4gKFlvbmdob25nKQ0K
PiAgIC0gVXBkYXRlZCB0ZXN0Y2FzZSBpbnNuLXVuaXQucyAoWW9uZ2hvbmcpDQo+IA0KPiBCUEYg
WEFERCBzZW1hbnRpY3MgcmVxdWlyZSBhbGwgRGVmcyBvZiBYQUREIGFyZSBkZWFkLCBtZWFuaW5n
IGFueSByZXN1bHQgb2YNCj4gWEFERCBpbnNuIGlzIG5vdCB1c2VkLg0KPiANCj4gSG93ZXZlciwg
QlBGIGJhY2tlbmQgaGFzbid0IGVuYWJsZWQgc3ViLXJlZ2lzdGVyIGxpdmVuZXNzIHRyYWNrLCBz
byB3aGVuDQo+IHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIG9wZXJhbmRzIG9mIFhBREQgYXJl
IEdQUjMyLCB0aGVyZSBpcyBubw0KPiBzdWItcmVnaXN0ZXIgZGVhZCBpbmZvLiBJZiB3ZSByZWx5
IG9uIHRoZSBnZW5lcmljDQo+IE1hY2hpbmVJbnN0cjo6YWxsRGVmc0FyZURlYWQsIHRoZW4gd2Ug
d2lsbCByYWlzZSBmYWxzZSBhbGFybSBvbiBHUFIzMiBEZWYuDQo+IA0KPiBUaGlzIHdhcyBmaW5l
IGFzIHRoZXJlIHdhcyBubyBzdWItcmVnaXN0ZXIgY29kZS1nZW4gc3VwcG9ydCBmb3IgWEFERCwg
YnV0DQo+IGl0IHdpbGwgYmUgYWRkZWQgYnkgdGhlIHNlY29uZCBwYXRjaC4gV2l0aG91dCBwcm9w
ZXIgaGFuZGxpbmcgb2YgR1BSMzIgRGVmLA0KPiB0ZXN0Y2FzZSBsaWtlIHRoZSBvbmUgYWRkZWQg
aW4gdGhlIHNlY29uZCBwYXRjaCB3aWxsIGZhaWwgb24gc3ViLXJlZ2lzdGVyDQo+IGNvZGUtZ2Vu
IG1vZGUuDQo+IA0KPiBUbyBzdXBwb3J0IEdQUjMyIERlZiwgaWRlYWxseSB3ZSBjb3VsZCBqdXN0
IGVuYWJsZSBzdWItcmVnaXN0ciBsaXZlbmVzcw0KPiB0cmFjayBvbiBCUEYgYmFja2VuZCwgdGhl
biBhbGxEZWZzQXJlRGVhZCBjb3VsZCB3b3JrIG9uIEdQUjMyIERlZi4gVGhpcw0KPiByZXF1aXJl
cyBpbXBsZW1lbnRpbmcgVGFyZ2V0U3VidGFyZ2V0SW5mbzo6ZW5hYmxlU3ViUmVnTGl2ZW5lc3Mg
b24gQlBGLg0KPiANCj4gSG93ZXZlciwgc3ViLXJlZ2lzdGVyIGxpdmVuZXNzIHRyYWNraW5nIG1v
ZHVsZSBpbnNpZGUgTExWTSBpcyBhY3R1YWxseQ0KPiBkZXNpZ25lZCBmb3IgdGhlIHNpdHVhdGlv
biB3aGVyZSBvbmUgcmVnaXN0ZXIgY291bGQgYmUgc3BsaXQgaW50byBtb3JlIHRoYW4NCj4gb25l
IHN1Yi1yZWdpc3RlcnMgZm9yIHdoaWNoIGNhc2UgZWFjaCBzdWItcmVnaXN0ZXIgY291bGQgaGF2
ZSB0aGVpciBvd24NCj4gbGl2ZW5lc3MgYW5kIGtpbGwgb25lIG9mIHRoZW0gZG9lc24ndCBraWxs
IG90aGVycy4gU28sIHRyYWNraW5nIGxpdmVuZXNzDQo+IGZvciBlYWNoIG1ha2Ugc2Vuc2UuDQo+
IA0KPiBGb3IgQlBGLCBlYWNoIDY0LWJpdCByZWdpc3RlciBjb3VsZCBvbmx5IGhhdmUgb25lIDMy
LWJpdCBzdWItcmVnaXN0ZXIuIFRoaXMNCj4gaXMgZXhhY3RseSB0aGUgY2FzZSB3aGljaCBMTFZN
IHRoaW5rIGJyaW5ncyBubyBiZW5lZml0cyBmb3IgZG9pbmcNCj4gc3ViLXJlZ2lzdGVyIHRyYWNr
aW5nLCBiZWNhdXNlIHRoZSBsaXZlIHJhbmdlIG9mIHN1Yi1yZWdpc3RlciBtdXN0IGFsd2F5cw0K
PiBlcXVhbCB0byBpdHMgcGFyZW50IHJlZ2lzdGVyLCB0aGVyZWZvcmUgbGl2ZW5lc3MgdHJhY2tp
bmcgaXMgZGlzYWJsZWQgZXZlbg0KPiB0aGUgYmFjay1lbmQgaGFzIGltcGxlbWVudGVkIGVuYWJs
ZVN1YlJlZ0xpdmVuZXNzLiBUaGUgZGV0YWlsZWQgaW5mb3JtYXRpb24NCj4gaXMgYXQgcjIzMjY5
NToNCj4gDQo+ICAgIEF1dGhvcjogTWF0dGhpYXMgQnJhdW4gPG1hdHplQGJyYXVuaXMuZGU+DQo+
ICAgIERhdGU6ICAgVGh1IE1hciAxOSAwMDoyMTo1OCAyMDE1ICswMDAwDQo+ICAgIERvIG5vdCB0
cmFjayBzdWJyZWdpc3RlciBsaXZlbmVzcyB3aGVuIGl0IGJyaW5ncyBubyBiZW5lZml0cw0KPiAN
Cj4gSGVuY2UsIGZvciBCUEYsIHdlIGVuaGFuY2UgTWFjaGluZUluc3RyOjphbGxEZWZzQXJlRGVh
ZC4gR2l2ZW4gdGhlIHNvbG8NCj4gc3ViLXJlZ2lzdGVyIGFsd2F5cyBoYXMgdGhlIHNhbWUgbGl2
ZW5lc3MgYXMgaXRzIHBhcmVudCByZWdpc3RlciwgTExWTSBpcw0KPiBhbHJlYWR5IGF0dGFjaGlu
ZyBhIGltcGxpY2l0IDY0LWJpdCByZWdpc3RlciBEZWYgd2hlbmV2ZXIgdGhlIHRoZXJlIGlzDQo+
IGEgc3ViLXJlZ2lzdGVyIERlZi4gVGhlIGxpdmVuZXNzIG9mIHRoZSBpbXBsaWNpdCA2NC1iaXQg
RGVmIGlzIGF2YWlsYWJsZS4NCj4gRm9yIGV4YW1wbGUsIGZvciAibG9jayAqKHUzMiAqKShyMCAr
IDQpICs9IHc5IiwgdGhlIE1hY2hpbmVPcGVyYW5kIGluZm8NCj4gY291bGQgYmU6DQo+IA0KPiAg
ICAkdzkgPSBYQUREVzMyIGtpbGxlZCAkcjAsIDQsICR3OSh0aWVkLWRlZiAwKSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgaW1wbGljaXQga2lsbGVkICRyOSwgaW1wbGljaXQtZGVmIGRlYWQg
JHI5DQo+IA0KPiBFdmVuIHRob3VnaCB3OSBpcyBub3QgbWFya2VkIGFzIERlYWQsIHRoZSBwYXJl
bnQgcmVnaXN0ZXIgcjkgaXMgbWFya2VkIGFzDQo+IERlYWQgY29ycmVjdGx5LCBhbmQgaXQgaXMg
c2FmZSB0byB1c2Ugc3VjaCBpbmZvcm1hdGlvbiBvciBvdXIgcHVycG9zZS4NCj4gDQo+IEFmdGVy
IGFib3ZlIGltcHJvdmVtZW50cywgdGhlIHNlY29uZCBwYXRjaCBpbiB0aGlzIHNldCB0aGVuIGFk
ZHMNCj4gc3ViLXJlZ2lzdGVyIGNvZGUtZ2VuIHN1cHBvcnQgZm9yIFhBREQuDQo+IA0KPiBKaW9u
ZyBXYW5nICgzKToNCj4gICAgYnBmOiBpbXByb3ZlIGRlYWQgRGVmcyBjaGVjayBmb3IgWEFERA0K
PiAgICBicGY6IGVuYWJsZSBzdWItcmVnaXN0ZXIgY29kZS1nZW4gZm9yIFhBREQNCj4gICAgYnBm
OiBkaXNhc3NlbWJsZXIgc3VwcG9ydCBmb3IgWEFERCB1bmRlciBzdWItcmVnaXN0ZXIgbW9kZQ0K
DQpUaGUgY2hhbmdlIGxvb2tzIGdvb2QuIFRlc3RlZCB3aXRoIHVuaXQgdGVzdHMgYW5kIGtlcm5l
bCBzZWxmdGVzdHMuDQpJIGFkZGVkIHNvbWV0aGluZyBsaWtlIGJlbG93IHRvIG9uZSBvZiB0ZXN0
X3Byb2dzIGJwZiBwcm9ncmFtczoNCiAgICh2b2lkKV9fc3luY19mZXRjaF9hbmRfYWRkKHZhbHVl
X3AsIDEpOw0KYW5kIHRoZSBnZW5lcmF0ZWQgY29kZSBpcyBjb3JyZWN0IGZvciBhbHUzMiBtb2Rl
IGFuZCB0aGUgb2JqZHVtcA0KaXMgYWJsZSB0byBkaXNhc3NlbWJsZSBjb3JyZWN0bHkgd2l0aCAt
bWF0dHI9K2FsdTMyLg0KDQpZb3UgY2FuIGFkZCBteSBhY2s6DQogICBBY2tlZC1ieTogWW9uZ2hv
bmcgU29uZyA8eWhzQGZiLmNvbT4NCg0KQ291bGQgeW91IGdvIGFoZWFkIHRvIHB1c2ggdG8gbGx2
bSB0cnVuaz8gVGhhbmtzIQ0KDQo+IA0KPiAgIGxpYi9UYXJnZXQvQlBGL0JQRkluc3RySW5mby50
ZCAgICAgICAgICAgICAgICAgIHwgMjggKysrKysrLQ0KPiAgIGxpYi9UYXJnZXQvQlBGL0JQRk1J
Q2hlY2tpbmcuY3BwICAgICAgICAgICAgICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiAgIGxpYi9UYXJnZXQvQlBGL0Rpc2Fzc2VtYmxlci9CUEZEaXNhc3NlbWJsZXIuY3BwIHwg
IDMgKy0NCj4gICB0ZXN0L0NvZGVHZW4vQlBGL3hhZGQubGwgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyICsNCj4gICB0ZXN0L0NvZGVHZW4vQlBGL3hhZGRfbGVnYWwubGwgICAgICAgICAgICAg
ICAgICB8IDI2ICsrKysrKysNCj4gICB0ZXN0L01DL0JQRi9pbnNuLXVuaXQucyAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzICstDQo+ICAgdGVzdC9NQy9CUEYvbG9hZC1zdG9yZS0zMi5zICAg
ICAgICAgICAgICAgICAgICAgfCAgMyArDQo+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNTQgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdC9Db2Rl
R2VuL0JQRi94YWRkX2xlZ2FsLmxsDQo+IA0K

Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992BFC43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA0C206C0
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EIr/2m5t";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ak3A56uE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfDYP1a (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:27:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726964AbfDYP13 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 11:27:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3PFKaVH032394;
        Thu, 25 Apr 2019 08:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=T1O/7F8ViMHaYaLNpAluEy2lIsiYVjwFmT43+9c19Yk=;
 b=EIr/2m5tzm2ks9tsHgQmX0ij50w80/6UluQS7cdVTh2oO6/pVZ1TZwrNMzHp0i329LUK
 +gyrB0ziZDGwMUnT6jcnC1+SO7dn4M0ZiivSwDBzhtCmRHk1hp3jrXkSnHB7G4M4Bc8N
 3XnGc+HdNymY9Bqj4O64JRYRCr+/FBoor3A= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2s35gc22q9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Apr 2019 08:27:07 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 25 Apr 2019 08:27:02 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 25 Apr 2019 08:27:01 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Apr 2019 08:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1O/7F8ViMHaYaLNpAluEy2lIsiYVjwFmT43+9c19Yk=;
 b=ak3A56uEU/kZdB4FdllL2golps0+jqb2phjzYbugnpGrnYkMnzNv3Xl+HtPxBoL3sL90qe5PWEZQzszuFtIA0auPEkdmz3YlFy0U7Rj0vZtvyGpDyZNMmGfJyfLJ+P6v2H8KE/Ub6yD6cQL985ncMXi0qcTLTpyBdojGtLbQdDE=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3365.namprd15.prod.outlook.com (20.179.58.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 15:27:00 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 15:27:00 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Xiao Han <xiao.han@orange.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: mark registers in all frames after
 pkt/null checks
Thread-Topic: [PATCH bpf v3 0/2] bpf: mark registers in all frames after
 pkt/null checks
Thread-Index: AQHU+3tTK3+Qh1XjLUSwm2v4zZEb6w==
Date:   Thu, 25 Apr 2019 15:27:00 +0000
Message-ID: <233bca7b-6412-bb07-8185-71a6f86ec003@fb.com>
References: <cover.1556127905.git.paul.chaignon@orange.com>
In-Reply-To: <cover.1556127905.git.paul.chaignon@orange.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:104:7::29) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a55d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aee27dc5-de7a-4770-8430-08d6c99275b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3365;
x-ms-traffictypediagnostic: BYAPR15MB3365:
x-microsoft-antispam-prvs: <BYAPR15MB336595ADA3478A604ABDDCAED33D0@BYAPR15MB3365.namprd15.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39860400002)(54534003)(199004)(189003)(54906003)(66946007)(6512007)(6436002)(110136005)(446003)(386003)(53546011)(6506007)(73956011)(53936002)(66476007)(66556008)(66446008)(36756003)(6486002)(64756008)(4326008)(476003)(186003)(5660300002)(2501003)(2616005)(102836004)(71200400001)(71190400001)(14454004)(7736002)(305945005)(229853002)(2201001)(97736004)(8936002)(86362001)(46003)(81156014)(81166006)(31696002)(478600001)(8676002)(31686004)(52116002)(14444005)(256004)(11346002)(68736007)(6246003)(486006)(99286004)(25786009)(6116002)(2906002)(316002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3365;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: avXyN88Z/jRQLO+9IVvNgco6YPeMj2CSpyNjdTTXKdSDxXnT6Xzk23bn8iLvxb83krnmYVP8ipvumc2eB0Ijp6wdXvTEskbD3ySiwB+W9wjw+OtB8pNS6AZ4Qsw09/qA5oaXxDtXXcdm6lHbttPULogRo3InoArZZXZkBREyOyUCmspsT8mD2fXZeWNWVyZ4zt3GOqSzsBqmY80jp7W6Sn5azUQ4agZP+5LzHUeLRyLMF+Dw4Y/Fa0iBJuiY7JkL9LUKONEC+iDGP0l/yBMqyZtNL5Dr4xSSWy0YuBG4jskIMjYckJVrW1WdOXFtwHC53a4RbE4U8+UoFtFgxExe0nFOlUuYZITkmHdLUujmb7EnYQYwXo8blTGcnpVFTDaC8jCRJxFiL6Yk6IeQqTbLeQMzscEZjOhiX9/5zu4RyEE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACCDEBEE1015A4DB3ED7B1C67993485@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aee27dc5-de7a-4770-8430-08d6c99275b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 15:27:00.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjQvMTkgMTI6NDkgUE0sIFBhdWwgQ2hhaWdub24gd3JvdGU6DQo+IEluIGNhc2Ug
b2YgYSBudWxsIGNoZWNrIG9uIGEgcG9pbnRlciBpbnNpZGUgYSBzdWJwcm9nLCB3ZSBzaG91bGQg
bWFyayBhbGwNCj4gcmVnaXN0ZXJzIHdpdGggdGhpcyBwb2ludGVyIGFzIGVpdGhlciBzYWZlIG9y
IHVua25vd24sIGluIGJvdGggdGhlIGN1cnJlbnQNCj4gYW5kIHByZXZpb3VzIGZyYW1lcy4gIEN1
cnJlbnRseSwgb25seSBzcGlsbGVkIHJlZ2lzdGVycyBhbmQgcmVnaXN0ZXJzIGluDQo+IHRoZSBj
dXJyZW50IGZyYW1lIGFyZSBtYXJrZWQuICBQYWNrZXQgYm91bmQgY2hlY2tzIGluIHN1YnByb2dz
IGhhdmUgdGhlDQo+IHNhbWUgaXNzdWUuICBUaGUgZmlyc3QgcGF0Y2ggZml4ZXMgaXQgdG8gbWFy
ayByZWdpc3RlcnMgaW4gcHJldmlvdXMgZnJhbWVzDQo+IGFzIHdlbGwuDQo+IA0KPiBBIGdvb2Qg
cmVwcm9kdWNlciBmb3IgbnVsbCBjaGVja3MgbG9va3MgYXMgZm9sbG93Og0KPiANCj4gMTogcHRy
ID0gYnBmX21hcF9sb29rdXBfZWxlbShtYXAsICZrZXkpOw0KPiAyOiByZXQgPSBzdWJwcm9nKHB0
cikgew0KPiAzOiAgIHJldHVybiBwdHIgIT0gTlVMTDsNCj4gNDogfQ0KPiA1OiBpZiAocmV0KQ0K
PiA2OiAgIHZhbHVlID0gKnB0cjsNCj4gDQo+IFdpdGggdGhlIGFib3ZlLCB0aGUgdmVyaWZpZXIg
d2lsbCBjb21wbGFpbiBvbiBsaW5lIDYgYmVjYXVzZSBpdCBzZWVzIHB0cg0KPiBhcyBtYXBfdmFs
dWVfb3JfbnVsbCBkZXNwaXRlIHRoZSBudWxsIGNoZWNrIGluIHN1YnByb2cgMS4gIFRoZSBzZWNv
bmQNCj4gcGF0Y2ggaW1wbGVtZW50cyB0aGUgYWJvdmUgYXMgYSBuZXcgdGVzdCBjYXNlLg0KPiAN
Cj4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggZml4ZXMgYW5vdGhlciByZXN1bHRpbmcgYnVnIHdoZW4g
dXNpbmcNCj4gYnBmX3NrX3JlbGVhc2UoKToNCj4gDQo+IDE6IHNrID0gYnBmX3NrX2xvb2t1cF90
Y3AoLi4uKTsNCj4gMjogc3VicHJvZyhzaykgew0KPiAzOiAgIGlmIChzaykNCj4gNDogICAgIGJw
Zl9za19yZWxlYXNlKHNrKTsNCj4gNTogfQ0KPiA2OiBpZiAoIXNrKQ0KPiA3OiAgIHJldHVybiAw
Ow0KPiA4OiByZXR1cm4gMTsNCj4gDQo+IEluIHRoZSBhYm92ZSwgbWFya19wdHJfb3JfbnVsbF9y
ZWdzIHdpbGwgd2FybiBvbiBsaW5lIDYgYmVjYXVzZSBpdCB3aWxsDQo+IHRyeSB0byBmcmVlIHRo
ZSByZWZlcmVuY2Ugc3RhdGUsIGV2ZW4gdGhvdWdoIGl0IHdhcyBhbHJlYWR5IGZyZWVkIG9uDQo+
IGxpbmUgMy4NCj4gDQo+IENoYW5nZWxvZ3M6DQo+ICAgIENoYW5nZXMgaW4gdjM6DQo+ICAgICAg
LSBGaXggc2FtZSBpc3N1ZSBpbiBmaW5kX2dvb2RfcGt0X3BvaW50ZXJzKCkuDQo+ICAgICAgLSBB
ZGQgdGVzdCBjYXNlIGZvciBmaW5kX2dvb2RfcGt0X3BvaW50ZXJzKCkgaXNzdWUuDQo+ICAgICAg
LSBDaGFuZ2UgdGl0bGUgdG8gYWNjb3VudCBmb3IgdGhlIGFib3ZlIGNoYW5nZS4gT2xkIHRpdGxl
IHdhcw0KPiAgICAgICAgImJwZjogbWFyayByZWdpc3RlcnMgYXMgc2FmZSBvciB1bmtub3duIGlu
IGFsbCBmcmFtZXMiLg0KPiAgICAgIC0gUmVmYWN0b3IgZmluZF9nb29kX3BrdF9wb2ludGVycyBh
bmQgbWFya19wdHJfb3JfbnVsbF9yZWdzLg0KPiAgICAgIC0gSSBkaWQgbm90IGtlZXAgWW9uZ2hv
bmcncyBhY2sgYmVjYXVzZSBvZiB0aGUgYWJvdmUgY2hhbmdlcy4NCj4gICAgQ2hhbmdlcyBpbiB2
MjoNCj4gICAgICAtIEZpeCBleGFtcGxlIGNvZGVzIGluIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4g
UGF1bCBDaGFpZ25vbiAoMik6DQo+ICAgIGJwZjogbWFyayByZWdpc3RlcnMgaW4gYWxsIGZyYW1l
cyBhZnRlciBwa3QvbnVsbCBjaGVja3MNCj4gICAgc2VsZnRlc3RzL2JwZjogdGVzdCBjYXNlcyBm
b3IgcGt0L251bGwgY2hlY2tzIGluIHN1YnByb2dzDQo+IA0KPiAgIGtlcm5lbC9icGYvdmVyaWZp
ZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDc2ICsrKysrKysrKysrLS0tLS0tLS0NCj4g
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdmVyaWZpZXIvY2FsbHMuYyAgfCAyNSArKysr
KysNCj4gICAuLi4vYnBmL3ZlcmlmaWVyL2RpcmVjdF9wYWNrZXRfYWNjZXNzLmMgICAgICAgfCAy
MiArKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyksIDMwIGRlbGV0
aW9ucygtKQ0KDQpBY2sgZm9yIHRoZSB3aG9sZSBzZXJpZXMuDQpBY2tlZC1ieTogWW9uZ2hvbmcg
U29uZyA8eWhzQGZiLmNvbT4NCg==

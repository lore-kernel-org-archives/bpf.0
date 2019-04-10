Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48110C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F55A2083E
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eal7lrJu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LeQd6NVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfDJRJa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:09:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42852 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728860AbfDJRJa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Apr 2019 13:09:30 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AH1ACY013584;
        Wed, 10 Apr 2019 10:08:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OPw8KHkT4B2vmehubXRE2a75+st+tLiNoxe4eXVo+So=;
 b=eal7lrJu3Z46rUCQ8egyMtNtgfW2dHH9BJd7TZjGt8YoLT1J3jEXXT3Md1oy/N/TK4dG
 rxS4qq8uvU6Y+9YyscsxWMWnpsmgxDbJMJWZOdVLWd73OjFdRlOEiTQu2gXhnQMhx65I
 Hmlh0i/04un0N1RFPK1mBzoJ7aGoxWn++us= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rsmdwr31k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 10:08:34 -0700
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 10 Apr 2019 10:08:33 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 10 Apr 2019 10:08:33 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Apr 2019 10:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPw8KHkT4B2vmehubXRE2a75+st+tLiNoxe4eXVo+So=;
 b=LeQd6NVLENmqjkz++DM/na6gn3ux8vQMdPvw0KwqDwEIU526ssqCdILZZ6AIqLulNV1MTG07mfyoZBazaBzJnMMUQZzheaqgosyUuTh6l8rjVl5zxci00MPWeLZH9G1a+fejQE2TWyfol4XOZdimi+jonkZZPItuXV/vtscQrxU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2775.namprd15.prod.outlook.com (20.179.158.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 17:08:31 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e%5]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 17:08:31 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Thread-Topic: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Thread-Index: AQHU76oCY0hWPKPN/k284b75C7IYIKY1oLWA
Date:   Wed, 10 Apr 2019 17:08:31 +0000
Message-ID: <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
In-Reply-To: <20190410143025.11997-1-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:301:39::29) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:61dc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faaef5b7-3c44-4d83-8d16-08d6bdd7286c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2775;
x-ms-traffictypediagnostic: BYAPR15MB2775:
x-microsoft-antispam-prvs: <BYAPR15MB2775296AC1169935119CD342D32E0@BYAPR15MB2775.namprd15.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(102836004)(46003)(476003)(68736007)(386003)(186003)(53546011)(6506007)(36756003)(11346002)(2616005)(7736002)(305945005)(2501003)(76176011)(106356001)(105586002)(446003)(6512007)(53936002)(6246003)(6116002)(6486002)(54906003)(2906002)(110136005)(486006)(6436002)(316002)(229853002)(31686004)(14454004)(5660300002)(52116002)(4326008)(14444005)(25786009)(31696002)(99286004)(71190400001)(71200400001)(256004)(478600001)(8676002)(81166006)(81156014)(8936002)(97736004)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2775;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HCYwA1LwEJ5IXEKuTqlRlKL1sDDWC+9dT2+NbQ8AAM0eda77YXSNgFG3+yN7bO1eEw4yWvDGEis1tP/wEKUSgY5c08Cdlxx0ypEDUBeJfZAUmJjOw0fRf7ZdAwKNsNhADTbTAzFXsm3+hQg+DVmhoRV6RyHQqjf8HrnmbEsXO7XWD+17pOVD/VFV0aDcaYCESw/0y8gSo/aY30VbYWiKpM3Emi0ITinaNxFdYkyzZcSgKm7n12DdGOmuQqy26WGLCPb2szGTQEZfEzhvCI2bwL2El5zyO2p9fKw72L3hcLGR7AmXGLgxy9ETCNtW2S/6U6iaALxKJUBIib76AHhLLpW75wrUK4t/7XPSSvAgsw1K/f7l+wSazzsthwfztXwoErEeK6jEGZn+9PV13UIjl9tpH/bsufHg/hNi3lfG4Xk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <393870A10C37A04A9B98E62C3EDE8056@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: faaef5b7-3c44-4d83-8d16-08d6bdd7286c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 17:08:31.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2775
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMTAvMTkgNzozMCBBTSwgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToN
Cj4gVGhlcmUgaXMgbm8gZGlmZmVyZW5jZSBiZXR3ZWVuIHNwaW5sb2NrX3QgYW5kIHJhd19zcGlu
bG9ja190IGZvciAhUlQNCj4ga2VybmVscy4gSXQgaXMgcG9zc2libGUgdGhhdCBicGZfbHJ1X2xp
c3RfcG9wX2ZyZWVfdG9fbG9jYWwoKSBpbnZva2VzDQo+IGF0IGxlYXN0IHRocmVlIGxpc3Qgd2Fs
a3Mgd2hpY2ggbG9vayB1bmJvdW5kZWQgaXQgcHJvYmFibHkgbWFrZXMgc2Vuc2UNCj4gdG8gdXNl
IHNwaW5sb2NrX3QuDQo+IA0KPiBNYWtlIGJwZl9scnVfbGlzdCB1c2UgYSBzcGlubG9ja190Lg0K
DQpDb3VsZCB5b3UgYWRkIGEgY292ZXIgbGV0dGVyIGZvciB0aGUgcGF0Y2ggc2V0IHNpbmNlIHlv
dSBoYXZlDQptb3JlIHRoYW4gb25lIHBhdGNoPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWJh
c3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+IC0tLQ0KPiAg
IGtlcm5lbC9icGYvYnBmX2xydV9saXN0LmMgfCAzOCArKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgIGtlcm5lbC9icGYvYnBmX2xydV9saXN0LmggfCAgNCArKy0tDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2JwZl9scnVfbGlzdC5jIGIva2VybmVsL2JwZi9i
cGZfbHJ1X2xpc3QuYw0KPiBpbmRleCBlNmVmNDQwMWExMzgwLi40MGY0NzIxMGMzODE3IDEwMDY0
NA0KPiAtLS0gYS9rZXJuZWwvYnBmL2JwZl9scnVfbGlzdC5jDQo+ICsrKyBiL2tlcm5lbC9icGYv
YnBmX2xydV9saXN0LmMNCj4gQEAgLTMxMyw5ICszMTMsOSBAQCBzdGF0aWMgdm9pZCBicGZfbHJ1
X2xpc3RfcHVzaF9mcmVlKHN0cnVjdCBicGZfbHJ1X2xpc3QgKmwsDQo+ICAgCWlmIChXQVJOX09O
X09OQ0UoSVNfTE9DQUxfTElTVF9UWVBFKG5vZGUtPnR5cGUpKSkNCj4gICAJCXJldHVybjsNCj4g
ICANCj4gLQlyYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmwtPmxvY2ssIGZsYWdzKTsNCj4gKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmbC0+bG9jaywgZmxhZ3MpOw0KPiAgIAlfX2JwZl9scnVfbm9kZV9tb3Zl
KGwsIG5vZGUsIEJQRl9MUlVfTElTVF9UX0ZSRUUpOw0KPiAtCXJhd19zcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZsLT5sb2NrLCBmbGFncyk7DQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbC0+
bG9jaywgZmxhZ3MpOw0KPiAgIH0NCg0KVGhpcyBmdW5jdGlvbiAocGx1cyBtYW55IG90aGVycykg
aXMgY2FsbGVkIGJ5IGJwZiBwcm9ncmFtIGhlbHBlcnMgd2hpY2ggDQpjYW5ub3Qgc2xlZXAuIElz
IGl0IHBvc3NpYmxlIHRoYXQgdW5kZXIgUlQgc3Bpbl9sb2NrX2lycXNhdmUoKSBjb3VsZCANCnNs
ZWVwIGFuZCB0aGlzIHdpbGwgbWFrZSBicGYgc3Vic3lzdGVtIGNhbm5vdCBiZSB1c2VkIHVuZGVy
IFJUPw0KDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgYnBmX2xydV9saXN0X3BvcF9mcmVlX3RvX2xv
Y2FsKHN0cnVjdCBicGZfbHJ1ICpscnUsDQo+IEBAIC0zMjUsNyArMzI1LDcgQEAgc3RhdGljIHZv
aWQgYnBmX2xydV9saXN0X3BvcF9mcmVlX3RvX2xvY2FsKHN0cnVjdCBicGZfbHJ1ICpscnUsDQo+
ICAgCXN0cnVjdCBicGZfbHJ1X25vZGUgKm5vZGUsICp0bXBfbm9kZTsNCj4gICAJdW5zaWduZWQg
aW50IG5mcmVlID0gMDsNCj4gICANCj4gLQlyYXdfc3Bpbl9sb2NrKCZsLT5sb2NrKTsNCj4gKwlz
cGluX2xvY2soJmwtPmxvY2spOw0KPiAgIA0KPiAgIAlfX2xvY2FsX2xpc3RfZmx1c2gobCwgbG9j
X2wpOw0KPiAgIA0KPiBAQCAtMzQ0LDcgKzM0NCw3IEBAIHN0YXRpYyB2b2lkIGJwZl9scnVfbGlz
dF9wb3BfZnJlZV90b19sb2NhbChzdHJ1Y3QgYnBmX2xydSAqbHJ1LA0KPiAgIAkJCQkgICAgICBs
b2NhbF9mcmVlX2xpc3QobG9jX2wpLA0KPiAgIAkJCQkgICAgICBCUEZfTFJVX0xPQ0FMX0xJU1Rf
VF9GUkVFKTsNCj4gICANCj4gLQlyYXdfc3Bpbl91bmxvY2soJmwtPmxvY2spOw0KPiArCXNwaW5f
dW5sb2NrKCZsLT5sb2NrKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgX19sb2NhbF9s
aXN0X2FkZF9wZW5kaW5nKHN0cnVjdCBicGZfbHJ1ICpscnUsDQpbLi4uXQ0KPiAgIHN0YXRpYyB2
b2lkIGJwZl9scnVfbGlzdF9pbml0KHN0cnVjdCBicGZfbHJ1X2xpc3QgKmwpDQo+IEBAIC02NDIs
NyArNjQyLDcgQEAgc3RhdGljIHZvaWQgYnBmX2xydV9saXN0X2luaXQoc3RydWN0IGJwZl9scnVf
bGlzdCAqbCkNCj4gICANCj4gICAJbC0+bmV4dF9pbmFjdGl2ZV9yb3RhdGlvbiA9ICZsLT5saXN0
c1tCUEZfTFJVX0xJU1RfVF9JTkFDVElWRV07DQo+ICAgDQo+IC0JcmF3X3NwaW5fbG9ja19pbml0
KCZsLT5sb2NrKTsNCj4gKwlzcGluX2xvY2tfaW5pdCgmbC0+bG9jayk7DQo+ICAgfQ0KPiAgIA0K
PiAgIGludCBicGZfbHJ1X2luaXQoc3RydWN0IGJwZl9scnUgKmxydSwgYm9vbCBwZXJjcHUsIHUz
MiBoYXNoX29mZnNldCwNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvYnBmX2xydV9saXN0Lmgg
Yi9rZXJuZWwvYnBmL2JwZl9scnVfbGlzdC5oDQo+IGluZGV4IDdkNGY4OWI3Y2I4NDEuLjRlMWU0
NjA4ZjFiYjAgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9icGYvYnBmX2xydV9saXN0LmgNCj4gKysr
IGIva2VybmVsL2JwZi9icGZfbHJ1X2xpc3QuaA0KPiBAQCAtMzYsMTMgKzM2LDEzIEBAIHN0cnVj
dCBicGZfbHJ1X2xpc3Qgew0KPiAgIAkvKiBUaGUgbmV4dCBpbmFjaXR2ZSBsaXN0IHJvdGF0aW9u
IHN0YXJ0cyBmcm9tIGhlcmUgKi8NCj4gICAJc3RydWN0IGxpc3RfaGVhZCAqbmV4dF9pbmFjdGl2
ZV9yb3RhdGlvbjsNCj4gICANCj4gLQlyYXdfc3BpbmxvY2tfdCBsb2NrIF9fX19jYWNoZWxpbmVf
YWxpZ25lZF9pbl9zbXA7DQo+ICsJc3BpbmxvY2tfdCBsb2NrIF9fX19jYWNoZWxpbmVfYWxpZ25l
ZF9pbl9zbXA7DQo+ICAgfTsNCj4gICANCj4gICBzdHJ1Y3QgYnBmX2xydV9sb2NhbGxpc3Qgew0K
PiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3RzW05SX0JQRl9MUlVfTE9DQUxfTElTVF9UXTsNCj4g
ICAJdTE2IG5leHRfc3RlYWw7DQo+IC0JcmF3X3NwaW5sb2NrX3QgbG9jazsNCj4gKwlzcGlubG9j
a190IGxvY2s7DQo+ICAgfTsNCj4gICANCj4gICBzdHJ1Y3QgYnBmX2NvbW1vbl9scnUgew0KPiAN
Cg==

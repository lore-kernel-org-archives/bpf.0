Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FBC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4624A20652
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kMHz0dPj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BnpwGdDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbfDXSMe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:12:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387726AbfDXRMt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 13:12:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OH5hY9020270;
        Wed, 24 Apr 2019 10:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jq+M887/7dUV3ClEzsIAday9XRP8tP5KN0qQeMn5aWE=;
 b=kMHz0dPjW8L4kxY5iCrxNKy7T/eBXtEuArSlYHwgm9h/0HcBbnjZHJdYdCHPRbHj9n8C
 jvXId3kbvymB8sNWU5r8uAnbMAqhmbSrv4IvOGLsBNUnBYoCfm+4Kj9JP2B+0a74BUbR
 JvnWu8HwjZ1lyjKBfFbG9hMbdEMuqKIg/NI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2k8fas0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 10:12:15 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 10:12:14 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 10:12:14 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 10:12:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq+M887/7dUV3ClEzsIAday9XRP8tP5KN0qQeMn5aWE=;
 b=BnpwGdDoYwtwOyTPRK/sbXsdq/ZvdWEbd3bIOT2KGYXZpuI11r2xVbzFLUnCzlq7hFu1g7GzO0xXCPRjCB3+MJxAUHeQ3G8/V9ARorE3Z0REvM/hG4BQivfqRBxG87Fhqy3PUQgVSpr1qwAOjXJ8P5pUiY7H654owPm6O+O3fbo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3352.namprd15.prod.outlook.com (20.179.58.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 17:12:12 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 17:12:12 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Martin Lau <kafai@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: add ability to dump BTF types
Thread-Topic: [PATCH bpf-next 1/2] bpftool: add ability to dump BTF types
Thread-Index: AQHU+l5mzy/JVefHY02PsB35pRYTrqZLjPQA
Date:   Wed, 24 Apr 2019 17:12:11 +0000
Message-ID: <94852017-ca8e-78c1-9b98-bdc6b9852e76@fb.com>
References: <20190424052200.1625142-1-andrii.nakryiko@gmail.com>
 <20190424052200.1625142-2-andrii.nakryiko@gmail.com>
In-Reply-To: <20190424052200.1625142-2-andrii.nakryiko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0038.namprd22.prod.outlook.com
 (2603:10b6:301:16::12) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab8dd6d5-5cec-4999-1597-08d6c8d7fd71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3352;
x-ms-traffictypediagnostic: BYAPR15MB3352:
x-microsoft-antispam-prvs: <BYAPR15MB335285BDB578B4013E2B61ABD33C0@BYAPR15MB3352.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(71200400001)(386003)(64756008)(66946007)(6506007)(66476007)(53546011)(66446008)(66556008)(71190400001)(54906003)(256004)(68736007)(6116002)(6436002)(110136005)(73956011)(229853002)(186003)(102836004)(25786009)(14444005)(76176011)(316002)(4326008)(31696002)(478600001)(446003)(6512007)(2201001)(36756003)(5660300002)(97736004)(86362001)(81156014)(8676002)(81166006)(46003)(31686004)(14454004)(8936002)(476003)(2616005)(2501003)(11346002)(2906002)(52116002)(99286004)(6486002)(6246003)(53936002)(7736002)(486006)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3352;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vwX9aJyJmPToAMBMnvTwwSvTocRUK8oH//+Jd7+8SwMnIxDZr0ZqDCz6s5gHNhYcSGKpiH5Etohkjrdhvb93c9mOwtHjYQTUksrgOR17kA8hkEgy7W/WM9BsUXP9lx0MgIzxgF+YH7CTddgB7CutKGDwUTUypE9MwrMQpVbgiy0FTKStZ/bLkz5pRP91VLXOY/cnpH8mfdKaOi3LybcGYZNSXx55+r8qAlE2f3pMR0W/JciHnzCfk4D43iMXwxZen+BSw8i3Jn+nRQMIcEKBJj1iXC4IaHK21YEs7Fvw8vQsLCO1NGo+8Wf3+PCee1a4lnHe2vaZ0XHgXQc5ZGLgerIAhBBo7tJeutVufA+z85Fm1uXii0n3luA85UmCyiEmsUfhrxItfxg9B+Ug1HuieaFLOn9wNbIb46aSmbetNVc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B934F7164471B44691F1C2A8941212B2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8dd6d5-5cec-4999-1597-08d6c8d7fd71
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 17:12:11.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3352
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjMvMTkgMTA6MjEgUE0sIGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20gd3JvdGU6
DQo+IEZyb206IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQo+IA0KPiBBZGQgbmV3
IGBidGYgZHVtcGAgc3ViLWNvbW1hbmQgdG8gYnBmdG9vbC4gSXQgYWxsb3dzIHRvIGR1bXANCj4g
aHVtYW4tcmVhZGFibGUgbG93LWxldmVsIEJURiB0eXBlcyByZXByZXNlbnRhdGlvbiBvZiBCVEYg
dHlwZXMuIEJURiBjYW4NCj4gYmUgcmV0cmlldmVkIGZyb20gZmV3IGRpZmZlcmVudCBzb3VyY2Vz
Og0KPiAgICAtIGZyb20gQlRGIG9iamVjdCBieSBJRDsNCj4gICAgLSBmcm9tIFBST0csIGlmIGl0
IGhhcyBhc3NvY2lhdGVkIEJURjsNCj4gICAgLSBmcm9tIE1BUCwgaWYgaXQgaGFzIGFzc29jaWF0
ZWQgQlRGIGRhdGE7IGl0J3MgcG9zc2libGUgdG8gbmFycm93DQo+ICAgICAgZG93biB0eXBlcyB0
byBlaXRoZXIga2V5IHR5cGUsIHZhbHVlIHR5cGUsIGJvdGgsIG9yIGFsbCBCVEYgdHlwZXM7DQo+
ICAgIC0gZnJvbSBFTEYgZmlsZSAoLkJURiBzZWN0aW9uKS4NClRoaXMgaXMgZ3JlYXQuIFRoYW5r
cyENCj4gDQo+IE91dHB1dCBmb3JtYXQgbW9zdGx5IGZvbGxvd3MgQlBGIHZlcmlmaWVyIGxvZyBm
b3JtYXQgd2l0aCBmZXcgbm90YWJsZQ0KPiBleGNlcHRpb25zOg0KPiAgICAtIGFsbCB0aGUgdHlw
ZS9maWVsZC9wYXJhbS9ldGMgbmFtZXMgYXJlIGVuY2xvc2VkIGluIHNpbmdsZSBxdW90ZXMgdG8N
Cj4gICAgICBhbGxvdyBlYXNpZXIgZ3JlcHBpbmcgYW5kIHRvIHN0YW5kIG91dCBhIGxpdHRsZSBi
aXQgbW9yZTsNCj4gICAgLSBGVU5DX1BST1RPIG91dHB1dCBmb2xsb3dzIFNUUlVDVC9VTklPTi9F
TlVNIGZvcm1hdCBvZiBoYXZpbmcgb25lDQo+ICAgICAgbGluZSBwZXIgZWFjaCBhcmd1bWVudDsg
dGhpcyBpcyBtb3JlIHVuaWZvcm0gYW5kIGFsbG93cyBlYXN5DQo+ICAgICAgZ3JlcHBpbmcsIGFz
IG9wcG9zZWQgdG8gc3VjY2luY3QsIGJ1dCBpbmNvbnZlbmllbnQgZm9ybWF0IHRoYXQgQlBGDQo+
ICAgICAgdmVyaWZpZXIgbG9nIGlzIHVzaW5nLg0KPiANCj4gQ2M6IERhbmllbCBCb3JrbWFubiA8
ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQo+IENjOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBmYi5j
b20+DQo+IENjOiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KPiBDYzogTWFydGluIEthRmFp
IExhdSA8a2FmYWlAZmIuY29tPg0KPiBDYzogU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNv
bT4NCj4gQ2M6IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUByZWRoYXQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaW5AZmIuY29tPg0KPiAtLS0NCj4g
ICB0b29scy9icGYvYnBmdG9vbC9idGYuYyAgfCA1NzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgdG9vbHMvYnBmL2JwZnRvb2wvbWFpbi5jIHwgICAxICsNCj4g
ICB0b29scy9icGYvYnBmdG9vbC9tYWluLmggfCAgIDEgKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwg
NTc4IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvYnBmL2JwZnRv
b2wvYnRmLmMNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9icGYvYnBmdG9vbC9idGYuYyBiL3Rv
b2xzL2JwZi9icGZ0b29sL2J0Zi5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwMC4uYWZlNWNiN2JhYjBjDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdG9vbHMv
YnBmL2JwZnRvb2wvYnRmLmMNCj4gQEAgLTAsMCArMSw1NzYgQEANCj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKy8qIENvcHly
aWdodCAoQykgMjAxOSBGYWNlYm9vayAqLw0KPiArDQo+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4g
KyNpbmNsdWRlIDxmY250bC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiArI2luY2x1
ZGUgPHN0ZGJvb2wuaD4NCj4gKyNpbmNsdWRlIDxzdGRpby5oPg0KPiArI2luY2x1ZGUgPHN0cmlu
Zy5oPg0KPiArI2luY2x1ZGUgPHVuaXN0ZC5oPg0KPiArI2luY2x1ZGUgPGdlbGYuaD4NCj4gKyNp
bmNsdWRlIDxicGYuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9idGYuaD4NCj4gKw0KWy4uLi4uXQ0K
PiArDQo+ICtzdGF0aWMgaW50IGRvX2R1bXAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiArew0K
PiArCXN0cnVjdCBidGYgKmJ0ZiA9IE5VTEw7DQo+ICsJX191MzIgcm9vdF90eXBlX2lkc1syXTsN
Cj4gKwlpbnQgcm9vdF90eXBlX2NudCA9IDA7DQo+ICsJX191MzIgYnRmX2lkID0gLTE7DQo+ICsJ
Y29uc3QgY2hhciAqc3JjOw0KPiArCWludCBmZCA9IC0xOw0KPiArCWludCBlcnI7DQo+ICsNCj4g
KwlpZiAoIVJFUV9BUkdTKDIpKSB7DQo+ICsJCXVzYWdlKCk7DQo+ICsJCXJldHVybiAtMTsNCj4g
Kwl9DQo+ICsJc3JjID0gR0VUX0FSRygpOw0KPiArDQo+ICsJaWYgKGlzX3ByZWZpeChzcmMsICJt
YXAiKSkgew0KPiArCQlzdHJ1Y3QgYnBmX21hcF9pbmZvIGluZm8gPSB7fTsNCj4gKwkJX191MzIg
bGVuID0gc2l6ZW9mKGluZm8pOw0KPiArDQo+ICsJCWlmICghUkVRX0FSR1MoMikpIHsNCj4gKwkJ
CXVzYWdlKCk7DQo+ICsJCQlyZXR1cm4gLTE7DQo+ICsJCX0NCj4gKw0KPiArCQlmZCA9IG1hcF9w
YXJzZV9mZF9hbmRfaW5mbygmYXJnYywgJmFyZ3YsICZpbmZvLCAmbGVuKTsNCj4gKwkJaWYgKGZk
IDwgMCkNCj4gKwkJCXJldHVybiAtMTsNCj4gKw0KPiArCQlidGZfaWQgPSBpbmZvLmJ0Zl9pZDsN
Cj4gKwkJaWYgKGFyZ2MgJiYgaXNfcHJlZml4KCphcmd2LCAia2V5IikpIHsNCj4gKwkJCXJvb3Rf
dHlwZV9pZHNbcm9vdF90eXBlX2NudCsrXSA9IGluZm8uYnRmX2tleV90eXBlX2lkOw0KPiArCQkJ
TkVYVF9BUkcoKTsNCj4gKwkJfSBlbHNlIGlmIChhcmdjICYmIGlzX3ByZWZpeCgqYXJndiwgInZh
bHVlIikpIHsNCj4gKwkJCXJvb3RfdHlwZV9pZHNbcm9vdF90eXBlX2NudCsrXSA9IGluZm8uYnRm
X3ZhbHVlX3R5cGVfaWQ7DQo+ICsJCQlORVhUX0FSRygpOw0KPiArCQl9IGVsc2UgaWYgKGFyZ2Mg
JiYgaXNfcHJlZml4KCphcmd2LCAiYWxsIikpIHsNCj4gKwkJCU5FWFRfQVJHKCk7DQo+ICsJCX0g
ZWxzZSBpZiAoYXJnYyAmJiBpc19wcmVmaXgoKmFyZ3YsICJrdiIpKSB7DQo+ICsJCQlyb290X3R5
cGVfaWRzW3Jvb3RfdHlwZV9jbnQrK10gPSBpbmZvLmJ0Zl9rZXlfdHlwZV9pZDsNCj4gKwkJCXJv
b3RfdHlwZV9pZHNbcm9vdF90eXBlX2NudCsrXSA9IGluZm8uYnRmX3ZhbHVlX3R5cGVfaWQ7DQo+
ICsJCQlORVhUX0FSRygpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJcm9vdF90eXBlX2lkc1tyb290
X3R5cGVfY250KytdID0gaW5mby5idGZfa2V5X3R5cGVfaWQ7DQo+ICsJCQlyb290X3R5cGVfaWRz
W3Jvb3RfdHlwZV9jbnQrK10gPSBpbmZvLmJ0Zl92YWx1ZV90eXBlX2lkOw0KPiArCQl9DQo+ICsJ
fSBlbHNlIGlmIChpc19wcmVmaXgoc3JjLCAicHJvZyIpKSB7DQo+ICsJCXN0cnVjdCBicGZfcHJv
Z19pbmZvIGluZm8gPSB7fTsNCj4gKwkJX191MzIgbGVuID0gc2l6ZW9mKGluZm8pOw0KPiArDQo+
ICsJCWlmICghUkVRX0FSR1MoMikpIHsNCj4gKwkJCXVzYWdlKCk7DQo+ICsJCQlyZXR1cm4gLTE7
DQo+ICsJCX0NCj4gKw0KPiArCQlmZCA9IHByb2dfcGFyc2VfZmQoJmFyZ2MsICZhcmd2KTsNCj4g
KwkJaWYgKGZkIDwgMCkNCj4gKwkJCXJldHVybiAtMTsNCj4gKw0KPiArCQllcnIgPSBicGZfb2Jq
X2dldF9pbmZvX2J5X2ZkKGZkLCAmaW5mbywgJmxlbik7DQo+ICsJCWlmIChlcnIpIHsNCj4gKwkJ
CXBfZXJyKCJjYW4ndCBnZXQgcHJvZyBpbmZvOiAlcyIsIHN0cmVycm9yKGVycm5vKSk7DQo+ICsJ
CQlnb3RvIGRvbmU7DQo+ICsJCX0NCj4gKw0KPiArCQlidGZfaWQgPSBpbmZvLmJ0Zl9pZDsNCj4g
Kwl9IGVsc2UgaWYgKGlzX3ByZWZpeChzcmMsICJpZCIpKSB7DQo+ICsJCWNoYXIgKmVuZHB0cjsN
Cj4gKw0KPiArCQlidGZfaWQgPSBzdHJ0b3VsKCphcmd2LCAmZW5kcHRyLCAwKTsNCj4gKwkJaWYg
KCplbmRwdHIpIHsNCj4gKwkJCXBfZXJyKCJjYW4ndCBwYXJzZSAlcyBhcyBJRCIsICoqYXJndik7
DQo+ICsJCQlyZXR1cm4gLTE7DQo+ICsJCX0NCj4gKwkJTkVYVF9BUkcoKTsNCj4gKwl9IGVsc2Ug
aWYgKGlzX3ByZWZpeChzcmMsICJmaWxlIikpIHsNCj4gKwkJZXJyID0gYnRmX2xvYWRfZnJvbV9l
bGYoKmFyZ3YsICZidGYpOw0KPiArCQlpZiAoZXJyKQ0KPiArCQkJZ290byBkb25lOw0KPiArCQlO
RVhUX0FSRygpOw0KPiArCX0NCg0KQW5vdGhlciAiZWxzZSIgYnJhbmNoIGhlcmUgdG8gaGFuZGxl
IHdyb25nIHByZWZpeD8gT3RoZXJ3aXNlLCBpdCB3aWxsIA0KZmFsbCBkb3duIHRvICJjYW4ndCBm
aW5kIGJ0ZiB3aXRoIElEICg0Mjk0OTY3Mjk1KSIgd2hlcmUgIjQyOTQ5NjcyOTUgPT0gDQotMSkg
d2hpY2ggaXMgYSBsaXR0bGUgbWlzbGVhZGluZyBmb3IgdXNlcnMuDQoNCj4gKw0KPiArCWlmICgh
YnRmKSB7DQo+ICsJCWVyciA9IGJ0Zl9fZ2V0X2Zyb21faWQoYnRmX2lkLCAmYnRmKTsNCj4gKwkJ
aWYgKGVycikgew0KPiArCQkJcF9lcnIoImdldCBidGYgYnkgaWQgKCV1KTogJXMiLCBidGZfaWQs
IHN0cmVycm9yKGVycikpOw0KPiArCQkJZ290byBkb25lOw0KPiArCQl9DQo+ICsJCWlmICghYnRm
KSB7DQo+ICsJCQllcnIgPSBFTk9FTlQ7DQo+ICsJCQlwX2VycigiY2FuJ3QgZmluZCBidGYgd2l0
aCBJRCAoJXUpIiwgYnRmX2lkKTsNCj4gKwkJCWdvdG8gZG9uZTsNCj4gKwkJfQ0KPiArCX0NCj4g
Kw0KPiArCWR1bXBfYnRmX3JhdyhidGYsIHJvb3RfdHlwZV9pZHMsIHJvb3RfdHlwZV9jbnQpOw0K
PiArDQo+ICtkb25lOg0KPiArCWNsb3NlKGZkKTsNCj4gKwlidGZfX2ZyZWUoYnRmKTsNCj4gKwly
ZXR1cm4gZXJyOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGRvX2hlbHAoaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQ0KPiArew0KPiArCWlmIChqc29uX291dHB1dCkgew0KPiArCQlqc29ud19udWxs
KGpzb25fd3RyKTsNCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KPiArDQo+ICsJZnByaW50ZihzdGRl
cnIsDQo+ICsJCSJVc2FnZTogJXMgYnRmIGR1bXAgICAgICAgQlRGX1NSQ1xuIg0KPiArCQkiICAg
ICAgICVzIGJ0ZiBoZWxwXG4iDQo+ICsJCSJcbiINCj4gKwkJIiAgICAgICBCVEZfU1JDIDo9IHsg
aWQgQlRGX0lEIHwgcHJvZyBQUk9HIHwgbWFwIE1BUCBbe2tleSB8IHZhbHVlIHwga3YgfCBhbGx9
XSB8IGVsZiBGSUxFIH1cbiINCg0KImVsZiBGSUxFIiBpcyBub3QgY29uc2lzdGVudCB3aXRoIGlt
cGxlbWVudGF0aW9uLiBUaGUgaW1wbGVtZW50YXRpb24gDQp1c2VzICJmaWxlIEZJTEUiLiBJIHBy
ZWZlciB0byB1c2UgImZpbGUgRklMRSIuDQoNCj4gKwkJIiAgICAgICAiIEhFTFBfU1BFQ19NQVAg
IlxuIg0KPiArCQkiICAgICAgICIgSEVMUF9TUEVDX1BST0dSQU0gIlxuIg0KPiArCQkiICAgICAg
ICIgSEVMUF9TUEVDX09QVElPTlMgIlxuIg0KPiArCQkiIiwNCj4gKwkJYmluX25hbWUsIGJpbl9u
YW1lKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGNtZCBjbWRzW10gPSB7DQo+ICsJeyAiaGVscCIsCWRvX2hlbHAgfSwNCj4gKwl7ICJkdW1w
IiwJZG9fZHVtcCB9LA0KPiArCXsgMCB9DQo+ICt9Ow0KPiArDQo+ICtpbnQgZG9fYnRmKGludCBh
cmdjLCBjaGFyICoqYXJndikNCj4gK3sNCj4gKwlyZXR1cm4gY21kX3NlbGVjdChjbWRzLCBhcmdj
LCBhcmd2LCBkb19oZWxwKTsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29s
L21haW4uYyBiL3Rvb2xzL2JwZi9icGZ0b29sL21haW4uYw0KPiBpbmRleCBhOWQ1ZTllNmE3MzIu
LmViYTU2ZWRkN2M3NyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvbWFpbi5jDQo+
ICsrKyBiL3Rvb2xzL2JwZi9icGZ0b29sL21haW4uYw0KPiBAQCAtMTg4LDYgKzE4OCw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgY21kIGNtZHNbXSA9IHsNCj4gICAJeyAicGVyZiIsCWRvX3BlcmYg
fSwNCj4gICAJeyAibmV0IiwJZG9fbmV0IH0sDQo+ICAgCXsgImZlYXR1cmUiLAlkb19mZWF0dXJl
IH0sDQo+ICsJeyAiYnRmIiwJZG9fYnRmIH0sDQo+ICAgCXsgInZlcnNpb24iLAlkb192ZXJzaW9u
IH0sDQo+ICAgCXsgMCB9DQo+ICAgfTsNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29s
L21haW4uaCBiL3Rvb2xzL2JwZi9icGZ0b29sL21haW4uaA0KPiBpbmRleCAxY2NjNDYxNjlhMTku
LjNkNjNmZWI3Zjg1MiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvbWFpbi5oDQo+
ICsrKyBiL3Rvb2xzL2JwZi9icGZ0b29sL21haW4uaA0KPiBAQCAtMTUwLDYgKzE1MCw3IEBAIGlu
dCBkb19wZXJmKGludCBhcmdjLCBjaGFyICoqYXJnKTsNCj4gICBpbnQgZG9fbmV0KGludCBhcmdj
LCBjaGFyICoqYXJnKTsNCj4gICBpbnQgZG9fdHJhY2Vsb2coaW50IGFyZ2MsIGNoYXIgKiphcmcp
Ow0KPiAgIGludCBkb19mZWF0dXJlKGludCBhcmdjLCBjaGFyICoqYXJndik7DQo+ICtpbnQgZG9f
YnRmKGludCBhcmdjLCBjaGFyICoqYXJndik7DQo+ICAgDQo+ICAgaW50IHBhcnNlX3UzMl9hcmco
aW50ICphcmdjLCBjaGFyICoqKmFyZ3YsIF9fdTMyICp2YWwsIGNvbnN0IGNoYXIgKndoYXQpOw0K
PiAgIGludCBwcm9nX3BhcnNlX2ZkKGludCAqYXJnYywgY2hhciAqKiphcmd2KTsNCj4gDQo=

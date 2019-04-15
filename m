Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3469C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E5320848
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="UukLxydS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfDOJzB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:55:01 -0400
Received: from mail-eopbgr30130.outbound.protection.outlook.com ([40.107.3.130]:38371
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbfDOJzA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 05:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spy43QYkA+1YZGu8Y0VwVR0+UH/47EJhr3bnjca8AWs=;
 b=UukLxydSc9Mpsp1f8JOJ+ewFI2VBKDh2XzqlSEWiTwpWgvHr1leO3lGnu0+vvtEXl4ckQk8ZYAPIdYajCFRw0R8w5Uk4gYgZ+3X4sPTTFfQSirZf0REIxOc6fUZESLK5UW2FKtvr2PXCb71hONko/ogOSOsub+BiQI2rVd3iTi8=
Received: from AM6PR03MB4086.eurprd03.prod.outlook.com (20.177.38.149) by
 AM6PR03MB5377.eurprd03.prod.outlook.com (10.255.98.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Mon, 15 Apr 2019 09:54:55 +0000
Received: from AM6PR03MB4086.eurprd03.prod.outlook.com
 ([fe80::f063:d4dd:9c1f:8fe5]) by AM6PR03MB4086.eurprd03.prod.outlook.com
 ([fe80::f063:d4dd:9c1f:8fe5%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 09:54:55 +0000
From:   Viet Hoang Tran <hoang.tran@uclouvain.be>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Lawrence Brakmo <brakmo@fb.com>, Martin Lau <kafai@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "tranviethoang.vn@gmail.com" <tranviethoang.vn@gmail.com>,
        Viet Hoang Tran <hoang.tran@uclouvain.be>
Subject: [PATCH bpf] bpf: allow clearing all sock_ops callback flags
Thread-Topic: [PATCH bpf] bpf: allow clearing all sock_ops callback flags
Thread-Index: AQHU83FHYT2ycenC0U6Jc5FzR6ziAw==
Date:   Mon, 15 Apr 2019 09:54:55 +0000
Message-ID: <20190415131042.1111-1-hoang.tran@uclouvain.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0285.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::33) To AM6PR03MB4086.eurprd03.prod.outlook.com
 (2603:10a6:20b:1a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoang.tran@uclouvain.be; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [130.104.36.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e20ac60f-1a4d-4b04-df6d-08d6c188692c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR03MB5377;
x-ms-traffictypediagnostic: AM6PR03MB5377:
x-microsoft-antispam-prvs: <AM6PR03MB53777D3123D251661D7214F7EB2B0@AM6PR03MB5377.eurprd03.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(105586002)(316002)(106356001)(2501003)(7736002)(256004)(2351001)(386003)(36756003)(71190400001)(71200400001)(6486002)(8676002)(478600001)(6506007)(52116002)(1076003)(50226002)(99286004)(102836004)(5660300002)(6436002)(86362001)(54906003)(1730700003)(305945005)(81156014)(81166006)(8936002)(6916009)(26005)(2616005)(107886003)(5640700003)(97736004)(476003)(2906002)(25786009)(6512007)(786003)(6116002)(3846002)(4326008)(14454004)(68736007)(66066001)(53936002)(486006)(74482002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR03MB5377;H:AM6PR03MB4086.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uclouvain.be does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zPT7WLrQwsDlUf3bjpNq/7i5B5W//+aOyKVL+TEJjOFHfa2XN+SxOxmn/kHkqMQY0QSxa90a4oLdjtihWx3Yclp+rbQAABA3WbzSIgGWcTurLXa4XKSK6xp6E05K1uJ0gxYBzKp+rEjMijgTUaT5LHK2xzKAiFgbqbPCqvq2Ij6fR7fMwSWbHqOtxfwZJODkfhGcH6v1dw2/jB37oO4qQ5uW/9DtpLgulKqQErNAwlXAt6BZ0uDvqioLVykecXgDTcOoJ6u9NkE6DQK/SDJJVX2jFx4kIvGWKu4YlueTfdU3bll/+RuwIkbCTsWTolCX8cdEeCIJFFscP+Rca587GjhX53AQlQ6VFmuN9ibXX07Z+GEC4U4iJ2usMyG5M3hrl0Js44gmuC/4WfpakhO/GidPuDR+4lzd0ucJBvahu2o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: e20ac60f-1a4d-4b04-df6d-08d6c188692c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 09:54:55.3971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5377
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhlIGhlbHBlciBmdW5jdGlvbiBicGZfc29ja19vcHNfY2JfZmxhZ3Nfc2V0KCkgY2FuIGJlIHVz
ZWQgdG8gYm90aA0Kc2V0IGFuZCBjbGVhciB0aGUgc29ja19vcHMgY2FsbGJhY2sgZmxhZ3MuIEhv
d2V2ZXIsIGl0cyBjdXJyZW50DQpiZWhhdmlvciBpcyBub3QgY29uc2lzdGVudC4gQlBGIHByb2dy
YW0gbWF5IGNsZWFyIGEgZmxhZyBpZiBtb3JlIHRoYW4NCm9uZSB3ZXJlIHNldCwgb3IgcmVwbGFj
ZSBhIGZsYWcgd2l0aCBhbm90aGVyIG9uZSwgYnV0IGNhbm5vdCBjbGVhciBhbGwNCmZsYWdzLg0K
DQpUaGlzIHBhdGNoIGFsc28gdXBkYXRlcyB0aGUgZG9jdW1lbnRhdGlvbiB0byBjbGFyaWZ5IHRo
ZSBhYmlsaXR5IHRvDQpjbGVhciBmbGFncyBvZiB0aGlzIGhlbHBlciBmdW5jdGlvbi4NCg0KU2ln
bmVkLW9mZi1ieTogSG9hbmcgVHJhbiA8aG9hbmcudHJhbkB1Y2xvdXZhaW4uYmU+DQotLS0NCiBp
bmNsdWRlL3VhcGkvbGludXgvYnBmLmggfCA5ICsrKysrKysrLQ0KIG5ldC9jb3JlL2ZpbHRlci5j
ICAgICAgICB8IDMgKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNs
dWRlL3VhcGkvbGludXgvYnBmLmgNCmluZGV4IDkyOWM4ZTUzN2ExNC4uZjllZTA5M2ZlOGQzIDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oDQorKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmgNCkBAIC0xNjk0LDEyICsxNjk0LDE5IEBAIHVuaW9uIGJwZl9hdHRyIHsNCiAg
KiAJCWVycm9yIGlmIGFuIGVCUEYgcHJvZ3JhbSB0cmllcyB0byBzZXQgYSBjYWxsYmFjayB0aGF0
IGlzIG5vdA0KICAqIAkJc3VwcG9ydGVkIGluIHRoZSBjdXJyZW50IGtlcm5lbC4NCiAgKg0KLSAq
IAkJVGhlIHN1cHBvcnRlZCBjYWxsYmFjayB2YWx1ZXMgdGhhdCAqYXJndmFsKiBjYW4gY29tYmlu
ZSBhcmU6DQorICogCQkqYXJndmFsKiBpcyBhIGZsYWcgYXJyYXkgd2hpY2ggY2FuIGNvbWJpbmUg
dGhlc2UgZmxhZ3M6DQogICoNCiAgKiAJCSogKipCUEZfU09DS19PUFNfUlRPX0NCX0ZMQUcqKiAo
cmV0cmFuc21pc3Npb24gdGltZSBvdXQpDQogICogCQkqICoqQlBGX1NPQ0tfT1BTX1JFVFJBTlNf
Q0JfRkxBRyoqIChyZXRyYW5zbWlzc2lvbikNCiAgKiAJCSogKipCUEZfU09DS19PUFNfU1RBVEVf
Q0JfRkxBRyoqIChUQ1Agc3RhdGUgY2hhbmdlKQ0KICAqDQorICogCQlUaGVyZWZvcmUsIHRoaXMg
ZnVuY3Rpb24gY2FuIGJlIHVzZWQgdG8gY2xlYXIgYSBjYWxsYmFjayBmbGFnIGJ5DQorICogCQlz
ZXR0aW5nIHRoZSBhcHByb3ByaWF0ZSBiaXQgdG8gemVyby4gZS5nLiB0byBkaXNhYmxlIHRoZSBS
VE8NCisgKiAJCWNhbGxiYWNrOg0KKyAqDQorICogCQkqKmJwZl9zb2NrX29wc19jYl9mbGFnc19z
ZXQoYnBmX3NvY2ssKioNCisgKiAJCQkqKmJwZl9zb2NrLT5icGZfc29ja19vcHNfY2JfZmxhZ3Mg
JiB+QlBGX1NPQ0tfT1BTX1JUT19DQl9GTEFHKSoqDQorICoNCiAgKiAJCUhlcmUgYXJlIHNvbWUg
ZXhhbXBsZXMgb2Ygd2hlcmUgb25lIGNvdWxkIGNhbGwgc3VjaCBlQlBGDQogICogCQlwcm9ncmFt
Og0KICAqDQpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZmlsdGVyLmMgYi9uZXQvY29yZS9maWx0ZXIu
Yw0KaW5kZXggZmM5MmViYzRlMjAwLi4wYzRjZGZiYjJmYzcgMTAwNjQ0DQotLS0gYS9uZXQvY29y
ZS9maWx0ZXIuYw0KKysrIGIvbmV0L2NvcmUvZmlsdGVyLmMNCkBAIC00MzU1LDggKzQzNTUsNyBA
QCBCUEZfQ0FMTF8yKGJwZl9zb2NrX29wc19jYl9mbGFnc19zZXQsIHN0cnVjdCBicGZfc29ja19v
cHNfa2VybiAqLCBicGZfc29jaywNCiAJaWYgKCFJU19FTkFCTEVEKENPTkZJR19JTkVUKSB8fCAh
c2tfZnVsbHNvY2soc2spKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQotCWlmICh2YWwpDQotCQl0
Y3Bfc2soc2spLT5icGZfc29ja19vcHNfY2JfZmxhZ3MgPSB2YWw7DQorCXRjcF9zayhzayktPmJw
Zl9zb2NrX29wc19jYl9mbGFncyA9IHZhbDsNCiANCiAJcmV0dXJuIGFyZ3ZhbCAmICh+QlBGX1NP
Q0tfT1BTX0FMTF9DQl9GTEFHUyk7DQogfQ0KLS0gDQoyLjE3LjENCg0K

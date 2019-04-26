Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7BC43218
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2118208CA
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RlHCC5HO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hTsLeTfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfDZRux (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:50:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58466 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbfDZRux (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 13:50:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QHjnU5009732;
        Fri, 26 Apr 2019 10:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=z/HbZOVx5RLrg30QSf/lu7p/8pKTAxFVmedu8Q6EWqU=;
 b=RlHCC5HOgNDCJizymYO51fapLnQFZACbWAS7Idm/6LaBFPwnZRyU2osQhwoJzTWQQW9b
 nkYJE4wNn1swE48XkeOP9xf+LUKn1SxcIq9kHug2nKs8ErdcVBAZVMGtcScQHEbkJx/I
 ZU0SR10Qj8ODvA7xsS4yaNpx6Unk6dj2eqc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3yc5hetg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 10:50:32 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Apr 2019 10:50:31 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Apr 2019 10:50:31 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 10:50:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/HbZOVx5RLrg30QSf/lu7p/8pKTAxFVmedu8Q6EWqU=;
 b=hTsLeTfC7JQr1uZ4NJyj6SKP7if7/mo5PtrDOwMJ/7UN9dS4UQFc29wbKATkrFJSOL2otjoi9od6ttLD3FsK5LHZaQDSL4keQ6CMLj7pY8ZM3i9wsFE0vaFyh0w0efFZt8KpVDiZC+63MKqjtaxFkTuBp1IlAGZRnVWqk4KEyKY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2887.namprd15.prod.outlook.com (20.178.206.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 17:50:29 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 17:50:29 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in
 bpf map probing
Thread-Topic: [PATCH v3 bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in
 bpf map probing
Thread-Index: AQHU/FMXRizVb8uBukumtVYKswm2FaZOuGeA
Date:   Fri, 26 Apr 2019 17:50:29 +0000
Message-ID: <c81269b9-a422-0407-e6c4-830e86310852@fb.com>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171107.62279-1-kafai@fb.com>
In-Reply-To: <20190426171107.62279-1-kafai@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:9790]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1931bbcf-60d8-447c-3f4d-08d6ca6fab9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2887;
x-ms-traffictypediagnostic: BYAPR15MB2887:
x-microsoft-antispam-prvs: <BYAPR15MB28872C5A3E872553E5C1CFC9D33E0@BYAPR15MB2887.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(53936002)(186003)(97736004)(71200400001)(81166006)(66446008)(2616005)(6436002)(446003)(6116002)(66946007)(31686004)(11346002)(6246003)(66476007)(71190400001)(66556008)(25786009)(8936002)(7736002)(486006)(68736007)(8676002)(73956011)(14444005)(81156014)(64756008)(305945005)(36756003)(476003)(52116002)(76176011)(2501003)(4326008)(229853002)(86362001)(2201001)(478600001)(6512007)(6486002)(102836004)(5660300002)(31696002)(54906003)(14454004)(386003)(2906002)(256004)(99286004)(316002)(110136005)(53546011)(46003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2887;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eVktPwCeOiuDL2mYwP9mrJTW8RzcJgMhGQ/txIB+uqmrFxv4bxNh2C2ZT8RyAeeI1HrvsMHYDqGZ2M/HUkQmIPgMVfxf31ME1kvOaKfwkdky3P9ilC3f+duyPfuH9jYN24xIv4fV4fSC2inshq8tVhkEk+v5a/LlAwm+qor2OX4s0uuJLywTM0xdCTgjGj7JA5hUqDmWMNcnnDoVjlFjBGK6c9iIosWbXVYX3I8yzjmZsFMVNJfcl8lJPPOVb7f6FzKiRWiSzR75xcXGprBV5dd01HRQuiMZoxgr7QnGpDA3Qvo6lin3LWFTEhXxmZ+NU+qqTCXSYX1cR5qSDe9hNiM+5guNBiUdG9IDkIWtvc3I+4Ze9B075pKuqd80TR/WYjfa7XOEn4ShCJL7Dq2s9/2MEk+cY8xFU9TSO7hSRa0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA4AE9AFE04CCC48B83DC505E42AB45A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1931bbcf-60d8-447c-3f4d-08d6ca6fab9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 17:50:29.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjYvMTkgMTA6MTEgQU0sIE1hcnRpbiBLYUZhaSBMYXUgd3JvdGU6DQo+IFRoaXMg
cGF0Y2ggc3VwcG9ydHMgcHJvYmluZyBmb3IgdGhlIG5ldyBCUEZfTUFQX1RZUEVfU0tfU1RPUkFH
RS4NCj4gQlBGX01BUF9UWVBFX1NLX1NUT1JBR0UgZW5mb3JjZXMgQlRGIHVzYWdlLCBzbyB0aGUg
bmV3IHByb2JlDQo+IHJlcXVpcmVzIHRvIGNyZWF0ZSBhbmQgbG9hZCBhIEJURiBhbHNvLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEthRmFpIExhdSA8a2FmYWlAZmIuY29tPg0KPiAtLS0N
Cj4gICB0b29scy9icGYvYnBmdG9vbC9tYXAuYyAgICAgICB8ICAxICsNCj4gICB0b29scy9saWIv
YnBmL2xpYmJwZl9wcm9iZXMuYyB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYnBmL2JwZnRvb2wvbWFwLmMgYi90b29scy9icGYv
YnBmdG9vbC9tYXAuYw0KPiBpbmRleCAxMGI2YzlkM2U1MjUuLjY5M2FiM2RhMzdkZSAxMDA2NDQN
Cj4gLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvbWFwLmMNCj4gKysrIGIvdG9vbHMvYnBmL2JwZnRv
b2wvbWFwLmMNCj4gQEAgLTQ2LDYgKzQ2LDcgQEAgY29uc3QgY2hhciAqIGNvbnN0IG1hcF90eXBl
X25hbWVbXSA9IHsNCj4gICAJW0JQRl9NQVBfVFlQRV9QRVJDUFVfQ0dST1VQX1NUT1JBR0VdCT0g
InBlcmNwdV9jZ3JvdXBfc3RvcmFnZSIsDQo+ICAgCVtCUEZfTUFQX1RZUEVfUVVFVUVdCQkJPSAi
cXVldWUiLA0KPiAgIAlbQlBGX01BUF9UWVBFX1NUQUNLXQkJCT0gInN0YWNrIiwNCj4gKwlbQlBG
X01BUF9UWVBFX1NLX1NUT1JBR0VdCQk9ICJza19zdG9yYWdlIiwNCj4gICB9Ow0KPiAgIA0KPiAg
IGNvbnN0IHNpemVfdCBtYXBfdHlwZV9uYW1lX3NpemUgPSBBUlJBWV9TSVpFKG1hcF90eXBlX25h
bWUpOw0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9saWJicGZfcHJvYmVzLmMgYi90b29s
cy9saWIvYnBmL2xpYmJwZl9wcm9iZXMuYw0KPiBpbmRleCAwZjI1NTQxNjMyZTMuLjJlMjZkZGIw
MDVlNCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGZfcHJvYmVzLmMNCj4gKysr
IGIvdG9vbHMvbGliL2JwZi9saWJicGZfcHJvYmVzLmMNCj4gQEAgLTksNiArOSw3IEBADQo+ICAg
I2luY2x1ZGUgPG5ldC9pZi5oPg0KPiAgICNpbmNsdWRlIDxzeXMvdXRzbmFtZS5oPg0KPiAgIA0K
PiArI2luY2x1ZGUgPGxpbnV4L2J0Zi5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9maWx0ZXIuaD4N
Cj4gICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAgDQo+IEBAIC0xMzAsMTEgKzEzMSw2
NSBAQCBib29sIGJwZl9wcm9iZV9wcm9nX3R5cGUoZW51bSBicGZfcHJvZ190eXBlIHByb2dfdHlw
ZSwgX191MzIgaWZpbmRleCkNCj4gICAJcmV0dXJuIGVycm5vICE9IEVJTlZBTCAmJiBlcnJubyAh
PSBFT1BOT1RTVVBQOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQgbG9hZF9idGYodm9pZCkN
Cj4gK3sNCj4gKyNkZWZpbmUgQlRGX0lORk9fRU5DKGtpbmQsIGtpbmRfZmxhZywgdmxlbikgXA0K
PiArCSgoISEoa2luZF9mbGFnKSA8PCAzMSkgfCAoKGtpbmQpIDw8IDI0KSB8ICgodmxlbikgJiBC
VEZfTUFYX1ZMRU4pKQ0KPiArI2RlZmluZSBCVEZfVFlQRV9FTkMobmFtZSwgaW5mbywgc2l6ZV9v
cl90eXBlKSBcDQo+ICsJKG5hbWUpLCAoaW5mbyksIChzaXplX29yX3R5cGUpDQo+ICsjZGVmaW5l
IEJURl9JTlRfRU5DKGVuY29kaW5nLCBiaXRzX29mZnNldCwgbnJfYml0cykgXA0KPiArCSgoZW5j
b2RpbmcpIDw8IDI0IHwgKGJpdHNfb2Zmc2V0KSA8PCAxNiB8IChucl9iaXRzKSkNCj4gKyNkZWZp
bmUgQlRGX1RZUEVfSU5UX0VOQyhuYW1lLCBlbmNvZGluZywgYml0c19vZmZzZXQsIGJpdHMsIHN6
KSBcDQo+ICsJQlRGX1RZUEVfRU5DKG5hbWUsIEJURl9JTkZPX0VOQyhCVEZfS0lORF9JTlQsIDAs
IDApLCBzeiksIFwNCj4gKwlCVEZfSU5UX0VOQyhlbmNvZGluZywgYml0c19vZmZzZXQsIGJpdHMp
DQo+ICsjZGVmaW5lIEJURl9NRU1CRVJfRU5DKG5hbWUsIHR5cGUsIGJpdHNfb2Zmc2V0KSBcDQo+
ICsJKG5hbWUpLCAodHlwZSksIChiaXRzX29mZnNldCkNCj4gKw0KPiArCWNvbnN0IGNoYXIgYnRm
X3N0cl9zZWNbXSA9ICJcMGJwZl9zcGluX2xvY2tcMHZhbFwwY250XDBsIjsNCj4gKwkvKiBzdHJ1
Y3QgYnBmX3NwaW5fbG9jayB7DQo+ICsJICogICBpbnQgdmFsOw0KPiArCSAqIH07DQo+ICsJICog
c3RydWN0IHZhbCB7DQo+ICsJICogICBpbnQgY250Ow0KPiArCSAqICAgc3RydWN0IGJwZl9zcGlu
X2xvY2sgbDsNCj4gKwkgKiB9Ow0KPiArCSAqLw0KPiArCV9fdTMyIGJ0Zl9yYXdfdHlwZXNbXSA9
IHsNCj4gKwkJLyogaW50ICovDQo+ICsJCUJURl9UWVBFX0lOVF9FTkMoMCwgQlRGX0lOVF9TSUdO
RUQsIDAsIDMyLCA0KSwgIC8qIFsxXSAqLw0KPiArCQkvKiBzdHJ1Y3QgYnBmX3NwaW5fbG9jayAq
LyAgICAgICAgICAgICAgICAgICAgICAvKiBbMl0gKi8NCj4gKwkJQlRGX1RZUEVfRU5DKDEsIEJU
Rl9JTkZPX0VOQyhCVEZfS0lORF9TVFJVQ1QsIDAsIDEpLCA0KSwNCj4gKwkJQlRGX01FTUJFUl9F
TkMoMTUsIDEsIDApLCAvKiBpbnQgdmFsOyAqLw0KPiArCQkvKiBzdHJ1Y3QgdmFsICovICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBbM10gKi8NCj4gKwkJQlRGX1RZUEVfRU5DKDE1
LCBCVEZfSU5GT19FTkMoQlRGX0tJTkRfU1RSVUNULCAwLCAyKSwgOCksDQo+ICsJCUJURl9NRU1C
RVJfRU5DKDE5LCAxLCAwKSwgLyogaW50IGNudDsgKi8NCj4gKwkJQlRGX01FTUJFUl9FTkMoMjMs
IDIsIDMyKSwvKiBzdHJ1Y3QgYnBmX3NwaW5fbG9jayBsOyAqLw0KPiArCX07DQo+ICsJc3RydWN0
IGJ0Zl9oZWFkZXIgYnRmX2hkciA9IHsNCj4gKwkJLm1hZ2ljID0gQlRGX01BR0lDLA0KPiArCQku
dmVyc2lvbiA9IEJURl9WRVJTSU9OLA0KPiArCQkuaGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgYnRm
X2hlYWRlciksDQo+ICsJCS50eXBlX2xlbiA9IHNpemVvZihidGZfcmF3X3R5cGVzKSwNCj4gKwkJ
LnN0cl9vZmYgPSBzaXplb2YoYnRmX3Jhd190eXBlcyksDQo+ICsJCS5zdHJfbGVuID0gc2l6ZW9m
KGJ0Zl9zdHJfc2VjKSwNCj4gKwl9Ow0KPiArCV9fdTggcmF3X2J0ZltzaXplb2Yoc3RydWN0IGJ0
Zl9oZWFkZXIpICsgc2l6ZW9mKGJ0Zl9yYXdfdHlwZXMpICsNCj4gKwkJICAgICBzaXplb2YoYnRm
X3N0cl9zZWMpXTsNCj4gKw0KPiArCW1lbWNweShyYXdfYnRmLCAmYnRmX2hkciwgc2l6ZW9mKGJ0
Zl9oZHIpKTsNCj4gKwltZW1jcHkocmF3X2J0ZiArIHNpemVvZihidGZfaGRyKSwgYnRmX3Jhd190
eXBlcywgc2l6ZW9mKGJ0Zl9yYXdfdHlwZXMpKTsNCj4gKwltZW1jcHkocmF3X2J0ZiArIHNpemVv
ZihidGZfaGRyKSArIHNpemVvZihidGZfcmF3X3R5cGVzKSwNCj4gKwkgICAgICAgYnRmX3N0cl9z
ZWMsIHNpemVvZihidGZfc3RyX3NlYykpOw0KPiArDQo+ICsJcmV0dXJuIGJwZl9sb2FkX2J0Zihy
YXdfYnRmLCBzaXplb2YocmF3X2J0ZiksIDAsIDAsIDApOw0KPiArfQ0KDQpJbiB0aGUgZnV0dXJl
LCBkaWZmZXJlbnQgbWFwIHR5cGVzIGNvdWxkIHdhbnQgdG8gdGVzdCBkaWZmZXJlbnQgdHlwZQ0K
Y29uZmlndXJhdGlvbnMuIE1heWJlIGJ0Zl9yYXdfdHlwZXMgYW5kIGJ0Zl9zdHJfc2VjIGNvdWxk
IGJlIHByb3ZpZGVkDQphcyBhIHBhcmFtZXRlciBmb3IgbG9hZF9idGYoKT8NCg0KPiArDQo+ICAg
Ym9vbCBicGZfcHJvYmVfbWFwX3R5cGUoZW51bSBicGZfbWFwX3R5cGUgbWFwX3R5cGUsIF9fdTMy
IGlmaW5kZXgpDQo+ICAgew0KPiAgIAlpbnQga2V5X3NpemUsIHZhbHVlX3NpemUsIG1heF9lbnRy
aWVzLCBtYXBfZmxhZ3M7DQo+ICsJX191MzIgYnRmX2tleV90eXBlX2lkID0gMCwgYnRmX3ZhbHVl
X3R5cGVfaWQgPSAwOw0KPiAgIAlzdHJ1Y3QgYnBmX2NyZWF0ZV9tYXBfYXR0ciBhdHRyID0ge307
DQo+IC0JaW50IGZkID0gLTEsIGZkX2lubmVyOw0KPiArCWludCBmZCA9IC0xLCBidGZfZmQgPSAt
MSwgZmRfaW5uZXI7DQo+ICAgDQo+ICAgCWtleV9zaXplCT0gc2l6ZW9mKF9fdTMyKTsNCj4gICAJ
dmFsdWVfc2l6ZQk9IHNpemVvZihfX3UzMik7DQo+IEBAIC0xNjAsNiArMjE1LDE2IEBAIGJvb2wg
YnBmX3Byb2JlX21hcF90eXBlKGVudW0gYnBmX21hcF90eXBlIG1hcF90eXBlLCBfX3UzMiBpZmlu
ZGV4KQ0KPiAgIAljYXNlIEJQRl9NQVBfVFlQRV9TVEFDSzoNCj4gICAJCWtleV9zaXplCT0gMDsN
Cj4gICAJCWJyZWFrOw0KPiArCWNhc2UgQlBGX01BUF9UWVBFX1NLX1NUT1JBR0U6DQo+ICsJCWJ0
Zl9rZXlfdHlwZV9pZCA9IDE7DQo+ICsJCWJ0Zl92YWx1ZV90eXBlX2lkID0gMzsNCj4gKwkJdmFs
dWVfc2l6ZSA9IDg7DQo+ICsJCW1heF9lbnRyaWVzID0gMDsNCj4gKwkJbWFwX2ZsYWdzID0gQlBG
X0ZfTk9fUFJFQUxMT0M7DQo+ICsJCWJ0Zl9mZCA9IGxvYWRfYnRmKCk7DQo+ICsJCWlmIChidGZf
ZmQgPCAwKQ0KPiArCQkJcmV0dXJuIGZhbHNlOw0KPiArCQlicmVhazsNCj4gICAJY2FzZSBCUEZf
TUFQX1RZUEVfVU5TUEVDOg0KPiAgIAljYXNlIEJQRl9NQVBfVFlQRV9IQVNIOg0KPiAgIAljYXNl
IEJQRl9NQVBfVFlQRV9BUlJBWToNCj4gQEAgLTIwNSwxMSArMjcwLDE4IEBAIGJvb2wgYnBmX3By
b2JlX21hcF90eXBlKGVudW0gYnBmX21hcF90eXBlIG1hcF90eXBlLCBfX3UzMiBpZmluZGV4KQ0K
PiAgIAkJYXR0ci5tYXhfZW50cmllcyA9IG1heF9lbnRyaWVzOw0KPiAgIAkJYXR0ci5tYXBfZmxh
Z3MgPSBtYXBfZmxhZ3M7DQo+ICAgCQlhdHRyLm1hcF9pZmluZGV4ID0gaWZpbmRleDsNCj4gKwkJ
aWYgKGJ0Zl9mZCA+PSAwKSB7DQo+ICsJCQlhdHRyLmJ0Zl9mZCA9IGJ0Zl9mZDsNCj4gKwkJCWF0
dHIuYnRmX2tleV90eXBlX2lkID0gYnRmX2tleV90eXBlX2lkOw0KPiArCQkJYXR0ci5idGZfdmFs
dWVfdHlwZV9pZCA9IGJ0Zl92YWx1ZV90eXBlX2lkOw0KPiArCQl9DQo+ICAgDQo+ICAgCQlmZCA9
IGJwZl9jcmVhdGVfbWFwX3hhdHRyKCZhdHRyKTsNCj4gICAJfQ0KPiAgIAlpZiAoZmQgPj0gMCkN
Cj4gICAJCWNsb3NlKGZkKTsNCj4gKwlpZiAoYnRmX2ZkID49IDApDQo+ICsJCWNsb3NlKGJ0Zl9m
ZCk7DQo+ICAgDQo+ICAgCXJldHVybiBmZCA+PSAwOw0KPiAgIH0NCj4gDQo=

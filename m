Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908FEC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4948320B7C
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mcnJSGEQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CFt2aug7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDZSuJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:50:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfDZSuI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 14:50:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QIcexg011434;
        Fri, 26 Apr 2019 11:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lRatratIMmZTzJj8Eth6o0O6t1v/QOC0VJSF5k+144g=;
 b=mcnJSGEQPZQrH4aQ+qhGORChgag7AT39k+9bazrAwOI2HhS5ndawwi9J4r/mu8WZJImK
 SGrI65esP5Wax56m1s1pdUl6MpGAvC88lIQRkaGXaiPz8OGXuWTGYwlNRJg0bZjN1P9L
 zKVbkGeCdjGAXmDET9dFrLiLq+xdKF+I3GQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s42qps3sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 11:49:47 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Apr 2019 11:49:47 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Apr 2019 11:49:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 11:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRatratIMmZTzJj8Eth6o0O6t1v/QOC0VJSF5k+144g=;
 b=CFt2aug7KRTQTq+XspzVhxBm2lAmz0zMRkvTBBcYC+P7VVUVMq8UyK8wNQq8D9vB6A9/6IrFaF/rcW79CkH/UD3FYshLeVIwoLKDPgXVh5xjNfHKZvbXg6bI7pd/2/BbrOAhzfcUHuzcSZEL7GIssUGFDBDaVIYCKeR0PP1VCVU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2199.namprd15.prod.outlook.com (52.135.196.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Fri, 26 Apr 2019 18:49:44 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 18:49:44 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Martin Lau <kafai@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in
 bpf map probing
Thread-Topic: [PATCH v3 bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in
 bpf map probing
Thread-Index: AQHU/FMXRizVb8uBukumtVYKswm2FaZOQw6AgAB95ACAAAgEgA==
Date:   Fri, 26 Apr 2019 18:49:43 +0000
Message-ID: <3a6ce258-a117-c203-ac14-96d8fc17abf7@fb.com>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171107.62279-1-kafai@fb.com>
 <c81269b9-a422-0407-e6c4-830e86310852@fb.com>
 <20190426182057.7d54qljtiah5aump@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190426182057.7d54qljtiah5aump@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:9790]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edc2c6b0-d44b-4f0b-0c55-08d6ca77f273
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2199;
x-ms-traffictypediagnostic: BYAPR15MB2199:
x-microsoft-antispam-prvs: <BYAPR15MB219981B479AEC84E4D92BF49D33E0@BYAPR15MB2199.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(53936002)(66446008)(73956011)(476003)(6436002)(478600001)(6636002)(186003)(68736007)(6246003)(446003)(2616005)(11346002)(486006)(316002)(81166006)(81156014)(8676002)(99286004)(8936002)(6862004)(6116002)(46003)(6486002)(66556008)(66476007)(86362001)(37006003)(71190400001)(97736004)(305945005)(64756008)(36756003)(229853002)(25786009)(6512007)(66946007)(31696002)(4326008)(14454004)(71200400001)(31686004)(5660300002)(93886005)(52116002)(256004)(102836004)(386003)(54906003)(7736002)(14444005)(2906002)(6506007)(53546011)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2199;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o/sr4h9eNF0KbJQL7CguiZjN1Clb4uU7om2pRlJx6ZESHoRVfbLZwW4aZzcZb9kqehpjt49+OyV6IAX9m5V76+foFLK3eocqN/wSI9z+g4woYFdyx3ojH4DLE58TFnZWfZQRyinLYz/u8R7AtS08ezTjgDmQqfwC8tcGTbvumFRHsM0DFQ9ZKb3xhktkTUGwdNJUiz4ove4oyP0Ph52mkqrKauXyXPFBG7xMSVW0NmE4R+QbB6V24RKEsmRYCvq+5uD4e8rVhL0NxEy5Hd37vW95KZgtT1oH+NCfol4OK9/P9e7B6Vy/azPwLA2fzqlA4DqaTYi7SzgvEyhEKVPMKsjPzsownrbOG6UQBle/3t0g5wQhLdpvVIbE1Mu6ylKQ4vZ91jOFf3E6AOySpzXNUrKH6PAk4PnD/uvHTo0FIaI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1CB072E459A3D44BB0E46B7D9B193D1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: edc2c6b0-d44b-4f0b-0c55-08d6ca77f273
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 18:49:43.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2199
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjYvMTkgMTE6MjEgQU0sIE1hcnRpbiBMYXUgd3JvdGU6DQo+IE9uIEZyaSwgQXBy
IDI2LCAyMDE5IGF0IDEwOjUwOjI5QU0gLTA3MDAsIFlvbmdob25nIFNvbmcgd3JvdGU6DQo+Pg0K
Pj4NCj4+IE9uIDQvMjYvMTkgMTA6MTEgQU0sIE1hcnRpbiBLYUZhaSBMYXUgd3JvdGU6DQo+Pj4g
VGhpcyBwYXRjaCBzdXBwb3J0cyBwcm9iaW5nIGZvciB0aGUgbmV3IEJQRl9NQVBfVFlQRV9TS19T
VE9SQUdFLg0KPj4+IEJQRl9NQVBfVFlQRV9TS19TVE9SQUdFIGVuZm9yY2VzIEJURiB1c2FnZSwg
c28gdGhlIG5ldyBwcm9iZQ0KPj4+IHJlcXVpcmVzIHRvIGNyZWF0ZSBhbmQgbG9hZCBhIEJURiBh
bHNvLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEthRmFpIExhdSA8a2FmYWlAZmIu
Y29tPg0KPj4+IC0tLQ0KPj4+ICAgIHRvb2xzL2JwZi9icGZ0b29sL21hcC5jICAgICAgIHwgIDEg
Kw0KPj4+ICAgIHRvb2xzL2xpYi9icGYvbGliYnBmX3Byb2Jlcy5jIHwgNzQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDc0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90b29scy9icGYv
YnBmdG9vbC9tYXAuYyBiL3Rvb2xzL2JwZi9icGZ0b29sL21hcC5jDQo+Pj4gaW5kZXggMTBiNmM5
ZDNlNTI1Li42OTNhYjNkYTM3ZGUgMTAwNjQ0DQo+Pj4gLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wv
bWFwLmMNCj4+PiArKysgYi90b29scy9icGYvYnBmdG9vbC9tYXAuYw0KPj4+IEBAIC00Niw2ICs0
Niw3IEBAIGNvbnN0IGNoYXIgKiBjb25zdCBtYXBfdHlwZV9uYW1lW10gPSB7DQo+Pj4gICAgCVtC
UEZfTUFQX1RZUEVfUEVSQ1BVX0NHUk9VUF9TVE9SQUdFXQk9ICJwZXJjcHVfY2dyb3VwX3N0b3Jh
Z2UiLA0KPj4+ICAgIAlbQlBGX01BUF9UWVBFX1FVRVVFXQkJCT0gInF1ZXVlIiwNCj4+PiAgICAJ
W0JQRl9NQVBfVFlQRV9TVEFDS10JCQk9ICJzdGFjayIsDQo+Pj4gKwlbQlBGX01BUF9UWVBFX1NL
X1NUT1JBR0VdCQk9ICJza19zdG9yYWdlIiwNCj4+PiAgICB9Ow0KPj4+ICAgIA0KPj4+ICAgIGNv
bnN0IHNpemVfdCBtYXBfdHlwZV9uYW1lX3NpemUgPSBBUlJBWV9TSVpFKG1hcF90eXBlX25hbWUp
Ow0KPj4+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZl9wcm9iZXMuYyBiL3Rvb2xz
L2xpYi9icGYvbGliYnBmX3Byb2Jlcy5jDQo+Pj4gaW5kZXggMGYyNTU0MTYzMmUzLi4yZTI2ZGRi
MDA1ZTQgMTAwNjQ0DQo+Pj4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGZfcHJvYmVzLmMNCj4+
PiArKysgYi90b29scy9saWIvYnBmL2xpYmJwZl9wcm9iZXMuYw0KPj4+IEBAIC05LDYgKzksNyBA
QA0KPj4+ICAgICNpbmNsdWRlIDxuZXQvaWYuaD4NCj4+PiAgICAjaW5jbHVkZSA8c3lzL3V0c25h
bWUuaD4NCj4+PiAgICANCj4+PiArI2luY2x1ZGUgPGxpbnV4L2J0Zi5oPg0KPj4+ICAgICNpbmNs
dWRlIDxsaW51eC9maWx0ZXIuaD4NCj4+PiAgICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+
Pj4gICAgDQo+Pj4gQEAgLTEzMCwxMSArMTMxLDY1IEBAIGJvb2wgYnBmX3Byb2JlX3Byb2dfdHlw
ZShlbnVtIGJwZl9wcm9nX3R5cGUgcHJvZ190eXBlLCBfX3UzMiBpZmluZGV4KQ0KPj4+ICAgIAly
ZXR1cm4gZXJybm8gIT0gRUlOVkFMICYmIGVycm5vICE9IEVPUE5PVFNVUFA7DQo+Pj4gICAgfQ0K
Pj4+ICAgIA0KPj4+ICtzdGF0aWMgaW50IGxvYWRfYnRmKHZvaWQpDQo+Pj4gK3sNCj4+PiArI2Rl
ZmluZSBCVEZfSU5GT19FTkMoa2luZCwga2luZF9mbGFnLCB2bGVuKSBcDQo+Pj4gKwkoKCEhKGtp
bmRfZmxhZykgPDwgMzEpIHwgKChraW5kKSA8PCAyNCkgfCAoKHZsZW4pICYgQlRGX01BWF9WTEVO
KSkNCj4+PiArI2RlZmluZSBCVEZfVFlQRV9FTkMobmFtZSwgaW5mbywgc2l6ZV9vcl90eXBlKSBc
DQo+Pj4gKwkobmFtZSksIChpbmZvKSwgKHNpemVfb3JfdHlwZSkNCj4+PiArI2RlZmluZSBCVEZf
SU5UX0VOQyhlbmNvZGluZywgYml0c19vZmZzZXQsIG5yX2JpdHMpIFwNCj4+PiArCSgoZW5jb2Rp
bmcpIDw8IDI0IHwgKGJpdHNfb2Zmc2V0KSA8PCAxNiB8IChucl9iaXRzKSkNCj4+PiArI2RlZmlu
ZSBCVEZfVFlQRV9JTlRfRU5DKG5hbWUsIGVuY29kaW5nLCBiaXRzX29mZnNldCwgYml0cywgc3op
IFwNCj4+PiArCUJURl9UWVBFX0VOQyhuYW1lLCBCVEZfSU5GT19FTkMoQlRGX0tJTkRfSU5ULCAw
LCAwKSwgc3opLCBcDQo+Pj4gKwlCVEZfSU5UX0VOQyhlbmNvZGluZywgYml0c19vZmZzZXQsIGJp
dHMpDQo+Pj4gKyNkZWZpbmUgQlRGX01FTUJFUl9FTkMobmFtZSwgdHlwZSwgYml0c19vZmZzZXQp
IFwNCj4+PiArCShuYW1lKSwgKHR5cGUpLCAoYml0c19vZmZzZXQpDQo+Pj4gKw0KPj4+ICsJY29u
c3QgY2hhciBidGZfc3RyX3NlY1tdID0gIlwwYnBmX3NwaW5fbG9ja1wwdmFsXDBjbnRcMGwiOw0K
Pj4+ICsJLyogc3RydWN0IGJwZl9zcGluX2xvY2sgew0KPj4+ICsJICogICBpbnQgdmFsOw0KPj4+
ICsJICogfTsNCj4+PiArCSAqIHN0cnVjdCB2YWwgew0KPj4+ICsJICogICBpbnQgY250Ow0KPj4+
ICsJICogICBzdHJ1Y3QgYnBmX3NwaW5fbG9jayBsOw0KPj4+ICsJICogfTsNCj4+PiArCSAqLw0K
Pj4+ICsJX191MzIgYnRmX3Jhd190eXBlc1tdID0gew0KPj4+ICsJCS8qIGludCAqLw0KPj4+ICsJ
CUJURl9UWVBFX0lOVF9FTkMoMCwgQlRGX0lOVF9TSUdORUQsIDAsIDMyLCA0KSwgIC8qIFsxXSAq
Lw0KPj4+ICsJCS8qIHN0cnVjdCBicGZfc3Bpbl9sb2NrICovICAgICAgICAgICAgICAgICAgICAg
IC8qIFsyXSAqLw0KPj4+ICsJCUJURl9UWVBFX0VOQygxLCBCVEZfSU5GT19FTkMoQlRGX0tJTkRf
U1RSVUNULCAwLCAxKSwgNCksDQo+Pj4gKwkJQlRGX01FTUJFUl9FTkMoMTUsIDEsIDApLCAvKiBp
bnQgdmFsOyAqLw0KPj4+ICsJCS8qIHN0cnVjdCB2YWwgKi8gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIFszXSAqLw0KPj4+ICsJCUJURl9UWVBFX0VOQygxNSwgQlRGX0lORk9fRU5D
KEJURl9LSU5EX1NUUlVDVCwgMCwgMiksIDgpLA0KPj4+ICsJCUJURl9NRU1CRVJfRU5DKDE5LCAx
LCAwKSwgLyogaW50IGNudDsgKi8NCj4+PiArCQlCVEZfTUVNQkVSX0VOQygyMywgMiwgMzIpLC8q
IHN0cnVjdCBicGZfc3Bpbl9sb2NrIGw7ICovDQo+Pj4gKwl9Ow0KPj4+ICsJc3RydWN0IGJ0Zl9o
ZWFkZXIgYnRmX2hkciA9IHsNCj4+PiArCQkubWFnaWMgPSBCVEZfTUFHSUMsDQo+Pj4gKwkJLnZl
cnNpb24gPSBCVEZfVkVSU0lPTiwNCj4+PiArCQkuaGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgYnRm
X2hlYWRlciksDQo+Pj4gKwkJLnR5cGVfbGVuID0gc2l6ZW9mKGJ0Zl9yYXdfdHlwZXMpLA0KPj4+
ICsJCS5zdHJfb2ZmID0gc2l6ZW9mKGJ0Zl9yYXdfdHlwZXMpLA0KPj4+ICsJCS5zdHJfbGVuID0g
c2l6ZW9mKGJ0Zl9zdHJfc2VjKSwNCj4+PiArCX07DQo+Pj4gKwlfX3U4IHJhd19idGZbc2l6ZW9m
KHN0cnVjdCBidGZfaGVhZGVyKSArIHNpemVvZihidGZfcmF3X3R5cGVzKSArDQo+Pj4gKwkJICAg
ICBzaXplb2YoYnRmX3N0cl9zZWMpXTsNCj4+PiArDQo+Pj4gKwltZW1jcHkocmF3X2J0ZiwgJmJ0
Zl9oZHIsIHNpemVvZihidGZfaGRyKSk7DQo+Pj4gKwltZW1jcHkocmF3X2J0ZiArIHNpemVvZihi
dGZfaGRyKSwgYnRmX3Jhd190eXBlcywgc2l6ZW9mKGJ0Zl9yYXdfdHlwZXMpKTsNCj4+PiArCW1l
bWNweShyYXdfYnRmICsgc2l6ZW9mKGJ0Zl9oZHIpICsgc2l6ZW9mKGJ0Zl9yYXdfdHlwZXMpLA0K
Pj4+ICsJICAgICAgIGJ0Zl9zdHJfc2VjLCBzaXplb2YoYnRmX3N0cl9zZWMpKTsNCj4+PiArDQo+
Pj4gKwlyZXR1cm4gYnBmX2xvYWRfYnRmKHJhd19idGYsIHNpemVvZihyYXdfYnRmKSwgMCwgMCwg
MCk7DQo+Pj4gK30NCj4+DQo+PiBJbiB0aGUgZnV0dXJlLCBkaWZmZXJlbnQgbWFwIHR5cGVzIGNv
dWxkIHdhbnQgdG8gdGVzdCBkaWZmZXJlbnQgdHlwZQ0KPj4gY29uZmlndXJhdGlvbnMuIE1heWJl
IGJ0Zl9yYXdfdHlwZXMgYW5kIGJ0Zl9zdHJfc2VjIGNvdWxkIGJlIHByb3ZpZGVkDQo+PiBhcyBh
IHBhcmFtZXRlciBmb3IgbG9hZF9idGYoKT8NCj4gSSB0aGluayBpdCB3aWxsIGJlIGNsZWFuZXIg
dG8ga2VlcCBvbmUgYnRmX3Jhd190eXBlc1tdLg0KPiBPdGhlciB0eXBlcyBjYW4gYmUgYWRkZWQg
dG8gdGhlIHNhbWUgYnRmX3Jhd190eXBlc1tdIGxhdGVyIGluc3RlYWQgb2YNCj4gcmVkZWZpbmlu
ZyBpbnQvbG9uZy91bnNpZ25lZC4uLmV0Yy4gIFRoZSBicGZfcHJvYmVfbWFwX3R5cGUoKSBjYW4N
Cj4gcG9pbnQgdGhlIGJ0Zl9rZXlfdHlwZV9pZCBhbmQgYnRmX3ZhbHVlX3R5cGVfaWQgdG8gZGlm
ZmVyZW50IHR5cGVfaWQuDQo+IA0KPiBJdCBjYW4gYmUgcmV2aXNpdGVkIGlmIGl0IG5lZWRzIHRv
IHByb2JlIHNvbWUgbmV3bHkgaW50cm9kdWNlZCBCVEYgdHlwZQ0KPiAoaW4gdGhlIHR5cGUgc2Vj
dGlvbikgbGF0ZXIgd2hpY2ggSSB0aGluayBzaG91bGQgYmUgdmVyeSByYXJlLg0KDQpGYWlyIGVu
b3VnaC4gV2UgY2FuIHJldmlzaXQgbGF0ZXIgb25jZSB0aGVyZSBpcyBhIG5lZWQgZm9yIHByb2Jp
bmcgYnRmDQpmb3IgYSBkaWZmZXJlbnQgcHVycG9zZS4NCg0KPiANCj4+DQo+Pj4gKw0KPj4+ICAg
IGJvb2wgYnBmX3Byb2JlX21hcF90eXBlKGVudW0gYnBmX21hcF90eXBlIG1hcF90eXBlLCBfX3Uz
MiBpZmluZGV4KQ0KPj4+ICAgIHsNCj4+PiAgICAJaW50IGtleV9zaXplLCB2YWx1ZV9zaXplLCBt
YXhfZW50cmllcywgbWFwX2ZsYWdzOw0KPj4+ICsJX191MzIgYnRmX2tleV90eXBlX2lkID0gMCwg
YnRmX3ZhbHVlX3R5cGVfaWQgPSAwOw0KPj4+ICAgIAlzdHJ1Y3QgYnBmX2NyZWF0ZV9tYXBfYXR0
ciBhdHRyID0ge307DQo+Pj4gLQlpbnQgZmQgPSAtMSwgZmRfaW5uZXI7DQo+Pj4gKwlpbnQgZmQg
PSAtMSwgYnRmX2ZkID0gLTEsIGZkX2lubmVyOw0KPj4+ICAgIA0KPj4+ICAgIAlrZXlfc2l6ZQk9
IHNpemVvZihfX3UzMik7DQo+Pj4gICAgCXZhbHVlX3NpemUJPSBzaXplb2YoX191MzIpOw0KPj4+
IEBAIC0xNjAsNiArMjE1LDE2IEBAIGJvb2wgYnBmX3Byb2JlX21hcF90eXBlKGVudW0gYnBmX21h
cF90eXBlIG1hcF90eXBlLCBfX3UzMiBpZmluZGV4KQ0KPj4+ICAgIAljYXNlIEJQRl9NQVBfVFlQ
RV9TVEFDSzoNCj4+PiAgICAJCWtleV9zaXplCT0gMDsNCj4+PiAgICAJCWJyZWFrOw0KPj4+ICsJ
Y2FzZSBCUEZfTUFQX1RZUEVfU0tfU1RPUkFHRToNCj4+PiArCQlidGZfa2V5X3R5cGVfaWQgPSAx
Ow0KPj4+ICsJCWJ0Zl92YWx1ZV90eXBlX2lkID0gMzsNCj4+PiArCQl2YWx1ZV9zaXplID0gODsN
Cj4+PiArCQltYXhfZW50cmllcyA9IDA7DQo+Pj4gKwkJbWFwX2ZsYWdzID0gQlBGX0ZfTk9fUFJF
QUxMT0M7DQo+Pj4gKwkJYnRmX2ZkID0gbG9hZF9idGYoKTsNCj4+PiArCQlpZiAoYnRmX2ZkIDwg
MCkNCj4+PiArCQkJcmV0dXJuIGZhbHNlOw0KPj4+ICsJCWJyZWFrOw0KPj4+ICAgIAljYXNlIEJQ
Rl9NQVBfVFlQRV9VTlNQRUM6DQo+Pj4gICAgCWNhc2UgQlBGX01BUF9UWVBFX0hBU0g6DQo+Pj4g
ICAgCWNhc2UgQlBGX01BUF9UWVBFX0FSUkFZOg0KPj4+IEBAIC0yMDUsMTEgKzI3MCwxOCBAQCBi
b29sIGJwZl9wcm9iZV9tYXBfdHlwZShlbnVtIGJwZl9tYXBfdHlwZSBtYXBfdHlwZSwgX191MzIg
aWZpbmRleCkNCj4+PiAgICAJCWF0dHIubWF4X2VudHJpZXMgPSBtYXhfZW50cmllczsNCj4+PiAg
ICAJCWF0dHIubWFwX2ZsYWdzID0gbWFwX2ZsYWdzOw0KPj4+ICAgIAkJYXR0ci5tYXBfaWZpbmRl
eCA9IGlmaW5kZXg7DQo+Pj4gKwkJaWYgKGJ0Zl9mZCA+PSAwKSB7DQo+Pj4gKwkJCWF0dHIuYnRm
X2ZkID0gYnRmX2ZkOw0KPj4+ICsJCQlhdHRyLmJ0Zl9rZXlfdHlwZV9pZCA9IGJ0Zl9rZXlfdHlw
ZV9pZDsNCj4+PiArCQkJYXR0ci5idGZfdmFsdWVfdHlwZV9pZCA9IGJ0Zl92YWx1ZV90eXBlX2lk
Ow0KPj4+ICsJCX0NCj4+PiAgICANCj4+PiAgICAJCWZkID0gYnBmX2NyZWF0ZV9tYXBfeGF0dHIo
JmF0dHIpOw0KPj4+ICAgIAl9DQo+Pj4gICAgCWlmIChmZCA+PSAwKQ0KPj4+ICAgIAkJY2xvc2Uo
ZmQpOw0KPj4+ICsJaWYgKGJ0Zl9mZCA+PSAwKQ0KPj4+ICsJCWNsb3NlKGJ0Zl9mZCk7DQo+Pj4g
ICAgDQo+Pj4gICAgCXJldHVybiBmZCA+PSAwOw0KPj4+ICAgIH0NCj4+Pg0K

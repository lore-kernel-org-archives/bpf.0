Return-Path: <SRS0=xnNa=S5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFFC43219
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 16:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9BF2087F
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 16:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HZ6qs2Pq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KxpMzv5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfD0QBw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:01:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34878 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbfD0QBw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Apr 2019 12:01:52 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3RFwjSj010081;
        Sat, 27 Apr 2019 09:01:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8Jo922gXAAdB/fEZQl6LZJJ7yYKUSHqAknWN66p5L4w=;
 b=HZ6qs2PqMvym0Z1sKQ/25IK02OhYlpola+wAEo9x1mCwK/FaXnMUv8X/GeABC1wINko2
 o09G6jawjc19P9wq3FYrBXkrtmeOn1YHpPRo0NgXUG8S0oI5+gj3+hGljPpgUs8ddjgV
 FGbF+BFwZLVrn/crLazdNhGZHOPZBUQq4LU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s4mkdgj4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 27 Apr 2019 09:01:30 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sat, 27 Apr 2019 09:01:29 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sat, 27 Apr 2019 09:01:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jo922gXAAdB/fEZQl6LZJJ7yYKUSHqAknWN66p5L4w=;
 b=KxpMzv5+dACMS8HLLnRjXlkTktbUpR5pn+nHKTnDWOHtCLU9LbrDYLxkMVOA+CEv5hmKCtLz9i2c4yhTgp92nB5mJxqpLYzyA+MnZp4BvJMzFlxUEZXfwIOKnNT/Z2JkKnFJAf29ccJii3v77NHCu4nMvT1kFdztRYkRprEMh6w=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2888.namprd15.prod.outlook.com (20.178.206.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sat, 27 Apr 2019 16:01:23 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Sat, 27 Apr 2019
 16:01:23 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v4 bpf-next 0/7] BPF sk local storage
Thread-Topic: [PATCH v4 bpf-next 0/7] BPF sk local storage
Thread-Index: AQHU/IlaSIKgLiv9l0OLXurIhDNljKZQK9SA
Date:   Sat, 27 Apr 2019 16:01:23 +0000
Message-ID: <f0489bd3-1b30-7a50-4ec4-9b5e95459149@fb.com>
References: <20190426233938.1330361-1-kafai@fb.com>
In-Reply-To: <20190426233938.1330361-1-kafai@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::69a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47182adc-14cf-4ca2-9f83-08d6cb299841
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2888;
x-ms-traffictypediagnostic: BYAPR15MB2888:
x-microsoft-antispam-prvs: <BYAPR15MB288819D55CDFA4649EE5B927D33F0@BYAPR15MB2888.namprd15.prod.outlook.com>
x-forefront-prvs: 0020414413
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(4326008)(97736004)(2616005)(446003)(99286004)(81166006)(8936002)(14444005)(186003)(52116002)(53936002)(81156014)(76176011)(6436002)(102836004)(53546011)(386003)(6506007)(46003)(25786009)(64756008)(66556008)(66476007)(256004)(11346002)(6246003)(486006)(66946007)(8676002)(476003)(2906002)(73956011)(5660300002)(71190400001)(2501003)(71200400001)(6512007)(7736002)(6116002)(66446008)(31686004)(2201001)(14454004)(54906003)(478600001)(36756003)(110136005)(316002)(68736007)(6486002)(229853002)(31696002)(305945005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2888;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YGJ+ffBKqzCNwpDG9/hQdFJZjjtYFTO/ypWC2/9FMAwFrI9BWFUwTME8JWJjTx/XAZ75LBNnS1Aiy5ewKF+wdUdoLHItyHhvKiAhtr0z8/YwsbndkYP2GcYp1LN8aqIK4W6eDbdeML7yyKAriuSJ1HgjWUA98gRuyXrGDgRj1J2RC2aIdKMWhmnE9RkZoFN/wuzyGMfL6U4LjaY/fuJTQZMFsdJJdbWATRsFBeLZXYBVjwanBb3MYV7jEkwmrz9Hmki3R235xM5OqQB/QZE6jPRDkHUgDa6Wz+AM4iBeklJgzDRXvikdkrraZaQLqwCyf60u+fPUmTszmH9+vzC2LcTtNxRGZRUIZ2AvF3+H6UtO8HxsMZSZ5gl83ZkmNdojJ1t4lVtak7a4ZK3gEd+1iO/veHwuB/yGniGeOkN0GCU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49886025BC4A2440B80562F7A552A7C0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47182adc-14cf-4ca2-9f83-08d6cb299841
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2019 16:01:23.1521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-27_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjYvMTkgNDozOSBQTSwgTWFydGluIEthRmFpIExhdSB3cm90ZToNCj4gdjQ6DQo+
IC0gTW92ZSBjaGVja3MgdG8gbWFwX2FsbG9jX2NoZWNrIGluIHBhdGNoIDEgKFN0YW5pc2xhdiBG
b21pY2hldikNCj4gLSBSZWZhY3RvciBCVEYgZW5jb2RpbmcgbWFjcm9zIHRvIHRlc3RfYnRmLmgg
YXQNCj4gICAgYSBuZXcgcGF0Y2ggNCAoU3RhbmlzbGF2IEZvbWljaGV2KQ0KPiAtIFJlZmFjdG9y
IGdldGVudiBhbmQgYWRkIHByaW50IFBBU1MgbWVzc2FnZSBhdCB0aGUNCj4gICAgZW5kIG9mIHRo
ZSB0ZXN0IGluIHBhdGNoIDYgKFlvbmdob25nIFNvbmcpDQo+IA0KPiB2MzoNCj4gLSBSZXBsYWNl
IHNwaW5sb2NrX3R5cGVzLmggd2l0aCBzcGlubG9jay5oIGluIHBhdGNoIDENCj4gICAgKGtidWls
ZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPikNCj4gDQo+IHYyOg0KPiAtIEFkZCB0aGUgInRl
c3RfbWFwcy5oIiBmaWxlIGluIHBhdGNoIDUNCj4gDQo+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMg
dGhlIEJQRiBzayBsb2NhbCBzdG9yYWdlLiAgVGhlDQo+IGRldGFpbHMgaXMgaW4gdGhlIHBhdGNo
IDEgY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiBNYXJ0aW4gS2FGYWkgTGF1ICg3KToNCj4gICAgYnBm
OiBJbnRyb2R1Y2UgYnBmIHNrIGxvY2FsIHN0b3JhZ2UNCj4gICAgYnBmOiBTeW5jIGJwZi5oIHRv
IHRvb2xzDQo+ICAgIGJwZjogU3VwcG9ydCBCUEZfTUFQX1RZUEVfU0tfU1RPUkFHRSBpbiBicGYg
bWFwIHByb2JpbmcNCj4gICAgYnBmOiBSZWZhY3RvciBCVEYgZW5jb2RpbmcgbWFjcm8gdG8gdGVz
dF9idGYuaA0KPiAgICBicGY6IEFkZCB2ZXJpZmllciB0ZXN0cyBmb3IgdGhlIGJwZl9za19zdG9y
YWdlDQo+ICAgIGJwZjogQWRkIEJQRl9NQVBfVFlQRV9TS19TVE9SQUdFIHRlc3QgdG8gdGVzdF9t
YXBzDQo+ICAgIGJwZjogQWRkIGVuZS10by1lbmQgdGVzdCBmb3IgYnBmX3NrX3N0b3JhZ2VfKiBo
ZWxwZXJzDQoNCkxvb2tzIGdvb2QgdG8gbWUuIEFjayB0aGUgd2hvbGUgc2VyaWVzLg0KDQpBY2tl
ZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCg0KPiANCj4gICBpbmNsdWRlL2xpbnV4
L2JwZi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGluY2x1ZGUvbGlu
dXgvYnBmX3R5cGVzLmggICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgaW5jbHVkZS9u
ZXQvYnBmX3NrX3N0b3JhZ2UuaCAgICAgICAgICAgICAgICAgIHwgIDEzICsNCj4gICBpbmNsdWRl
L25ldC9zb2NrLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAgIGluY2x1
ZGUvdWFwaS9saW51eC9icGYuaCAgICAgICAgICAgICAgICAgICAgICB8ICA0NCArLQ0KPiAgIGtl
cm5lbC9icGYvc3lzY2FsbC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KPiAg
IGtlcm5lbC9icGYvdmVyaWZpZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNyArLQ0K
PiAgIG5ldC9icGYvdGVzdF9ydW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
DQo+ICAgbmV0L2NvcmUvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4gICBuZXQvY29yZS9icGZfc2tfc3RvcmFnZS5jICAgICAgICAgICAgICAgICAgICAgfCA4
MDQgKysrKysrKysrKysrKysrKysrDQo+ICAgbmV0L2NvcmUvZmlsdGVyLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEyICsNCj4gICBuZXQvY29yZS9zb2NrLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAgIHRvb2xzL2JwZi9icGZ0b29sL21hcC5jICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4
L2JwZi5oICAgICAgICAgICAgICAgIHwgIDQ0ICstDQo+ICAgdG9vbHMvbGliL2JwZi9saWJicGZf
cHJvYmVzLmMgICAgICAgICAgICAgICAgIHwgIDc0ICstDQo+ICAgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL01ha2VmaWxlICAgICAgICAgIHwgIDI1ICstDQo+ICAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL2JwZl9oZWxwZXJzLmggICAgIHwgICA1ICsNCj4gICAuLi4vc2VsZnRlc3Rz
L2JwZi9tYXBfdGVzdHMvc2tfc3RvcmFnZV9tYXAuYyAgfCA2MjkgKysrKysrKysrKysrKysNCj4g
ICAuLi4vYnBmL3Byb2dzL3Rlc3Rfc29ja19maWVsZHNfa2Vybi5jICAgICAgICAgfCAgNTMgKysN
Cj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9idGYuYyAgICAgICAgfCAgNjMg
Ky0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9idGYuaCAgICAgICAgfCAg
NjkgKysNCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9tYXBzLmMgICAgICAg
fCAgMTggKy0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9tYXBzLmggICAg
ICAgfCAgMTcgKw0KPiAgIC4uLi90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9zb2NrX2ZpZWxk
cy5jICB8IDExNSArKy0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF92ZXJp
Zmllci5jICAgfCAgNTUgKy0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdmVyaWZp
ZXIvc29jay5jICAgfCAxMTYgKysrDQo+ICAgMjYgZmlsZXMgY2hhbmdlZCwgMjA4OSBpbnNlcnRp
b25zKCspLCAxMTQgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
bmV0L2JwZl9za19zdG9yYWdlLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgbmV0L2NvcmUvYnBm
X3NrX3N0b3JhZ2UuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvbWFwX3Rlc3RzL3NrX3N0b3JhZ2VfbWFwLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfYnRmLmgNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfbWFwcy5oDQo+IA0K

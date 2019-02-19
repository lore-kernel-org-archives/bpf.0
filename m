Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765BC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 02:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBA921773
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 02:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WgrPJRzp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ihE3XFyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfBSCrp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:47:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfBSCro (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Feb 2019 21:47:44 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1J2cL49003552;
        Mon, 18 Feb 2019 18:46:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ULDiAeG9ykEulaFXtEDbpb9XV87YeboPN9d3kep+AuY=;
 b=WgrPJRzpj/jv3n18PwDZewdWcQGca3rpk1Sz34Ga6nfAy0SoyJhpXm1fMl+duYV80R2/
 7nEVI3CMeo59SDp9yP9fABZ1FDxix/80TrO53odbWgP3QlhXfLx/XjbcrAXsyX2GR+/J
 KG5Y1LSXD9AFNdLcISjYbJcVI1Rmb4wdkCg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qr7rp86jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 18:46:58 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 18:46:57 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 18 Feb 2019 18:46:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULDiAeG9ykEulaFXtEDbpb9XV87YeboPN9d3kep+AuY=;
 b=ihE3XFyK6YER0LkAxuZZQogJJeXM1vrqcrVOY4oVEl4nbqPGRBLBPeZ12FyaRSESDGNwxNcoPJXsEzjjY67AINClv+V3bJp8puCTT0Rpcc5Ye/jxXXR306nOjdlyTjdKDO6g01drfCFFRwe8U1inAIcLqOzPUX+agIxM+F/nF6c=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2358.namprd15.prod.outlook.com (52.135.198.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 02:46:55 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 02:46:55 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before
 writing out to ELF
Thread-Topic: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before
 writing out to ELF
Thread-Index: AQHUxpmk3eFBL443iEOLGbqWUGeCDqXln2AAgABWhoCAAAShgIAAcmqAgAAAlwA=
Date:   Tue, 19 Feb 2019 02:46:55 +0000
Message-ID: <dd30614c-2950-63a1-9c85-35e092329eaf@fb.com>
References: <20190217082018.1008069-1-andriin@fb.com>
 <20190217082018.1008069-3-andriin@fb.com> <20190218142900.GR31177@kernel.org>
 <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
 <20190218195515.GT31177@kernel.org>
 <CAEf4BzY1BYF_Ki4zHf=_6K19A32xpV6MsfpaZLWS_Y2maYfEwQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY1BYF_Ki4zHf=_6K19A32xpV6MsfpaZLWS_Y2maYfEwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:a364]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 097e747b-3650-4f70-ac16-08d69614823f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2358;
x-ms-traffictypediagnostic: BYAPR15MB2358:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2358;20:Ze3nK603gedHuqvfa9L6kbzwDC/SzW1SsCvmnHWgMcLzIKByKAfc//Hi9AA2Im2toB4S7WPY+kfb8yTRLt1vyKXlnCgpVqPaRS6V1c+jQ6KWDdN7mheVAQkYGD1UpkcmOVB3ARmivLAMAXJnwEycpefQPPZsbavkbQic4CDtOfo=
x-microsoft-antispam-prvs: <BYAPR15MB2358737461FF8FC96CD75175D77C0@BYAPR15MB2358.namprd15.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(97736004)(229853002)(76176011)(81156014)(81166006)(6116002)(486006)(8676002)(14444005)(256004)(99286004)(36756003)(52116002)(5660300002)(446003)(6486002)(105586002)(11346002)(8936002)(86362001)(6436002)(31696002)(106356001)(7736002)(31686004)(2616005)(476003)(478600001)(4326008)(102836004)(93886005)(68736007)(46003)(6512007)(25786009)(186003)(71190400001)(71200400001)(2906002)(53936002)(6246003)(305945005)(53546011)(386003)(6506007)(14454004)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2358;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sdWTzpM3XIK5z+hygm92QL7bNUHDgUbwMqDrxf+KYH2bKqXhTCshyN57OMZUZSy8m61StO9IDPKg3wLievhGW0ttlumq7qCSjg/YDZ134qWGzlfcWl6My9ZWFQPnc23jQflFYXgiBlOti7dLheWPJI8A90tqX5gvx0o67R0aWmJ32HTcLCFCCrZb8foyECkOV8wZrlZE4Lmy6itODXuHH0rpylQpqII+gjy0rRXJx5soQTjqubbrycOmyR8sbWQnqAQyiHLMOc8pugG+NJS/wb+418/BF2iIqYpXQdnOjsNGxH34LSqgwat8hAo6YKHu67ymBUsw+mJSugHZXxn9Ro3rB+n7kSrpcaGCwuJbw/lkGURFz9jLuS4+QeGVyr8p3+lLm/Mzl/5t7IGuKlAluy3RTv/b8xePK3ID8L5m7Dc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A7E1B64697C814C8CB74C965F8B2E51@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 097e747b-3650-4f70-ac16-08d69614823f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 02:46:54.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2358
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8xOC8xOSA2OjQ0IFBNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+IE9uIE1vbiwgRmVi
IDE4LCAyMDE5IGF0IDExOjU1IEFNIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8YXJuYWxk
by5tZWxvQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRW0gTW9uLCBGZWIgMTgsIDIwMTkgYXQg
MTE6Mzg6NDFBTSAtMDgwMCwgQW5kcmlpIE5ha3J5aWtvIGVzY3JldmV1Og0KPj4+IE9uIE1vbiwg
RmViIDE4LCAyMDE5IGF0IDY6MjkgQU0gQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIHdyb3RlOg0K
Pj4+PiBUaGFua3MgZm9yIGFsbCB0aGUgY29vbCB3b3JrIQ0KPj4NCj4+PiBNeSBwbGVhc3VyZSwg
aXQgd2FzIGZ1biEgOikNCj4+DQo+PiBTbywgbmV4dCBzdGVwLCB0YWcgYSBwYWhvbGUgcmVsZWFz
ZSBhbmQgYW5ub3VuY2UgaXQsIGJ1dCBJIHdvbmRlciBhYm91dA0KPj4gdGhlIGxpYmJwZiBsaW5r
aW5nLCB3b3VsZG4ndCBiZSBiZXR0ZXIsIGZvciBub3csIHRvIG1ha2UgaXQgbGluaw0KPj4gc3Rh
dGljYWxseSB3aXRoIGxpYmJwZj8NCj4+DQo+PiBJIGFzayB0aGlzIGJlY2F1c2UgbGliYnBmIGlz
bid0IHlldCBnZW5lcmFsbHkgYXZhaWxhYmxlLCBzbyBwZXJoYXBzIHdlDQo+PiBzaG91bGQgaGF2
ZSBzb21lIGxvZ2ljIHRvIGRldGVjdCBpZiBpdCBpcyBhdmFpbGFibGUgYW5kIGxpbmsgYWdhaW5z
dCBpdA0KPj4gb3IgaWYgbm90LCB1c2UgdGhlIG1vZHVsZSBzdHVmZiB3ZSBoYXZlIG5vdyBhbmQg
bGluayBpdCBzdGF0aWNhbGx5LA0KPj4gd2R5dD8NCj4gDQo+IEkgYWdyZWUuIE5vdyB0aGUgcXVl
c3Rpb24gaXMgaG93IHRvIGRvIGl0Lg0KPiANCj4gVGhlIGVhc2llc3Qgd2F5IHRvIGRvIHRoaXMg
aXMgdG8gbWFrZSBicGYtc3RhdGljIGFuIE9CSkVDVCBsaWJyYXJ5IGluDQo+IGNtYWtlLCB3aGlj
aCB3aWxsIG1ha2UgaXQgY29tcGlsZSBhcyBQSUMgbGlicmFyeS4gQnV0IHRoYXQgZmVhdHVyZQ0K
PiByZXF1aXJlcyBjbWFrZSAyLjguOC4gV291bGQgeW91IGJlIG9rIHRvIGJ1bXAgbWluaW11bSB2
ZXJzaW9uIG9mIGNtYWtlDQo+IHRvIDIuOC44IChpdCdzIDIuNC44IHJpZ2h0IG5vdykuDQoNCnRo
YXQncyBvbGQuDQpsbHZtIGRvZXM6DQpjbWFrZV9taW5pbXVtX3JlcXVpcmVkKFZFUlNJT04gMy40
LjMpDQo=

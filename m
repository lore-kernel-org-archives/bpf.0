Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73907C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 22:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9CB206A3
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 22:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qEr10Xuk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LhH6Z7u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfDVWIN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:08:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbfDVWIM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Apr 2019 18:08:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MM5cDk010960;
        Mon, 22 Apr 2019 15:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HAXbhWtVa3A6AKvhw8uD6bwtmXN84PWfGbLE5vLd2gw=;
 b=qEr10XuknDqJbN3VvwZ1OLR6c548QUO1Lt8X8mW99h314PEvlu49ubrZUf9/Mt5DE3dR
 LC6QWo60MipzSQ9tj6ugUYIIPmqY6uh5WAVzRlvt6WVuarTSKozmC64dQKecSP24PWKm
 8imAj11LLKZQze2Q2t85GiQMH+9B9OcNhik= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s1k6mrrgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 15:07:49 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 15:07:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 15:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAXbhWtVa3A6AKvhw8uD6bwtmXN84PWfGbLE5vLd2gw=;
 b=LhH6Z7u/NPkO2iAGkiyNZVutKQlNQ8e+zJmxhjmumyqB6NvxtPbsH6lyLur/EZ9hZh7uESfc+KhW/3XAnBY3amEBzBaHNAmv9LNxPno19A7GgwNgjLK33h5sSu/SkGcSRUsUDN33c6Koq/AvKZAsfcI1rwdhCjPHq2wFf9QquD0=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2984.namprd15.prod.outlook.com (20.178.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Mon, 22 Apr 2019 22:07:46 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 22:07:46 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Xiao Han <xiao.han@orange.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf v2 0/2] bpf: mark registers as safe or unknown in all
 frames
Thread-Topic: [PATCH bpf v2 0/2] bpf: mark registers as safe or unknown in all
 frames
Thread-Index: AQHU+ToMWij5uTUO/kq7EGgsy7auxaZIvSmA
Date:   Mon, 22 Apr 2019 22:07:46 +0000
Message-ID: <58187776-5cce-6a8b-cff1-3b8872c6df8f@fb.com>
References: <cover.1555957346.git.paul.chaignon@orange.com>
In-Reply-To: <cover.1555957346.git.paul.chaignon@orange.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:104:1::31) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:417e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db446085-0c88-455d-a871-08d6c76ef348
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2984;
x-ms-traffictypediagnostic: BYAPR15MB2984:
x-microsoft-antispam-prvs: <BYAPR15MB2984FB289CB64CBAAFC7994ED3220@BYAPR15MB2984.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(54534003)(2201001)(99286004)(76176011)(52116002)(316002)(71190400001)(73956011)(8936002)(31696002)(66476007)(66946007)(86362001)(97736004)(386003)(64756008)(6506007)(53546011)(66556008)(66446008)(2906002)(71200400001)(68736007)(5660300002)(53936002)(81166006)(446003)(81156014)(31686004)(7736002)(305945005)(6246003)(14454004)(186003)(8676002)(2501003)(36756003)(229853002)(6436002)(46003)(478600001)(110136005)(54906003)(4326008)(6512007)(6116002)(11346002)(102836004)(2616005)(476003)(486006)(25786009)(6486002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2984;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SVFmQJw+GR3KJE99mtnXLQJvK/dpHvsKjk/9Py8AkgbVfN3/ttCiTHT0yZG2uCR8IkPHp8QIWeoy+bHgBknEGeT73bRVqZcHXB4UDr3cJZKrmT8Mirk9yjlF5ac8JvEg/TR+LKr/POGe7qg3gkDIv6cuV5vQEdLaidlbiNi1y0ay4FLwsaR8cJfNgaXptMYx2Z571kvSu6/W6wgbDYWk+F7kBTRLlMIIxH5onf7YxQhYE7gq4t09+oym5P6IjCk3EBP7htVjnDz9mxfGLivYGQw2vPblcOt9rzIpl1RghlPaRv0spa/qbB4R3B4sK9LfULxaoBJLfxXmAqDJTaUwxlC4ec6LD0vhOk5PlubFDn7n6MvIUwEJpc8tWockPhjOd23rwCt1ZndXe0TOu0d3n+czV1JARuxxPbggcHWykVM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E3804D1E19C940935E14E36041431C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db446085-0c88-455d-a871-08d6c76ef348
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 22:07:46.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjIvMTkgMTE6MzQgQU0sIFBhdWwgQ2hhaWdub24gd3JvdGU6DQo+IEluIGNhc2Ug
b2YgYSBudWxsIGNoZWNrIG9uIGEgcG9pbnRlciBpbnNpZGUgYSBzdWJwcm9nLCB3ZSBzaG91bGQg
bWFyayBhbGwNCj4gcmVnaXN0ZXJzIHdpdGggdGhpcyBwb2ludGVyIGFzIGVpdGhlciBzYWZlIG9y
IHVua25vd24sIGluIGJvdGggdGhlIGN1cnJlbnQNCj4gYW5kIHByZXZpb3VzIGZyYW1lcy4gIEN1
cnJlbnRseSwgb25seSBzcGlsbGVkIHJlZ2lzdGVycyBhbmQgcmVnaXN0ZXJzIGluDQo+IHRoZSBj
dXJyZW50IGZyYW1lIGFyZSBtYXJrZWQuICBUaGlzIGZpcnN0IHBhdGNoIGFsc28gbWFya3MgcmVn
aXN0ZXJzIGluDQo+IHByZXZpb3VzIGZyYW1lcy4NCj4gDQo+IEEgZ29vZCByZXByb2R1Y2VyIGxv
b2tzIGFzIGZvbGxvdzoNCj4gDQo+IDE6IHB0ciA9IGJwZl9tYXBfbG9va3VwX2VsZW0obWFwLCAm
a2V5KTsNCj4gMjogcmV0ID0gc3VicHJvZyhwdHIpIHsNCj4gMzogICByZXR1cm4gcHRyICE9IE5V
TEw7DQo+IDQ6IH0NCj4gNTogaWYgKHJldCkNCj4gNjogICB2YWx1ZSA9ICpwdHI7DQo+IA0KPiBX
aXRoIHRoZSBhYm92ZSwgdGhlIHZlcmlmaWVyIHdpbGwgY29tcGxhaW4gb24gbGluZSA2IGJlY2F1
c2UgaXQgc2VlcyBwdHINCj4gYXMgbWFwX3ZhbHVlX29yX251bGwgZGVzcGl0ZSB0aGUgbnVsbCBj
aGVjayBpbiBzdWJwcm9nIDEuICBUaGUgc2Vjb25kDQo+IHBhdGNoIGltcGxlbWVudHMgdGhlIGFi
b3ZlIGFzIGEgbmV3IHRlc3QgY2FzZS4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIGZpeGVz
IGFub3RoZXIgcmVzdWx0aW5nIGJ1ZyB3aGVuIHVzaW5nDQo+IGJwZl9za19yZWxlYXNlKCk6DQo+
IA0KPiAxOiBzayA9IGJwZl9za19sb29rdXBfdGNwKC4uLik7DQo+IDI6IHN1YnByb2coc2spIHsN
Cj4gMzogICBpZiAoc2spDQo+IDQ6ICAgICBicGZfc2tfcmVsZWFzZShzayk7DQo+IDU6IH0NCj4g
NjogaWYgKCFzaykNCj4gNzogICByZXR1cm4gMDsNCj4gODogcmV0dXJuIDE7DQo+IA0KPiBJbiB0
aGUgYWJvdmUsIG1hcmtfcHRyX29yX251bGxfcmVncyB3aWxsIHdhcm4gb24gbGluZSA2IGJlY2F1
c2UgaXQgd2lsbA0KPiB0cnkgdG8gZnJlZSB0aGUgcmVmZXJlbmNlIHN0YXRlLCBldmVuIHRob3Vn
aCBpdCB3YXMgYWxyZWFkeSBmcmVlZCBvbg0KPiBsaW5lIDMuDQo+IA0KPiBDaGFuZ2Vsb2dzOg0K
PiAgICBDaGFuZ2VzIGluIHYyOg0KPiAgICAgIC0gRml4IGV4YW1wbGUgY29kZXMgaW4gY29tbWl0
IG1lc3NhZ2UuDQo+IA0KPiBQYXVsIENoYWlnbm9uICgyKToNCj4gICAgYnBmOiBtYXJrIHJlZ2lz
dGVycyBhcyBzYWZlIG9yIHVua25vd24gaW4gYWxsIGZyYW1lcw0KPiAgICBzZWxmdGVzdHMvYnBm
OiB0ZXN0IGNhc2UgZm9yIHBvaW50ZXIgbnVsbCBjaGVjayBpbiBzdWJwcm9nDQo+IA0KPiAgIGtl
cm5lbC9icGYvdmVyaWZpZXIuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKystLS0NCj4g
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdmVyaWZpZXIvY2FsbHMuYyB8IDI1ICsrKysr
KysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpGb3IgdGhlIHNlcmllczoNCiAgIEFja2VkLWJ5OiBZb25naG9uZyBT
b25nIDx5aHNAZmIuY29tPg0K

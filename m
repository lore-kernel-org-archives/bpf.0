Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDABFC10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9051220830
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 16:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mGCo2mCb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="S2k7BILv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfDJQZJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:25:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35636 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729881AbfDJQZJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Apr 2019 12:25:09 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3AGMkZd002316;
        Wed, 10 Apr 2019 09:24:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EdYAT4MgZHUGhd/mkYbpYogUcTA3NTqRLlDXMNz1jtI=;
 b=mGCo2mCbWd+i3SYN1yZtRKpNFOpK0Gu64l4Enpy+1jZDknAoxX+mJzTLSDajgtsFzexL
 ILfbu88RydrHPDIdBbyK6Lh6N0BBKkgq0ocRUK1tPLQ/MOEtSxUXoiNk1ojZn1IfNvxK
 TqRwXHaqjXhOKUyqUiURfMvzT7aOGt6a+Gg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rs3fr3bqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 09:24:48 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 10 Apr 2019 09:24:47 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Apr 2019 09:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdYAT4MgZHUGhd/mkYbpYogUcTA3NTqRLlDXMNz1jtI=;
 b=S2k7BILvzTmGiFGIDiDIZZ8HgRdiACGNn50HZ9RfWlogO2JMBtigb8A2tId14C8LcOCK04vTNRKgobcqXkon2d5CDIzJF4SkzIFfAg3v3Br5TwnK7RrKVexo0Swz093PS8QR+pdSgz57BsuzAcevl40FUihHvNJOGOzPgn9deDA=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3368.namprd15.prod.outlook.com (20.179.58.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 10 Apr 2019 16:24:44 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e%5]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 16:24:44 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] [tools/bpf] fix a few ubsan warning
Thread-Topic: [PATCH bpf-next] [tools/bpf] fix a few ubsan warning
Thread-Index: AQHU7zWk4KrynIz4YkmOlGUv4PMmBKY1B9cAgACNgIA=
Date:   Wed, 10 Apr 2019 16:24:44 +0000
Message-ID: <b4524602-9bc9-f614-f8ee-d0f315fea7b5@fb.com>
References: <20190410003741.1855113-1-yhs@fb.com>
 <48f2792a-e0fa-305e-ff5f-cfe45dbfe82d@iogearbox.net>
In-Reply-To: <48f2792a-e0fa-305e-ff5f-cfe45dbfe82d@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0045.namprd12.prod.outlook.com
 (2603:10b6:301:2::31) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:61dc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dda5b542-d641-4011-c0bd-08d6bdd10aa2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3368;
x-ms-traffictypediagnostic: BYAPR15MB3368:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB3368E42EDE5FD62D141952B2D32E0@BYAPR15MB3368.namprd15.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(396003)(346002)(199004)(189003)(2201001)(229853002)(52116002)(6116002)(316002)(31686004)(110136005)(2906002)(5660300002)(97736004)(6486002)(105586002)(99286004)(6436002)(54906003)(68736007)(106356001)(6306002)(6512007)(8936002)(478600001)(2501003)(25786009)(186003)(7736002)(53936002)(4326008)(386003)(71190400001)(8676002)(81166006)(486006)(86362001)(6246003)(446003)(476003)(71200400001)(966005)(46003)(6506007)(11346002)(2616005)(256004)(14454004)(36756003)(53546011)(31696002)(102836004)(76176011)(305945005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3368;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fkv7BhfjT5lDpfjLoi/3LEIMQKWTKqaj8ah3888sA6c4qm7VRMeSiEInEe2nuNf/WNHUZgePbmpzUtBi8/axhNO7dLbimOX3gHmLW7irkBbMPJxQrX0R9ktrTn/oCgYxPZKWZjUaj1O1d42xRcCsWOTv5YHyym+F8rwubNOtlhwuO4Bzc223fmtJJy6jUYCqPrZpPsoms4hHEQsQZlylKuKUqAJ4sMtI+GrQdHn2ss9SGbgif0VQGaMUOBJxjQZcFq94SWfL4epqu7bTf9zYmQYiRQkjPZcW2YzBcFNmbXqi7pVemwQ8oX6hEcg5YSGH+/Iq4wVlm7kBfd8lIbGGueF6jErflCNhCGIoKMC3UrxYavyuYtVmKd9qx1rZ5tuhymz3Epfu+LgMBjFG8gtMo1blZGUey9m8smGsqb8Ij+k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBB9913F6B89BA4A948819397C938BA0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dda5b542-d641-4011-c0bd-08d6bdd10aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 16:24:44.7409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3368
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMTAvMTkgMTI6NTggQU0sIERhbmllbCBCb3JrbWFubiB3cm90ZToNCj4gT24gMDQv
MTAvMjAxOSAwMjozNyBBTSwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+IFRoZSBpc3N1ZSBpcyBy
ZXBvcnRlZCBhdCBodHRwczovL2dpdGh1Yi5jb20vbGliYnBmL2xpYmJwZi9pc3N1ZXMvMjguDQo+
Pg0KPj4gQmFzaWNhbGx5LCBwZXIgQyBzdGFuZGFyZCwgZm9yDQo+PiAgICB2b2lkICptZW1jcHko
dm9pZCAqZGVzdCwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3QgbikNCj4+IGlmICJkZXN0IiBvciAi
c3JjIiBpcyBOVUxMLCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgIm4iIGlzIDAgb3Igbm90LA0KPj4g
dGhlIHJlc3VsdCBvZiBtZW1jcHkgaXMgdW5kZWZpbmVkLiBjbGFuZyB1YnNhbiByZXBvcnRlZCB0
aHJlZSBzdWNoDQo+PiBpbnN0YW5jZXMgaW4gYnBmLmMgd2l0aCB0aGUgZm9sbG93aW5nIHBhdHRl
cm46DQo+PiAgICBtZW1jcHkoZGVzdCwgMCwgMCkuDQo+Pg0KPj4gQWx0aG91Z2ggaW4gcHJhY3Rp
Y2UsIG5vIGtub3duIGNvbXBpbGVyIHdpbGwgY2F1c2UgaXNzdWVzIHdoZW4NCj4+IGNvcHkgc2l6
ZSBpcyAwLiBMZXQgdXMgc3RpbGwgZml4IHRoZSBpc3N1ZSB0byBzaWxlbmNlIHVic2FuDQo+PiB3
YXJuaW5ncy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29t
Pg0KPiANCj4gQXBwbGllZCwgdGhhbmtzLiBJIGZpeGVkIHVwICRTVUJKRUNUIHdoaWxlIGFwcGx5
aW5nIHRvIGFkZCBhIHN1YnN5c3RlbSBwcmVmaXguDQo+IA0KPj4gLS0tDQo+PiAgIHRvb2xzL2xp
Yi9icGYvYnBmLmMgfCAxOSArKysrKysrKystLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90
b29scy9saWIvYnBmL2JwZi5jIGIvdG9vbHMvbGliL2JwZi9icGYuYw0KPj4gaW5kZXggYTFkYjg2
OWE2ZmRhLi43OGYyNDAwZGQyZDEgMTAwNjQ0DQo+PiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5j
DQo+PiArKysgYi90b29scy9saWIvYnBmL2JwZi5jDQo+PiBAQCAtNzksNyArNzksNiBAQCBzdGF0
aWMgaW5saW5lIGludCBzeXNfYnBmX3Byb2dfbG9hZCh1bmlvbiBicGZfYXR0ciAqYXR0ciwgdW5z
aWduZWQgaW50IHNpemUpDQo+PiAgIA0KPj4gICBpbnQgYnBmX2NyZWF0ZV9tYXBfeGF0dHIoY29u
c3Qgc3RydWN0IGJwZl9jcmVhdGVfbWFwX2F0dHIgKmNyZWF0ZV9hdHRyKQ0KPj4gICB7DQo+PiAt
CV9fdTMyIG5hbWVfbGVuID0gY3JlYXRlX2F0dHItPm5hbWUgPyBzdHJsZW4oY3JlYXRlX2F0dHIt
Pm5hbWUpIDogMDsNCj4+ICAgCXVuaW9uIGJwZl9hdHRyIGF0dHI7DQo+PiAgIA0KPj4gICAJbWVt
c2V0KCZhdHRyLCAnXDAnLCBzaXplb2YoYXR0cikpOw0KPj4gQEAgLTg5LDggKzg4LDkgQEAgaW50
IGJwZl9jcmVhdGVfbWFwX3hhdHRyKGNvbnN0IHN0cnVjdCBicGZfY3JlYXRlX21hcF9hdHRyICpj
cmVhdGVfYXR0cikNCj4+ICAgCWF0dHIudmFsdWVfc2l6ZSA9IGNyZWF0ZV9hdHRyLT52YWx1ZV9z
aXplOw0KPj4gICAJYXR0ci5tYXhfZW50cmllcyA9IGNyZWF0ZV9hdHRyLT5tYXhfZW50cmllczsN
Cj4+ICAgCWF0dHIubWFwX2ZsYWdzID0gY3JlYXRlX2F0dHItPm1hcF9mbGFnczsNCj4+IC0JbWVt
Y3B5KGF0dHIubWFwX25hbWUsIGNyZWF0ZV9hdHRyLT5uYW1lLA0KPj4gLQkgICAgICAgbWluKG5h
bWVfbGVuLCBCUEZfT0JKX05BTUVfTEVOIC0gMSkpOw0KPj4gKwlpZiAoY3JlYXRlX2F0dHItPm5h
bWUpDQo+PiArCQltZW1jcHkoYXR0ci5tYXBfbmFtZSwgY3JlYXRlX2F0dHItPm5hbWUsDQo+PiAr
CQkgICAgICAgbWluKHN0cmxlbihjcmVhdGVfYXR0ci0+bmFtZSksIEJQRl9PQkpfTkFNRV9MRU4g
LSAxKSk7DQo+IA0KPiBBbnkgcmVhc29uIHdlIGRvbid0IHNpbXBsaWZ5IHRoaXMgdG8gdXNlIHN0
cm5jcHkoKSBmb3IgYWxsIHRoZXNlIG9jY3VycmVuY2VzPw0KTm8gcGFydGljdWxhciByZWFzb24s
IGp1c3QgZGlkIG5vdCB0aGluayB0aGF0IGZhciA6LSkNClllcywgc3RybmNweSBpbnN0ZWFkIG9m
IG1lbWNweSBzaG91bGQgd29yayBoZXJlIGFzIHdlbGwuDQoNCj4gDQo+IFRoYW5rcywNCj4gRGFu
aWVsDQo+IA0K

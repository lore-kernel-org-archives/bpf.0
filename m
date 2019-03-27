Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F78C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35125208E4
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I3JMjcz+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aRtUpUHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfC0Fb1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:31:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725780AbfC0Fb1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Mar 2019 01:31:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2R5TVL8006559;
        Tue, 26 Mar 2019 22:31:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=d/id/1NIBeL6Ou0JYv1xINABBHsuhqMf50S1/czRaF4=;
 b=I3JMjcz+5Xkx6lSRgNv+u2d0qJPFqJ+OM/PI3cUtkuK3QZkHraCT0VpUH4QIVIggls6p
 byZ0PZPnOdKT72qXQcxPpaypsYoWdhOHl3Hv8VlPLhaYwT+cAwepCSTFQgIngg+LJEj7
 tfGWwdSIghuSlHQHmK9jw6CfR7ep9caJaMQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rfx6n94ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Mar 2019 22:31:02 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 26 Mar 2019 22:31:02 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 26 Mar 2019 22:31:01 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 26 Mar 2019 22:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/id/1NIBeL6Ou0JYv1xINABBHsuhqMf50S1/czRaF4=;
 b=aRtUpUHKCH7rnzmzVR8lq81zCFJn6sGCutLIN0Av0T/yU9N0ftM4Cb4dnGR7nY59g1siB+kGl08i34UcSN7aJE1eBbHYaKSdW7gy9IBKBhqwe9EunwrE80DJh7j1DpdJiijYlEKr/uqCz9155Q1ZEC1gpUljKcMaCQZUFkG73Zo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3319.namprd15.prod.outlook.com (20.179.58.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 05:30:44 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e%5]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 05:30:44 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Michal Rostecki <mrostecki@opensuse.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Brenden Blanco <bblanco@gmail.com>
Subject: Re: libbpf packaging
Thread-Topic: libbpf packaging
Thread-Index: AQHU4yRKu0OnEJTLWkS6qR49Y01dX6YcmASAgAAlRYCAAAy3gIACLCUA
Date:   Wed, 27 Mar 2019 05:30:44 +0000
Message-ID: <0715b98f-6017-7b9d-61b5-ca08ddd539e5@fb.com>
References: <20190325122134.GA14042@krava>
 <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
 <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
 <20190325172115.i35nfrelzkwqgyoy@workstation>
 <e13f6295-e7ae-80c4-67af-6e8551a375a1@fb.com> <20190325202009.GA14511@krava>
In-Reply-To: <20190325202009.GA14511@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::16f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def3f155-5988-4571-a652-08d6b2755bd3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3319;
x-ms-traffictypediagnostic: BYAPR15MB3319:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR15MB33192B4436374E0BD0C2B294D3580@BYAPR15MB3319.namprd15.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(54906003)(2616005)(76176011)(3480700005)(486006)(102836004)(25786009)(5660300002)(316002)(386003)(52116002)(476003)(446003)(99286004)(86362001)(4326008)(46003)(11346002)(6506007)(71190400001)(106356001)(7736002)(221733001)(71200400001)(6436002)(186003)(8676002)(256004)(14444005)(31696002)(93886005)(31686004)(81166006)(81156014)(6116002)(68736007)(36756003)(105586002)(305945005)(8936002)(6246003)(966005)(229853002)(14454004)(6916009)(6486002)(97736004)(7116003)(478600001)(53936002)(2906002)(6512007)(6306002)(111123002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3319;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: THq74xm5/faW0TRjWT5x1rdwgeFZ3x8Ra1XJXj5yG28TxfraYwWt0vSpPhUjLJWQunuyALtU/VsoNadiVaoI9PQGm2EmhUUYgzTWn7OXwWQUydB8L6LinUqczWtD/OKINQFh4Ez4Z00Hd62ZsoGWf8Qul7l/uQ+1o8AjuvkBLitBXnxj5T8RUWhCQB8V8rSD9FNHqNZY7QhX7pw1844eezjZmikrjdKpNZKU/2fiNCQ1uUJc9ufCd3Uf7JY8a/dY7pr8EfonlwNzRfp5DA5ZZ6xg9l7ruecPX2Rd32L5gD7XyCxmvOP0FdT7pih2CwlKECVSCYG1d1gvdZFi72M2P3+1T1ejPeWWuEJHr7PCgDjwDqe/GYWQ5JJjCtDZP1GzCUN6MXGG1twOpWl0nuiqbMboSOYtrkjEkyR6LVo/iis=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD4855959F619847BCACFF2B21ACF030@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: def3f155-5988-4571-a652-08d6b2755bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 05:30:44.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3319
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SmlyaSwNCg0KPj4+Pj4+IDIpIFRoZXJlJ3MgYWxyZWFkeSBiY2MtZGV2ZWwncyBsaWJicGYgbGli
cmFyeSBwYWNrYWdlZDoNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgJCBycG0gLXFmIC91c3IvbGliNjQv
bGliYnBmLnNvDQo+Pj4+Pj4gICAgICBiY2MtZGV2ZWwtMC44LjAtMS5mYzI4Lng4Nl82NA0KPj4+
Pj4+DQo+Pj4+Pj4gICAgICBzbyB0aGVyZSdzIGEgY29uZmxpY3QuLiBhbnkgY2hhbmNlIHdlIGNv
dWxkIHJlbmFtZSBsaWJicGYgdG8NCj4+Pj4+PiAgICAgIHNvbWV0aGluZyBlbHNlIGxpa2U6DQo+
Pj4+Pj4NCj4+Pj4+PiAgICAgIGxpYmJwZjIuc28NCj4+Pj4+PiAgICAgIGxpYmJwZm9iamVjdC5z
bw0KPj4+Pj4+ICAgICAgbGliYnBmYmVzdC5zbw0KPj4+Pj4+ICAgICAgLi4uPw0KPj4+Pj4NCj4+
Pj4+IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIHJlbmFtZSB0aGUgb2ZmaWNpYWwgbGliYnBmIHBh
Y2thZ2UsIHRoaXMgd2lsbA0KPj4+Pj4ganVzdCBjcmVhdGUgcGxhaW4gY29uZnVzaW9uIGFuZCB3
aWxsIG1ha2UgaXQgbXVjaCBoYXJkZXIgZm9yIHBvdGVudGlhbA0KPj4+Pj4gdXNlcnMgdG8gYWRh
cHQgaW4gdGhlIGxvbmctdGVybSBzaW5jZSB3ZSBhaW0gZm9yIC9ldmVyeW9uZS8gdG8gY29uc3Vt
ZQ0KPj4+Pj4gb2ZmaWNpYWwgbGliYnBmIGxpYnJhcnkgaW5zdGVhZCBvZiBoYWNraW5nIHRoZWly
IG93bi4NCj4+Pj4+DQo+Pj4+PiBJIHRoaW5rIGJjYyBmb2xrcyBhcmUgbWlncmF0aW5nIHRvIG9m
ZmljaWFsIGxpYmJwZiBhcyB3ZWxsLCBhdCBsZWFzdA0KPj4+Pj4gdGhhdCB3YXMgbXkgaW1wcmVz
c2lvbi4gSW1obywgdGhpcyB3b3VsZCBuZWVkIGZpeGluZyBvbiBiY2Mgc2lkZSB0aGVuLg0KPj4+
Pg0KPj4+PiBiY2MgbWlncmF0ZWQgdG8gbGliYnBmIHNvbWUgdGltZSBhZ28uDQo+Pj4NCj4+PiBB
bmQgdGhlIGxpYmJwZi5zbyBmaWxlIHdoaWNoIGlzIGluc3RhbGxlZCB3aXRoIGJjYyBpcyAib3Vy
IiBsaWJicGYuIGJjYw0KPj4+IHNpbXBseSB1c2VzIGxpYmJwZiAoZnJvbSB0aGUgYXV0by1zeW5j
ZWQgc3RhbmRhbG9uZSByZXBvWzBdKSBhcyBhDQo+Pj4gc3VibW9kdWxlWzFdLiBUbyBwYWNrYWdl
IGxpYmJwZiBhbmQgYmNjIHByb3Blcmx5IGluIExpbnV4IGRpc3Ryb3Mgd2UNCj4+PiBuZWVkIGEg
cG9zc2liaWxpdHkgdG8gdXNlIGJjYyB3aXRoIHNoYXJlZCBsaWJicGYgbGlicmFyeSAtIHdoaWNo
DQo+Pj4gcHJvYmFibHkgY2FuIGJlIGFjaGl2ZXZlZCBieSBzbWFsbCBjaGFuZ2UgaW4gYmNjJ3Mg
Q01ha2VMaXN0cy50eHQuDQo+Pg0KPj4gSSB0aGluayB3ZSBzaG91bGQgcmVuYW1lIGJjYyBsaWJi
cGYuc28gdG8gYSBkaWZmZXJlbnQgbmFtZSAobWF5YmUNCj4+IGxpYmJjY19icGYuc28pIHRvIGF2
b2lkIGNvbmZ1c2lvbnMgYmV0d2VlbiBiY2MgbGliYnBmIGFuZCBsaWJicGYgcmVwby4NCj4+IFRo
ZSBiY2MgbGliYnBmLnNvIGlzIGRpZmZlcmVudCBmcm9tIGxpYmJwZiByZXBvIGl0IGNvbnRhaW5z
IHNvbWUgd3JhcHBlcnMuLi4NCj4gDQo+IHRoYXQnZCBiZSBncmVhdCBmaXJzdCBzdGVwLi4gdGhl
biB3ZSBjb3VsZCBhZGQgbGliYnBmDQo+IHBhY2thZ2UgYW5kIG1ha2UgYmNjIGRlcGVuZCBvbiBp
dCBhcyBzdWdnZXN0ZWQgYnkgTWljaGFsDQo+IA0KPj4NCj4+IEkgd2lsbCBwcm9wb3NlIHRvIGlv
dmlzb3IvYmNjIG1haWxpbmcgbGlzdC4NCj4gDQo+IHBsZWFzZSBrZWVwIG1lIGluIGNjIGZvciB0
aGF0DQoNCkRvIG5vdCBrbm93IHlvdXIgZ2l0aHViIG5hbWUsIHNvIG5vdCBhYmxlIHRvIGNjIHlv
dSBvbiB0aGUgYmNjIHB1bGwgDQpyZXF1ZXN0IHdoaWNoIGNoYW5nZXMgbGlicmFyeSBmcm9tIGxp
YmJwZi57YSxzb30gdG8gbGliYmNjX2JwZi57YSxzb30uDQpUaGUgYmVsb3cgaXMgdGhlIGxpbms6
DQogICAgaHR0cHM6Ly9naXRodWIuY29tL2lvdmlzb3IvYmNjL3B1bGwvMjI5MA0KDQo+IA0KPiB0
aGFua3MsDQo+IGppcmthDQo+IA0KPj4NCj4+Pg0KPj4+IFRoZSBzdGFuZGFsb25lIHJlcG9bMF0g
bWlnaHQgYmUgYSBiZXR0ZXIgYmFzZSBmb3IgY3JlYXRpbmcgYSBwYWNrYWdlDQo+Pj4gdGhhbiBm
dWxsIGtlcm5lbCBzb3VyY2VzLiBBbmQgdXNpbmcgJXNvdmVyc2lvbiUrZ2l0JXNoYSUgKGkuZS4N
Cj4+PiAwLjAuMitnaXQzM2IwMTcpIG1pZ2h0IGJlIGEgYmV0dGVyIHZlcnNpb24gcGF0dGVybiBv
ZiB0aGF0IHBhY2thZ2UuDQo+Pj4NCj4+PiBDaGVlcnMsDQo+Pj4gTWljaGFsDQo+Pj4NCj4+PiBb
MF0gaHR0cHM6Ly9naXRodWIuY29tL2xpYmJwZi9saWJicGYNCj4+PiBbMV0gaHR0cHM6Ly9naXRo
dWIuY29tL2lvdmlzb3IvYmNjL2Jsb2IvbWFzdGVyL0NNYWtlTGlzdHMudHh0I0wxMi1MMTYNCj4+
Pg0K

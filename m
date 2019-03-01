Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83218C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351CE2084D
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eL1+/rLC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cH3l3p+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfCAU0N (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:26:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfCAU0N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Mar 2019 15:26:13 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21KF6bQ006314;
        Fri, 1 Mar 2019 12:25:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cbsxTbLX49DmRVVpXMkMU5uk+XFCpWcSekwntI5HzTY=;
 b=eL1+/rLCCv0loMFENY4eOcRDISUtfa0QHoiW0CLgSd6lCq7IwbzH3uhD4wDgF3AdyXc4
 Sx9d79g4nvzk9ve7q8jYgoBXItCrKv+nCAPNUKaq5cOXBYL2sa92tLI8lkD4BRlKLqbK
 KOilK7cYcGAgvMNI1mzExEBYULGFaSGbbqQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qybh181tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Mar 2019 12:25:45 -0800
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 1 Mar 2019 12:25:44 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 1 Mar 2019 12:25:44 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Mar 2019 12:25:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbsxTbLX49DmRVVpXMkMU5uk+XFCpWcSekwntI5HzTY=;
 b=cH3l3p+MmBwy/fRKOz196U7GsaRQhFUjMLae+zZhU1lNAqPju+Rn32YUc3knZMaq4296Wc7set43x8H2fKqDVJGnuzax8hXACK3NlLrLpY2dzcbkYneyzN6cbIZO6Kfu9hWGfYegEyJaPrRv5wgS8rRSWVbJflARVKs4qmI8QJU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3221.namprd15.prod.outlook.com (20.179.56.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 20:25:41 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 20:25:41 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <ast@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
Thread-Topic: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
Thread-Index: AQHUz7wVyvWwKXwnbUuxMyCVCB5fAqX3FN6AgAAKXAD//3ywgIAAiXoAgAACpICAAA0KgIAABVSA
Date:   Fri, 1 Mar 2019 20:25:41 +0000
Message-ID: <0120903c-bef7-51b8-44b8-5f4288a78107@fb.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
 <CAEf4BzYx=05UXSkOpRdKzhXenXJpRYrukgnG7fGjTSR30wLz-Q@mail.gmail.com>
 <e8678d06-20e0-5501-7cff-62de57a2cdf2@fb.com>
 <CAEf4BzZWZmTFj0Xqf+_1QoT5E6tt7ijmzk39khgZ2zYfe0QFUw@mail.gmail.com>
 <e6157f2f-80e4-6a99-2053-498e0581a0db@fb.com>
 <93e20522-cafd-ee1f-1dc1-3cebab122588@iogearbox.net>
In-Reply-To: <93e20522-cafd-ee1f-1dc1-3cebab122588@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:cd24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e65ba89c-09b4-422e-d4a7-08d69e841337
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3221;
x-ms-traffictypediagnostic: BYAPR15MB3221:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3221;20:ndOX6r0tELRdbncPTAkpXPLwUAQHUdHD7gq+dxzIZe3IzqBf5qkTJV3WXWA4t/litbGppRUMNxU9JzWxi44L3pPXgOzaydtxaKE+vE7FyA/spOjsDgUuVoYGGz4tJZlcf/Nt71z23pUcQrJiNQJKUxbr7pFaggUGGmzrfb8QER8=
x-microsoft-antispam-prvs: <BYAPR15MB3221F276A5D8EB02C1B531CFD3760@BYAPR15MB3221.namprd15.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(478600001)(6436002)(14454004)(68736007)(106356001)(105586002)(186003)(316002)(6486002)(229853002)(6512007)(8936002)(36756003)(6116002)(71200400001)(81166006)(81156014)(8676002)(31686004)(71190400001)(93886005)(5660300002)(7736002)(97736004)(305945005)(99286004)(476003)(256004)(2616005)(54906003)(11346002)(86362001)(31696002)(25786009)(102836004)(486006)(53936002)(4326008)(6246003)(53546011)(386003)(6506007)(446003)(110136005)(2906002)(46003)(52116002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3221;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hRqpVVqZjFfloPNrQ4QpXcMEir3bpGBm0mK6bdIKD7pvi1po7Qm+xjeN6oNm3OZEc9xPrA15ZiOuk5BN8MYkIUTNoA4irBqpzm2umf0HK16IQPuESk7VxpujimE7o3Cw2GYbs3IIi6+VLWGuiCoBPpKcXnEUq1BkK8CwxdCHRxrSlOslEm7Kdq/7YExMjwWp7wjdLv4THXJCA9QF8UOzVbtHtY5arHfyXLS5D7H5lcE0HBjn3eBuQhcxcNkbQIr9fYs7NICmst/GiN5NGDjjfk3KFX1v/g8fwgmf/njcVHnFGFEuj+lbDfNXTvRw5SVnTUPjm4880jTY09/spxrBNL4tGMyWcf/jsUnyR9ksUDfa/2rUrQsv+6MjYqrfjtd/A5Eds/DPimj2KSU55514FtOoLvHO0yQ8bukFeqK5ljE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5A804A57E8A9546B541619A9E5CBB36@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e65ba89c-09b4-422e-d4a7-08d69e841337
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 20:25:41.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMS8xOSAxMjowNiBQTSwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPiBPbiAwMy8w
MS8yMDE5IDA4OjE5IFBNLCBZb25naG9uZyBTb25nIHdyb3RlOg0KPj4gT24gMy8xLzE5IDExOjEw
IEFNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+Pj4gT24gRnJpLCBNYXIgMSwgMjAxOSBhdCAx
MDo1OCBBTSBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPiB3cm90ZToNCj4+Pj4gT24gMy8xLzE5
IDEwOjQ4IEFNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+Pj4+PiBPbiBGcmksIE1hciAxLCAy
MDE5IGF0IDEwOjMxIEFNIFlvbmdob25nIFNvbmcgPHloc0BmYi5jb20+IHdyb3RlOg0KPj4+Pj4+
IE9uIDIvMjgvMTkgMzoxOCBQTSwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPiBbLi4uXQ0KPj4+
Pj4gV291bGQgaXQgYmUgcmVhc29uYWJsZSB0byBqdXN0IHBsYWluIGRpc2FibGUgdXNhZ2Ugb2Yg
dW5pbml0aWFsaXplZA0KPj4+Pj4gZ2xvYmFsIHZhcmlhYmxlcywgYXMgaXQga2luZCBvZiBnb2Vz
IGFnYWluc3QgQlBGJ3MgcGhpbG9zb3BoeSB0aGF0DQo+Pj4+PiBldmVyeXRoaW5nIHNob3VsZCBi
ZSB3cml0dGVuIHRvLCBiZWZvcmUgY2FuIGJlIHJlYWQ/IFNvIHdoaWxlIHdlIGNhbg0KPj4+Pj4g
anVzdCBpbXBsaWNpdGx5IHplcm8tb3V0IGV2ZXJ5dGhpbmcgYmVmb3JlaGFuZCwgaXQgbWlnaHQg
YmUgYSBnb29kDQo+Pj4+PiBpZGVhIHRvIHJlbWluZCBhbmQgZW5mb3JjZSB0aGF0IGV4cGxpY3Rs
eT8NCj4+Pj4NCj4+Pj4gVGhlcmUgd2lsbCBiZSBhIHZlcmlmaWVyIGVycm9yLCBzbyB0aGUgcHJv
Z3JhbSB3aXRoICJpbnQgZyIgd2lsbCBub3QNCj4+Pj4gcnVuLCB0aGUgc2FtZSBhcyB0b2RheS4N
Cj4+Pg0KPj4+IFllYWgsIEkgdW5kZXJzdGFuZCwgYnV0IHdpdGggcHJldHR5IG9ic2N1cmUgZXJy
b3IgYWJvdXQgbm90IHN1cHBvcnRpbmcNCj4+PiByZWxvY2F0aW9ucyBhbmQgc3R1ZmYsIHJpZ2h0
Pw0KPj4+DQo+Pj4+DQo+Pj4+IFdlIGNvdWxkIGltcHJvdmUgYnkgZmxhZ2dpbmcgdGhlIGVycm9y
IGF0IGNvbXBpbGVyIGVycm9yIG9yIGxpYmJwZiB0aW1lLg0KPj4+DQo+Pj4gU28gdGhhdCdzIG15
IHBvaW50LCB0aGF0IGhhdmluZyBjb21waWxlciBlbWl0IG5pY2VyIGVycm9yIGZvcg0KPj4+IHRh
cmdldD1icGYgd291bGQgYmUgbmljZSB0b3VjaCB0byB1c2VyIGV4cGVyaWVuY2UgOikNCj4+DQo+
PiBJIGp1c3QgcmVtb3ZlZCBhIGNvbXBpbGVyIGVycm9yIGZvciBzdGF0aWMgdmFyaWFibGVzLi4u
DQo+Pg0KPj4gSSB3aWxsIHdhaXQgZm9yIHRoaXMgcGF0Y2ggbGFuZHMsIGhlYXIgcGVvcGxlIGNv
bXBsYWlucyAoZWl0aGVyIG5lZWQgdG8NCj4+IHN1cHBvcnQgImludCBnOyIgb3IgbmVlZCBiZXR0
ZXIgZXJyb3IgbWVzc2FnZXMsIGV0Yy4pIGFuZCB0aGVuIGRlY2lkZQ0KPj4gd2hhdCBuZXh0IHRv
IGRvIC4uLg0KPiANCj4gQnkgdGhlIHdheSwgZnJvbSBMTFZNIHNpZGUsIGRvIHlvdSB0aGluayBp
dCBtYWtlcyBzZW5zZSBmb3IgbG9jYWwgdmFycw0KPiB3aGVyZSB5b3UgZW5jb2RlIHRoZSBvZmZz
ZXQgaW50byBpbnNuLT5pbW0gdG8gYWxyZWFkeSBlbmNvZGUgaXQgaW50bw0KPiAoaW5zbisxKS0+
aW1tIG9mIHRoZSBsZGltbTY0LCBzbyB0aGF0IGxvYWRlcnMgY2FuIGp1c3QgcGFzcyB0aGlzIG9m
ZnNldA0KPiB0aHJvdWdoIGluc3RlYWQgb2YgZml4aW5nIGl0IHVwIGxpa2UgSSBkaWQ/IEknbSBm
aW5lIGVpdGhlciB3YXkgdGhvdWdoLA0KPiBqdXN0IHRob3VnaHQgbWlnaHQgYmUgd29ydGggcG9p
bnRpbmcgb3V0IHdoaWxlIHdlJ3JlIGF0IGl0LiA6KQ0KDQpZZXMsIGxsdm0gY2FuIGRvIHRoYXQu
IExldCBtZSBwcm90b3R5cGUgaXQgYW5kIHdpbGwgbGV0IHlvdSBrbm93DQppZiBpdCBsYW5kZWQg
aW4gbGx2bSB0cnVuay4NCg0KPiANCj4gVGhhbmtzLA0KPiBEYW5pZWwNCj4gDQo=

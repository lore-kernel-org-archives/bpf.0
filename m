Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDAC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAD02084F
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UK8NweoJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="K10+sEKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCATYq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:24:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34150 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfCATYq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Mar 2019 14:24:46 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21JOE6m029855;
        Fri, 1 Mar 2019 11:24:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qT4Cpo70NLaqMjeazzR2/noThniB+d0pqVopgXYbWKs=;
 b=UK8NweoJXz2qLSiC+NDeofJXDjcsNPINEzwqdQCcyULjCkZRfsFPnRQ3S8xdIN3X2khN
 3JHk8i04x4a8Vmj2E8TLwkbscKXt6Vt5LO4FC1RZhsqWj/N4j/TIfSG3zvZyX2f9uGpF
 M4mu71cqFPlkuKL9jxHc5J2bX1Vpmk+f4u8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qya3fg7nq-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Mar 2019 11:24:24 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 1 Mar 2019 11:23:46 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Mar 2019 11:23:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT4Cpo70NLaqMjeazzR2/noThniB+d0pqVopgXYbWKs=;
 b=K10+sEKZwgD7IAGUxjpw85V6L/wLR505OoUAxXT2R5q5dsl0PSsyIGAUWpbakuwQw/3im8vWOdGslxsI3jCnvFONwH8RfQnup6gao5+LAmIvsxcn6MwqYg0oHoAdljyQ2+lT2qzbveJcT3ibUfbIFbz4rKfoX2cifxupiqgvLB0=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2518.namprd15.prod.outlook.com (20.179.154.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Fri, 1 Mar 2019 19:23:45 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 19:23:45 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next 2/4] bpf/verifier: fix code formatting
Thread-Topic: [PATCH bpf-next 2/4] bpf/verifier: fix code formatting
Thread-Index: AQHUz89ZGr+Z5gvnRkWe54ut05Ad/aX3KO4A
Date:   Fri, 1 Mar 2019 19:23:44 +0000
Message-ID: <fda23d5e-6de3-ab2f-107c-8abc1abaaef8@fb.com>
References: <20190301013716.1370014-1-andriin@fb.com>
 <20190301013716.1370014-3-andriin@fb.com>
In-Reply-To: <20190301013716.1370014-3-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::4eb5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1f2f5e-55c4-4403-cad4-08d69e7b6aab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2518;
x-ms-traffictypediagnostic: BYAPR15MB2518:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2518;20:bSF4ZGClByTHWXDq1XhHIRcoHWXpz8CI0tuoZkxm87kBpgrm59xg0oSAstjjWnuOczsvummssu4c2mFK6yaB9mIHmRstRs8lAYhPxR40Wz4L2C4IJzRGe2TzstzU4HgR8zM9KErfKw13TOM4DZESH5u/ZbXEs/wrtZNkyrsNhGk=
x-microsoft-antispam-prvs: <BYAPR15MB2518AB1C0D2FA9E322CAA792D7760@BYAPR15MB2518.namprd15.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(51444003)(52116002)(6436002)(4744005)(8676002)(6116002)(81166006)(6486002)(11346002)(446003)(53936002)(46003)(81156014)(14454004)(229853002)(8936002)(97736004)(5660300002)(102836004)(6512007)(53546011)(386003)(6506007)(71200400001)(76176011)(476003)(31696002)(2616005)(99286004)(2906002)(86362001)(68736007)(71190400001)(2201001)(316002)(110136005)(31686004)(7736002)(6246003)(106356001)(256004)(2501003)(105586002)(478600001)(305945005)(486006)(186003)(6636002)(25786009)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2518;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xKvNmE1wFef8XloezVa401zJkMvrutA/8aB7ILyuOA66U+xEwww+jjyH7v7ZMhpepGd02hHJFtyVj6N4koIwkXoqzAkJ+Uo/wYcNFrDFFWd5TA8NNdVHCQAe+Ig/GyyQAe6NgviI63YAZic0iHpEkctdh+DBL2bq3yFZ/2ZTpcjAK4T1dzwOCOlzg5wBTGEDZDDjVBhD1Csljtf6aP7FHXiL8O0lRQeKNYC1OnWOdqulLqlHuOxqAyJhE8+4sS2qp286QqN3JkV9Fwmo13SeuIwVn7TDtl4PuIjRMGfPQvzda/R6rIwRii3Hfft9/gfJLj/Egal0oUrhu4qA8179877p0oW21/qB2udbEKAHP3ld0brLsFyNjiwtTknHzCzJSSPF6vSuGpKanznlJYshO9I0WbVU3vhVckDyIOP+aGU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADDBD342E6EF2F4EA3E5D20EA72128D8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1f2f5e-55c4-4403-cad4-08d69e7b6aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 19:23:44.8788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2518
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8yOC8xOSA1OjM3IFBNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+IC0jZGVmaW5lIFJF
QUxMT0NfU1RBVEVfRk4oTkFNRSwgQ09VTlQsIEZJRUxELCBTSVpFKQkJCVwNCj4gLXN0YXRpYyBp
bnQgcmVhbGxvY18jI05BTUUjI19zdGF0ZShzdHJ1Y3QgYnBmX2Z1bmNfc3RhdGUgKnN0YXRlLCBp
bnQgc2l6ZSwgXA0KPiAtCQkJCSAgYm9vbCBjb3B5X29sZCkJCQlcDQo+IC17CQkJCQkJCQkJXA0K
PiAtCXUzMiBvbGRfc2l6ZSA9IHN0YXRlLT5DT1VOVDsJCQkJCVwNCj4gLQlzdHJ1Y3QgYnBmXyMj
TkFNRSMjX3N0YXRlICpuZXdfIyNGSUVMRDsJCQkJXA0KPiAtCWludCBzbG90ID0gc2l6ZSAvIFNJ
WkU7CQkJCQkJXA0KPiAtCQkJCQkJCQkJXA0KPiAtCWlmIChzaXplIDw9IG9sZF9zaXplIHx8ICFz
aXplKSB7CQkJCVwNCj4gLQkJaWYgKGNvcHlfb2xkKQkJCQkJCVwNCj4gLQkJCXJldHVybiAwOwkJ
CQkJXA0KPiAtCQlzdGF0ZS0+Q09VTlQgPSBzbG90ICogU0laRTsJCQkJXA0KPiAtCQlpZiAoIXNp
emUgJiYgb2xkX3NpemUpIHsJCQkJXA0KPiAtCQkJa2ZyZWUoc3RhdGUtPkZJRUxEKTsJCQkJXA0K
PiAtCQkJc3RhdGUtPkZJRUxEID0gTlVMTDsJCQkJXA0KPiAtCQl9CQkJCQkJCVwNCj4gLQkJcmV0
dXJuIDA7CQkJCQkJXA0KPiAtCX0JCQkJCQkJCVwNCj4gKyNkZWZpbmUgUkVBTExPQ19TVEFURV9G
TihOQU1FLCBDT1VOVCwgRklFTEQsIFNJWkUpCQkJICAgICBcDQo+ICtzdGF0aWMgaW50IHJlYWxs
b2NfIyNOQU1FIyNfc3RhdGUoc3RydWN0IGJwZl9mdW5jX3N0YXRlICpzdGF0ZSwgaW50IHNpemUs
ICAgIFwNCj4gKwkJCQkgIGJvb2wgY29weV9vbGQpCQkJICAgICBcDQo+ICt7CQkJCQkJCQkJICAg
ICBcDQo+ICsJdTMyIG9sZF9zaXplID0gc3RhdGUtPkNPVU5UOwkJCQkJICAgICBcDQoNCndoYXQg
aXMgdGhlIGNoYW5nZSBoZXJlPw0KZXh0cmEgdGFiIGF0IHRoZSBlbmQgb2YgZXZlcnkgbGluZT8N
CkkgdGhpbmsgdGhhdCBhZGRzIHRvbyBtdWNoIG5vaXNlIHRvIGdpdCBoaXN0b3J5Lg0KSSdkIHJh
dGhlciBrZWVwIHRoaXMgYml0IGFzLWlzLg0KDQoNCg==

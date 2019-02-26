Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D21C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 05:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272AE2147C
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 05:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nITwiHk0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NbHjdPHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfBZFpE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:45:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfBZFpE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Feb 2019 00:45:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q5fVrN001490;
        Mon, 25 Feb 2019 21:45:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tbbdLyyk1RD6KFRC7jn0JvbL3HAk3RIJwZX+sXjYWhA=;
 b=nITwiHk0fbAyZHaKvsPDE6UFIfdOqjnOlfituprNza2uYgDw0+Yi0XD+4MDJx8epA3sx
 w2MnomNd+BrFr1I/OvlkfRpCVoP+VftSrHBKhM/xKemfle6Mv+7KeTXiBuxecrMp9EjC
 WTrS5CU47n9+zuB5x3osIFBmlu6bJlQbUbw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvvbyrg1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 21:45:02 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 21:45:00 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 25 Feb 2019 21:45:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbbdLyyk1RD6KFRC7jn0JvbL3HAk3RIJwZX+sXjYWhA=;
 b=NbHjdPHjuZLt/M2KDUqSzRIYiHJmFT7Sm4qIROFfJ0tV8nsnsA4UDtEIdLdaqQ7F8RfL0qhtPOPm1SlqAs6Yb7pjo7tpG7XzDxMdNszZ4dvnRWtQonYIPbR7ZzmFimZW9+HG0BszbDIJpRT4f06UgHjuG90H7aUJCllitd8OEzo=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3461.namprd15.prod.outlook.com (20.179.59.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 05:44:59 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 05:44:59 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
Thread-Topic: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling
 of bitfields in btf_loader
Thread-Index: AQHUyV7upVyFXX+oVE6CV1aVhOpfhaXsYe2AgAAWrACABDu5gIAAMYCAgAAL64CAAAc8AIAAC/2AgAAMw4CAAIZWAIAAAgEA
Date:   Tue, 26 Feb 2019 05:44:59 +0000
Message-ID: <27cb8cbf-ad66-7be7-452b-b0d7a6fcddd6@fb.com>
References: <20190220205732.2514975-1-andriin@fb.com>
 <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org>
 <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
 <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com>
In-Reply-To: <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:701d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d484a9a-f0f9-4feb-e32a-08d69bad8b08
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3461;
x-ms-traffictypediagnostic: BYAPR15MB3461:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3461;20:Cj8TDopDZJheQ0mFED8JbLQs7SVYMYq45wdCqmmTrYEs5AaPDgQ9aWMIH+zuFkrSOvhKpbNeAqolm3DAaku8GxSz/gL//J/9l53PqPQd3wnIaG2Nq7HVa5dZtJVP/TgcKflf0Xa5ua4DMY/XrFSJFAwwrawIFVndZcyiR7qyVG0=
x-microsoft-antispam-prvs: <BYAPR15MB3461782CF861569B386DFDEBD77B0@BYAPR15MB3461.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(6506007)(6486002)(386003)(53546011)(46003)(316002)(110136005)(478600001)(54906003)(71200400001)(97736004)(36756003)(71190400001)(68736007)(52116002)(6436002)(76176011)(446003)(99286004)(11346002)(93886005)(31686004)(8676002)(6116002)(81156014)(81166006)(4326008)(6512007)(229853002)(186003)(256004)(25786009)(31696002)(7736002)(305945005)(8936002)(486006)(5660300002)(14454004)(106356001)(476003)(102836004)(53936002)(86362001)(105586002)(2616005)(6246003)(2906002)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3461;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5mPdxkxzLmDRgS+XQSuwy0/viWdpSWs0ng3ahiEUGW6VGV6Tqg8DJf7EKlJ3mnpv8y1t+WZH1vq4oCk2J1eYy62QGqccyKHPWafHEVSln3mZnRDbxuM9Tp4gsOIS522kr9HXpmdFE4D1UpUsvdCxzBBOYv6XF2wYeypC7aPhpcVX0gFH58YucEM6ld3VqCf7GT4iUkI9IzoIfs/peoh/MR8UwfnF1l2/w1FeErEdhnghiarBTx0wpZmygQSPOIAfkzmbindiNLH0b+8t0/1AF/HXcFIXxjDWtYCz1Trdt4Z/JJoLjU8fQDHX3Q2/IB3bxt5FXP9MVXFT17UvmCUnTs+hmO+o5LpMbF4ggLqrH0rAUP7mqyZIYjX6WKPdxGLTKdzXkcQdgQfeOGxLBFwe94wQZzKpISpb5kaTrg399ZM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BD192DD439E1346BDFB573E0D7C53AF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d484a9a-f0f9-4feb-e32a-08d69bad8b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 05:44:58.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8yNS8xOSA5OjM3IFBNLCBZb25naG9uZyBTb25nIHdyb3RlOg0KPiBJIGFtIG5vdCAxMDAl
IHN1cmUgd2hldGhlciBwYWhvbGUgZHdhcmYvYnRmIHBhcml0eSBpcyBjb25zaWRlcmVkDQo+IGFz
IGEgc3Ryb25nIHJlYXNvbiB0byBhZGQgZmxvYXRpbmcgcG9pbnQgdHlwZSBzdXBwb3J0IGluIEJU
RiBvciBub3QuDQoNCkkgd291bGRuJ3QgYWRkIGZsb2F0aW5nIHBvaW50IHRvIEJURiB5ZXQuDQpC
VEYgaXMgbm90IHRyeWluZyB0byByZXBsYWNlIGR3YXJmLg0KTGV0J3MgbWFrZSBpdCB3b3JraW5n
IHdlbGwgZm9yIEJQRiB1c2UgY2FzZXMgZmlyc3QuDQo=

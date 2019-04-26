Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F2DC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A6D2077B
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VA5+PPyA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f4ATavkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfDZSG5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:06:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbfDZSG5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 14:06:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3QHlooY017494;
        Fri, 26 Apr 2019 11:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Uizf9SH8m0q08rmUlSmwACyVLIm56M7Kfy/BkHN1OoA=;
 b=VA5+PPyAfV+4L0Z5mJGrBgKzjeDPpbSVtT50JKxdoZgDso+sXBo6rHCkCiu1x3MC2pFC
 OF1iWdT/XR8SSwC6uNMjx5Rorh8z60DkJi60fRrmgHRGzfgPWtTcv7A23wlPHbaytSFK
 2zlmDC9L0KAqlnMHvqLLfywXifIydzryD7A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2s3bspnc73-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Apr 2019 11:06:37 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 11:06:17 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 11:06:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uizf9SH8m0q08rmUlSmwACyVLIm56M7Kfy/BkHN1OoA=;
 b=f4ATavkGR8C2QOFNXw309Asz+ifPOtRfqgSP3EzDqF8/29/4B88t8qLjvNKWsIxZ4ReDKv0jzdqPmrE0ugvnYVJDWo7MfXCnBdhmwdHnzvS2M9dleGADrQzUHUUeA+5aoqk3+4SSocNVHGY5DJ9ThuZaokQYp6NTrsUk3w7lWEI=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2454.namprd15.prod.outlook.com (52.135.198.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Fri, 26 Apr 2019 18:06:14 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 18:06:14 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 4/6] bpf: Add verifier tests for the
 bpf_sk_storage
Thread-Topic: [PATCH v3 bpf-next 4/6] bpf: Add verifier tests for the
 bpf_sk_storage
Thread-Index: AQHU/FMr9dgdkmRaKE6CSwTWVEdMv6ZOvM+A
Date:   Fri, 26 Apr 2019 18:06:14 +0000
Message-ID: <5b3c7741-bcbc-1db8-1ef0-f991c130549e@fb.com>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171110.62344-1-kafai@fb.com>
In-Reply-To: <20190426171110.62344-1-kafai@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:907:1::42) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:9790]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315c0c82-4e87-4fb4-df28-08d6ca71decd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2454;
x-ms-traffictypediagnostic: BYAPR15MB2454:
x-microsoft-antispam-prvs: <BYAPR15MB245426B6561181BB0F150A09D33E0@BYAPR15MB2454.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(46003)(6436002)(14444005)(53936002)(52116002)(66446008)(229853002)(66946007)(86362001)(7736002)(305945005)(64756008)(186003)(73956011)(66476007)(256004)(486006)(5660300002)(4744005)(31696002)(66556008)(71190400001)(71200400001)(53546011)(6506007)(386003)(6486002)(68736007)(102836004)(2906002)(110136005)(2501003)(14454004)(8936002)(478600001)(2201001)(25786009)(316002)(54906003)(4326008)(36756003)(81156014)(81166006)(476003)(31686004)(2616005)(446003)(97736004)(8676002)(11346002)(6246003)(6116002)(76176011)(6512007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2454;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jgWsRD+n7kVzB+VtBtgg/VucP9cUYLLbcjscOReAYEGib/x2QgF3p93uvnigOC9xlcG2fHg5N+JpupU9LMGcYGPW6XjRVDPJOzbTOzfHl9n7UiYNwuRvFBkq6zC4mbHXQ7GT28lnbhxlkopD1F8/McBknq94hfv2+lYWNIL32K2LAVy4Nfk4fr11vX9OX9JCb2WUi14x0qVOoFyPBcxKnTMB5o/n4SBpwScVuuTWURim229C8IVTPhgM5IrNoRR9+GtWDREWnulJeXY/BnL5v2z4JJXQ2mQoL/YFk/fQRXOjYyjiIcetIxtwPa622EgZPcdT5IKqXfy23gEmdNepG/pYcrMFkcznP6pp3gsivHNDHIpDLiFHL3dCwYcKiRJ/3dkA/aQxhRbuOYtrfybOUTQVG/zOEyAMW27k/2EAEzE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2BF1A89F8BE6E4AA88EA598ABFB3854@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 315c0c82-4e87-4fb4-df28-08d6ca71decd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 18:06:14.2846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2454
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=693 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260122
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjYvMTkgMTA6MTEgQU0sIE1hcnRpbiBLYUZhaSBMYXUgd3JvdGU6DQo+IFRoaXMg
cGF0Y2ggYWRkcyB2ZXJpZmllciB0ZXN0cyBmb3IgdGhlIGJwZl9za19zdG9yYWdlOg0KPiAxLiBB
UkdfUFRSX1RPX01BUF9WQUxVRV9PUl9OVUxMDQo+IDIuIE1hcCBhbmQgaGVscGVyIGNvbXBhdGli
aWxpdHkgKGUuZy4gZGlzYWxsb3cgYnBmX21hcF9sb29va3VwX2VsZW0pDQo+IA0KPiBJdCBhbHNv
IHRha2VzIHRoaXMgY2hhbmNlIHRvIHJlbW92ZSB0aGUgdW51c2VkIHN0cnVjdCBidGZfcmF3X2Rh
dGEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gS2FGYWkgTGF1IDxrYWZhaUBmYi5jb20+
DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0K

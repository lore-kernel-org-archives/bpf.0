Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94995C4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A672171F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="B+fGdxPb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iY7OlHDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDDFKO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:10:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbfDDFKN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Apr 2019 01:10:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3458vJ7018056;
        Wed, 3 Apr 2019 22:09:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h4fZ+sGJCeAqxQ4WAwbUYppyHosFpRDGK4+Yb0f1lAM=;
 b=B+fGdxPbbpw3/LRkwD3kJFWP94i/Br48dXUuiyXu4g0g2l3TK89ijPJsWCvHjYaKrYbv
 rPDqcUSewRc1cPqIfcy2ZRKYiqaBQcvBmBgG5C5iOeGTvIHLntQ45EDWwVwwdwVc9jw/
 pWhdAN9iS5Lh9Xvc7Y8sA10rEKKB0NkzZSk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rn6gggsre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 22:09:48 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 22:09:46 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 22:09:46 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 22:09:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4fZ+sGJCeAqxQ4WAwbUYppyHosFpRDGK4+Yb0f1lAM=;
 b=iY7OlHDvktz4k0LaE2bJ3t5gQXa2BPhcW6swc0xHd1sva1vamNd8vvT5Ek1GwwOJ64tsBjJYu3YrKUO8cSxTFYL0KWvbbOZN1ypQd6U9/yL7ftSp5Qqgnv5EMc+nqfrBwoUjPlFO2LWplwXU9Y74ZW8A8ry74FQXh+g7nAkiESY=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Thu, 4 Apr 2019 05:09:44 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 05:09:44 +0000
From:   Martin Lau <kafai@fb.com>
To:     Peter Oskolkov <posk@google.com>, David Ahern <dsahern@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
Thread-Topic: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
Thread-Index: AQHU6jQVEG5oFTqj1EGXfFdYfUswM6YrdM+A
Date:   Thu, 4 Apr 2019 05:09:44 +0000
Message-ID: <20190404050941.w3fegqpm4kmyx3n5@kafai-mbp.dhcp.thefacebook.com>
References: <20190403154338.29990-1-posk@google.com>
In-Reply-To: <20190403154338.29990-1-posk@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:301:1::29) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6309f878-dd64-418c-ca78-08d6b8bbc035
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1278;
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-microsoft-antispam-prvs: <MWHPR15MB1278EA6B314FE11C2AEBB0ADD5500@MWHPR15MB1278.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(54906003)(46003)(558084003)(25786009)(446003)(71200400001)(476003)(186003)(486006)(76176011)(2906002)(86362001)(6506007)(52116002)(8676002)(386003)(256004)(1076003)(11346002)(102836004)(71190400001)(229853002)(81156014)(6512007)(6486002)(6436002)(110136005)(5660300002)(316002)(6246003)(68736007)(99286004)(14454004)(97736004)(478600001)(4326008)(53936002)(305945005)(81166006)(105586002)(6116002)(106356001)(9686003)(8936002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XoKQkj8g9gZ2t/I2piBWo4ayIvDS0TRic90TlIj9TNfy8VbuhuW3I/4rgdXAM3+5B6UPqWh+Wp2bXfQGHmk591ktp9NFKOdBDwnipciAI5lfgG+ar8qqJRLknd4XkN8qdvNoREc946BvLh3TxJxZVVBTNGqq05j7Rj4IaetFJLHsa4fZWWZLIDsUwo2e5EIpU9LdV9G/efQLhauJLYXA7qjaB0mqQoQPTuXJohwrCAmsd+ifx0SmsGSVv5a8c+5I6wlYe9EOWbrTP7HF2Cfw7HVPdxcUuUpZNuunMeXVOpkLz+2OCBQ2hcO0k2Fyib/1shPdStHGZZR97SaD3veFukEC9TOBmlmE9npJy1QpbQ3HRF8icMo9rbDujyzh1btkBFQpp18iJEkJqcRQ38fQNi90aZ+f21A4I0JAlV0GAec=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <241367A574C36442B1B0F117AE0102C8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6309f878-dd64-418c-ca78-08d6b8bbc035
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 05:09:44.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 03, 2019 at 08:43:38AM -0700, Peter Oskolkov wrote:
> This patch adds tests validating that VRF and BPF-LWT
> encap work together well, as requested by David Ahern.
LGTM.  David Ahern, please review also.

Acked-by: Martin KaFai Lau <kafai@fb.com>

Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE0C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A4B218B0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mx0BppkP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aO6/NozW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfB1Tat (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:30:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfB1Tat (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 14:30:49 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SJLOne030326;
        Thu, 28 Feb 2019 11:30:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=AwTaR+sf9pnXDvHM/k/7mlZqS/qum5IzMt4tMIPL35o=;
 b=mx0BppkPljiQ10ne0TPb7kGUGdvA/eeyuRUyDvVvf3naLGG8uPpf0k6y1Rumj/J8/iEV
 YPwz7ifCjw9+6RFcwJbRSxESfSnxwNEoDXOQQk4/2bRdOQ/OcWJgn3mWHC2ghR1+73Yd
 ypwFZgvNw9TWRTjSSAv/+BwBscIEAGWbykQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxjqt8t6c-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:30:24 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 11:29:49 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 11:29:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwTaR+sf9pnXDvHM/k/7mlZqS/qum5IzMt4tMIPL35o=;
 b=aO6/NozWi92m0VhEOWNHvAiNOMht6jmUoNmuOtlZ5d4iWo7uwe5tl/f2jCVz3rs8tK49RjZQN0dicKiQ3T7z3+5mNYE5tYmEiKJcQ5N8x0AMzT8MRW7X90UtIKlYQMhEMJedVi/+eXr2nLu3TxlG2X5lSQyeJYsVasg4rOZwkUM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1406.namprd15.prod.outlook.com (10.173.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 19:29:48 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 19:29:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v3] tools/libbpf: signedness bug in btf_dedup_ref_type()
Thread-Topic: [PATCH v3] tools/libbpf: signedness bug in btf_dedup_ref_type()
Thread-Index: AQHUz5BttK5XRPhzqkC4Wc7YSa57/6X1mMyA
Date:   Thu, 28 Feb 2019 19:29:47 +0000
Message-ID: <8716067D-5904-41A6-8337-E653D8597F21@fb.com>
References: <20190228180647.GF9806@kadam>
In-Reply-To: <20190228180647.GF9806@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::45c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea783a67-79b8-4cba-3aa0-08d69db31a0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1406;
x-ms-traffictypediagnostic: MWHPR15MB1406:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1406;20:v/4qcrv/MSbuaVnpA0hWbDDqrZX2QtF8nEVtChVG7FbMrn0m5BFb864LfjsXkXrxOHBhiWPm5B+WF4muuk2JZ8wQrP1/VOQ5pvCJF8ZCSZhp1+EvvxvQam8vHSasZWxZYa6/7I/1nWKTyn55K41D5lv1K3ErNCh0cAJle9NCkkY=
x-microsoft-antispam-prvs: <MWHPR15MB14061F365FC3F8C4648B1E41B3750@MWHPR15MB1406.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(6512007)(6116002)(71200400001)(106356001)(97736004)(99286004)(256004)(2906002)(6486002)(68736007)(71190400001)(8676002)(83716004)(57306001)(305945005)(82746002)(53936002)(25786009)(54906003)(316002)(86362001)(50226002)(36756003)(7736002)(76176011)(105586002)(229853002)(478600001)(446003)(14454004)(476003)(186003)(486006)(6246003)(102836004)(53546011)(6506007)(6916009)(81166006)(6436002)(5660300002)(8936002)(4326008)(81156014)(11346002)(33656002)(2616005)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1406;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T235V/mbUsCDAVYYfUHguiH5v5mWZ9SZu1njv/yc+LVnls9XJnv1m4sCZA49lHLJBjzpIiUMgPG1lnDcb4A5s+2a6PIXdiega3D+lvVRoaS6rKeqETxGveBe54bes4iN25DzmWe13i9xeBFzgeBVxertkY4V8kTRDPx00AXHEoGDN+C1NZeo9oXeQr3KwZBcXry9ugY82kkggvkis6SKqrQHRaaD2ud/zfh+94O6Y2ITDZvimTCz6YBKHDMx/BkBZiBj1lKSK+RMXog7MLCpBPP4+IK2lCDUPWpkquls0YhknbNeR+kk9Ejm5TnCg0/VN8hrVACeDrRN01Bqqc+PPjYosHMA3m8Fr3NyDZD4hEGy74wS98t3MB4y8c0HCyz4zxHxp701tOUz8lfA3C5JBUZKLbN7Tq092lVPsQKnpbg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39E36E87CF58774CB0B709958DABDB91@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea783a67-79b8-4cba-3aa0-08d69db31a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 19:29:47.9717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1406
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 28, 2019, at 10:06 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>=20
> The "ref_type_id" variable needs to be signed for the error handling
> to work.
>=20
> Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> v2: Use reverse Christmas tree style
> v3: Remove the bonus fix.
>=20
> This goes through the BPF tree probably, although it does apply to
> net-next.
>=20
> tools/lib/bpf/btf.c                      | 3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 68b50e9bbde1..00a2f06e38fd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2326,7 +2326,8 @@ static int btf_dedup_ref_type(struct btf_dedup *d, =
__u32 type_id)
> 	struct btf_type *t, *cand;
> 	/* if we don't find equivalent type, then we are representative type */
> 	__u32 new_id =3D type_id;
> -	__u32 h, ref_type_id;
> +	int ref_type_id;
> +	__u32 h;
>=20
> 	if (d->map[type_id] =3D=3D BTF_IN_PROGRESS_ID)
> 		return -ELOOP;
> --=20
> 2.17.1


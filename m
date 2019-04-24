Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB3C282E1
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 23:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B5521773
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 23:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I916T809";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jkvkDvoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfDXXqu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:46:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59268 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727181AbfDXXqu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 19:46:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3ONgd1v009855;
        Wed, 24 Apr 2019 16:46:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6I+uBdj8Vk/Y/m1x64oNTbyHDIH0aFvxOcsV6O9JGO8=;
 b=I916T809QDs2j4AXP2t68E31DZTbPS5GXQDU4SOHF/V5+95A4ElP7U+Fw7Nuo+2PiM+0
 slGsXTiH7r+QayislYLOEqpNla5EYt0pXfI/1wGpqfaS6uwfqLeWT0fQ0kbUFStfcT+x
 sZXZIva8cuqBnSty5dUdfRfvS36MySZlhqM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2s28ke5rp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 16:46:30 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Wed, 24 Apr 2019 16:46:29 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Apr 2019 16:46:29 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 16:46:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I+uBdj8Vk/Y/m1x64oNTbyHDIH0aFvxOcsV6O9JGO8=;
 b=jkvkDvoAnTWWbtRMKjk53TQI5+4FOu39r1L+binWtEnRkdkd7Cm4viA32ODg1lJMkllkAUY67bdFjorj+7ZAQWyLQt1c2ifFg714bGfYBQQuj3MaOSWLNxHjWAIk7zlfwBD6mH2+nAa133WAhGVHMgEuSiTxCqLDXtvVOJNWUlQ=
Received: from DM5PR15MB1788.namprd15.prod.outlook.com (10.174.246.146) by
 DM5PR15MB1225.namprd15.prod.outlook.com (10.173.214.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 23:46:27 +0000
Received: from DM5PR15MB1788.namprd15.prod.outlook.com
 ([fe80::2de1:550b:8ed6:b534]) by DM5PR15MB1788.namprd15.prod.outlook.com
 ([fe80::2de1:550b:8ed6:b534%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 23:46:27 +0000
From:   Martin Lau <kafai@fb.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Add BPF_MAP_TYPE_SK_STORAGE test to
 test_maps
Thread-Topic: [PATCH bpf-next 5/6] bpf: Add BPF_MAP_TYPE_SK_STORAGE test to
 test_maps
Thread-Index: AQHU+u68ZLIio+6BMkqFRwiuPAE0kaZL+fwA
Date:   Wed, 24 Apr 2019 23:46:27 +0000
Message-ID: <20190424234624.3swccvafxyna4diu@kafai-mbp.dhcp.thefacebook.com>
References: <20190424223948.516788-1-kafai@fb.com>
 <20190424223958.517263-1-kafai@fb.com>
In-Reply-To: <20190424223958.517263-1-kafai@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:302:1::17) To DM5PR15MB1788.namprd15.prod.outlook.com
 (2603:10b6:4:4d::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::c6d3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 541197a8-2099-41c9-7f0e-08d6c90f114e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1225;
x-ms-traffictypediagnostic: DM5PR15MB1225:
x-microsoft-antispam-prvs: <DM5PR15MB1225624BF1BFD9830392A037D53C0@DM5PR15MB1225.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(189003)(199004)(71190400001)(6506007)(305945005)(7736002)(316002)(25786009)(229853002)(2501003)(68736007)(6436002)(4326008)(46003)(6486002)(53936002)(386003)(54906003)(110136005)(476003)(102836004)(478600001)(486006)(11346002)(446003)(52116002)(5660300002)(14454004)(99286004)(76176011)(2906002)(86362001)(66446008)(64756008)(66556008)(66476007)(186003)(97736004)(71200400001)(73956011)(14444005)(256004)(8936002)(8676002)(66946007)(81166006)(81156014)(1076003)(6116002)(6246003)(6512007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1225;H:DM5PR15MB1788.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wc/7DkxDuX/qRRq1flJh0Eca6HxYhkYAweg7wrES0Jv/7NNHm5FIbp+uYAy4ThoXvcBpaT9yRExq+QG+PhdGfiJ06DDm0T2Z9Ow1AIOAJKatAqLOLjItNShwAY3uoZLZoNPKtmZ1Q+yYwnp7iK6MtE/PeM7Ymygux8sXBhS5R0pCThbWvOPM9s5O2GPJ2ta0WmYFY+CHuPnR2n3Zmv5WpUm+jFk/vgh0jFe4god6fGs3XdYCIbqmEGrvOVFw4HvjD7LMzr4rOO9BuWA5QogTrB6WXtUdhg62bFatodNqihIm+UkPsrpXCPgfCWu5WDClbfwT5uon5nYakjsNc8+ikWHHz8K7zo8La8zSfDEfAF5mqhboKn9K2m5D6WOaXRGp8LOBSG8JtRtxBHh/5EXQL4mFHN5ipai9q5LX6OR2RoY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D4CC9DE5D521E40AEF99EB3F5C5693F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 541197a8-2099-41c9-7f0e-08d6c90f114e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 23:46:27.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1225
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 24, 2019 at 03:39:58PM -0700, Martin KaFai Lau wrote:
> This patch adds BPF_MAP_TYPE_SK_STORAGE test to test_maps.
> The src file is rather long, so it is put into another dir map_tests/
> and compile like the current prog_tests/ does.  Other existing
> tests in test_maps can also be re-factored into map_tests/ in the
> future.
>=20
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
[ ... ]
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> index 3c627771f965..246f745cb006 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -27,6 +27,7 @@
> =20
>  #include "bpf_util.h"
>  #include "bpf_rlimit.h"
> +#include "test_maps.h"
I forgot to add this new test_maps.h.  will fix.

Please continue the review on this set for now.

> =20
>  #ifndef ENOTSUPP
>  #define ENOTSUPP 524
> @@ -36,15 +37,6 @@ static int skips;
> =20
>  static int map_flags;
> =20
> -#define CHECK(condition, tag, format...) ({				\
> -	int __ret =3D !!(condition);					\
> -	if (__ret) {							\
> -		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
> -		printf(format);						\
> -		exit(-1);						\
> -	}								\
> -})
> -
>  static void test_hashmap(unsigned int task, void *data)
>  {
>  	long long key, next_key, first_key, value;
> @@ -1703,6 +1695,10 @@ static void run_all_tests(void)
>  	test_map_in_map();
>  }
> =20
> +#define DECLARE
> +#include <map_tests/tests.h>
> +#undef DECLARE
> +
>  int main(void)
>  {
>  	srand(time(NULL));
> @@ -1713,6 +1709,10 @@ int main(void)
>  	map_flags =3D BPF_F_NO_PREALLOC;
>  	run_all_tests();
> =20
> +#define CALL
> +#include <map_tests/tests.h>
> +#undef CALL
> +
>  	printf("test_maps: OK, %d SKIPPED\n", skips);
>  	return 0;
>  }
> --=20
> 2.17.1
>=20

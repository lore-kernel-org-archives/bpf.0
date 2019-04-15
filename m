Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B21C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7502A20830
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YbAwz5hR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AmrhHdKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfDOXiN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:38:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726939AbfDOXiM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 19:38:12 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3FNb1XX026462;
        Mon, 15 Apr 2019 16:37:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=E7lGXEhgy9ITeffZlNOOlKwTN3dCxUTF2ZgIbM83pSU=;
 b=YbAwz5hRnqj6sMwkvTokUhujMlJsK/n3g+9pPIYAeN1lyuKdZOJZ7H1VCnKztzNkoox7
 CVxie9UsiMNMpCvBv+QbJBplupHNagaU1vj4Ytex/5FfzeJQFma4ugFCDvD64Q/7/RcX
 LqYZNoFYzMlVrYRzJb642RhFSGYURIhj5Xw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rvyws0tyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Apr 2019 16:37:47 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 15 Apr 2019 16:37:46 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 15 Apr 2019 16:37:45 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 15 Apr 2019 16:37:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7lGXEhgy9ITeffZlNOOlKwTN3dCxUTF2ZgIbM83pSU=;
 b=AmrhHdKMxgxFYpYbUO+twQ6ECp1gh+rxej4usICnll76t+v7HMkrqb64iMDAvUmgKhU+C7zRpnGlE8c1a1tRwUwNlv5/eOCr2QiZgP804LZjoSTB8glKrpbHroO+EwYghdCqZwkJyIKCfiZayM9gHioi7pcypjyjjeV4QgjnUTY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1469.namprd15.prod.outlook.com (10.173.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 23:37:43 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 23:37:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     Networking <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next] kbuild: handle old pahole more gracefully when
 generating BTF
Thread-Topic: [PATCH bpf-next] kbuild: handle old pahole more gracefully when
 generating BTF
Thread-Index: AQHU89Z++hiEqAp9hkWzLu50MK3mYKY94MKA
Date:   Mon, 15 Apr 2019 23:37:42 +0000
Message-ID: <9AEC2C3E-D4F7-413C-A31B-557D9F56EEAC@fb.com>
References: <20190415215839.1895340-1-andrii.nakryiko@gmail.com>
In-Reply-To: <20190415215839.1895340-1-andrii.nakryiko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::a82b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78f29a90-d05b-4b37-231d-08d6c1fb5b7b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1469;
x-ms-traffictypediagnostic: MWHPR15MB1469:
x-microsoft-antispam-prvs: <MWHPR15MB1469538F5CDA4F324F80A0E0B32B0@MWHPR15MB1469.namprd15.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(33656002)(46003)(6116002)(6512007)(25786009)(2906002)(53936002)(478600001)(71200400001)(83716004)(7736002)(36756003)(316002)(54906003)(105586002)(1361003)(2351001)(14444005)(14454004)(256004)(305945005)(106356001)(5640700003)(71190400001)(86362001)(186003)(5660300002)(486006)(446003)(81156014)(76176011)(6506007)(102836004)(4326008)(2501003)(99286004)(2616005)(8936002)(68736007)(97736004)(6486002)(476003)(82746002)(11346002)(6916009)(81166006)(50226002)(8676002)(57306001)(53546011)(6436002)(229853002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1469;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9lexrS5pvmwML5wTfqKnUGla5jByNGMlbN3kUN3QjlYKZO+bBI9zc2t3JJc45ZNVS/4fbnVx2FwAKqWEPj8IR8iv0xBdJ207Tzd4heHABN4Trfd0zLQSZFFj69Y69I6pIE+TQH4WfqEY7BxajhJJsmR9gl6AW38UN6RIRsi97lwvXjIjP+Z7ICEVG1Jdc5onWp0t8470902Dj2GVqJ1T6b+Gw6VkeRoR+f7+r3VsFvGKoe2qZP2h2tPIJPgGL+WX8BD7/SFdRb+OxF+jlL0I90JhV+7qPAoK0PkUKjPK4Rbh8vvOMpHCFv2iOPxUpJT14JV7YTHBA9Fr1epU3IVtWsbNTv3GKzbluQMw8Yw2YqR4QGQrrmGfACAz8L1+o28K1onXS8q2GwWp4xnxwtqfFdN3wDmVccmoNMoM9Fhy4I4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1059AE0568F1AF4A87F87459F9436D76@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f29a90-d05b-4b37-231d-08d6c1fb5b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 23:37:43.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1469
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 15, 2019, at 2:58 PM, andrii.nakryiko@gmail.com wrote:
>=20
> From: Andrii Nakryiko <andriin@fb.com>
>=20
> When CONFIG_DEBUG_INFO_BTF is enabled but available version of pahole is =
too
> old to support BTF generation, build script is supposed to emit warning a=
nd
> proceed with the build. Due to using exit instead of return from BASH fun=
ction,
> existing handling code prematurely exits exit code 0, not completing some=
 of
> the build steps. This patch fixes issue by correctly returning just from
> gen_btf() function only.
>=20
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for v=
mlinux")
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> scripts/link-vmlinux.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index dd2b31ccca6a..6a148d0d51bf 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -99,7 +99,7 @@ gen_btf()
> 	pahole_ver=3D$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/=
')
> 	if [ "${pahole_ver}" -lt "113" ]; then
> 		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, nee=
d at least v1.13"
> -		exit 0
> +		return 0
> 	fi
>=20
> 	info "BTF" ${1}
> --=20
> 2.17.1
>=20


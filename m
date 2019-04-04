Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F776C10F0F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 19:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C495C2147C
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VALlHDnT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RdONRwPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfDDTVS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:21:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbfDDTVS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Apr 2019 15:21:18 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34JINbb004451;
        Thu, 4 Apr 2019 12:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sSlH1yIFxEJv/36nxBw4qEMrz9nrFnxiF2Ak9XbtNtU=;
 b=VALlHDnTHFXKYe4hAvOl3FSt3iQEgqCkbf0gtUWBRNRcHkkBX26FNgFGwYsbxDEg0BBH
 cG9wzRZicRSY59M/6FY/mCv3MtlmfFqDBh5WVPo3il8ouH0/UK7p0CXAghxM1FKgEHUN
 8a3SqoIWwoMTVmw4FyNUAQ7DMOhytDDfgrE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnq6786gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 12:20:55 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 12:20:54 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Apr 2019 12:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSlH1yIFxEJv/36nxBw4qEMrz9nrFnxiF2Ak9XbtNtU=;
 b=RdONRwPUc9XFULdOq/CLTSzX2pR+qspAdjZle7MP5wFuQ/Jwl5u805rvUqj9rYkG/Q/XlbVqtyDnDW6DqA1h+ojXifIm+CIGpK7DsMC7+lIPofxGKDe7EmaHOrzL2Ca/yCABQuo4rgZqDEYzNjoL/olLwo3+KZRVoRV9BjsRA0Y=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1343.namprd15.prod.outlook.com (10.175.3.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 4 Apr 2019 19:20:52 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 19:20:52 +0000
From:   Martin Lau <kafai@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>, Yonghong Song <yhs@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: kernel side support for BTF Var
 and DataSec
Thread-Topic: [PATCH bpf-next v3 06/15] bpf: kernel side support for BTF Var
 and DataSec
Thread-Index: AQHU6kpjkUzBd2Ym40yd2RGiYDD+86YsYnCA
Date:   Thu, 4 Apr 2019 19:20:51 +0000
Message-ID: <20190404192049.qyae2zfzadb7os3a@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1554314902.git.daniel@iogearbox.net>
 <62cf123c51006a02c1ffa9aaaf2881a8eb292d59.1554314902.git.daniel@iogearbox.net>
In-Reply-To: <62cf123c51006a02c1ffa9aaaf2881a8eb292d59.1554314902.git.daniel@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:a03:54::14) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:ab56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dceb50af-f267-42d3-27f2-08d6b932a68f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1343;
x-ms-traffictypediagnostic: MWHPR15MB1343:
x-microsoft-antispam-prvs: <MWHPR15MB13431A520FA11591BE17840CD5500@MWHPR15MB1343.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(86362001)(102836004)(76176011)(6506007)(386003)(52116002)(53936002)(186003)(71200400001)(71190400001)(316002)(14444005)(54906003)(99286004)(6246003)(105586002)(106356001)(68736007)(46003)(14454004)(478600001)(4326008)(9686003)(6116002)(97736004)(476003)(6512007)(11346002)(446003)(2906002)(1076003)(256004)(81166006)(6436002)(8676002)(81156014)(5660300002)(8936002)(6916009)(7736002)(229853002)(305945005)(25786009)(6486002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1343;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kE4kZW0wzEGA9uqPDVqU7cnRphLrxybIvij4jf929rSjHSXeKZBehYG0EdqOB38+lPyg1pqYlM/LdzRM9md7o6lVheeWUJkljIVlPfb7rRD2cQ2H6W60EThj+VSTg52cWluLVlBwYjde/ybUJ7PySnD/8Fi5L+AaqfDJqcQNSxaK96b3KsxY0Qf90He+Ftvhzuumbjg96O7P2Ayz4ClgiI9h0dSRCC2Trgls/n4EHSd8Xv72HWOGl9XRBK4sQrxJ9BbECgdIw+AZz+BoYLAEd0pNfhB4LIrQIbmGgi/eYSQXEkdrwF+N2+3U2yD6150twgtopNFf3GVxsQFqYbkBnzBhZL2q+4a9QlOq1WsSA3aLarnWFxnG1UEb8jl8AtYOrTvklInhKDF3BAZmpevIqdjM6SC2VrCGt5vVtR93Ucc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA5516FE7B24C545B98BD01ED8D7CD91@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dceb50af-f267-42d3-27f2-08d6b932a68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 19:20:52.0122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1343
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 03, 2019 at 08:22:57PM +0200, Daniel Borkmann wrote:
> This work adds kernel-side verification, logging and seq_show dumping
> of BTF Var and DataSec kinds which are emitted with latest LLVM. The
> following constraints apply:
>=20
> BTF Var must have:
>=20
> - Its kind_flag is 0
> - Its vlen is 0
> - Must point to a valid type
> - Type must not resolve to a forward type
> - Must have a valid name
> - Name may include dots (e.g. in case of static variables
>   inside functions)
> - Cannot be a member of a struct/union
> - Linkage so far can either only be static or global/allocated
>=20
> BTF DataSec must have:
>=20
> - Its kind_flag is 0
> - Its vlen cannot be 0
> - Its size cannot be 0
> - Must have a valid name
> - Name may include dots (e.g. to represent .bss, .data, .rodata etc)
> - Cannot be a member of a struct/union
> - Inner btf_var_secinfo array with {type,offset,size} triple
>   must be sorted by offset in ascending order
> - Type must always point to BTF Var
> - BTF resolved size of Var must be <=3D size provided by triple
> - DataSec size must be >=3D sum of triple sizes (thus holes
>   are allowed)
Looks very good.  A few questions.

[ ... ]

> @@ -308,6 +320,7 @@ static bool btf_type_is_modifier(const struct btf_typ=
e *t)
>  	case BTF_KIND_VOLATILE:
>  	case BTF_KIND_CONST:
>  	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_VAR:
Why BTF_KIND_VAR is added here?

If possible, it may be better to keep is_modifier() as is since var
intuitively does not belong to the is_modifier() test.

>  		return true;
>  	}
> =20
> @@ -375,13 +388,27 @@ static bool btf_type_is_int(const struct btf_type *=
t)
>  	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_INT;
>  }
> =20
> +static bool btf_type_is_var(const struct btf_type *t)
> +{
> +	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_VAR;
> +}
> +
> +static bool btf_type_is_datasec(const struct btf_type *t)
> +{
> +	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DATASEC;
> +}
> +
>  /* What types need to be resolved?
>   *
>   * btf_type_is_modifier() is an obvious one.
>   *
>   * btf_type_is_struct() because its member refers to
>   * another type (through member->type).
> -
> + *
> + * btf_type_is_var() because the variable refers to
> + * another type. btf_type_is_datasec() holds multiple
> + * btf_type_is_var() types that need resolving.
> + *
>   * btf_type_is_array() because its element (array->type)
>   * refers to another type.  Array can be thought of a
>   * special case of struct while array just has the same
> @@ -390,9 +417,11 @@ static bool btf_type_is_int(const struct btf_type *t=
)
>  static bool btf_type_needs_resolve(const struct btf_type *t)
>  {
>  	return btf_type_is_modifier(t) ||
> -		btf_type_is_ptr(t) ||
> -		btf_type_is_struct(t) ||
> -		btf_type_is_array(t);
> +	       btf_type_is_ptr(t) ||
> +	       btf_type_is_struct(t) ||
> +	       btf_type_is_array(t) ||
> +	       btf_type_is_var(t) ||
is_var() is also tested here on top of is_modifier().

> +	       btf_type_is_datasec(t);
>  }
> =20
>  /* t->size can be used */
> @@ -403,6 +432,7 @@ static bool btf_type_has_size(const struct btf_type *=
t)
>  	case BTF_KIND_STRUCT:
>  	case BTF_KIND_UNION:
>  	case BTF_KIND_ENUM:
> +	case BTF_KIND_DATASEC:
>  		return true;
>  	}
> =20

[ ... ]

> +static int btf_var_resolve(struct btf_verifier_env *env,
> +			   const struct resolve_vertex *v)
> +{
> +	const struct btf_type *next_type;
> +	const struct btf_type *t =3D v->t;
> +	u32 next_type_id =3D t->type;
> +	struct btf *btf =3D env->btf;
> +	u32 next_type_size;
> +
> +	next_type =3D btf_type_by_id(btf, next_type_id);
Does the BTF verifier complain if BTF_KIND_VAR -> BTF_KIND_VAR -> BTF_KIND_=
INT?

The same goes for BTF_KIND_PTR -> BTF_KIND_VAR -> BTF_KIND_INT.

> +	if (!next_type) {
> +		btf_verifier_log_type(env, v->t, "Invalid type_id");
> +		return -EINVAL;
> +	}
> +
> +	if (!env_type_is_resolve_sink(env, next_type) &&
> +	    !env_type_is_resolved(env, next_type_id))
> +		return env_stack_push(env, next_type, next_type_id);
> +
> +	if (btf_type_is_modifier(next_type)) {
May be a few comments on why this is needed.  Together with
the is_modifier() change above, it is not immediately clear to me.

I suspect this could be left to be done in the btf_ptr_resolve()
as well if the ptr type happens to be behind the var type in
the ".BTF" ELF.

> +		const struct btf_type *resolved_type;
> +		u32 resolved_type_id;
> +
> +		resolved_type_id =3D next_type_id;
> +		resolved_type =3D btf_type_id_resolve(btf, &resolved_type_id);
> +
> +		if (btf_type_is_ptr(resolved_type) &&
> +		    !env_type_is_resolve_sink(env, resolved_type) &&
> +		    !env_type_is_resolved(env, resolved_type_id))
> +			return env_stack_push(env, resolved_type,
> +					      resolved_type_id);
> +	}
> +
> +	/* We must resolve to something concrete at this point, no
> +	 * forward types or similar that would resolve to size of
> +	 * zero is allowed.
> +	 */
> +	if (!btf_type_id_size(btf, &next_type_id, &next_type_size)) {
> +		btf_verifier_log_type(env, v->t, "Invalid type_id");
> +		return -EINVAL;
> +	}
> +
> +	env_stack_pop_resolved(env, next_type_id, next_type_size);
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -2622,13 +2983,17 @@ static bool btf_resolve_valid(struct btf_verifier=
_env *env,
>  	if (!env_type_is_resolved(env, type_id))
>  		return false;
> =20
> -	if (btf_type_is_struct(t))
> +	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
>  		return !btf->resolved_ids[type_id] &&
> -			!btf->resolved_sizes[type_id];
> +		       !btf->resolved_sizes[type_id];
> =20
> -	if (btf_type_is_modifier(t) || btf_type_is_ptr(t)) {
> +	if (btf_type_is_modifier(t) || btf_type_is_ptr(t) ||
> +	    btf_type_is_var(t)) {
>  		t =3D btf_type_id_resolve(btf, &type_id);
> -		return t && !btf_type_is_modifier(t);
> +		return t &&
> +		       !btf_type_is_modifier(t) &&
> +		       !btf_type_is_var(t) &&
> +		       !btf_type_is_datasec(t);
>  	}
> =20
>  	if (btf_type_is_array(t)) {
> --=20
> 2.9.5
>=20

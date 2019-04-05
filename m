Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF067C4360F
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 07:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CEE21850
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 07:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O40M9ndm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HlODFvB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfDEHDn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:03:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbfDEHDn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Apr 2019 03:03:43 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35700Hs010768;
        Fri, 5 Apr 2019 00:03:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=subFS6LrSlvPd2wd79VEVtIXavwIRZLDesjFYGW2t9c=;
 b=O40M9ndmmlXJtBYTeg3tA6DBCMfrINFlFrVckuo6geWTzr5zP3YMguOEwTs4ThRXqUgk
 g/yvZfOKRIFQfuz8sltEZWidPF3dsZYhDESN5sXGyS+yyeTFCMVYw5Kz7WQfnxamqhxm
 DGe+jo8jJwWYi9JhVPsYcBWbh9a3ereEWBM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnpmpj754-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 00:03:19 -0700
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 00:03:17 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 00:03:17 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 5 Apr 2019 00:03:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=subFS6LrSlvPd2wd79VEVtIXavwIRZLDesjFYGW2t9c=;
 b=HlODFvB6IEp+5hlEEOrk7pUPclJ0ZNO7W+DGbpXam+XNKF7PfJZqZxL6ma0GSWjQ7NAgd/U0t5hVrkVpWnNxva1Wn8UASthiE1h+ruPHkxBWblsq0V36NhsI3r0+D1t0as8SgF1IbKCyTgVrWJiQRR5xv1x+e5hTum38tdHyLWg=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1469.namprd15.prod.outlook.com (10.173.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Fri, 5 Apr 2019 07:03:16 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Fri, 5 Apr 2019
 07:03:15 +0000
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
Thread-Index: AQHU6kpjkUzBd2Ym40yd2RGiYDD+86YsYnCAgADEPgA=
Date:   Fri, 5 Apr 2019 07:03:15 +0000
Message-ID: <20190405070312.uprjxyzyg6r3sm4l@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1554314902.git.daniel@iogearbox.net>
 <62cf123c51006a02c1ffa9aaaf2881a8eb292d59.1554314902.git.daniel@iogearbox.net>
 <20190404192049.qyae2zfzadb7os3a@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190404192049.qyae2zfzadb7os3a@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0043.namprd14.prod.outlook.com
 (2603:10b6:300:12b::29) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::d000]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82bd4301-403b-4c2c-3ccd-08d6b994c62f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1469;
x-ms-traffictypediagnostic: MWHPR15MB1469:
x-microsoft-antispam-prvs: <MWHPR15MB146940C63AC746FE2FB49851D5510@MWHPR15MB1469.namprd15.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(199004)(189003)(8936002)(14444005)(6486002)(229853002)(6436002)(8676002)(71200400001)(11346002)(476003)(446003)(46003)(1076003)(6916009)(186003)(52116002)(102836004)(76176011)(99286004)(386003)(6506007)(106356001)(105586002)(71190400001)(68736007)(6246003)(5660300002)(6512007)(86362001)(53936002)(9686003)(81166006)(25786009)(4326008)(54906003)(81156014)(316002)(14454004)(6116002)(97736004)(256004)(7736002)(305945005)(2906002)(478600001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1469;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BiYVRUZunaVdfHqX7MkxWw8MSPq3FUlOeTAylBgPKRfJNGiz+AUSKvsnX5McEPrfatl0UeMUh9ewFZ/BfDpOUx/91+ew2CitDU7XKtT6GfvkOcdkqU8FoGeMcBs6X6mVfto+9v/UzAou3bEyyLbDAROGkkn1Ob86Zeh/LDCT5QzBfGWDmc3LSkgTpiXFN6TUhx+2UM6/faxbR/7PLSGONix39NZ7McNh6aIFP01PIMPEG1WM5p4Zts9tMGLfdpLxU9QhI8J7hgNM0rs68ybgl4h74dnAUqPiH7cmedK3egYRD7G4NWTfGWfOstZlhSlpOPr99QawMxcpSuCnRHGzDGT2iYIrat37iwu/JJZjThVR3gv4yk0MBmLxHsRR7GByadaUtSBUtZJnVOJcaxWpV5VghGUyDtqhhlkN4gnkjSY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D3E8CFAEDCE654A8DB9223CFBDB857F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bd4301-403b-4c2c-3ccd-08d6b994c62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 07:03:15.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1469
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 04, 2019 at 07:20:51PM +0000, Martin Lau wrote:
> On Wed, Apr 03, 2019 at 08:22:57PM +0200, Daniel Borkmann wrote:
> > This work adds kernel-side verification, logging and seq_show dumping
> > of BTF Var and DataSec kinds which are emitted with latest LLVM. The
> > following constraints apply:
> >=20
> > BTF Var must have:
> >=20
> > - Its kind_flag is 0
> > - Its vlen is 0
> > - Must point to a valid type
> > - Type must not resolve to a forward type
> > - Must have a valid name
> > - Name may include dots (e.g. in case of static variables
> >   inside functions)
> > - Cannot be a member of a struct/union
> > - Linkage so far can either only be static or global/allocated
> >=20
> > BTF DataSec must have:
> >=20
> > - Its kind_flag is 0
> > - Its vlen cannot be 0
> > - Its size cannot be 0
> > - Must have a valid name
> > - Name may include dots (e.g. to represent .bss, .data, .rodata etc)
> > - Cannot be a member of a struct/union
> > - Inner btf_var_secinfo array with {type,offset,size} triple
> >   must be sorted by offset in ascending order
> > - Type must always point to BTF Var
> > - BTF resolved size of Var must be <=3D size provided by triple
> > - DataSec size must be >=3D sum of triple sizes (thus holes
> >   are allowed)
> Looks very good.  A few questions.
>=20
> [ ... ]
>=20
> > @@ -308,6 +320,7 @@ static bool btf_type_is_modifier(const struct btf_t=
ype *t)
> >  	case BTF_KIND_VOLATILE:
> >  	case BTF_KIND_CONST:
> >  	case BTF_KIND_RESTRICT:
> > +	case BTF_KIND_VAR:
> Why BTF_KIND_VAR is added here?
>=20
> If possible, it may be better to keep is_modifier() as is since var
> intuitively does not belong to the is_modifier() test.
>=20
> >  		return true;
> >  	}
> > =20
> > @@ -375,13 +388,27 @@ static bool btf_type_is_int(const struct btf_type=
 *t)
> >  	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_INT;
> >  }
> > =20
> > +static bool btf_type_is_var(const struct btf_type *t)
> > +{
> > +	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_VAR;
> > +}
> > +
> > +static bool btf_type_is_datasec(const struct btf_type *t)
> > +{
> > +	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DATASEC;
> > +}
> > +
> >  /* What types need to be resolved?
> >   *
> >   * btf_type_is_modifier() is an obvious one.
> >   *
> >   * btf_type_is_struct() because its member refers to
> >   * another type (through member->type).
> > -
> > + *
> > + * btf_type_is_var() because the variable refers to
> > + * another type. btf_type_is_datasec() holds multiple
> > + * btf_type_is_var() types that need resolving.
> > + *
> >   * btf_type_is_array() because its element (array->type)
> >   * refers to another type.  Array can be thought of a
> >   * special case of struct while array just has the same
> > @@ -390,9 +417,11 @@ static bool btf_type_is_int(const struct btf_type =
*t)
> >  static bool btf_type_needs_resolve(const struct btf_type *t)
> >  {
> >  	return btf_type_is_modifier(t) ||
> > -		btf_type_is_ptr(t) ||
> > -		btf_type_is_struct(t) ||
> > -		btf_type_is_array(t);
> > +	       btf_type_is_ptr(t) ||
> > +	       btf_type_is_struct(t) ||
> > +	       btf_type_is_array(t) ||
> > +	       btf_type_is_var(t) ||
> is_var() is also tested here on top of is_modifier().
>=20
> > +	       btf_type_is_datasec(t);
> >  }
> > =20
> >  /* t->size can be used */
> > @@ -403,6 +432,7 @@ static bool btf_type_has_size(const struct btf_type=
 *t)
> >  	case BTF_KIND_STRUCT:
> >  	case BTF_KIND_UNION:
> >  	case BTF_KIND_ENUM:
> > +	case BTF_KIND_DATASEC:
> >  		return true;
> >  	}
> > =20
>=20
> [ ... ]
>=20
> > +static int btf_var_resolve(struct btf_verifier_env *env,
> > +			   const struct resolve_vertex *v)
> > +{
> > +	const struct btf_type *next_type;
> > +	const struct btf_type *t =3D v->t;
> > +	u32 next_type_id =3D t->type;
> > +	struct btf *btf =3D env->btf;
> > +	u32 next_type_size;
> > +
> > +	next_type =3D btf_type_by_id(btf, next_type_id);
> Does the BTF verifier complain if BTF_KIND_VAR -> BTF_KIND_VAR -> BTF_KIN=
D_INT?
>=20
> The same goes for BTF_KIND_PTR -> BTF_KIND_VAR -> BTF_KIND_INT.
I was about to try but it seems I cannot apply the set cleanly.
Likely due to some recent changes.

After a quick skim through, the above cases seem possible.

If rejecting the above cases is desired,
I think it may be easier to check them at the individual
type's _resolve() instead of depending on the final resort
btf_resolve_valid().  The individual type's _resolve() should
know better what are the acceptable next_type[s].
I was thinking btf_resolve_valid() is more like a
"btf verifier internal error" to ensure the
earlier individual type's _resolve() is sane.

It seems at least the modifier_resolve() and ptr_resolve()
are missing to reject BTF_KIND_FUNC.  I will code
up a patch to fix BTF_KIND_FUNC.

>=20
> > +	if (!next_type) {
> > +		btf_verifier_log_type(env, v->t, "Invalid type_id");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!env_type_is_resolve_sink(env, next_type) &&
> > +	    !env_type_is_resolved(env, next_type_id))
> > +		return env_stack_push(env, next_type, next_type_id);
> > +
> > +	if (btf_type_is_modifier(next_type)) {
> May be a few comments on why this is needed.  Together with
> the is_modifier() change above, it is not immediately clear to me.
>=20
> I suspect this could be left to be done in the btf_ptr_resolve()
> as well if the ptr type happens to be behind the var type in
> the ".BTF" ELF.
>=20
> > +		const struct btf_type *resolved_type;
> > +		u32 resolved_type_id;
> > +
> > +		resolved_type_id =3D next_type_id;
> > +		resolved_type =3D btf_type_id_resolve(btf, &resolved_type_id);
> > +
> > +		if (btf_type_is_ptr(resolved_type) &&
> > +		    !env_type_is_resolve_sink(env, resolved_type) &&
> > +		    !env_type_is_resolved(env, resolved_type_id))
> > +			return env_stack_push(env, resolved_type,
> > +					      resolved_type_id);
> > +	}
> > +
> > +	/* We must resolve to something concrete at this point, no
> > +	 * forward types or similar that would resolve to size of
> > +	 * zero is allowed.
> > +	 */
> > +	if (!btf_type_id_size(btf, &next_type_id, &next_type_size)) {
> > +		btf_verifier_log_type(env, v->t, "Invalid type_id");
> > +		return -EINVAL;
> > +	}
> > +
> > +	env_stack_pop_resolved(env, next_type_id, next_type_size);
> > +
> > +	return 0;
> > +}
> > +
>=20
> [ ... ]
>=20
> > @@ -2622,13 +2983,17 @@ static bool btf_resolve_valid(struct btf_verifi=
er_env *env,
> >  	if (!env_type_is_resolved(env, type_id))
> >  		return false;
> > =20
> > -	if (btf_type_is_struct(t))
> > +	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
> >  		return !btf->resolved_ids[type_id] &&
> > -			!btf->resolved_sizes[type_id];
> > +		       !btf->resolved_sizes[type_id];
> > =20
> > -	if (btf_type_is_modifier(t) || btf_type_is_ptr(t)) {
> > +	if (btf_type_is_modifier(t) || btf_type_is_ptr(t) ||
> > +	    btf_type_is_var(t)) {
> >  		t =3D btf_type_id_resolve(btf, &type_id);
> > -		return t && !btf_type_is_modifier(t);
> > +		return t &&
> > +		       !btf_type_is_modifier(t) &&
> > +		       !btf_type_is_var(t) &&
> > +		       !btf_type_is_datasec(t);
> >  	}
> > =20
> >  	if (btf_type_is_array(t)) {
> > --=20
> > 2.9.5
> >=20

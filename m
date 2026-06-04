Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93436A013
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612109; cv=none; b=b4WvImh+lVzrbcvCIn431sFzvjE1TqFP6fE8u8QFl9Pl9VcMOwgzOVQ+m2eLRK/Vi9CCTWwLU4nrWageyGzNVQGioRD70g3V2W1rEPw0ccd4rTDTd9lR/MTIIk7PCYeLNtfiCo2L8oUW0rbgExu+GmIh6El3Y5ifwCxS6XXxyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612109; c=relaxed/simple;
	bh=MzyGql4GHd0+RGCrF2pbBZpefHTbyT9IDPjrE3kxFM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A8md4GVIAEbApyTF5lalY4rc2fBGFAx99ZYbLtwiLXrgLSh97V/S+toKBuHKQ4O0+bYfZ0EZTgXiuYZdjInl5yDh2Y+vUQ+/ZcfMjvLDiMvR/7LbzMT8829whaWOVXN/nyArIV+UC/jW2Zs0/tzVWtOGQoQszr5BjymkUSBklrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU7YvSUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU7YvSUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4961F00893;
	Thu,  4 Jun 2026 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780612104;
	bh=iT4JvDWPz4Zr3pMI08QJSP/3J6bDWh5gu1HnZAFmAms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PU7YvSUWx5pKhdtqmgAtDnf8ZTRlB9/X/bdwHc8LvAx4zXTTI9sESq7xe6EpYay+F
	 0ZPj2I/MxPUpvZKl7+Nh4ow6DgvRfcmnprxdknlteYLm+eP2UXC0fjqpPNfA2Gdhf+
	 /TvqyY2LftUuG9m7Mz92+Pmfb6QGVdn9o7YVYwPlr+02Zi9EuM9tV/JR1F/gQ+qljG
	 bpekpnjZDHVDC6N/2dUm2bUfs0wDtKC4maSYjhHLGIy3u3RPTV3wcNqMAlEPihaPVf
	 querbGX+IJXSUp561iSpy2jyEQT4gw53zT+J3RH3B3n9pCtembhIX/87NFaMs/n6km
	 4uIdf5u9GIZuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix dead error check on
 acquire_reference() in check_kfunc_call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604220904.1032145-2-ameryhung@gmail.com>
References: <20260604220904.1032145-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 22:28:23 +0000
Message-Id: <20260604222824.2D4961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check on `acquire_reference()` in `do_check_common` =
allows BPF programs to bypass reference tracking and leak kernel resources.
--

commit 259ddea87c590cd0902d75313fa1c99925c708fb
Author: Amery Hung <ameryhung@gmail.com>

bpf: Fix dead error check on acquire_reference() in check_kfunc_call

This commit changes the type of the 'id' variable from a u32 to an int
so that negative error codes returned from acquire_reference() are
checked correctly instead of being treated as large positive integers.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a4..6446db9628aed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	struct bpf_kfunc_call_arg_meta meta;
>  	struct bpf_insn_aux_data *insn_aux;
>  	int err, insn_idx =3D *insn_idx_p;
> -	u32 i, nargs, ptr_type_id, id;
>  	const struct btf_param *args;
> +	u32 i, nargs, ptr_type_id;
>  	struct btf *desc_btf;
> +	int id;

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing a missing
error check on acquire_reference() here, could a similar issue exist in
do_check_common() when initializing struct_ops program arguments?

In kernel/bpf/verifier.c:do_check_common():

    /* Acquire references for struct_ops program arguments tagged with "__r=
ef" */
    if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
        for (i =3D 0; i < aux->ctx_arg_info_size; i++)
            aux->ctx_arg_info[i].ref_id =3D aux->ctx_arg_info[i].refcounted=
 ?
                              acquire_reference(env, 0, 0) : 0;
    }

Since acquire_reference() can return a negative error like -ENOMEM, assigni=
ng
it directly to aux->ctx_arg_info[i].ref_id (which is a u32) without checking
for errors seems like it would swallow the error code.

Does this allow the verifier to successfully accept a BPF program without
tracking the reference, potentially leading to a kernel resource leak when
the reference isn't released at runtime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604220904.1032=
145-1-ameryhung@gmail.com?part=3D1

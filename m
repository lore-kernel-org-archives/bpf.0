Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998692;
	b=EMrvxWWDbegEmyxXagOHX+axnaK5ZfeM9l9gEB1tNVMxFMoPwG2iaWlcmjBJ34/QhIZe
	 8jmDk0g6RC1dF1PXYljbfqLYHhEWeWiX0/8ODbw6p+WtvQZ4tROOFYZWcWorbUvd7WHqN
	 eQWT/K9fsNcisflFXkqCpa60sGwrb2DUgXlYcUWj17hB7r4ZMDt76xdTzByqaDF1Q/gvm
	 Aq9xP/Yfv8P2bWIMDFEAsZnPtl1Hel94E1MwDEfJgKWk7KlQTsOVjkukyUfImVFttFlNS
	 MniazZBSD3z1vS7Gouxxnyw55hh2ikJOK2wWZuf1FOtcc+WO4BQkD+9d7DmuiEsj1MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VcAefyoDXZEKELCTIxTaFjGyzFoF8IYLdpAnW+99SFg=;
	b=TH70XcWBPVQE9GunEjdsmtZE80d4Tzmb80kasLPFWvVQcKcPcvUV3vhMvGS5cZWAsL+2
	 6t4BfqIqhy5GBLVsxzUSZndLKPxtz6UqooiaeAZNOgRhPSOSZn3SV9j1Dxd179n/IVEDE
	 /l1a6EXFGXrPhImdD9IYh1b0SGqyz+xvgiki+H7JrrIwNGoGMjmEgUSz3FYBSf8yive7w
	 YXLuLUXe0pcNMUzOkduUThcPsREStyDLGA14KS9RREdWRvqzJnoZTHu8m6383nWXDjP+o
	 vKqgur/JV4aiXGEwJ2Vomh4QXxzUvuhp8R2MShIMDV6dGkYmJ9wd0tfcV+wvfEuy5Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeNITR8p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D15606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeNITR8p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABFB1F008A1;
	Fri,  6 Nov 2026 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998691;
	bh=VcAefyoDXZEKELCTIxTaFjGyzFoF8IYLdpAnW+99SFg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MeNITR8ptVjXJZQ3Ybl48fSykVnPBONqIAVfVjsfb+ccrT+rA9X/Wivz2+ayJoC3y
	 hiBW9KLlIV5YyRHqD5bVV+cNs3wQJVE0Y6Jp9Vpsvc+e7+KbGdKVvRch8tCs2dXiXd
	 ODIFzAgNS+ebNfVpqHP/zySTqH1SXtYJzFXeIK3EeY7Mvsm5ZXEnUcgkn7u6CqEjEq
	 vrpXigEXieKNHfCbFCwSChxg6OAFB4ynl3ruR0DL0/t6QN7BYNC1gIDSxjmWV7WZRV
	 Kr067hlbgTg9ieUaKHmM3RBccYeLxetkEJIeLo0czpaHOxv14gM8vH20aR4X+pc72o
	 BY5wFroIcHNYg==
Message-ID: <sashiko-outbox-202267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 02/18] bpf: Add a btf_id_set8_entry helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106210314.1767267-2-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:58:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] bpf: kfunc sets destruction on failure in
  btf_populate_kfunc_set() [1]
--

commit 0f99bfedbc98b8fbe7b7a25dd4038c3e714adb73
Author: Anton Protopopov <a.s.protopopov@gmail.com>

bpf: Add a btf_id_set8_entry helper

This commit names the element type of struct btf_id_set8 as struct
btf_id_set8_pair, introduces btf_id_set8_entry() to look up a pair, and
changes btf_id_set8_contains() to return a boolean.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 228b93d4f8c94..61d2df6776a99 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -9973,8 +9973,8 @@ static u32 *btf_kfunc_id_set_contains(const struct =
btf *btf,
>  				      enum btf_kfunc_hook hook,
>  				      u32 kfunc_btf_id)
>  {
> +	struct btf_id_set8_pair *pair;
>  	struct btf_id_set8 *set;
> -	u32 *id;
> =20
>  	if (hook >=3D BTF_KFUNC_HOOK_MAX)
>  		return NULL;
> @@ -9983,11 +9983,10 @@ static u32 *btf_kfunc_id_set_contains(const struc=
t btf *btf,
>  	set =3D btf->kfunc_set_tab->sets[hook];
>  	if (!set)
>  		return NULL;
> -	id =3D btf_id_set8_contains(set, kfunc_btf_id);
> -	if (!id)
> +	pair =3D btf_id_set8_entry(set, kfunc_btf_id);
> +	if (!pair)
>  		return NULL;
> -	/* The flags for BTF ID are located next to it */
> -	return id + 1;
> +	return &pair->flags;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but in the paired
btf_populate_kfunc_set() function that populates btf->kfunc_set_tab, does an
error on a later registration destroy all previously registered kfunc sets
[1]?

kernel/bpf/btf.c:btf_populate_kfunc_set() {
    ...
	/* Grow set */
	set =3D krealloc(tab->sets[hook],
		       struct_size(set, pairs, set_cnt + add_set->cnt),
		       GFP_KERNEL | __GFP_NOWARN);
	if (!set) {
		ret =3D -ENOMEM;
		goto end;
	}
    ...
end:
	btf_free_kfunc_set_tab(btf);
	return ret;
}

Multiple subsystems register kfunc sets into the shared vmlinux BTF.  If a
later registration fails in krealloc() or exceeds BTF_KFUNC_SET_MAX_CNT,
jumping to end calls btf_free_kfunc_set_tab(), which frees every hook's set
and clears btf->kfunc_set_tab, breaking all previously registered kfuncs.

[1] https://sashiko.dev/#/bug/linux-1a311d3c-46c9-4fa6-a26e-40badcd832d8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106205523.1765=
622-1-a.s.protopopov@gmail.com?part=3D2

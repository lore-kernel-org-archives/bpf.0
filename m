Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809784;
	b=kcKYkkOUcfChVaoR+UhynfgmRsLr/SKncbgOAFj14hL+v2n45Ms5t+vgzuAgXaGDBYti
	 Zr2bbyAQE+EESr6LALfIr3DwMjFKWhpDZ4Ru/+2I1DV9x0GSKm136WLjPiifZyr5YrIGu
	 6UVRrMYgzTPvD4eedTcv2GcMzHLbb99K2wkLsne0N8rQjSjlrZRZH6/Yu4bV/6xose75j
	 FPaEo+dhItOjMNLR4p+9IgzQUwMsUzAV5MxeeC9W4QdojPjNeSEAdLywTACr6VIFHMz6Z
	 hloIdfDUV2z4d03dB/dfiFXgCrj6QQCEbxckOZpvTMnhzl777Xz655uNsuRtfokD73A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gKNaSDDckoYKahjUJ9t74Y2bJzeZHhSxzyhkhUJU0SQ=;
	b=N2rYWxO+TCguIN0yp2U9/VGjSbyNkKZXjbHhLVzbHcJKSwop7b3yDWH99FMxFBwjmSMj
	 4tlffssymzuqYWxYENOr+n4y6vvXhUY5bQcB2gnAmJ6I0qv/v2Df/ZtbLW2mikL11aGw3
	 5MEErR3mTqnOPWLNUxvdBbPYoiUPYTqgU9yavnXOtPavUHfjBSczQs9SVXMrxBHHabzBp
	 /k1zi9Z53xbCTIKjHgDapt8YwoRCj2DdSW47VOGc+lL5DBqj1DolM5oTBDTL2iEoQJ8aI
	 w2eQiqECC/3d1datP7wruVtf7JBh90Y0+apJI0tunH0nU6CbZbJi8UAipQdim4Hhr9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDD2BX9t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B78606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDD2BX9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F51F000C4;
	Mon, 16 Nov 2026 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809784;
	bh=gKNaSDDckoYKahjUJ9t74Y2bJzeZHhSxzyhkhUJU0SQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nDD2BX9tQZeQIR1z433zogx7niYQft0TjZIpoPEP9TidYKOFH1Fz8uzQF2ltSwH8n
	 P/hoMtvSWS2RL3nYYJIlWm+g4vCxJGTj3mRvryLbjmyAquUJA36VFE49OKwuMwKKCa
	 T74SOlT0jXuzKmiyj4b/LWA43VBtykaV83pgAYwgaCIOVEH7Dkv6MHHVfO0KP15P/y
	 67o+Hzv0X5VIHCftEqYUqX0jPWM42fhfYj2kSzTB2jLxloojn4vEgGNHy4Nm0rimJa
	 8PblSZDlJ31uZNhOvQBvecaVul0j+tNFAhOLdvUI+NuRDK6inKEzWNZuYgb/1n4+8c
	 KMDe+2Ulwvn+w==
Message-ID: <sashiko-outbox-216255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/21] bpf: Do not scan all maps for each insn
 and each subprog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-9-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:16:23 +0000
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
- [Critical] bpf: integer overflows in jt_from_subprog() and
  bpf_copy_insn_array_uniq() [1]
--

commit ad22f7b9cb9db9b58629009bfe124e8d3522e5f8
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Do not scan all maps for each insn and each subprog

This commit speeds up program dumping, subprogram JITing, and subprogram ju=
mp
table reallocation when a program uses a large number of maps.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index c16b4a283dbca..92dc8d0dc22a5 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -366,13 +366,14 @@ static int __compute_subprog_jts(struct bpf_verifie=
r_env *env)
>  		}
> =20
>  		old_cnt =3D subprog->jt ? subprog->jt->cnt : 0;
> -		jt =3D bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
> +		jt =3D bpf_iarray_realloc(subprog->jt, roundup_pow_of_two(old_cnt + jt=
_cur->cnt));
>  		if (!jt) {
>  			subprog->jt =3D NULL;
>  			kvfree(jt_cur);
>  			return -ENOMEM;
>  		}
>  		memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
> +		jt->cnt =3D old_cnt + jt_cur->cnt;
>  		subprog->jt =3D jt;

[Severity: Critical]
This problem wasn't introduced by this patch, but can jt_cur->cnt << 2
overflow its 32-bit signed int type here [1]?

When an INSN_ARRAY map is configured with a large max_entries value so that
jt_cur->cnt is at least 1 << 29, jt_cur->cnt << 2 overflows into a negative
int and sign-extends into the size_t length passed to memcpy(), causing an
out-of-bounds memory access.

Similarly, bpf_copy_insn_array_uniq() computes u32 n =3D end - start + 1 and
passes it to sort_insn_array_uniq(), which takes a signed int cnt and passes
it as the size_t element count to sort():

kernel/bpf/cfg.c:sort_insn_array_uniq() {
	int unique =3D 1;
	int i;

	sort(items, cnt, sizeof(items[0]), cmp_ptr_to_u32, NULL);
    ...
}

kernel/bpf/cfg.c:bpf_copy_insn_array_uniq() {
	u32 n =3D end - start + 1;
    ...
	return sort_insn_array_uniq(off, n);
}

If n exceeds INT_MAX, cnt becomes negative and sign-extends in sort() into =
an
out-of-bounds sort.

[1] https://sashiko.dev/#/bug/linux-cb5b5936-948b-46ff-9eb4-c71357c19248

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D8

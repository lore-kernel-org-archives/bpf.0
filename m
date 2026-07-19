Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B213AA9DA
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476108; cv=none; b=F9xDtK2mYb7tilkFv+b9almiIeavDjnQHRNJYtfl4NBY2vzYgxuTzkaQS8Z0vgA6JhcO/z1v62apMPQoKdL9V/6Bi4fk1sQPb2CR3WMB0Rfnu3ll2s1MuGiRKPPaSW9fhVcKnCtm1kke5SDWguEqaFnDBr9VHHHfoJsMYsujiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476108; c=relaxed/simple;
	bh=jQaD8PRMWKovOaniB8I1GBmLfiXIK0f+wYeWw+8tjB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HbH7UJx+88E4O2tRbJoFgUqyVaDrMw7c/ebpxuhogTPBSZeV3xx2gPNjqk4VnmCRTVwQ1Y/NOlKlbI3jPmOjf8j2M/zLlfUibZuMoVj6y3zSz7vtEH/nQ7vaq5OyCEHrD2oN0eOn/7fItBQ25L+tjk6O6LxKt1AdMJLSd/f5y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDkTpFVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDkTpFVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DA51F000E9;
	Sun, 19 Jul 2026 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784476107;
	bh=yZUjJeNbCbJOTkLL5nJppQxjXnwy6R3W/OCITAJ3n7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDkTpFVS5ZpN4qLWFTGJhslTLvRQXNYBzARwU5NIww0SEwNALFmGasoIijsHt3xcX
	 KfRd9yN+g5K/EK6JiUboo+a0vrG88/Yb7kssHWwzwgBSKBjHPZfmXfdbwuIaItZWtH
	 Cy8i/pEoZtTIvtmG+ELJ+TxuP8/R2T4FhmWrJdp2K0LP/QZxq6uX5RTm5qjt/3KeFv
	 GG7RnX30c0gLC31kMgmW0lTSFrX0/fZgxWsqpg60ALl7+go8bFSG5c2OPDYT2DdCpx
	 ydotN4aDZFT9+xwn2MnEHjgWeoODPDEF0BIP4aLV+Om3AyBMCK1SXlWfJCbvBNc+9P
	 IoR5zLj+KYBiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Fix offset warn check for
 bpf_res_spin_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719153634.2908692-2-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
 <20260719153634.2908692-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 15:48:26 +0000
Message-Id: <20260719154827.54DA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Userspace-triggerable kernel warning (WARN_ON_ONCE) due to nested =
struct bypassing `seen_mask` uniqueness check, potentially leading to kerne=
l panic.
--

--- Patch [1]: [PATCH bpf-next v2 1/5] bpf: Fix offset warn check for bpf_r=
es_spin_lock ---
commit f617fbd9a79f403f8e8be07c38922dcd0eedd840
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Fix offset warn check for bpf_res_spin_lock

This commit fixes an incorrect offset check for BPF_RES_SPIN_LOCK in
btf_parse_fields(). It now correctly checks res_spin_lock_off instead of
spin_lock_off.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index cbb1e49b9bcbf..e7d4e9ba24e26 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4168,7 +4168,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
>  			rec->spin_lock_off =3D rec->fields[i].offset;
>  			break;
>  		case BPF_RES_SPIN_LOCK:
> -			WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
> +			WARN_ON_ONCE(rec->res_spin_lock_off >=3D 0);

[Severity: High]
This is a pre-existing issue, but could this WARN_ON_ONCE() be triggered
from userspace and cause a kernel panic on systems with panic_on_warn
enabled?

If a crafted BTF with multiple identical unique fields (like
BPF_RES_SPIN_LOCK) is provided in different nested structures, it appears
btf_find_struct_field() resets seen_mask to 0 for each nested level:

kernel/bpf/btf.c:btf_find_struct_field() {
	u32 i, off, seen_mask =3D 0;
	...
}

This could allow duplicate unique fields to bypass the seen_mask check and
be returned to btf_parse_fields(). When iterating over these duplicates
here, would it hit this WARN_ON_ONCE() and panic the system? Should we
return an error instead of warning, or pass seen_mask down during the
recursive struct traversal to prevent this?

>  			/* Cache offset for faster lookup at runtime */
>  			rec->res_spin_lock_off =3D rec->fields[i].offset;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719153634.2908=
692-1-memxor@gmail.com?part=3D1

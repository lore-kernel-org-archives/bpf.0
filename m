Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6D38E8BA
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464178; cv=none; b=BPdI/wGS6AOjDMbeoQKH2ntXYVRFhNIheoIFGh6ZE7fltPY+l9HFK4MKiWHebZy3Lc4RrFk0dt8Yaqy76D8aCtTgMJ/tLOT+ngl+pbFmFo2b9GiTOMZjLVjrSuU3w7ZF6QgcheufrGJaJxQuYyFik4FFMi/czl2yT8Q9pZ7n9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464178; c=relaxed/simple;
	bh=hN8SuF8OLSzbcLiJlJGWjoQsZ2HQuXOMARiUFW5Ljdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=drL09gIh2eWlAxrNwjGUDRrDalS0Aj0SEZJTDx01UGjtmj1z1dY57awnVaa4cV+3C2kXfTgFWAfStuxJiRPxwreaOcOCZvNYhFWBZ/QhIE8xBMtAt59pCIfAuS1yTkUZ1/cVvcdW8dNz83iL2G9L7k8VOv4a95aGKkNt8Nn5wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FosEudP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FosEudP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FDD1F000E9;
	Sun, 19 Jul 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784464177;
	bh=uUFzx+MnG0gAguZEwyJc7B7OLom88tSRN4gJvNpxr/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FosEudP5mELZvRFMLkjvupab99K6U4CXvpyssR1QSWBX9GZ4a8JeaqxnIRlPhmmmT
	 kvYbOk00k6NHcmvskByeIKYNbx7uQZ7hadqNfQhKXwCt60d/aO3BXsuSCxJxukXLoh
	 E0wOD31quC2jKuLw+YR5x5eexg8hwYndpS7DIbL/ABihJqvA/EtyVP29CnX/4JRQWE
	 uAhSDTUUN9IfabI2IvbfTMoDPo4L2qWAEQSRt0ilillzMm/YuwDzj3kMM8pyz97E1M
	 LT3xY4Fv5Q6sRvZBpnmoNHBvprlXFV+mPfDvzAk2qqQg1Kc1GKedzyWZQ12nnFFJTQ
	 EU/iDb84AADxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix offset warn check for
 bpf_res_spin_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719121740.1547434-1-memxor@gmail.com>
References: <20260719121740.1547434-1-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 12:29:36 +0000
Message-Id: <20260719122937.03FDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprivileged users can trigger a `WARN_ON_ONCE` in the kernel (cau=
sing a panic on systems with `panic_on_warn` enabled) by supplying a crafte=
d BTF with duplicate unique fields hidden inside nested structs.
--

--- Patch [1]: [PATCH bpf-next] bpf: Fix offset warn check for bpf_res_spin=
_lock ---
commit 5f18853b127e7eb3f89c39c50e8644777d002289
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Fix offset warn check for bpf_res_spin_lock

Sashiko pointed out correctly that the case statement for
BPF_RES_SPIN_LOCK incorrectly checks offset for BPF_SPIN_LOCK.
Fix it by checking res_spin_lock_off instead.

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
This is a pre-existing issue, but can unprivileged users trigger this
WARN_ON_ONCE() by supplying a crafted BTF with duplicate unique fields
hidden inside nested structs?

Looking at btf_find_struct_field(), it enforces the uniqueness of special
BTF fields using a local seen_mask variable:

kernel/bpf/btf.c:btf_find_struct_field() {
    ...
    u32 i, off, seen_mask =3D 0;
    ...
    ret =3D btf_find_field_one(..., &seen_mask, ...);
    ...
}

However, when it encounters a nested struct, it recursively calls itself
via btf_find_nested_struct(). This nested call initializes a fresh
seen_mask =3D 0, ignoring the parent's state.

If a user crafts a BTF with multiple nested structs containing duplicate
unique fields (like BPF_SPIN_LOCK or BPF_RES_SPIN_LOCK), wouldn't these
duplicates bypass the seen_mask checks and be returned to
btf_parse_fields()?

Since btf_parse_fields() processes these duplicates and hits this
WARN_ON_ONCE() macro, could this act as a local Denial of Service (DoS)
vector on systems configured with panic_on_warn=3D1?

>  			/* Cache offset for faster lookup at runtime */
>  			rec->res_spin_lock_off =3D rec->fields[i].offset;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719121740.1547=
434-1-memxor@gmail.com?part=3D1

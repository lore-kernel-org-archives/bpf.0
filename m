Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC3390609
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672237; cv=none; b=rnIGstCGlYQyK5hkaLtq1qNiZ7ZqNLxTjmGTsNhx/oR9MdqqBD6DgfuyawR+nyXB1Z1e6gbVfpAKDqDARujaW2vIdBmRKA51zVc9+4sRPnSlHdI7fLkosNKGBp3Y0VdTYos8y9LtQ60PVKgGMbhpXhDDDdBmf/xcP+6eiXOCvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672237; c=relaxed/simple;
	bh=dc7zEFV5ABo4kthe0GvUWkiXml7HkLUOnpn/feHLLM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lAFbJHN+zHi3E3up1SRoLdDxJIGNHaFtOSu2C6Sl+o/3ynqaTZGe3/a/Vzh4wfbFQ5Afz0/B30u6fyPd8tUcLEtxXPBapaZSaz2EEHtDUesIrOAXZzY9i52tNVImZj6ERchgD518mmUs2Cn9Nwh3HyBrSqHvOoGytzzZiWjAEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaZfc9rY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaZfc9rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B0D1F00A3A;
	Fri, 14 Aug 2026 01:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672235;
	bh=vnjm3Pb0E4wzP7Fbx1ECQErbbdr/cBBN+Le7lrpbdSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaZfc9rYRO+Bn3YI751WO9EyxKdfGCxjTGUnayO1sTQSHZ/LrsTwdcglzhrY+LfQT
	 zDvDqSyp9PVuNX3VmUW7uap4BBgChuVgHqJXlYrNlGbWr9uhmHpIfCoRZ+5QrexilY
	 gvgsETv5FqedrHgA4ZaJZtNc8kO40SJJ4IMSKKF2KfOzb3jfkKGQmXwjDS3x4XPi+H
	 Ddi20asIUrw8Zh6bFWM0VWx5uQoDRaLcuKrtEECufqAQA/4P1/n+KDeIvnZJBYv87S
	 x0xVhPTfoHodqUK8HbMRYWraLu5qQ/bFou0jZbwQmcBYTpT85rKUIWPYvl8RszmtFa
	 pMMYPCj0qYazw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Reject untrusted allocated-object
 pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ning Ding" <dingning04@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813211533.290256-4-dingning04@gmail.com>
References: <20260813211533.290256-1-dingning04@gmail.com>
 <20260813211533.290256-4-dingning04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:50:35 +0000
Message-Id: <20260814015035.98B0D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing Invalidation / Use-After-Free: Untrusted non-owning re=
ferences bypass invalidation on bpf_spin_unlock(), leading to a kernel pani=
c upon subsequent memory access.
--

--- Patch [3]: [PATCH bpf-next v4 3/4] bpf: Reject untrusted allocated-obje=
ct pointers ---
commit 7424ccf28aa2cdb4011681f68f04f8f438496194
Author: Ning Ding <dingning04@gmail.com>

bpf: Reject untrusted allocated-object pointers

type_is_ptr_alloc_obj() treats PTR_UNTRUSTED pointers as valid allocated
objects, allowing unprotected pointers to be passed to bpf_refcount_acquire=
().
This patch makes type_is_ptr_alloc_obj() reject PTR_UNTRUSTED to prevent
acquiring references through stale memory. It also adds a new helper for the
read path where these pointers are still allowed for BPF_PROBE_MEM reads.

Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 27b43fda9b178..22fcd01c3cceb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1341,7 +1341,16 @@ static inline bool bpf_type_has_unsafe_modifiers(u=
32 type)
> =20
>  static inline bool type_is_ptr_alloc_obj(u32 type)
>  {
> -	return base_type(type) =3D=3D PTR_TO_BTF_ID && type_flag(type) & MEM_AL=
LOC;
> +	return base_type(type) =3D=3D PTR_TO_BTF_ID &&
> +	       type_flag(type) & MEM_ALLOC &&
> +	       !(type_flag(type) & PTR_UNTRUSTED);
> +}
> +
> +static inline bool type_is_untrusted_ptr_alloc_obj(u32 type)
> +{
> +	return base_type(type) =3D=3D PTR_TO_BTF_ID &&
> +	       type_flag(type) & MEM_ALLOC &&
> +	       type_flag(type) & PTR_UNTRUSTED;
>  }
> =20
>  static inline bool type_is_non_owning_ref(u32 type)

[Severity: Critical]
By rejecting PTR_UNTRUSTED in type_is_ptr_alloc_obj(), doesn't this break
type_is_non_owning_ref() for untrusted non-owning references?

If a BPF program obtains a non-owning reference to a refcounted object insi=
de
a bpf_rcu_read_lock() and bpf_spin_lock() section, the pointer type is
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU.

Calling bpf_rcu_read_unlock() clears MEM_RCU and sets PTR_UNTRUSTED.

Then, when bpf_spin_unlock() calls invalidate_non_owning_refs(), it appears
the untrusted non-owning reference will not be invalidated because
type_is_non_owning_ref() now returns false.

This could allow the untrusted pointer to survive the lock section. Later
memory reads on this register would fall through the switch statement in
bpf_convert_ctx_accesses() because it does not match
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | PTR_UNTRUSTED.

Would this result in a native load without PROBE_MEM fault protection,
potentially causing a kernel panic on freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813211533.2902=
56-1-dingning04@gmail.com?part=3D3

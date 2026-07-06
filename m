Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591A379C2F
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348065; cv=none; b=mUnRm21tpdGjrg7Juk+qkNPQpWRv3iyHR7aCVqoFz6kNDds5rj6wC6jYEAwFYc+BWsnG/nCDTid7ZyfhcoYRNn7s8F5UG2qZXKowTWZrQDGv2x5FIPQ9jy8Y2Lkor0KsRYafesm6YdFm8ITSyzE83U76wXIlp1j8/HeqPuGOR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348065; c=relaxed/simple;
	bh=Zte1zo1dQKoTFI+EMMFTWaWSKTb6f3RC5+UcwEgFuPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwDnaHNOmfMBkDQLRU+EoHYX6D6H5ka55zwFh+Y88rWUVSniqTAd6h9T2kZnFgCu6oDyL1ItxMmU+RML+5r9Lb61mwUJyhQGgN44OpS6m6XUOoVnTVHE4AcXVOIBBNhqkEgPc2mV6nhOGo+QOK53bUt8ISrKGU9siFcliE8G+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZUfCrjc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZUfCrjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1777F1F00A3A;
	Mon,  6 Jul 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348060;
	bh=mJexkvB2usKKX+6w1X6p4rTZhq9fZxLx3dX+bSS2c4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZUfCrjcwABmDA73QkkqI3ZdZ1rBL0DXnznhgWRXhKz25y82t7RJHx/I3PH8Fi++k
	 3C6T/KLOJ/gaA/3pO3iIIAGKCLHV/oMgf9v4MfQv0IZ9mFFtObH6ap/BlTZ+Vl3A6K
	 pAL9lyZzzoIKVt8YoCMwesT3/XJpMiEV0rY26jJpqzqnPliR9aP5U1PzusJj4rYzWo
	 1KeNiw4Z1yewyIzAj+U+saI7yyFRXRZYpnXfobA9+VQRoWT9HdtKuYSjGOVGqo6K5H
	 S+1pAGduVF+Os2TxTknXgrwEls0cBzkgg9z8bu69E+Xw/SfZodtff+nqnyUbO9OUFl
	 2L70enoLxo1bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 7/9] selftests/bpf: Adjust bpf_map layout in
 verifier_map_ptr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706135644.326006-8-daniel@iogearbox.net>
References: <20260706135644.326006-1-daniel@iogearbox.net>
 <20260706135644.326006-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:27:39 +0000
Message-Id: <20260706142740.1777F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The removal of the `excl` field from `struct bpf_map` breaks b=
ackwards compatibility for existing, previously compiled userspace signed B=
PF loaders (light skeletons).
--

commit c88125fac4570eca959a997d221adcd929990142
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Adjust bpf_map layout in verifier_map_ptr

This commit updates the verifier_map_ptr selftest to reflect the new layout
of struct bpf_map. It adjusts the offsets and expected error messages to
account for the ops pointer moving to offset 32 after the removal of the
excl field.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index 1661936598703..e0a65835c861b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> @@ -72,14 +72,15 @@ __naked void bpf_map_ptr_write_rejected(void)
> =20
>  /*
> - * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a rea=
dable
> - * byte array), the u32 excl field at offset 32, and the ops pointer at =
offset
> - * 40. Reading a u32 at offset 41 reaches into the middle of the ops poi=
nter,
> - * i.e. a partial pointer access, which is rejected.
> + * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a rea=
dable
> + * byte array), followed by the ops pointer at offset 32 and the inner_m=
ap_meta
> + * pointer at offset 40. Reading a u32 at offset 41 reaches into the mid=
dle of
> + * the inner_map_meta pointer, i.e. a partial pointer access, which is
> + * rejected.
>   */
[Severity: Critical]
Does this structure layout change introduce a regression by breaking backwa=
rds
compatibility for existing userspace signed BPF loaders (light skeletons)?

Older versions of bpftool generated a loader program that included explicit
BPF bytecode to verify the metadata map via a 4-byte read of the excl field
at offset 32. To support this, the kernel previously pinned this offset usi=
ng
BUILD_BUG_ON(offsetof(struct bpf_map, excl) !=3D SHA256_DIGEST_SIZE).

By removing excl without retaining 4 bytes of padding, the 8-byte ops point=
er
shifts to offset 32 in struct bpf_map. When an old loader attempts to read 4
bytes at offset 32, the verifier sees a partial pointer read (since 8 !=3D =
4)
and unconditionally rejects it:

kernel/bpf/btf.c:btf_struct_access() {
    ...
    if (msize !=3D size || off !=3D moff) {
        bpf_log(log,
            "cannot access ptr member %s with moff %u in struct %s with off=
 %u size %u\n",
            mname, moff, tname, off, size);
        return -EACCES;
    }
    ...
}

Could a 4-byte padding be added to maintain backward compatibility, allowing
old loaders to safely read the padding while the new kernel securely handles
the load-time verification?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706135644.3260=
06-1-daniel@iogearbox.net?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3283B813E
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222855; cv=none; b=Je0wYk8RGFcBRaSc7VZ4ZcZTgru61YGt4CcZLXu2slLNGewowyHPMtXtiR4dY6md/fWGl9JsrXR5O4mrO0kxN+OKXtOipX7q52J7Ge9mKnKsxWFcL764b+4PBfLYZGX+MrmE+Ew3Zb7GL/t8P4+0NXEGcS5ErXjdn4I9eohlEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222855; c=relaxed/simple;
	bh=1wemuly0fv73DYvh+b9bnboi5v5P2NQBwVj823s9/lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIC1FpGbcAF5bBqyr7a4q7LFiKZh+YZUY4ZBpYPLPIocWSvlI9chVHYHvSaDEIqWZCss9uwTs54AyZqaMl2SbMu3YVWalZBhgvhxWkfLo6EdFkhwWzgl2FOWT95UkksvG2asDDc/Tz6MEX65Xnxnx8C+qKvlido5coDZdhkCzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgjbpcSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgjbpcSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B71F000E9;
	Tue, 19 May 2026 20:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222853;
	bh=xOWVl2ZnQypco/sChPAAI8dgFEPDhybFevaXZFY0vhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UgjbpcSRmz99GaQQqip4ssr6+LBW2p76Rdm6FN+g4VaVg7mmxSDdYcXSozaecizsI
	 ZsyWwwSsGxUxI/aUOrlPaK5N4EFqPQhMXGq8pdJ/WrJtVNaMLOEDg3kygZWU0WAVWB
	 Nwl6grHC+7N7TLvVUJ95nujHWm1mnuwHpgPBUPowZ1BHl903kYfE7zFe8hGOFYkfqv
	 L25Ra7TG+nJwr1vg/EY8Bfdn0PpzFud1Q4h0sg8kev/5Fa9d3byX2YV8jS3ikjo+rE
	 70yXgp5Hzl0mUvXelJajXdjeFXQ2qu7n/xGeUfVRoA9BEPO2aeli/dg5rxeFta8iaw
	 9ndbBh0kiFb8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] powerpc/bpf: Move out dummy_tramp_addr after
 Long branch stub
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519233812.18787-3-adubey@linux.ibm.com>
References: <20260519233812.18787-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 20:34:13 +0000
Message-Id: <20260519203413.AA2B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch: The patch fails to =
exclude the last 8 bytes from the overall program length, despite the commi=
t message claiming it does.
--

commit ba8b98dfdd35a5bb47f0ad30755a56bb74e290d8
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: Move out dummy_tramp_addr after Long branch stub

This commit moves the dummy_tramp_addr field to the bottom of the long bran=
ch
stub in the PowerPC BPF JIT. It updates the dummy_tramp_addr field offset
calculation from the end of the program to reflect its new location.

> powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
>
> Move the long branch address space to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. Exclude these last bytes from the overall
> program length to prevent failure in assembly generation.

[Severity: Medium]
Does the code actually exclude these last 8 bytes from the overall program
length?

Looking at the patch, there are no modifications to jited_len or any
subtraction of SZL (8 bytes) from it. The 8 bytes of dummy_tramp appear
to still be included in the final program length returned to user space.

Because of this, standard tools like bpftool prog dump jited might still
attempt to disassemble the trailing 8 bytes of data, which can result in
incorrect instructions or disassembly failures.

While a subsequent patch in the series works around this issue by truncating
the length in the selftest's disassembler wrapper, the kernel still returns
the full length, leaving standard tools exposed to the disassembly failure.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 00b86ed97cb56..56a923d3908e1 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
[ ... ]
> @@ -1404,10 +1407,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_po=
ke_type old_t,
>  	 * 1. Update the address in the long branch stub:
>  	 * If new_addr is out of range, we will have to use the long branch stu=
b, so patch new_addr
>  	 * here. Otherwise, revert to dummy_tramp, but only if we had patched o=
ld_addr here.
> +	 *
> +	 * dummy_tramp_addr moved to bottom of long branch stub.
>  	 */
>  	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
>  	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
> -		ret =3D patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub -=
 SZL),
> +		ret =3D patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_=
addr offset */

[Severity: Medium]
Additionally, if jited_len had actually been reduced, this new calculation
using bpf_func_end - SZL would become incorrect, since bpf_func_end
relies on jited_len encompassing those 8 bytes.

Could the commit message be updated if excluding the bytes was left out, or
should the length calculation be adjusted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519233812.1878=
7-1-adubey@linux.ibm.com?part=3D2

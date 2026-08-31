Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2213C3F67
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161738; cv=none; b=rrFscKoci2/Ke0Ixu7swa7bgxnZmk5uq9gizB0Xog5HsYpQ4eKA0UVSR9xRbQVxYREjg/W8GwtynJlf2ADoT5on5+w9UL8zJSHFFg2Aw2A2E7aMMBE9UWsmterb3aUye9ApGECQ7pQo2rmXxKnrf28tkUsR/160v+aHb3PGqCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161738; c=relaxed/simple;
	bh=Y+dP9yGZSDdtpUINZ7xkgv3iVpj9sDZSK6RaW1AtO0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzPPnlqGTWFXvPC9I9OYqJpTLUokNs5LWOWVXcMkJzxd0MZ7KmtKUppT4rYzdivSV6BnUWToPdYzDxWclke5xWo2iyyuOW2XjE7juXtkM7L3Ju3sCHICqvDcdzkHTrxQyA2FKXkIZmdWKnaVGkLuPRmvZ27TLgVpmMOK0EOej/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbZ9/QSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbZ9/QSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CEA1F000E9;
	Mon, 31 Aug 2026 07:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161736;
	bh=NUXqbyD41XEXGyp2w3fylYoBp1MLXrNMuLX/gxh5JGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbZ9/QSfF/TwYfAcFbiiydjqH8NSb8u8LX4ZZGqOir/Q855mQHBlzasM1mpVcEdeE
	 vY6I+gn5rLE+vUs1gb+33Lu9K3t80A1yhDVveA4i1bwv1GRu2iXums7diMlLL4C2F6
	 yu13urovih8tIUcwr4bkuVh58IL6jk/J7Strs28/igoqYpp1WmqyCtAyjdlgnhuPFA
	 Zdw2omPqvnM/ua1MREGoKKGscNHCoW+OH20oIRPPVzRLPSBEYqHVoy8J9lWt/nQGfd
	 6qOSxa8GkXATLp5Zse12DWyiNh22ad8+Hf51LNCWsgDDBtgXeRyq42zb2J25yfdb9i
	 4KaK0ovGQyOzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/8] powerpc/bpf: Move out dummy_tramp_addr after
 Long branch stub
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:35:36 +0000
Message-Id: <20260831073536.85CEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting boundary asymmetry in branch range validation causes s=
ilent failure and NOP patching when trampoline targets are exactly 32MB awa=
y.
--

commit 5b58234b51abd3de6209e164ca3ba6723fb0f569
Author: Abhishek Dubey <adubey@linux.ibm.com>
powerpc/bpf: Move out dummy_tramp_addr after Long branch stub

This patch moves the long branch address field to the bottom of the long
branch stub to prevent disassembly failure. It updates the dummy_tramp_addr
field offset calculation from the end of the program to reflect its new
location.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 8ca36a933c7ae..c2717f0d9cdd4 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
[ ... ]
> @@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_po=
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
>  				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
>  				  (unsigned long)new_addr : (unsigned long)dummy_tramp);
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but looking at bpf_arch_text_poke(), there
appears to be a boundary asymmetry in the branch range validation just above
this hunk.

Earlier in the function, the offset is calculated as ip - old_addr and
ip - new_addr:

	if (old_addr) {
		if (is_offset_in_branch_range(ip - old_addr))
			create_branch(&old_inst, ip, (unsigned long)old_addr, branch_flags);
		else
...
	if (new_addr) {
		if (is_offset_in_branch_range(ip - new_addr))
			create_branch(&new_inst, ip, (unsigned long)new_addr, branch_flags);
		else

While in the hunk above it correctly calculates new_addr - ip and
old_addr - ip.

Does this cause silent failures when trampoline targets are exactly 32MB aw=
ay?

If new_addr is exactly 0x2000000 bytes ahead of ip, the true offset (0x2000=
000)
is out of range. However, ip - new_addr evaluates to -0x2000000, which
is_offset_in_branch_range() incorrectly sees as IN range.

If this happens, the code enters the block and calls create_branch(), which
correctly calculates the true offset, fails its internal bounds check, and
returns an error.

Because bpf_arch_text_poke() ignores the return value of create_branch() in
this path, does this leave new_inst as a NOP?

If so, bpf_modify_inst() would silently patch a NOP into the execution path
instead of a branch to the long branch stub, dropping the BPF call entirely.

Similarly, if the target is 0x2000000 bytes behind ip, the true offset
-0x2000000 is valid, but ip - old_addr evaluates to 0x2000000, incorrectly
triggering the else path.

Could this mismatch cause bpf_modify_inst() to fail (as the instruction
currently in memory is a direct branch, not a stub branch), leaving the sys=
tem
unable to detach the BPF program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788154635.gi=
t.skb99@linux.ibm.com?part=3D5

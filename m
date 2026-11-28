Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830420;
	b=BFcZ9Qc+z8TKOV8rGc5INF/v3hllvxPEPTzg3byKOIAv7PMg6QpNUuY52bzxcFBfCQfw
	 1kkDR/6IqejwOWhvf3XpBQEUhcgiAOcax3QWTZCBochUtfldAh92uzXRDUscBCRTLBf1M
	 XwD5MxXVLO4x9zXMtg9g5tjjX6YLO6skjnzorqEZ64g38H5K4AMlj0POg2aJpgJfqxNYX
	 Oq7cnZGlj1y3VoNQWVreeV4Vbmfzhwt/sRz5JfGzgMDkz7w9xakwpSFu5Avn/v3qS6yFk
	 cA7qZL6YYnaHKx3yNxKDPHBtoPK/yBV9BfpX5gkjRDofR+rhMoRNxVrz4GBMmYXGf/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uSihf4eP5gfyaPDgJaxYlSI6t6g19Kro1GUFW/Ps2Cc=;
	b=zSmcgoPKKvumf/WptNZBu9YERLeD6TS94Ua+n9lXYvwpYBbyollUKF1q8NnmRbJTmAwU
	 JjnRN3UIA3STIvTj1Nt0kqKDkKs91XPFGSWh1Lt3eeC65q4Y7MGOzisa+7mVBIO4/KP8B
	 xzwVbA6GlWMchXapWj1XOqQD+IQK1Ed0OSREDtZt+FxzUkJOOw7/IzTBbTnITYnUwrTo0
	 KwfRzIvmntbd7jTCRcjblMBHO0pYqhcRBDiJW4smjPacfuO0gyWX3VtIMLlZW5+tQcGQa
	 lKKtGZk2i+ZN42k9YSJFBCcI3O+38kginZkDnrlum0stwLZ2BrwCpCnQNIJXtvjroWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9urTLJh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292A606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9urTLJh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE52D1F000C1;
	Sat, 28 Nov 2026 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830420;
	bh=uSihf4eP5gfyaPDgJaxYlSI6t6g19Kro1GUFW/Ps2Cc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=P9urTLJhI7LHytw1b2UETApYdYEM5GsKn0ywc+Ow5MX3cSW0exJlhIZH5s2vavAKb
	 Gh6wPkKICSpYuAKiOEYZrYujU6GXOsJYHUWHW23m5D5Yi9Rv08p+2y08sWME5cU0Hg
	 GBSBLpR2K9CZKUyLTyTyp1s8SGob1zRVpM0RxCEAQOXFt2sA8JqLKNXYZJHCjYMnqH
	 0RuOlHzJD4SLv/SnH2oZH347rIg8vDfoUWHpfNb5DFbQOsKzAOp2IqIcj7fpR7hcBj
	 q7uFTWWmI72SpUDDyzY96tPWl8jDMVjMHslUOmDBQGc+UJ6U6W3u5ZwtWHFOMvi7qY
	 7bRKThuFbIXwQ==
Message-ID: <sashiko-outbox-238412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <0a30eeab6bea7ddfc0202d1970ab1b7f3a4d580c.1795829324.git.memxor@gmail.com>
References: <cover.1795829324.git.memxor@gmail.com>
 <0a30eeab6bea7ddfc0202d1970ab1b7f3a4d580c.1795829324.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 01:46:59 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] x86/mm: SMAP does not fault on supervisor mappings below
  TASK_SIZE_MAX
--

commit 9b387754d627ac256ae9705ce7d6a4e7a2935051
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

x86/mm: Resolve BPF exception fixups for user address faults under SMAP

This commit resolves EX_TYPE_BPF exception table entries on kernel-mode read
faults in do_user_addr_fault() under SMAP, allowing the x86 BPF JIT to omit
its software range check before PROBE_MEM loads.

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index aa88370ce7394..9fe8705eff043 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1263,7 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		     !(error_code & X86_PF_USER) &&
>  		     !(regs->flags & X86_EFLAGS_AC))) {
>  		/*
> -		 * No extable entry here.  This was a kernel access to an
> +		 * The CPU refused the access. If the BPF JIT marked this load
> +		 * as one that may fault, skip it and zero the destination.
> +		 */
> +		if (!user_mode(regs) && !(error_code & X86_PF_WRITE) &&
> +		    ex_get_fixup_type(regs->ip) =3D=3D EX_TYPE_BPF &&
> +		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
> +			return;

[Severity: Medium]
Can relying on SMAP to refuse PROBE_MEM loads below TASK_SIZE_MAX allow rea=
ds
from supervisor mappings in the low address range when a temporary mm such =
as
efi_mm is active in CR3?

SMAP only faults when the page-table entries mapping the linear address have
_PAGE_USER set.  efi_setup_page_tables() permanently maps 0x0..0xfff 1:1 in
efi_mm.pgd without _PAGE_USER, and efi_map_region() likewise creates 1:1
supervisor mappings below TASK_SIZE_MAX for EFI runtime and MMIO regions:

arch/x86/platform/efi/efi_64.c:efi_setup_page_tables() {
    ...
	pf =3D _PAGE_NX | _PAGE_RW;
	if (sev_es_active())
		pf |=3D _PAGE_ENC;

	if (kernel_map_pages_in_pgd(pgd, 0x0, 0x0, 1, pf)) {
    ...
}

While arch_efi_call_virt_setup() has efi_mm loaded in CR3 (with LASS disabl=
ed
and interrupts and NMIs enabled), a BPF tracing program executing a PROBE_M=
EM
load through a NULL pointer or into a 1:1 EFI region will not fault into
do_user_addr_fault() and will instead read physical page 0 or trigger an
unintended firmware/MMIO read rather than zeroing the destination register.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795829324.gi=
t.memxor@gmail.com?part=3D1

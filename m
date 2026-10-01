Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788128B7EA;
	Thu,  1 Oct 2026 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815524; cv=none; b=NGKaVkDWNxZj5PO7mnsHh/wNAGUf2+Gf98zu05ERkyz4iyTMyJveqJGVHd43XgCSbVcKtUGbE1QR2NI2l3wjWkpvSW3T76bMoJChIekm+JKRrQ1w+24NxFw7awpty9JfM7HJl4huWz3NQWK6yGlOdEJISzJaqI/kYBX8PpmMeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815524; c=relaxed/simple;
	bh=BhisNan7F9TGHYQyZGINhML9TnHNORLgubZORUS2DXY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GXK//LtwOn6z+/10kWu8HYFsgj4Qgbew828aDVV+F86Rlfkq/L5Gqx7rzZpNlolNS9t+I+flc6oinGBfkGq+p+U1aaevW5iG4HE5XRjC72BeHt6eLnReJOxlFydBeqY2Rgd1LkEBea3EQLaHM8diSZvVQ+2IW2SFDQR7jKzHFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V24eQ7Nt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V24eQ7Nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7811F000FF;
	Thu,  1 Oct 2026 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815520;
	bh=2smmW3wvvGrWN5XipL/4yPgudrrGxYefW4D9XCLIuXs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V24eQ7Ntb7FXccvKOc+dxghlFokA7s+863LWUSBA5MtsaGf1lxSsU2VtdzP6AfLeH
	 Wq+VAj3Rp2ZH92HyTqjQ6KDKW8UNVaUJii1TG8Q/U/Cmu510VL9RicPQC17vNhSM+v
	 anaSXx32IH74weCbSAQtXbSE4Vs2/CSq3B4dtoW8nXoWqHYm7H5k35spEayAGOT/Lp
	 0f0OjAuzBFs+NGZyaq5pc2nPV33ysicGNkrFvJyaD7Bss1cx+/kUPdoBdoFYiFpUdD
	 OmaDomS4BWPv8UK9JsYGlLfjdEdy1EpnW1TyevcA3/LMxtExduyC0EYJyef4M54dVT
	 F2h5Q2F5F+uGQ==
Content-Type: multipart/mixed; boundary="===============6479455916182214820=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c26e2afbfa2cd71b2cf8bb0e963bb1d67dc5519bb5c4307c96b826ae5fdce269@mail.kernel.org>
In-Reply-To: <20260930132109.260597-3-david.laight.linux@gmail.com>
References: <20260930132109.260597-3-david.laight.linux@gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: Optimise symbol name search
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,akpm@linux-foundation.org,pmladek@suse.com,kees@kernel.org,david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ljs@kernel.org
Cc: thunder.leizhen@huawei.com,mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 00:45:19 +0000 (UTC)

--===============6479455916182214820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Optimise symbol name search

TL;DR:
- kallsyms 24-bit table struct may be padded to 4 bytes on ARM OABI, giving
  wrong offsets and a possible out-of-bounds read
- weak table symbols may not read as NULL on relocatable x86-32, so the wrong
  table may be chosen

> diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> index 81a867dbe57d..be503f3f993f 100644
> --- a/kernel/kallsyms_internal.h
> +++ b/kernel/kallsyms_internal.h
> @@ -13,6 +13,8 @@ extern const char kallsyms_token_table[];
>  extern const u16 kallsyms_token_index[];
>
>  extern const unsigned int kallsyms_markers[];
> -extern const u8 kallsyms_seqs_of_names[];
> +
> +extern struct { unsigned int v:24 __attribute__((packed)); } kallsyms_off24_of_names[] __attribute__((weak));

Is this struct guaranteed to be 3 bytes on every architecture?

The packed attribute is on the bitfield member only, not on the struct.  That
reduces the member alignment, but it does not stop an ABI from padding the
struct size.  On ARM OABI kernels structures are padded to a multiple of 32
bits.  Documentation/driver-api/ioctl.rst says "On ARM OABI user space,
structures are padded to multiples of 32-bit", and GCC applies
STRUCTURE_SIZE_BOUNDARY unless the record itself is packed.

OABI kernels can still be built.  arch/arm/Kconfig offers AEABI as optional
for CPU_SA110 || CPU_SA1100, and the assabet, footbridge, rpc, neponset and
netwinder defconfigs all have '# CONFIG_AEABI is not set'.  For those builds
arch/arm/Makefile compiles with -mabi=apcs-gnu.

In that configuration sizeof(kallsyms_off24_of_names[0]) would be 4, but
write_src() in scripts/kallsyms.c still writes 3 bytes per entry:

    printf("\t.byte 0x%02x, 0x%02x, 0x%02x\t/* %s */\n", ...

get_symbol_name(index) would then read at 4 * index instead of 3 * index for
every index > 0:

    if (kallsyms_off24_of_names)
            return kallsyms_off24_of_names[index].v;

That returns garbage offsets, and for the top quarter of the indexes it reads
past the end of the table.  kallsyms_lookup_names() and
kallsyms_on_each_match_symbol() would then compare against arbitrary
positions in kallsyms_names, which can be up to 16 MiB past its start, so
lookups fail or return wrong addresses, and there is possibly an
out-of-bounds read.

The old u8 kallsyms_seqs_of_names[] with manual byte assembly had no layout
dependency.  Would it be better to put __packed on the struct itself, as
struct __una_u32 { u32 x; } __packed; does in
include/linux/unaligned/packed_struct.h?  Alternatively, a u8 array read
with get_unaligned_le24()/get_unaligned_be24() would avoid the problem.

> +extern u32 kallsyms_off32_of_names[] __attribute__((weak));

Can these two weak references be relied on to read back as NULL when the
symbol is left undefined?

Commit 951bcae6c5a0 ("kallsyms: Avoid weak references for kallsyms symbols")
removed weak references, noting that they need a GOT in position-independent
code and are "not usually supported by RIP or PC relative symbol
references".  Commit c442db3f49f2 ("kbuild: remove PROVIDE() for kallsyms
symbols") then added the empty step-0 kallsyms object so that no weak or
PROVIDE() fallback is needed.

The previous weak references were always resolved in the final link.  Here
one of the two symbols is always left unresolved in the final vmlinux, and
get_symbol_name() relies on its address being NULL.

That does not seem to hold on every relocatable kernel.  On x86-32 with
X86_NEED_RELOCS (RELOCATABLE or RANDOMIZE_BASE), the R_386_32 relocation for
'$kallsyms_off24_of_names' goes through do_reloc32() in
arch/x86/tools/relocs.c.  Unlike do_reloc64(), which has:

    if (sym->st_shndx == SHN_UNDEF)
            return 0;

do_reloc32() does not skip undefined symbols, so the relocation is added to
relocs32.  When the decompressor relocates the kernel by a non-zero delta,
the unresolved weak address becomes delta instead of 0.

If the names table needs the 32-bit layout, kallsyms_off24_of_names is the
undefined one, so 'if (kallsyms_off24_of_names)' in get_symbol_name() is
then true and it reads 3-byte entries from a bogus low address.

Could the generator always emit both labels, with one of them empty, and
could the kernel pick the table with a non-weak test, for example by
comparing the label addresses or by using a size or flag word?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36795037147
--===============6479455916182214820==--

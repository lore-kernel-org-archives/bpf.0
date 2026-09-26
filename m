Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C22F8EAA;
	Sat, 26 Sep 2026 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383718; cv=none; b=RbZW2UAZtMTkfG8Ph+xr0IsfyRl5DggqCVY8g4hihJN6OiV81CmsbIdX+3cKizSzdvGAslsp49Tpbzt7I6sl95qTSEoci5XJFnxaXFk+QKrd4g0oHlHNUsYWAbK8e8e/EsMcFO/efhrEVFW5eWCkFzomFAEILq3+n7SiQ3GgfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383718; c=relaxed/simple;
	bh=Z7XCeoSHKKt9WBQu7ZD63KQ+fEc+1rxwtMoSoG94pEU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kmiWCjFJnW1KyHO7iMfKDd5NFSlV9NE+dKDPAci5W6qbR8YWKmAgD8KbLleeimdyso1yG58SPAMTfW8UxgEOO9JknK1KPgK7HZFEuXyEVbBATU1yEANw8yCtta5a1E8npDE1EmHycSzX0BG0U4LdAr2yFWshVb/4ypyTyDq5tRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd8DygpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd8DygpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A11F00893;
	Sat, 26 Sep 2026 00:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383716;
	bh=iOwdJEwTgWoc/NuLEQrScb9TaxVUu4KCZ070iq0PUMs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bd8DygpQ5MDVbD/dqPPV5jdv8OC+vpxadxLVizg0Rydng4DkeOp1UB9M59UccLk1b
	 1CmxMnQTX0hdsrrTfgCi7Ka/OdDS5hi8Mwok5laCH56okGVs1ZRGsArzJ1Tr9OSzIF
	 JAqYinzcvI9uhw4ZWPy4I6SZ7r37JJfbTtoXG7sJ/nyzTe2FJrcH1lvPbE7NEFpzWF
	 AEy1wa5ZbcenEA2TqOs7xFzAEptwKii3fdf+VDdpHy4tKEW8zsxON11/Ix0c/Nomn+
	 3UK80gOL7V57UDVPzyAQB0qktknnweXDEp6J0z5/tdTSWex5uGrMHb3ONb9DCI6rTR
	 1JOQZpMFcb2bA==
Content-Type: multipart/mixed; boundary="===============1926093681046393851=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <194f91dc0b4dcbfff03d079c616a00316f4faaad234fe2f13f156eb301cab163@mail.kernel.org>
In-Reply-To: <20260925-ksyms-tune-v5-2-1f75ad0c321c@gmail.com>
References: <20260925-ksyms-tune-v5-2-1f75ad0c321c@gmail.com>
Subject: Re: [PATCH v5 2/3] kallsyms: Increase marker density to 16:1 to accelerate lookups
From: bot+bpf-ci@kernel.org
To: jim.cromie@gmail.com,akpm@linux-foundation.org
Cc: ljs@kernel.org,kees@kernel.org,david.laight.linux@gmail.com,masahiroy@kernel.org,olsajiri@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 26 Sep 2026 00:48:36 +0000 (UTC)

--===============1926093681046393851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Increase marker density to 16:1 to accelerate lookups
>
> kallsyms_lookup_names() resolves symbol names to addresses using a
> binary search over kallsyms_seqs_of_names[].  In baseline, each probe
> invokes get_symbol_offset() to find the symbol in kallsyms_names[].
> Because markers in kallsyms_markers[] are spaced every 256 symbols in
> address order, each probe must sequentially scan and decode ULEB128
> lengths across an average of 127.5 symbols from the nearest marker
> (~2,176 hops across a 17-step binary search).
>
> During bulk symbol resolution (e.g. BPF multi-kprobe and tracing-multi
> attach across tens of thousands of functions), this linear scan penalty
> compounds into substantial latency (~4.7 us to ~6.1 us per lookup).
>
> Increase the static marker density from 256:1 down to 16:1 (1 marker
> every 1 << 4 symbols):
>
> 0. Define KALLSYMS_MARKER_SHIFT as 4 in kernel/kallsyms_internal.h, with
>    a matching KALLSYMS_MARKER_MASK of 0x0F.  Guard kernel types so host
>    scripts/kallsyms.c can include this header directly as the single
>    symbolic source of truth.
>
> 1. In scripts/kallsyms.c, emit markers every
>    (1 << KALLSYMS_MARKER_SHIFT) symbols into kallsyms_markers[].  For a
>    typical kernel with ~184,000 symbols, this increases marker count
>    from 719 to 11,501 entries, adding only +42.2 KiB to write-protected
>    .rodata (0.002% of vmlinux).
>
> 2. In kernel/kallsyms.c:get_symbol_offset(), compute marker offset via
>    pos >> KALLSYMS_MARKER_SHIFT and step through
>    pos & KALLSYMS_MARKER_MASK.  Because both are compile-time
>    constants, GCC emits single bit-shift and AND instructions with zero
>    division overhead.
>
> This reduces the maximum sequential scan from 255 down to 15 symbols,
> and cuts the average scan from 127.5 down to 7.5 hops (a 17x reduction
> in sequential loop hops).  In-tree selftest measurements across all
> 184,008 symbols show lookup latency dropping from 6,102 ns down to
> 866 ns (a 7.0x speedup) with zero runtime memory allocation, zero RCU
> synchronization, and zero new user-facing APIs or Kconfig options.

This isn't a bug, but could the numbered list be simplified? The items
0-2 restate the diff hunk by hunk, and some of the remarks describe
things the patch doesn't change.

The old code already used 'pos >> 8' and 'pos & 0xFF', so 'zero
division overhead' isn't new to this patch. Similarly, 'zero RCU
synchronization' and 'zero new user-facing APIs' describe things the
patch never touches.

Also, is 0.002% the intended percentage for the extra .rodata? That
would imply a vmlinux of about 2 GiB, but a typical loaded image is
tens of MiB, making the actual percentage closer to 0.1-0.2%.

The useful parts are the lookup-latency motivation and the
memory-versus-speed trade-off. Would dropping the numbered list in
favour of just the rationale make the description clearer?

> diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> index 81a867dbe57d..3e6494b7dfc4 100644
> --- a/kernel/kallsyms_internal.h
> +++ b/kernel/kallsyms_internal.h
> @@ -1,7 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  #ifndef LINUX_KALLSYMS_INTERNAL_H_
>  #define LINUX_KALLSYMS_INTERNAL_H_
> +#define KALLSYMS_MARKER_SHIFT 4  /* 16:1 sweet spot: +42 KiB .rodata, 17x fewer hops */
> +#define KALLSYMS_MARKER_SIZE  (1U << KALLSYMS_MARKER_SHIFT)
> +#define KALLSYMS_MARKER_MASK  (KALLSYMS_MARKER_SIZE - 1U)
>
> +#ifdef __KERNEL__
>  #include <linux/types.h>

This isn't a bug, but would a short comment explaining the trade-off be
enough here, without the specific measurements? The trailing comment
hard-codes benchmark figures from one configuration (about 184k
symbols). The .rodata cost grows with the symbol count, so '+42 KiB'
will be wrong for other configs and will go stale as the kernel grows.

The same measurements are already in the commit message, where they
usually go. Nothing else in this header has comments like this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36204745600
--===============1926093681046393851==--

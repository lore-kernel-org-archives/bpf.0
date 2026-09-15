Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA63C2B80;
	Tue, 15 Sep 2026 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506700; cv=none; b=drAIzUtdHOkOOKyEi9At6oS8gB/HN12tPQzDo5AFfLEHPB9S47siioYV1GFTtLEKyw1kE59KmglzKSw/32IZGGpL0YgbAoGK/SjSr/cZapSltE+2eXJ9fCGUksUgngFxkjVA1J/wzGqTZYjkwObiiVA+L/zGx0NisRq+2RjlrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506700; c=relaxed/simple;
	bh=AoCsTzTXHNFuc1Q3z61KajNZO1vb0aiiUflGwAKK9as=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GfT1FgkMD/kRspSmU1qMG6IkNVl0Ow1jK2yX7qnjFvPdJLLKRoTQLuIbWJheNbr6DjZmo3oR3vYbVm2lCIDl3yqbFh9MrTNOn6UlwFe4woOoaMREAc6PdPbrc0MZ9X+B/8ECPVBJM97bBuNPeChfvwxMiM7PX81vmlAGHJgahrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIEZ9YIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIEZ9YIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901E71F000FF;
	Tue, 15 Sep 2026 21:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789506698;
	bh=+pGd8JfDOqITlxuT8mGbAoIqAGn1R9IUwsi4Nnx1v8A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SIEZ9YIXnJSKYliDIq0pkMpKkt5XBWybSSL5ndE8Ce8Z4N4CpYIhkn0bdLCD0cDgL
	 S7U41qJG8WEvp25guKpcMFmRFnT5yh9e4msDj89j2LHbqeMEaK44+D+bG3Go/9AxdZ
	 aedHkjCQw9TwD9eNY6J6u3kw0kKafeOFUePmoh1XCOtJ8gZSVPampUfAEAx0mEr3sP
	 +CnPljEoImnCAXZ4x84fTksdHG2ZFpAdeENACnliu7EwdUmUc5GN8BexBOBxyg6EYc
	 pnqFD88Bo1DLAVZZ1Cyb5sPnLk3uC+ZJ8Q9iIF5L/jIIwYN6NUkCJ+xx1+QupCkN6Z
	 N1EJl7E30Mbqg==
Content-Type: multipart/mixed; boundary="===============4666062696086601469=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <640ebe4456fcfd59b05e5fdf3c7870a2514c76bbcb2fe4a111243911ac38a100@mail.kernel.org>
In-Reply-To: <20260915202220.3535321-1-arnd@kernel.org>
References: <20260915202220.3535321-1-arnd@kernel.org>
Subject: Re: [PATCH] bpf: add printf attributes
From: bot+bpf-ci@kernel.org
To: arnd@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: arnd@arndb.de,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,ameryhung@gmail.com,kees+treewide@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 21:11:37 +0000 (UTC)

--===============4666062696086601469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 5d37f3f1dd68e8bbee421b3d0871994907f9e35d
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Sep 15 22:21:55 2026 +0200
>
>     bpf: add printf attributes
>
>     Building with extra warnings enabled shows some missing printf attributes:
>
>     kernel/bpf/diagnostics.c: In function 'bpf_diag_source':
>     kernel/bpf/diagnostics.c:828:9: error: function 'bpf_diag_source' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>       828 |         msg = bpf_diag_vfmt(env, fmt, args);
>
>     Add these to shut up the warning and allow the compiler to check the
>     format strings.
>
>     Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Does the Fixes tag reference the commit that introduced the warning?
Looking at the compiler warning, bpf_diag_source() triggers the warning
because it calls va_start(args, fmt) and passes those to bpf_diag_vfmt(),
which already carries __printf(2, 0) in kernel/bpf/diagnostics.h:50.

Both halves of that trigger existed before commit a8f427835394. The
parent commit a8f427835394~1 already had:

kernel/bpf/diagnostics.c:795
    static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
                                const char *fmt, ...)

with va_start(args, fmt) and msg = bpf_diag_vfmt(env, fmt, args) in the
body, and kernel/bpf/diagnostics.h:50 already had __printf(2, 0) on
bpf_diag_vfmt.

Commit a8f427835394 changed only kernel/bpf/diagnostics.c by 19
insertions, adding bpf_diag_program_structure() without touching
bpf_diag_source() or any format attribute, so the warning already
existed before that commit.

Should the Fixes tag instead name the commit that introduced
bpf_diag_source() together with the __printf(2, 0) annotation on
bpf_diag_vfmt?

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index a2cac59c6639..b069fe73d3dc 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -291,7 +291,7 @@ char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size)
>  	return buf;
>  }
>
> -const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
> +__printf(2, 0) const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
>  {
>  	va_list copy;
>  	char *buf;

Is this attribute needed here? bpf_diag_vfmt() already carries
__printf(2, 0) on its prototype in kernel/bpf/diagnostics.h:49-50:

    const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
            __printf(2, 0);

kernel/bpf/diagnostics.c includes that header at line 17, so the
compiler was already applying the format attribute before this patch.
The attribute was present in the parent of the Fixes-referenced commit
(a8f427835394~1:kernel/bpf/diagnostics.h:50), and the compiler output
in the changelog reports exactly one warning, for bpf_diag_source()
only.

This hunk silences no warning and enables no new format checking, but it
pushes the line from 86 to 101 columns, exceeding the kernel's
100-column limit, so checkpatch will now emit "WARNING: line length of
101 exceeds 100 columns" on a line that was previously clean.

> @@ -309,7 +309,7 @@ const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list
>  	return buf ?: "";
>  }
>
> -const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...)
> +__printf(2, 3) const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...)
>  {
>  	const char *buf;
>  	va_list args;

Same redundancy here. bpf_diag_fmt() already carries __printf(2, 3) on
its prototype in kernel/bpf/diagnostics.h:51:

    const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);

Both translation units that call it include that header
(kernel/bpf/diagnostics.c:17, kernel/bpf/verifier.c:38), so all call
sites were already format-checked. The attribute is present in the
parent of the Fixes-referenced commit (a8f427835394~1), so this hunk
adds no checking and silences no warning.

The changelog says "shows some missing printf attributes" and "Add these
to shut up the warning", but the quoted compiler output reports a single
warning and only bpf_diag_source() was actually missing an attribute.

Could the patch be reduced to the bpf_diag_source() change alone?

> @@ -794,7 +794,7 @@ static void diag_print_insn_context(struct bpf_verifier_env *env, u32 insn_idx,
>  	}
>  }
>
> -static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
> +__printf(4, 5) static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
>  			    const char *fmt, ...)
>  {
>  	struct bpf_diag_scratch *scratch;

This is the hunk that is actually needed, but was the prefix inserted
without re-wrapping the declaration?

Adding the 15-character __printf(4, 5) prefix causes two formatting
issues:

1. Line 797 grows from 90 to 105 columns, exceeding the kernel's
100-column limit, so checkpatch will emit "WARNING: line length of 105
exceeds 100 columns".

2. The continuation line 798 is no longer aligned with the open
parenthesis. Before the patch, the first argument sat at column 29 and
line 798 (3 tabs + 4 spaces) also started at column 29, matching
exactly. Adding the prefix moves the open parenthesis so the first
argument now sits at column 44, while line 798 still starts at column 29
-> checkpatch "CHECK: Alignment should match open parenthesis".

The five nearest in-tree uses of this exact __printf(N, M) static form
all avoid both problems by re-wrapping the parameter list:

    kernel/bpf/btf.c:1536-1537   len=75, continuation at col 47
    kernel/bpf/btf.c:1560-1561   len=80, continuation at col 52
    kernel/bpf/btf.c:8334-8335   len=79, continuation at col 41
    kernel/bpf/verifier.c:7656-7657  len=92, continuation at col 50
    kernel/bpf/verifier.c:8457-8458  len=92, continuation at col 50

Should the parameters be split across the two lines (or move label down)
to bring line 797 under 100 columns and re-indent line 798 to the new
parenthesis column?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35020865259
--===============4666062696086601469==--

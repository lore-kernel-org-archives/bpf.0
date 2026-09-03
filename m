Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F584E80DC
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450768; cv=none; b=cMNf8fk+R6GhNYqcVVWwr963DmLX6oeeD+kht7eEeeOCbHGfbBtH+T7sKwptSWfBnnU5nE2AGpM1Ups8zceE3EsaCIhMcCLs44WQY7LH4cy7HCyCwqEsYwGDq4p/j6ozoDKPdm3sqicQKWXd4iUrzhaKTkkR59mWbLW+ZNGIfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450768; c=relaxed/simple;
	bh=mtk47xjwbeGA5AHokxn+L4mgWvOm3RZA4Ct/9XhZ8B4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aoNm1XzbNuv0oJpPo2zB+fiGwoPccIp2nTh4tjZkQl0kDjhr+444Y1ldd0Aa+B46tjl2WBkr1cm9DQ8jvCbdwmDUqpDd/iGhOoXwpYG7ke+LwvdDSxTPs0Q6NVjsT2cvpevVabuJP628tLPrAYFIHqM+8n/BZjZrWMlK8OWXvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhJNc4Iq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhJNc4Iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17821F00A3D;
	Thu,  3 Sep 2026 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450767;
	bh=8BKx/FQiHhwgrfBDS2Z3mcbm6RjSkQJP3LeNno5nGp4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XhJNc4IqUgxhavYvTU7s9NZjBQ7YUgzPV79GqbAqOhjBCQTmUtnW8kw0d5ISMi30/
	 k5lX/1V3ngOQBXQCLrG7UkT6zwOsX9rnIfbdBnOlT/hFmcPtGSAfnFXPtq4VusUaTh
	 Hf+sqTk3gPoYgdrwXl8NOyb0iSUAtYD730fRuX46BR88pkC5yElB9MqCJMl/4iGVL4
	 bbDAMl3ld/z/DOKSpMPZVGGI67uw/9nfq8eYOwmsl41E5ivNKg82gC8eDJMSXyoXcW
	 OTr6VT1ND+cT9qntG/oDMCS0Fyoyyliv/+qyB+aDfdQ6dgx2BOHDQAZGXUORBxr2xB
	 hac7UEU7ELIFA==
Content-Type: multipart/mixed; boundary="===============5139105425103562218=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbc8b63e44e2fc3abc511f5659cb50c4b42db63d1738afc81dd007a527e436cf@mail.kernel.org>
In-Reply-To: <20260903144433.1716731-2-memxor@gmail.com>
References: <20260903144433.1716731-2-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 01/10] bpf: Mark signal tracepoint siginfo arguments as scalar
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:52:46 +0000 (UTC)

--===============5139105425103562218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index da36d4b9d31ab..d6d243c262ea5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6717,6 +6717,9 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
>  	{ "rxrpc_resend", 0x10 },
>  	{ "rxrpc_tq", 0x10 },
>  	{ "rxrpc_client", 0x1 },
> +	/* signal */
> +	{ "signal_generate", 0x20 },
> +	{ "signal_deliver", 0x20 },
                                   ^^^^

Is signal_deliver's 0x20 mask too strict for its actual call sites?

Looking at the two call sites for trace_signal_deliver():

  kernel/signal.c (do_coredump):
    trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
                         &sighand->action[SIGKILL-1]);

  kernel/signal.c (get_signal):
    trace_signal_deliver(signr, &ksig->info, ka);

SEND_SIG_PRIV is never passed to this tracepoint. SEND_SIG_NOINFO is
zero (NULL), and &ksig->info is always a real pointer filled by
dequeue_synchronous_signal() or dequeue_signal() just above the call.

SEND_SIG_PRIV == 1 only reaches trace_signal_generate() from
kernel/signal.c:__send_signal_locked().

If that's the case, would 0x10 (PTR_MAYBE_NULL) be both sufficient and
less restrictive for signal_deliver? With 0x10 the verifier would still
force a NULL check to catch SEND_SIG_NOINFO, but after the check a
tp_btf program could read info->si_code and other fields. With 0x20 the
register becomes SCALAR_VALUE immediately and check_mem_access() rejects
all dereferencing with "R1 invalid mem access 'scalar'".

This table supports per-argument distinctions. The existing entry:

  { "cachefiles_lookup", 0x1 | 0x200 }

marks arg 0 nullable and arg 2 ERR_PTR rather than applying the same
mask to both. The signal_generate justification holds (SEND_SIG_PRIV is
nonzero so PTR_MAYBE_NULL alone doesn't work), but does the same
reasoning apply to signal_deliver given that it never sees that
sentinel?

> commit a481db8aa51a8682ee36d019234a31b254b3ecd5
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Date:   Thu Sep 3 16:44:19 2026 +0200
>
>     bpf: Mark signal tracepoint siginfo arguments as scalar
>
>     The signal_generate and signal_deliver tracepoints declare their info
>     argument as a struct kernel_siginfo pointer. btf_ctx_access() therefore
>     treats it as a trusted pointer for tp_btf programs.
>
>     Signal delivery also uses SEND_SIG_NOINFO and SEND_SIG_PRIV as special
>     values for this argument. Those values are zero and one respectively,
>     and are not pointers. A tp_btf program can currently dereference either
>     value and fault the kernel. In particular, signal_generate can run from
>     timer interrupt context, turning the fault into a kernel panic.
>
>     Record both tracepoints in raw_tp_null_args[] and mark argument one as
>     a non-pointer. This preserves scalar access to the cookie while rejecting
>     direct and helper-mediated pointer use. Merely marking it nullable would
>     not suffice because SEND_SIG_PRIV is nonzero.
                                                             ^^^^^^

Could this paragraph's wording be more precise about which parts are
being preserved and which argument is being marked?

"This preserves scalar access to the cookie" - there doesn't appear to
be a cookie anywhere in this change. Neither signal_generate nor
signal_deliver has a cookie argument, and this isn't related to
bpf_get_attach_cookie(). What's actually preserved is scalar access to
the siginfo sentinel value itself (0 for SEND_SIG_NOINFO, 1 for
SEND_SIG_PRIV), which is what a program can still read back. The term
"cookie" has a specific meaning in BPF context, so this might mislead
a reader trying to understand what the patch keeps working.

"mark argument one as a non-pointer" - 838a10bd2ebf documents the mask
as "1st arg: 0x1 / 2nd arg: 0x10 / 3rd arg: 0x100", where the nibble
position is the zero-indexed argument number. The mask 0x20 is nibble 1,
meaning the second argument (info). Against the referenced commit's own
wording, "argument one" could point at sig rather than info. Would
"argument 1 (info)" or "the second argument" remove the off-by-one
ambiguity?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33770534313
--===============5139105425103562218==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C783BFAF7;
	Sat, 17 Oct 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257429; cv=none; b=BdcVVtAEPbrCsUhYootT0rmvi62cN/42jACKCTXQPHyadgtKGjvxad1Fqo4I0iU9/i6Z2qaWykZ/G8JB6Qr5EjG8CbiUg5+wSjw+xE1WG8Z4nZ2unUL87C2AAsC32RYhhc72hUg52VM/FxWtq9uMlwigVVDoZXUMHbYaKg9HxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257429; c=relaxed/simple;
	bh=xjRwdUU7Nzvd5j4B0LTSke/xxiSyRn5MuaWCWE3oOEA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ciizhoCunYv2F8X2GPGwsn8OufgqVNEJjsMZNMw3sX//01G369uDmddnBvclnim5QlD3j6i7SY8wZyD8deQQaqJLq8rQhUDYn5N6rWTNmb6Hf8ic+FXb69imWpwUTdJb6Mb4C35Ltq1kC2PX1JMOC2djq0N1FDLA5RYtcxmDq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JACnFO0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JACnFO0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AFD1F000C4;
	Sat, 17 Oct 2026 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257428;
	bh=6gw/jRkQpTEOJ+u/ZLu6+6qk6iflZlK3LBX4V0vnzwg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JACnFO0yiGog3+Cu7JC6WnJzMJ8JHco3TSklWJznjQrZ/d4PLU8gkv7bjLIU7+eny
	 P8Qq0QXHMPOXvb1xdWcctLW64cQDU+Uc0VI8+4QD+allYnRnSOq5GNyZoE0yXWT5vg
	 03qc4osPTkaL0zkkl9t8MJdGRB7LmZJ6BiFnvb5v7ceUaxtZvJlQXNlAAk2reiy2oL
	 KtYn707L8JPfo3p5z2DzVBdp9+rzK0Y5OfBy1jW3YxOfWT3U5Y6qMNWCCBu6kM0zas
	 5iZJ0cfPt4+zTan1tIvEpf9/yTtDKPwwENjQa4OBwS+KVfVvSNLuS8gTU1zr/csFLn
	 rA37x8+2Emjww==
Content-Type: multipart/mixed; boundary="===============4781013323597679358=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08a50eba0856889f7d4c7334d1e8e587ddd65315c4e691eeb00988aebdf8638f@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-29-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-29-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 28/43] bpf: Don't take an extension for a writable raw tracepoint program
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:07 +0000 (UTC)

--===============4781013323597679358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't take an extension for a writable raw tracepoint program

TL;DR: The new check only rejects extensions of writable raw tracepoint
programs; an freplace of a plain raw_tp program may still read past the
tracepoint args (stack out-of-bounds read) via unchecked max_ctx_offset.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 81660ffce99a..0d1b729989d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22232,6 +22232,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  					"Extension programs should be JITed\n");
>  				return -EINVAL;
>  			}
> +			/*
> +			 * How much of the buffer of the tracepoint is used
> +			 * is checked for the program that is attached to it.
> +			 */
> +			if (tgt_prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
> +				bpf_log(log,
> +					"Cannot extend a writable raw tracepoint program\n");
> +				return -EINVAL;
> +			}

Is this check sufficient for the problem described in the commit message?

The commit message reasons that an extension's accesses are noted in its own
max_tp_access, which nobody looks at.  The same applies to max_ctx_offset,
which bpf_probe_register() checks right before the max_tp_access test:

    if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
        return -EINVAL;

The new check only refuses BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE targets, so
an extension of a plain BPF_PROG_TYPE_RAW_TRACEPOINT program still gets
through.

check_attach_btf_id() sets env->ops = bpf_verifier_ops[tgt_prog->type], so the
extension's ctx loads go through:

    raw_tp_prog_is_valid_access()
      bpf_tracing_ctx_access()

which allows any off < 8 * MAX_BPF_FUNC_ARGS (96 bytes).  check_ctx_access()
then records the access in env->prog->aux->max_ctx_offset, which belongs to
the extension's aux and not to the target's.  Nothing copies it to the target,
and bpf_tracing_prog_attach() only compares kprobe_write_ctx.

For example, with CAP_BPF and CAP_PERFMON, as in the case from the commit
message:

  - Load a SEC("raw_tp") program P whose main function calls a global subprog
    sub(struct bpf_raw_tracepoint_args *ctx) that does not touch ctx, so P's
    max_ctx_offset is 0.

  - Load a freplace program for sub() that reads ctx->args[11], so its own
    max_ctx_offset becomes 96, and attach it.

  - Attach P to a 1-argument tracepoint.  bpf_probe_register() sees P's
    max_ctx_offset (0 <= 8) and accepts it.  bpf_trace_run1() runs P with
    u64 args[1] on its stack, and the extension reads 88 bytes past it.  That
    is a stack out-of-bounds read, the same kind of failure as the KASAN
    report in the commit message.

  - BPF_PROG_TEST_RUN on P with ctx_size_in == 0 passes the
    "ctx_size_in < prog->aux->max_ctx_offset" check (0 < 0 is false), sets
    info.ctx = NULL, and the replaced subprog then loads from NULL + 88.
    With ctx_size_in == 8, memdup_user() allocates 8 bytes and the extension
    reads past them.

None of the later patches in this series touch max_ctx_offset or the
BPF_PROG_TYPE_RAW_TRACEPOINT handling.

Should the check also cover BPF_PROG_TYPE_RAW_TRACEPOINT targets, or should
the extension's max_ctx_offset be checked against the target at attach time?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============4781013323597679358==--

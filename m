Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6560C101
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418612; cv=none; b=awkIqmleKiRezzFuQHcyzFuCuGMSht7TemeN22Ib+zJC+txMfYJ8+StK1SS5BrZ4gNoiPMhkcyNCsJSy1nsVNKTRjLHs40PmEilIx3Fm+r+oDD+GFN9Hf8pbDtxiIOw7evtGYQlEr9XD9/rwM+1NKYBJNvedmVb0Hm+2H4p6IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418612; c=relaxed/simple;
	bh=h6xGDoPyLQ1nZ3+Q50MFzy66EL0E1Tejahe1bsWseoY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PnKtDY7fAFg8en6BvvPTAOpnHbkhCtcd7jD9RTrLk5UfjFsZB/gERvtg1B5utVyz9iGM0pgKu0UpBEwVtNH3Cf5T2rqci4duW3w0nAGb7L+JDX9u7jaMWgNF8Gobugk6WJGQkpQBIQF40N2qqp9e4csWQdzp+V27dyVF77zPu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab7avVrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab7avVrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F111F000C5;
	Mon, 19 Oct 2026 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418609;
	bh=lTbb3Lmt3Bi0Mm3Cx0XjfyM36VGf3B0Iz7WQklIS9zM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ab7avVrqi7repH2Z+60TZv9n5s9Y5TP4oj8hVK6appTw7um2USkXExcykX472zL6L
	 +g09eNZNqah19YcEnfPFfs/7zxNyMoB6h1Jk8TlpchCj7rrvrHAWOJIXlLT64ieqN0
	 0xKQpuHubcB/1Qv6XzGhdiR4J3qL4EJTaqKEKhDQjYZWicTRAtu4/eul9xoiwN7ve0
	 DtkhKcZjUVTC6M5EyhpoyOZJNZ6zBmQYGIg0F8gVqYLvBLKOyzDDXO0RoNAY1xR+l5
	 ZwpUprYfby+k1wwJ5L+SkcEbrRXbpshseaWt8+ySJ7N51FI11HqfsPvUsnpkfAMX5t
	 83Nagk61ELe5w==
Content-Type: multipart/mixed; boundary="===============5460802406061155290=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <17a218c395dfe05751b4a1797025a3c8678aeca58ef83d22fecb1c19dae470d8@mail.kernel.org>
In-Reply-To: <20261019132203.3034698-8-memxor@gmail.com>
References: <20261019132203.3034698-8-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/16] bpf: Turn loads of __arena pointer members into arena pointers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 14:03:29 +0000 (UTC)

--===============5460802406061155290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Turn loads of __arena pointer members into arena pointers

TL;DR: Nit only: arena_member_fixup() and its comment were inserted between
the ctx-conversion block comment and bpf_convert_ctx_accesses(), separating
that comment from its function; suggest moving it.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index bfbb0cf5c0a8..34b53ebb5841 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -882,6 +882,37 @@ static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
>   *     struct __sk_buff    -> struct sk_buff
>   *     struct bpf_sock_ops -> struct sock
>   */
> +/*
> + * A load through an __arena pointer member of a kernel struct reads the kernel
> + * address of arena memory. Append the conversion to the arena pointer form,
> + * (u32)(kaddr - kern_vm_start), that the struct_ops trampoline applies to
> + * __arena arguments. A __nullable member keeps NULL as NULL, tested on the
> + * full kernel address, and so does a probed load, which reads as 0 when it
> + * faults. Returns the number of insns in @buf, 0 when the insn loads no such
> + * member, or an error when it does so on some paths only.
> + */

Was it intended to insert arena_member_fixup() and its comment between the
existing "convert load instructions that access fields of a context type ..."
block comment and bpf_convert_ctx_accesses()?

With this placement the two block comments now sit back to back, and the
ctx-conversion comment is no longer adjacent to the function it describes.

Could arena_member_fixup() move above the "convert load instructions ..."
comment (or after ext_prog_takes_prologue()) so each comment stays with its
function?

> +static int arena_member_fixup(struct bpf_verifier_env *env, int idx, struct bpf_insn *insn,
> +			      struct bpf_insn *buf)

[ ... ]

> +	return cnt;
> +}
> +
>  int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  {
>  	struct bpf_subprog_info *subprogs = env->subprog_info;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39261628996
--===============5460802406061155290==--

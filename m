Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C082E7380;
	Sun, 11 Oct 2026 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708014; cv=none; b=nOxo1n0aHJjAHST/OsNs1QxT8O9tlczuJhU5IYmXaFsNBffRjrZgjRqfgO/aYOD23LjS3LU9zcoEoH5urtgYiiL3DFNajEvX8Pn991PFEh3hX+lZnMayziMZlB5Hy/75uFFa16J9yfwj8k2KX5Q0C0XV3mAHUsEesE086ysUM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708014; c=relaxed/simple;
	bh=TbktEhj1a1+7ugqE0PLzbE7QRnJvyRaedk6Ba1R3byU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LB1jJTzEkiOlw/F6JaeCFi09uMKQxCfc1OD9XSIby7B4lRRzeT012a3xqtPI4gD0zX3Do8PL7v5Alh61DXPnJ3KTW6h0WMv5fiVPZV4D2JCXIcH/oLpkwv8zDNOGkVsfSzAvcuD/HBJ0Wmp0aD5L4jcXW3hA9HYvQ7i2zJXLsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3vvTbLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3vvTbLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585021F0089C;
	Sun, 11 Oct 2026 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791708013;
	bh=hp9xX2dUrZlCXONwEL+JCIXeQEQv5+IPQxFX1fAUAtU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S3vvTbLk8vDK/+zaU6Tcbk3NTdv6/y9sz6lzuZywie9orctLkEC8RJqWcFseS3hYy
	 X8GEnMj62twLs5faSpFFlObTtlg70L9tnSh4RCthWeq64cXP34Z51VOXZk4ckw7+Je
	 DmgMGjwcbutPLm4ZltlD2fMPAJamA6nhbz8ugzMx4QBKQfC8ZZarQ3xe4Oakpjbk+/
	 PbH2woZ92BjGp+lwC1aJ0WyBY3gUO8a0daHQOw2uao9VpDduJ/fIF0N/8l85PxLxC5
	 Yc644TnqDcz+9qtRiUd5sm8agF48aXszEO33NS6ZRY8i0Z0qzfps2am+a1GhzpoGpH
	 Mj944qFof0Z6Q==
Content-Type: multipart/mixed; boundary="===============0635665488301257032=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e81d8aa1c5fef5135717607342f2564d58907fb0e8e7bd9c32eea76b2eb2b2d9@mail.kernel.org>
In-Reply-To: <20261011072930.3879724-1-visitorckw@gmail.com>
References: <20261011072930.3879724-1-visitorckw@gmail.com>
Subject: Re: [PATCH v9] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,corbet@lwn.net,skhan@linuxfoundation.org,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,andrii@kernel.org,gerg@linux-m68k.org
Cc: rdunlap@infradead.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,jserv@ccns.ncku.edu.tw,marscheng@google.com,eleanor15x@gmail.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,visitorckw@gmail.com,daniel@thingy.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 11 Oct 2026 08:40:10 +0000 (UTC)

--===============0635665488301257032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> m68k, bpf: Add initial BPF JIT compiler support

TL;DR: Nit only: in the m68k JIT's emit_math_call(), the BPF_CLASS checks on
the signed div/mod selection look redundant given is_64, and could be folded
into the switch cases. Not a bug.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..e585cbcd7564
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +static void emit_math_call(const struct bpf_insn *insn, struct jit_ctx *ctx, bool is_64)
> +{

[ ... ]

> +	if (is_64) {
> +		switch (op) {
> +		case BPF_MUL:
> +			func = (void *)jit_mul64;
> +			break;
> +		case BPF_DIV:
> +			func = (void *)jit_div64;
> +			break;
> +		case BPF_MOD:
> +			func = (void *)jit_mod64;
> +			break;
> +		}
> +		if (BPF_CLASS(insn->code) == BPF_ALU64 && op == BPF_DIV && insn->off == 1)
> +			func = (void *)jit_sdiv64;
> +		if (BPF_CLASS(insn->code) == BPF_ALU64 && op == BPF_MOD && insn->off == 1)
> +			func = (void *)jit_smod64;
> +	} else {
> +		switch (op) {
> +		case BPF_MUL:
> +			func = (void *)jit_mul32;
> +			break;
> +		case BPF_DIV:
> +			func = (void *)jit_div32;
> +			break;
> +		case BPF_MOD:
> +			func = (void *)jit_mod32;
> +			break;
> +		}
> +		if (BPF_CLASS(insn->code) == BPF_ALU && op == BPF_DIV && insn->off == 1)
> +			func = (void *)jit_sdiv32;
> +		if (BPF_CLASS(insn->code) == BPF_ALU && op == BPF_MOD && insn->off == 1)
> +			func = (void *)jit_smod32;
> +	}

This isn't a bug, but since is_64 already encodes the instruction class, are
the BPF_CLASS(insn->code) == BPF_ALU64 and BPF_CLASS(insn->code) == BPF_ALU
tests in these four conditions always true?

Could the signed/unsigned choice be made inside the BPF_DIV and BPF_MOD cases
of the switch instead, for example:

	case BPF_DIV:
		func = insn->off ? (void *)jit_sdiv64 : (void *)jit_div64;
		break;

That would drop the redundant class checks and the second assignment that
overrides the one made in the switch.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38122863281
--===============0635665488301257032==--

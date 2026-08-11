Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4E21D5B0
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411483; cv=none; b=iICP7VQNfEk97Ifrp/oUEQHYbw755mU4bnTa6Cs/J4fWU+len9YhasxhlbZlQpetvM03TACF56pHTtT/8eSMg7JuHq1z6dO21Q6rk+2VRJ6YCs+rl9rUnWCAs6+YntTtri8g8Lm18B274clt4cQdGoT6CcumjY2XzwduH6k3XeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411483; c=relaxed/simple;
	bh=C0dyFN/PAs84j4IMA7MtunsnijWTByjoWKfm+7iDtaU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O4L/KToRJ0aIpH3DfEMVbowjyjZQ9tcpAcKxmMViOZvMXZsuzbUkdJhU11Be4TnAzdPYQF4y7rb7zfDENCWhV+hE+M9TcpdBSbHDHXSLMwpSkUz+/AGzyduqXvo5AVwkaVB2P6DYBoW5gnmW0bTMU8EIjSlgfGtqcLgzbcPSV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE4/xeOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE4/xeOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296171F00A3A;
	Tue, 11 Aug 2026 01:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411481;
	bh=BbP7Yxk6ziN+XMy+dg6Q/PV3n5R72tRkH+umVE5AScQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eE4/xeOYCWDQ0rI5yWIy8n0o6UaHlMppiRsWFJ8RBArKHJV99ju/aybfr7wDQ01AD
	 s1qTs8MykyghVo7n5t+t6u6fWSUphseEVlQD+LMb8Eg2UYnr7ZZoPUZjWCYDW2D++s
	 DVI9n8Ogw8jvOBvYw7kvUNvEXAxlOjBAy5FC+WzgJlG+18tNgr/dVu5FQnE44eO+TB
	 VEuyAurAoeod6umJtbeoQPtSCe1VRK+ioU6PpxCBj+l8GZlmhNUaMm2pUP3FHUlbdg
	 p3cGz9xSOJ0hNfq8XU8NJ12UoZb+VDYJpZ3ADqGGjgUGlkKgh+yKXIZeqKIyjR+KQl
	 jbwTxc6EBsCUw==
Content-Type: multipart/mixed; boundary="===============3851755487865849214=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b969b8d1045c704a50153c0947c5c47a35042e9755b592b4c38807daf64b23d3@mail.kernel.org>
In-Reply-To: <20260811000927.2380571-1-yonghong.song@linux.dev>
References: <20260811000927.2380571-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 03/13] bpf: Wire up JIT support for 16-byte kfunc returns
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:24:41 +0000 (UTC)

--===============3851755487865849214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
> larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
> taught the verifier about that convention; wire up the JIT side so that the
> second half of the return value actually lands in R2.

This isn't a bug, but should this say the previous patch added the shared
R0:R2 helpers, rather than that it taught the verifier the convention?
Looking at 882cac43a2cef ("bpf: Add helpers to describe the R0:R2 return
register pair"), its changelog states "No functional change,
bpf_ret_reg_pair() has no callers yet" and "Later patches teach the JIT,
precision backtracking, live register analysis and the verifier itself
about that convention." The verifier actually learns the convention in
d280e9c973c59 ("bpf: Add verifier support for 16-byte returns in R0:R2"),
two patches later.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8dddb5d7af21b..01c34114c8502 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2647,6 +2647,22 @@ st:			insn_off = insn->off;
>  				return -EINVAL;
>  			if (priv_frame_ptr)
>  				pop_r9(&prog);
> +			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +				const struct btf_func_model *fm;
> +
> +				/*
> +				 * A kfunc returning a >8 byte aggregate hands the
> +				 * second half back in RDX (the native ABI's second
> +				 * return reg), but BPF expects it in R0:R2. BPF R0
> +				 * is RAX (no move needed), while BPF R2 is RSI, so
> +				 * copy RDX into RSI.
> +				 */

This isn't a bug, but since struct/union returns are still rejected by
btf_distill_func_proto() at this point in the series (kernel/bpf/btf.c
checks "if (ret < 0 || btf_type_is_struct(t))"), would "a kfunc
returning more than 8 bytes" read more accurately here than ">8 byte
aggregate"? Aggregates only become reachable later in b12c58bbc5e59
("bpf: Enable aggregate return types up to 16 bytes"), so the only
return type that can reach fm->ret_size > 8 at this commit is __int128.

> +				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
> +				if (!fm)
> +					return -EFAULT;
> +				if (fm->ret_size > 8)
> +					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
> +			}
>  			break;
>  		}

This isn't a bug, but emit_kfunc_arena_args() already does this same
bpf_jit_find_kfunc_model() lookup earlier in do_jit() and bails out on
NULL. Looking at emit_kfunc_arena_args() in arch/x86/net/bpf_jit_comp.c:

    fm = bpf_jit_find_kfunc_model(prog, insn);
    if (!fm)
        return -EINVAL;

Since bpf_jit_find_kfunc_model() is a pure bsearch over an immutable
table, if the first lookup succeeded the second cannot fail. Could the
two BPF_PSEUDO_KFUNC_CALL blocks share one lookup, so the second bsearch
and the unreachable "if (!fm)" guard go away? The two sites also disagree
on the errno for the identical condition (-EINVAL vs -EFAULT).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============3851755487865849214==--

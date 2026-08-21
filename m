Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCABB640
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290237; cv=none; b=Ek+/p+eWEmD3TqfVsWWqQ2nZQ6VdbIfcldLMyF6SnX7QwZ6Vi241jg+cNsXDEgnPVsoIpg/ZXWtx5qNXn5HYiol3AOK81lT90328Lp5Tmte+1kCQil8140SBQVTlso6u197OyndgOL53z/Wy1x6Sldz9bmIw+0DIbXh+UCnn6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290237; c=relaxed/simple;
	bh=+yFFUFX+PSW5ebKC3lVbkmoBo4ffQMpqVB4T6E8kBzA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dohiuIKBJwZLcFInG/EsQJ3m85Tg5g/1Nr7w5MvX6OKGxdgZWvc0RawA4Oz8n/oJxVS7XohgvIJCMreGHXD+AF76eaUUUTtI8JhD47MxdPRqckNjKyCh8jM8aFfFi0yLXGcjATjx+j/fc4T/F2LuRYhLvxtlrC1oNvYCU8/5fg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZpL82qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZpL82qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78511F000E9;
	Fri, 21 Aug 2026 05:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787290236;
	bh=uRQfoDIjlieP1NllI3xMCP6FF7NLjCki3iCI7vEzuhs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cZpL82qgNkE9N+Jmn+hlA5u2fftC4IICqzm+UJ+0qfe2Qy5Z2UVqAuaDUUn2wkmxe
	 eEoGHllJJj1WiKPvtWJwiM1RCb7mL3X1kFOOlkHaV0F01WuKxI92B0WHrBtUvUqDpV
	 xFpK0bxHy+Hz8aLMvzuH1z5S2REcsSYnUBgPIcdyPQFE/wFaORKnM8K83cwMGNzU/2
	 p8vDoy9s6FhbmMpJmiVyFb/8qY5t8my3yYzb3894X70YdopPpEnUFPUb0RsqY2SELy
	 wV6o6cya3WKLoPXi8HrbJHYHQOUVwdzVh9STqmGi0ZCABM+7Tf77OMiKZ2q4izxWOP
	 T//KvoyIF6b9Q==
Content-Type: multipart/mixed; boundary="===============7498455695527093437=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5aa1dac8607107bbeee81a92209555f78e5b0cffcad08833357b3fcd5b18a468@mail.kernel.org>
In-Reply-To: <20260821042837.2786719-1-yonghong.song@linux.dev>
References: <20260821042837.2786719-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] bpf: Rewrite "rX <<= 32; rX >>= 32" into "wX = wX" to keep linked scalars
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 05:30:35 +0000 (UTC)

--===============7498455695527093437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> For the following test in
> tools/testing/selftests/bpf/progs/verifier_linked_scalars.c:
>
>         void alu32_negative_offset(void)
>         {
>                 volatile char path[5];
>                 volatile int offset = bpf_get_prandom_u32();
>                 int off = offset;
>
>                 if (off >= 5 && off < 10)
>                         path[off - 5] = '.';
>
>                 /* So compiler doesn't say: error: variable 'path' set but not used */
>                 __sink(path[0]);
>         }
>
> Without alu32 (-mcpu=v2), the test
> verifier_linked_scalars/alu32_negative_offset will fail with llvm22 and
> llvm23 like below.
>
>   3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
>   4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
>   5: (67) r2 <<= 32             ; R2=scalar(smax=0x7fffffff00000000,...)
>   6: (77) r2 >>= 32             ; R2=scalar(smin=0,umax=0xffffffff,...)
>   7: (25) if r2 > 0x4 goto pc+5 ; R2=scalar(smin=0,smax=umax=4,...)
>   8: (bf) r2 = r10
>   9: (07) r2 += -5
>  10: (0f) r2 += r1              ; R1=scalar(id=1,smin=0,umax=0xffffffff)
>                                 ; R2=fp(smin=-5,smax=0xfffffffa)
>  11: (b7) r1 = 46               ; R1=46
>  12: (73) *(u8 *)(r2 -5) = r1
>  invalid unbounded variable-offset write to stack R2
>
> R1 is never narrowed down, so the address stays unbounded and the store
> is rejected.
>
> The test is okay for llvm21 with -mcpu=v2, see below:
>
>   3: (07) r1 += -5              ; R1=scalar(smin=-5,smax=0xfffffffa)
>   4: (67) r1 <<= 32             ; R1=scalar(smax=0x7fffffff00000000,...)
>   5: (77) r1 >>= 32             ; R1=scalar(smin=0,umax=0xffffffff,...)
>   6: (25) if r1 > 0x4 goto pc+5 ; R1=scalar(smin=0,smax=umax=4,...)
>   7: (bf) r2 = r10
>   8: (07) r2 += -5
>   9: (0f) r2 += r1              ; R2=fp(smin=-5,smax=-1)
>  10: (b7) r1 = 46               ; R1=46
>  11: (73) *(u8 *)(r2 +0) = r1   ; fp-8=ppppm???
>
> To fix the test issue with llvm22 and llvm23, note that the shift pair
> computes zext32(base + delta), which is what "wX = wX" computes as well
> and which is exactly the relation BPF_ADD_CONST32 describes. So rewrite
> the pair into "wX = wX" and let the mov turn the 64-bit link into a
> 32-bit one, which makes the -mcpu=v2 sequence track like an alu32 one.
>
> The rewrite has to keep the program length, so the second shift becomes
> a second "wX = wX" rather than being removed. A "goto pc+0" nop looks
> like the obvious filler, but it is a jump, and bpf_is_state_visited()
> decides where to place a checkpoint based on how many jumps it has
> seen. One extra jump per shift pair re-times that heuristic and moves
> the checkpoints of an enclosing loop, which can lose state pruning.
>
> For example, clear_global_array_list() in the no_alu32 flavour of the
> linked_list selftest calls the always_inline clear_list(), three
> 256 iteration loops in a row. With the shift pair, we have
>
>   processed 15384 insns (limit 1000000) max_states_per_insn 4 total_states 260 peak_states 125 mark_read 0
>
> With a "goto pc+0" filler the checkpoint changes its location, we have
>
>   BPF program is too large. Processed 1000001 insn
>   processed 1000001 insns (limit 1000000) max_states_per_insn 4 total_states 19479 peak_states 148 mark_read 0
>
> The duplicated mov keeps both the insn and the jump counts the same as
> before the rewrite. It is idempotent, the second mov re-derives the
> same bounds and finds the 32-bit link already in place.
>
> With this, the llvm22 and llvm23 code verifies, R2 keeps its id across
> the zero extension and the jump narrows down R1:
>
>   3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
>   4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
>   5: (bc) w2 = w2               ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)
>   6: (bc) w2 = w2               ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)
>   7: (25) if r2 > 0x4 goto pc+5 ; R1=scalar(id=1,smin=5,smax=9,...)
>                                 ; R2=scalar(id=1-5,smin=0,smax=4,...)
>   8: (bf) r2 = r10
>   9: (07) r2 += -5
>  10: (0f) r2 += r1              ; R2=fp(smin=0,smax=4)
>  11: (b7) r1 = 46               ; R1=46
>  12: (73) *(u8 *)(r2 -5) = r1   ; fp-8=ppppm???
>
> The llvm21 sequence is rewritten as well, the rewrite is not tied to
> BPF_ADD_CONST, so both its insns 4 and 5 become "w1 = w1". R1 carries
> no id there, so the mov takes the ordinary zero extension path and ends
> up with the same bounds the shift pair produced, the program verifies
> as before.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for the BPF_ADD_CONST linked register tracking
mechanism. The zero-extension shift pattern wasn't properly handling
registers with BPF_ADD_CONST relationships, causing the verifier to lose
track of register bounds and reject valid programs.

Should this include:

  Fixes: 98d7ca374ba4 ("bpf: Track delta between \"linked\" registers.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32447591531
--===============7498455695527093437==--

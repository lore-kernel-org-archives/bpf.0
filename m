Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC444A49BC
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547680; cv=none; b=TCUrrh42pZavYj9nQa4qhQMnEKPzvujf1vwUeArXeXbbe2CH9tZGwvpn+jsmCi0zDuoybq/eESuH/Z7TnMQHtSwum9H8DTQW6Z5tkzDdMULaoHwKY8ZU6WkZRdiIytTrletnSiAp0jsjSaCZsDJcLBXM5SHke9QuC1b/wtweMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547680; c=relaxed/simple;
	bh=OJ6e6YcpuLxdxJlCfVW8vDOT0bNk/Kc7pFScWsncpbg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q7scSDEI2NGqZVzH6e5puww8u2ll0yAPpUzqji04328dJ9mp+NgrlzY5q9a/ftVokBu910vFjTzpWVGmMHbPUPCuMd+wLwNDKkElfz6C1UVS/LYzanRbCw0yRnfu8iIt4+vo1+vszeqqz2FTkKvDxnGkCoyFDW8U2NnKGEGm8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wogc4rL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wogc4rL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB161F00898;
	Fri,  9 Oct 2026 12:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547675;
	bh=5Dk0tnZFhXOKvpEEF/ZEcV756xJ+1AxrI4nlTSFIHgU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wogc4rL6xjWPdUMb8LZ5q1JGKIkuTUcUstlONpkWj7YZG1UunJdNVaFWj6ZCWKRH7
	 VFdY0/xdaLDuT8uOra5rikJL6X349Y5hYqkLAyVAp1OLQMnNRoDvDX73SuVxDzQ5WH
	 bESZe3ZrQn39tBOHzEgB5YuOBi9VLb/frZ1aFp8Nfdohah6lQCvVlTD8dH9aKqiYwU
	 V6GdCugXu9k1FrJ9W/i5j9zfaZJz9yIcoQKmAGhS2a32192UlR9moVZ0Q5Z/XPdV9+
	 hl+QoHSZutwLtPht6+bY0FHiwipz8kGUb7HTybFFAVz9iiHYe9OWN6o4X5vFvdUBlP
	 AGytfjbH1Newg==
Content-Type: multipart/mixed; boundary="===============4501707364632007112=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <262b226e1056a727be3794037a29a5dea962ee31c053f7ce5777834baf9fb9bc@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-33-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-33-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 33/51] bpf: compute scalar evolution expressions for loops
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:54 +0000 (UTC)

--===============4501707364632007112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: compute scalar evolution expressions for loops

TL;DR: The new need_scev bool in struct bpf_insn_aux_data may grow it from 208
to 216 bytes, about 8MB more for a 1M-insn program; a bitfield would avoid
that. Also lacks a comment.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 963106328791..52f72e92eb0c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -745,6 +745,7 @@ struct bpf_insn_aux_data {
>  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
>  	bool arena_scalar; /* ldx/stx/st/atomic through a number, it's an address in arena */
>  	bool bb_end; /* last instruction of a basic block */
> +	bool need_scev;

Does this new bool grow struct bpf_insn_aux_data?

Before this patch, the ten bools after 'u32 seen', plus 'u8 alu_state' and
the u8 fastcall bitfield byte, filled exactly 12 bytes, so 'unsigned int
orig_idx' followed them with no padding.  With one more bool, orig_idx and
every field after it move forward by 4 bytes, and because the trailing
'struct bpf_loop *loop' needs 8-byte alignment, the struct goes from 208 to
216 bytes on x86_64 (orig_idx moves from offset 136 to 140).

bpf_check() allocates this struct once per instruction:

    __vmalloc(array_size(sizeof(struct bpf_insn_aux_data), len))

and adjust_insn_aux_data() memmoves it on every patch, so a 1M instruction
program uses about 8MB more memory.  Nothing later in the series
(71f4568a6476..726d0559f576) touches the struct again, so the growth
remains.

There is room that would cost nothing: a 2-byte hole after 'u16
stack_ptrs', and 25 unused bits in the 'u32 jmp_point:1 ... jump_target:1'
word.  That word holds the other flags set once in the pre-pass, such as
prune_point, and need_scev is also set only once, by mark_latches().  Would
'u32 need_scev:1;' there keep the struct at its current size?

This isn't a bug, but this is also the only member in this block without a
comment.  Could one be added saying that the flag marks loop headers,
latches and in-loop exit sources where SCEVs are materialized, and that it
also forces a basic-block split in compute_scev_for_loop()?

>  	u8 alu_state; /* used in combination with alu_limit */
>  	/* true if STX or LDX instruction is a part of a spill/fill
>  	 * pattern for a bpf_fastcall call.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============4501707364632007112==--

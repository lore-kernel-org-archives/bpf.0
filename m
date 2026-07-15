Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A02DF136
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784155906; cv=none; b=jtuXMuV+YgoGTkWSokUCo0eRSAIGVzGd4OvsVR2AdvKtACIdFMQ0stzweHHAAOVMB9K7ADOEkXVs8zlE6Izjv5qjJyu3hlgt28Vv/Lz43KdxTf5pZhP+M/pcNZJMGX7KTuFDeJo2/nsHx4QNQ00/u1lImbbX+V5NVfZVt7+yge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784155906; c=relaxed/simple;
	bh=Qy2iEn4Yum0YOVoMv/fM6qMaE6zVukKt8wiTmgWBgAs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bHVVk0vir0cLr/wjSrqgJEDW7oEUZELxo+D90ZJ6310FqG2Ou6EtW/H8eJhErO4skLM1Pcw9CQpvjrF92TnP98PZl8FSJQdjT9rV42qW3mw3WRCvbIGm31VvQnRWDXVoZ7uiCcGvYmmwaNFU+u4CnXvDuiA6AO1iDPQv3E2nLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgFL/0Vp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgFL/0Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC981F000E9;
	Wed, 15 Jul 2026 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784155905;
	bh=zDOcEM3af1h9ekSYjc4E4d6R1nUCoyfDwGHCAnT8QUA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VgFL/0VpthWGhuq4qHwY02G6wIr3WJdK+8of+gbNQnhEOuA6ab9R3eFeu4Go2PICN
	 yuVfYM4WUIA/04H6sKnCZ+uqpH5Rw44wDFKSQ85+Un+LaX9KEXnOLPbWYfmJMD4VaQ
	 RoN4jLOU61J0g0qgzhfw03eyiZBBhYTT3qQqcCcAYfJ/t1Kpe/R1fadKZxvMJj0NVf
	 apvUH+hXKNHxWcLgICj2O2guWTP8zPN0vdBBqk41+FlbSvHOzhjAfnnL4Pt1Kv510q
	 87jMIhpQwhb9b+1wHbmcYOS3cwW8DEYLB2TWaDLluNdQlbj5NBYlS00npRpdXVATru
	 s1hYW8bNyihxg==
Content-Type: multipart/mixed; boundary="===============8251342499987838570=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f5af5b85f53599cdaf42b7f3014c145828323cc5b2f7dc7290cd660914c44435@mail.kernel.org>
In-Reply-To: <20260715220052.1590783-9-memxor@gmail.com>
References: <20260715220052.1590783-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf, x86: Fix stack-passed arguments for indirect trampolines
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 22:51:44 +0000 (UTC)

--===============8251342499987838570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf, x86: Fix stack-passed arguments for indirect trampolines
>
>     save_args() reads stack-passed arguments relative to rbp assuming two
>     return addresses sit between the saved rbp and the arguments, which
>     holds when the trampoline is entered through the fentry call from a
>     traced function. An indirect trampoline is called through a function
>     pointer, so only the caller's return address is on the stack and the
>     arguments start at rbp + 16, not rbp + 24. Every stack-passed argument
>     of a struct_ops callback with more than six argument slots is read one
>     slot off.
>
>     This has gone unnoticed because no in-tree struct_ops member passes
>     arguments on the stack. The jmp-entry form already accounts for having
>     a single return address; treat BPF_TRAMP_F_INDIRECT the same way.
>
>     Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING")
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Is the Fixes: tag pointing at the right commit here?

473e3150e30a introduced save_args() and its rbp + 24 stack read, but at
that point trampolines were only entered through the fentry call, where
both the origin-call and caller return addresses are on the stack, so
rbp + 24 was correct and the described bug did not yet exist.

The indirect entry path that leaves a single return address on the stack
came in with BPF_TRAMP_F_INDIRECT, added by 2cd3e3772e41 ("x86/cfi,bpf:
Fix bpf_struct_ops CFI"), which reused save_args() unchanged. That looks
like the point where a struct_ops callback with more than six argument
slots starts reading each stack-passed argument one slot off.

Would this be more accurate?

  Fixes: 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops CFI")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29454748905
--===============8251342499987838570==--

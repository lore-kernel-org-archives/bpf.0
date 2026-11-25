Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630628;
	b=tPQO2Uj7C2y0cLZ2VhFU+qa+jkBHmt8dnjEdo2VkY38PUEQSOcI2L0Kft1VzpVLg/9vD
	 ELEUIn8oMbd2Y68lGl4RnckRHnCitoC8V5tn8LL5CHVHLZnOdJLBWRjXRteps63hlPpU7
	 pj8CGQPq9pKvijgLcqoVg7xis+9L+VIkNoM7CJvVmXqAAqPBcp2hl42a+SwCI4vsFmWZS
	 jm1TLJGp5FesWbN0lYv5l/tJQ52W1VwTc+ci3ZMEV+Jo593w72tetxtldC8t+rhHfKfDy
	 13NCglEwyxgHheBRjTjlmGQejm9LGcMv8jzMx9JVNIJFEJqiHwE+LaAs9PfsNVSOzww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630628;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uHaxkAM+VtG73baBp2ExxBwE6vYXYASWgYgaiBDy2yE=;
	b=fuIymLujS7Zviqx5MMqAb8jh73tkUzdK6HJlpwxThuUm2SIcwDpHvmvKFZIh+ZCUCs2L
	 R7/Piwsg3AZ3GOcLbxpq+JVlomX7IwHWrwMngzX/Pl8TbKP9JNWgrENd/9ACIw/3QcHzE
	 ay4LacW3MQikQ8z8Tjty08eBDD51AQiN00oBNDx3nvSwAySG0aNL1eNRiK6NbTizMM7Hs
	 fTRlZiZlz8u6C/ZthHEokdWqoNkVkFUJN54bhAAkO8dZbnXfL+UCX/Kqc+i9FKE1okoym
	 Kwsd7B8ax3TcuINxhsLsemgpd9zWBGWP7RROuiD2+MCzgh7vwXL1+/A+I69FFhhtJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbIA3zxW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6F606A339;
	Wed, 25 Nov 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbIA3zxW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082BE1F000C0;
	Wed, 25 Nov 2026 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630628;
	bh=uHaxkAM+VtG73baBp2ExxBwE6vYXYASWgYgaiBDy2yE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EbIA3zxWqnsAVHSvvlRB5f57ilf8qdQ4lqpIt1f8kR6SqZPi4fB4U8AyIRTDne0E3
	 d2D5G9vGuSsAZOHWfEN2qLhjCb+WOxrMPN1SNhMi9PRlaBke+VAwJHEeVehYWnuGr+
	 ui8ifjOqNVaWJRBDdSHlbXdOZbXz6kbCsoWNCTpxlnYq4092VaX2LYT6CMu6r1Sc0V
	 zOB83UkL54qvTGgDnjmDHtmAg1Ymo2iFj9K/jKch71csMTnv4hZwqXg4J8sTn78L9H
	 MQKtKl7P57jpEWyIjqoAhHenNteNbr7PzZx9wE9N8mBH/8/kUG7M91GBRJUs4j9pbm
	 qk4iMcbqy18LQ==
Content-Type: multipart/mixed; boundary="===============8089566910416508142=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0270ce6c47b8174654edc62b12007b9c008d7a1ae1cad7d1aa8227a251c054ef@mail.kernel.org>
In-Reply-To: <793677d276c8e0315ab4a9fb70178cd040d9bc97.1795625597.git.luis.gerhorst@fau.de>
References: <793677d276c8e0315ab4a9fb70178cd040d9bc97.1795625597.git.luis.gerhorst@fau.de>
Subject: Re: [PATCH bpf 3/4] bpf: Emit nospec after every insn with nospec_result
From: bot+bpf-ci@kernel.org
To: luis.gerhorst@fau.de,ast@kernel.org,bpf@vger.kernel.org
Cc: luis.gerhorst@fau.de,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,henriette.herzog@rub.de,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 18:17:05 +0000 (UTC)

--===============8089566910416508142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Emit nospec after every insn with nospec_result

TL;DR: bpf_emit_nospec() runs after bpf_optimize_bpf_loop(), contrary to its
comment, so the nospec may land after an inlined bpf_loop and let it run
speculatively. This predates the patch.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> +/*
> + * Emit the speculation barriers that do_check() asked for:
> + *
> [ ... ]
> + * An insn may require both. The insn keeps its aux data, so this has to run
> + * before the passes that rewrite the insn itself: what they emit for the insn
> + * stays between the two nospec.
> + */
> +int bpf_emit_nospec(struct bpf_verifier_env *env)

This comment says the pass has to run before the passes that rewrite the
insn itself, but bpf_check() does not follow that ordering.

bpf_emit_nospec() is called after bpf_optimize_bpf_loop():

    if (ret == 0)
        ret = bpf_optimize_bpf_loop(env);
    ...
    if (ret == 0)
        ret = bpf_emit_nospec(env);

inline_bpf_loop() replaces the bpf_loop call with a sequence of insns via
bpf_patch_insn_data(), so adjust_insn_aux_data() moves the call's aux data,
including a set nospec, to the last insn of the patch (the restore of r8
from the stack).  bpf_emit_nospec() then places the barrier in front of
that restore rather than in front of the inlined loop.

Can this be reached with CAP_BPF but without CAP_PERFMON?  For example, if
a speculative path reaches 'call bpf_loop' with a scalar in R3,
check_func_arg() fails, error_recoverable_with_nospec() accepts it, and
do_check() sets nospec and ends that path.  The call can still be inlined
because of the architectural visit, so the inlined loop would run
speculatively with the scalar R3 passed to the callback as r2, which was
verified as PTR_TO_STACK.

The code before this patch had the same ordering, since
bpf_convert_ctx_accesses() also ran after bpf_optimize_bpf_loop(), so this
predates the patch.

The bpf_capable passes that run earlier look related: a conditional jump
that got nospec on a speculative path and whose target is dead is
hard-wired to 'ja 0' and then removed by bpf_opt_remove_nops() together
with its aux data.

Should the pass move earlier, should nospec be carried through those
rewrites, or should the comment avoid promising an ordering that
bpf_check() does not provide?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45667123547
--===============8089566910416508142==--

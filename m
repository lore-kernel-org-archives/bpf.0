Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7458122B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194373; cv=none; b=JW8irmqfKNuh3ioj7QqzJquWUjO+Qo9rKI0JGvJQW3QhJ8lMHYBo/LVWGXNYWgBASfaxKHwr/rqKI9ttC0Khbjhiutp26685MY17LQdwEn7M6CZ0ZhNt42nKkfZxQ/DNtCKSMxB/oBNiaQ1hpr8byZgQoWY/tnhuvocrSC5IC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194373; c=relaxed/simple;
	bh=wAEuQNjEMmFW5aZClx53ALoIyHMSSJNPMinF1Nal70Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JU2lrvhhqjaQTQ26bhU3tS0WNiwuv/kGq+pTPlw1aI9s0FeZwdDukInL8zOPeZeoAenzlw+m3IovzRQQo0Cvy5qACg8jqvQjfXp/JA9W3vDRU/izukq9BK9s7i/aa3se8hKAtNMSxwhQmIb2+efimoYg/20yCHjdw7ZiMSpJV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBOzKP9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBOzKP9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258951F00898;
	Wed, 23 Sep 2026 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194363;
	bh=JGiYvQ1+a8NmS3ajeASpGC/dbBojlZOw7TmzqPIsptA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TBOzKP9k7i6X/GNMwMncK2C1UoP08f+/ILj5QEnQvwGrs/PRJeVvKRKAElCe1BwDl
	 QJrshGrel7//j5hvkyNlrxs6CrxJOr7g+V33XTejbyqIBi+B61tEQ5rqy+GnppEPdo
	 qgk/MlVr9BtyamGjt4p9ZXsQIz2/iCtPuZ1WSIK0FnrCWn8vIMjuhjmQTZqJ/jlxOs
	 eegdMubj7cYFaP6OStWaa0F/LP7WuzF1I+AR3S7vzwcF1L2oiPQ1XWTxwmeAnR9V/x
	 jv1RCeYaPayX2OFMz+vjJhMpHx2o0eIMtah737hZiJ6pyXxuy1whulhv76N2eEFZ5b
	 Ec3M4k/CbkqlA==
Content-Type: multipart/mixed; boundary="===============2181079628725225313=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a1d67ea63858c1e4125d88f346df080360f4a9dd7b17e53163ccbfdb0dddd2c3@mail.kernel.org>
In-Reply-To: <20260923191139.2816206-13-memxor@gmail.com>
References: <20260923191139.2816206-13-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/18] bpf: Size the per-frame verifier structures for a 2 KiB stack
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 20:12:42 +0000 (UTC)

--===============2181079628725225313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d8cafd3d74aa..11fa9f1f087c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -19,11 +19,12 @@
>   * that converting umax_value to int cannot overflow.
>   */
>  #define BPF_MAX_VAR_SIZ	(1 << 29)
> -/* size of tmp_str_buf in bpf_verifier.
> - * we need at least 306 bytes to fit full stack mask representation
> - * (in the "-8,-16,...,-512" form)
> +/*
> + * size of tmp_str_buf in bpf_verifier.
> + * we need at least 1399 bytes to fit full stack mask representation
> + * (in the "-8,-16,...,-2048" form)
>   */
> -#define TMP_STR_BUF_LEN 320
> +#define TMP_STR_BUF_LEN 1408

TMP_STR_BUF_LEN is raised to 1408 so that bpf_fmt_stack_mask() can render
all 256 slots. The commit message says the buffer grows "so that all 256
slots still fit". But every place that consumes env->tmp_str_buf prints it
through verbose() -> bpf_verifier_vlog(), which formats into a fixed kbuf:

kernel/bpf/log.c:bpf_verifier_vlog() {
    n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
}

BPF_VERIFIER_TMP_LOG_SIZE is still 1024 (include/linux/bpf_verifier.h).
The precision backtracking log lines are:

kernel/bpf/backtrack.c: {
    verbose(env, "stack=%s before ", env->tmp_str_buf);
    verbose(env, "stack=%s: ", env->tmp_str_buf);
}

With a full 256-slot mask, the "stack=%s before " line is 1412 bytes and is
silently cut at 1023 characters. The remaining slots and the trailing
" before " / ": " separator are lost, so the next log fragment runs into
the truncated mask.

The mask alone goes over the kbuf limit once roughly 168 or more slots are
set. The larger tmp_str_buf therefore does not deliver the complete log
line the comment and commit message promise. The extra 1 KiB only helps up
to the 1023-character kbuf limit.

This commit only resizes the structures; the verifier still caps the stack
at 512 bytes here. The problem becomes reachable later in the same series,
in d1a4a32c6444 ("bpf, x86: Allow programs 2 KiB of stack") and
5782325bd60a ("bpf, arm64: Allow programs 2 KiB of stack"), which let
bpf_jit_supports_large_stack() programs use more than 64 slots. No later
commit in 00a8442f56e5..7757cddf610a changes BPF_VERIFIER_TMP_LOG_SIZE or
the print sites.

The impact is limited to log readability (no memory-safety or
verification-result impact), but selftests or tools that parse the stack=
mask from level-2 logs will see incomplete data.

Should BPF_VERIFIER_TMP_LOG_SIZE be raised to at least TMP_STR_BUF_LEN
plus a small prefix, or should the mask be emitted in pieces with several
verbose() calls?

>  /* Patch buffer size */
>  #define INSN_BUF_SIZE 32
>
> @@ -243,12 +244,13 @@ enum bpf_stack_slot_type {
>  #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
>
>  /*
> - * Largest number of BPF_REG_SIZE stack slots a single frame can have. A frame
> - * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth()
> - * enforces the bound on the combined depth of frames sharing the kernel stack
> - * and on each frame using a private stack.
> + * Largest number of BPF_REG_SIZE stack slots a single frame can have, sized
> + * for the largest stack budget any JIT supports. A frame may use any part of
> + * its program's budget; check_max_stack_depth() enforces the budget on the
> + * combined depth of frames sharing the kernel stack and on each frame using
> + * a private stack.
>   */
> -#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
> +#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK_JIT / BPF_REG_SIZE)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35909853278
--===============2181079628725225313==--

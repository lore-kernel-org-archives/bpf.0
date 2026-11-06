Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939087;
	b=42crMVTGyHtBrjK52m+YYqjw+v2QmrxKaoqqrdSOJ8lAFdpEYdIwliVVJMBjkQSQxeM4
	 5bMT+y1Sh4I7P8PTY0W03oWfydXXeo+3mt5rrD3KnBgFyGPi8YPLhG1fpH4x9RyEfdig3
	 xzc7rdfEc76VFc5B4ZELejVetDM3MUPv0hI9Mt9NDYRvQR6eXWQdZ3NNWHtjmhVNq4VNw
	 XWl/qRKQ71Y+IC5lOrQcOsxK3sw2qfsIAwU0PoGvbit871P3Xw1JGmVhEcgpem8IlEuAi
	 e1AvFUqN7zHB+ruMdQZq2dYlWPd1oRjneGGZlipvB2GZY0d/oacVJcZmywfaWhr8ywg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939087;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=hSm0e+ZV7/yMtYwZEQYDMojj2o9mtOZQTSa2xwiK1P8=;
	b=v2JMViZKZ+zfKVwv7+V/OeroZ5ojgloaWc0R9Ijugp17zl6PigNFTsLjqvgWaqwz2I6J
	 Ze6WAVVq3E5NnYFaFBpe2vWX/wBhNo372ACENSS8mdGRspoi4Bwr9CqismRKZF1TGJCES
	 SeJgETaeC3CY1Omp3z9x9g1ZqrDZocH7JZR3EB12Gzqzby9+mm14FErM7sCJ3kNT0kZXo
	 pmKTPcM2JIO/jxQkUuGvHov9L3ntVmta/+Ffi1HqdrkV7bCl3pj7Z19KN21WwqXroYYQ9
	 g1lvwjeTxUm2cMI8x9ZBGGPZOsOmt6oeETqZxB9HQTFPpWNJi+/KNh9pp65aJzU3bbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REjA6Wt+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4F606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REjA6Wt+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC581F0089F;
	Fri,  6 Nov 2026 04:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939086;
	bh=hSm0e+ZV7/yMtYwZEQYDMojj2o9mtOZQTSa2xwiK1P8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=REjA6Wt+Ok6nRRKsO+oJa7u4BVJyBEwno3etZ1qxJAg/z6+FrXXCpeaUtbE9uWfjJ
	 KjqpMZKVqAHY5eQ1KDxKJvC4ElgsLTwIlorIuXbuijxjMdwjpnZzcY/mAbvo2TeHWa
	 xGGw8iE5HHlpMbdAcppTEAu/JR+0Q68BIEsokiYnixv7k3BAb6oA/fLpjZdRtGDEUq
	 GDSlaMl2A6wJhdAY+L6Nqm+Rx8PCeUq0EE/kjxcVuJo4KOtT7v7eeApFCxC2FYIgCg
	 aGRfO1CbOvzDT7ol5bwWf0RS6b1Ta3iYyNU4EZqGyJyOtA00rwNk48I/8tLXTrEQvp
	 +Oe0OP+/6a8xA==
Content-Type: multipart/mixed; boundary="===============2275813601394709311=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1e87490a2937f20e69335a500c19a1fa5652ed6b15a20da1bd371311288cb9b0@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-8-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/45] bpf: Add the data structures of the main pass over the control flow graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:24:46 +0000 (UTC)

--===============2275813601394709311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add the data structures of the main pass over the control flow graph

TL;DR: Comment-only nit: the head comment's rule for verifying static
functions on their own is incomplete, since later patches refuse more cases
(e.g. maybe-NULL pointer args). Suggest pointing to func_is_on_its_own().

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> new file mode 100644
> index 000000000000..01681957855d
> --- /dev/null
> +++ b/kernel/bpf/flow.c

[ ... ]

> + * Functions. A static function that gets nothing but numbers and pointers to
> + * what is not the stack is verified on its own, for the states at its entry
> + * and not for every chain of calls. The call waits. What comes out of the
> + * function goes to all calls that wait for the states it comes from.

This isn't a bug, but is this rule complete as written?

The func_is_on_its_own() function added later in the series (in
"bpf: Verify static subprogs on their own") also refuses functions for
other reasons:

    if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
        sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
            return false;
    if (state->speculative)
            return false;
    ...
    if (state->acquired_refs > BPF_ID_MAP_SIZE / 2)
            return false;

and arg_needs_caller() refuses some pointer arguments:

    if (reg_is_pkt_pointer(reg) && reg->id)
            return true;
    if ((reg->type == PTR_TO_PACKET_END ||
         (reg->type == PTR_TO_PACKET && sub->loads_pkt_end)) && !sub->recursive)
            return true;
    return type_may_be_null(reg->type) && !sub->recursive;

So a static non-recursive subprog that gets a map value pointer that may be
NULL, or that calls a helper that changes packet data, is still verified for
every chain of calls.  Later commits narrow the rule further, and the
paragraph is not updated.

The other paragraphs of this comment point to the function that holds the
details, such as bpf_states_join() and flow_compute_order().  Could this one
say that the stated condition is necessary but not sufficient, and refer to
func_is_on_its_own()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============2275813601394709311==--

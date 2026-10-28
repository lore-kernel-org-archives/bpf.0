Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150733;
	b=YOFBFj8TBXaovLLbcMNDUqKu1plo346CPN4TgnIzQm96YfNJXleYEfzgsFk/b4pf4r/j
	 +iUWU/5UqXFeAcfIaIy4C4lcHzBLwsq3VgfdFj3T+QoAW5HdftIWuZHvtpdwKCs8Xl7DM
	 M8bJ2RwGxGoP82kPLsGuoFisCdQ3METF8lCNP+4I8NlG46RBRGW5xQMEHJYYvU0eGlfA0
	 z+JwAWJPZ8JTRe6uWVP+OUWm9ZvlhRa7tzdcCQQR5X9tc69cBN2G3gZ/ElMnbJ60PybIk
	 0/LP1cDAPvL3vTw959Fr6woCKG6TvRCbeSrXIQVZkmeXQojsKq53xYjWZ5MVXJgp9eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150733;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ZrDj8FzyCe6Slte1Ar+XvlMDgWSj73BLxNLPRjeu8gY=;
	b=xjoxxBdprIXVvZe/Nk02h7Wc2DFvvmCMr5T8Xyybjp/wF/zYDFUQQju7LmIILpF8CkkG
	 fMQApxWYtQY5WJTDlI6EFEUnYxaURs4+4SxEggoysJSnNLVOZ3ku4LNXJWSybYpoFtrtk
	 KsHPw5tunzprbj7JM2G+m4yyIyF2KXnHGYPmPbzOz7MMbnXDeW/IOBQAosdRc2PKnF78G
	 CXbNXQ4Not7T3UbrOXSwErfORFt+y7lNnDBCT4raWkUO1cBzP53BzRKLB6MG9XPQRkdxy
	 bDISQef4+DJqkM+hOx7n262bHCkSJNpdlvKpPbgItfyJYvhOYkpv9C/slGujZx4oCGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hizm0/cy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEB606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hizm0/cy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D4D1F01825;
	Wed, 28 Oct 2026 01:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150733;
	bh=ZrDj8FzyCe6Slte1Ar+XvlMDgWSj73BLxNLPRjeu8gY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hizm0/cyfzB/srrnRprAeoMQv2uofDEg19iw+TkrWC5Y1OCYC8rLrVg3iKLxVM3s8
	 ZRFbvnSsQHl0+XOb9C+JK8xuBEJojxUo2N2AIyvtD8UfHTbMy7jNSj2Cb+QN0MXtTa
	 ErTGF/gX9Ml4tInboTp37VBv8OpwixzLNlH6HstjWj86DQZ15lUlt3RsrEY5HpELX2
	 aXcITsY51/0MFPE5XwpeTwH6KqVVEKKxKZiKJ8UKGu8k61e8Be2Owg1d1tUhqT3NKG
	 4pFG8bUAOsGMA6R7gUqyv2R0aC7YKHC0oZlMMRL1KWmUSzOhvN3ODRuNeJjqJwLmnA
	 AvoDLn2cm+I4A==
Content-Type: multipart/mixed; boundary="===============6530758837708285994=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8b767073e860cc55e546b7d5e034d3f757b91d207627e92aea95112977ec002f@mail.kernel.org>
In-Reply-To: <1b3fb00521b2eda1ffa902ee6e413d30b677bdb0.1793147364.git.memxor@gmail.com>
References: <1b3fb00521b2eda1ffa902ee6e413d30b677bdb0.1793147364.git.memxor@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 06/11] bpf: Let the callback of bpf_for_each_map_elem unwind
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 01:25:32 +0000 (UTC)

--===============6530758837708285994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let the callback of bpf_for_each_map_elem unwind

TL;DR:
- Array map callback may return a PTR_TO_MAP_KEY to dead kernel stack after
  unwind, possibly leaking stale stack
- bpf_unwind_leave() may misbehave (WARN, wrong return) if the helper is
  traced

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 133f189bf6d2..4c81c7c76145 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> @@ -823,14 +824,18 @@ static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback
>  			val = array_map_elem_ptr(array, i);
>  		num_elems++;
>  		key = i;
> -		ret = callback_fn((u64)(long)map, (u64)(long)&key,
> -				  (u64)(long)val, (u64)(long)callback_ctx, 0);
> +		bpf_call_cb(callback_fn, map, &key, val, callback_ctx, 0, ret, unwound);

Can the PTR_TO_MAP_KEY handed to the callback here outlive the frame it
points into?

&key is a local in the frame of bpf_for_each_array_elem(), and
map_set_for_each_callback_args() types it as PTR_TO_MAP_KEY in R2 of the
callback.  With BPF_FUNC_for_each_map_elem now in helper_has_cb_pad(), the
callback may leave with unwind_exit, and prepare_func_exit() from
b2f03cf6322f hands the callback's r0 to the pad unchanged, except for
PTR_TO_STACK, which it refuses.

A PTR_TO_MAP_KEY in r0 therefore reaches the pad after the call, where
check_mem_access() still allows reads of key_size bytes through it.  By then
the helper frame has been popped (and, on the indirect path, the frame of
bpf_for_each_map_elem() too), so the pointer refers to dead kernel stack that
any later call or interrupt can overwrite.  A program without
allow_ptr_leaks/allow_uninit_stack would be able to read stale kernel stack
through it.

The changelog of b2f03cf6322f mentions this case: "the key of the array
iterator live in the frame of the helper ... the fix for that has to see to
r0 too".  Nothing between b2f03cf6322f and the end of this series adds that
fix.  Hash and rhash keys point into map elements rather than the helper
frame, so only the array iterator is affected.

Should a PTR_TO_MAP_KEY r0 (or any pointer whose lifetime ends with the helper
frame) be refused or turned into a scalar at the callback's unwind_exit
before for_each_map_elem is opened up for array maps?  Alternatively, could
the key live somewhere that outlives the helper?

>  		/* return value: 0 - continue, 1 - stop and return */
>  		if (ret)
>  			break;
>  	}
>
>  	return num_elems;
> +
> +unwound:
> +	/* The callback left with unwind_exit: nothing to drop here */
> +	bpf_unwind_leave();
> +	return ret;

Does bpf_unwind_leave() work if the helper itself is being traced?

It reads the return-address slot of bpf_for_each_array_elem() and looks it up
with bpf_unwind_target(), which only works if the slot still holds the
address the BPF caller pushed.  The same leave path is added to
bpf_for_each_hash_elem(), bpf_each_rhash_elem() and bpf_for_each_map_elem().
All four are ordinary traceable functions: arraymap.o, hashtab.o and
bpf_iter.o are not in the CFLAGS_REMOVE list of $(CC_FLAGS_FTRACE) in
kernel/bpf/Makefile, none of the four is notrace, and none is in btf_id_deny.

If the function-graph tracer, a kretprobe/rethook, or a BPF fexit/fmod_ret
trampoline is attached to one of them, the slot would hold return_to_handler,
the rethook trampoline, or a trampoline address, and bpf_unwind_target()
would find no entry.  Then WARN_ON_ONCE(to == *slot) fires (fatal with
panic_on_warn), and the exception comes back as a plain return.  The BPF
program carries on past the unwind_goto on the normal path, in a state the
verifier only explored on the unwind edge.

bpf_check_attach_target() already guards the BPF-target version of this
("unwind_exit would return to the trampoline that called the target", "Only
fentry can attach to %s, which can unwind"), but kernel-function targets that
now carry pads get no equivalent check.  bpf_loop() from 4e61c40fe5c0 has the
same exposure.

Should these helpers be marked notrace and added to btf_id_deny, or should
bpf_unwind_leave() recover the original return address (as
ftrace_graph_ret_addr() and rethook do for unwinders) before the lookup?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40612543702
--===============6530758837708285994==--

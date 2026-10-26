Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986778;
	b=w+5rgS+gWARcCL0gxAfq6OEZYL2Vux6gjziHuYm9KfHO8+jOoMIiJszw6cPRNzTCZxau
	 UQ146p4J77adKJ445uZ0eMv0USxA3tpdYxuPatsh5ClMHbO1qHjGG0miYSI03doq4dSLx
	 8BtDwmadqr6VyH/Ut7DLZJY0xx9YQ+pjwsqTk+kEV3WO+8WuwjQUw9JDZ3SWz5msXdST2
	 b71BIm/aClEyH7+7kKseeckhND7aL6Sl5VJtnmYrEx5E/p+NBjqMx7+7RhHqmQWViqgU0
	 k6+hUpcXgry9PgIcag8yj0X48HqC6xYogQBMxi9hnSxiGVF5OKyug9pIftW7QiNujzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986778;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=3pzZUgGQvwUINfOBXy8pMJ1dugOTp+5iGtG6RBPfvDo=;
	b=35AQOeKdafmmxS/Fu6PWVN9HhT1ehHnz11qeK8euN7N/+YEivLKP5U6Jb+kpwdqX7FDY
	 FN9T2S0SBavguKZuPcIxaKtdvnegONd1tYnq9u9tBjYmVVMOnWOVJl+Qtu+V9xWhkH8RC
	 JWbefrbFDs8BGcViazuj0kIn7Y6QUqNTqrEjD/xi+2s3xUQcvFZZqyJBcQjcTzc2XjbT8
	 h3zFD/D2Ao/XPi007ovHtW9gKfwz3PgDc582bCRljwMz69OziVQA2bjCAnKUYjW4HlRBC
	 8XhhWp2Q/qgz+xLb+C3qNG8OKprR6DSPNflpVH2VovoIHqHQS19zpqKe0VC8t1TmUZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPpY4fo3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E5606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPpY4fo3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44AE1F01825;
	Mon, 26 Oct 2026 03:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986778;
	bh=3pzZUgGQvwUINfOBXy8pMJ1dugOTp+5iGtG6RBPfvDo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WPpY4fo3LQtWNIzGbXE7QtxCe83Wn4yvj8IHV4LVt14b+q515CznMrPpfTB0LYO8S
	 SBr/VY9p+kv+R8YebK//SBw58W7z00X24uWMVs7TRkzBp9OoZJ6AhaF3N0YeVpcW75
	 Ods0oQxXIXie0TNHMo/FhhmH4aU/ahXput/xgQpDlsZ+SoNGY0eAlFaHb3uK2FoGll
	 wZiUZVjgsUfYE0z5uTW4EiIPTCLLkhoqvs+SRvrbs+Um6sUlzVKDkBp7pDMdEJyQcU
	 x5CaymdD6Pn2yhfxvLBsRYtAygU+t4A5zhkgplXN7s/ZjKDpx0Ctdck6FhnfvJpMG3
	 YXYYJ3i8AFM1Q==
Content-Type: multipart/mixed; boundary="===============1248595083483076292=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b2f685123bf7383bd43fe74d2fe05dd6a5f59e59d32c97c5bfca9e010bd8581b@mail.kernel.org>
In-Reply-To: <20261026025943.404450-64-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-64-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 63/81] bpf: Print 0 as the limit in the statistics line
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:52:57 +0000 (UTC)

--===============1248595083483076292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Print 0 as the limit in the statistics line

TL;DR: Comments only: "no limit on verification" in bpf.h and verifier.c looks
inaccurate, since flow.c still rejects programs with -E2BIG when states exceed
bounds. Suggests narrower wording. No code issues raised.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d8cd7c63f157..8cd82f506e0d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2636,6 +2636,7 @@ struct bpf_array {
>   */
>  int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key);
>
> +/* the longest program. There is no limit on what it takes to verify it. */
>  #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
>  #define MAX_TAIL_CALL_CNT 33
>

Is it accurate to say there is no limit on what it takes to verify the
program?  The commit message says the verifier now limits the number of
states, see BPF_FLOW_MAX_STATES.

kernel/bpf/flow.c still rejects a program with -E2BIG in two cases.  The
first is when a single insn has too many states that cannot be joined:

    if (flow->nr_states[insn_idx] >= BPF_FLOW_MAX_STATES) {
        verbose(env, "more than %d states that cannot be joined at insn %d\n",
                BPF_FLOW_MAX_STATES, insn_idx);

The second is when the total number of states is too large for the program
size:

    verbose(env, "too many states for %d insns: %d, %d at a time\n", ...

with the bound computed as BPF_FLOW_TOTAL_PER_INSN * env->prog->len +
BPF_FLOW_TOTAL_BASE.

So the effort to verify a program is bounded, and a program of
BPF_COMPLEXITY_LIMIT_INSNS insns can still be rejected for complexity.  What
is true is narrower: the number of processed insns (env->insn_processed) is
no longer compared with any limit.

The same shorthand appears in the verifier.c comment "user space parses this
line. There is no limit."

Would it be more precise to say the macro is only the maximum program length
(it is still used by the insn_cnt check in bpf_prog_load(), by
BPF_MAX_GOTOX_EDGES in cfg.c and for sizing in liveness.c), and that
complexity is bounded by the number of states?  For example:

    /* the longest program; verification effort is bounded by the number of
     * states, not by the number of processed insns */

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 864009dbac47..3bc0dcbeaa60 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22783,9 +22783,10 @@ static void print_verification_stats(struct bpf_verifier_env *env)
>  				env->subprog_info[i].stack_depth);
>  		}
>  	}
> -	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
> +	/* user space parses this line. There is no limit. */
> +	verbose(env, "processed %d insns (limit 0) max_states_per_insn %d "
>  		"total_states %d peak_states %d mark_read %d\n",
> -		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
> +		env->insn_processed,
>  		env->max_states_per_insn, env->total_states,
>  		env->peak_states, env->longest_mark_read_walk);
>  }

The same wording applies to this comment.  "There is no limit" could be
narrowed to say there is no limit on the number of processed insns.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============1248595083483076292==--

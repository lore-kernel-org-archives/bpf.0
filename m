Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163108;
	b=vJS8B+TwTLsQcfBI2Aa9BWGW4HsGpXkAnuU2aLwedrR68M9ke7S61QjfY+m1qu8e3xPg
	 xnCT2aTDIOLI0tj2+aSv4ZqzRro7ASqxBKjontwoiB90EMfzDAehmyptXOggi6WSrWthD
	 t2wskqZeMwPwXqCNze1Is8wmtsd8vbl3iMXWRxC9pJNVFMKDXJFngPkdGI1soB7+94fJc
	 DIwTpyyXLni2cTe0PpAfOEkzrP3webAeBEMRelN/7wPqvHb9Qqz8y5oG/giYwnFchImeb
	 p6buFqbDhUNv/CONJSB35tT/IEUsRv3mfetRNeCUb9x2+qq5BMrU638tHzHlbOqJIPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163108;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qIqXZo4c/RKJ07CxUaCtA03PMs3zMa+g15pCpx3IIRc=;
	b=lp1skyYLcnUbHUb7UJipkBbvOnAowRKkdggFrv0MfxxjiLhaPGfY0lTrDiIYDrZta21d
	 giS188zRvLdd4x7FeGbFFXgAzPae4WXc9R67u1bjZpNXLddm8pH/b6sLryC5gY6IbcSI2
	 NR9oc2md8M9kY+obM0HxGK/dgfcuQOZT2pd/61uAB7CQRuMBmH6FsL96cfI6Q7DDJ3RW1
	 NPqAPzHZSmLwli0JQMhKV9gSd7bGJGvaCZPcbxXseBfqSECpphQh7afiWAu363tNjwfJZ
	 74xPgO5WYYBEOVJ4vj5lrQI1B0WGJinGQvdv2mq6oCqgabjaV+054WIUtyhV38ZZLKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeJmKMS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177E606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeJmKMS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A01F000C4;
	Fri, 20 Nov 2026 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163107;
	bh=qIqXZo4c/RKJ07CxUaCtA03PMs3zMa+g15pCpx3IIRc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EeJmKMS8FET5cySMblgmH4nyiylLhwRMk/RDQ9igVcVkbr0z96qh6l+0tLFRchV0m
	 h6kaMl/l25OGJws7qdzEPPp3OoE40vxvuskPpXlSAJhP7NzXpTLumq8NJ4P3cmX/wV
	 sDb60tN86QlfJrbNQ0ztxwhKt+cCkozEXQhUW2Mw4PUnN39fLqxKLhPti/aTZcQbvC
	 37NOmnDBm7FErgwVdegnHDtuAZvQRZD7fPkAe4qg8KUWfn2zVFHT+gIpJ12QCps0wd
	 AI//XejWyEkU7cYqrja/Aw/HVXOc0IL2CLGXNnQRXUfX+RGdKVQaC4YKaHEseJ2aPB
	 7Jbi5LzLWn7sQ==
Content-Type: multipart/mixed; boundary="===============7236217941638020098=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9249cfbdbaf07a35d422dcebaa40c68e8536a3d45283a234495ec7abed2d229e@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-6-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 05/49] bpf: Limit the cost and the memory of a load
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:06 +0000 (UTC)

--===============7236217941638020098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Limit the cost and the memory of a load

TL;DR:
- free_states() loop still calls bpf_free_verifier_state() with the old
  arguments, likely a build break and unreleased memory charge
- verifier_liveness_exp selftest may now fail: it expects the removed
  "complexity limit" message

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22010,9 +22032,9 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
>  static void free_states(struct bpf_verifier_env *env)
>  {
>  	struct bpf_verifier_stack_elem *elem;
>
> -	bpf_free_verifier_state(env->cur_state, true);
> +	bpf_free_verifier_state(env, env->cur_state, true);
>  	env->cur_state = NULL;
>  	while ((elem = env->head)) {
>  		env->head = elem->next;
>  		bpf_free_verifier_state(&elem->st, false);

This call in the loop still uses the old two-argument form, while the
prototype now takes env as the first argument.  Won't this fail to build
with "too few arguments to function 'bpf_free_verifier_state'"?

Even once the argument count is fixed, these pushed states were charged to
env->mem by push_stack() through bpf_copy_verifier_state() ->
bpf_charge_state(), so they need the env-aware free to give those bytes back.

The later commit 931721673c10 ("bpf: Put a barrier where no mask fits")
moves this loop into free_pushed_states() and passes env, so every commit
from this one up to that one is affected.  Should the loop be fixed here,
where the prototype changes, like flow_drain() already does in this patch?

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2366,18 +2388,8 @@ static int analyze_subprog(struct bpf_verifier_env *env,
>  	int po_end = env->subprog_info[subprog + 1].postorder_start;
>  	struct func_instance *prev_instance = NULL;
>  	int j, err;
>
> -	/* a subprog on its own is analyzed once, chains of calls multiply */
> -	if (depth && ++env->liveness->subprog_calls > 10000) {
> -		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n",
> -			env->liveness->subprog_calls);
> -		return -E2BIG;
> -	}
> -
> -	if (bpf_must_abort())
> -		return -EINTR;
> -

Removing this message leaves the selftest
tools/testing/selftests/bpf/progs/verifier_liveness_exp.c expecting it:

    SEC("?raw_tp")
    __failure __log_level(2)
    __msg("liveness analysis exceeded complexity limit")
    __naked int liveness_exponential_complexity(void)

The program still fails to load, but now through the cost limit, where
bpf_check_limits() logs "BPF program is too complex: cost %llu of %llu,
memory %llu of %llu" and returns -E2BIG.  Nothing under kernel/bpf prints
the old text any more, and no later commit in the series touches the
selftests.

Will test_progs -t verifier_liveness_exp now fail?  Should the expectation
be updated, for example to __msg("BPF program is too complex")?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============7236217941638020098==--

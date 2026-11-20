Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163142;
	b=FWSVXOoNlBC5zRJead1ZIDLwkQaoJ6HwmubIC6DySw3UPo4IZc0u6EMw87ASjFiBW5op
	 6JONCqgOrp3kzTEb2W7KUCbG0FlPoUc7f6j8oZN6Mc6g5XN7rGOEtrTzd3245XWOzRnHY
	 pTVbQ9LxJQJn9BWdJBVWWHZLdURl7VsSYP1WOTsW6jzTv4WTo3UVFWB8ZX95dAC84rY8h
	 dkgo4bW8hsLfBMkz2uMzpFwYN+WnBoJuDuVOyP+gYr6KKdzJFGSj9DoRARBMVYXZyr1v9
	 nV135gxgThOxfYSpquIwRx8GSU/y1iqPdD5C63YemDIPge9Kufs4WjSy3m6bqiTBb5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163142;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DtQgwtFpuXadVelfi/xCa+4GDYnKP6T8sIWIIadHHqU=;
	b=a7uFGXYP9i1m+/2Qdi2odFxqg8mjz3K5iXvFVUWJCM/xsPZ8l6VTFUiQ90eoY45Hvtwn
	 lTN9l8uoLt5a4wr1Jy7KCSmzC27wayOfHhD9pOZxpmMqa/cRza2NreQa8Qjbg6iFTEmqE
	 p+2j1wgT9uXK7WYuw78OtGGe0LUyNXxUSFpxgMpfjopAiRdoH9Zyme0YjkKU/62kFVfyp
	 vGGZkE5S7bh3UsqnhIYC7l8eTYkVM/LyuDB20ruchTDnTLn1KZqLSVPRv/Sdxj7A5S9tZ
	 /KCn5u1tfGwnkyiQEAzrMlmuAGYjtfVa2y6v98SrMTmrf1kAT0JxJ3zfim9Ajza9MbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3AiRlMr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F53606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3AiRlMr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8A1F000C4;
	Fri, 20 Nov 2026 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163142;
	bh=DtQgwtFpuXadVelfi/xCa+4GDYnKP6T8sIWIIadHHqU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b3AiRlMrxFvF7vyxfYMzypRMJYPMvLqRhfQOEmJsBEGzQqsU3IsTgLjtLs73JGVdD
	 bkalfmlEwtOVFhDNRpxO5nmozE4jW3kG2CgkVhLhGDPpV0K1lPH3edDGE5+NpEtsTG
	 WI1YaqgfpQThdRkCKTbfB/E+dzFFvHNQHyK7Rw3hY2w7CdPbkeyTwt05YqyhsABqP7
	 8iIBxXDlZBdY+DcOqHrmACRatnZdEAivXHSjvZBL5v4+oWVYfWCtUWrjtHORvLexNv
	 8Km2F3mC2ugEUFMX8TMy/HDR1xx74Wn7q6XO6PoowZVwQAeDhZk/SrX0TC+1k19acs
	 /Ji2flvkCMGPQ==
Content-Type: multipart/mixed; boundary="===============2559208742481425716=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ad82954b5dbf7e28fcfcb7a41802667e9efdf117cf4fcc8b09be22a20fac94d1@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-5-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 04/49] bpf: Delete scalar evolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:41 +0000 (UTC)

--===============2559208742481425716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Delete scalar evolution

TL;DR:
- loops.c uses bpf_add_cost()/BPF_COST_SCAN, defined only in the next commit,
  so this commit may not build (bisection)
- verifier_loop_hierarchy and verifier_scev selftests likely fail on removed
  log lines
- unused helpers remain despite commit message

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> --- a/kernel/bpf/loops.c
> +++ b/kernel/bpf/loops.c

[ ... ]

> +static int find_latch(struct bpf_verifier_env *env, int h, int n)
>  {
> [ ... ]
> +	if (bpf_loop_at_index(env, n) != h || idoms_intersect(env, n, h) != h)
> +		return -1;
> +	for (; n >= 0 && !bpf_insn_leaves_loop(env, h, n); n = n == h ? -1 : env->idoms[n])
> +		bpf_add_cost(env, 1, BPF_COST_SCAN);
> +	return n;
>  }

Are bpf_add_cost() and BPF_COST_SCAN defined anywhere at this commit?

A git grep finds no definition of either.  The only other user is the
bpf_add_cost() call in kernel/bpf/liveness.c added by cd07fb71e4d5 ("bpf:
Make stack liveness faster").  loops.o is built whenever CONFIG_BPF_SYSCALL
is set, so this looks like an implicit function declaration plus an
undeclared identifier, and loops.c would not compile.

The definitions arrive in the next commit, ecbd98bcc45a ("bpf: Limit the
cost and the memory of a load"), which adds BPF_COST_SCAN and a static
inline bpf_add_cost() to include/linux/bpf_verifier.h.  That commit also
adds bpf_add_cost() calls to idoms_intersect(), assign_header() and
bpf_is_nested_loop(), but not to find_latch().

Should the bpf_add_cost() call in find_latch() move to that commit, or
should the cost definitions come before this one?  As it stands this commit
adds a second file that does not build, so the series cannot be bisected
until ecbd98bcc45a.

[ ... ]

> @@ bpf_compute_loops()
> -			for (j = 0; j < loop->exits_cnt; j++)
> -				bpf_log(log, "  exit from %d to %d\n",
> -					loop->exits[j].from, loop->exits[j].to);
> +			if (loop->exit_to >= 0)
> +				bpf_log(log, "  first exit to %d\n", loop->exit_to);

The BPF_LOG_LEVEL2 loop dump no longer prints one "  exit from %d to %d"
line per exit, and it drops ", dominating exits at ...", ", too many exits"
and ", too many exits of a nested loop".

tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c is still
registered in prog_tests/verifier.c and still expects the old lines with
__msg_next():

  loop_nested_siblings_common_ancestors:
    __msg_next("  backedge from 10, latch at 10")
    __msg_next("  exit from 10 to 11")
    ...

  loop_outer_backedge_from_inner:
    __msg_next("  backedge from 4{{$}}")
    __msg_next("  exit from 5 to 7")
    ...

"exit from 5 to 7" is not a substring of "first exit to 7", so both
subtests should fail.  loop_nested_siblings_common_ancestors also exists to
check that edge 6->7 is "logged only as an exit from loop at 5", which the
new log cannot show.  progs/verifier_scev.c also matches "too many exits"
and "dominating exits at" lines that are removed here.

Do these selftests need to be updated or reworked in this commit?  None of
the commits up to a50a112fb866 touches them.

[ ... ]

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> deleted file mode 100644

[ ... ]

Deleting scev.c removes the only code that prints the "scev at header N:",
" scev at latch N:" and expression-dump lines at log level 2.

tools/testing/selftests/bpf/progs/verifier_scev.c still has 39 __msg() and
__msg_next() expectations for them, and prog_tests/verifier.c still has:

  void test_verifier_scev(void) { RUN(verifier_scev); }

For example:

  __success
  __log_level(2)
  __msg_next("scev at header 1:")
  __msg_next("  r0=(+ r0 1) / (linear r0 1)")
  __naked void simple_loop1(void)

Won't test_progs -t verifier_scev fail on these?  verifier_scev is not in
ci/vmtest/configs/DENYLIST*, and no commit through a50a112fb866 touches the
file.  Should verifier_scev.c and its RUN() entry be removed or rewritten
in this commit, given that it deletes the feature they test?

[ ... ]

> Delete scev.c, its callers, and the helpers that only it uses.

Is this accurate for bpf_mark_reg_known_scalar() and scalar_union()?

Both are non-static in kernel/bpf/verifier.c, both have prototypes in
include/linux/bpf_verifier.h, and in the parent their only callers were in
scev.c:

  bpf_mark_reg_known_scalar(&scev->zero_reg, 0);      (bpf_init_scev())
  scalar_union(&iters->iv_range, &tmp.iv_range);

Neither has a caller after this commit, and neither is used again through
a50a112fb866.  The compiler does not warn because they are not static.
scalar_union() is also the only remaining user of gcd(), so the
#include <linux/gcd.h> in verifier.c appears to be left only for it.

scalar_intersect() and bpf_same_memory_origin() also lose their callers
here, but later patches in the series use them again.

Should bpf_mark_reg_known_scalar() and scalar_union() be deleted together
with their prototypes, or should the commit message be reworded?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============2559208742481425716==--

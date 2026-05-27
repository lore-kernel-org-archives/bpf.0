Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD13E9C0F;
	Wed, 27 May 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886784; cv=none; b=Gpd6FbelEAvvSWA65KoSPs1XVJbT3zBCdkIzlbeFd5H2/Wwk4zEVdFyHX/y3su4pOyPjWR14hmf7sT0PWkzvl+2D+KO87kPpwQqwuPPhCMWOiYtrCSvH/xXpCC3qkAHiwr7228mex0M7g3CoNdrNzckNNlLQRzxNHPLBXLjZr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886784; c=relaxed/simple;
	bh=5YMcwRTM5MRFQmytpEYZDz+fdfPjEJi5touwGbDyeZI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VyVj2hVmUKmBa4jwrU3dA8DFwEzgguggc+HZPL/e1uDAOAO11XCTvVQK6B9L2ooe2oLkfSg2ZCvvd+VhBMcRbPQd3VyLFSkq6G/Api2CX2Q/7S4dK5AGTwgpUJjV1C4m80bXyRGLVPCSohBWRtqsG4oVF/PwWwLRM6I0uE0PvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPIzCX7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPIzCX7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFC61F000E9;
	Wed, 27 May 2026 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886783;
	bh=PZc3CwxugLpx8XjxkywPKHC7l+bBNg13y0ds94rmUsc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GPIzCX7V2g1XUwQV1RfWFdP0RiohWmbxUIvOXqxTavqPBoVnxfg5vfqeoXvYBcRIQ
	 apuTrigXZboBO4SthvmTAaDWrZvHjEm33MaSrfHvNmtKiTdl6HMra25fJLjqis4e3G
	 012bEySYq/LqZAW0bzhvnAzKER8ChQYPQxguAvDh/tO2AO8gvXCN5Fm679clROiz/R
	 +WNUOW2f1rv4CwC0kX9dUXxuN85Rhf4Oe+zeEAgNTkyn99HhFG7ar/Su8gTp3jZ50I
	 Xz5AuNXxI6QivGNxKwVIhy3kb+Sn/qk9qC9kFu8kvw3WQtESq2OJT7vcEHBFELuYyS
	 H3ra0rA1C+1Kw==
Content-Type: multipart/mixed; boundary="===============2864074215489784785=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58@mail.kernel.org>
In-Reply-To: <20260527113951.46265-11-jolsa@kernel.org>
References: <20260527113951.46265-11-jolsa@kernel.org>
Subject: Re: [PATCHv6 bpf-next 10/29] bpf: Add multi tracing attach types
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 12:59:43 +0000 (UTC)

--===============2864074215489784785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 435ae6efe961..27ad0c265c95 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -41,6 +41,7 @@
>  #include <linux/overflow.h>
>  #include <linux/cookie.h>
>  #include <linux/verification.h>
> +#include <linux/btf_ids.h>
>
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <net/netkit.h>

[ ... ]

> @@ -2904,6 +2914,11 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
>  	return 0;
>  }
>
> +extern int bpf_multi_func(void);
> +int __init __used bpf_multi_func(void) { return 0; }

The signature change from v5 to v6 creates a potential issue. In v5,
bpf_multi_func had 6 arguments (matching the initial verifier setup):

  int __init __used bpf_multi_func(u64 r1, u64 r2, u64 r3,
                                   u64 r4, u64 r5, u64 r6)

Now it has no arguments. The Sashiko AI review in v5 identified that
context array bounds checking could fail when bpf_multi_func's argument
count doesn't match the attached function's argument count, and the
author acknowledged the need to disable direct context access.

Since the initial verification happens against bpf_multi_func (which now
has 0 arguments), but the verifier previously allowed direct ctx[0-5]
accesses based on the 6-argument version, is there still a path where
direct context accesses could be allowed? If so, would accessing ctx[0]
on a function with 0 arguments lead to out-of-bounds kernel stack reads?

The earlier review suggested either:
  (a) explicitly disabling direct memory accesses to the ctx array for
      FENTRY_MULTI and FEXIT_MULTI, or
  (b) enforcing the use of bounds-checked helpers like bpf_get_func_arg()

Was this implemented somewhere in the patch series?

> +
> +BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd709..58450cb88beb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18837,6 +18839,11 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
>
>  #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
>
> +static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
> +{
> +	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
> +}
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,

[ ... ]

> @@ -19094,7 +19105,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		if (ret < 0)
>  			return ret;
>
> -		if (tgt_prog) {
> +		/*
> +		 * *.multi programs don't need an address during program
> +		 * verification, we just take the module ref if needed.
> +		 */
> +		if (is_tracing_multi_id(prog, btf_id)) {
> +			if (btf_is_module(btf)) {
> +				mod = btf_try_get_module(btf);
> +				if (!mod)
> +					return -ENOENT;
> +			}
> +			addr = 0;
> +		} else if (tgt_prog) {
>  			if (subprog == 0)
>  				addr = (long) tgt_prog->bpf_func;
>  			else

[ ... ]

> @@ -19122,6 +19144,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			ret = -EINVAL;
>  			switch (prog->type) {
>  			case BPF_PROG_TYPE_TRACING:
> +				/* *.multi sleepable programs will pass initial sleepable check,
> +				 * the actual attached btf ids are checked later during the link
> +				 * attachment.
> +				 */
> +				if (is_tracing_multi_id(prog, btf_id))
> +					ret = 0;
>  				if (!check_attach_sleepable(btf_id, addr, tname))
>  					ret = 0;

The multi types are not included in btf_validate_prog_ctx_type() in
kernel/bpf/btf.c. That function validates which attach types allow u64*
as their ctx parameter:

kernel/bpf/btf.c:btf_validate_prog_ctx_type() {
    case BPF_TRACE_FENTRY:
    case BPF_TRACE_FEXIT:
    case BPF_MODIFY_RETURN:
        ...
}

Since BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI also use u64*
context, do they need to be added to that validation list? Or if direct
context access should be disabled for multi types (per the earlier
review concern), should they be handled with special rejection logic?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26509800686
--===============2864074215489784785==--

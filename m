Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D33A4524
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763058; cv=none; b=D+3oEwpbsL7hKUY4L53SCJrzhZbwbBF2y42DzemWhyu1gIP3QN3H0IWnVLaUzY90qSS4pXPKEEQpAkmxcfKnxrV/lIb32sT/lOFnDsR8R8iFWnfplFuOz5Pr93jutdjDR3gUGDZW4BE+iNRN6xY2tXPW6ci5u410ASBbbgbAKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763058; c=relaxed/simple;
	bh=KrWV4rnZkO7L2PItPSnQ0G4AKlTqIKD3M9c4EigwkPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLLr266lkYaQ02E1f2YyKaCvZb6yqDAaC3RvoCSNXFeEq9AbiUA0E2em7czEItOdLovGRv7ztbpXIaaHddVlIs6FzTImlUA+hYsMjhnS7rw18Aqzk+4L/g2OYuf8nnCUvptBNNZglcV9yn4Fxs+e9sYlz0n7zcyDw+xnWDAJ8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRjf1djp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRjf1djp"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba9ad0fbc3aso58986666b.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776763054; x=1777367854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBxzEfJvKX9hLQrnYOFYwsK+6ogO43PAjy1oaRp/RjI=;
        b=PRjf1djpW+BMBrk/xYKgxNVZl0nqDFUctzKCOAXDF1AZ/6viUfRFIbRsPCi6Mc+y4B
         zR8rXbvmSNaOwzDtUbJ584kpqwfv2iq3O1YEsfu8nTCxHY8IKxCv51SePiOpKzMupoWq
         q+sZXDpGRXj2t8GlOweqaHYjByxtBakDrHeWsMt6Xgp/A3lE+jsE/CCvqv8XgOMPf46k
         hYne7gXJduYBg53yHW1gIY/SCG2kSVNHCGFDmV1bjigF4roIU8XNu46loFj4dLZKpVjG
         Pue2OhEosex4zMfAbqXU1Fr4AAok7gqU+fUNnEE2LaUirhOXSvp0HAzhNCn1UyRjbZ8y
         F7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763054; x=1777367854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBxzEfJvKX9hLQrnYOFYwsK+6ogO43PAjy1oaRp/RjI=;
        b=iRxSekQjBpO0I3D3KGkHps6nMzLJAXUl4gUC0zZItkEChWPWiOOGBzAiUkwSTgkHQK
         eMTq1VU6USKaYR8tGkmMC+rWjIIUuSJrANU8PXCJByFHscDa93Cinb+Rdsxew3hBTkpk
         lFFjcIImIelpTWQtjOJIX38T17fCKhDIU5rEdM01pUZekK71tloYI1W5oVi4+/vUD4tj
         jbjNBFYKU6TPu1NYSfufxu//58Lu56NLsJxQxsNzha0qThGT+QwpmE9NFMY8ZbPvnGVP
         jeyAloepBm3MPQFWYva81/jQ/UazsYePhjn9lZhcuOuR8aVz5HVKEuIVs5X49cMEKlk+
         6ldA==
X-Forwarded-Encrypted: i=1; AFNElJ+I+T4iDpjXYmuyzKnpXejZHQziZB5e/MDJ41iZJw2+cSL8sl0e/l556Cpqowm1BOdn4v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eFFsKGHMb7eVrIx0lBrezQdbzon5oip1Z6BNn8jFr1kBIYIk
	7qEqmykqyL0rx8MAFFPigOgD7rYDIREPiCXN0BRrhT961F6t081bQL/VVntiKlrwsg==
X-Gm-Gg: AeBDiesAMbVZbnlCEH9cpNqzTyhu2/VRyI9Kajm0dpAThox6aI5D//GBDi3tXs6RS2P
	5Zqyaq/n2wIUS5zcILQTn4+4PEUKljkUH5ihR+KoW11Va7nIr3zsoSEIdGroo36wMG48y3ocfsr
	GnyudDa29BgOhKUDsOXVcd01EubP3NZg8z91b2n/tRW0b9i7Q2ya/MMMgAjQjjZgF6VW6ZBknhy
	n7vJgS9YQLkYuKKWLXBUDxa1tyL58RhkLj4ZVEqvgjLKAaM6GdUU6uW4099tARQAsKh8LUZpLRf
	vgXVm/C3cl1DXcp7NmuloEHxMzHfKPJuOyyxeesgRFRXcz1PG01c/rHetEe9/4bFAFiZkZtsdUP
	kBk5cPd3XfMgV0ZpCbllt+pQltBiURB0/mFv8nQjRzjxUMQtB+YpOT0gneWLWzJXejq8COahCYp
	nUtdyAnc7bj7FZ+0fDkA32a1HCRsPwgZVML2FeUsH279y/jRyQkqUjxxdHZwqJ6iYfGh8+iV9T4
	074igxmMO3x6rTssbu+pOM=
X-Received: by 2002:a17:907:6d17:b0:ba8:a829:e649 with SMTP id a640c23a62f3a-ba8a82a9b9fmr290366166b.30.1776763053577;
        Tue, 21 Apr 2026 02:17:33 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4517ec776sm436161866b.16.2026.04.21.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:17:33 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:17:29 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: 2022090917019@std.uestc.edu.cn, M202472210@hust.edu.cn,
	bpf@vger.kernel.org, daniel@iogearbox.net, dddddd@hust.edu.cn,
	dzm91@hust.edu.cn, edumazet@google.com,
	hust-os-kernel-patches@googlegroups.com, jiayuan.chen@linux.dev
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
Message-ID: <aedAqdeuVqLq4hDQ@google.com>
References: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>
 <20260421084806.1785541-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421084806.1785541-1-kuniyu@google.com>

On Tue, Apr 21, 2026 at 08:47:31AM +0000, Kuniyuki Iwashima wrote:
> From: Quan Sun <2022090917019@std.uestc.edu.cn>
> Date: Tue, 21 Apr 2026 14:32:35 +0800
> > Our fuzzing found an Uninitialized Stack Variable vulnerability in the 
> > Linux Socket Subsystem. The issue is triggered when a 
> > `BPF_PROG_TYPE_LSM` attached to the `bpf_lsm_socket_create` cgroup hook 
> > uses the `bpf_set_retval()` helper to return a value greater than 0 
> > (e.g., `1`). This bypasses the actual `socket_create` execution but 
> > returns a success status back to `__sys_socket_create`, which then 
> > accesses the uninitialized stack variable `sock` leading to a NULL 
> > pointer dereference or potential privilege escalation.
> > 
> > Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > 
> > ## Root Cause
> > 
> > This vulnerability is caused by treating a manipulated return value from 
> > an LSM hook as complete success in `__sys_socket_create` without 
> > ensuring that the underlying object has been fully initialized.
> > 
> > 1. `__sys_socket_create()` in `net/socket.c` reserves a pointer variable 
> > `struct socket *sock;` on the kernel stack without zero-initializing it.
> > 2. It calls `sock_create(family, type, protocol, &sock);` to allocate 
> > and initialize the socket object.
> > 3. `sock_create` proceeds to allocate the socket internally and invokes 
> > the `security_socket_create` LSM hook (which triggers 
> > `bpf_lsm_socket_create`).
> > 4. If a BPF program is attached to the cgroup LSM hook for 
> > `bpf_lsm_socket_create`, it can call `bpf_set_retval(1)` and return `1`.
> > 5. Because the BPF hook completes without an error code (< 0), 
> > `sock_create` interprets this bypass as success and promptly returns `1` 
> > (or a positive bypass value) back to `__sys_socket_create()`. However, 
> > the critical variable `sock` is never populated.
> > 6. The caller `__sys_socket_create()` checks if `sock_create()`'s return 
> > value is `< 0`. Since `1` is not less than `0`, it assumes the `sock` 
> > pointer is valid.
> > 7. Subsequent socket operations inside `__sys_socket_create()`, such as 
> > `sock_map_fd(sock, ...)`, attempt to dereference the uninitialized 
> > `sock` stack pointer.
> > 
> > #### Execution Flow Visualization
> > 
> > ```text
> > Vulnerability Execution Flow
> > |
> > |--- 1. `__sys_socket_create(...)`
> > |    |\
> > |    | `-- struct socket *sock; (Uninitialized pointer on stack)
> > |    |
> > |--- 2. `sock_create(...)` -> `security_socket_create(...)`
> > |    |\
> > |    | `-- BPF LSM CGROUP hook for `bpf_lsm_socket_create` triggered.
> > |    |     |
> > |    |     `-- bpf_set_retval(1); return 1;
> > |    |
> > |--- 3. Context switches back to `sock_create`
> > |    |\
> > |    | `-- LSM hook returns `1`. `sock_create` skips allocation and 
> > returns `1`.
> > |    |
> > |--- 4. Context switches back to `__sys_socket_create`
> > |    |\
> > |    | `-- Check return value (1 < 0 is False). Treated as SUCCESS.
> > |    |     |
> > |    |     `-- `sock_map_fd(sock, ...)`
> > |    |         |
> > |    |         `-- Dereferences `sock` leading to KERNEL PANIC or Hijack.
> > ```
> > 
> > ## Reproduction Steps
> > 
> > 1. Load a `BPF_PROG_TYPE_LSM` BPF program that:
> >     - Sets the target BTF ID to `bpf_lsm_socket_create`.
> >     - Calls the `bpf_set_retval(1)` helper inside the hook.
> > 2. Attach the loaded program to a chosen cgroup directory using 
> > `BPF_LSM_CGROUP`.
> > 3. Add the current process to the targeted cgroup.
> > 4. Trigger the creation of a socket by invoking the `socket(AF_INET, 
> > SOCK_STREAM, 0)` system call from within the cgroup.
> > 5. The `sock_create` function skips allocation, returns 1, and 
> > `__sys_socket_create` dereferences the uninitialized stack pointer.
> 
> Thanks for the report.
> 
> Maybe we could fix like below.
> I guess all (most?) places suppose LSM to return 0 or
> a negative value, and the btf_id_set_contains() check
> would be unnecessary ?
> 
> ---8<---
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index c5c925f00202..c4b9e9d4de92 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -87,6 +87,13 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
>  #endif
>  BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
>  
> +BTF_SET_START(bpf_lsm_negative_set_retval_hooks)
> +#ifdef CONFIG_SECURITY_NETWORK
> +BTF_ID(func, bpf_lsm_socket_create)
> +#endif
> +BTF_SET_END(bpf_lsm_negative_set_retval_hooks)
> +
> +
>  #ifdef CONFIG_CGROUP_BPF
>  void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  			     bpf_func_t *bpf_func)
> @@ -221,12 +228,37 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  };
>  
> +BPF_CALL_1(bpf_lsm_set_retval, int, retval)
> +{
> +	struct bpf_cg_run_ctx *ctx;
> +
> +	if (retval > 0)
> +		return -EINVAL;
> +
> +	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> +	ctx->retval = retval;
> +
> +	return 0;
> +}
> +
> +const struct bpf_func_proto bpf_lsm_set_retval_proto = {
> +	.func		= bpf_lsm_set_retval,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_ANYTHING,
> +};
> +
>  static const struct bpf_func_proto *
>  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
>  	const struct bpf_func_proto *func_proto;
>  
>  	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
> +		if (func_id == BPF_FUNC_set_retval &&
> +		    btf_id_set_contains(&bpf_lsm_negative_set_retval_hooks,
> +					prog->aux->attach_btf_id))
> +			return &bpf_lsm_set_retval_proto;
> +
>  		func_proto = cgroup_common_func_proto(func_id, prog);
>  		if (func_proto)
>  			return func_proto;

Sorry, I missed this response. I was probably typing out my response
(https://lore.kernel.org/bpf/aec6Q1g2K8vP_jck@google.com/) whilst this
had already come through.

I guess this is kinda on the right path and how I'd probably go about
fixing part of the underlying issue. My slight concern/reservation is
that it's highly BPF LSM specific as it's focused only on preventing
the BPF LSM from violating the expected semantics of the LSM hook.

The other immediate issue here which I think also needs to be
addressed is that __sys_socket_create() operates on an uninitialized
pointer and assumes that any non-negative return value from
sock_create() means that the pointer is valid. I'd probably also
propose making __sys_socket_create() a little more fail-safe by
initializing sock to NULL and explicitly checking both the return code
and the poitner validity post calling into sock_create(). This makes
the caller robust against any failure of sock_create() to fulfill its
implied contract (initializing the sock pointer on success),
regardless of whether that failure was caused by BPF, some other LSM,
or a bug in a protocols family's ->create() function.

What do you think?

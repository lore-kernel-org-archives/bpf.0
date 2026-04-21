Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86322BDC0E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765755; cv=none; b=p04zqxwUrCc5Fweit8xyUGrOT3DrQMD/dKJusRScjVkzp2FALxNoYT92c0ohfwWSltuh38h47Gx9IE4CXBTQXMVL8yC3qcHzWZf0CsLDMF6s6+grLZmGDV+SF0StV/fiNSskdvYowpOUtluKED/LdLTZGLYhqJZa3iWuCIOT1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765755; c=relaxed/simple;
	bh=eun/gVfOzLClPhE7LxVfD0P+cYzMjVlmXjvoM+0vPRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ngu40LDvX27V7XW4YvsDUalQCioNvdlgC0/d+rwbJ157OmvHfhkvb6tPnI4UqBsA1bw5dudnJLpox5XVAVr9guBc/kCIrMCK6HwUnLqUc+gMKZOL28FOWKydSMQRtBHBwhVzy/yyfABrf+hYvIdoM8HqKsbf/2hUknXQv55eRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZNqlgqU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZNqlgqU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f8bbb4045so2569138b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776765753; x=1777370553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E57bHCW0v6ClglZFowsqeZFsrXHaem9bg2FEeYcuNNI=;
        b=gZNqlgqUnLws+58x7YDihewjdzwqPUTI0vu8tDPfpQN5M4cL+Q/W1ypILur66ji+l/
         zAAH03G7dPFkrNYb2NP9S8OVqyxNQK2cQ3rs8L1qVqNkV97CCTvsdGc1LVreroEtmYHA
         a2LWqjsMqsPzHkalAirVhq+q/V7OFNlV62oSeApd0bu+IpvN0XpFgYEjIvtghVzuNKaM
         k41enwN5yxJNDzg2J8bZMHx7sR+AjbESQWRg0GAtIaLNqwpH8hquPK3XYwKE25NYRu37
         KCedCTY7SPDdZgDK81R0A69WmyvfRb1i90hUydd89fAnyLMCdAwxhb6+2QHZNpQXazU8
         o1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765753; x=1777370553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E57bHCW0v6ClglZFowsqeZFsrXHaem9bg2FEeYcuNNI=;
        b=G4mB4k6AXVWz80Vfd/p7wxqdzDLKB+qzikXM9feKIJ8pf1vKpsUVOCNfcM5NntIwO8
         FpbgOxFQ+582Qn0Qtt6XkqB37g2MivwhkZSQdxYh2z6qmbE39xFTQdMyTo8cFCHdqSqK
         PWng6JdTKTT+indoPxMGpKO0yHK7b66vm6TMeh/IoKyNlbhkEIwMxSg13n5skYXpRt1i
         3CkY9BzIqzcB+E+uUr0bIXHQjrNTjTj4yDGpI+v+cRm1wi7hQ+xlKqSOlAs9eSKywf/N
         WOLEwoN1e8Elb+/gH1oFcwF+XCrKbHycqpl9Y3jnKlChP2jNSATci80PH0ZSVHvGJ5Oh
         Blpg==
X-Forwarded-Encrypted: i=1; AFNElJ8Kh5LjF7KigfuDDS8DcsGUICjjCSZf87P+xD2rZVhUcsTgcoRa8CQp/yQbiruZkpZe384=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqM2LSLMkCmOYc7H1Q3YGdQCUTwLotsKPaHR004XGJJ29D8CRe
	RElxMFt/E403DU36nQ7mCk79ltTc/jz+CsiEXub6D0V5HCBy9eE/qaD3hOsK04YLMjT20roOFfF
	lKR3r+A==
X-Received: from pfnz21.prod.google.com ([2002:aa7:85d5:0:b0:82f:aed1:37c5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:908e:b0:82c:6da7:2d3d
 with SMTP id d2e1a72fcca58-82f8c870c7emr17068162b3a.11.1776765752831; Tue, 21
 Apr 2026 03:02:32 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:59:12 +0000
In-Reply-To: <aedAqdeuVqLq4hDQ@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aedAqdeuVqLq4hDQ@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421100231.1834988-1-kuniyu@google.com>
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
From: Kuniyuki Iwashima <kuniyu@google.com>
To: mattbobrowski@google.com
Cc: 2022090917019@std.uestc.edu.cn, M202472210@hust.edu.cn, 
	bpf@vger.kernel.org, daniel@iogearbox.net, dddddd@hust.edu.cn, 
	dzm91@hust.edu.cn, edumazet@google.com, 
	hust-os-kernel-patches@googlegroups.com, jiayuan.chen@linux.dev, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Matt Bobrowski <mattbobrowski@google.com>
Date: Tue, 21 Apr 2026 09:17:29 +0000
> On Tue, Apr 21, 2026 at 08:47:31AM +0000, Kuniyuki Iwashima wrote:
> > From: Quan Sun <2022090917019@std.uestc.edu.cn>
> > Date: Tue, 21 Apr 2026 14:32:35 +0800
> > > Our fuzzing found an Uninitialized Stack Variable vulnerability in the 
> > > Linux Socket Subsystem. The issue is triggered when a 
> > > `BPF_PROG_TYPE_LSM` attached to the `bpf_lsm_socket_create` cgroup hook 
> > > uses the `bpf_set_retval()` helper to return a value greater than 0 
> > > (e.g., `1`). This bypasses the actual `socket_create` execution but 
> > > returns a success status back to `__sys_socket_create`, which then 
> > > accesses the uninitialized stack variable `sock` leading to a NULL 
> > > pointer dereference or potential privilege escalation.
> > > 
> > > Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > > 
> > > ## Root Cause
> > > 
> > > This vulnerability is caused by treating a manipulated return value from 
> > > an LSM hook as complete success in `__sys_socket_create` without 
> > > ensuring that the underlying object has been fully initialized.
> > > 
> > > 1. `__sys_socket_create()` in `net/socket.c` reserves a pointer variable 
> > > `struct socket *sock;` on the kernel stack without zero-initializing it.
> > > 2. It calls `sock_create(family, type, protocol, &sock);` to allocate 
> > > and initialize the socket object.
> > > 3. `sock_create` proceeds to allocate the socket internally and invokes 
> > > the `security_socket_create` LSM hook (which triggers 
> > > `bpf_lsm_socket_create`).
> > > 4. If a BPF program is attached to the cgroup LSM hook for 
> > > `bpf_lsm_socket_create`, it can call `bpf_set_retval(1)` and return `1`.
> > > 5. Because the BPF hook completes without an error code (< 0), 
> > > `sock_create` interprets this bypass as success and promptly returns `1` 
> > > (or a positive bypass value) back to `__sys_socket_create()`. However, 
> > > the critical variable `sock` is never populated.
> > > 6. The caller `__sys_socket_create()` checks if `sock_create()`'s return 
> > > value is `< 0`. Since `1` is not less than `0`, it assumes the `sock` 
> > > pointer is valid.
> > > 7. Subsequent socket operations inside `__sys_socket_create()`, such as 
> > > `sock_map_fd(sock, ...)`, attempt to dereference the uninitialized 
> > > `sock` stack pointer.
> > > 
> > > #### Execution Flow Visualization
> > > 
> > > ```text
> > > Vulnerability Execution Flow
> > > |
> > > |--- 1. `__sys_socket_create(...)`
> > > |    |\
> > > |    | `-- struct socket *sock; (Uninitialized pointer on stack)
> > > |    |
> > > |--- 2. `sock_create(...)` -> `security_socket_create(...)`
> > > |    |\
> > > |    | `-- BPF LSM CGROUP hook for `bpf_lsm_socket_create` triggered.
> > > |    |     |
> > > |    |     `-- bpf_set_retval(1); return 1;
> > > |    |
> > > |--- 3. Context switches back to `sock_create`
> > > |    |\
> > > |    | `-- LSM hook returns `1`. `sock_create` skips allocation and 
> > > returns `1`.
> > > |    |
> > > |--- 4. Context switches back to `__sys_socket_create`
> > > |    |\
> > > |    | `-- Check return value (1 < 0 is False). Treated as SUCCESS.
> > > |    |     |
> > > |    |     `-- `sock_map_fd(sock, ...)`
> > > |    |         |
> > > |    |         `-- Dereferences `sock` leading to KERNEL PANIC or Hijack.
> > > ```
> > > 
> > > ## Reproduction Steps
> > > 
> > > 1. Load a `BPF_PROG_TYPE_LSM` BPF program that:
> > >     - Sets the target BTF ID to `bpf_lsm_socket_create`.
> > >     - Calls the `bpf_set_retval(1)` helper inside the hook.
> > > 2. Attach the loaded program to a chosen cgroup directory using 
> > > `BPF_LSM_CGROUP`.
> > > 3. Add the current process to the targeted cgroup.
> > > 4. Trigger the creation of a socket by invoking the `socket(AF_INET, 
> > > SOCK_STREAM, 0)` system call from within the cgroup.
> > > 5. The `sock_create` function skips allocation, returns 1, and 
> > > `__sys_socket_create` dereferences the uninitialized stack pointer.
> > 
> > Thanks for the report.
> > 
> > Maybe we could fix like below.
> > I guess all (most?) places suppose LSM to return 0 or
> > a negative value, and the btf_id_set_contains() check
> > would be unnecessary ?
> > 
> > ---8<---
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index c5c925f00202..c4b9e9d4de92 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -87,6 +87,13 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
> >  #endif
> >  BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
> >  
> > +BTF_SET_START(bpf_lsm_negative_set_retval_hooks)
> > +#ifdef CONFIG_SECURITY_NETWORK
> > +BTF_ID(func, bpf_lsm_socket_create)
> > +#endif
> > +BTF_SET_END(bpf_lsm_negative_set_retval_hooks)
> > +
> > +
> >  #ifdef CONFIG_CGROUP_BPF
> >  void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
> >  			     bpf_func_t *bpf_func)
> > @@ -221,12 +228,37 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
> >  	.arg1_type	= ARG_PTR_TO_CTX,
> >  };
> >  
> > +BPF_CALL_1(bpf_lsm_set_retval, int, retval)
> > +{
> > +	struct bpf_cg_run_ctx *ctx;
> > +
> > +	if (retval > 0)
> > +		return -EINVAL;
> > +
> > +	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> > +	ctx->retval = retval;
> > +
> > +	return 0;
> > +}
> > +
> > +const struct bpf_func_proto bpf_lsm_set_retval_proto = {
> > +	.func		= bpf_lsm_set_retval,
> > +	.gpl_only	= false,
> > +	.ret_type	= RET_INTEGER,
> > +	.arg1_type	= ARG_ANYTHING,
> > +};
> > +
> >  static const struct bpf_func_proto *
> >  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> >  	const struct bpf_func_proto *func_proto;
> >  
> >  	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
> > +		if (func_id == BPF_FUNC_set_retval &&
> > +		    btf_id_set_contains(&bpf_lsm_negative_set_retval_hooks,
> > +					prog->aux->attach_btf_id))
> > +			return &bpf_lsm_set_retval_proto;
> > +
> >  		func_proto = cgroup_common_func_proto(func_id, prog);
> >  		if (func_proto)
> >  			return func_proto;
> 
> Sorry, I missed this response. I was probably typing out my response
> (https://lore.kernel.org/bpf/aec6Q1g2K8vP_jck@google.com/) whilst this
> had already come through.
> 
> I guess this is kinda on the right path and how I'd probably go about
> fixing part of the underlying issue. My slight concern/reservation is
> that it's highly BPF LSM specific as it's focused only on preventing
> the BPF LSM from violating the expected semantics of the LSM hook.
> 
> The other immediate issue here which I think also needs to be
> addressed is that __sys_socket_create() operates on an uninitialized
> pointer and assumes that any non-negative return value from
> sock_create() means that the pointer is valid. I'd probably also
> propose making __sys_socket_create() a little more fail-safe by
> initializing sock to NULL and explicitly checking both the return code
> and the poitner validity post calling into sock_create(). This makes
> the caller robust against any failure of sock_create() to fulfill its
> implied contract (initializing the sock pointer on success),
> regardless of whether that failure was caused by BPF, some other LSM,
> or a bug in a protocols family's ->create() function.
> 
> What do you think?

I think the issue here is that __sock_create() handles
a positive retval as error only for two LSM hooks,
security_socket_create() and security_socket_post_create(),
which is different from __sys_socket_create()'s expectation.

sock_create()(_kern()) callers are supposed to check the retval
first before accessing the passed &sock pointer, so I don't
think leaving it uninitialised itself is a problem and I'd
rather ignore >0 value as allowed.

And I found a good place in verifier to reject the repro.

---8<---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e4980128151..19cc4ed8c389 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10448,6 +10448,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
 				return -EINVAL;
 			}
+
+			if (regs[BPF_REG_1].s32_max_value > 0) {
+				verbose(env, "BPF_LSM_CGROUP can't return a positive value!\n");
+				return -EINVAL;
+			}
 		}
 		break;
 	case BPF_FUNC_dynptr_data:
diff --git a/net/socket.c b/net/socket.c
index 22a412fdec07..d40aea527f66 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1617,7 +1617,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	}
 
 	err = security_socket_create(family, type, protocol, kern);
-	if (err)
+	if (err < 0)
 		return err;
 
 	/*
@@ -1685,7 +1685,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	 */
 	module_put(pf->owner);
 	err = security_socket_post_create(sock, family, type, protocol, kern);
-	if (err)
+	if (err < 0)
 		goto out_sock_release;
 	*res = sock;
 
---8<---


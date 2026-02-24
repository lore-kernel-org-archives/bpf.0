Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C83A0EB1
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940120; cv=none; b=WUgDG3Ehc42nAGtzFTzB4E3DDjJ/A9KOxNDZJUp/wCAf00NZ9unFfJbtgPri4qs2BMtHXr0N/K6Y6OcWcPGl8qhNwwBlke5exzzk2UCEOyO4RzBxzRlKVFYuUZx6Mks5YhcTJuHyHtUKCV9XZvwsg83FJMKYBqpitmQWqhSD1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940120; c=relaxed/simple;
	bh=qhbJpmZITKjbEAcPdtlGm6W8/Qffyxn/CjLw4UREa1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlZMM67aDf9vVkF212ejfqyPbGu+42Yuiq5lKly/sir2oDmFQIe8+tCf2FtdjoRZuogR6ztokZLVCgK0paKc8QpPTC60XzgJT+Ib6OoylNm7v74kc9gEvpcKBa8GvjeIzwOiI0aVfQplwz8KW4YeEo1CAkeunRrcX0yjVn8r6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTmOl1Wg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTmOl1Wg"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so539644a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 05:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771940116; x=1772544916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=017Au0WagCuxotQHTbuPbnn7OOhD26VlW9T9YwI+bmw=;
        b=TTmOl1WgO9ipDMNDDj3wD89bpFoluL+wCTIJLb4MqoavlpDQ7xDtodnvIGGDqUtyoV
         4RuHCPw2s1t1N3q7xh+MDGSRsMf2rHME6KoikPe0TAyvLoQ2PpIpze0jjE2xrJ1zLSxg
         lSiEZ0xAr3QCnDNChTXHZBsW60fDZ+7HIvIN19yVqKesbgtur9ChCDTEh/FEi/Wunz1D
         eSRz7a9cqDMe9Z2lGY1nPkhl0rL0NUbLZXbw3DCCismTWLKcz4H0yL6aFBSVNFViPnFZ
         dU5OygsDP70fjKg+dUuf9sLk/Cfc7KSLLOTxK/nT29jkbd8Yg0GgNshE+3zb3RZMh5Vs
         2RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940116; x=1772544916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=017Au0WagCuxotQHTbuPbnn7OOhD26VlW9T9YwI+bmw=;
        b=u1ocOq3HPnGDM92YWfLc1NIZM26tDnodd6HcOnMKuspbITkkcOSDbbEnpZzo2Y+Ivh
         T6XKKfgoIeLI2Wz4xYsflGLJ10Pj3Y8pbiz7sgzhhAPNRHjryvc4VF4DjYYy6wMZ/7o0
         SDvqt4rI56Fgi2cpDgk+zXRaYTLIfxSvgCipl57sdsieau1TEJzRt/+BklKbxmUj1o+/
         1TvuRu0EGvj+HIkQEoOmidwdDofwkucmf6b5hlHHK4H+40YAksAVogsqEDjCNtYGjjBp
         nXxy9d+c5bXzomdz3IXNDQUUfKTJJXFyyMiO4qMCUR2eIB213moCvblfXGjJmc14wOpj
         dDtA==
X-Forwarded-Encrypted: i=1; AJvYcCVuKQFE4ft+V1Onddto1SmHwHesE50HXOODk6EgCkfU2TLaaqO7XIeV8rFWaXBksKZdUpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuozmGnl79E9gLbt/cimf2xhLV7e/fGatdyYlPNfKOeus1VRMC
	bPWakXkuZxXDNmSGdGpsl5hzvGRpvGIUOgio2xEwxMe4LvQm3b51jS08VgXZ/cpnzg==
X-Gm-Gg: AZuq6aJjtNR5c4hiPhwjx1Pv7MRh42z7ADtEMtXNuQrWrVOU4AMCHqei3exECCsoFGy
	wT/mcA9XxgsJDZPvZMGA/l4qJYTUo24e1FUyTmpUNGdAaHLveHbjxWE69+ORfw2EoYJOXTtYyyV
	UlrxW4r8np1rGWDSc5g9w6bVg1RlA/CbxXNQBn6F5v3/RqyDvZ9hLNNT98A+ALzllGSiXhEq/aT
	3vXeghOxGqi7D7DjWaSIenMxkLuc4YkggxT77GldyraMIxapI7sripFMLzuefxGuSnGGgxTOF1K
	xdJbcDxrdH7aIqhvBBQ5OarLEiw8su+8EdPwIChJhb0ILApbIBCSn7S23nPJ1H71sERD8DZc7uE
	DQSGr7n6qbqogamFIXhlLJvcULd9J44rRNeNjAqPu9tflOyh/Ki6syN2yW14KUOpHevo0Es1eFm
	/vPYSN6R6+jDIj9f6CMJIRe+Q4mYy3IaNwog6GYnI257Kon7Z0dSgFC8kcxWjuTEM=
X-Received: by 2002:a17:906:eec7:b0:b87:117f:b6f0 with SMTP id a640c23a62f3a-b9081b23d01mr691501366b.30.1771940115631;
        Tue, 24 Feb 2026 05:35:15 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084a4d6e1sm426835366b.0.2026.02.24.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:35:15 -0800 (PST)
Date: Tue, 24 Feb 2026 13:35:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>,
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <aZ2pDzhDFpFMjgb1@google.com>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>

On Fri, Feb 20, 2026 at 01:38:29AM +0100, Christian Brauner wrote:
> Add the three namespace lifecycle hooks and make them available to bpf
> lsm program types. This allows bpf to supervise namespace creation. I'm
> in the process of adding various "universal truth" bpf programs to
> systemd that will make use of this. This e.g., allows to lock in a
> program into a given set of namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
>  kernel/nscommon.c       |  9 ++++++++-
>  kernel/nsproxy.c        |  7 +++++++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..5ae438fdf567 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -12,6 +12,9 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/lsm_hooks.h>
>  
> +struct ns_common;
> +struct nsset;
> +
>  #ifdef CONFIG_BPF_LSM
>  
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>  
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  			     struct bpf_retval_range *range);
> +
> +int bpf_lsm_namespace_alloc(struct ns_common *ns);
> +void bpf_lsm_namespace_free(struct ns_common *ns);
> +int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
> +
>  int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  				const struct bpf_dynptr *value_p, int flags);
>  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> @@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
>  {
>  	return false;
>  }
> +
> +static inline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> +{
> +	return 0;
> +}
> +static inline void bpf_lsm_namespace_free(struct ns_common *ns)
> +{
> +}
> +static inline int bpf_lsm_namespace_install(struct nsset *nsset,
> +					    struct ns_common *ns)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 0c4a0c8e6f70..f6378db46220 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>  
> +__bpf_hook_start();
> +
> +__weak noinline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +__weak noinline void bpf_lsm_namespace_free(struct ns_common *ns)
> +{
> +}

I'm wondering how you foresee this hook functioning in a scenario
where the BPF LSM program is attached to this new hook point, although
with its attachment type being set to BPF_LSM_CGROUP instead of
BPF_LSM_MAC? You probably wouldn't want to utilize something like
BPF_LSM_CGROUP for your specific use case, but as things stand
currently I don't believe there's anyhthing preventing you from using
BPF_LSM_CGROUP with a hook like bpf_lsm_namespace_free().

Notably, the BPF_LSM_CGROUP infrastructure is designed to execute BPF
programs based on the cgroup of the currently executing task. There
could be some surprises if the bpf_lsm_namespace_free() hook were to
ever be called from a context (e.g, kworker) other than the one
specified whilst attaching the BPF LSM program with type
BPF_LSM_CGROUP.

> +__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
> +					  struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +__bpf_hook_end();
> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
>  BTF_SET_START(bpf_lsm_hooks)
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
> +BTF_ID(func, bpf_lsm_namespace_alloc)
> +BTF_ID(func, bpf_lsm_namespace_free)
> +BTF_ID(func, bpf_lsm_namespace_install)
>  BTF_SET_END(bpf_lsm_hooks)
>  
>  BTF_SET_START(bpf_lsm_disabled_hooks)
> @@ -383,6 +405,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
>  BTF_ID(func, bpf_lsm_task_setscheduler)
>  BTF_ID(func, bpf_lsm_task_to_inode)
>  BTF_ID(func, bpf_lsm_userns_create)
> +BTF_ID(func, bpf_lsm_namespace_alloc)
> +BTF_ID(func, bpf_lsm_namespace_install)
>  BTF_SET_END(sleepable_lsm_hooks)
>  
>  BTF_SET_START(untrusted_lsm_hooks)
> @@ -395,6 +419,7 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
>  BTF_ID(func, bpf_lsm_sk_free_security)
>  #endif /* CONFIG_SECURITY_NETWORK */
>  BTF_ID(func, bpf_lsm_task_free)
> +BTF_ID(func, bpf_lsm_namespace_free)
>  BTF_SET_END(untrusted_lsm_hooks)
>  
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..c3613cab3d41 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
>  
> +#include <linux/bpf_lsm.h>
>  #include <linux/ns_common.h>
>  #include <linux/nstree.h>
>  #include <linux/proc_ns.h>
> @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		ret = proc_alloc_inum(&ns->inum);
>  	if (ret)
>  		return ret;
> +
>  	/*
>  	 * Tree ref starts at 0. It's incremented when namespace enters
>  	 * active use (installed in nsproxy) and decremented when all
> @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		atomic_set(&ns->__ns_ref_active, 1);
>  	else
>  		atomic_set(&ns->__ns_ref_active, 0);
> -	return 0;
> +
> +	ret = bpf_lsm_namespace_alloc(ns);
> +	if (ret && !inum)
> +		proc_free_inum(ns->inum);
> +	return ret;
>  }
>  
>  void __ns_common_free(struct ns_common *ns)
>  {
> +	bpf_lsm_namespace_free(ns);
>  	proc_free_inum(ns->inum);
>  }
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..5742f9664dbb 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -9,6 +9,7 @@
>   *             Pavel Emelianov <xemul@openvz.org>
>   */
>  
> +#include <linux/bpf_lsm.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/nsproxy.h>
> @@ -379,6 +380,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>  
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> +	int ret;
> +
> +	ret = bpf_lsm_namespace_install(nsset, ns);
> +	if (ret)
> +		return ret;
> +
>  	return ns->ops->install(nsset, ns);
>  }
>  
> 
> -- 
> 2.47.3
> 

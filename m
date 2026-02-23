Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCC35BDA7
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842987; cv=none; b=bLaBUVT/D5kJ8IvJuzGO7tzqSO+drfmxn8zSpc9kC41yuWWeOdkVpgPkXNqabuLdNU3JitMSEeWlxuQGJlkVr9JZLgamsaW9Ngm6+TR1vJadSMjXM3TaMUfB1T0PBdg+Ed5ESvFNlblAfzT7TcMBlOl8CDH7Uug+kd+Z+h1ZE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842987; c=relaxed/simple;
	bh=JSLGqiSDjgElRV2goR5pCQttJXW9o2ylgPNe8z4u/P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkcLcTwD6Follc5LSblqu+bJRzQnVZxKYlD+h0OBhJv1ll0L4EDmet/eJUouiDEQZuUjYM01Oa6hkSuNHaXVxw6nHPN9gKm9GMHkzmyCjVFPDxbqh9IqeQU/2gOcfrTjaJtWH5mE4Re27WS0OiQet3BBHmbZcoTboEV7WUNqLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/QeRXVG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/QeRXVG"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65bf302471dso4215007a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771842984; x=1772447784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXAUAzqkpnDd1Jzh6Y9R0674dRENosx/WyoGcsLMZB0=;
        b=o/QeRXVGkLtE7tIxRNXuCMtYfoq02XkANB5WGxk/FdzXyKsxvQwa21XY02qmkhPeMD
         Hx7WCDYvAgK3XJ+l7C+YI/BVtdJzQkr3BVywfNvPE319wymcnFQNRA4lml7RIG8u576x
         nSRV9k2OpXJ52vSKBHoIgC41hTLk5k6wdiTZUPM0lT5m3yj3NhiNY3NH6qeXxjNpj6UC
         fC+pmKYQ48L9MuqSvi+LhaDk+DhI5KU2MSp7rDKent+OGHWjE/w6CpITBP7wwJIJ7LvK
         +wK0mfjFqytr9fm6U8qUgjzOkxFfJJ1Oq4+2KSJv8GnmtDUj7DY1ef3DS/1gWibpgW8D
         6WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771842984; x=1772447784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXAUAzqkpnDd1Jzh6Y9R0674dRENosx/WyoGcsLMZB0=;
        b=o3iwpZ+DvFT7D4i01EfP99poq4IVp2PWBsJu9ig7n2W+/hDWWyWmPHGXn60+gDHP2Q
         Lvv/LBjnfVBynOiZzQURqTGUgKfHezZnM5OGjPyRq1ubMB0qKcBl3hmr/HwC579H+ZzT
         uawd3dS1Y4/2c9YCY8tQaDEK+4kKPvcQ+pizVi6mZy/kYXhy7ocLrgOkD5VUbrfOMoZQ
         a8YmfMZbLSST5FRa7spyS4WJ/4atF9Ovldg9WPRB/cZnTNSzt+1ptNN1JslswMADfyo6
         VtWiV908J6laR8LHVaN2u59eX5GC1pnxbwgD1QHAd1gbNL5QyBR/FtsNmp5wW17G8bsJ
         rqUw==
X-Forwarded-Encrypted: i=1; AJvYcCUMkZ4S2yd38jjFFtMzOJu8ida60GoBGsErNu2W7XI8EX2zAEAH73B/xGLH5vEqBGYIr0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/A1Q6Yj6Shv6zuSuyDP/8YhHEatV0UW6y0hqw9ADcmEXTRdS
	/L9MB3l2XPMdsreczGSD7+fFyyyOLJQkbPUJMWo3+HqZVALDRBIkmwD+rhXc3eOQ5A==
X-Gm-Gg: AZuq6aKkHETRusjW8w4I6mdAgo/j+ikn5kk/G4k7eHd3+G+LE0HgsE9gmDEgvFmd8cO
	IXsAQZxTqGU+gcAdKR8X+zmNcWhzRDCRRFH2tOBQt9Kw1eFTL1+FdHt1sSgXJw4vGTlLnEPaR6j
	sgGFgR8jLKQBefzXUIoYoB52CXuQq28NMIWeStXhBLX1Q62Eiupnp2S2DPVJonlP+SgZDCU5Xy/
	gMnkS7sdbKsMKEoJvkVozkBfPiCFxCdyXXPU0iWUJsUNInzDlyAMR4HCLAnnbJE2z0876VWuDNT
	vGqHIOSZMOqrCYuwlw0ViM+UGoW81/AzITa5zZc8iiNPIf8LvEY7PmEogMBWMWMxlB8KSa8rvcp
	SNLO9AfUrTZu6egM4JKpF2GrGBW6tm3/dcdg9aKuEsyPxy32kXICiB35wfxQyVyZvm8cMfmL7x+
	0dogivA3VcefVIbSonPpC8PL+WkSDtUXdSPTFGUCa6vD5xYLz6scOhbjlF9tBPYHI=
X-Received: by 2002:a17:907:3e83:b0:b7f:f862:df26 with SMTP id a640c23a62f3a-b9081a0251bmr477474066b.14.1771842983799;
        Mon, 23 Feb 2026 02:36:23 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5d47fsm300893566b.11.2026.02.23.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:36:23 -0800 (PST)
Date: Mon, 23 Feb 2026 10:36:19 +0000
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
Message-ID: <aZwto86A08K91w0c@google.com>
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
> +
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

What's the reason for not adding these new hook points to the generic
set of hooks that are currently being exposed directly by the LSM
framework? Honestly, it seems a little odd to be providing
declarations/definitions for a set of new hook points which are to be
exclusively siloed to BPF LSM implementations only. I'd argue that
some other LSM implementations could very well find namespace
lifecycle events possibly interesting.

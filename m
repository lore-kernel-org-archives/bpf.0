Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59151328257
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631722; cv=none; b=TavAs1ioC7hZl0rLUCI41rUVc/Zp/qKKj9FO6g6/t1cZ3feqqdmpGDSPQDQ62eYo86x0DnGN6v8z7IlqBnLjRESbOS++j9ifeLZtsI01LTVROy62lJ9or0G0KKSSFx3+yVhdVn87wKL6udKwfBHUnfpiUJsIrgO3UfWRGDEEmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631722; c=relaxed/simple;
	bh=vSINIHv0wXmSOsXcQbjzgCh5vZoXfWzVsCZuQlEilAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N18JBYc74BtjggiMz79rmSEZ6LZjhOha2oIGcKfZFNnBug7UV1atT7cz5I+c6UHn5soCzt9E+H6am4HVp6EIieMNToRnayH6wbupYAheqjbDTzP8nUon7KdmjoLi/QpacZ3btXGXtpNzmnc9HnhIhrkMrH0fgsV7vwQcLP81MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGPVj7rS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGPVj7rS"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8845cb5862so37842066b.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769631719; x=1770236519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOneaQwgm5r1vQWLDH+rGl4A5aPHuLzm9ueYQTD0ies=;
        b=ZGPVj7rSaaKSOU4KX681gKn2DGrFUSIw59BuY0qTJyxd6ms3U2YzsGeA3PGxVkVqGY
         wJkBio2aDdZKi1+eihg1wgtoMqvmxCGmmR+t1Zd64R9nKol5jeXlsSSkGYOEUlEooUuw
         VYqPclpMtw2wiTcFDWAqicK5n4xvhzrzzKMqWW4k8wy8rEqHKkgAkhL9iXZk0QJ0XH/M
         JPjCmmAV+PfVq/SSdSvSmc9IvJ1P//caw6sfgRE5ENdAK6E7iHjvTc3DAlc3qkek0lY5
         YrFv1AcgyaKziRYEe8RjZL+NFtQ2Xy+bBkZa1VdaRAM+pesj0OWgWhWVwzMFefVNEeJi
         dWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631719; x=1770236519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOneaQwgm5r1vQWLDH+rGl4A5aPHuLzm9ueYQTD0ies=;
        b=bD2RBOUs/63Mdob6rFFQjtI/JDRpwjfVU6bI48EaJVYpGBES+5oG61VaRWPB9b0ffS
         dwUEImHfFUx3SPiuXdqdoGNxxaiZSz2kwFKCz9VaZl+9tOBJfmfcMUQYCmrlCM66Eh9F
         u6xIsT6K/n0o8Cx9jXOD/kZXe6yA9tYctOSdPHRWprBn3UQ5ywblCInzxhm9EKpjHRXc
         RZFK7k5qzfDhYZZevylu6WmkymBbl6F3Irz+qrgkl2JSnSoSblPbtk4iP8aL5BGUezxm
         v0kj7hMJcJLOj0t1qBiQ354YKghIwiG85TnOJGcy/NNOUlJ/eDTmP5aTEwA9oBSrUHqL
         j8dw==
X-Gm-Message-State: AOJu0YxMS1QCTNwbTNFBA2MPq9GVAQAxgdNXpDzsTGezvspvRgiWQ18+
	nGxsfjpZO02B5yRtsPQFxUaXAXa6g80PxmZ8SvFppBtD3aGtwHwDElx8J+ALn4ekug==
X-Gm-Gg: AZuq6aKiGQlEe0t+w0fKI0q7w6ieou41McTzpqT17/uuOxccnXIo6/WGmFxGM9xhFrv
	yYysRToqY4Qp4cxXbBct52yyTy8uRkTRI07AI1vNtZQuZ1wrRxjMCjic1OaQayq78tI39jSl3Xq
	ckW+WpWvxGTipFC5MSifNz1mWbuoz40QZ1bMv7xWU8mAZPU17U9YkbYy0XFfdhKyE2jKYRVKPKq
	oewDD4BHzEaCop6kzVHN43fVcK+jcUTx8y/UkUgzQ9GpHT6lAKHytsC48Rk2Oj9xmhyTDEvOTOd
	iCfThIdo54coYeshVl4bcvDoXJTGcj6Tkp1IhJNS8rlgLK95o1napMA/PvQ2wfKZmD834tQ9K0j
	XanpHRhd16B8FxR6NsTCyVSywizbkGPTXzm9uo003f9AWvyAIcZyvOBFqQEgrDW4N669DHM9ps0
	jDW6TwJM73qp7ft1Yg6xy6i3cb+DcXvC9RNduSatNs07q3wU0I1kCzMbMDf0jlTQ==
X-Received: by 2002:a17:907:7f8c:b0:b86:f558:ecc0 with SMTP id a640c23a62f3a-b8dab1c8bc7mr433016666b.29.1769631718213;
        Wed, 28 Jan 2026 12:21:58 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef86deesm171812666b.3.2026.01.28.12.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:21:57 -0800 (PST)
Date: Wed, 28 Jan 2026 20:21:54 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 09/17] mm: introduce bpf_out_of_memory() BPF
 kfunc
Message-ID: <aXpv4r_3L0UWzAQn@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-10-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-10-roman.gushchin@linux.dev>

On Mon, Jan 26, 2026 at 06:44:12PM -0800, Roman Gushchin wrote:
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
> 
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
> 
> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
> can be declared and handled in the system at once, so if the function
> is called in parallel to another OOM handling, it bails out with -EBUSY.
> This mode is suited for global OOM's: any concurrent OOMs will likely
> do the job and release some memory. In a blocking mode (which is
> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
> 
> The function is declared as sleepable. It guarantees that it won't
> be called from an atomic context. It's required by the OOM handling
> code, which shouldn't be called from a non-blocking context.
> 
> Handling of a memcg OOM almost always requires taking of the
> css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
> also guarantees that it can't be called with acquired css_set_lock,
> so the kernel can't deadlock on it.
> 
> To avoid deadlocks on the oom lock, the function is filtered out for
> bpf oom struct ops programs and all tracing programs.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/oom.h |  5 +++
>  mm/oom_kill.c       | 85 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index c2dce336bcb4..851dba9287b5 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -21,6 +21,11 @@ enum oom_constraint {
>  	CONSTRAINT_MEMCG,
>  };
>  
> +enum bpf_oom_flags {
> +	BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK = 1 << 0,
> +	BPF_OOM_FLAGS_LAST = 1 << 1,
> +};
> +
>  /*
>   * Details of the page allocation that triggered the oom killer that are used to
>   * determine what should be killed.
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 09897597907f..8f63a370b8f5 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1334,6 +1334,53 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>  	return 0;
>  }
>  
> +/**
> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
> + * @memcg__nullable: memcg or NULL for system-wide OOMs
> + * @order: order of page which wasn't allocated
> + * @flags: flags
> + *
> + * Declares the Out Of Memory state and invokes the OOM killer.
> + *
> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
> + * is true, the function will wait on it. Otherwise it bails out with -EBUSY
> + * if oom_lock is contended.
> + *
> + * Generally it's advised to pass wait_on_oom_lock=false for global OOMs
> + * and wait_on_oom_lock=true for memcg-scoped OOMs.
> + *
> + * Returns 1 if the forward progress was achieved and some memory was freed.
> + * Returns a negative value if an error occurred.
> + */
> +__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> +				  int order, u64 flags)
> +{
> +	struct oom_control oc = {
> +		.memcg = memcg__nullable,
> +		.gfp_mask = GFP_KERNEL,
> +		.order = order,
> +	};
> +	int ret;
> +
> +	if (flags & ~(BPF_OOM_FLAGS_LAST - 1))
> +		return -EINVAL;
> +
> +	if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
> +		return -EINVAL;
> +
> +	if (flags & BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK) {
> +		ret = mutex_lock_killable(&oom_lock);

If contended and we end up waiting here, some forward progress could
have been made in the interim. Enough such that this pending OOM event
initiated by the call into bpf_out_of_memory() may no longer even be
warranted. What do you think about adding an escape hatch here, which
could simply be in the form of a user-defined function callback?

> +		if (ret)
> +			return ret;
> +	} else if (!mutex_trylock(&oom_lock))
> +		return -EBUSY;
> +
> +	ret = out_of_memory(&oc);
> +
> +	mutex_unlock(&oom_lock);
> +	return ret;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_oom_kfuncs)
> @@ -1356,14 +1403,48 @@ static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
>  	.filter         = bpf_oom_kfunc_filter,
>  };
>  
> +BTF_KFUNCS_START(bpf_declare_oom_kfuncs)
> +BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_declare_oom_kfuncs)
> +
> +static int bpf_declare_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&bpf_declare_oom_kfuncs, kfunc_id))
> +		return 0;
> +
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> +	    prog->aux->attach_btf_id == bpf_oom_ops_ids[0])
> +		return -EACCES;
> +
> +	if (prog->type == BPF_PROG_TYPE_TRACING)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_declare_oom_kfunc_set = {
> +	.owner          = THIS_MODULE,
> +	.set            = &bpf_declare_oom_kfuncs,
> +	.filter         = bpf_declare_oom_kfunc_filter,
> +};
> +
>  static int __init bpf_oom_init(void)
>  {
>  	int err;
>  
>  	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					&bpf_oom_kfunc_set);
> -	if (err)
> -		pr_warn("error while registering bpf oom kfuncs: %d", err);
> +	if (err) {
> +		pr_warn("error while registering struct_ops bpf oom kfuncs: %d", err);
> +		return err;
> +	}
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +					&bpf_declare_oom_kfunc_set);
> +	if (err) {
> +		pr_warn("error while registering unspec bpf oom kfuncs: %d", err);
> +		return err;
> +	}
>  
>  	return err;
>  }
> -- 
> 2.52.0
> 

Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9322F16E
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007757; cv=none; b=Hi6+W6szTMb9kVS6flVmN0oWgnUCoCxed2XvKoaQxI9iuPjV1ASULeu2F5s5ACRRtIxkBaVBxhi9WY7ZXjkE9mPT15IKTmEdiOXcnHPHCK0tY25uoGOtZqARzjjGoqoUa3mOfrUy32YsSbL9JhcqNNLxEZrzPV9XSvGhaav0Lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007757; c=relaxed/simple;
	bh=riFaidnk/OLlPdzxwI2+yuXF9ybDODW3OZnO3ACZn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoDp8lWC+Rq9V+nZuBTXswOe9whAnGgMUYmINV1suPKoZQaHPfoCLZ268anFs3YCek1Reh5849gBMuWK6ULEPu7xb8HCDu+EvgEP452kY8pem4tFZRvzj450dSz96vYtgIPACWKxur4sky5OUzNtwIjDpkANJsZarF6xMe+nRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=US1f3KK4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US1f3KK4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso7114621a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 20:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770007754; x=1770612554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iI1Ccr3tQDh02EONmID1TL3UlMW3pFDSOrDm5zM+CFg=;
        b=US1f3KK4YBsmzBFjCbj95DIAzr0k4SslpOhqQJgnzDOrxNIyvoaGia7EBugGTAghCC
         uv1mISiom7DVpDU4Qw6JiGI1YoygJIKRBbsWjo1FcW1H52ZCEaSDC59IiHOZ513vtB7q
         nP/ZC+buO4eq/zUUER/o8LZ1zShyohO8gBQoa0e8sfW0es9W24FhyoR2jIsBNnqqN9j5
         44syNa26OmZ7j9uhHP42aprRkxD8XJJ/sjJ+n40XLb1ouzbWy9BIMi7k9dknM0GXGkXr
         7kp1UP+ivrbqZL8Xzw6juDlOI7xz3WWK3lvoUUJll06Q3giJUvwfHouUYr06vECpglxo
         RjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007754; x=1770612554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI1Ccr3tQDh02EONmID1TL3UlMW3pFDSOrDm5zM+CFg=;
        b=j7NPztOwRU1FQgngzVwvUuwRts9v2fsq+riSh8VigSstClPd79KIgDqfk6acb2/1fY
         qci3gLm9uggWuDnX6KTDG8FJ4B6b3Biue63jCu2WoT0ZizthijUfy2CriWHYedfDh7Or
         LMQkqKvlo2jWP/w/p7WpgzgnT7NA2n/BQxZUJxrjXjoHLxsU8DylT1ylkQgrwOk21m5B
         2ss6CME8bqMSS8eiwm5ie5YCVgvlYOvHryQcDLev80+XXoBOgRvCfinu09AyABF87bQ1
         KRe8uTjGn8PGiifKPjTspHGMGd2weEMRX2W9UOhgepgVy+hcNJK+WNxRdgn9eHlwku3t
         M2uw==
X-Gm-Message-State: AOJu0Ywo7ORxf7u+nPdSAaCX976Wq4/U/SnlMBeVQHH6/TnUvOh2tehk
	t9h5hRzuSB/wI6u6wSKEC92YmelGXbYaWAWgPAdqshbHxTX4Ntr5aqQHdx+IhWomtA==
X-Gm-Gg: AZuq6aIdpyKv14E5wgbyC839Z7lsjBRuNDshNGYK0jm7nH0M4XGsBOUZl+JeiihW3a7
	DTOd0Z/u+7M03pbO2mPhyDxkjbXqocK+2Sl//k+BWletP01hwdo0PAE6nVFwQ89nLUvyVvz0vD6
	Pq/7CN6lujjIn8hxP8+rULGF4gNj74Tem/KF0fNzhdH+3a57aJPe6P6Cn6vEltFTCFQOW5vndjk
	IMlp3B23+/mUciIto5v1JKwzLRJ3JVE5EH34gMB2yEUYR1D03SWitXVK1tMduDm6r0UoCigkxIR
	gSdRhyXNaUpS0IwziA7VczWCVyRi70jNRTP+j4VOFm5odTyF7ownOMOpDGvf9XkuWAJ9n9KDK+a
	qDtIZYdLCKV4yO2QRMuIPbs043Zen6uGVzfiziJA9jSJrx4A9hlNY2oNG4HpcUAlJE7S3NRGrwO
	AGWgizJ5GugdBjqBt2SCXIgQcJ9N4TN20+vrqF3gPL0XLERtujYYY=
X-Received: by 2002:a05:6402:1646:b0:64a:86db:526a with SMTP id 4fb4d7f45d1cf-658cb1cc407mr6482647a12.4.1770007754306;
        Sun, 01 Feb 2026 20:49:14 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b42563dbsm7592239a12.3.2026.02.01.20.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:49:13 -0800 (PST)
Date: Mon, 2 Feb 2026 04:49:09 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 08/17] mm: introduce bpf_oom_kill_process()
 bpf kfunc
Message-ID: <aYAsxRI2JGU9KCeO@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-9-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-9-roman.gushchin@linux.dev>

On Mon, Jan 26, 2026 at 06:44:11PM -0800, Roman Gushchin wrote:
> Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
> to be used by BPF OOM programs. It allows to kill a process
> in exactly the same way the OOM killer does: using the OOM reaper,
> bumping corresponding memcg and global statistics, respecting
> memory.oom.group etc.
> 
> On success, it sets the oom_control's bpf_memory_freed field to true,
> enabling the bpf program to bypass the kernel OOM killer.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/oom_kill.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 44bbcf033804..09897597907f 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -46,6 +46,7 @@
>  #include <linux/cred.h>
>  #include <linux/nmi.h>
>  #include <linux/bpf_oom.h>
> +#include <linux/btf.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -1290,3 +1291,82 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	return -ENOSYS;
>  #endif /* CONFIG_MMU */
>  }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +__bpf_kfunc_start_defs();
> +/**
> + * bpf_oom_kill_process - Kill a process as OOM killer
> + * @oc: pointer to oom_control structure, describes OOM context
> + * @task: task to be killed
> + * @message__str: message to print in dmesg
> + *
> + * Kill a process in a way similar to the kernel OOM killer.
> + * This means dump the necessary information to dmesg, adjust memcg
> + * statistics, leverage the oom reaper, respect memory.oom.group etc.
> + *
> + * bpf_oom_kill_process() marks the forward progress by setting
> + * oc->bpf_memory_freed. If the progress was made, the bpf program
> + * is free to decide if the kernel oom killer should be invoked.
> + * Otherwise it's enforced, so that a bad bpf program can't
> + * deadlock the machine on memory.
> + */
> +__bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
> +				     struct task_struct *task,
> +				     const char *message__str)
> +{
> +	if (oom_unkillable_task(task))
> +		return -EPERM;
> +
> +	if (task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN)
> +		return -EINVAL;

task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN is also
representative of an unkillable task, so why not fold this up into the
above conditional? Also, why not bother checking states like
mm_flags_test(MMF_OOM_SKIP, task->mm) and in_vfork() here too?

In all fairness I'm a little surprised about constraints like
task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN being enforced
here. You could argue that the whole purpose of BPF OOM is such that
you can implement your own victim selection algorithms entirely in BPF
using your own set of heuristics and what not without needing to
strictly respect properties like oom_score_adj.

In any case, I think we should at least clearly document such
constraints.

> +	/* paired with put_task_struct() in oom_kill_process() */
> +	get_task_struct(task);
> +
> +	oc->chosen = task;
> +
> +	oom_kill_process(oc, message__str);
> +
> +	oc->chosen = NULL;
> +	oc->bpf_memory_freed = true;
> +
> +	return 0;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_oom_kfuncs)
> +BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_oom_kfuncs)
> +
> +BTF_ID_LIST_SINGLE(bpf_oom_ops_ids, struct, bpf_oom_ops)
> +
> +static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
> +	    prog->aux->attach_btf_id != bpf_oom_ops_ids[0])
> +		return -EACCES;
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
> +	.owner          = THIS_MODULE,
> +	.set            = &bpf_oom_kfuncs,
> +	.filter         = bpf_oom_kfunc_filter,
> +};
> +
> +static int __init bpf_oom_init(void)
> +{
> +	int err;
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					&bpf_oom_kfunc_set);
> +	if (err)
> +		pr_warn("error while registering bpf oom kfuncs: %d", err);
> +
> +	return err;
> +}
> +late_initcall(bpf_oom_init);
> +
> +#endif
> -- 
> 2.52.0
> 

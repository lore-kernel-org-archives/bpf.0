Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254948CD6B
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331780; cv=none; b=cg5x88omo4XgLKp/kBKof8NCGYkvy33x6wzt7NZHDh2P/7RmnSuV8HlY84js7DRdaH3V4+Q/Yj9711Dp2TW0CUHRJAXmfHO2z3lVx7DOAxUOyW9bfzKPCiPswYRw1qMEt47n46CiYBKNcOhJU1k34y3ST9I+CHY87SRJEDUFoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331780; c=relaxed/simple;
	bh=PHt+aRmkFWbvB8uR6W5QXVfMRltRQJ9Is6QfG2qzQ2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phheWt0FISy9W1VnScJ/7XXmj6D9nXB6Iv59BdhUzUXtBwJhI9Ea4sdLpdkpS38s+2wtAHu++qMwEkH98EyB+8bNrsDKgx36XDzmQW7upMTiiLGdRSXl6WXd0Swh65K2FNPqwy+QPeN/EjgDUtpi6HarpuWLjsHLRlKSLkkz/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHnG/e1q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHnG/e1q"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954d29264cso4410875e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785331773; x=1785936573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DK37VB3qMOhbD5yb9Im3WBPoq9gsNNuMseW5SbMeCGk=;
        b=LHnG/e1qy+rsALO7v0Ccj8HwqpildvCNBXCZr1nm2WojnRGD67GKCIVpoFWPtVl7jq
         xVN73dmX/fwjmjx6ekQEDm2betmAOuV/QxiXhFz/Kz+X5YW8N4j0fuVxxNbEPBq9UZZj
         wpn9f7dTv+3HqWnT/VkDAWkMg7DyXujnsPkVO3UbWcQEkQCV6pnyA4ToGCd5ILZngKz7
         UlZR4lfFTjKNayXfrzsbduZYnZ1cPdWfDDMZlGyr4FH4HJcrgzBPFnWJnFiwj6TkCqax
         bhqsoh5HV2QigIOzBX0HT9LyxKjoeUv3rQVB24RrVXSv3ELzHlNtDvvqyFmNrhWiohUS
         Pe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331773; x=1785936573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK37VB3qMOhbD5yb9Im3WBPoq9gsNNuMseW5SbMeCGk=;
        b=d7N8W7zLy618grxOG72+rmnmnI1AwORO5JsK9lhhEMwbhbY/aC9HwPiZrcXN0MXGf8
         qPDh4u5W6cPaNPhhvyKzY9YVK83nQZthIrm00KDnD3YaCPHA374nu2GSkV9WVuyVvkay
         SdWlyxWLgbNdGXaZK9Sk5S2J4jrAEo0sydDrIAbvaRNtp7/ZUn0xe4PUxUt5+P+Wk5c+
         IuViL3vYlO7T107uIbl+kEEebgtgkjdpx4BJM/gw9MQuremJe08fLFOvxpPD/7PziUro
         VIkBi+3qLvlc/pLgHnAZioP6y9lMic0c635cLI9Eix6dGIJgcQJVZWUF7buqDGUpcqFb
         kH7g==
X-Gm-Message-State: AOJu0Yyt40EgFROL5uTTj2g1uxpY3XY80Zf1oFob2mYDptPSZk16WFIl
	etCgxaNaVtKqhCCnh6VVmjwTb2C4FtLuTqquY6kUmIS0w5XziVPVXrVE
X-Gm-Gg: AR+sD13Qfc21eVmS1UyNucMfqjbyhyfPCGk3X6bJeV2LNzLOtGHhPBJD2S82YB+w7eM
	0nmpcKWyNa/T94TDuOncbr7zO0ts4wyIqo/Hv4XvhR1facKsfOSKyA/by/6kJyUCltCcwxLF++/
	tNLyUz/IH6U7EH+vadKFqn3Fl60yU08FstbXYV8zSkOz9g2KjuYcc2zTAQ56cAmc3UYxalO06lq
	FUYye3S4SA5OEvh+cgt8/0o/bp3JzAyHyzvVktGNymM6bs/HRUHSoOTcQqteOz/pF5mSlLCIN9x
	pY/Mxzxe03qKIAlA3EOglhioYEKd+RRsPrKM2zSefLjk89EIQoTsNSDgiXOJ/FdVmbbUh2YIyT0
	hJ3N+9Sv19M3+vN6AuUQoc4KS7LuFDqK8F3lvcjMMaVXxKjA1AUtUBubHjAB4ZNSfhxHtZ/GiF2
	Y/NzPrygtgYoI7uzWLyZ6I+Hjb1HL0p+qeAQ==
X-Received: by 2002:a05:600c:b85:b0:495:6934:414c with SMTP id 5b1f17b1804b1-496c656e6d8mr85293065e9.19.1785331772970;
        Wed, 29 Jul 2026 06:29:32 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::dd7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4615681sm158139025e9.11.2026.07.29.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:29:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Jul 2026 15:29:30 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
	rostedt@goodmis.org, naveen@kernel.org, davem@davemloft.net,
	mhiramat@kernel.org, stable@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: mark trampoline ftrace_ops
 permanent
Message-ID: <amoAOqd0MdO04bM5@krava>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-2-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729005959.3853865-2-andrey.grodzovsky@crowdstrike.com>

On Tue, Jul 28, 2026 at 08:59:57PM -0400, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 silently kills BPF trampolines (fentry/fexit):
> attach still succeeds, the hook stops firing with no error, and
> re-enabling silently restores it with no indication anything happened.
> 
> This is a regression, not a new gap: BPF trampolines were already
> protected against this the same way livepatch protects itself, via
> FTRACE_OPS_FL_PERMANENT on the shared trampoline ftrace_ops. That
> protection was silently dropped during a later refactoring and never
> restored, so this has been broken for years.
> 
> Both the shared direct_ops (CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
> arches) and the per-trampoline ops allocated on other arches (arm64,
> s390) are BPF-trampoline-private, not shared with any unrelated
> subsystem, so restoring the same unconditional flag is safe and needs
> no kernel/trace/ftrace.c changes -- its existing generic sysctl gate
> and attach-time refusal already scan the ops list and pick this up
> for free.
> 
> Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")

hum, we did use it before this commit, I completely missed that, thanks

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

> ---
>  kernel/bpf/trampoline.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 129d07db117e..3d5069091db7 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -224,6 +224,8 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
>   */
>  struct ftrace_ops direct_ops = {
>  	.ops_func = bpf_tramp_ftrace_ops_func,
> +	/* Same protection livepatch gives its own ftrace_ops. */
> +	.flags = FTRACE_OPS_FL_PERMANENT,
>  };
>  
>  static int direct_ops_alloc(struct bpf_trampoline *tr)
> @@ -303,6 +305,8 @@ static int direct_ops_alloc(struct bpf_trampoline *tr)
>  		return -ENOMEM;
>  	tr->fops->private = tr;
>  	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
> +	/* See the direct_ops initializer above for why. */
> +	tr->fops->flags |= FTRACE_OPS_FL_PERMANENT;
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

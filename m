Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC5190462
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097563; cv=none; b=Z+cE/rypLdL/tKZcWaYvtxwbR9ocAu1EgjV265liKVmlXnFvtgo98r6fDiey4KxK5yG/TnBKb0Jmt1tqvK5gQrHwFWh0919rzvzAMjocHxoTlB9xN6H1CXZRENEpzI3WQLessEGvnnNhgVVF8nCNwZ8Xh7tMIzUF9UxiNeCD6W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097563; c=relaxed/simple;
	bh=3/FC3+rTB7zenyYUb/SAoT6ao55r7Msw4PLNzKlY1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJu24S5aGjjTnzmAwKOotPdHRaopVdEN6EYQYn0+Pxy3RxXOHyNzjMBNR/JqnMz6nJC68lujHKmv/+zMaRxYgaT/MM6fCuVo09lIqHtK9APUOAWs3szBLxAYHRxJtEcZhnfD2OBXaxWHSg9rbjEUo1RnKQzB4+zwKPfsgZuL3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvGalExL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvGalExL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccf2360620so3037765ad.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 16:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787097561; x=1787702361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UA11QdsDBQZZwlQ8Rx/R/X7VYyb6gM0uXTt1nPuef8=;
        b=AvGalExL57zB9dAd6e/zsohPJQ4EjxjlxdyXQ35qSFnq6v+xVESozfqfHbSWZc+UQc
         rILD5x1YHKhM+izDD8POVAwJ40uIjHA2uDwYoBYagrxtS6UIdY6bjBeE1Nht4vOIAxWt
         3ILnmro/pldKVNBIggkZtXV+Xxar1l17naq99FSE+dJc9gmg+YnyB37c5NEKO/VMWKb5
         qmauLF2iC4LlJPCNWpXAPgEf0poz8gROp3vXR2IBir//40deagwXupiw2EZbKkRCx/9j
         T1XmMABCtiZGzL7Dau7QC5h/Yuqgjbu41rCMSpm68ohfwcDzhDevediqrO5T4/LKplUa
         zTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787097561; x=1787702361;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UA11QdsDBQZZwlQ8Rx/R/X7VYyb6gM0uXTt1nPuef8=;
        b=iXQ7yFmcWJWPpY4w1A19nfz2V2Ncg0jnG8Ze1knx4ScQvB5fMyTY2TZuWBQcXkK4gw
         ZqFHpHirT/C6EbD3TzecXdPMGOFkVVUJeQnSqYkhd8k10gJAl6f66/atOWC5cmgfEkin
         +F6SRgd/EK4HTLIFtho3qv4WTuJyz/a8WnakfKTjkZoof1WtWrkpmeBdkCH9Dpgh6Jgi
         EwXlFBk4gvBV3eL4CuKWy8sD79Qz/A0hhCpGFwth7JBidzJQciEkxIiAvg47lj90N84X
         TXmy0nVEISwTQwUqAybKzqzkD1iiIn1JfKBy0nxo8EjeG3PsUUJ6wM3JqJ8eXQBseLTm
         T1kA==
X-Forwarded-Encrypted: i=1; AHgh+RoQnUAnwpIP772rRb9dmqkGjb+16XvrPCzjO/7xvwlWnPuoyDettBHqKY//szZdVNh/Qu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0WGeqrbOkTeR5meftbnhs9vVwt713qTK7vz1Wp2xSZdKf7hC
	0EQAm8V5pi2gZN0HLasL/X5OBZfB5sswZFX5/ZsKOpfqiUjFA0zZwYAU
X-Gm-Gg: AR+sD13E1k1eQq6+IKZx6EKyb4A7PbBP76eaigoUNWiQyxhXxYGCHxeH6OR6EfAvd0L
	QjObVJl34gOgB0Js6PGnVXHMAAKs3m4OhC36xQ9tVU9IasoqnpRofLqHS2YzmAwaRFYKtmNFrAG
	JiqIq7klhrLE1rF3tM0Jh27OAKT33Uz9chBftrzJtcK8l/97+kA93wyVFsFyBgVk7/Udj0va6Vu
	bW7L1ieV0lrl3UVufdZZEZ4Ekd20Q2D0mTNe6qz7ifRlmTWj9oBtkcsTjsC2uDlEW6qc7MrFOtX
	rLvE/gcX4vQutrZ+mjLqrtYtjo5nLPNbuFVGIaN06rW/ntA/lFy52Uy0BlOAC9MhE+OQ+q0yoee
	rkNAUEFLlB8Cb7UVu+iJUHSN0XlW8PSkt7A549yxuBVJFrC72iKvxkJWr4++cLxRbPI2m+Z9XYf
	efhpIJ4NIe2rhz4pgjDUWKH1E36+l6xMHOnVWbDIr0hQd9Xc8SlKJ/vg1KLVUP4qcJAm9Fgwfk7
	GGDf0Mwksq/NwxA2qM=
X-Received: by 2002:a17:90b:4a4b:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39580a4d03cmr971369a91.2.1787097561159;
        Tue, 18 Aug 2026 16:59:21 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:73::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm1121775c88.13.2026.08.18.16.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:59:20 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:59:17 -0700
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>, kernel-team@meta.com,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cgroup: add BPF kfuncs to read a cpu cgroup's
 stats
Message-ID: <aoTx1eaNNJ+xrUq1@devvm16600.scu0.facebook.com>
References: <20260818002450.3071325-1-ziyang.meme@gmail.com>
 <20260818002450.3071325-2-ziyang.meme@gmail.com>
 <aoSTaFwsVEoNW01D@slm.duckdns.org>
 <aoTgVOTxsEbFXTp2@devvm16600.scu0.facebook.com>
 <aoTg7ybddqzoZbz7@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aoTg7ybddqzoZbz7@slm.duckdns.org>

Hi Tejun,

On Tue, Aug 18, 2026 at 12:47:11PM -1000, Tejun Heo wrote:
>On Tue, Aug 18, 2026 at 03:44:36PM -0700, Ziyang Men wrote:
>> > > +BTF_KFUNCS_START(bpf_rstat_common_kfunc_ids)
>> > > +BTF_ID_FLAGS(func, bpf_css_flush_rstat, KF_SLEEPABLE)
>> > > +BTF_ID_FLAGS(func, bpf_cgroup_base_stat, KF_SLEEPABLE)
>> >
>> > Why are these SLEEPABLE?
>> >
>>
>> The css_rstat_flush() calls might_sleep() and cond_resched().
>
>I see.
>
>> The bpf_cgroup_base_stat() takes an rstat spinlock_t, which can sleep on
>> PREEMPT_RT.
>
>Is this actually required? This doesn't really make sense to me. Shouldn't
>what SLEEPABLE mean change on RT kernels instead?

Oh sorry, I didn't notice that.

I might be wrong: this function calls the cputime_adjust(), which in turn
acquires raw_spin_lock_irqsave(), so there would be NMI deadlock in the
perf_event program. The __css_rstat_lock() take the spin_lock_irq() as well. So
maybe a SLEEPABLE tag is still necessary?

Please let me know your concerns. Thanks!

Best,
Ziyang

>
>Thanks.
>
>-- 
>tejun

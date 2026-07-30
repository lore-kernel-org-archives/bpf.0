Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB43432E6A;
	Thu, 30 Jul 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420431; cv=none; b=p9AYT48Gay2HStDhY9QKjLhiGy8mTcpabJRpXy4EAA88CfnRJC8WSty2OIqECkIMTFalizMeNwX4c+/7EyqMq51TSAISUxoiwEyB+1SjL5pN/4X4JyWwSXrCPUN0my/PsTqdkbSq1WRGm2+qfma67qmBh/zHoC6AMNDADtMnELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420431; c=relaxed/simple;
	bh=HLfB78vNC0yjT2zF/niDrwupE1UuT6JJmS49+HNeJP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6K8e6OI6e4FCe5zvKyvxSAstt0yNctak7zCfJdxr5FNBbwvvOX22a2740/6thyj/gXMV4VPe1y/FoQfeovHeK3aBx/Oe6g1d0p12wFEtag+UYUwH6vICsnmfE9OidHxrTznCLqlxrZZf2BKQeYEtlW3ivcDsoM8AIM2qbkQv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JruAloCF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JruAloCF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PLkeg63OuLCVxSyZVT3FGznGIpDxUacdB3JC+M2Czpc=; b=JruAloCFq/byX902aD6eb4nSmJ
	bpfmu/SXtypm50k/hfRBOvP6it/z0APmDVQDTWrPjumMRGG0LWjP2/LGKwl8/ecdBsoTVGJ5Ptzh3
	gZ5fFaZ5HF2WTw6QpSrIrFKHJgnbk4to5b4wCE/CswWZ6ILaUoOL4+ukFOnZLxltSF7+A7CeWTUY9
	Z/D+IoHIcvlw85VXICazmvxGAudPMceZS4m1giLr+ZJwkwewLS6iRI0dFrJkWtfrmqPgj7TFHtOsx
	yVZHX5GnuKGAptpU6MoKnNMsWTsNspG20QtN19pdXc6wFrgC3OSBGUlKeRx1ovL3qwQyqPmmE++y6
	Frj56npw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpRPN-009IEB-2U;
	Thu, 30 Jul 2026 14:06:50 +0000
Date: Thu, 30 Jul 2026 07:06:44 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, rostedt@goodmis.org, 
	pjaroszynski@nvidia.com
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, dcostantino@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <amtZNwxZ3gpOsPER@gmail.com>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
 <amM1xUOhcpGpqIpe@gmail.com>
 <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
 <amdWVTs0WKOxguxP@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdWVTs0WKOxguxP@gmail.com>
X-Debian-User: leitao

On Mon, Jul 27, 2026 at 06:04:37AM -0700, Breno Leitao wrote:
> I found 3 different cases on Meta fleet, where rcu task stalls show up:
...
> 3) Nvidia driver
>   * stuck in nv_procfs_read_lock_params

I've investigated this issue. The nvidia driver contains the following
locking pattern:

        static inline int nv_down_read_interruptible(struct rw_semaphore *lock)
        {
                while (!down_read_trylock(lock))
                {
                        if (signal_pending(current))
                        return -EINTR;
                        cond_resched();
                }
                return 0;
        }

Code at: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/452cec62d827034798072827d3866d1881662b77/kernel-open/common/inc/nv-lock.h#L54

The lock is never acquired, and cond_resched() provides insufficient
scheduling relief.

This triggers a more severe issue with ftrace, which holds ftrace_lock
across RCU synchronization:

        mutex_lock(&ftrace_lock);
                ftrace_shutdown(struct ftrace_ops *ops, int command) {
                        synchronize_rcu_tasks_rude();
                        synchronize_rcu_tasks();
                }
        mutex_unlock(&ftrace_lock);

Since nv_down_read_interruptible() spins indefinitely, ftrace_lock
now becomes completely wedged.

I suppose we want two things:

1) change cond_resched() with cond_resched_tasks_rcu_qs()
2) Avoiding holding the ftrace lock while calling
   synchronize_rcu_tasks()? It can take up to 10 minutes on a healthy
   system to be releasd, right?

--breno

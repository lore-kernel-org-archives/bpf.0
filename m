Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C32857CC;
	Mon, 10 Aug 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356068; cv=none; b=Cb73M2bHDqsqTpsJWJbnBztH1+sN5ac9iMA7SQwtlJaM9bFxoVMKkrbNYnTU09opz+Mm9YGutbR5GAGOwDYZBti0dN/W/0rxrEBk5PdMGTda58UJeqz25zcsWsn1V1I3r3eShmLIeFz6YF1nFiGY9G06JkUp/se9MfgpkBwrasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356068; c=relaxed/simple;
	bh=WvkKQ7lU/MHz5kEjFrWnIQl4/VWKa6xtRBFAQcOVtV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQKOKHXAQKBdirt09kDgvJRVesusDtLhzXzn1WDOQdF3929NCGc7nAcdTtoA8w7l39NY6mMBte474eQfG2mO2bNa63jbv5+BQqBeZ68DVPZXDncbNQB0YefocRuygEkp+/imJ1+3YKITDb+lU/kmTxg/xB+PAqYy1EoqOGnlIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dwjz6/dr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dwjz6/dr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=X/3olvZ9OU5OtT3hTQR+ZrKkdBFXH3u9o+ZOdpAud8s=; b=dwjz6/drwiKj8uRgpsTyHLTebJ
	Ut24XTdsgtrQ9SRHOWJ9ZtiG63PMR/JHgRn+SBSTbEBf7UrUnYKYFya7VKq0Y3Uy5XK3xOxAU8PE+
	dCNZptpIHT4X53HzWDKk/cqY8k6Vp+9HbS2CvN0sh/U8LPYlBEZ0VOqhegHn3LjWP4k3wRmB3oGd+
	mRfanpKdH6jdb6/9zGdc2RHgXVRiak2wADtbef2i3O68I3Gm/JzPVJEQBouwqMU9Oe09ixKlVZ8nr
	UYrhadHJ2Gb/+6R3KM3PZGQe29VkL8vFFPzIh1KM8cmsYPcWX42QF2QWTC7XKlPbnu40VDjyMvqWT
	cFIeuaXA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtMoW-002fXZ-1C;
	Mon, 10 Aug 2026 10:01:00 +0000
Date: Mon, 10 Aug 2026 03:00:56 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <anmhBp_hmvSsLqEa@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amdWVTs0WKOxguxP@gmail.com>
X-Debian-User: leitao

On Mon, Jul 27, 2026 at 06:04:37AM -0700, Breno Leitao wrote:
> I found 3 different cases on Meta fleet, where rcu task stalls show up:
> 
> 1) kmemleak -> This patch solves it
> 2) KVM / kcompactd
>   * Holdout: kcompactd0 (pid 1216), state:R, nvcsw frozen at
>      716336/716336 across three reports 10 min apart (stuck ≥20 min in
>      one compaction pass)
>   * This is coming from: migrate_pages ->
>     kvm_mmu_notifier_invalidate_range_start ->
> 	   tdp_mmu_next_root -> tdp_mmu_zap_leafs
> 
> 3) Nvidia driver
>   * stuck in nv_procfs_read_lock_params

I've found an additional one:

4) While shrinking in reclaim:

   INFO: rcu_tasks detected stalls on tasks:
	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
  Call Trace:
   shrink_lruvec
   mem_cgroup_iter
   shrink_node

I've proposing promoting cond_resched() to cond_resched_tasks_rcu_qs():
https://lore.kernel.org/all/20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org/

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5471DED4C;
	Mon, 20 Jul 2026 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587160; cv=none; b=Vfmnqt4jw3yygj2GvyPCkaQiTt0znN1lApuz0NARWCUsaQc0InYvyxyBYVqZdb3impjgLwLhaSgCEzMJA59mY7o4M25z+utYqYET+EEDILQAn1ggF4mALFn8a3SFQE0058jnJslndcGiLwo0zTeNqTx6QkH3dHYYc43urM/YrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587160; c=relaxed/simple;
	bh=Ok2Dc/5b7BOU7sD7UmG2pt5nwkergtNvjtRMYY4xGn0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rWsiDhXtIIh7OvT5AuLV+k874DHK2HTL6KIknSwKHLuMV66Ym1amAXYzyZ1kCTN4nZwHst723nS1w2FHbaa0qfACFsn04qShKqicf3AqSPcMHW8J8ikB2LXkybKSHOFhvCb7lR4RX83ikkXfle/ozX9gbFkh5Tf12aDGua8ttmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IMUmUWOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IMUmUWOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558E11F000E9;
	Mon, 20 Jul 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784587158;
	bh=n9Hp2lCCEZ9lb9WzpnWx8yXkzJX6L7iH3HYpRFS5fnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IMUmUWOmBd0q+fgNDoomb9dXf9qnFt9omp1Qdq5dnG+Gvz0CxQOs5c8CbsWGX2g9F
	 lQZuRWMgT0grvsxE3h4FY8sb2ZZdzqkt94oZm9MK+7XnOIH3/eC86U2AmZ9vu4YAI5
	 4yV2/5lqtSFC8Qax9ZGxFvm9W2w68Y0SF5BeNn40=
Date: Mon, 20 Jul 2026 15:39:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, paulmck@kernel.org,
 puranjay@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-Id: <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
In-Reply-To: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 06:23:45 -0700 Breno Leitao <leitao@debian.org> wrote:

> kmemleak_scan() can run for ages on large debug kernels. It was
> causing some soft-lockups which I got fixed with commit
> 3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
> stacks") with our beloved cond_resched().
> 
> I've got the fix above deployed in the Meta fleet, and now I am seeing:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>     task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
>      scan_block
>      scan_gray_list
>      kmemleak_scan
> 
> and, worse, blocks the callers waiting on that grace period. Here a BPF
> struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
> call_rcu_tasks), is stuck long enough to also trip the hung task check:
> 
>   INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
>      __wait_rcu_gp
>      bpf_struct_ops_map_free
> 
> Then I've learned that cond_resched() is not an RCU-tasks quiescent
> state, so, we need to use stronger primitives.
> 
> Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
> reports an RCU-tasks quiescent state as it proceeds.
> 
> Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
> quiescent state for task rcu").

I'll add

Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
Cc: <stable@vger.kernel.org>
.
.


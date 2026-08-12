Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2735F172;
	Wed, 12 Aug 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523956; cv=none; b=PZbmrAyTPWxLikW3FSnkKyLoYOnZNa9YfC9n9KtZs8MpQ8M3H1jbYWicBHATYT8iJMoat8HA2uD5T84Jc66plOyLSKpqz0f1kbRFnkFsQNd6boyETU2Xe0W4DDLxR7RgZYiOdIz6Dk1CL0qkv2ztQHuNqKGxsPBppEc7TCIz064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523956; c=relaxed/simple;
	bh=JpTcVyoA8oYbiqkWi/Wud7zkoSe0bDVKYAKa9IRJ5SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJNXYdUX7Bta/LciijsCYkHeR1u8G30NhCHC51WkWEQlk7zzLCO/OEzHlaDdfY0EN6gz11u49CZDplBd6HMfzT9QDFaIfzQH74gTpqEIC9fh0QmqAOKchjRXyR6stC3iRVBYp0W95RoMtbsSQNsvtYS75hi7kC96fDS9e++/IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MsaETShT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MsaETShT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0321596;
	Wed, 12 Aug 2026 01:39:09 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A9F3F86F;
	Wed, 12 Aug 2026 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786523953; bh=JpTcVyoA8oYbiqkWi/Wud7zkoSe0bDVKYAKa9IRJ5SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsaETShT/3KkE1CiAfvTprgrDPb/6GingNr4Q0sP5vJZQPYaLO9tWymZLMaA8k4Ld
	 cEbj2tTnEeL9Dp2oAMySwbSHkHvcJ9uPG6StJaXzaLafd4mDxAk36mwa2BfxY4M7jf
	 AZy8MsmE+vJMbjy7xvlzbbmuf8oi/Xw61LyLEGyE=
Date: Wed, 12 Aug 2026 09:39:09 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
	puranjay@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <anwxLa94aV5IZWPc@arm.com>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>

On Mon, Jul 20, 2026 at 06:23:45AM -0700, Breno Leitao wrote:
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
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

In case Andrew still need a tag:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

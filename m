Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD02311C2C;
	Tue, 21 Jul 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592066; cv=none; b=eGlbvfl5DD4DqAaTNGDG5tyCuXxeV+E3QWypXtZ048K6Vvl/Knczotb1ALTWfx8Xm7qomw6Y+8BHNzLYtAwGhi2eH+/Oc13QF755hMrmJTu3jV8bGsQamUer7xEy+8HFsUZPHCK+bL51itkNNSsUgQ1JsPyOS01biHYps7JCi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592066; c=relaxed/simple;
	bh=dJ3GwMJMT5xdzpl1KK3yBmGhMtmteWXh/sSThw42kk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWIg1CCCR0bLo7eotpq7PUbo2RxQErwptk9yf7Jioc1WOn9Qi6A/ao83pH3LTH0poChmUM5wx/ptxv7JFGH+mRxwAJ458cavZVH10qNetvBt++b0u6ddljzOm2HPx2RMsLToZI1ngzkE/O4NFA/3kFbf3VRezVA3X1nWcOp4s1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X04jWm/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X04jWm/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B541F00A3A;
	Tue, 21 Jul 2026 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592054;
	bh=4wdjW8c1HAVinsR//TSoBy/VK5cUlFr4en6GPrctD8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X04jWm/CZcIpNE4VJdYMUGxH1VsaElK2FXRzzYh/OPqniy0vHlLKcT8+WjsWt9xdu
	 qMvaih8so/D0iLPKRSNaId6J6rCwJhVEmMvjuHz4b9SinZEqTH/a8XvbhA7JpMxvzL
	 +IWLJeZ7XFWIMnVSKFWFmpcykGq7sKoFG0YOh3RkvwCICPG2lt4UhXaURJamBbHfS2
	 hbfE3JJAOMj6W91Vc5CU/ctHlbTd3B0Mpl1M//CBnCTU57m9oOiIvhO+t5hSSwQIQj
	 7ng78oz6hNCxrDSsTWGwttlkw3a4XI4Uvoa3fhKZE4bkU5NNjEk1aDmTFfw/wNQ8nY
	 5pmPllPWQIwxA==
From: SJ Park <sj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: SJ Park <sj@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	paulmck@kernel.org,
	puranjay@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during the scan
Date: Mon, 20 Jul 2026 17:00:46 -0700
Message-ID: <20260721000047.93528-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Makes sense to me.

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

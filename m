Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED135E922
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218735; cv=none; b=dSIkP6P1PzJWKaGYTV+WBew9iOxz6khPsqDAxhQQRUlWRomuD3lJm8NU8dYfONivGFLqNwTmgwlYblviFiO/ItxtUKvwdD3Dt7y6p7S72uBc+lWrIi6xhTRBomhmaCJ2jeVikl0IEsdgnDex9wEMHtCNAwRaEH5p0xExTB9ppes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218735; c=relaxed/simple;
	bh=EA0vNBtwvCVjg2sk4x/1buorHro61Onhlu+670IoGbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrXZg8VLBNQWdmOSA9MGXQpBigTbf4xyT7gDGRenkkApqrEv1XCM3y2+vnTihvLonm5U4Mq1t0vSGraU3Uj05M2Hr8JQooPGx9MYjlSHegf9hVmNiRCq1Q6/YZVzYOP53DEQbJi2xNK/ehCkVpBT2tuCAHgR4m6lle3aoJEoM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtOC8hNa; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtOC8hNa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785218731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hHUCL2/8ivjxADtZEr1oOdfiXOA14LirnoWTZ9FODJY=;
	b=ZtOC8hNa2kR6jMvcVla9gjjJ7WXYfInIHz5Wn0kgCl8PTur025uX+OT0X72c6wnHCG4sXS
	2IXIr1lGnaJcRT8HYMojs23oRdCNASqXypt7CqQS9YlscvkAR4iDNsm3MMhKfrys8Jy3cM
	C5E+TvEVkkrT7o/3dvJz3E9SvS72PsU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena lock failure
Date: Tue, 28 Jul 2026 14:05:16 +0800
Message-ID: <20260728060517.95183-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Reported by the Sashiko AI review.

arena_vm_fault() returns VM_FAULT_RETRY when it can't take
arena->spinlock, but it never took mmap_lock. The fault path assumes a
VM_FAULT_RETRY handler already dropped mmap_lock and re-takes it on the
retry, so mmap_lock gets taken twice and can deadlock:

	do_user_addr_fault()
	{
		fault = handle_mm_fault(...);   // calls arena_vm_fault()
		if (fault & VM_FAULT_RETRY)
			goto retry;   // re-locks mmap_lock
		mmap_read_unlock(mm);
	}

Return VM_FAULT_SIGBUS instead, for two reasons:

1. We could keep VM_FAULT_RETRY, but then we'd have to drop the fault
   lock first and cap the retry ourselves, the way __folio_lock_or_retry()
   does.

2. A failed raw_res_spin_lock_irqsave() already means a possible deadlock
   was detected, so retrying just hits the same lock again.

So returning VM_FAULT_RETRY here is overkill.

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
target to bpf-next since I think it is moderate.
---
 kernel/bpf/arena.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 34f023a537fe..555ee2531ef9 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -490,8 +490,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kaddr = kbase + (u32)(vmf->address);
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
-		/* Make a reasonable effort to address impossible case */
-		return VM_FAULT_RETRY;
+		/*
+		 * A failed lock means a possible deadlock was detected. Don't
+		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
+		 * the fault path would re-take it on retry and deadlock. Fail.
+		 */
+		return VM_FAULT_SIGBUS;
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
-- 
2.43.0


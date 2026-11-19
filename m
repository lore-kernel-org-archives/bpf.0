Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104031;
	b=iOKHv20pu0DFQUyTdnGVRJEA1FgTnCBq9eLOtIqPpyaGvjIiz09tjJdrKcK1Vc5xwt0X
	 W6CfzlpdfLniOh/nj3Msvi76r8xq2JY/dkNYl1Xz5WaDC/tzTazV4f/E8vKDgDgcQlzuz
	 MJXgc8MlU6OXX8cVWc4t/iVncWrVtW3LHmXDpVWvorskgX5270xOMKSF+9IvL6CH1NeK+
	 9MppdQtewrI1m9RZGwudVyqTPgaLgYq9FYayUJFzJ5IAl4wyN/m3rjpozAMRf6kLQ43Gs
	 c57cFqHqi2MwzSDU23Fs8kNU8jKjApevmI5vELOzadefGuUY0esE1cexVZgN9v4Qajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104031;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ghdvXRs6WeD3J65MxVpuLnA2rqhyvwGZJnk+T3/dQgs=;
	b=HwNCZTvaAnwHYZhczhXN5C4F+33sUEhFJQiGaWgfZDclU/uu/MqQXyXnX6/3fgBcXY/Y
	 6n2dTSdmiQ7p2mLDXU+b7nS50YUwLxxlp9ggVNXrBF7nD6owrZWpbebd1o77ccseR4Z2n
	 DaIh5Kq4mN7Y2LU6LFVKall6tPZVj1sw5tTCXvaEHqMtzSoQcyqOMtRuWzOa4tIVbUIGP
	 3FnysDMV6mN+Q3l4kCtgzWOY+yqPmDETjrRIiAK++Xb9k3glH6w7uOIMWdXXs5ziEyf1m
	 5SrRJzGzRy0w/pIPMm2n5tDWiORSPEBAkBUS/WHiIeqMTrW2SsZhNuIlMyQIBKWG8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UoebAUpc;
	arc=none smtp.remote-ip=95.215.58.58
Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A2606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827A2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UoebAUpc
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=muSluvC1BBHfMSuECvqWpxXBduhSE0/vxCvegiCzjJc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795104028; v=1; x=1795708828;
 b=UoebAUpc9Dovg7tSqjUZM3lF7OlcG3b+G7ban6XEK46pjjJWwV3B+/VNPL3K8EpL7lHmQGa1
 xbaevpAFmrlU2DB0tu28JUK2StqMgpNtZMQyyRfrDVlh1SJUbkhQCPIlgv9xLgWtMNx8VcwX1aP
 wPbYDQzZzeyAiWmOTMUOOudY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d38b154e6baa8d3a;
	Thu, 19 Nov 2026 16:00:27 +0000
X-Mizu-Trace-ID: d38b154e6baa8d3a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 16:00:23 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: david@kernel.org
CC: akpm@linux-foundation.org, alexander.shishkin@linux.intel.com, ast@kernel.org,
 bpf@vger.kernel.org, bsegall@google.com, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, kees@kernel.org, kprateek.nayak@amd.com,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, mason@kernel.org, mathieu.poirier@linaro.org,
 mgorman@suse.de, mhocko@suse.com, mingo@kernel.org, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org,
 sashiko-bot@kernel.org, songliubraving@fb.com, stable@vger.kernel.org,
 surenb@google.com, vbabka@kernel.org, vincent.guittot@linaro.org,
 vschneid@redhat.com, yhs@fb.com
Subject: Re: [PATCH] fork: clear p->mm when copy_process() fails
In-Reply-To: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
Message-ID: <7F08BE59-B6F6-4884-AD56-8178335F2C15@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 November 2026 08:04:58 GMT, "David Hildenbrand (Arm)"
<david@kernel.org> wrote:
>From: Chris Mason <mason@kernel.org>
>
>When copy_process() fails after copy_mm(), the error path drops the mm
>reference but leaves p->mm set. Perf and BPF can still reach the
>task, and take a reference on the already freed mm through get_task_mm()
>or bpf_find_vma(), resulting in a use-after-free:
>
>    copy_process()               PERF_EVENT_IOC_SET_FILTER
>    ==============               =========================
>    perf_event_init_task(p)
>    copy_mm(p)
>    a later step fails
>    mmput(p->mm)
>      /* frees the mm */
>                                 perf_event_addr_filters_apply()
>                                   get_task_mm(p)
>                                     /* use-after-free */
>
>Similarly, a BPF program on the task_free LSM hook can call
>bpf_find_vma(p)
>before the task is freed.
>
>Fix it by clearing p->mm under task_lock() before dropping the reference,
>just like exit_mm() does.
>
>Further, if copy_process() fails before copy_mm(), p->mm is still the
>parent's mm pointer copied by dup_task_struct(), without having taken a
>reference. While nobody can access it concurrently, there is the
>chance that it might get accessed later when a BPF program is attached
>to free_task().
>
>With CONFIG_MEMCG the task is freed after an RCU grace period, so the
>parent might already be gone and p->mm in the child points at something
>that was already freed. So let's just clear p->mm before freeing the
>task. No lock is required as there cannot be concurrent access (and we
>might not even have the lock initialized yet).
>
>This has medium urgency.
>
>Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
>Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
>Reported-by: Sashiko <sashiko-bot@kernel.org>
>Closes: https://lore.kernel.org/sashiko-outbox-180866@kernel.org/
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comments ]

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
>I can take this through my tree (rather soonish) unless someone else
>wants to pick this up.
>---
> kernel/fork.c | 15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 5efceb8d58a78..77d6c8fc38c66 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -2628,8 +2628,14 @@ __latent_entropy struct task_struct *copy_process(
> bad_fork_cleanup_mm:
> 	sched_cache_fork_cleanup(p);
> 	if (p->mm) {
>-		mm_clear_owner(p->mm, p);
>-		mmput(p->mm);
>+		struct mm_struct *mm = p->mm;
>+
>+		/* Perf events and BPF programs can still reach p. */
>+		task_lock(p);
>+		p->mm = NULL;
>+		task_unlock(p);
>+		mm_clear_owner(mm, p);
>+		mmput(mm);
> 	}
> bad_fork_cleanup_signal:
> 	if (!(clone_flags & CLONE_THREAD))
>@@ -2663,6 +2669,11 @@ __latent_entropy struct task_struct *copy_process(
> 	exit_cred_namespaces(p);
> 	exit_creds(p);
> bad_fork_free:
>+	/*
>+	 * If set, p->mm points at the parent's mm without a reference. Nobody
>+	 * can access it concurrently anymore, but prevent later access.
>+	 */
>+	p->mm = NULL;
> 	WRITE_ONCE(p->__state, TASK_DEAD);
> 	exit_task_stack_account(p);
> 	put_task_stack(p);
>
>---
>base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
>change-id: 20261119-mm_failed_fork-a46141b503d0
>
>Best regards,
>--  
>David Hildenbrand (Arm) <david@kernel.org>
>
>
>


--- Thanks!

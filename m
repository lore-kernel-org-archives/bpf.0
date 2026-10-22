Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634283;
	b=QI2GnuTZNMY56fWR65o9lf0qGJt+ynC4xsQJBhQii+SoXWsJZdHhteNn0CxPCzQgOCW2
	 dcH/S3CmI9DYXlgV5SgNUDb/ojoSGpOZ/mPcPxpy5GxE2ijNqiLdfN+fpa2ZgLSQPcusX
	 esfFt+iegovOY3Fzr5oByJfTq0f1Z5eyTY9qJCQ6O7qeG19DxPu7qOv8fhslnUeZsISNX
	 eCiMQM+cKk6D3LWH+zCjVDTK2JHgXSIrj45TIE9ERXmTo+tQ3TfwyoVqBzGVoGUDMo98V
	 lyjEd/6iKlgkIzX9vF3l5n6IIVYNnucXnEY30dMmst3aHjQs7xlbrkBou9lKfQVK6bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
	b=lUcxS8cDJLW9UekQ4Fgl1v9Vaweoof+NsJAWD6GU8aqvb7Nb5V7jnjXY4nUuom6X9LM6
	 zdOHt92XbT92z+4BKW/lsI2N8gcdmMSRTRwlGuzP+PGKJdBgz4kDQ7+1VprYfzq8NTc4n
	 UouJ2OwDlXj3CgnVgyHUhEJAufgk1egNVJO9hz1uR8YUeM8ELfUXBsjBwZN/hMO0MXUTh
	 njBiEQwjmlsNncGLgv52GGHyPLtVO1DZMV7fHVHUg3ZrD1stMoI1Qw4X+Me3yAS9G92TQ
	 a5alnfbM3DvkObXI2+XlTs208tNKHxxTW5ghOl8FdVJdriMAOnXFSrSQ22dDJUkNluA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFKEKRsq;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94179606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94179606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFKEKRsq
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so780153a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634282; x=1793239082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
        b=IFKEKRsqFaZjucw+rqR4ryTGBSp6IDf1i5gaP/nvE9Wndr/QCOZn/7yv9UpaKZHjDW
         8/qyEA5iS19EeITAWkeyWrMT+JTRum1RMsLopl0wBBbhATjbhMHOkwMspb7/m6mO/BmT
         pfVK8W7BlQpeEkx7qfVaNeDcMUgnW4ewjeTmIoIFaKAue3DgHNDQZS/6PVOffg3EDz9t
         k9mZgSSMef4WmBGQmCR6sCoBnqW9r1Hm6mhecwOw4RqmvPO1etWZqFuPJzYWB7QaFvPK
         PNESNeRhCzNr+XEjblAL7LZO5n9/FCFC9VKwF+DgX0t7XnCL861klOfl4Nys4q4D2M7y
         OkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634282; x=1793239082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
        b=sUJK56Xp/D2yz7EgAkPNtqnpI7cDesYZJqy9k0aunfPgXZ8RJxNPtm0xoDSk1GYmPi
         WFEAvpgDLgCx9FBOCNxsAnfsM3nYT9Q27WiCfaqywFPO2Ozm8ND7/CF1rdcuv2PW4iNH
         /9KoiIDJBMQng1r2BGn8UzCRzhVaVJ8khpjRQpkuJZ8TZU0ftS5g7FQcLN4e3LOeFue6
         uMykI2h4DHIaQ641Z5BVvVuy1fCm7fGuRUQT5JiSqpwvFpmBlylJJ3sqKIjiWo1FDVOX
         OKnFjrC0VCHBdoFLxphrVdgeoEA18Q+N6kHUPHgBuQY8jfrTy7FgN8MKw8bT1TNkarFv
         TJQA==
X-Gm-Message-State: AFq9FYLY+bDKh+/C5Z0lHkz/1syykw8fVzFWMz8o7UQLNc08MflHPY8c
	senMx6tlsEvGqdGWYHzyvWEDCsfW8lNnCVtEZokSKMdzaeuWCTlpZScdq66EZg==
X-Gm-Gg: AYBFou1QGRsWYHJBzRIelBOVYiB3WTVihOp6FhR8tj9Fkkrjchu3tn364cSA+TBUsF5
	WXbPRetg3ATdEsfO/vdaVbYq8J0/rZu0HzA+/bHcvWffVpMNhhU4DovUh82qsXCu212hrpnacW3
	SNDitIstogSVFjP9OnAGDPwKXyygI307Suli9VgVusnH6KLtTdoVVySOMPHxjDDGVbjTO0d5c3g
	GxhpeunW+l/WeP1IZpYBJTxSBJqXUez6XkJakiRTCdJ3ZTdCVMjJFdEQhyp4PMVcpq6i6lVcXRN
	pWzJnVItq52gTalE7kq3R8d0bAANVXOaq/afSsCFRxnSsTq102uroBNnbj7EmfJWbYP/+Y4bM1k
	OhyYwyxQq3GvCCY+qgATF30WQLNgh08eDUO1gXuwN3nnMHaFA4upaD6+K/X6GyFNftoqErhxsov
	lqwIotez1x5k8VxZ54SodJFjYlPvIq1ZCdWdLI5IVF83Z9sTzSDppCXdHSb+TiOpuyDwECvPCiH
	4OXWQ6P5WR+RgUQtCQsEGyJu+ItOVz4aFGysYzoWnR0Vtx5Jk956xLdInJ0aewNXGQ1gMtTisbX
	njxd0KGIoWA6sZm/EwHdyPr7RvFc2FLmUyolsNavM2T+1b3JrZXzMYRyrNmAXH1iDOc5lRLoD9s
	oWbbDbVIVZW3AxuiEIXo56cdP
X-Received: by 2002:a17:90a:e7c8:b0:3ab:d45c:59e2 with SMTP id 98e67ed59e1d1-3ad86f1b28fmr2821607a91.55.1792634281882;
        Wed, 21 Oct 2026 18:58:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5edsm1751706a91.8.2026.10.21.18.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 7/9] fork: Let the new task point to its mm before uprobes can find it
Date: Thu, 22 Oct 2026 01:57:10 +0000
Message-ID: <20261022015712.1297331-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

uprobe_perf_filter() compares event->hw.target->mm with mm. The target of
an inherited event is the new task. copy_mm() sets tsk->mm after dup_mm()
returned, but register_for_each_vma() can find the new mm as soon as
dup_mmap() releases dup_mmap_sem. No task points to this mm yet, so
the filter says that nobody wants it.

The walk that removes the breakpoint, because another consumer of the same
uprobe goes away, sees !filter_chain() and removes it from the child.
Nobody installs it again, and the inherited event doesn't see this child.

It's an old bug with a short window. The previous patch releases
dup_mmap_sem before dup_userfaultfd_complete(), so with UFFD_EVENT_FORK
the window is as long as the monitor likes.

Set tsk->mm at the end of dup_mmap() before it releases dup_mmap_sem.
Not earlier. The new task can be reached via its perf events and from bpf
progs. They shouldn't find mm that is half copied. Clear tsk->mm when
dup_mm() fails after dup_mmap(). Do both under task_lock() like exec_mmap()
and exit_mm().

The tasks with such event fork, while another consumer of the same uprobe
comes and goes. 5 cpu VM, 90 sec and 7000 children per run. The number of
children that the inherited event didn't see:

  without this series          11 to 24, 8 runs
  patches 1, 2, 5, 6 only      23, 12, 21
  this series                  0, 0, 0

With UFFD_EVENT_FORK monitor that reads the event after 5 sec the child
lost the breakpoint in 5 of 5 runs without this patch, and in 0 of 5 with.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/fork.c |  9 ++++++++-
 mm/internal.h |  3 ++-
 mm/mmap.c     | 14 +++++++++++++-
 mm/nommu.c    |  3 ++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8fd6be932afe..5a2f571b64b7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1539,7 +1539,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk))
 		goto fail_nomem;
 
-	err = dup_mmap(mm, oldmm);
+	err = dup_mmap(tsk, mm, oldmm);
 	if (err)
 		goto free_pt;
 
@@ -1552,6 +1552,13 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	return mm;
 
 free_pt:
+	/*
+	 * dup_mmap() has set it if it succeeded. get_task_mm() must not find
+	 * it after the mmput() below.
+	 */
+	task_lock(tsk);
+	tsk->mm = NULL;
+	task_unlock(tsk);
 	/* don't put binfmt in mmput, we haven't got module yet */
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
diff --git a/mm/internal.h b/mm/internal.h
index 9e3be236f18c..70e40306d881 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1520,7 +1520,8 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 			  pgd_t *pgd, void *private);
 
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
-int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
+int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+	     struct mm_struct *oldmm);
 
 int remap_pfn_range_prepare(struct vm_area_desc *desc);
 int remap_pfn_range_complete(struct vm_area_struct *vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 6ce654e33e3b..3167272a77ad 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
 
@@ -1705,7 +1706,8 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 	return true;
 }
 
-__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+__latent_entropy int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+			      struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp;
 	int retval;
@@ -1897,6 +1899,16 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
+	if (!retval) {
+		/*
+		 * As soon as dup_mmap_sem is released uprobes can find mm via
+		 * the rmap tree and ask the consumers if they want it. The
+		 * filter of an inherited perf event looks for mm in tsk->mm.
+		 */
+		task_lock(tsk);
+		tsk->mm = mm;
+		task_unlock(tsk);
+	}
 	uprobe_end_dup_mmap();
 	if (!retval)
 		dup_userfaultfd_complete(&uf);
diff --git a/mm/nommu.c b/mm/nommu.c
index 68b05565e15a..7529e03d3f2c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1885,7 +1885,8 @@ static int __meminit init_admin_reserve(void)
 }
 subsys_initcall(init_admin_reserve);
 
-int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+	     struct mm_struct *oldmm)
 {
 	mmap_write_lock(oldmm);
 	dup_mm_exe_file(mm, oldmm);
-- 
2.55.0


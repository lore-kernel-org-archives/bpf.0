Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D183B8D40
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179438; cv=none; b=rkXf8NPVX11MNvbP8dhTU6k79Es1X+xq6Xtyv/SPcO9OeC8SR4/7AaUoOReYB8GdGyMAQHVxAOfAQ9mG3f/ZA7ifOF9rJkM8U9VIvDXABBUKc1fRoY36v5+hBhak4x6D2bE7MESUc0ufCmBokEgpE3l6gHD09qfxoBae9n9gavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179438; c=relaxed/simple;
	bh=WI3qBdSvI+VLdREf4UzPlPd7pjV+HoZ+sGSpjeoGBlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0oT0WGeYiSLiKh8QXYkptkwTT8QPpW/MQALcmCvAE8zVrJxfS8ls5IJlle7HnZxM6cytS4hSVFlhqcR1Wg3rkEfre7xjTS68pCpSrtOrJvGz7ZX/TTYwq6qfKsvQicDackyLSTzh2Bwid2jt7hlLVk7UGHcmAHDyBB9UyiRP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WN5pE8/K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WN5pE8/K"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9ae391a05so1201335ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792179433; x=1792784233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKAIvonxJeUP7Jsk8C5mNA6Fs7NOiNZCRDPjjqnhWx0=;
        b=WN5pE8/KrmnGyb+wrKaJ2qAIojFNxGV/VCBtFwEPFMy4eDBg8xJ/Yr7sePQ6Km+nBt
         3GuT+oGcBX7IP99OXgsTRxjwRHgklWKCaPuxuwE5YFvRslQ1FygMheGZzjVfa8x9vKvL
         bsCstrB6SR5MiyYXKZKvTtvSdouVkfdETIqsSqhUXYQ5wfga8SicWSDJi3TbDOSjHEpt
         qslKRzQeTRuvX3u9DyPJUe3yMLMyEbUsofjBUq++mqAzVDMwn9IjJ6QiiQkIcR22lh8y
         SxmqVHcblURSS5EeMuar01d8p8JKlH22c0c+jsW+cjr2oWbH3iI81dJ5Jb01QSTJYS6Z
         BJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179433; x=1792784233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKAIvonxJeUP7Jsk8C5mNA6Fs7NOiNZCRDPjjqnhWx0=;
        b=uUXzEuNNFQR7zg6CyVw3rnrFY+0pLXUpjbvST+waZr39BuDnktFa4mVsByhuMaAPhL
         0bqw5FMomRa4VBQDlhkSfFInQG7wqt82Nz5ACB+X8EhBBFwni8JGOFqS3azrH7yguvsv
         t4LpsuvOwCfrPU+Z3sqwNvhJ+5C1ADQYu6oa5V5gcW73kTfx/FMlXAKfimP7xzTagBTM
         hvRjAhEdaiEf9h2v5JfKXNP+UweULJ/RGJicCLdbqf+xwhIbr3ucRDaapsTxuHJgHPG7
         sVj4mhr6adnc/hv2n/PGfdsJdwZIvbdprzyJgp9xAWAenOJiVS+GLvrBLa+OLJsvNGPw
         CSbA==
X-Gm-Message-State: AFq9FYIHiArACRxec2W5cUAHNCPZTzH6k3Z0CGMb6CXGAIBRzodP9KWK
	QHMRBmlMYlAhlzRjHdliUVc7IgytOujXYEx8fZqHwV7aurTDKW2f6yuT49vyRRnf0BoMXmXfo38
	75WoVmIKIUA==
X-Gm-Gg: AYBFou25MLvv4UzoGHX0Y8DzF1MdzKmJh6TU5dD0Mk0OI6TTXOSmjKEYnhfpeeo6W/n
	4WfEqx29GnnUDWZN9coJAgWt84hziNW9H3tSbFUyvJZMoM8EptRxR3cMO1LjJqcpkvmzofygsyu
	VYU23EYbXnVvRHvqqqAVcpaxCklD68qKH/qAL5H/UoK2xKuZaf/nfoYBSjjFdteWtDxpwCzD81s
	LuogXEO1K1hArmtlFoY+g8xAgofxEECQvi69iANLMN3z515hE4t4qwASqOYY6YUF0KrD059cvy2
	VgDjaLK8J4hH9ZFAUKgLKEaciPxH5afgeySO2hcP4jExOKt6LXB7LMC3t+Df3Ky01PiLhZPtj+C
	zZGVLjn1vqfxEhMh//a2Kx8xea22tDxFps345rrJYYgBsArZ2EbYs/sAGKBXg7bXNhSjrT9a9wT
	D1GCTegdt0a+kT3JwXnJf7YxFw4DLrcH6uHjpa7l6pyJ17WgUmZpVHP0T9iwQTf+1zAxBEPU+tz
	P+BwDRSBiw2ignukOtm2mMrrd/aPVBQeFQ4
X-Received: by 2002:a17:903:2a87:b0:2e6:2023:29fb with SMTP id d9443c01a7336-2e977569c8emr30181245ad.29.1792179432556;
        Fri, 16 Oct 2026 12:37:12 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm14970045ad.68.2026.10.16.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:37:11 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 4/5] bpf: Retry arena faults when the arena lock times out
Date: Fri, 16 Oct 2026 19:37:02 +0000
Message-ID: <20261016193703.9203-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016193703.9203-1-emil@etsalapatis.com>
References: <20261016193703.9203-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_fault() and arena_fault_page() raise SIGBUS whenever they
fail to take the arena spinlock. The resilient spinlock fails with
-EDEADLK when it detects a deadlock involving locks the caller holds,
which retrying cannot resolve, and with -ETIMEDOUT otherwise. A
timeout means either contention or a deadlock among other CPUs that
the lock broke by timing out. The faulting task holds no other
resilient spinlock, so it is not part of such a cycle, and a retry
can succeed. A timeout should not kill the faulting process.

Commit 0b10b945479c ("bpf: Fix mmap_lock deadlock on arena lock
failure") raised SIGBUS because a retry would have to drop the fault
lock and bound its retries. Keep SIGBUS for -EDEADLK and retry the
fault on a timeout. Faults that allow retry drop the fault lock and
return VM_FAULT_RETRY, as __folio_lock_or_retry() does, unless
FAULT_FLAG_RETRY_NOWAIT asks to keep it. Each attempt spins until it
takes the lock or times out, and the fault handlers stop retrying on
fatal signals, so no explicit bound is needed. Faults that cannot
retry, such as some get_user_pages() callers, return VM_FAULT_NOPAGE
so that the caller faults again, as they already do for pages whose
free is in progress.

Fixes: 0b10b945479c ("bpf: Fix mmap_lock deadlock on arena lock failure")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index dd9f322ad57f..034495e014fe 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -589,7 +589,7 @@ static bool arena_fault_page(struct bpf_arena *arena, struct vm_fault *vmf,
 
 	folio_unlock(folio);
 	put_page(page);
-	if (err) {
+	if (err == -EDEADLK) {
 		*retp = VM_FAULT_SIGBUS;
 		return true;
 	}
@@ -672,8 +672,13 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
 	if (ret) {
-		fault_ret = VM_FAULT_SIGBUS;
-		goto out_err;
+		/* If we are deadlocking somehow, no way to ensure forward progress. */
+		if (ret == -EDEADLK) {
+			fault_ret = VM_FAULT_SIGBUS;
+			goto out_err;
+		}
+
+		goto retry_free;
 	}
 
 	page = vmalloc_to_page((void *)kaddr);
@@ -776,6 +781,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		free_pages_nolock(new_page, 0);
 	return fault_ret;
 
+retry_free:
+	if (new_page)
+		free_pages_nolock(new_page, 0);
 retry:
 	/* Non-retryable GUP callers recheck the PTE on NOPAGE. */
 	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
-- 
2.52.0


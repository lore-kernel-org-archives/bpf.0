Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148302;
	b=5tmqDsTlWH1rZYAXOA6aJhJ/Cce/DK1GpUA/FmYPd+F7klo/u3d1Lmu2L9+tObMFZa5p
	 s7393kz9/8U5F3xcPc+9Hc89vPZdpMn8SUjWKg0zWcoVmwv66OnHud11MhU0qTi1mVVNM
	 io6BfD3JGDrxevWpg5fQjxzlivWlqaaIevcR1bCAMiO8aTqvTzl6pFiDeB/jpsfnElbBp
	 LC9eI46r3yLaABjNDXeeh21nMUUBozKA0SL5+3Zb+6dAgKcCCSD3rfXWtAun4wS5NiobW
	 3ErSKk/lqO2cLJ+G1Sy/JqSNm7MylmPfj/R4CpYtlKxb251A5wme6+g83M1XbHeSw0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=bZ0vzUS7ojUxUMAz+uz2vZs9hZ+sgYHK6cDo+77Kg7w=;
	b=FTN6yfJTriaf7kAJ1W+rMB1edVTBaT8LGfWFf0iF4wtAnPAeoHw2XACHQVbdDLU4bsev
	 8919aLWGxkyvEdLHUZffHAEbvCltd2YSYOGJ/h5ZwOSvgnbxoC7OlMy86ln7VTuZRQ/4k
	 oRtXRBwBAAqZ2xeYZTT/qvD1wra40t95aVINaktmU67SoioGBihGxbqJAgg2RbD2ZGO0a
	 bczk7tFiYlM/MtMas+wqoLi5r2cYUp0/tzUcRALZtRNtvxyxK8KSm8WjuvA/rT+dXn93T
	 ecQwYSXvCiG7rKEcrPnlwJEHzIw8vw4Db5lNJK0IoqQy+yGB9CY1xY15mIeZJeGe5IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z32yG7LE;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F60606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F60606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z32yG7LE
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48df0245ce6so247591f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148300; x=1793753100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZ0vzUS7ojUxUMAz+uz2vZs9hZ+sgYHK6cDo+77Kg7w=;
        b=Z32yG7LEZfW/LWAG5CYClM3j9/ikeKaH+QH93sAWKrpR/6zfP2G6/jzAYxEBOMu5j7
         tISAJQTHf1699oyRqBWfMFIw5MpnJFSckFIovl50PD7exT4nvTgchEOndt8CN0/kpgLg
         fZVAF4mR8HP5pewcJEl69gc9NSkOIkwyicMjPfO3rCn4QziOeL7AWH6lz7v5QigTz0Bb
         KYonrHkrjSINM0Bs2Sgof/CRR/abTXuUjB9SpO4boEz4YLLo+EBtb8Fq5DRVCIcAjbaL
         d7zE+8250A9CHv/bEeXBTkx6/F6QH9SMeBXp0rBTzJyRxMgVD2/n0V6yDc/KZkhn2OGO
         Zp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148300; x=1793753100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZ0vzUS7ojUxUMAz+uz2vZs9hZ+sgYHK6cDo+77Kg7w=;
        b=G070wrmGX/Mqddao8dWOQG59vY1rKPRvcYi5Skgwgg7k9cXX/k2ttbKFs+4xIyEj7V
         IjDKU5x0cVTwHvMxgMbbdPpxFRiZcnHoZ1BuI+CnTCLzHg3Rq+urAhuD8hdQ3otpb0zx
         alc1Q9d/5+R+poh6/Jwa0On4WAoAisgvc3oWcXE1L/gRYUdDWYjin02B/uXHQ3+8N1e1
         zlZzI++NhFBHRffphpNRW00m0qXkytB+RZTgMDvH8M84obtTBIO8t8JBMa9tUF1VNrIk
         fk0AHErdyVjUq0cHhG/+RPiufp2GcNyQD+CfEI1ZjkZ6+o5ZLOxZ9ZZ1js0PS86i/zQF
         Hdlw==
X-Gm-Message-State: AFq9FYJWvOuzd2Pcgb9ZCH6PZ4UpFyQsCXHiDen5hJk55lDq3kG94uMF
	zNKFVwKfmcWAfW463sMspbgRPgjPzYpjo878xuBDiWCGgg+uq1wHVKsBgcX0on0I
X-Gm-Gg: AYBFou2O8faZB0ueHX8hcwtQkivF9jklge/U+ePP9HJP2zUYs1qKc9escyj+Jba9lCZ
	CTMZ/2IEff/3wYZF0yijJaH4GKCHow2smGZ6nMNHM+e151fdFQ2UNsEjNsEy19kBSgIfdCArXAg
	sUl7GLk+BhA/LdaMHSBMpPDG7vRo/XUM3RIRc0TsC6lDnxqUUSpqfzgIV5P9XfuGkO0Ys+FN0RU
	GUfdpP9zIqNpK59JmLK1dfbapwrRyQ//iXLdtLiJ9WYpgAHcwRConyCTQ1CwRPwDb/TsQ0DXaBJ
	sDVbOP+bkCP06J108RX3eW2qjAXLBfAZMKCXE37cVgF6rmUK+hbhqwIFjShjRMfgaa27P1NAnhq
	9ua2UBGAlcrizuIh1/zL7eTJoyJm9zRucTE3IeNRB0ovzdSVR1AOoJkW5C81uQBxIr2c1yk1Iop
	6DpDkEg99c8F4MADp22kvJY7tPpZ+80VQKgruCMJQqkuxY6t0YSVARpZTN68genF9UFPUj/cV3D
	PXcj7VYry2fUzZMvkyrytYE6tbimfWCDUjxwlQPzssUu8cSV28vNcyqeVt5QiQMWkHVVVHFzrn6
	fmj45a2d830VuhVY/WKWYkoEYk8zMWxc1ySt4cOS0vc2jydHekBLUF8B7Z/yHUfCrFrsamRABao
	hYbM9GzoDqP8rHhvrO0mYE+/SlrXXBQgSeTEr8tXg0g==
X-Received: by 2002:a05:6000:200e:b0:48b:a4b:5a2c with SMTP id ffacd0b85a97d-48e5d45a42dmr2051028f8f.3.1793148300492;
        Tue, 27 Oct 2026 17:45:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7easm25711113f8f.52.2026.10.27.17.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:45:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 07/11] bpf: Let the callback of bpf_find_vma unwind
Date: Wed, 28 Oct 2026 01:44:44 +0100
Message-ID: <9b98417904ec1b27a1b6e2d6a37b897fe2494073.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=memxor@gmail.com; h=from:subject:message-id; bh=HSocFi0ykeI4h/TeDVWkIJ5tC4zb1DqGRSfWaEwiJdE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh43OVKT3H+a5Hn25amzGtKU1kedvZuTmpXO/mnRQ99 N5bwXpZRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaynZvhf0KqS0nlXBbbQy+S ijwzLSvdOCeciDnYqRLiHd6Q6R2uwPDf/fB1BW7zvg9pN9k2iy0raHRl3vVmwuSaT0Vfdsz5/vE rMwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_find_vma() runs the callback under the mmap lock and in an RCU section.
The pad drops both and the reference on a foreign mm, the same way out as
a return, and leaves with the r0 of the callback. With that the verifier
lets the callback of bpf_find_vma() unwind.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/task_iter.c | 21 ++++++++++++++++++---
 kernel/bpf/verifier.c  |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2ee7b3b3c10b..ae67c97fe845 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -6,6 +6,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/fs.h>
 #include <linux/filter.h>
+#include <linux/bpf_unwind.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include <linux/mm_types.h>
@@ -754,7 +755,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
 	.show_fdinfo		= bpf_iter_task_show_fdinfo,
 };
 
-BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
+BPF_CALL_x(5, noinline, bpf_find_vma, struct task_struct *, task, u64, start,
 	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
 {
 	struct mmap_unlock_irq_work *work;
@@ -762,6 +763,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	bool __maybe_unused mmput_needed = false;
 	struct mm_struct *mm;
 	int ret = -ENOENT;
+	u64 r0;
 
 	if (flags)
 		return -EINVAL;
@@ -815,8 +817,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 		 * verifier checks it as an RCU read-side critical section.
 		 */
 		rcu_read_lock();
-		callback_fn((u64)(long)task, (u64)(long)vma,
-			    (u64)(long)callback_ctx, 0, 0);
+		bpf_call_cb(callback_fn, task, vma, callback_ctx, 0, 0, r0, unwound);
 		rcu_read_unlock();
 		ret = 0;
 	}
@@ -827,6 +828,20 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 		mmput_async(mm);
 #endif
 	return ret;
+
+unwound:
+	/*
+	 * The callback left with unwind_exit, under the mmap lock and in the
+	 * RCU section. The way out is the same as after a return.
+	 */
+	rcu_read_unlock();
+	bpf_mmap_unlock_mm(work, mm);
+#ifdef CONFIG_MMU
+	if (mmput_needed)
+		mmput_async(mm);
+#endif
+	bpf_unwind_leave();
+	return r0;
 }
 
 const struct bpf_func_proto bpf_find_vma_proto = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2b72b3b32ac..3c39cc0f358a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11408,6 +11408,7 @@ static bool helper_has_cb_pad(enum bpf_func_id func_id)
 	switch (func_id) {
 	case BPF_FUNC_loop:
 	case BPF_FUNC_for_each_map_elem:
+	case BPF_FUNC_find_vma:
 		return true;
 	default:
 		return false;
-- 
2.53.0


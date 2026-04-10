Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C282218ADD
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840992; cv=none; b=qj5XtDOPcEnnF5hMbxVYDLRKVw8ss1wIQpQJzENQ7fnuFszGMAIttsoCAH+SX7LTG89i3LSjV2akFnKvXKFxIJqTkMa7IJo2l53RRJkw/9mYH+e5DWDSXbeRYd6dkj3X91dspSFq8aihGvmDRm78VNyh87b7SXI5X38HXzLmkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840992; c=relaxed/simple;
	bh=cMZlUCusS9UN4SlP1eQoEWrgWmCbMtQ3CE45PPWEdjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STiNScqyzzZmGFoeVYL5KW/lZN7p+j03CkNLm8CQpxFfVrG8G1Jm9qTg8apMySYeTdH/VHXTn4RoeVveHsL2E6bSxDwXUslbZVkAp+8ykdA8xmt618xtB7ZRLJISBEin7dA/xO/ZW8qsNJTxl59TBcw0Z0+H2i4G4O3gN0VbxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH5aunGn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH5aunGn"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43ccda008cdso1310834f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840990; x=1776445790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQvlU/uy59zfgqKffUuLI9T8gvZHlnr4DmpCr4uyCu0=;
        b=ZH5aunGnxnPDd6PhUe0Bi5pPHXhA9hvUgBkDAb0JqRrkYxsU2aoU7bbMz5Ir6PEpSz
         dKgFp1PXK0irVwMQaj8U8e/mPPOZv7nqibjzlMpq4OZyWuTXib5nERCLLif+puTkNzX0
         FWUUFP48O5R/PyisGgXL0KmYoFJ2fmCw5y6dfmfXEwE7RjrCj/2ge7LemkOFaXyk2hYy
         O6Ow9zEkx192XTe7lOl6RSyspI1cQle8GhYWg8dkC5kEA1W1JCA70swLEdLpOYmiKTys
         apU3sGJ4N+y7BmCG10ZFycVaZ+aKG4dh3yHzwgMth3XjdyKDa9DiIzHve6Sz0Jq+hvHX
         Oe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840990; x=1776445790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQvlU/uy59zfgqKffUuLI9T8gvZHlnr4DmpCr4uyCu0=;
        b=cK4RgiyIgvRaIwz4//4QR9cuRtZFWxEMfmBhTO3y7nnQyeN7miwrHdYIWN6u9ON+M3
         XB8CeI17N4wsmNINffaTqhpoqNXdqKH7KIX1o0Gov0RZnPJNqiLVHGCs2DpY/ab10Atz
         WfkQbnuQojEMNv3v2hF/Nf2ww7BJ+Nc4zmplpaWItyVLdrYI5UDJ6s7bVPFPSmDRKwMX
         hzl0seolhd4RjCu+Grz5Mc+sVoHLTihD/sqYtzpu6agCRZS+ilmvrmjkbQEBxbhnyhqk
         aasQ5ZTW7PoKO/B+iuqIJ9kZMMFfkrcPMTKUcdfsrr1ufDptTu95ghSPtxPulD6QiKHW
         ONNQ==
X-Gm-Message-State: AOJu0YzlKrsuHPxDWHfc9P3erKqmm6jMlHbqA6i2lDzNcXziL7dEauF+
	dNLvnwn6buN2LUifefxBXus7XYMKcABEeTUnwppFWMAj0drAo8WUtTMg
X-Gm-Gg: AeBDietejTdhT5No+ZuioBvtflXxzekQj/yTKPtnwngHGWroLvIWFdALVuF3Qb2cpar
	QtRVvJ8+mu60eBo9TjYDcpV+g5+d2VX0bmpfi5KUfe3bO16h4LrAFg7wXtcXroVCu0hgPUA6PWS
	85ceblZBENIuTVSZUJpiRJ75mnn0LiYb+Esm+sZ6BirVfSMhf9Q0xm1Wb6OC/sSjpnC8WLuwZ6i
	61cagsojldnhqdgLHjGw1uMV3Qu4mN46h7omT3pH3LGM0Jd8Qy/igk0dvo+K+7jnV4zUHVczFFQ
	pEElDm3ByrtwA9VUv+G0CPpR3bHICUgsk8bmNw+u3rBn64t+KoZudM9ouSloUT3gAmev3nDubAg
	nB4FgG/jxz8xJQvhdQgUk0wjUkMnMKSiOdL7z+2F5M304MnSU9OXqCICcG114zmpS4wf2gEwOJR
	IM1c0WI38npFvwNg==
X-Received: by 2002:a05:6000:4013:b0:43c:cda2:4f2a with SMTP id ffacd0b85a97d-43d6491fe1cmr5982777f8f.4.1775840989722;
        Fri, 10 Apr 2026 10:09:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm8553920f8f.30.2026.04.10.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:09:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 10 Apr 2026 10:09:30 -0700
Subject: [PATCH bpf-next v9 2/6] bpf: Add bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sleepable_tracepoints-v9-2-e719e664e84c@meta.com>
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775840982; l=2265;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=KkNATvLcJwnrptp+MEb9+MNTMcOML9sDqMZWrPNSPFI=;
 b=BJaybwqrB0U/wv9IRfaSuY/69Hxhm/qbOAtPzJ6RI3qp5B43jCr9KXRWxS/TlEN6kDYjRtULr
 MSF1NUCNqHcDGsJp07H/kfZJv8PunN8jnS/6FdAS9Q1M0G/AW0nZs8f
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_prog_run_array_sleepable() for running BPF program arrays
on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
includes per-program recursion checking for private stack safety
and hardcodes is_uprobe to false.

Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0136a108d083..4e166accab35 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3077,6 +3077,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	struct bpf_prog *prog;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret = 1;
+
+	might_fault();
+	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
+
+	if (unlikely(!array))
+		return ret;
+
+	migrate_disable();
+
+	run_ctx.is_uprobe = false;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		if (!prog->sleepable)
+			rcu_read_lock();
+
+		/* Per-prog recursion check to enable private stack. */
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			if (!prog->sleepable)
+				rcu_read_unlock();
+			item++;
+			continue;
+		}
+
+		run_ctx.bpf_cookie = item->bpf_cookie;
+		ret &= run_prog(prog, ctx);
+
+		bpf_prog_put_recursion_context(prog);
+		item++;
+
+		if (!prog->sleepable)
+			rcu_read_unlock();
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	migrate_enable();
+	return ret;
+}
+
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {

-- 
2.52.0


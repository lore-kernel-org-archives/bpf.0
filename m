Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189C274B59
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914456; cv=none; b=ue0Bl78MRkwMk58AotVPRkZkHalmahkl6kWrepz5o/8e+CACL6wtu0gcEcx1J3xB5jk6D01VjSIIrfimKAclgCTuRM5kOeGLVRWAMTXGcWb3FxYjzBpaLCTiWYtJwkOhZZ1GaEgHUWG+YPA/gdhAFH8vL2PjcaeRi1zrytE72n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914456; c=relaxed/simple;
	bh=gkF50bz90n8AIHBUNrG6ejVKz7rdoODf0Sv6P/gy+lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkyCPZSVz9fcRmgwCeNvRQfQFD/L/sRjft1p+1DiTy7Xzubod3QlEOtslbL/v+5LbxTPknvBaeWVVdcqvwSOztO7L9r/5LvlnJoD0xDjLvZLX9X/4hs/WhuVeCqCTmz6Oj4j8PkDGy67ayX440lKhAEd2bdRP3UX7ct99kgW6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi7OHMkx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi7OHMkx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c21417781so1694365a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914454; x=1770519254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4/rT8ni9uShBwCZbwHc9QvP6yGQp+8wEcnMK5KW3Fg=;
        b=Xi7OHMkxQQgPlHJEmDPVBkcvu+YN4RKjjww/4Xhu9+toebGIyNdWinbLxcF/DD629j
         ZKfn52Da6Urm5mYH/g/xeu0/yQTl4gMf/uFnS+LGRBTOAxygbHOv8bDE+gh6CKlWj1IT
         /sMs8C+uqO5Hj2S5d+IeTs70l1uKveSaqbIq+v8xY3MEw7OzZ5OSlPGozIQ4SEomHkEm
         okqgJqUyu3L+sZUg1+upBJPCVAHnlsTmxkTTaey9a6O55aDOmLTojbhnV5/+/07CiYT4
         MPIBcdDmKbOTSi9k+YUnQ6ouTpga6KE/Att0qUv5jo7W2gruk/fbSzz//MAZeDDdtV9Q
         ZaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914454; x=1770519254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s4/rT8ni9uShBwCZbwHc9QvP6yGQp+8wEcnMK5KW3Fg=;
        b=eFkMKRnNrVgn5vMY3kmRRxJnZPXLaYMruTCx6kZDilDLZpzCjQ25z/cb9d92v3s5NN
         9cIxal0YJKL6WdARjrV26SJnTbcG0H42JbxNBKolgphWC3QsQMouZZSKUQWc3DIBFGWn
         3Mqk4HBpsCZPXnQsxendI3m9WXlWOvOKLnQcHPyYIbFZZo4bVXOz51I33GYA+LqvUIJp
         ngKzLgXnPyKjSKrUYrpFaGn04NGq8gTT1o+uHlKtQ4b+/6XGeAizlQnNGV2scSdC0AHj
         yWkgP2aKRLvb9NtHc7gFgKKu4hIG6svZKvdi1clRTSuJqmFU18gtx4izVXu8zTotg2CO
         Z+2w==
X-Gm-Message-State: AOJu0YxLV/IS0ZEp7bcu2E742C/RwmM/mSQ1mJEviIgSeMa0xh+qvITZ
	f2/oqFru6bMRL87F7lf1BfdmjW3FA4gevMkH9IgQtfC91fJW8y+A+u976mPFAA==
X-Gm-Gg: AZuq6aJLRdLjBhKceuogcy8CbZLAWKjEot6/5k1UrbXw69u1izZYYs21yKZ6y4zjVAx
	Oq54hEkrunppmCz+c3YzhOyVOjAoVojWiXmzdvJGQI8GCEhnYA6dTFkq0LjBQW4SO/3CICJyhdz
	v8frjagYLu35L7cR0ipcShw4lBqqfDIWuuUHvCHdDWkQOd3h/ofKjN503eESsbN07ImepC2d3vs
	i5QZ60JP+9eJgBRmdTPYfCO0vm+q4iw3voWdqa5PMnd1mxUqeICx8dN+mMTZr5Gf/4xPsQzRApB
	/CeqMbylKAwsGHGIuZGzHh7rFKalRSmFGjySWla4RghHG+3dhhCSGBl9DqH1yJ8KatbPEkta7li
	pKkMtmOhzgxOB0kYq8zhbR9NmbhW1Fv90gIqIml+WyC0++u77pI1mkuZc8o2ub4rZDuylEa1eBz
	GUeQIEJ4EFLrHVaWc5CjN7ejEFo/4CGG/ozcOF2bxV333WfroGVyXgZd+qPrZWQfnjpKMhphsU/
	4RNaJZCHHxk5odRiDQURn4jdts2q7HXvaJuGaBiogFiyfyGgQ==
X-Received: by 2002:a17:90b:3bc6:b0:34a:47d0:9a82 with SMTP id 98e67ed59e1d1-3543b3d65c9mr8067862a91.23.1769914453903;
        Sat, 31 Jan 2026 18:54:13 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24ccsm15522112a91.8.2026.01.31.18.54.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 3/9] bpf: Introduce bpf_timer_cancel_async() kfunc
Date: Sat, 31 Jan 2026 18:53:57 -0800
Message-ID: <20260201025403.66625-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce bpf_timer_cancel_async() that wraps hrtimer_try_to_cancel()
and executes it either synchronously or defers to irq_work.

Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2eb262d52232..2ea0c08f5ef4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4426,6 +4426,53 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+/**
+ * bpf_timer_cancel_async - try to deactivate a timer
+ * @timer:	bpf_timer to stop
+ *
+ * Returns:
+ *
+ *  *  0 when the timer was not active
+ *  *  1 when the timer was active
+ *  * -1 when the timer is currently executing the callback function and
+ *       cannot be stopped
+ *  * -ECANCELED when the timer will be cancelled asynchronously
+ *  * -ENOMEM when out of memory
+ *  * -EINVAL when the timer was not initialized
+ *  * -ENOENT when this kfunc is racing with timer deletion
+ */
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_kern *async = (void *)timer;
+	struct bpf_async_cb *cb;
+	int ret;
+
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	/*
+	 * Unlike hrtimer_start() it's ok to synchronously call
+	 * hrtimer_try_to_cancel() when refcnt reached zero, but deferring to
+	 * irq_work is not, since irq callback may execute after RCU GP and
+	 * cb could be freed at that time. Check for refcnt zero for
+	 * consistency.
+	 */
+	if (!refcount_inc_not_zero(&cb->refcnt))
+		return -ENOENT;
+
+	if (!in_hardirq()) {
+		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
+
+		ret = hrtimer_try_to_cancel(&t->timer);
+		bpf_async_refcount_put(cb);
+		return ret;
+	} else {
+		ret = bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+		return ret ? ret : -ECANCELED;
+	}
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4608,6 +4655,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.47.3


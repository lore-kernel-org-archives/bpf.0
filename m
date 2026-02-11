Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A109346A0A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833573; cv=none; b=vAZUA+Ih7Llf4PtuGezTmIBrBX0zg5/q2EnV/iri+O31smJPBsuDbBWGp1JjS5b9wR+KpvHcvJ6fqzqLH+9J/KN83jDMD/03evvAKRsF88W2e4wxhhoKuI2Tcwc5wj9Rvc6Zp4dxQhlDAHgBwo+i0D6OtoyPEIduhPCm/T3mkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833573; c=relaxed/simple;
	bh=x2sbND/j0tPQKkynjYI6nbzU2ehJAO43GVI/dZLBSMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK+3sHbUSV2G1A0OphEa4xNHs9XURxz2RBQHNC98m8ISAlp1fWBXeNDAXc1w4hVVuFZ12GTQwuBdLEtP2hk//g5ZS83sW1cWAthxdDKJNts/KRJYS+A0divNwn0pExjgVWiV+ZngJBxwgQf7jxlMi47IR5EN5C/H4RNb0nXQI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRCad7nD; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRCad7nD"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-460f3f9fdb1so796822b6e.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833571; x=1771438371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxDdvjnGHno7eZfVF/Lv2e/xCApsCsIdvzVno6nsjaI=;
        b=bRCad7nDLK+uM47GoqPp/lc8FjdLuYJ6wqZGX73BxUmNNB2IUC9thXnONCbJrYzWsd
         TXmPPzl3kFCbguA3QzDfscxaFgxUBv18WWAz/RbRdJ8HamFOEzDQN/MakOUQZZk59gAb
         1lULz0i1zRWTL6OFRuUqhk8z2JUYkn/36ANu5fiq14UMTa/PJFaDT4OV8n4UWfiejX4s
         HzAzRHANbVnJyJS9dn5LoPkvfmdBDFeAx5XzPI6StB7/oBGe/yzpYEUdhATnE6BH1U6A
         +ZNF4pCY1qufnxl42fI5FyhEWXnQPrnaM7pysaJgJF9ksr4Nixg1NavhycN3AcUg61BD
         aQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833571; x=1771438371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxDdvjnGHno7eZfVF/Lv2e/xCApsCsIdvzVno6nsjaI=;
        b=oe4fB9RYu2JcvoC7rQ/bZNIQ+setAFCLDEnJ68RjmgUiA67q/tvV04e3qs+zSkQmW7
         flzzZ+Alt5FmrUGYIIAe9CaT26/tRTKYO4D/u1BVI+TdW35+JalBawS+PExtlPvrGAYH
         WsGYPLTvQFTZuIqXCYSrTJx48pOa/wDwbp6UY3VdIknjA4elNpS1igucdZe1tW1l0UH+
         BO/sRkdxl9C2CX5qIDHSbrOdOwVqi3NvMmFGx4j+pt/YJAu1YG1ywsXbWv1/5qfE7rkx
         IO4LCZKBzkvUOaI5i26V3dpmspn4T54USkBmc3X2x3VA2d3djch/IHeY7wCJpsorpB57
         czuA==
X-Gm-Message-State: AOJu0YwMP0io6NUz2EGVIaT+NGcGRPiUUPK7IMc6u4yGzE/HytXIkcGS
	5Lcg4i1rTrO1Rm7g0hIuB/H/KTY0SwRydPc5LIHc3aZIZHWDuwolgClFKoS0dxMZ
X-Gm-Gg: AZuq6aKXfF9va0d8siLRyNpMBoF8o2TEvuJUUPGhHw90BRfx2iwWZ9yVJ3hHyAtjFaW
	XgxRQgGO9ThUvu9pIrp4EFdex2JiEFq7RnQQX/OWKrJjGji2erg/GAEjawCym/Ht8r2NH+akgIi
	I9zKbjq3h6tFH0t/G/55op5wLmlHmA0Uvl2XDwrdee+kKudGOMwWgWbjeN6fi8k7Ui+FalnZY4x
	mlhTx1PhG44z3t5B+ma7H67/KdFI1NQQj7yDM6RkahUZBw0qaQIZ+eiFnuNyf72J7xMDcoi/p8g
	hqSHMfkUpHnoqOyx/2z0VGph1gGJI3DGifIsqEClzCWeg1JbeSzFvW1olFI0Q6HVCcxeuzooH/w
	hQe3omxIELCn7/s+XGfMKGc2wHSP9rWT9FlTd2nFItxmKw+ITuWpia3NLyz6MHHROFsi0YzJK15
	MgV+agNEcTc3n52c6CYrhbdDvWYK6V+TfDH1tH7lG7QJPn
X-Received: by 2002:a05:6808:168a:b0:45e:fff5:89b4 with SMTP id 5614622812f47-463520d9509mr3730228b6e.10.1770833570878;
        Wed, 11 Feb 2026 10:12:50 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636b065d5csm1379587b6e.13.2026.02.11.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 1/6] bpf: Support repeat, duration fields for syscall prog runs
Date: Wed, 11 Feb 2026 10:12:41 -0800
Message-ID: <20260211181248.3040142-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211181248.3040142-1-memxor@gmail.com>
References: <20260211181248.3040142-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5009; h=from:subject; bh=x2sbND/j0tPQKkynjYI6nbzU2ehJAO43GVI/dZLBSMc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUexpLWfh7MTsJmtNjllsyfN7I3ZRGdFnAiQWxu Gno7sgiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHgAKCRBM4MiGSL8RyjTFD/ wO+vtEtj80s6lRUEDEzsNj5tgukbPW60UGkcgKndZvQBap/vKE50YKOUZBN7xiG5vm8yEQzg+unNz1 S/89sVmRvkWJc18AmmqwkAqwWlAtZZRIBMXxOpkveFI/1phol5FiICJbLVfHtW1xUREQMMPDlsmQqM cYdbY3AOmlgnc83G7cQ6sshczsHg2F/uCOl2gOgfaSXmp2w3GnAYAeiBusMZgIEZc068zIJ36iw7AR 1NCkpeZGMynTHdh5O3JU1bvhE4t8fI3kSHfipU/WhCmJOKLXNPpsFibDuTlkO9GfSdGzW0QfP56Kbq NDCviPoM7LAAS8CgMOVLIbPcPhEw7KBFS24jTSbom6wo8sUoJEqJKg8d4QYKPHWqhdgDH+cS2v9+21 eCOE4gu13AUhh8iCngNBj+5JfyYrf8mOTxJ7Qv/FkXhPUtDiWiRiaoiaxmPVIa84Mjf5swnTJlj63a WGRXFZTUmEY/YaE04G19tfTQZVPMnqbYxcnVViXIex+5Uq0QB+Ru8c3SA6ztbUjgC9cK6NLBVhenM+ HZRiTkEfXVG8tNacf2b7OinozN/mldWQZ6sh5nxlr/EC7C4NtqC6gnsFyuLnzrZZkYx/3tQngp+3Gz RGiE0imJ6XV6GDCeGM4ij2VE4kXEHkYQ7yaRta38k6BUlDpE/mLowRdLJg0Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, BPF syscall programs do not support specifying the repeat
field to repeat the test inside the kernel multiple times. Use the
test_timer infra for other prog run tests and make it with RCU tasks
trace to allow usage for syscall programs. Also make the duration field
available for use.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c | 92 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..4e06e516d9f2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -33,23 +33,27 @@ struct bpf_test_timer {
 	u64 time_start, time_spent;
 };
 
-static void bpf_test_timer_enter(struct bpf_test_timer *t)
-	__acquires(rcu)
+static void __bpf_test_timer_enter(struct bpf_test_timer *t, bool trace)
 {
-	rcu_read_lock_dont_migrate();
+	if (trace)
+		rcu_read_lock_trace();
+	else
+		rcu_read_lock_dont_migrate();
 	t->time_start = ktime_get_ns();
 }
 
-static void bpf_test_timer_leave(struct bpf_test_timer *t)
-	__releases(rcu)
+static void __bpf_test_timer_leave(struct bpf_test_timer *t, bool trace)
 {
 	t->time_start = 0;
-	rcu_read_unlock_migrate();
+	if (trace)
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock_migrate();
 }
 
-static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
-				    u32 repeat, int *err, u32 *duration)
-	__must_hold(rcu)
+static bool __bpf_test_timer_continue(struct bpf_test_timer *t,
+				      int iterations, u32 repeat,
+				      int *err, u32 *duration, bool trace)
 {
 	t->i += iterations;
 	if (t->i >= repeat) {
@@ -70,9 +74,9 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
 	if (need_resched()) {
 		/* During iteration: we need to reschedule between runs. */
 		t->time_spent += ktime_get_ns() - t->time_start;
-		bpf_test_timer_leave(t);
+		__bpf_test_timer_leave(t, trace);
 		cond_resched();
-		bpf_test_timer_enter(t);
+		__bpf_test_timer_enter(t, trace);
 	}
 
 	/* Do another round. */
@@ -83,6 +87,45 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
 	return false;
 }
 
+static void bpf_test_timer_enter(struct bpf_test_timer *t)
+	__acquires(rcu)
+{
+	__bpf_test_timer_enter(t, false);
+}
+
+static void bpf_test_timer_leave(struct bpf_test_timer *t)
+	__releases(rcu)
+{
+	__bpf_test_timer_leave(t, false);
+}
+
+static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
+				    u32 repeat, int *err, u32 *duration)
+	__must_hold(rcu)
+{
+	return __bpf_test_timer_continue(t, iterations, repeat, err, duration, false);
+}
+
+static void bpf_test_timer_enter_trace(struct bpf_test_timer *t)
+	__acquires(rcu_trace)
+{
+	__bpf_test_timer_enter(t, true);
+}
+
+static void bpf_test_timer_leave_trace(struct bpf_test_timer *t)
+	__releases(rcu_trace)
+{
+	__bpf_test_timer_leave(t, true);
+}
+
+static bool bpf_test_timer_continue_trace(struct bpf_test_timer *t,
+					  int iterations, u32 repeat,
+					  int *err, u32 *duration)
+	__must_hold(rcu_trace)
+{
+	return __bpf_test_timer_continue(t, iterations, repeat, err, duration, true);
+}
+
 /* We put this struct at the head of each page with a context and frame
  * initialised when the page is allocated, so we don't have to do this on each
  * repetition of the test run.
@@ -1615,14 +1658,14 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 {
 	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
 	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	struct bpf_test_timer t = {};
+	u32 retval, duration, repeat;
 	void *ctx = NULL;
-	u32 retval;
 	int err = 0;
 
-	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
+	/* doesn't support data_in/out, ctx_out, or flags */
 	if (kattr->test.data_in || kattr->test.data_out ||
-	    kattr->test.ctx_out || kattr->test.duration ||
-	    kattr->test.repeat || kattr->test.flags ||
+	    kattr->test.ctx_out || kattr->test.flags ||
 	    kattr->test.batch_size)
 		return -EINVAL;
 
@@ -1636,14 +1679,27 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			return PTR_ERR(ctx);
 	}
 
-	rcu_read_lock_trace();
-	retval = bpf_prog_run_pin_on_cpu(prog, ctx);
-	rcu_read_unlock_trace();
+	repeat = kattr->test.repeat;
+	if (!repeat)
+		repeat = 1;
+
+	bpf_test_timer_enter_trace(&t);
+	do {
+		retval = bpf_prog_run_pin_on_cpu(prog, ctx);
+	} while (bpf_test_timer_continue_trace(&t, 1, repeat, &err, &duration));
+	bpf_test_timer_leave_trace(&t);
+
+	if (err)
+		goto out;
 
 	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
 		err = -EFAULT;
 		goto out;
 	}
+	if (copy_to_user(&uattr->test.duration, &duration, sizeof(duration))) {
+		err = -EFAULT;
+		goto out;
+	}
 	if (ctx_size_in)
 		if (copy_to_user(ctx_in, ctx, ctx_size_in))
 			err = -EFAULT;
-- 
2.47.3


Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BA426681
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971297; cv=none; b=h7LlgOdrVeyvuW+O7+FGNEEJ3JGb5bIPjBOrFoR5pbp4v9XdDVvyKG8u1pyQfNvK3R7TGxEsmCBUyJBwIRU5IJ7T+zycq67QWj9U24qpN+/muYpNPATBVYSOpkpwHkqjlqo2eKbs/15kd6WTagnFl/jug1ocAKH9yGFnYbKQzdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971297; c=relaxed/simple;
	bh=QKH00JljZrlMfVod10pqmeNjUeUmhefNzONLwQdWIy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DR7KNgu0PzfgkAnq1viIN38V7HOo3LNCChpR0eNosbGk38I41Rt92DzAV1y4lb6OuNtFExakCljYwzOn7MDAdTkfM+vNuigmfECL0aQKXZ9UTvict/cBCeg5nqA0EoRGwNSp9lj3coQ/WvFopW0e6eRvpK5Cdqm+Ky2IolGV+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZiqyRw6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZiqyRw6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso4877568eec.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971293; x=1775576093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQA/UKYBuXcCvugMU5yRxI2SsSzVyoeHKW9NqHrZ5UA=;
        b=aZiqyRw694GKSHlKvQISz4LUFSWoy2YiR8D9kfutO79W9rFfui+PfshZKv+ADZ9pNV
         B7I5sHTP2uLb00d1Mvgt9d3JZpAsNGRWmyKwZ1lv9Ukl/eIrKor70PvOXSXIb6KbSKYd
         6HjXjY6dmoA9dtu9YxlgVPKpYi0ajC9Xn6+ACI8Vi7IWKROHr0xuWmt5CaQEQeXU/BG6
         lqJZgdk7L+qNe9IpyuGLWSJQDWKrUi0rJdLN7cf+n9VzoditU1FRN40cqkE/pRkkvxJY
         W10s+yhE3bUdqwX8A2w56of9gWdITdeecirF98YjT7nN76VcGCniS+0Kf+1ZgHkKTnDE
         QS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971293; x=1775576093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQA/UKYBuXcCvugMU5yRxI2SsSzVyoeHKW9NqHrZ5UA=;
        b=EyyMM0ssMHsaXQlWajrZ8VSNg7Mw0zgZFl4FM9i9+vp454FblPsH3CGghpt9fHui86
         PBqtXxkhnd0mjWOdJxoTMi67gRvJA3cuzsTBn58mwrTmo1223cTY1vDagNcZjiYd2SCS
         BHhnyX+ur0hOVuwzchSedwQpvf1u7tJGNfAy9MCNSSc/Baw6MPhStsX8Mog5t8ui8uXO
         lYBxFKBHtVKY4SGJl/hiAtZnHzvpeIrRw/ieAA2Q7dXg1giUyAQqxLxrEX5yEG/t0WLi
         MPYROAbP446hb2I6I6VrYpaIoOONlOMznwM2vnjF3EW4fLWq8Xcw1c7Z9J8FLhCxsPch
         plyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6n6UVTOhGrwOgQp/bW95OjrFwMaGBUfjN15BajEC/WNw5rSSFmdF97Tg6jOVNs+oP+eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvWSqXA/VO1+3u5Hwy+33KGo8Sz7RGOslFz60ClbGIPe9IQSd
	rTtE2aZH6EveRR57ab+UZY1N2ieoVL+T6TMlWVJ/xNBDXzagB2OufFNE9RSImBvg89aR8Tz+8Wr
	ig5odTM6FRXZb8A==
X-Received: from dyr23.prod.google.com ([2002:a05:693c:4017:b0:2be:6911:c4f2])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:da0b:b0:2c3:b172:83c2 with SMTP id 5a478bee46e88-2c3b1728c62mr5463093eec.20.1774971292418;
 Tue, 31 Mar 2026 08:34:52 -0700 (PDT)
Date: Tue, 31 Mar 2026 08:34:10 -0700
In-Reply-To: <20260331153413.2469218-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331153413.2469218-2-wusamuel@google.com>
Subject: [PATCH v3 1/2] PM: wakeup: Add kfuncs to traverse over wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Iterating through wakeup sources via sysfs or debugfs can be inefficient
or restricted. Introduce BPF kfuncs to allow high-performance and safe
in-kernel traversal of the wakeup_sources list.

The new kfuncs include:
- bpf_wakeup_sources_get_head() to obtain the list head.
- bpf_wakeup_sources_read_lock/unlock() to manage the SRCU lock.

For verifier safety, the underlying SRCU index is wrapped in an opaque
'struct bpf_ws_lock' pointer. This enables the use of KF_ACQUIRE and
KF_RELEASE flags, allowing the BPF verifier to strictly enforce paired
lock/unlock cycles and prevent resource leaks.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/power.h  |  7 ++++
 drivers/base/power/wakeup.c | 72 +++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 922ed457db19..8823aceeac8b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -168,3 +168,10 @@ static inline void device_pm_init(struct device *dev)
 	device_pm_sleep_init(dev);
 	pm_runtime_init(dev);
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+struct bpf_ws_lock { };
+struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void);
+void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock);
+void *bpf_wakeup_sources_get_head(void);
+#endif
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index b8e48a023bf0..8eda7d35d9cc 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1168,11 +1168,79 @@ static const struct file_operations wakeup_sources_stats_fops = {
 	.release = seq_release_private,
 };
 
-static int __init wakeup_sources_debugfs_init(void)
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/btf.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_wakeup_sources_read_lock - Acquire the SRCU lock for wakeup sources
+ *
+ * The underlying SRCU lock returns an integer index. However, the BPF verifier
+ * requires a pointer (PTR_TO_BTF_ID) to strictly track the state of acquired
+ * resources using KF_ACQUIRE and KF_RELEASE semantics. We use an opaque
+ * structure pointer (struct bpf_ws_lock *) to satisfy the verifier while
+ * safely encoding the integer index within the pointer address itself.
+ *
+ * Return: An opaque pointer encoding the SRCU lock index + 1 (to avoid NULL).
+ */
+__bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
+{
+	return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
+}
+
+/**
+ * bpf_wakeup_sources_read_unlock - Release the SRCU lock for wakeup sources
+ * @lock: The opaque pointer returned by bpf_wakeup_sources_read_lock()
+ *
+ * The BPF verifier guarantees that @lock is a valid, unreleased pointer from
+ * the acquire function. We decode the pointer back into the integer SRCU index
+ * by subtracting 1 and release the lock.
+ */
+__bpf_kfunc void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock)
+{
+	wakeup_sources_read_unlock((int)(long)lock - 1);
+}
+
+/**
+ * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
+ *
+ * Return: The head of the wakeup sources list.
+ */
+__bpf_kfunc void *bpf_wakeup_sources_get_head(void)
+{
+	return &wakeup_sources;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(wakeup_source_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_get_head)
+BTF_KFUNCS_END(wakeup_source_kfunc_ids)
+
+static const struct btf_kfunc_id_set wakeup_source_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &wakeup_source_kfunc_ids,
+};
+
+static void __init wakeup_sources_bpf_init(void)
+{
+	if (register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &wakeup_source_kfunc_set))
+		pm_pr_dbg("Wakeup: failed to register BTF kfuncs\n");
+}
+#else
+static inline void wakeup_sources_bpf_init(void) {}
+#endif /* CONFIG_BPF_SYSCALL */
+
+static int __init wakeup_sources_init(void)
 {
 	debugfs_create_file("wakeup_sources", 0444, NULL, NULL,
 			    &wakeup_sources_stats_fops);
+	wakeup_sources_bpf_init();
+
 	return 0;
 }
 
-postcore_initcall(wakeup_sources_debugfs_init);
+postcore_initcall(wakeup_sources_init);
-- 
2.53.0.1018.g2bb0e51243-goog


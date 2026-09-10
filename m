Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCC492E43
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050075; cv=none; b=X6TdZ3XPmaIQPDU/AkunDAUXqE0Gej2MXzk3hHMM0hFoQ0kzv+KqdWhNhZ1S8n+9Zu70dc+i0Xf+6+FsAxbx+bXpCiYd8O2F80kfm3zfifMzxze3ZCTRpFa5YNVQVvt0Z7tpC4nLbvWfI3AjfahLqt72V/cyqaypbufX8MvNo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050075; c=relaxed/simple;
	bh=fuaw0BI6lnzMc/Dnj95Nj2q+FpOFFbThhctzS3R3gQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4H7RM4wbkBrEkyc6oNKRbPlje+rCbWYAewxe1Wkwr5kQplBP6FzZw4pHlgEAQMo8JrtRY6B04S3/1FhqDCMYbaW8/kLvAAINAs/xThXJhESm8hrMO+1/W01ASirCN//JbhTQrgL+SoN02neylz8DOqGIx6gutZwvSrOzYaXwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fnPEEgX/; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fnPEEgX/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1ECkcAPUO6+34HyFwaFCqaf/P+ldwgFRmed5KD6bthY=; b=fnPEEgX/xo6MvaHDnLDTRvAkMA
	FEo5hfiakvDbt8tgLeh39zYi9BVqU4W0dYpU1kmWt2buWxK6rbcwcT3jPL5GrQMkrcPk07c/iZUA8
	IOyZYEYIFxMyYlGGW4FaQJcgGXht41hWUPkEuMkOp4axNnhcOFLgzR9QCoi1zd3fR8lhp1Bz7DX5J
	wzn/7LguvhngE/MXuQ9rOW/N9C5iFmXZP+vO5vbznC0xmusBSN+4WnDvzuNqheWcy1FQorUyg0k0B
	bsoVWiDPETK9Z/HgbAkD5NID1/Op8si2rM/SZmgT5RT0GCmoqMj4sktE3NgdqFknjbAc0NNjnrLn5
	PKjg7qBQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4feG-000Gls-2z;
	Thu, 10 Sep 2026 16:21:09 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 2/4] bpf: Require CAP_PERFMON for kfuncs reading memory
Date: Thu, 10 Sep 2026 16:21:05 +0200
Message-ID: <20260910142107.40582-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910142107.40582-1-daniel@iogearbox.net>
References: <20260910142107.40582-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

Mark fault-safe probe reading kfuncs as KF_PERFMON, similarly as we do for
the old-style BPF helper equivalents. bpf_rdonly_cast() is included in this
list as well as it returns PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED for an
unchecked object and is using fault-safe BPF_PROBE_MEM.

Note that only the void form of bpf_rdonly_cast() produced a register that
was readable without CAP_PERFMON. For a struct type id the kfunc returns
PTR_TO_BTF_ID | PTR_UNTRUSTED, whose dereference has always been gated in
check_ptr_to_btf_access(). The flag is not conditional on the type id, so
for the latter it only moves the rejection from the dereference to the call
itself, which is the better place to report it anyway.

The bpf_stream_vprintk() and bpf_stream_print_stack() kfuncs are marked
as well. The former ends up in the same bpf_bprintf_prepare() as the
bpf_snprintf() helper, where %pks, %pus and %pI4 read through a program-
supplied address and %pB resolves one into a symbol. The latter walks the
stack and prints each instruction pointer via %pS.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Fixes: 19559e844184 ("bpf: add bpf_strcasecmp kfunc")
Fixes: b5b693f73589 ("bpf: add bpf_strcasestr,bpf_strncasestr kfuncs")
Fixes: 1dc669646762 ("bpf: add bpf_strncasecmp kfunc")
Fixes: 63328bb23f26 ("bpf: Add bpf_stream_print_stack stack dumping kfunc")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/helpers.c | 58 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..8a0eeb4f6236 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4883,7 +4883,7 @@ BTF_ID(func, bpf_cgroup_release_dtor)
 
 BTF_KFUNCS_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
-BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
@@ -4920,11 +4920,11 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_ID_FLAGS(func, bpf_preempt_disable)
 BTF_ID_FLAGS(func, bpf_preempt_enable)
-BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
@@ -4932,14 +4932,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
 #ifdef CONFIG_BPF_EVENTS
-BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
-BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
-BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
-BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
-BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr, KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr, KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr, KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr, KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_PERFMON)
 #endif
 #ifdef CONFIG_DMA_SHARED_BUFFER
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
@@ -4947,26 +4947,26 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
-BTF_ID_FLAGS(func, bpf_strcmp);
-BTF_ID_FLAGS(func, bpf_strcasecmp);
-BTF_ID_FLAGS(func, bpf_strncasecmp);
-BTF_ID_FLAGS(func, bpf_strchr);
-BTF_ID_FLAGS(func, bpf_strchrnul);
-BTF_ID_FLAGS(func, bpf_strnchr);
-BTF_ID_FLAGS(func, bpf_strrchr);
-BTF_ID_FLAGS(func, bpf_strlen);
-BTF_ID_FLAGS(func, bpf_strnlen);
-BTF_ID_FLAGS(func, bpf_strspn);
-BTF_ID_FLAGS(func, bpf_strcspn);
-BTF_ID_FLAGS(func, bpf_strstr);
-BTF_ID_FLAGS(func, bpf_strcasestr);
-BTF_ID_FLAGS(func, bpf_strnstr);
-BTF_ID_FLAGS(func, bpf_strncasestr);
+BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strcasecmp, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strncasecmp, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strchr, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strchrnul, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strnchr, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strrchr, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strlen, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strnlen, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strspn, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strcspn, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strstr, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strcasestr, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strnstr, KF_PERFMON);
+BTF_ID_FLAGS(func, bpf_strncasestr, KF_PERFMON);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
-BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270492;
	b=bf3mmtjCn9vmw0PBNKZGPN9MWjwDzzL0Nr5G7Db0KmB1pvZ4YX5q9BKb1k3aURzfatlS
	 6znsUT4I8bDc8aPAaTMvlwivEDYYDHoRrGNcX45EEK0aBXD4rwUFbEZS169Pyi9RTq1oz
	 egpGLWdRnnZtBDV2gFqazPQLkfozKep6y/6LYG8WYhI2MLP7TTL7agp3dZK/dJzAP4HdF
	 a5TLGiSGEr8tEugMN/tnAK1jkR0DAadn5XU+yg4CsZ9CoEk9dOt5NJKVGJYFpEzYJK1lE
	 NyrtHy0vuCwDxufo+SjRAIfBeYjmCtMdwC22J9Qiu9hYfFwK6QhxKZQtqr8E4MqnYbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=81wYGxU+CcpGkNwdfrLjfdz4HVcNFzDgxGlIymd69G4=;
	b=yYqJn5ZkbTjSdRjKFxuEQS0Zdq30xV2c5kX1H/OHepkmi21Go9LBTtnfOWpkWbSlhaUn
	 Ti3cQTvK+LzEX9ahfW5ktlG3B+0mEDCBlsuDeQ4yyykEzXSQDNGqvyKthjjYcc2A9odZp
	 nnyyBMQrGm7jq4p0tFn9zE2bk3NdLED30vi7du0BLU0A+d37403fMpvnyxVJG0n44MbWe
	 StRPLcK+ipFW5KNM50ck3VndikfRf+btBWM8ZPQY1ZsgAJpYyyihRUvUj8vn2hDacgunx
	 /zRroF2kIOPetlQ9LiT2Tfkj8wklUmWGHV9QgsKavq3zu00Da12KURm04geIIBXraZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hInFFpnB;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73F606A326
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC73F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hInFFpnB
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4912e5f330dso687440f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270490; x=1794875290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81wYGxU+CcpGkNwdfrLjfdz4HVcNFzDgxGlIymd69G4=;
        b=hInFFpnBC3A4nkZPazQypbDumVqRQCeA37evxud+9g0hwf0W+5gkMQCVMo9WY2hu8f
         qvoo5HT0AFPLCO2k4HE4QTalLJf29P1BKQz/7m2sSBjX1ti15Pz4VCS0MXtBzMhDYGxD
         9eoFzw8wlL5fr4y4nIClj12hUS78m7QQlxfP4oKlDIMjFordsqXG53ULaAA9u9Ox6YYk
         CfTIPoAuDcdOueJCT/NgYSf6EaMUlhzxZoGaklxOy3zle7hnSVe3vYYR0/q7++0YY/DQ
         rou9Uuu1lCsgRVZQ21oohiuVMATotylQRaCMokJ9QBunG3bvolQJIeK+xQsEI5J3p5H3
         icuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270490; x=1794875290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81wYGxU+CcpGkNwdfrLjfdz4HVcNFzDgxGlIymd69G4=;
        b=c/sv0td53z6Zf8YDSTORePCMag7Zj7bZi0ta6yHUIE7BDFXrOLTOBGK4kzAKQSefXa
         Y2iRs60Ijk4J+UuQ2bTICgx2PcqRkBq+WQlnuPZTDFPkDYsiiv58/TmmM/sF1fy66aq/
         9kFh1moOrCf/2KQv8GHSpoLUv/o8UFnX1IAX9rimtGfZntRiuV1st6OgR4KIZD1+UZJS
         WUCBoSvgR5d/2p+3f8jAKbkLFQGkBg02mAuCYlKOomA/2kp0Y4ZCZkuE5camhwofKD1S
         7W43x/nNXRCqSEqF/jTSamXDDiWign5HKH23yS0CchX+VuKpKCXw10mJ8y2f2KH+9DHx
         bM2w==
X-Gm-Message-State: APuU4Z8tZ78mSTiSd9QzqdwsbUCI87RGI+b4MnZ1II+RDzdmu5dLNhDI
	q5DrNmfLl3gQTqMfsxQzF2ms0L9MH/nFd6+GdNvqfLFqvyEbAkkmYyWQoAeD2f6a
X-Gm-Gg: AYBFou3hbC11vzsrumAaHzHvR0VZCoCFJ4KhWApX+Gjme/g2Ikn99NJdoyWqqZmouSb
	sF7frh5FMjazINnGTxodqfIDa52wT1nn68hnLy9m2eYeuE6Cb1UR6oQ8pGtJDrgS0OFuYXaS0/C
	7RRa3v/hx7e6yTntzVublJ+M0dZ+Qb4/iTii4l5qON0z+so7VJSPEUTZeu2u7QOq0/SSXpmU666
	oLSNIa23WgTUmqOIPkwarj5d+U8el8RRQxgTAuoPiSpQIFL0PE5oOewRFn1NB97N9y7TnusdQCk
	nreO0LKJaGj/mMPPqu+u83F0tnIeA8P/2jqMUR7oc6HmGzwshkIRnKm7IUtnCnI+eoyTC+4WDj8
	+acvzrd5itno0madz/HssVYtrFNFGZHUwuKQMoa9O6JzpW8R3EYmsBV4tkD4a7RIYisPywEwdHa
	9vpwirrvOVSo9mC8SBXKuCenzONalT2QlnOceBZa4McvOvFhsTy4+SCVS9SDDZ3DTB6AlRDgPg6
	xrOrS4zxfagHq/iM3HJqMo5xCE1BX1Lv9aqj3oydI/Tpan/GDEm6L5147vOj3KlGxnu+tNWsmVA
	3KfH0IDskATIGrIePwae05m5wR1Q+nmoY0SOpXle2lKk5vFIGNVm/boKPl7U6QW7Nvys0wmsU/X
	AQuFPRFpQxEEOhq19L6Rq2OFgGl1SOWFtF1BsqbTnVr5mLBaxWuBmR/N1bQD7wv3ti/OQzA==
X-Received: by 2002:a05:6000:3102:b0:48f:fcac:a5e2 with SMTP id ffacd0b85a97d-498303f151bmr1709820f8f.38.1794270490236;
        Mon, 09 Nov 2026 16:28:10 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c4e07sm1643551f8f.49.2026.11.09.16.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:09 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/20] bpf: Add bpf_kthread_attach_cgroup() to place a BPF kthread in a cgroup
Date: Tue, 10 Nov 2026 01:27:35 +0100
Message-ID: <ad0973be4a5c323bbdeeafb33c7c88ee15e5caf0.1794269507.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10887; i=memxor@gmail.com; h=from:subject:message-id; bh=ehqWIF9VCWKmY+kET7zMEqhVWwlK4QHZDHYu42QHvys=; b=kA0DAAoWRy03e2NUL4MByyZiAGryYUfIyvKHeJSvtZOAWIaKOnMG2dGKxYh09pdk44QbH8kHW Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmryYUcACgkQRy03e2NUL4PVyAD9EFD6 YTz/CcFekFteRs7EmDfY6fPSIMgCsa5uTyQFmm0BAIrsrn1V9eZ3NComNdyQy4XS5iET5ysVxpq kem3QRBoJ
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A BPF kthread runs in the root cgroup, as every kernel thread does, so
whatever it does is accounted to nobody. A pool of reclaim workers that
serves one memory cgroup each, or a thread that does a container's work
on its behalf, should have its CPU time and the pressure it causes
charged to the cgroup it works for, and should run within that cgroup's
cpuset. The program can read the thread's PID and leave the
placement to user space, but the thread then runs unplaced until a round
trip through user space completes, and a program that creates threads
as its load demands has no user space thread waiting for each one.

Add bpf_kthread_attach_cgroup(), which moves the thread into a cgroup
the program names, usually one it got from bpf_cgroup_from_id(). The
cgroup core gains cgroup_attach_kthread() for it, which is what writing
the thread's PID to cgroup.procs does once the permission check, which
the program's privilege covers, is left out: it takes cgroup_mutex,
cpus_read_lock() and the threadgroup rwsem, the moved process's own
under favordynmods as cgroup.procs does, refuses a dying cgroup and one
that cannot host processes on the default hierarchy, and migrates the
thread as a thread group of one. The thread then counts as a member of
the cgroup, which
cannot be removed until the thread leaves or exits; a program that
places threads in cgroups it does not own has to stop them when the
cgroup's owner wants it gone, which is why the move is a separate call
and not a parameter of the creation. A cpuset applies its CPUs when the
thread joins, so a bind has to follow the move.

The move does not make the thread a user task. Kernel memory it
allocates is still charged to no memory cgroup, and it is not frozen
with the cgroup, which then never reports frozen, as with any kernel
thread in a cgroup.

A running thread joins a cpuset at its next park, and the move waits for
that under cgroup_mutex, cpus_read_lock() and the threadgroup rwsem, so
it runs with migration enabled, as the stop and the bind do. Pinned, it
could wait for a thread that is itself waiting for the caller to enable
migration, through a cpuset writer or through a stop, and a thread on a
CPU going offline could wait for cpus_read_lock() while the offline
waits for the thread to enable migration; migratable, the caller
satisfies whatever waits for it and the move completes. The core helper
refuses what
cgroup_procs_write_start() refuses, a task that may not migrate between
cgroups or that has PF_NO_SETAFFINITY, and leaves a thread whose
callback has returned where it is, as cgroup.procs leaves an exiting
task.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/cgroup.h |  3 +++
 kernel/bpf/kthread.c   | 56 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  |  9 ++++++-
 kernel/cgroup/cgroup.c | 45 +++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2afb4cb2bb4f..f649973801f4 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -158,6 +158,7 @@ struct cgroup *cgroup_v1v2_get_from_fd(int fd);
 bool cgroup1_ssid_disabled(int ssid);
 
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *);
+int cgroup_attach_kthread(struct cgroup *dst_cgrp, struct task_struct *task);
 int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
@@ -804,6 +805,8 @@ static inline void cgroup_lock(void) {}
 static inline void cgroup_unlock(void) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
 					 struct task_struct *t) { return 0; }
+static inline int cgroup_attach_kthread(struct cgroup *dst_cgrp,
+					struct task_struct *task) { return -ENODEV; }
 static inline int cgroupstats_build(struct cgroupstats *stats,
 				    struct dentry *dentry) { return -EINVAL; }
 
diff --git a/kernel/bpf/kthread.c b/kernel/bpf/kthread.c
index 444fff4bd102..d4b8110545f0 100644
--- a/kernel/bpf/kthread.c
+++ b/kernel/bpf/kthread.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/cgroup.h>
 #include <linux/cpumask.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate_trace.h>
@@ -397,6 +398,58 @@ __bpf_kfunc int bpf_kthread_bind(struct task_struct *task, u32 cpu, u64 flags)
 	return ret;
 }
 
+#ifdef CONFIG_CGROUPS
+/**
+ * bpf_kthread_attach_cgroup - Move a BPF kthread into a cgroup
+ * @task: a thread created by bpf_kthread_create()
+ * @cgrp: the cgroup to move it into
+ * @flags: must be 0
+ *
+ * Moves the thread into @cgrp, started or not, so that its CPU time and the
+ * pressure it causes are accounted to @cgrp and its affinity follows @cgrp's
+ * cpuset. Until then it runs in the root cgroup, as a kernel thread does.
+ * Kernel memory the thread allocates is still not charged to @cgrp, since
+ * the allocations of a kernel thread are charged to no memory cgroup. The
+ * thread is a member of @cgrp like any process: @cgrp cannot be removed until
+ * the thread leaves or exits, and @cgrp has to be able to host processes, so
+ * on cgroup v2 it may not have controllers enabled in its children. Like any
+ * kernel thread it is not frozen with @cgrp, which then never reports frozen.
+ * A cpuset applies its CPUs to the thread as it joins, so bind the
+ * thread with bpf_kthread_bind() afterwards, not before. A running thread
+ * joins a cpuset at its next park, and the move waits for that with
+ * migration enabled, holding cgroup_mutex meanwhile, so the caller may return
+ * on another CPU and a thread may move itself. A thread whose callback has
+ * returned but that has not been stopped is left where it is and the call
+ * reports success, as cgroup.procs does for an exiting task.
+ *
+ * Return: 0 on success, -EINVAL if @flags is not 0, -ESRCH if @task is not a
+ * BPF kthread or has been stopped, -ENODEV if @cgrp is being removed, -EBUSY
+ * or -EOPNOTSUPP if @cgrp cannot host processes, or an error of the move.
+ */
+__bpf_kfunc int bpf_kthread_attach_cgroup(struct task_struct *task, struct cgroup *cgrp,
+					  u64 flags)
+{
+	unsigned long irqflags;
+	bool found;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+	found = !!bpf_kthread_find(task);
+	raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+	if (!found)
+		return -ESRCH;
+
+	/* A running thread joins at its next park: see the comment at the top. */
+	migrate_enable();
+	ret = cgroup_attach_kthread(cgrp, task);
+	migrate_disable();
+	return ret;
+}
+#endif
+
 /**
  * bpf_kthread_stop - Stop a BPF kthread and wait for it to exit
  * @task: a thread created by bpf_kthread_create()
@@ -500,6 +553,9 @@ BTF_KFUNCS_START(bpf_kthread_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_kthread_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE | KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kthread_start, KF_RCU)
 BTF_ID_FLAGS(func, bpf_kthread_bind, KF_SLEEPABLE)
+#ifdef CONFIG_CGROUPS
+BTF_ID_FLAGS(func, bpf_kthread_attach_cgroup, KF_SLEEPABLE)
+#endif
 BTF_ID_FLAGS(func, bpf_kthread_stop, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kthread_should_stop)
 BTF_KFUNCS_END(bpf_kthread_kfunc_ids)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54fc44dd8fcc..e7769999e8c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14367,6 +14367,7 @@ enum special_kfunc_type {
 	KF_bpf_kthread_create,
 	KF_bpf_kthread_stop,
 	KF_bpf_kthread_bind,
+	KF_bpf_kthread_attach_cgroup,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_session_is_return,
@@ -14463,6 +14464,11 @@ BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_kthread_create)
 BTF_ID(func, bpf_kthread_stop)
 BTF_ID(func, bpf_kthread_bind)
+#ifdef CONFIG_CGROUPS
+BTF_ID(func, bpf_kthread_attach_cgroup)
+#else
+BTF_ID_UNUSED
+#endif
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
@@ -14510,7 +14516,8 @@ static bool is_migrating_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_task_park] ||
 	       btf_id == special_kfunc_list[KF_bpf_kthread_create] ||
 	       btf_id == special_kfunc_list[KF_bpf_kthread_stop] ||
-	       btf_id == special_kfunc_list[KF_bpf_kthread_bind];
+	       btf_id == special_kfunc_list[KF_bpf_kthread_bind] ||
+	       btf_id == special_kfunc_list[KF_bpf_kthread_attach_cgroup];
 }
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a284225f8dc9..41adae216ada 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3124,6 +3124,51 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	return ret;
 }
 
+/**
+ * cgroup_attach_kthread - move a kernel thread into a cgroup
+ * @dst_cgrp: the cgroup to move it into
+ * @task: the kernel thread
+ *
+ * For kernel threads the kernel creates on behalf of a user and accounts to a
+ * cgroup of the user's choosing rather than, as cgroup_attach_task_all() does,
+ * to the creator's own. @dst_cgrp is checked as a destination of cgroup.procs
+ * is, except for the permission check, which the caller owes: it must not be
+ * dying and, on the default hierarchy, must be able to host processes, and
+ * @task must be one the cgroup core may migrate.
+ *
+ * Return: 0 on success, -ENODEV if @dst_cgrp is being removed, -EBUSY or
+ * -EOPNOTSUPP if it cannot host processes, -EINVAL if @task may not be
+ * migrated, or the error of the migration.
+ */
+int cgroup_attach_kthread(struct cgroup *dst_cgrp, struct task_struct *task)
+{
+	enum cgroup_attach_lock_mode lock_mode;
+	int ret;
+
+	cgroup_lock();
+	if (cgroup_is_dead(dst_cgrp)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	/* As cgroup_procs_write_start() refuses them: cpusets cannot move these. */
+	if (task->no_cgroup_migration || (task->flags & PF_NO_SETAFFINITY)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	ret = cgroup_migrate_vet_dst(dst_cgrp);
+	if (ret)
+		goto out_unlock;
+	/* The moved process's own rwsem under favordynmods, as cgroup.procs takes. */
+	lock_mode = cgroup_enable_per_threadgroup_rwsem ? CGRP_ATTACH_LOCK_PER_THREADGROUP :
+							   CGRP_ATTACH_LOCK_GLOBAL;
+	cgroup_attach_lock(lock_mode, task);
+	ret = cgroup_attach_task(dst_cgrp, task, true);
+	cgroup_attach_unlock(lock_mode, task);
+out_unlock:
+	cgroup_unlock();
+	return ret;
+}
+
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     enum cgroup_attach_lock_mode *lock_mode)
 {
-- 
2.53.0


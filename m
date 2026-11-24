Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560512;
	b=tE8zb1xoZ71amMn2YwU4aFDoO7suF7GcodCUfUMYfwfE2SCbnN5kF6N0wzEo2OTc/4sQ
	 aoZlazRishLBs6xqpdx7bfRLWe7hEYw1Blj5uZTa5p+uhWc+7HnGPJ3jZ5tvdVmmuvM4u
	 +MXhIyEzQqRGUHJtNMvyGDspW1NyZmMLSVN6fK3Q+5VvL30lGjKOe8ZouC4BXuMk30LVX
	 kRbIeOLgW5I53vZ9pUAf8+nwoPHQ19QdtGruIPKVDVFkWsf1IaXV+agP4poq0/VHar+An
	 DBIOw0a2E9cYSYMM70PCghEqn65kwaWXsGEFZwneW4O8qem4ClPfp4R0LJkwJ7v9SCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560512;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tlZEx+2S2uPqz2EO7/zieEPpzImioLfgNzaugPckSXQ=;
	b=IrmvMQ+TFC73Jm8YibImXIGiGNK+nmF+P/YKbW1olThEuax3vWVbbs4SzIusqux17SSQ
	 sgg31jgm2U2Fk6ygKeNmiCWWcdlBe+9YqEMlmXHRuU0PD7LS8fzeUZF/Q+rEjvmj9rA95
	 BnB4EMl2YWO1wNmXZSCoc7+mrfk32BuMqpCMQtZjuyq7Qr7RMZm6a0bKWKuf/w/+cMIuS
	 DHcw4oKYhPz6xqDw4ppvMT4Q1d2p6UkN8MtC7GmaJCNyf61rTQu12gSHrFTXdNaWuyrf5
	 Op25hRX3r5gZzMCDjao8hD4+ojjxqa+jW86mvgfZs2Nl4v11dNHyr6owvAN8udO84Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rUUjyR3s;
	arc=none smtp.remote-ip=91.218.175.175
Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420C606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8420C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rUUjyR3s
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aJzHhHVUtWVj1dZaUwICiOaSOIUvJToK7uVIiDZ6vnY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560508; v=1; x=1796165308;
 b=rUUjyR3s3NoQ6RXMghaTQde7FVnMyZGO779rTJar5o7p6hHk+Ir36ZBhP+2tOm9pqzugelVX
 t13M0anYuWjZY7xI56w8nQ38Nv/Jvr2SgT9KYMA2xUUMgvzy0zehWVPB+3LDV2X53QLf5P6Q+aP
 /mlGQqKqnd8emCYWIqlO69aQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e625f7673d8bf4c;
	Tue, 24 Nov 2026 22:48:28 +0000
X-Mizu-Trace-ID: 6e625f7673d8bf4c
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 2/6] sched_ext: Prefer ___v2 kfunc names in compat.bpf.h
Date: Tue, 24 Nov 2026 15:48:07 -0700
Message-ID: <20261124224811.16134-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124224811.16134-1-ihor.solodrai@linux.dev>
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
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

compat.bpf.h declares scx_bpf_dsq_insert___v2___compat and similar
names. libbpf drops the last ___ suffix of a declaration and looks up
the rest exactly, so these resolve the kernel's ___v2 kfuncs.

The next patch makes libbpf drop the last suffix of kernel function
names too and select a variant by prototype. The ___v2___compat
names then resolve nothing, and the wrappers silently fall back to
the ___v1 kfuncs. For example, scx_bpf_dsq_move_to_local() drops
enq_flags.

Try the ___v2 names first. libbpf with that patch resolves them by
prototype. Older libbpf leaves them unresolved, because the
unsuffixed kfunc has a different prototype, and still resolves the
___v2___compat names that follow.

__COMPAT_scx_bpf_reenqueue_local_from_anywhere() checks both names for
the same reason.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/sched_ext/include/scx/compat.bpf.h | 48 +++++++++++++++++-------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 254882bd8ce6..fcbf7908defd 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -29,8 +29,10 @@ struct cgroup *scx_bpf_task_cgroup___new(struct task_struct *p) __ksym __weak;
  * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
  * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
  *
- * v7.1: scx_bpf_dsq_move_to_local___v2() to add @enq_flags.
+ * v7.1: scx_bpf_dsq_move_to_local___v2() to add @enq_flags. Older libbpf can
+ * resolve it only through the extra ___compat suffix.
  */
+bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_to_local___v2___compat(u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_to_local___v1(u64 dsq_id) __ksym __weak;
 void scx_bpf_dsq_move_set_slice___new(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
@@ -45,11 +47,13 @@ bool scx_bpf_dispatch_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct t
 bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 
 #define scx_bpf_dsq_move_to_local(dsq_id, enq_flags)				\
-	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2___compat) ?		\
-	 scx_bpf_dsq_move_to_local___v2___compat((dsq_id), (enq_flags)) :	\
-	 (bpf_ksym_exists(scx_bpf_dsq_move_to_local___v1) ?			\
-	  scx_bpf_dsq_move_to_local___v1((dsq_id)) :				\
-	  scx_bpf_consume___old((dsq_id))))
+	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2) ?			\
+	 scx_bpf_dsq_move_to_local___v2((dsq_id), (enq_flags)) :		\
+	 (bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2___compat) ?		\
+	  scx_bpf_dsq_move_to_local___v2___compat((dsq_id), (enq_flags)) :	\
+	  (bpf_ksym_exists(scx_bpf_dsq_move_to_local___v1) ?			\
+	   scx_bpf_dsq_move_to_local___v1((dsq_id)) :				\
+	   scx_bpf_consume___old((dsq_id)))))
 
 #define scx_bpf_dsq_move_set_slice(it__iter, slice)				\
 	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice___new) ?			\
@@ -430,12 +434,13 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime
 /*
  * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
  * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
- * The extra ___compat suffix is to work around libbpf not ignoring __SUFFIX on
- * kernel side. The entire suffix can be dropped later.
+ * Older libbpf can resolve scx_bpf_dsq_insert___v2() only through the extra
+ * ___compat suffix.
  *
  * v6.13: scx_bpf_dsq_insert() renaming is also handled here. See the block on
  * dispatch renaming above for more details.
  */
+bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_insert___v2___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert___v1(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
@@ -443,7 +448,9 @@ void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64
 static inline bool
 scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
 {
-	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2___compat)) {
+	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2)) {
+		return scx_bpf_dsq_insert___v2(p, dsq_id, slice, enq_flags);
+	} else if (bpf_ksym_exists(scx_bpf_dsq_insert___v2___compat)) {
 		return scx_bpf_dsq_insert___v2___compat(p, dsq_id, slice, enq_flags);
 	} else if (bpf_ksym_exists(scx_bpf_dsq_insert___v1)) {
 		scx_bpf_dsq_insert___v1(p, dsq_id, slice, enq_flags);
@@ -506,23 +513,32 @@ static inline bool __COMPAT_has_dsq_reenq_task(void)
 
 /*
  * v6.19: The new void variant can be called from anywhere while the older v1
- * variant can only be called from ops.cpu_release(). The double ___ prefixes on
- * the v2 variant need to be removed once libbpf is updated to ignore ___ prefix
- * on kernel side. Drop the wrapper and move the decl to common.bpf.h after
- * v6.22.
+ * variant can only be called from ops.cpu_release(). Older libbpf can resolve
+ * the v2 variant only through the extra ___compat suffix. Drop the wrapper and
+ * move the decl to common.bpf.h after v6.22.
  */
 u32 scx_bpf_reenqueue_local___v1(void) __ksym __weak;
+void scx_bpf_reenqueue_local___v2(void) __ksym __weak;
 void scx_bpf_reenqueue_local___v2___compat(void) __ksym __weak;
 
 static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
 {
-	return bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
+	bool v2 = bpf_ksym_exists(scx_bpf_reenqueue_local___v2);
+
+	/*
+	 * Without the barrier, clang folds || into a bitwise OR of the two ksym
+	 * addresses, which the verifier rejects.
+	 */
+	barrier_var(v2);
+	return v2 || bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
 }
 
 static inline void scx_bpf_reenqueue_local(void)
 {
 	if (__COMPAT_has_generic_reenq())
 		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
+	else if (bpf_ksym_exists(scx_bpf_reenqueue_local___v2))
+		scx_bpf_reenqueue_local___v2();
 	else if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
 		scx_bpf_reenqueue_local___v2___compat();
 	else
@@ -541,6 +557,10 @@ static inline int scx_bpf_reenqueue_local_from_anywhere(void)
 		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
 		return 0;
 	}
+	if (bpf_ksym_exists(scx_bpf_reenqueue_local___v2)) {
+		scx_bpf_reenqueue_local___v2();
+		return 0;
+	}
 	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere()) {
 		scx_bpf_reenqueue_local___v2___compat();
 		return 0;
-- 
2.56.0


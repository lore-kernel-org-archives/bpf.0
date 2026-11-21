Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221266;
	b=TOrsjlV81DQ4FucBM36NkA8vFEuySvfUGb4JLIjEzuul83B/P7c76yq0M0BgBuZztboy
	 K5HqoyEqRRiD1FLRx8K2eNAe1l8cTelUqTYIQozcEKAxQYADdAak72vvybsiPilDzXbps
	 GwFW2wz8lhqNVaqDlWPix4N9CO0ufFyRxDjD4S/vkM8B5czYgh0y/o7/DCF8dzElxgMNH
	 1QUxOSuCWI6wWLga/FCV0Z3CQOi3nDLnuj/UnYakmHF/M26T2h4Q6zNIUgSwzcLwVZTES
	 I5W+Infbq+Erb1vW0fobpsFaCJ/lQYXSTN92CLRajAdxTO2NlTgWYp8SOaCgmr5LBEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221266;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBtkiDsj+it2yuD+PNBgJrBOad1TOpfb5WOVADUa3UM=;
	b=kU8vCEYRifv27JZQFMe6WZyD3e9f9h6ag3WgdhMADoZzNvxOceve35203DcAeKO0xa/o
	 FmDtilmNnyPzbhS+BKqoGZPw3sqoNQkMhMGMxqTE1FycAI5OPYc9Z8s5Tq49epU3JLK+w
	 OaAYbfoJ6JNl9RiOJLrBlAJ9sAOTBurpl6BHdZ+Np71XQy8qYJsdeTiYnH+6NTshvYnQ+
	 31QZExZceBxcRloYAHwF6THHoh7NE5uQDwEjO1JRdBWDRkNudYG1P6XUtzUji7S7UVZLv
	 cDgd2oE8SCcPSu1NGB8TR0cBlqU+zchM52pUCzM9hs++sDcJO1jXGNc1JnipO2rJ4Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dsWCaO0H;
	arc=none smtp.remote-ip=95.215.58.157
Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC060A2608
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EC060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dsWCaO0H
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6xxqSekLAxGWLipL5wNFTRl3FhuvQzQBfNSr9PL/vKE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795221263; v=1; x=1795826063;
 b=dsWCaO0HWVcVuW3Qs7Xbva1dEf/pZ0fPPFrRm1EXweP9sDiRSrpE9ZtTL8DtSlqZhhlorcfC
 Ag+HX2eun6lVMMUvPkQZYg/n/X17+d/IeAkwPoKUxsZyJmNd5CDIeCRm3yPrtsPc82bTOW1zi0n
 WRoCLopFvL35DiPaOpFDywTg=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 49c793bd95345343;
	Sat, 21 Nov 2026 00:34:22 +0000
X-Mizu-Trace-ID: 49c793bd95345343
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
Subject: [PATCH bpf-next v2 2/6] sched_ext: Prefer ___v2 kfunc names in compat.bpf.h
Date: Fri, 20 Nov 2026 17:33:59 -0700
Message-ID: <20261121003403.2928928-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
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

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/sched_ext/include/scx/compat.bpf.h | 39 ++++++++++++++++--------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 254882bd8ce6..16cf255e4221 100644
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
@@ -506,12 +513,12 @@ static inline bool __COMPAT_has_dsq_reenq_task(void)
 
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
@@ -523,6 +530,8 @@ static inline void scx_bpf_reenqueue_local(void)
 {
 	if (__COMPAT_has_generic_reenq())
 		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
+	else if (bpf_ksym_exists(scx_bpf_reenqueue_local___v2))
+		scx_bpf_reenqueue_local___v2();
 	else if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
 		scx_bpf_reenqueue_local___v2___compat();
 	else
@@ -541,6 +550,10 @@ static inline int scx_bpf_reenqueue_local_from_anywhere(void)
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
2.56.1


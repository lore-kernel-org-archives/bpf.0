Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F13351C34;
	Thu,  7 May 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139994; cv=none; b=XtFo+sxugmzM010Y0LYeb94BppggGhnr0mLwnjXT5/bUkpYRKVbZwc0Fs/ErMWAeD8jAV8I6A0SUEtRoL0qrw5fshjIhk8rj9SUcSdWDNYc6SM5Z/DXqwQ/FFojDnwd8x4PSWEbck9iFl1MLEwCLLvoq4L3MURNZVAvfjN4IwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139994; c=relaxed/simple;
	bh=hUfs54JWWTcX4/tM4vRkMB1fpoB0VrxcH5wJCexocmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dlEa1YYTQR8tdUmS9UiplEZbpmA9AwDxI401lQNN0CwfeXn/yVPIwxV58f2toCDanYrS7+S6z0ILTREQ4w1KyIdQmlk+gRtmnRRMAWxfV0xVK1yQkXeBsoIlqFJ4kCDKhQ9yeNhv3oycxC7UGPCmcE69I19uMwBsCSmPw/tgpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYlC4XJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYlC4XJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B70C2BCB8;
	Thu,  7 May 2026 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778139994;
	bh=hUfs54JWWTcX4/tM4vRkMB1fpoB0VrxcH5wJCexocmk=;
	h=From:To:Cc:Subject:Date:From;
	b=GYlC4XJqPASHi7WhTEXG/ic/9EOrO4YtAMlQlwg8qb/IMTclse/5omPd2DC4M94nF
	 UZurLFc8oxq6fOPtoT3Ymx1wxwh+PvWvJZYz0SSUSBcWHvGxax68tDbhahT1PhGV1u
	 3jufqvISNlisRTDjpJUpzlfW4TUUzuVQMgVcqr1Fqc5kP5+D1oE83oFy3fCNq2NBT2
	 F6cOqUiJemNZ1eaqokEIDCxPbJAB8a5jn5GZ82IZMNckes8/H7GomJTZRdRwlZJbwr
	 T+w6za0aE5ZTBeLQukrQ1jfY7nT8gnv73gpWIjaoHQK0T1rkAZqD1JyH2eXtg5hmNv
	 wXKmFtS4go38Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] fprobe: Fix unregister_fprobe() to wait for RCU grace period
Date: Thu,  7 May 2026 16:46:29 +0900
Message-ID:  <177813998919.256460.2809243930741138224.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Commit 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
changed fprobe to register struct fprobe to an rcu-hlist, but it forgot
to wait for RCU GP. Thus there can be use-after-free if the fprobe is
released right after unregistering. This can be happened on fprobe
event and sample module code.

To fix this issue, add synchronize_rcu() in unregister_fprobe().

Note that BPF is OK because fprobe is used as a part of
bpf_kprobe_multi_link. This unregisters its fprobe in
bpf_kprobe_multi_link_release() and it is deallocated via
bpf_kprobe_multi_link_dealloc(), which is invoked from
bpf_link_defer_dealloc_rcu_gp() RCU callback.

For BPF, this also introduced unregister_fprobe_async() which does
NOT wait for RCU grace priod.

Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes from v1 [1]:
  - Rewrite with async API.
  - Apply async API only to BPF.
  [1] https://lore.kernel.org/all/177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com/
---
 include/linux/fprobe.h   |    5 +++++
 kernel/trace/bpf_trace.c |    3 ++-
 kernel/trace/fprobe.c    |   23 +++++++++++++++++++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 0a3bcd1718f3..be1b38c981d4 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -94,6 +94,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
 int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
 int unregister_fprobe(struct fprobe *fp);
+int unregister_fprobe_async(struct fprobe *fp);
 bool fprobe_is_registered(struct fprobe *fp);
 int fprobe_count_ips_from_filter(const char *filter, const char *notfilter);
 #else
@@ -113,6 +114,10 @@ static inline int unregister_fprobe(struct fprobe *fp)
 {
 	return -EOPNOTSUPP;
 }
+static inline int unregister_fprobe_async(struct fprobe *fp)
+{
+	return -EOPNOTSUPP;
+}
 static inline bool fprobe_is_registered(struct fprobe *fp)
 {
 	return false;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index af7079aa0f36..a02bd258677e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2384,7 +2384,8 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
 	struct bpf_kprobe_multi_link *kmulti_link;
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
-	unregister_fprobe(&kmulti_link->fp);
+	/* Don't wait for RCU GP here. */
+	unregister_fprobe_async(&kmulti_link->fp);
 	kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
 }
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index cc49ebd2a773..f378613ad120 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -1093,14 +1093,15 @@ static int unregister_fprobe_nolock(struct fprobe *fp)
 }
 
 /**
- * unregister_fprobe() - Unregister fprobe.
+ * unregister_fprobe_async() - Unregister fprobe without RCU GP wait
  * @fp: A fprobe data structure to be unregistered.
  *
  * Unregister fprobe (and remove ftrace hooks from the function entries).
+ * This function will NOT wait until the fprobe is no longer used.
  *
  * Return 0 if @fp is unregistered successfully, -errno if not.
  */
-int unregister_fprobe(struct fprobe *fp)
+int unregister_fprobe_async(struct fprobe *fp)
 {
 	guard(mutex)(&fprobe_mutex);
 	if (!fp || !fprobe_registered(fp))
@@ -1108,6 +1109,24 @@ int unregister_fprobe(struct fprobe *fp)
 
 	return unregister_fprobe_nolock(fp);
 }
+
+/**
+ * unregister_fprobe() - Unregister fprobe with RCU GP wait
+ * @fp: A fprobe data structure to be unregistered.
+ *
+ * Unregister fprobe (and remove ftrace hooks from the function entries).
+ * This function will block until the fprobe is no longer used.
+ *
+ * Return 0 if @fp is unregistered successfully, -errno if not.
+ */
+int unregister_fprobe(struct fprobe *fp)
+{
+	int ret = unregister_fprobe_async(fp);
+
+	if (!ret)
+		synchronize_rcu();
+	return ret;
+}
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 
 static int __init fprobe_initcall(void)


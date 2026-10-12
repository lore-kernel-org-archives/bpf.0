Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF84AB1B9
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819794; cv=none; b=L74gXTQCTorPiDIIo07NtqtoMW3WINHcEe9DsVhgGMLmvDxsYhNKkY6wC8xxUy+ZaLtWDfuK6YiWUE7i3evvEiZeo9jIVYhLzT4EKV/tJ+45OSxP04Paf6VyrFHBFcA+orahrGJDl2w2i+J6rzZLJA6mThX8AC6hxh1vW0Mp91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819794; c=relaxed/simple;
	bh=t4wwibWf19/pFIHraFuZ0Qwx7etchUFm1FhsZDURbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/YYSY702cD2m/oy2lPkuaiH+Y1GePYTucdGfYQ8nv3GNp4dnkxM1bixPfxQ75y7Y86BZLKiV9ZmsvL3gYqOBjJRVAlCr8kbgNIPrCkbQyx6h4F+I7zmdw09JZYmyz0C51rxjlb8CEFY0Lk7rl4FyYi24MLeF9ErHHP5t8Js7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hUTVjsWG; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hUTVjsWG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t4wwibWf19/pFIHraFuZ0Qwx7etchUFm1FhsZDURbB4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819790; v=1; x=1792424590;
 b=hUTVjsWGjFqBJmNn5+FOh1hJIve+XNLPpVLOwMCMUtYLYTpw8V+tQywvhsnl8+QlwcepfcFt
 nZCpId3h/NcqyXzB4HnTelRaXKtlVrxLO3Mwx6VhLVTZxq14b6IYaqMRAgwafdfzgL8Lyw1Jv3H
 zmxg/BJrh5qCWHycU0uIMZUw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c6af0875fd131de8;
	Mon, 12 Oct 2026 15:43:10 +0000
X-Mizu-Trace-ID: c6af0875fd131de8
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 08/21] bpf: Move helpers out of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard in trampoline
Date: Mon, 12 Oct 2026 23:40:10 +0800
Message-ID: <20261012154024.29423-9-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following helpers are not relied on the
CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard.

* trampoline_lock_all()
* trampoline_unlock_all()
* bpf_trampoline_multi_attach_init()

Move them out of the CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard in order
to add tracing_multi link support for bpf progs.

Keep the CONFIG_BPF_SYSCALL guard to avoid compiling warning when
CONFIG_BPF_SYSCALL is disabled.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 48 ++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index a2fd0bd8c685..bb832af8703f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -60,6 +60,32 @@ static void trampoline_unlock(struct bpf_trampoline *tr)
 	mutex_unlock(select_trampoline_lock(tr));
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+
+static void trampoline_lock_all(void)
+{
+	int i;
+
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
+		mutex_lock(&trampoline_locks[i].mutex);
+}
+
+static void trampoline_unlock_all(void)
+{
+	int i;
+
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
+		mutex_unlock(&trampoline_locks[i].mutex);
+}
+
+static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
+{
+	tr->multi_attach.old_image = tr->cur_image;
+	tr->multi_attach.old_flags = tr->flags;
+}
+
+#endif /* CONFIG_BPF_SYSCALL */
+
 struct bpf_trampoline_ops {
 	int (*register_fentry)(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *data);
 	int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *data);
@@ -1574,22 +1600,6 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
     defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS) && \
     defined(CONFIG_BPF_SYSCALL)
 
-static void trampoline_lock_all(void)
-{
-	int i;
-
-	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
-		mutex_lock(&trampoline_locks[i].mutex);
-}
-
-static void trampoline_unlock_all(void)
-{
-	int i;
-
-	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
-		mutex_unlock(&trampoline_locks[i].mutex);
-}
-
 static void remove_tracing_multi_data(struct bpf_tracing_multi_data *data)
 {
 	ftrace_hash_remove(data->reg);
@@ -1682,12 +1692,6 @@ static const struct bpf_trampoline_ops trampoline_multi_ops = {
 	.modify_fentry     = modify_fentry_multi,
 };
 
-static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
-{
-	tr->multi_attach.old_image = tr->cur_image;
-	tr->multi_attach.old_flags = tr->flags;
-}
-
 static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
 {
 	/*
-- 
2.55.0


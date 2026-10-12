Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0874ABBC5
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819824; cv=none; b=R9WHxp8uyiRAcZ5SzIkMPCnG2XaYuP61+2NUSS8cC4pqjOdJhR/AFf6442hhM/V85SQlE0I34D3rxY7NnSBm3YlW5XYOcoM7q5FspDTLhh3rdl6EtZaN6h14PQsNyStc+pqIkbmpY6KXJbyPTVTRJ38sunMsBHiLVeB/k9DN0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819824; c=relaxed/simple;
	bh=/gBW1d1cVLJtNB/NJdMCnpkInb2694SgAuivVlbPgZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdwb5AJzIl60Lez76ViwbGkMt4yEMg8nBctxf6ty1v3sayFPPZgg0Alna3kycHLywKyGa7bjslmMt7eIiFCjPwfw64pof6BwMUBHUBwKUsOEyu7tkeTMxtlARlSMCHmcpbSuoQOKribbI6qKnu8emnbqUN+13uCnOYw85vWcj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L5L+XDIo; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L5L+XDIo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/gBW1d1cVLJtNB/NJdMCnpkInb2694SgAuivVlbPgZg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819820; v=1; x=1792424620;
 b=L5L+XDIooFbcYtRbwIgyLTM+CB2AJAAFnCe/51VkzHRfv2ETYa6i0yKn/PlEl9gPBeClA0oZ
 KppFaziUsw2cKpIpAXHPups/sY8esSmTqLtGZQ1hIBUTOKtJA35RIGCzfhqnFYB5dEeLHOHxpfM
 F/Jm5TRLo72ItMfsbHx7V+M0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ee9867227e8ab7f1;
	Mon, 12 Oct 2026 15:43:40 +0000
X-Mizu-Trace-ID: ee9867227e8ab7f1
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
Subject: [PATCH bpf-next v2 10/21] bpf: Shrink CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard scope for bpf_tracing_multi_attach()
Date: Mon, 12 Oct 2026 23:40:12 +0800
Message-ID: <20261012154024.29423-11-leon.hwang@linux.dev>
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

When adding tracing_multi link support for bpf progs, it will use the same
UAPI of the tracing_multi link for kernel functions in
bpf_tracing_multi_attach().

However, the tracing_multi link support for bpf progs does not require
CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS. So, shrink its guard scope to add
new code in bpf_tracing_multi_attach() for the tracing_multi link support
for bpf progs.

To simplify the change, validate CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS only
here, because the execution path in trampoline of the tracing_multi link
support for kernel functions is already guarded with the
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS and
CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS.

Meanwhile, provide a stub of bpf_trampoline_multi_detach() out of the
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS and
CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c  |  5 +++++
 kernel/trace/bpf_trace.c | 15 +++------------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e57c687955fd..6e18f69a63ad 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1867,6 +1867,11 @@ void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 #undef for_each_mnode_cnt
 #undef for_each_mnode
 
+#else
+
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link) {}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS &&
 	  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS &&
 	  CONFIG_BPF_SYSCALL */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 195f78db9bda..69559158ab0b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3679,9 +3679,6 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr
 
 __bpf_kfunc_end_defs();
 
-#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
-    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
-
 static void bpf_tracing_multi_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_multi_link *tr_link =
@@ -3858,6 +3855,9 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	if (attr->link_create.flags || attr->link_create.target_fd)
 		return -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS))
+		return -EOPNOTSUPP;
+
 	ids = kvmalloc_objs(*ids, cnt);
 	if (!ids)
 		return -ENOMEM;
@@ -3924,12 +3924,3 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	kvfree(link);
 	return err;
 }
-
-#else
-
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS && CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
-- 
2.55.0


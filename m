Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD2392821
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416956; cv=none; b=YMRA1fpxmBYzls8vIZ5QfmGw2Jg1M3BusysNogqbZYn9lxrd0KLcnsaU96DpNj+IeXS+Y81KvfjMYJXK1HThsBbTDvb+kyCzwS7KAS8PKShY1rqtN81OEANFMi9SfXFf6Vyjl6jZtcqEAdz0jmy/9NYUS+LqP0BT05b7QpRtl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416956; c=relaxed/simple;
	bh=h9CwLLgWY86IgBTBCFFT7XiOfU2SnvRpv0KtXOkp2b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmJjCrSFv1u2qUFOF4QOWQgIKDbfNbj91XztuapqlQ3q4Iz9MWj7iKF+x6QPuS22fsLHNIhxUkzyf1A8eTEK/GEUnxTyS88uxtEPdmL/v4hTkja/4+mHfMHmwFJpKDtm5dRrl9YZmnRDWEHLPedOCw+nRKweA7oBQthXuq15R3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KO5Mnr+s; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KO5Mnr+s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786416952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R/M8+7j69K4UXqpWgelzLhpMrxpij9/yR6sHHNa+oE=;
	b=KO5Mnr+sIpOt+vYcOec6mScWVCDn/0rUAW4tGAdOXZ/oDtuMOKtaJNOitcMN9CBgo04Gii
	rvXOLB4AiXl0/g2krIUFohZyc+2qO+LeEA+yqBuyxXo6iizR21p+VWjpPAPrZzqwwp+nMg
	FerUqRrElCTgyzbfhtl6ael2c/u83lg=
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
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
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v5 2/2] bpf: Make bpf_trampoline_multi_detach return void
Date: Tue, 11 Aug 2026 10:46:20 +0800
Message-ID: <12beba657f5c9e86a016a097750209287a2f262a.1786412280.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1786412280.git.zhuhui@kylinos.cn>
References: <cover.1786412280.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

bpf_trampoline_multi_detach() always returns 0 and the sole caller
ignores the return value.  Change it to return void and drop the
WARN_ON_ONCE at the call site.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 include/linux/bpf.h      | 9 ++++-----
 kernel/bpf/trampoline.c  | 4 ++--
 kernel/trace/bpf_trace.c | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..3255c6f5ea6b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1518,8 +1518,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 				struct bpf_tracing_multi_link *link);
-int bpf_trampoline_multi_detach(struct bpf_prog *prog,
-				struct bpf_tracing_multi_link *link);
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link);
 void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
 
 /*
@@ -1639,10 +1639,9 @@ static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 {
 	return -ENOTSUPP;
 }
-static inline int bpf_trampoline_multi_detach(struct bpf_prog *prog,
-					      struct bpf_tracing_multi_link *link)
+static inline void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+					       struct bpf_tracing_multi_link *link)
 {
-	return -ENOTSUPP;
 }
 static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
 #endif
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ea4d3c62f289..e30425789487 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1729,7 +1729,8 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	return err;
 }
 
-int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_tracing_multi_node *mnode;
@@ -1759,7 +1760,6 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 		bpf_trampoline_put(mnode->trampoline);
 
 	clear_tracing_multi_data(data);
-	return 0;
 }
 
 #undef for_each_mnode_cnt
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 891897f8a1b3..29260951aa87 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3687,7 +3687,7 @@ static void bpf_tracing_multi_link_release(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
-	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
+	bpf_trampoline_multi_detach(link->prog, tr_link);
 }
 
 static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
-- 
2.53.0


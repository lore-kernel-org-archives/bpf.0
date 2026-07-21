Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E573546EC
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640710; cv=none; b=IdSZs7ciQGzp0PUv6Y9hiNojVTfWOzZAuP1VsYBT2NFrQ+jDRyE189CK0TEi2yhyu7xg35q6gVO3Rc8hhzjHtHvcI3kMjpNCxEequcamjf5s9OaimuvxSZlJng0o2zug5jE92Nf/P/+IMkyPROccGBKDJqaNTSk5sVPDXXKAWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640710; c=relaxed/simple;
	bh=HmIgL9AgosyIsh6nVBViCL9eOIDR6q92CvDjnaAZ6fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuIboWl8qu0iOo3OcG8QEsiRJxhUkxYafbVwbIMQgmlSVypWlSwX/ezj9Sz3zTDWfYAVg0qw0bHl4qianf4ppW4c39Ivqt+SUdKRPyIzhQvE3C7xEyNQI06Olam8tpjpikbAm5ZjBxvFzQZGdOqJO/o7rG6btCPnFyIzAaCa3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P0emkjGT; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P0emkjGT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784640703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1L1QxRLeeYcsjArysBca5dBZPpFGjkWhx0OTqToqxYw=;
	b=P0emkjGTlvkOdSR/vbqrXpb/DvfEMKodqGsCuKoO1vFri0y+l0iZntC89JXATC8TRg8l/0
	JXxYIZXKI/7KhanAGLfzWbDLEN7JiwNHjzPzqDJbMBy6me1TjTs06F6x4LXFVw6k5the6N
	juVamVy6H0XBYodGKieRul/tcvfIDQM=
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
	Shuah Khan <shuah@kernel.org>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Pu Lehui <pulehui@huawei.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Lin Ma <malin89@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Fix WARNING in bpf_tracing_link_release
Date: Tue, 21 Jul 2026 21:30:34 +0800
Message-ID: <20260721133036.49265-2-leon.hwang@linux.dev>
In-Reply-To: <20260721133036.49265-1-leon.hwang@linux.dev>
References: <20260721133036.49265-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The trampoline could be corrupted by the blindly
'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.

1. A fexit attached to a tail_call_reachable prog.
2. Another fexit loaded with the same tail_call_reachable prog target.
3. Close the first fexit link.

[    3.410719] WARNING: kernel/bpf/syscall.c:3551 at bpf_tracing_link_release+0x53/0x60, CPU#1: test_progs/98
...
[    3.428793]  bpf_link_free+0x58/0x130
[    3.429293]  bpf_link_release+0x23/0x30

Fix the warning by updating 'tr->flags' with '|=' and lock.

Fixes: 2b5dcb31a19a ("bpf, x64: Fix tailcall infinite loop")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h     | 2 ++
 kernel/bpf/trampoline.c | 7 +++++++
 kernel/bpf/verifier.c   | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d9542127dfdf..fc84f39967ae 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1523,6 +1523,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 				struct bpf_tracing_multi_link *link);
 int bpf_trampoline_multi_detach(struct bpf_prog *prog,
 				struct bpf_tracing_multi_link *link);
+void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
 
 /*
  * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
@@ -1646,6 +1647,7 @@ static inline int bpf_trampoline_multi_detach(struct bpf_prog *prog,
 {
 	return -ENOTSUPP;
 }
+static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
 #endif
 
 struct bpf_func_info_aux {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6eadf64f7ec9..129d07db117e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -670,6 +670,13 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	return ERR_PTR(err);
 }
 
+void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags)
+{
+	trampoline_lock(tr);
+	tr->flags |= flags;
+	trampoline_unlock(tr);
+}
+
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
 				 const struct bpf_trampoline_ops *ops, void *data)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..66d8d9eaec05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19523,7 +19523,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -ENOMEM;
 
 	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
-		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
+		bpf_trampoline_set_flags(tr, BPF_TRAMP_F_TAIL_CALL_CTX);
 
 	prog->aux->dst_trampoline = tr;
 	return 0;
-- 
2.55.0


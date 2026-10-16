Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BD3845B3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160455; cv=none; b=loKaK2nFSab5BeL1a3aIEn0G9RMz2YslAnfRMAZp9Fw7aJwVJQjzLHFNILinxohP48EJtumewJWjYQrRQPOFtHtq8rIsrFltGcRy4MkhUNRBVTHZO2yh4L4lLxgjLr/xyIqX+40mt5tTa+2wl56yXRPQnZMCLppdPnLRM2KT7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160455; c=relaxed/simple;
	bh=UnkKdmlxZrAfNilILa/BseSLcG/fV1+Rqm2JjBeoV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdUqOT+KcZZBVq9BJVHDYtQDR9SbMCE/UMWfoYZ3iGRAoDli3ylg4JVWFa8mSUMR+ZXZXqJkLDDcivzWwN9DwqPNzP7AhZzTI/OrsCCLXY91WjNO+lhs9ZXoR0565PNgY+KSjIVnrpgD3jcZsIy2Yg+eV2Ue9EFCWh+3KxBOdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XxTrDQuP; arc=none smtp.client-ip=95.215.58.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XxTrDQuP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UnkKdmlxZrAfNilILa/BseSLcG/fV1+Rqm2JjBeoV1A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792160451; v=1; x=1792765251;
 b=XxTrDQuPmQ8p8k+5T8lgK7jo6Tp6IZMhkff8h3aGwmbfhdwuEz6iyKwk8eMTr0RCLGQzCytV
 iTMqzo1Sv3Lw5oCSQqCxJsEaFFOavt9wRgyFGyQc8xDILAWjsrRNQ69EKG10ng7jDcEbxEl0OrX
 HU2+DxcMuATmM2llxFQj3Gvg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ce7dafab37ac9838;
	Fri, 16 Oct 2026 14:20:51 +0000
X-Mizu-Trace-ID: ce7dafab37ac9838
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
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: Initialize ftrace_managed in bpf_trampoline_get()
Date: Fri, 16 Oct 2026 22:20:13 +0800
Message-ID: <20261016142014.12420-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016142014.12420-1-leon.hwang@linux.dev>
References: <20261016142014.12420-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A trampoline managed by ftrace is determined by its target, that said
ftrace_managed is already known when the trampoline is initialized. so,
set 'ftrace_managed = tr->ip != 0' in bpf_trampoline_get() instead of
relying on the first regular or tracing_multi attachment to set it.

This makes the backend selection independent of attachment order and keeps
the registration callbacks focused on installing the trampoline.

No functional change intended.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 24edb59238f3..17f2a8133f61 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -475,18 +475,11 @@ static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im
 			   void *data __maybe_unused)
 {
 	void *new_addr = im->image;
-	void *ip = tr->func.addr;
-	unsigned long faddr;
 	int ret;
 
-	faddr = ftrace_location((unsigned long)ip);
-	if (faddr) {
+	if (tr->func.ftrace_managed) {
 		if (!tr->fops)
 			return -ENOTSUPP;
-		tr->func.ftrace_managed = true;
-	}
-
-	if (tr->func.ftrace_managed) {
 		ret = direct_ops_add(tr, new_addr);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
@@ -1286,6 +1279,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 
 	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
 	tr->func.addr = (void *)tgt_info->tgt_addr;
+	tr->func.ftrace_managed = tr->ip != 0;
 out:
 	trampoline_unlock(tr);
 	return tr;
@@ -1649,7 +1643,6 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	tr->func.ftrace_managed = true;
 	ftrace_hash_add(data->reg, data->entry, ip, addr);
 	tr->cur_image = im;
 	return 0;
-- 
2.55.0


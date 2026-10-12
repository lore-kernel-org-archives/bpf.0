Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763C4A0EF3
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819685; cv=none; b=WvvTj49tGVJL2c70c8qT5aX1wFroxiN+1sa7UhBSlWrljlxtGAtjVzzIiKuSzjF3jgblTTIsAVvEg08BdKHjr+Toj88OOGPCtCGIgBhgEcH8R5V40rL46jBzZk17oPtXYoWx7YmGvMSRUbIfb3bcAQ4XRLBSduMMkNENwvXyebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819685; c=relaxed/simple;
	bh=f97YBpk24mCWaEC+VMRK7wh8FGCU36QI9W/V9kJ5Pag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh3bwBMZW50MMSmclIN4SMXK4rPhZV5MG00859tTalpUCYC031hwv0Pema6nAY7/RnTrKufZkR1SBjmD+we+5Uz5s9HPyyWxacE0R4b2GVgsaLMIMzDmFTypbXyBJBQsFOEOwnU8Ijm5l6IR+2XLL+zAJwHPs99tDagbkrNDH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+NQ6MZd; arc=none smtp.client-ip=95.215.58.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+NQ6MZd"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f97YBpk24mCWaEC+VMRK7wh8FGCU36QI9W/V9kJ5Pag=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819682; v=1; x=1792424482;
 b=A+NQ6MZdSPJeczDdSjHHlXS1NF0V7lMS13f3X8n58LVs2YQei98NmEkyGIvzBcbf5WSGRxqh
 z7/Tm9h4I8+dOQknRk7BneiM+WyoDMrLvWplQ89Sw796Dxx4noK9kgQbdyJAm+USPQDu00VzHYE
 6B/z98R/JvvaTXDoE1w5DDOM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 511aec9e5df13166;
	Mon, 12 Oct 2026 15:41:22 +0000
X-Mizu-Trace-ID: 511aec9e5df13166
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
Subject: [PATCH bpf-next v2 01/21] bpf: Initialize ftrace_managed in bpf_trampoline_get()
Date: Mon, 12 Oct 2026 23:40:03 +0800
Message-ID: <20261012154024.29423-2-leon.hwang@linux.dev>
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

A trampoline managed by ftrace is determined by its target, that said
ftrace_managed is already known when the trampoline is initialized. so,
set 'ftrace_managed = tr->ip != 0' in bpf_trampoline_get() instead of
relying on the first regular or tracing_multi attachment to set it.

This makes the backend selection independent of attachment order and keeps
the registration callbacks focused on installing the trampoline.

No functional change intended.

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


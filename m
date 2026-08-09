Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBD39A800
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287722; cv=none; b=ShXLWJOAquHTZN34oPBV0bXuYAkaN7Gzx+N9VKXJxCi6acyEqEETYkX1d673YD7DKuE47D4beeWGvmOi5mM7g6FEtJqdDY9FcKn4cl04JgEyph9YL7FeNrsU1ccwcTKB1EY+roRWQqgua0nkao7Tou6Q9wY2rQQLsQlBOFFlgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287722; c=relaxed/simple;
	bh=NPPv63MwhFAsbs4rGDL9pQ7OXlzNtqBnsPeNXBDr5hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkOSlhB2eFM9Ws7Vkfl6Pa6qL7PZkOUr8DYXho8MFyolqmHxi3SA3/Qvy+ateEkXefagW4Z348R/BGBayKuMvoNBwVA+R1gOfc6b1vx0CqGZa1svcoxndABKHJ2Zwe7H87pINlD9P8gVkGRY9ofE+1Nw6vrjuh5lQfh0cRRCKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1/W/gnA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1/W/gnA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nWaRn08RUguxiYGsJ8AlACfbwZDlTj8g6X00LLcNBk=;
	b=n1/W/gnAdHJBs3InaDrzXLC+vxGUeQNeitL/NhNMpWZd6XJKjfIGQJSaQoh7qeTu3rChs1
	Y3HiUt815mpH7jECtG2iF97dBob3y8V8LPzGHYeNzLSABKGLwEQ0Y9prDbLOXEBc+YAxGj
	L+JMzFhBGXS1n/kdW/pGiJ1cFiTxWbI=
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
Subject: [PATCH bpf-next 01/13] bpf: Initialize ftrace_managed in bpf_trampoline_get
Date: Sun,  9 Aug 2026 23:00:59 +0800
Message-ID: <20260809150111.45000-2-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A trampoline managed by ftrace is determined by its target, that said
ftrace_managed is already known when the trampoline is initialized. so,
set 'ftrace_managed = tr->ip != 0' in bpf_trampoline_get() instead of
relying on the first regular or tracing_multi attachment to set it.

This makes the backend selection independent of attachment order and keeps
the registration callbacks focused on installing the trampoline.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e07af35ed040..8c2c1d1b9094 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -474,18 +474,11 @@ static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im
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
@@ -1226,6 +1219,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 
 	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
 	tr->func.addr = (void *)tgt_info->tgt_addr;
+	tr->func.ftrace_managed = tr->ip != 0;
 out:
 	trampoline_unlock(tr);
 	return tr;
@@ -1583,7 +1577,6 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	tr->func.ftrace_managed = true;
 	ftrace_hash_add(data->reg, data->entry, ip, addr);
 	tr->cur_image = im;
 	return 0;
-- 
2.55.0


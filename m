Received: from out-181.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02F3A0E93
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287728; cv=none; b=L27g39cpCP1pwabUMmF4EMENqOxYByR7kGOtPHoMZJV19oyl8dTMI+e+9XCXmcqQyFtNSp9KtBt5RVS5jmzw1jSUGfGwzy9RuDfs0MIH+lnS5f5yHaWUaqa5osPw5F2Dx9sezt0LGA/sC/2ccyrTa+Gq0slOq03GK4Bf+MHIfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287728; c=relaxed/simple;
	bh=3MTCI5XeL+tPy6FWJF/tlCqoSyBh5wU07XGAQFqDxbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSg13Le4bwTPtl9uIJB6lLL6xFVI74jB3E9fsM7OLRqGH6rBaL1R70louwnAEDHcyA3VL9Lyfcyyb0yyCfvi47GA2UqcO5gUBnmb1CNqaQjrbcme48Tzfk8Ph8mSMCpRXOPLmR4p7d+Dk1mWvxHCuq4ZX+YTcvZrFETeyWw+8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjRYenol; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjRYenol"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPqBAE7OME6JB+B8bz7yQ1+hF2jZRRJRbW/HV1BzL+Q=;
	b=UjRYenolm0FPBJHMfJyghG/DV6Gs0ZAgHFe/SIRAsx3bNSXY86fuBoDqgrD/Op3NBewr/Z
	//+VS5rYncX176hSQ5o1Dmw8dsa9AQC4q3x8iuUqf4ZjzDi957Hn6ca+gI8Oe3eN1dD0dq
	nfovL+/g547OyHmBE3lR9FTNyO/PSAQ=
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
Subject: [PATCH bpf-next 02/13] bpf: Factor out update_fentry_multi helper
Date: Sun,  9 Aug 2026 23:01:00 +0800
Message-ID: <20260809150111.45000-3-leon.hwang@linux.dev>
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

The tracing_multi register, unregister, and modify callbacks differ only
in the trampoline image and ftrace hash they use. Move their common
address setup, hash insertion, and current image update into
update_fentry_multi().

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 8c2c1d1b9094..6e1898e1b200 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1568,47 +1568,41 @@ static void ftrace_hash_add(struct ftrace_hash *hash, struct ftrace_func_entry *
 	add_ftrace_hash_entry(hash, entry);
 }
 
-static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *ptr)
+static int update_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags,
+			       struct bpf_tramp_image *im, struct ftrace_hash *hash,
+			       struct bpf_tracing_multi_data *data)
 {
-	unsigned long addr = (unsigned long) im->image;
+	unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
 	unsigned long ip = ftrace_location(tr->ip);
-	struct bpf_tracing_multi_data *data = ptr;
 
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	ftrace_hash_add(data->reg, data->entry, ip, addr);
+	ftrace_hash_add(hash, data->entry, ip, addr);
 	tr->cur_image = im;
 	return 0;
 }
 
-static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *ptr)
+static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *ptr)
 {
-	unsigned long addr = (unsigned long) tr->cur_image->image;
-	unsigned long ip = ftrace_location(tr->ip);
 	struct bpf_tracing_multi_data *data = ptr;
 
-	if (bpf_trampoline_use_jmp(tr->flags))
-		addr = ftrace_jmp_set(addr);
+	return update_fentry_multi(tr, 0, im, data->reg, data);
+}
 
-	ftrace_hash_add(data->unreg, data->entry, ip, addr);
-	tr->cur_image = NULL;
-	return 0;
+static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *ptr)
+{
+	struct bpf_tracing_multi_data *data = ptr;
+
+	return update_fentry_multi(tr, orig_flags, NULL, data->unreg, data);
 }
 
 static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, struct bpf_tramp_image *im,
 			       bool lock_direct_mutex, void *ptr)
 {
-	unsigned long addr = (unsigned long) im->image;
-	unsigned long ip = ftrace_location(tr->ip);
 	struct bpf_tracing_multi_data *data = ptr;
 
-	if (bpf_trampoline_use_jmp(tr->flags))
-		addr = ftrace_jmp_set(addr);
-
-	ftrace_hash_add(data->modify, data->entry, ip, addr);
-	tr->cur_image = im;
-	return 0;
+	return update_fentry_multi(tr, orig_flags, im, data->modify, data);
 }
 
 static const struct bpf_trampoline_ops trampoline_multi_ops = {
-- 
2.55.0


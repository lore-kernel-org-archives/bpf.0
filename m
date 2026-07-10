Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D441166A
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694910; cv=none; b=ZIOUQDPM04+g3p41GRZnflg7UmlTtCy8BZqSMgCFYvAH//Vt8RAl6jD5aW3plpmTxbeduZ447BirAX8s7+uJ4Rkzxw8sQYF1jWoaoHLKZL9ozciiHcZh2RuXkmWd+oTw8Hbvi2v2CZk+WOXFzI/is4fX8BjAaP5+ac0QhzUB2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694910; c=relaxed/simple;
	bh=ikz2NH0HmLH9i3GQLFLN+FlT2xswhVZKdG1nuTo2Xiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju6gVABjZ3KrB1sSPQ2wwxfUNX5xHnNLUkhV2ydGEVcqAwF4DasNAgwtxCCQJUj8FDGCkx1uQdOaI7KOSeFndbaIMD6wrjWYqSUW7rpPAtAIVTgFMsSS+FLovk7/OfGTJBNjay/NIgEI/ULWx7FRFHacGFp4EzAELUwRpuny9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ptkm7okA; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ptkm7okA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783694905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4uXMXuRn9j+LTje2Yxn9MrG3YrwyITp+GwXCevnXQk=;
	b=Ptkm7okAdJAK7AnKgzhZAzk+d9rioyfuOj9FMPROP2fVkEcVALvLbISIcmuOSb74Wixpkx
	IzWh02RE9yvu1LoLeCI4d0Wa/tea8L7g5FPbFQ/d8BJEzG6fgOYNPf0A/2x7dWM31mxk5S
	W3XqpwfjGICb9e9Oemi981vt3ybOMro=
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
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Mark tracing_multi trampolines as ftrace managed
Date: Fri, 10 Jul 2026 22:47:33 +0800
Message-ID: <20260710144734.78203-2-leon.hwang@linux.dev>
In-Reply-To: <20260710144734.78203-1-leon.hwang@linux.dev>
References: <20260710144734.78203-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since tracing_multi link does not set ftrace_managed, it would fail to
release the tracing_multi link when attaching tracing_multi link and
then attaching fentry link.

[    3.714215] WARNING: kernel/bpf/trampoline.c:1727 at bpf_trampoline_multi_detach+0x20b/0x240, CPU#1: test_progs/97
...
[    3.733170]  bpf_tracing_multi_link_release+0x14/0x30
[    3.733890]  bpf_link_free+0x58/0x130
[    3.734414]  bpf_link_release+0x23/0x30

Fix it by setting 'ftrace_managed = true' in register_fentry_multi().

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..6eadf64f7ec9 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1536,6 +1536,7 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
+	tr->func.ftrace_managed = true;
 	ftrace_hash_add(data->reg, data->entry, ip, addr);
 	tr->cur_image = im;
 	return 0;
-- 
2.55.0


Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63682066DE
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774141; cv=none; b=N2aB5frzaS/8FvYMYpHpJoPSB5hgoo/0ujJ4rEnDAZM1/aWtMtOXMYkZOkIsHoC85/qPIZH+Nz7RKxd7tWj+lwTUe2O2AKO0fOhG2Vm7P6EYC0dfmLjoix7PKt3Dx+mne4dSyXRb0lt33b0n7wbD7TyO+4+7Mgr6DlC9Z1KNbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774141; c=relaxed/simple;
	bh=TfeVSlwN/GjNn5Mk3i297gvTM6ZIhIhJfywSe4beTHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEg9uNtumXLgBU9E/BE4itSvGD+taZlPL4BW9sV65xf+f9BBNRVUO7gi8jBjRqiNqCL0kKHEbK+4Wcz433yrUAA8UUeLsyubpngBwQTtuSH/in5IwEGEhRw5O019vwVBEjrje+hY+BOT4l1rnnu78kgWKZfizKK++SJfkuL61S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/i0prjS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/i0prjS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783774137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8WFbUBXO570IOWhXNUWieBtOnIjFGrLxW34mYupiF8=;
	b=Y/i0prjSv8MzVu33HrtMBHZdh8gxb0x8QeFQ3kW6TK1QcVli0pN+qxtmjSAcDSWGuDKIEp
	13Xphq7VDCgTuR+aq7s1vvdjXDnKM6q4wCF/zk2m+Hl4pzkDg8Cnk62o+c+XWKZwhF4VPo
	B/wqp9bWhWqwVBBfuAELzib20Za6MI4=
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
Subject: [PATCH bpf-next v2 1/2] bpf: Mark tracing_multi trampolines as ftrace managed
Date: Sat, 11 Jul 2026 20:48:21 +0800
Message-ID: <20260711124822.29406-2-leon.hwang@linux.dev>
In-Reply-To: <20260711124822.29406-1-leon.hwang@linux.dev>
References: <20260711124822.29406-1-leon.hwang@linux.dev>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
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


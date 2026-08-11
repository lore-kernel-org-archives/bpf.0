Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B03BED79
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416950; cv=none; b=fSpdX4xn0dgqHtAT6S7XYvAMzGiQ59WER2Tmuozw8XPlM+Xf/prwAYrJT4kx3SAXL5TafRcjC4Jtd9iRvVr5oSPYqkPMLFpYHeRGlt2HoPxODg+LMXRjjc2NJdH9T3BKN6z71qArxF69rDjM39Iaz3UtEDOH6+ZVPPlOIuliAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416950; c=relaxed/simple;
	bh=atw93eZi+ZmnIZz5hDFPYZTbYSbwZuvvn4mXuT+D05w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moKRifS5QW2BB9RHTEioWaI4sGt5h8psGp/VPNxR53eIBRmw+8JO/ATAtR41B2EC3PzBhVip/fB0DBoqP7lKCCvyvB/d67m5JCDVjXA6xIvSCLTItbU/wJSIqMmXPa2v0rocgBMTtzT1TOwSuQp5desEd9xjViU5K187O0lG76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYLIXLdW; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYLIXLdW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786416946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Lta0Xvjzz9D9Pj/K6bIxUSS5eKZQ8RbqTcjjbZ+Fc=;
	b=nYLIXLdWxQp1gvMi/+aka14A0004pJjkiW3TJ0j0YToVkhPWNWsGXhcSiWmZmeEOttIBpE
	YOvN51MV2r9umRivgFp3ujeVdHeNN0MiVMVdAYX5mA6zjQTnfXbSHzzkFfbN0R9Ejc7b4X
	yfkJK5FfQjjaHPl4UNJx5gpjEIIbyNw=
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
Subject: [PATCH bpf-next v5 1/2] bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
Date: Tue, 11 Aug 2026 10:46:19 +0800
Message-ID: <aaa3829e11e2e26bcd3bda9ee6df7a0101a718ac.1786412280.git.zhuhui@kylinos.cn>
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

When bpf_trampoline_update() fails before modify_fentry_multi()/
unregister_fentry_multi() is called, cur_image is unchanged
(cur_image == old_image) and ftrace still calls into it.  Freeing
old_image in that case causes a UAF.

Only free old_image when it differs from cur_image.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 kernel/bpf/trampoline.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ed7999ad6c66..ea4d3c62f289 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1595,7 +1595,17 @@ static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
 
 static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
 {
-	if (tr->multi_attach.old_image)
+	/*
+	 * Only free old_image if it is no longer the active image.
+	 * When bpf_trampoline_update() fails before modify_fentry_multi()/
+	 * unregister_fentry_multi() is called, cur_image is unchanged
+	 * (cur_image == old_image) and ftrace still points to it. Freeing
+	 * it would cause a UAF when ftrace calls into the freed memory.
+	 * On success, cur_image is either a new image or NULL, so
+	 * old_image != cur_image means the image is stale.
+	 */
+	if (tr->multi_attach.old_image &&
+	    tr->multi_attach.old_image != tr->cur_image)
 		bpf_tramp_image_put(tr->multi_attach.old_image);
 
 	tr->multi_attach.old_image = NULL;
-- 
2.53.0


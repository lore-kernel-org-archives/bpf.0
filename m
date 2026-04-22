Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E973279DC9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871650; cv=none; b=hYUSwM8z78ei0BfIcSy1q7RrJtxrChtZC0v936cNV9h/HqQ5Pd7Z2idCKZRAqzgxtjydlnFuJinNJJwh7UuKu8YCGhvmH9yzzdOltN18BAchAAj6c0OB7KnqwpvJYsT/kJKfoXF4pIYIIFpi97Aei5mwiuTXDbqQo32IxhUxobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871650; c=relaxed/simple;
	bh=2N3j5ucTQbrBUWaueBYOkGrX96WAhfkRiHGtMLyOtA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UeUTfuC/upFgQ8VHbnc2YQ7HJISKLF1kf2cNXoeDWFkni9WGUZ60z24ukZeMSPNbkPqhLuLO/gC+7s/To3rK17sjh1Dd/NzNHZn8Eeq6YyscDEvqFIcFZkdBuwHQ43EIki3cnGU1YkWV0IH0nl4vrAa4oRibnbKn10W/3U0GFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlGIUcTF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlGIUcTF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so4447858f8f.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871647; x=1777476447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vm0GJmj+hQcp9hDt0kcNms1KtwgTIV6yhI7GAymI8B4=;
        b=ZlGIUcTFczApsGkD+FrkTjOZlDSTbCRpV/LbaarDqFoSRChpORnwVLHsgjxidC2ScV
         XhVpbeg0C/NT6TilZtQdnj67EkYvEKFGfAXilD+5tcnvheMZpuV5YBYxE2MQad1NIA3E
         3wx+ScwOqTW9sM03/Mkt/dUe5gZ2MFIY9uYQn6ttXtwxSRXLPpN2kmExAyqx3oqRYvOL
         S/yr4QvP6u5dqgSyDjNC+9LjGgwW0wwVlE85CFTmEcMVK/geVqylwaNT7EgODPDCTEAH
         U17wSdBAy3ZGp2Q8YtSgVJEL8L3Mq2LFBh5L6mRMdO/KRBi8PZvdSdzd0LVBdINDByC6
         locA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871647; x=1777476447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vm0GJmj+hQcp9hDt0kcNms1KtwgTIV6yhI7GAymI8B4=;
        b=WokPpkS8qQ6BdeJBQQzCJPRh2p527R8zKUt12Iyqpe3D27slPF0hYT0jIZbQFwtbRH
         f3k+Hvp8H4PKUOv0nBTihBp9ImJCPXxgaorP5oDx4MoDmMPPU4BWSB3JgSCXRuBtLGCd
         qsiwnucHeYQ6zWrQc2frp8tw+LJ65GaoWu9FqYbSS5vwGZ1HhaM4mMWZkYQ58yLewwu2
         9F8+20XizAJ6YjOU8/FAaFCUnYrVA86D+YGrBJPXk+5mplb9jf0Tf+tYQ2aFSyjvHVkB
         jpfSpPKze3lAdoXr66gTn0e2DrCGsxVs419YMeegfqLXUZYcd7oF3v0y8gX8Pexe+1e/
         KwiA==
X-Gm-Message-State: AOJu0Yy9o1qn1ToOpsV4bRNeMETQdI3lOnTMPOE/H3/x6qmuPnXos1ML
	iHufsAlZh5eEQybeIrbdeRbshZ/ED2RsQ8KDUAaa8BPkst9IODlicTKIRt4gtiQD
X-Gm-Gg: AeBDiesNSsUzGb9xUCcYSmGtbqQJzgO2dkC/vdu+8WvP2TGRAgUwfE8f/37l84gOFVo
	uQxKdhs2GkOlpjeR68+LO7pkomJuIvEkaef6TT/vGj8JpuOjaY45DkYMuzp/c/Kbo+LemB6hFiW
	4CXWJDLVpp8gwIx9gJr35fm3lNAElkLIDg9FwakFexlYyy9j66GNLB4ibdjzVrDsF14PwVGtZhy
	/Ve60/9eLQkGElg/Jst2rkFUwAV7wdw69VNX3wRK5oNBWJ0Y7LdT0C5M5QrdzfRuy5Zljp1dwSh
	HNVPXuqywm4p0eZZUFJt0yuLStuUaLtCyLP/WxuLkRnEk53SOcC84DxA14BhjNDcuhrz/DvCQUL
	b6JxDuYmPGHGCwz1yyzIXxFxG4A2d1b3OFF92izSO9vv86NyQ1Jx/4ZG2nmmsQzuJRm75YlfcEY
	eXuHw3ncfgefKh9NjbU6qiCB03
X-Received: by 2002:a5d:5849:0:b0:43e:a8ad:975e with SMTP id ffacd0b85a97d-43fe3dfbedbmr36078606f8f.27.1776871646554;
        Wed, 22 Apr 2026 08:27:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm48578623f8f.27.2026.04.22.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:27:26 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 08:27:07 -0700
Subject: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776871642; l=2503;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=KkM5exrs3d4r5Zr6eBr5Qx+oH29B7xEW6khD6rekePQ=;
 b=7BDqtdmkpOap0azDWflSCQJPxKlb4yU+roA2efvcf9Ih6FSNYH4Dh3FCufTNZ5UEnbBlAXFvr
 dHOFMc9jOpLCvXoqPih4KPYX22qRTMWTCa1hXmE02nYlFjDUPkJbGzZ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_prog_run_array_sleepable() for running BPF program arrays
on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
includes per-program recursion checking for private stack safety
and hardcodes is_uprobe to false.

Skip dummy_bpf_prog at the top of the loop. When
bpf_prog_array_delete_safe() replaces a detached program with
dummy_bpf_prog on allocation failure, the dummy is statically
allocated and has NULL active, stats, and aux fields. Identify
it by prog->len == 0, since every real program has at least one
instruction.

Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3cb6b9e70080..4bc39eca1863 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3079,6 +3079,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	struct bpf_prog *prog;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret = 1;
+
+	if (unlikely(!array))
+		return ret;
+
+	migrate_disable();
+
+	run_ctx.is_uprobe = false;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		/* Skip dummy_bpf_prog placeholder (len == 0) */
+		if (unlikely(!prog->len)) {
+			item++;
+			continue;
+		}
+
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			item++;
+			continue;
+		}
+
+		run_ctx.bpf_cookie = item->bpf_cookie;
+
+		if (prog->sleepable) {
+			guard(rcu)();
+			ret &= run_prog(prog, ctx);
+		} else {
+			ret &= run_prog(prog, ctx);
+		}
+
+		bpf_prog_put_recursion_context(prog);
+		item++;
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	migrate_enable();
+	return ret;
+}
+
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {

-- 
2.52.0


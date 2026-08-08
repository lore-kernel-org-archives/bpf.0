Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10009369D56
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170368; cv=none; b=lWg/7IVsHbz+EbdcojahC4mDpIDVO4/Ny7pSX7pFug/B19JpXX2aVFrNhLC5yKPfO9UUERQkcf5QXwZsGPJzGvToJa4D0AYv8fq9E0XVJi5xJ2zo48nZlQAg5uNMEWrXLSsWqcqM2eHYGBVG61ViZdPhMaxz3d+f/cUclpGl4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170368; c=relaxed/simple;
	bh=BjIKCZl1uk4TK204gwSDoXcebMgwoaXrbaJuMU2SE58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6u4ebl2m74dPhpFvCyhayTSNHwjXlqkJbd6DO5jxRxCJTSDyWQDEQRfe64Rnw+oghFS9ZrLrsxl9pM+d0I8p5Z1Ls/g2KV03xKakQI/CAAuX2YdbtoB55bQ9qXdMe3/R1Ig8s0fc3YWaFd0Y8CKwSlz5ZOY+M7GTcRosZ9K9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3zLqdFj; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3zLqdFj"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso31720f8f.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170365; x=1786775165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtctCLSaluClI2dqjvC5Cd6YTxUYqfW/IhNegXlbRy0=;
        b=Q3zLqdFjXq4t8mAFdgvDmFc4uy4t8PyH5xXN2Wa1iG2+6nFM0q2c5iPGlCr6dRzjyq
         WqubQzg3muQXLSCbklCO5UOmKRD0jZa12N6uptmv31PdrJ87PLpTxsqZ/2SVNBbH9Vh6
         s6YuK7Y5EKmd4i8RAAC7acd/YQZ8QrADvjq6+DJS+mm0c9fQUYzKhCyahxkF7ZOhQZKE
         rufDjo+gQYIFJF6sa4LDolB0NZfLydE0hQnOLMFKQIUMufgOe8TYq1ELVjL+pLFTonHc
         I2+dMemB/wxKOUpF4WHcN/touKsAyO8HJ/T/Tw4+4qHGYt3IjYBc7WwgV8tcApMBR3Uf
         8MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170365; x=1786775165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rtctCLSaluClI2dqjvC5Cd6YTxUYqfW/IhNegXlbRy0=;
        b=Y8MqNQWS/9uwfOGqpsDjpZ7OE/Kh0UKnIRwtD8MbQnyjcLavqj9fgkX7YV4g085dqd
         4YBYoBuVt03r6Tg+iSJfwtM2oJ5r/URWT7KuHu06h1aks8qcXFoK2BsX0Grm4f0ZUHgC
         VQ0aTFBw/Jm8NWkeDaHoijheysjZLppWoavvnxuZnbqqeHwE2WcO9NP9QcEaE09ACVji
         Ym9PkkgFboEMEuGNS161UwG9rDSgEnL73rcLCPUSehNmX4sflP8cwpIVN1OTOlkDVTIo
         Rb202ORApgmEDPC26jphzr1O6bqULbW3ib5qNnXAFmRw/kYHuzrLKVOnm5ODnb96QvKN
         BXSg==
X-Gm-Message-State: AOJu0YwWz/k0nMin4mMYHYVfCZq40bwzrL+TkYwl0LA6/CEshdUHh16N
	j9it5CWuaUVbvKDRki22WHnXl1YXqG2NFJchRT/DYs7kcIkVHBqkxnxCFpWTchfjEm0=
X-Gm-Gg: AR+sD13DTdrZxCPk77MZpP5sX8IWpyam4hHsKjpCrxtfzhJZxOUXPzFqiI3iIa/diyb
	raaYFt6MY8FXKx8uP62Rb/EvqWAXpelmV427zQMKt5Ou5tc3CcbGmzyMmKzx/S88XphC8nXP8e9
	UY1cuuqN3mCqAD47+Y59dDnmZwktue6+ISFYw2z6H9/1t2bW0+4pnX0SjhCMhhYnmyz4OGfpJFb
	xuqIT+IZIgVGxExbIV7kowPYGTy22VC3SUHDDukrXYhGd4DimE8xTPnhuYIn2kwBYPBcdcds2h1
	1boBWtLaoaae17qsmetyJjodnZwNvXimpAC2fr6/t7D9qP95jY9Gec1mWTFprVGm6jTqifo0bPE
	MuPurJDUG75tdUnsQBxDkTjSJBUFChVtBVjhUhRJDI8/jQJ3eRbblJNVxhRdLgEjk0fmkQRBaKh
	PfFVIosf3LQhQPKUBf8dUP3eagIcckpxpcThjgu8gy8bxSIvWDG8QvpWxFrt8+y6ohMFnv02hOZ
	VhY57HqxqFAIVMr5vL64MFAEYrDRbg2/mxZRgIJQQm0czy9ahZuVAeNqchWkxVlXFK7XBTbUY+C
	uYWv4xptx7oNvmL4jeCNFgzE10+FA2Iyj/T9qA==
X-Received: by 2002:a05:6000:46d8:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-48130e7e741mr4988253f8f.6.1786170364949;
        Fri, 07 Aug 2026 23:26:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm12490773f8f.17.2026.08.07.23.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 2/6] bpf: Attribute async callback instructions to verification roots
Date: Sat,  8 Aug 2026 08:25:54 +0200
Message-ID: <20260808062601.1070988-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062601.1070988-1-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=memxor@gmail.com; h=from:subject; bh=BjIKCZl1uk4TK204gwSDoXcebMgwoaXrbaJuMU2SE58=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9C3NT+1dtxVKS7bINTn9dxEt8Z2rzbHdrvrue2Xhq zMExXZ3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLPQhj+x8iUerdGt303jp3/ q1BiuqMMg9Hrm8r5TlM3JNQHBVlKMfzTl12mtyk9qrR65lfNnFkrc/JcjD4e2KK2ZvUCvfvNp5O 4AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Asynchronous callbacks are explored as fresh frame-zero verifier states,
so normal callee-to-caller accounting cannot propagate their instruction
budget to the main or global subprogram whose verification scheduled them.

The callback exploration still happens within the same do_check_common()
invocation as that independent verification root. Record
env->insn_processed before checking each main or global subprogram, then
override the root's inclusive count with the delta afterwards. This includes
all directly and transitively scheduled asynchronous callbacks in the root's
total without maintaining a separate accounting call stack.

Static subprogram and callback totals remain local to their synchronous call
paths. Their self counts continue to account for each processed instruction
exactly once.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 855f245e7468..9b76851dcf54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18762,6 +18762,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
 	int i, ret, new_cnt;
+	u32 insn_processed;
 
 	if (!aux->func_info)
 		return 0;
@@ -18780,9 +18781,11 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
 
+		insn_processed = env->insn_processed;
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
+		env->subprog_info[i].insns_total = env->insn_processed - insn_processed;
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -18809,10 +18812,12 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 static int do_check_main(struct bpf_verifier_env *env)
 {
+	u32 insn_processed = env->insn_processed;
 	int ret;
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
+	env->subprog_info[0].insns_total = env->insn_processed - insn_processed;
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
-- 
2.53.0


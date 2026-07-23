Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B32C0294
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783295; cv=none; b=DIVfRPD9tCpHpW0rJEqhOK+YPhrT0vrj77/hlV5R3ma9MZaQ5qzWo4KKI0A0DbIE9V3XMqOvZC3tggkbkxHFuKrvc4Tf5nZWJv+GHuO/GyulgDdCX5iv5goaaJwIka6DtvOppCYEhYWjlx8cedmWIaqNpIWoCIY5t/C1uLWnGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783295; c=relaxed/simple;
	bh=yyIeP1iOuHpuKCUXegdZ176PU2ppIqz1dbsSlJx34fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzzhQqlaV7pgEc2z5ojvhCDY2usx1tOAanT8u3/bhVAo47j3/sRAYV9qKdiP1Agw1PcxeWwNRWLZOd4y+jntqjBPUuTXn5/oq3tltL6ghDUYP67QyNk9HPfj0lbSmQj6ZgJpRFeZ4ssIQLQpIy1JvmpDpX8DgHpDgz+ZSFV/5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFAVwn+h; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFAVwn+h"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so198682a91.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783293; x=1785388093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYo0t/apXz5ftMpgwq5iLcU5kVtHf0O6QX/wz01qxU8=;
        b=rFAVwn+he+4XiXiP3yChdeF8a4zZ26OQFeoMGwuNXZHJqt8jq3YYkGxSSy2NdLTpSL
         dpnYiAM3U7NXnHnvs/2YN03rqZvJQLa4QGtC5ca9Og1LQPEBGaS5IDq+n3m3bo5Jxw0U
         s+MM3SyvPd6qBW56Psj34SMWcls1E2ejfuEO65bhrmdRw2I/Xf/ahEQRW20a3Ey3ONAT
         WpNP8sGw2r3Itc7RHzf5go7CJZ577LWkRmxcH6YgljBqDwqGxIuS7tijQ8gqpxajyN0+
         rnAKkAG3vsweP7mGfkMV3oF/09NCvyp1j66hTXbAw+zJEuQfgp8L1E4cOGFJGTPineca
         Bmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783293; x=1785388093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYo0t/apXz5ftMpgwq5iLcU5kVtHf0O6QX/wz01qxU8=;
        b=exnCwDL1JAG2gm0RrzyiGwRv2yvaFwerG9YYb+OMOJHn+rYQ7P+MbB+9NFjSNT8Ey8
         9DgNPwSD7PADtyGa/mSEN+0RbgNh5ukOg6rhhRkmz3kbOQsXSwwPA9ICs859YGCG8+Yq
         /6ZPLPryDbfldfGrBoY7odQK6E+NooiZvdqbNs9N9S0NwKzyTPtFkZcUWAl8CtXTVvK7
         YXuRWpBKF2QPdR47Irrzcm4tjf3hZ2cLpKFiX4H++W1kWJj2ReIh4T1HRIZUKUyhhQ8P
         iDmtmvHahr9AevvJi20bfaJ/pPNAUKTcz64DtGxQMjMmXLG+G10vz22WFDLJu4zKiMpw
         AtVQ==
X-Gm-Message-State: AOJu0YxjPjh2FdxkzJC/HIOnF+pXVnKlwhuf60Ft4yjG3RJWso2REzyP
	RnVCGf2x03ZAuH+bS7Mff24bAFNTY6drTJu0TiQtBe80hRJIcXtILakXnjN//w==
X-Gm-Gg: AR+sD115yhB2eZ4FTUB3zbj7fSj+EGIkgu/3QL6KiV//SUeeBoyFhY/ZtHHuyQU9jFW
	VCwx1+w42b1tesQc9h/GLmY6TjOGRjJVr/KAxpnA8XN1dvyVkCPSlTJl0CZamtQdaROmwwzERe9
	WLwRvt0r793DQPtLcmizse8hzCsz+nn0CdPtK0FqmUSbq6oAVof2VMiUZYoDpi87UXeeSH6EbGR
	Bqf1wmk/nNmcUAlrfMOT/Cjp13HAb9tVWWDVhTuZlhcJ+4wJ39TByuR8DQNGGWysya0gIVqEV2e
	H+AxHm3uNiHI91yMvQ3uGNDlgIsZ3G96B+t4Jhfv0mL7ZzjaAVmb59YVhYi5qRgbSKm5Jv8gg8s
	obzMOVomwj1BqCZ3oYdD8Q9rUy89A8m75R6MqvutccqzVu7KqcvgX4jsLNhhhVrcIunHH
X-Received: by 2002:a17:90b:3145:b0:380:540:d499 with SMTP id 98e67ed59e1d1-38ec695694dmr1476520a91.6.1784783293348;
        Wed, 22 Jul 2026 22:08:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecab4c061sm288719a91.1.2026.07.22.22.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:12 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/18] bpf: Pass kfunc meta to mem and mem_size check
Date: Wed, 22 Jul 2026 22:07:52 -0700
Message-ID: <20260723050806.1158442-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfunc now shares the same bpf_call_arg_meta with helpers. Pass kfunc's
own meta to check_mem_reg() and check_kfunc_mem_size() instead of NULL
or a temporary meta on the stack.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0ba0de8eb8fe..29d45636c28b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6924,7 +6924,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 argno_t argno, u32 mem_size)
+			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -6950,8 +6950,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 
 	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
 
-	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, NULL);
-	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, NULL);
+	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
+	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -6994,22 +6994,20 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 }
 
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
-				    struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_argno)
+				    struct bpf_reg_state *size_reg, argno_t mem_argno,
+				    argno_t size_argno, struct bpf_call_arg_meta *meta)
 {
 	bool may_be_null = type_may_be_null(mem_reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
-	memset(&meta, 0, sizeof(meta));
-
 	if (may_be_null) {
 		saved_reg = *mem_reg;
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, &meta);
-	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, &meta);
+	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, meta);
+	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
@@ -9264,7 +9262,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size))
+			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
@@ -12410,7 +12408,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret = check_mem_reg(env, reg, argno, type_size);
+			ret = check_mem_reg(env, reg, argno, type_size, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12424,7 +12422,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
 				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
-							       argno, next_argno);
+							       argno, next_argno, meta);
 				if (ret < 0) {
 					verbose(env, "%s and ", reg_arg_name(env, argno));
 					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-- 
2.52.0


Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1300F9C0
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566781; cv=none; b=OEz03V2iUE1ChhAU+DJFR96uNb4aeSUStAKXjKiuTe6n7eLtE7TORTtRUZ68LIQNiQE5QfovyasJ9aAViqZ+hFC4/5JKzpRn0Qyg5m0mSVkupTZJ3wq3+p9AuK649wQssan5yZ07gOU8cOzNPyBv5wSnPSaLRC64/mz79zLklMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566781; c=relaxed/simple;
	bh=8NxyxHCT8egy+UWS5pwfYGyCK/nQ7Tue5th5bPz/ac4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFZ8scaWUBIRrYuZS5lmGDUKcOwkcjnJ6ET9ryeuXz4MCO/7Q8qjIWu2TZVcrbTJzxBN+ilVZwFGIfh4q894e4mYk/l4ykHlDe9GGxP7f+dZT9e8mOolv/y1aXu96fyKQSyniN69TZtgTGuBBJKKiOujxx5niKGNEq5g91BrEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTGi8+x5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTGi8+x5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so1773880a12.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566779; x=1789171579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Veg/L1QP4ZSDTaDKFmMvICr2v8MrXl+QTe9eYSlf1V4=;
        b=LTGi8+x5IKougdyQxlybtILbePLuis9/LK7Y5RRimkbHh/Vn4IOo/9jdqaLDqtdMnC
         VE/yMghhRRvoX5n+K4f1NYYK/WcZXWKMa3+e1yKsfysHlh2ez0GVoT5e2Jz3ZtAS5QqZ
         QtdcyC6mA9vTzh0uykdNdC9DtCII5X87Sj3iyita/A3KIPTz59bfMrlnR5/oBAZjShl1
         V6qZl2EOdOLNbIZjjfiiXryYTSl2nPXrSC6OJg1e/FFug+pGAXIhOmdmc1yZ6kBIyEVU
         bbargu4IR3Grv2UYi/9yNkkMr1aaX7tO9xvnoABc53cpEofPzwdeq8eh/fsi3o69tey9
         5nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566779; x=1789171579;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Veg/L1QP4ZSDTaDKFmMvICr2v8MrXl+QTe9eYSlf1V4=;
        b=SImdKxwpjR7UvJ/2dy8Ns3Fv11cO8gxX0gGaG3tevg+6GRKl+Uh6CH0GEi2xUT/NN3
         IHXQDEbpmbMekwpUPZ0LSyzVn8WVznWncvEdP5bVy/G9EgGZq/AEa3S6XhQZQ7/WueNf
         K+h6+7kQtFk/dbzQBydg/uYQMd3KuQ/5plY3eH2F5C4paGEaFnmDduKAH5qWMv0wpW7u
         6i6QaOuEq5laEtZ7ZBd8uJyaTp0mtioF9tl8264ZFV3M+kfh2ovjM1uA3cV2IoiQHM4n
         geBI4wiw3RRb7eqSP6MjxoiLyYuJX8I7H3roWgsxuTftQQvYsrnDnXPLDHaBR/uLqtJa
         ZEog==
X-Gm-Message-State: AFuF++nfTFFWsIz+0b548tjMr+TnDT7ME0Z3Pe5j3ANLNR/caYx55ZmL
	t8K4gkM3g7/0KoQWcM8X+Jmoo6z/yX2FD3V1GwEWJVs9AJtUHlTwVVnFoQ33D+cQhr8=
X-Gm-Gg: AYBFou2e8A5XwkaPzyKKBklNG3brpjhEv7VXZcwJC3q2mtKmKLwasyryadHJZ+e8WMk
	7EEHIUd0qM4YKfXn0aLhog+Cj6S48VpBtfdfNXC6lbKIrxBSztRp55xzd5vGQTkEnxPV2Krq3mJ
	I4Tr+VXyPQeH/BWD5XNyENrLfSKY8kjkVo/OOhrLkfRGPU+IFx+LL037+MixG25SAqpKDGQa256
	BdUl5oaH+JdzXTcFXfUeNcEqs1yZDL5H+6AJKdZtOAEJEb6W21UGqX3qQZeXqJxttmHq/jANxmu
	k/zNNF3/1Oe7/tYDvSwTNWLx/aPjJ28m2XBoZWuhdoCEtgTdSO/JTufjNEBjbQgJZIPpLecZGDW
	IpEwIC1unGDcxC5GsP1MQe6QZJOHEgOF01KJ3ZbChNdzJqCfQ53SgcaJn0SuZzMdFASvUnKD18p
	5UHX0idporZFt/hEloqMYPHOm+M4AnbYxC4iCEDATXGGwiQxplJQ7KqvzXm+eAnm6TjpnBvDQWZ
	Zuvem9gdFhQ9d7iiJWbu6R2me3C4E7XhuAzGNtH6WLi1rJN3ETh1UiU9w==
X-Received: by 2002:a17:90b:28ce:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-39b26100cbfmr16084442a91.10.1788566778761;
        Fri, 04 Sep 2026 17:06:18 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 03/10] bpf: mark a NULL memory argument of a call precise
Date: Fri,  4 Sep 2026 17:05:54 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-3-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_mem_reg() allows bpf_register_is_null() for nullable arguments
w/o marking the underlying scalar register precise. Hence a checkpoint
created on such a path would prune against arbitrary scalar value.

The argument may live on the stack rather than in a register when a
call has more than MAX_BPF_FUNC_REG_ARGS arguments, hence the new
mark_arg_precision() helper.

Fixes: e5069b9c23b3 ("bpf: Support pointers in global func args")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca362a7ea58c..b758f2822754 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4246,6 +4246,15 @@ static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
 	return mark_chain_precision_batch(env, env->cur_state);
 }
 
+static int mark_arg_precision(struct bpf_verifier_env *env, argno_t argno)
+{
+	int regno = reg_from_argno(argno);
+
+	if (regno >= 0)
+		return mark_chain_precision(env, regno);
+	return mark_stack_arg_precision(env, arg_idx_from_argno(argno));
+}
+
 static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
 				     int nargs, const char *callee_name, const struct btf *btf,
 				     const struct btf_param *args)
@@ -7168,7 +7177,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	int size, err = 0;
 
 	if (bpf_register_is_null(reg))
-		return 0;
+		return mark_arg_precision(env, argno);
 	if (known_memory)
 		*known_memory = true;
 

-- 
2.55.0

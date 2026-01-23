Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96C30BF75
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187950; cv=none; b=jYXb5TP+sCiQ7311ltDlFWThsR6AAqQv3/XJbxkfFeEmHvaySh7F4QQkmSKLFsJ/tIfQd1rdkBHojFolIL+e6yRbBnuYKK88T5hN/p2K1RZ9qnvqrpmZJ+Bk+CiBWYXeGl7lMe5o7b2v5SYyeR5DgvhzmWxPcV6Evf2ThO+DDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187950; c=relaxed/simple;
	bh=gvMdbX+icg3dbCnUJIuH0NKGuBkPVhNimUGLo6psQUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jICcRFkmQn3dDcn/Tj67xeir/lTEwZCnqKUeSgcSisguJBfuo7S7xEFa9XX316cyIobNfIlesjhqrtKwjQpItwYdLs4D8Nf1SZ7bVq8esddwB6fuf+mKpwWAsEPG1/E/zr1/CNclxbutDmXjNoGdI1a+yX2m6enU8haORLqYpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EMsksjct; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EMsksjct"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso3771314a12.3
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187937; x=1769792737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfhpj3sesnQM8iPrv156X7I9lkAuKOzp/WiXCsy1IVQ=;
        b=EMsksjctoQqgLu685d4nuKSEJniJM1INUwuh9/4x5lcEe9XGFyjifdv+2bMKeMyzza
         JjxBXgIdiMIhrAx7vf0pEimHhbOBXsxwNQhHgfiEKK/9EEM8yt1MIhLDB/PVs6x99z8d
         eYyvBBTUqFFP+BiLoU52Bydkr9QvGrpaEdK+tOMx7TgOmCwtX5WkNWE5+Tt2K2SAJEwZ
         XhZJGyGwNjpK/6e9cFQeyFu0qKjFvhqq9P/I92dWG9bZ5/8vkt/s6hV+cpH+laJGj943
         Kdy2P1/hbaY4UaNXN+aXjj5kg3xlBOtnSYSeAqebu9pQofN36gnMafjrJvZM0AsYLUo+
         /47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187937; x=1769792737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfhpj3sesnQM8iPrv156X7I9lkAuKOzp/WiXCsy1IVQ=;
        b=gOWsM6fhpHhVbh4XmnQ6u/jaVUnULFfWpaRlz41RAhxH/o5LZCNyecKCxG3qTRs49A
         jgAc/lKiAP/2eNEOkBsMk7oRl4h/CTZuxcPBV/7q2Gpyon1oVxsIznrMVxsY/q/XKdCV
         Ts3FJoELbVe4NGJGaMnp0WXFMcJSp/m95cpRHqkTL8hQBiCBdvlWL2aMu7VpYx5PNKZV
         q2rs0nTdvYM74G90M/UvZNcwA5BScTFpp2esTmplW4BRDOloQNGpsRnARljy4IKyPvEu
         04Fr5I2ojNCP/WyS/xf7jU/2xAj2H5HNeQvEcOYMcJzfPC0vOAe492aqYetiTiPKAqHy
         5VUw==
X-Gm-Message-State: AOJu0YwVzaRjitrlFg5uqxeRgZd+v7SHrtx+gBxe0XMscucmEkeGThR1
	ozaP+NvR6N4l1BaUZoUlOOLk0Ljk6cG9EVhef5xWj8paG4JAtD8G/wN6PSBX70oo1M4=
X-Gm-Gg: AZuq6aJP/NqvvcKFYaO14T1rYiqEoHRip/emZvvrbwGmv1Drl2xoLTiLHbJLFWCBEAs
	lnFDLF8ULqflYJz/weJtka1n15a0IeIrxf9HtzgnFIoNPGdff0d+i5qMXO/iscQmpxlRotWntcr
	JqSBMfLlg5/Vd2OxEJLz918ubNTTEhH8vNvSqdb1iU4dxnG8A2zUrPmbOTGHk2QfMbRH3zuy6RQ
	86SFhzldY0414X52xmyewvEbRq4+97CAk/pCvydT9BuqPbfDdIrrzr3IgALAOVpZ6SI16XeO3Uu
	BIXFG6uYWJOsf3CsCdKKmaTGJib3cWP7swZgF9TQAUaXUp7PmqOsgq4izfC1A7UHPboY9ycJU2h
	p2d+t12vAqHEe3KkyaGt96qOyRkSt0IO68yVLQVnzarq8Iqhwb4EvdDd/PvMxIgA/9ZfpW6QndG
	UpDzoEwTVCPvHlhBLkTEVPRp8uZ8MP12RgPCVY+A3NLQYEaa309Ho=
X-Received: by 2002:a17:906:4796:b0:b87:2780:1b2d with SMTP id a640c23a62f3a-b885ae9e6dbmr264270966b.56.1769187936849;
        Fri, 23 Jan 2026 09:05:36 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b418494sm137107866b.21.2026.01.23.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:36 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:21 +0100
Subject: [PATCH bpf-next v2 4/4] bpf: Remove kfunc support in prologue and
 epilogue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-4-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Remove add_kfunc_in_insns() and its call sites in convert_ctx_accesses().
This function was used to register kfuncs found in prologue and epilogue
instructions, but is no longer needed now that we use direct helper calls
via BPF_EMIT_CALL instead.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b4feedc14c9..41ff0c459a66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3543,21 +3543,6 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 	return res ? &res->func_model : NULL;
 }
 
-static int add_kfunc_in_insns(struct bpf_verifier_env *env,
-			      struct bpf_insn *insn, int cnt)
-{
-	int i, ret;
-
-	for (i = 0; i < cnt; i++, insn++) {
-		if (bpf_pseudo_kfunc_call(insn)) {
-			ret = add_kfunc_call(env, insn->imm, insn->off);
-			if (ret < 0)
-				return ret;
-		}
-	}
-	return 0;
-}
-
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
@@ -22223,7 +22208,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
@@ -22252,10 +22237,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -ENOMEM;
 			env->prog = new_prog;
 			delta += cnt - 1;
-
-			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
-			if (ret < 0)
-				return ret;
 		}
 	}
 
@@ -22277,10 +22258,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog = new_prog;
 			delta += cnt - 1;
 
-			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
-			if (ret < 0)
-				return ret;
-
 			mark_helper_calls_finalized(env, 0, cnt - 1);
 		}
 	}

-- 
2.43.0


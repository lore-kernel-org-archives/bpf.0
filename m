Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7990218592
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573172; cv=none; b=qnBaosT9/Z/U9SZTmZh6qdrrcEcL8vBFLmNb1pPq8Nc2dXfb3Wo7XxWijdVNHBh+uZDZct5n53hZ34OcqAnmJbktyJq1pzKALsm2/3RblfCTBdtTkoYv6k97d7YWiz02HMBKQZUSlpUzwIVnDlCIijAjIlFeb1UT83+7ipJa8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573172; c=relaxed/simple;
	bh=zDtCQKdSH9h4/LiDZ0v4auVC0wimmikwNKkqXnteFKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0nFPRRV5KOGvUbJh/n5hjUtXDoy9FYhrtQiRSvUPZGPtgJe2w7D/+7vwwZYLwvy0nU2YKP1+XNs5yeiB7PzQSxOnq1CGPkuQf8Rp4VjqYe7vtTRIsoiQr/7L+wIFDkY2xWfg/53j+/BIG2U6l/EQHXIhPAw3AuqHJzKWPIQOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZBJCh9h; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZBJCh9h"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so210272f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573169; x=1787177969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOXlOiS5QgUinobhbCJCt3+KShzgBvEnDGVxRzQpxDs=;
        b=fZBJCh9h4fMyK+BNj9H5FcJGa8IpJGAi0SzKoAo19b616CTQ1xkPjAw8iTTGDcqpYp
         fIUhCopSLSeL3tBFBpZhzkMoVluUGuagQCrU1lUp6Wl3n9MpZP+2H+ciTiwtBWunHX7x
         c0WKnCGB2p0tc6Jg8Q6tGPm8gThCXyUXk81tcCHaJI71n4pmBq7lzcnTkSr4sthAe4g5
         dlrG7HKTyIJhrl/HemN4NAa5ybkBUdzYzG4p97l2QQcMny4JfIDes8GpQkpDr3rxQpDL
         Na9VKM5XzdMGm3SOaf5Xo64yaG/2t9KxELOeQp7MjrmvJuIQqcomVhg1mpiFlE8cwdAT
         Rtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573169; x=1787177969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOXlOiS5QgUinobhbCJCt3+KShzgBvEnDGVxRzQpxDs=;
        b=Yo0hb/NcVWdnm1SRQQ/kt4WDIlkNJfNEk2ohvcYJo2Wt0QwSFqIkYszdeX8sFoOB3b
         +pRAmaJTnNQ9xqIkEI68dm+lPv+O53e/v5wuQHI2PDrimOYVMssOV6jPT/dYz1N0wm7b
         jmvj7ENNmcE33E0w+7P3vMM3lw0TFB1ot0vSw4fkCHrxKnDufI0HhMEJh8oAAK3szABH
         zermUDGHsm2BY9DS/jEFH0XYL0Dl7CHvPzLDMVNlpKBlmx3BZ2kLnCpoFPHnm10L8Nll
         5FYrOVcg9RsfWu4q1VN44KoP/H5HOgBKZMPyVUMTNTv3SP1Sj+ZIhhe+152ad6x6AL8i
         GH7w==
X-Gm-Message-State: AOJu0Yzai/7o++j+1SAWafyImEWCtnK37UPwm8cPBkyHX/+uCZ8anJUW
	LebFlS+2ePkJhUpt86meLZAYmyQDjW6T9hTOv6tX3ErFeVOUsh3fzyOTzQQplFeA
X-Gm-Gg: AR+sD10C33jE0ZeYG+pBJd/VlUscyX+LxwfFa/wEskNtBGyEiQODXhN0YtcjhSRiIMJ
	N1xsYvT3sATi1ZT7e4uA3ncUQRzMnO4s9PpNWTxo65W+LXoHwAl6kNHLXC/DIzFGRIu12toiJgc
	Am/SUdF6HaTh7yrrlj0dOJRPPabEKiY7LkgQbkvKvqggpzfGQS1vG7sVIUOvfz38RBFPj/CJF5D
	LIunBhsc0OrA5SDXtjRd+Ai84bX0mMAX1sFA+jXlN+rBi4FmE05JoA0bTWO9coXqxRyGH25wdrB
	hg29M5xP38STpQsq4JElovan+ozOSkgYRknzdbwvtmDQwIVD+TGC9g72f16zFn6ZtHkA02E0b/g
	ck6bzLHo4shV6id6he0t0ZiFhTHC8UvwGrwZVneVZEEd9Y4rCUm3+qq0XRXg1ZQ6sdgNhZGi6Rs
	4ISdPqzJd/pYOyqyarN6C15asjkXv29eUHp6ph1PxofbQLsW75TcwFQtUX9dcQm0hCBUCi9RdmM
	rB4e/nmAorOUJwNhKjKJIju6LvmjbY4JnIVUqoBnjCoT0tj9psLC+F5z2c7DTk4TzXu8tykwu3F
	jrFfV3rWEO3H6a7YInmlpbpHIRg=
X-Received: by 2002:a05:6000:188e:b0:480:b3:aaf4 with SMTP id ffacd0b85a97d-4815a5bbdf8mr858763f8f.4.1786573168978;
        Wed, 12 Aug 2026 15:19:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6fabsm1039467f8f.31.2026.08.12.15.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 2/6] bpf: Attribute async callback instructions to verification roots
Date: Thu, 13 Aug 2026 00:19:19 +0200
Message-ID: <20260812221925.3358041-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=memxor@gmail.com; h=from:subject; bh=zDtCQKdSH9h4/LiDZ0v4auVC0wimmikwNKkqXnteFKk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmw8+bWl/Wzl+by7OiUODgI6+Htl1C3Q9efxbnnt4ir pkqvutMRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbC8Y6R4VbWdYE/HLaCi9dH CfBc0VNa4vDwZ/OCWaF/vY6wHj64soiRofFT7R7Pm5rmfLaHqlP+Tbe6zxXm61QelnMw7LNbp/l 2dgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Asynchronous callbacks are explored as fresh frame-zero verifier states,
so normal callee-to-caller accounting cannot propagate their instruction
budget to the main or global subprogram whose verification scheduled them.

The callback exploration still happens within the same do_check_common()
invocation as that independent verification root. Record
env->insn_processed at do_check_common() entry and override the root's
inclusive count with the delta before returning. This includes all directly
and transitively scheduled asynchronous callbacks in the root's total
without maintaining a separate accounting call stack.

Static subprogram and callback totals remain local to their synchronous call
paths. Their self counts continue to account for each processed instruction
exactly once.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51d754bdef5d..fced21ec2304 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18448,6 +18448,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
+	u32 insn_processed = env->insn_processed;
 	int ret, i;
 
 	env->prev_linfo = NULL;
@@ -18590,6 +18591,15 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
+
+	/*
+	 * The override is needed to account for async subprograms, which
+	 * are verified with their own set of stack frames and thus are
+	 * not accounted as callees by account_current_path().
+	 * Accumulate their total counts as total counts of the main or
+	 * global subprog hosting the async call.
+	 */
+	env->subprog_info[subprog].insns_total = env->insn_processed - insn_processed;
 	return ret;
 }
 
-- 
2.53.0


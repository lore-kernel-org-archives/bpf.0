Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F01FDE14
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771043812; cv=none; b=UYuV9MPLnBtE0Gp8HAJm5DySCI5rc9hG+msKNC1juE+HOLCI+ZwulU4X8TSMpvtlTAO2e3ZQG5SgSxEgy/yicBEtO6sNcvymVpjMUCUon2v+FGogJVYZyVOb13xOMg073FhYUbRddXbCH9PoDZt0oTn/YBJxgvlObGulMbFs2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771043812; c=relaxed/simple;
	bh=0Ut/Yd2xFzBBknyWQqwazN3LxjtJIbDOmzRkADmWq9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQxZyY1uxM1JwlgZ9lpTuvfofPnlGXVZE6IKEIYw1lqydhADdYz2lJTBVy8CaEkv3gMC7+xaD65iNvjxL58tzZ++4qPgpdkmxjg3jzFGEaOGxSBiIk4nuAce0PFFFjK+Gu34k+e8M8DkzDUbyhpUKjHzWUH1kGlVxW6cASKyetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+/QCuMA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+/QCuMA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so823469a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 20:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771043809; x=1771648609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxayVJFfRrkf5xz/bcJOQ8q9k4PoLRBwxedlXN2B8nI=;
        b=W+/QCuMAgFk9YazxBDhqo4VqvXT7mS1tP++xH3gilwDIV7dRJVc6X9ZJsU4jlhwGBK
         qv9uZxBUexlGvYAFktWM+tbbSO7ORK7syIMw1BDLfGo2yM6fbBvnEkstbOHe2RF+r4uj
         9Avzfy6yHNX2QjtttmYsSJTzAynYFy6wfMjE/3v9IKm+djstcX51QIzv11s8k1MyG18T
         hAstp/0KfL0KTa2vfFazDk9r9XOcT/1dGXr88DdNHWMALuy7PGXO/7/Ay8BLXWT9ESvL
         w6hZ6D2rvmFihCVOGUBxZ+mJIH2YIrq2rAL1963x0u30AtOXXLu43JbjNgLViJdIXnqf
         34Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043809; x=1771648609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxayVJFfRrkf5xz/bcJOQ8q9k4PoLRBwxedlXN2B8nI=;
        b=GcFUfnP45Ub0tls3o7w+hlmVZC/zEhXw4cRB+s3osK+fcSHYatBeZLy8WM24ecHVhr
         rMoyFEw4WgF0quin/eGzREmLQB3OLxzgOLGSfI4O6BwYM080p79W0wmvOUt+mb2l7pDO
         sXPlGLvaxmMjCGg4+6fv7XNsbvFFA6pZKGsXR+Y63kQzOmm9QJTBO0G/zTXOjtBM26QG
         a1EiSxQkGVzCYEBM2A630cOBKkXhCvEiKSmZs+up4lPEuseBUu2Rb30uQ4HAtOk30UYk
         r7ljqVC6P4MHSbqpVEn/51Rs9o1ohuJoP89reCPledl36Tj2JMNiSjlrmoq9xPyIIxxl
         svFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4wK8057BmtgzY5eFYSSxJWMXUn0hDTuIldywKVp5bSxufDuICpvXcfdxJDa3C1/+7xTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZNCEPpGFuOhRN/CQoEb1YhzwbzRmP39aAmrqKrwwyNtu57o8
	8UbWEfds8cYUad8o7qaYJKM+Qe+ul02Vw+rut2sNOE/O1eX9JO4YXcER
X-Gm-Gg: AZuq6aJfD3VEcYmG1goUm9/jaO6FHp5dTSHFzSbZWYwzwfWQo64HanpPA+1qfaKjRl+
	abGuSdvL/kOoNPXoT9TFRPRkWMSAMEZK34FHKY+9bota09F/VmeNuFBfYrOTyRHBZ6Q7YXM01i+
	JvwPPEJgXtCLyap0Nvzunfiwrg0OH18B7QVXLisyQ/ebVeOiu6kYR/KA/oXUR1VBf+jcMQVYDcB
	PON/Ev5xA+RDr/dYkuL7D9LJJ0vl4czRjnmQbres9LWe6RF30xmujATILqXGvRG7E24EsOef/pc
	w2COVQZS416wa7X4x6ZPoQbOmLEe0fe8CoVO5CiL0qFnQcRrfgQDoZiz00T4phSDlZkRylRt9uO
	s6NvXS4509m/j1dga5aOI4TOVUHDpNcmE+b8m1c/fXt6wOxpAg/X92QCs9nF+JglYeXRyZIrejT
	+uuEXStuni4O1pO4egBcPV0owA/qGkjvDucU3l4YQIdukVUCO4EM+i
X-Received: by 2002:a17:90b:134d:b0:356:2b1c:f629 with SMTP id 98e67ed59e1d1-356aad3caf5mr3372625a91.22.1771043808772;
        Fri, 13 Feb 2026 20:36:48 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e53936sm13519815a91.1.2026.02.13.20.36.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 20:36:48 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v7 1/5] bpf: allow calling bpf_kptr_xchg while holding a lock
Date: Sat, 14 Feb 2026 12:36:26 +0800
Message-ID: <20260214043630.38644-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214043630.38644-1-pilgrimtao@gmail.com>
References: <20260214043630.38644-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

For the following scenario:
struct tree_node {
    struct bpf_rb_node node;
    struct request __kptr *req;
    u64 key;
};
struct bpf_rb_root tree_root __contains(tree_node, node);
struct bpf_spin_lock tree_lock;

If we need to traverse all nodes in the rbtree, retrieve the __kptr
pointer from each node, and read kernel data from the referenced
object, using bpf_kptr_xchg appears unavoidable.

This patch skips the BPF verifier checks for bpf_kptr_xchg when
called while holding a lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..2927a4622ff8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21044,7 +21044,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg == BPF_REG_0 &&
-				     insn->imm != BPF_FUNC_spin_unlock) ||
+				     insn->imm != BPF_FUNC_spin_unlock &&
+				     insn->imm != BPF_FUNC_kptr_xchg) ||
 				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 					verbose(env,
-- 
2.50.1 (Apple Git-155)


Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5498261B70
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518953; cv=none; b=LpIdNXV6ihBkEAhuILbHjmfIAG3/rmFsud63uMEwFYD3MYCUq84NwtIK+zPjkj/WEeKdaP2KOOdZn64cMGlX5bJLxQdIUlzKq65gaYe+W/DGGtQB1g6Jc6sBvvKGNks+Ts6pmZjB0NAtwZ/Lm6THu8oOwcVOYjSkKx+mf+aQa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518953; c=relaxed/simple;
	bh=dZ8/xKkTAFkHi86Z6ZuDxvGdLye8g4djv43rb0NZrDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSivEIc/wihi1FYRj6GodZPI5ygTrVeVfLrWN62/KgWFIMa99z8WZmHjaAcArX2kELEwLx6WYCLinLSsGQYysQfCVTbSyelp16b1GcVh2HvbutcHAfCuIqSj7hex9K/iHTYYCfFBjkwFceR4GmcskFGa+TkQEtC0IshR6qUUgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBIk1urY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBIk1urY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7bced39cfso33515475ad.1
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 18:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770518952; x=1771123752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUvK02mPR1NAypKry79/XuiDmQeUURl3TvGI0OGIX0Y=;
        b=NBIk1urYaOJ0Lssvt3oF2j+IRAm/+RCTyUujXkbslhQ7FMxSwbKv87C7VKVqdy8fwb
         43Mw9NQ2yHC5ntlMX+7u/tSlEejPP2keejSoaO3BCKTdQfAPN6SThepVHyIr091c90/C
         6Q0kgvLEnvbY0pagLvVHbV9f5adXT8X5LT8ieTzXVDTILLh98v7EfKy+/oE4dNGqB0X9
         AtEqGA5AZyItAGbd719ZtctnPiniGqUEQ7MIPGLkKX3B56Dmt+AUSq1SGbuunnRm+zIi
         9rXGTiiCreQ0OwhA1KZvKIQaAK9h/x0907d6E3ndOpGSLSVtOGchsH90HmvOz+incc33
         88Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770518952; x=1771123752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XUvK02mPR1NAypKry79/XuiDmQeUURl3TvGI0OGIX0Y=;
        b=QWhhpyvuZosAfNDpWh16oBwrfXU/3L971JII+eFOFe5l9N0dHtqv+dye1UqXEhYu7E
         QTYDhZ1l+8CiqYxGJbdG3+g3I5eMy7MPJEUXO1B/YOgGNzUv15QeYroSfKQHiihVkRc7
         VfixDebKkhmBfZHv4yGf7E2YVv+BsGoxnXKaHVuDqLhxTn3K+1kyN8BUnnrjf9Va7jp0
         CWs4cBF+1lTWIfRdZ7PMwM2nJSkJUx96V0ChTm1z+3u1To0oI3qQDNUidpmQVvbtmTjA
         4ZFPNjDvLwZxWh8Im0SC8x8L8eOPokwPoyDMwUoBqlW4+Uu/m2cTygiepWZ/uluvGGb6
         ClSA==
X-Forwarded-Encrypted: i=1; AJvYcCWlnq+/oiymCZmCS2axh3Y4gaoWiD7tAKsKcUkjRU7ETmHqtxhkgWCQZOO+mylXiDMi3mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUVj0VauY4a+Z+URnc722qnzOPeAz5ai9i/JY0jd9bhq6/ASW
	hGrX+yTZLD6jM2MKi9+NFjGYEv7pV9HOc1Q0TexHcPWF3JsniW0MBkJrIatjzQ==
X-Gm-Gg: AZuq6aI4G4OMm5OgoHu/wSWLl4SgKkb/4k2FUzQqV9QvX9RhKM7pIFBbarwlKpcjfGT
	splUWgImlb5slDi7tXCJfvCIRVKgRDsi2hegiU84360AMzbIKpMchOnXvSnWQ3LqEL/dlo5ABYg
	D3klfrp+egy3auu/Bah9d3zelarLkBtSUPfLGchpN8K6mVyYt1ad/w/VHJax0G5QAIt51PY6J2S
	8qduLZ+xa4dsXJhZKnL+URR+Hfw13/3r0xkYDUkQb1fROJ3auirgWdJSUZ4bZCXu8yfhVHkPyg7
	Hy3xcTYNeiyrgRZfhwP0jGqK3xQ5TVhgSWtcIXrbm1KCrbUtTX1pNLsKbfg+N1dwV+k0X9M76gn
	robP0JGQOxx5TsZRG8N8Ca2MuR7imijloRGv4C43EJPfvfKS23ty+1dFb2UkqK9R4eLM8G6s2V9
	xm/SMpYnxX6nuNmoUqzqIR5vwsoy4rvlzIfH7RBFm6
X-Received: by 2002:a17:902:e5c3:b0:2aa:daf9:697e with SMTP id d9443c01a7336-2aadaf9706bmr12330795ad.48.1770518952131;
        Sat, 07 Feb 2026 18:49:12 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9f5esm67194715ad.51.2026.02.07.18.49.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Feb 2026 18:49:11 -0800 (PST)
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
Subject: [PATCH v6 1/5] bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
Date: Sun,  8 Feb 2026 10:48:42 +0800
Message-ID: <20260208024846.18653-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260208024846.18653-1-pilgrimtao@gmail.com>
References: <20260208024846.18653-1-pilgrimtao@gmail.com>
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
index 3135643d5695..05a6a6606b6c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20387,7 +20387,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
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


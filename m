Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA0480DDF
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069680; cv=none; b=tAkH4iHr5jm33cLkDvVeCgq3EbM0WnqTEuPMQlPaNTHBU/QV3GrSFxOGLFrpeDFeTrFf56JSoCz7lc11v06P4rzbUsx1W0Q+CCfI96K8EjzJtKpLhNHGFSdRy7nD1K0JukhN7CLOz7vpJCfwkaCR8T4JADdiEH87MsfhcM1Df0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069680; c=relaxed/simple;
	bh=uUL3+hIqzzN4FF56+RZlxBho1NEz93n03uZmaBVx188=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=am8d6eLr/cVSJ0WVbVYTUVVjLRQP9UvIKqyblQvI6hD5KASxWTJGyefHyeadmPXVsOdxhlEHTpwewoP7oCnF7S983R/MFyIyolms6rRShcHe9oThgds0kqYl5iKEiVuHXr5OYdJ1n7ppUJftSiFutC8P3Mhbl/DSGWTbj7GV8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmwwkpdT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmwwkpdT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso3102665ad.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769069678; x=1769674478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32rXQW4BVZZQ4FbVA0RQJRaOaveBTs70Lc0Lq+KuBq8=;
        b=cmwwkpdTXWe38KjuNV8NX1oyIppji4rFyYFGfB7rp+eHJnSTJCGVKL5aR46JXfeaEZ
         eZrKKoNX4vu8FFk1sF7lfKI80SJh42qsV5piwPj8QkbzDIxc9vcD0eQeYEWIp9q2v/VY
         MGeL75gQodYt8mv5EB1hz35f1UizDRTnYJBknvIb0554i+NKuI1KsNR6mI+iJJMg/w0E
         3Vk3Q3qs/5BtrBgt6E2yFcfrpXR6Zv7wHESk0MH/fRdUUT7kvutU0/Ykl3B2pQGSXuif
         enzld763eIO8H4hYT3jjg97oZpM3j6Ky6VAeRVOlaAgiskCmqb/exFBfAyzOTVlIzGGb
         S2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069678; x=1769674478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32rXQW4BVZZQ4FbVA0RQJRaOaveBTs70Lc0Lq+KuBq8=;
        b=T4WxzHa6ek8SkspTVcjL6KwcUv61/K+eYEoVGATQ7uyOHgAcoZRpDrOnwgSyFZx0Mb
         68KUTSGp08rVzSl+8bXAX3n5+EXDafTn6D/dc1RnHVPrKVUDo7e4iCgBvVxfFK9AELfF
         mZkrCOlVJ0jkNJIsSYkzRlZqJ6VWRrs9lg3gYKaiLofV8DEwwQu6ZpzHOVxPOuroD4pg
         Da6KR2nnB/DbUcPTohU+iyGmAvfkXvN3j3fQbBAsEji0vgfU8SoSWciMGVOZDNVT8e0/
         kxD/IxKtQXt7G9TUlpXZm8miO4llITfXtO5a3nngPba/9MHpNu5NR+c4j52gH3oEUqfD
         LYcQ==
X-Gm-Message-State: AOJu0YyRLdNi33DDezdqIAP9mNR3sdeGyqShOVoQvrtNC9lK1gCkwcKc
	knP8PdbP/Jn2TRLiEAxCn7PdYzdT1hLvW/a6gXcEnaj+IWUPigP6h2m0
X-Gm-Gg: AZuq6aJopYCqTpk1V9IPfcTj20NdHXEhMjmQfJBe/iDPObC6KmKd4evNeCOh4iQxEXe
	DkOzn/PbpgIEuvnxO08BgxzsVqi/iVbNYMbg3ZfxrmKDqPE/l0kZTIUoE98xzNmx4LcYrmzlnPq
	BwV1zeSJ1Z331xOMWbuP6vYJ0ZcRDVKv4IBUm7GPAhTiWslpPG3q0SN9c0ukuKV2Joa1UIMgho4
	rsnUuvobzqKibiamsRYRHik3VsNnlpU8K89FJ2SMLJwcVeiP5mrKz2k10S+h2rPRJyB/oozG5lb
	V79K7EOWrAnesI/kZpo005C77LdQiB2QTajNme+vCzmLQNkhrc/b3udbnmWT+hCOiHVhOZGSF52
	QfxvXBDWw6zsd+OHG7Pd1CcoKr32OoqdtQsX4P4K6TESDHyYCMDdkeWc8zOM8bfVP/L/Gu5Gzln
	A6FCK7HpEAcveyWdWeQf8W/5P4pO6qzIWZOY+hUC/sag==
X-Received: by 2002:a17:902:f60b:b0:2a0:daa7:8a57 with SMTP id d9443c01a7336-2a76b05165fmr81780425ad.30.1769069677821;
        Thu, 22 Jan 2026 00:14:37 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9bdesm173868825ad.24.2026.01.22.00.14.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 00:14:37 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
Date: Thu, 22 Jan 2026 16:14:26 +0800
Message-ID: <20260122081426.78472-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

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

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
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


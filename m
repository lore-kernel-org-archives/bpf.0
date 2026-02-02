Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08921773F
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001947; cv=none; b=oaO5sVdd/rnphAXn710rXyf96glfstpLBssolAt2wJDrq/AlPAnXWY6ipwkaPYL+2jknTEXCQaeUuwrC1K5K/t8MASJmGjmv44lhaaqWq30ibiJc0INooyzLPZ4Lv66NT8a7gbgiFPpI3RNHBCZxXOxiYsZyxNxT6v9N9QapiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001947; c=relaxed/simple;
	bh=W0maPzPO5M3pfvomopBHHuSGpDn/zGTQOAOllm67+rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv6YYnxbJRbRLuk9e77t3y7pQrIig40wFkGeba8UjjDz/MCiObhhOu/4YxJcSK3AAWZrJ6UewPxOevclc0NdtkybaQD8BAcKy3mfaYn76QcEBHShhHyOCAgfmeojAumqLR5R3ncGzWyJlmmJPURXK01TBTcGtmOLXYjYt5nZ92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9WZ6L/1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9WZ6L/1"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c65822dead7so1523503a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770001946; x=1770606746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRIVmJL3tSUzEWbmHeuBiYdL6z2LK0b9AkJ41US+kYI=;
        b=I9WZ6L/1cNvIQ77LweVX02+SpkDdpH7G8N6eRrgdDWPwpAiASy2pk58ipiRiIU24ER
         Hixtm/lPMlsEbcwQeI/LPWwREHg5ZRIWnVu93028vzuUBbauw/Y02hJAmfq+tu9VXSA1
         lpvdI8qw/A31/Y5JH32TkTCUSeFiwr2OoR2tJa71ft0iqkAxnCHJsFT+EIswklwcVnHo
         xEITxSSSey07D9iHe5oF9TtSYXrMH3vRbQfqyzQ513gxAtdGq2dClmEXmLWlR6DGUuY4
         GsXQwrCk0NJeU4ej979FUJzNv7tbkuqQyRFXYuQ02j1HNWPbQUC6PKrhHGA10QtNxASI
         mj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770001946; x=1770606746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRIVmJL3tSUzEWbmHeuBiYdL6z2LK0b9AkJ41US+kYI=;
        b=LsoeAYzPmcKvaKO320cTAOAu+R3ucB1IqeHGmD9yveFA8MwB41CcokAPg3gBilroX6
         2nhLzJX0V7T5oEnYjKh6xDvpjbYZKDJjGwEEuitwNtP98hLdctq5J82OvTyBuv62sw3C
         XSxaciSi78eWQnA9zszdI3O2Pbm2SinYwooZU6wTCKO3kMY3YUquhKSnNDGemZCPhXw+
         RgGFuqRfVxabgVuS13DMxUNhi9hngUs3A2bwxHX7cK0N2OpfZsltX1BOklz1cUjkekn1
         +ily4ZsM0bCRMPewiUV9Ty8EiiMxAx1zvpE/bBPbz5oCO+C59pVvNz1Q8L6IoScCKZMl
         tzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7HBjL2M/EM/5v/HLwfptYdgD35bPEZtMU0RGDEImk5Qit1T4L0OoJiBQlHBr4ftkddac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjYKyaNG6A9ZJDTkyCYwSKegnUzohnoB0ORJBLwrGB0Xpdm2r
	Y6DI8aA8buhtUUxkISYY4pI6AtqX0IgZ4LpvZkY4U6bp/3QzXnA9Q95E
X-Gm-Gg: AZuq6aL/Xevgm6IEj1Qh26RKDwOAnlt3rVx+FpYmNAm1zuVmNAyryJ3goDq6T09Lbqn
	dVJWEVZhBR4OUtrk+2cXLyy1J+Ij1qSLvZFEvJzCNEp0SJq4r90pLsi/fZ2Iovd3WPhqsZwlToH
	TdOGwcRd4s+OQzHUJcS/ByaCqAs+UjOVfW3PYdEgp3cDH2HStuUXSza6xDe6BColy4xOk2G4XIG
	m+mGIeG1CV6lFHca9aBjiw6GvAoDI9YeI681R6WLIG5BK3iS+PYN49tQ77rVYGqosh6N1NpSdGJ
	0FwDn30BSl3h8e1wG3lfJTu598WN8TYtfgPiLUifiZ7bb7x7ifWcgrBcU4pJwx5weUSKARgvkWB
	K9fxW6s7JDJ4FBgq5sQwkrsZ29VBA4e6Jdm22nd6aw2FeBZkzDZgB/0EjeBiH8EVcwK1FVUTmbl
	4YWtRxIpv4GbVcwtlHRsLTgT2XB8CYgMsx4Ylm6uDdGQ==
X-Received: by 2002:a17:902:e811:b0:2a7:7ca1:8621 with SMTP id d9443c01a7336-2a8d8038214mr101481645ad.34.1770001945777;
        Sun, 01 Feb 2026 19:12:25 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4110sm124318605ad.84.2026.02.01.19.12.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 19:12:25 -0800 (PST)
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
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v3 0/3] bpf/verifier: Expand the usage scenarios of bpf_kptr_xchg
Date: Mon,  2 Feb 2026 11:12:12 +0800
Message-ID: <20260202031214.69958-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

When using bpf_kptr_xchg, we triggered the following error:
    31: (85) call bpf_kptr_xchg#194
    function calls are not allowed while holding a lock
bpf_kptr_xchg can now be used in lock-held contexts, so we extended
its usage scope in [patch 1/2].

When writing test cases using bpf_kptr_xchg and bpf_rbtree_*, the
following approach must be followed:

	bpf_spin_lock(&lock);
	rb_n = bpf_rbtree_root(&root);
	while (rb_n && can_loop) {
		rb_n = bpf_rbtree_remove(&root, rb_n);
		if (!rb_n)
			goto fail;

		tnode = container_of(rb_n, struct tree_node, node);
		node_data = bpf_kptr_xchg(&tnode->node_data, NULL);
		if (!node_data)
			goto fail;

		data = node_data->data;
		/* use data to do something */

		node_data = bpf_kptr_xchg(&tnode->node_data, node_data);
		if (node_data)
			goto fail;

		bpf_rbtree_add(&root, rb_n, less);

		if (lookup_key < tnode->key)
			rb_n = bpf_rbtree_left(&root, rb_n);
		else
			rb_n = bpf_rbtree_right(&root, rb_n);
	}
	bpf_spin_unlock(&lock);

The above illustrates a lock-remove-read-add-unlock workflow, which
exhibits lower performance. To address this, we introduced support
for a streamlined lock-read-unlock operation in [patch 2/2].

Changes in v3:
- Fix compilation errors
Changes in v2:
- Allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
- Add test case

Link to V2:
https://lore.kernel.org/all/20260201031607.32940-1-pilgrimtao@gmail.com/
Link to V1:
https://lore.kernel.org/all/20260122081426.78472-1-pilgrimtao@gmail.com/

Chengkaitao (3):
  bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
  bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag
    is set
  selftests/bpf: Add supplementary tests for bpf_kptr_xchg

 kernel/bpf/verifier.c                         |   7 +-
 .../testing/selftests/bpf/prog_tests/rbtree.c |   6 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/rbtree_search_kptr.c  | 164 ++++++++++++++++++
 4 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search_kptr.c

-- 
2.50.1 (Apple Git-155)


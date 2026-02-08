Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD11E260C
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518944; cv=none; b=pauVfkU4oMaeOifRZqDXUFv5Qlm7HJmdFY80/ddpFKrDZL+gnJuPVOPXwSUHLW0XdI/l9EpwZfMFUwbvhoJR/xRhAkt6cehxlxY5Bhe6G2qd0zwVACxZlxbdzavEjnhuw6zpeoJgLchE94xsDmuUinDKZEUXc1CCrreZ0MAtw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518944; c=relaxed/simple;
	bh=ggaDIpn3ewDGn+U09yPrXsdr7h8u5fNEwSg1M3wvUWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsrzF1/nY86Qx0hr+2gRMHPxB6UnNwKq8l+66Sh2Ow0dJWcNh6r8Q3h0AtOyHOa6dmelHxXR49q1Q/CUZwWaTSceWXKWTyfNV0BKVVbLLBSPqp+GtaO4RYOqXSY/CLU62NvlPWzKMH2b6NTJkObwxwWFOeq+CNO11BZ1KYU8pNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfNsrqoX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfNsrqoX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c20ee83dso27886395ad.2
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 18:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770518944; x=1771123744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJE7ntfEvSYVWyw3WIf0KrfyfMPjDLGhWYcYr6XtYJU=;
        b=NfNsrqoXaiLA1PL7fzChDL5OtZpDifgnOMYPnNrqhRgatjRa62JUBQdr55ntPT4AeS
         ulK7nsfIX+smPKvzvesJMq0iwWNlYYIZZQcmMVn0WQv0+j/ulQEAmA5YfyOJs4ngdino
         mYmYvQX4gVc7RkPHqpGZmtc0Zyec25YISw0T4/qhQ4Vcb0d/taGcwpNr9umVIy0Dihxx
         nmZ+RVPrEIJMCLLd0826w7ixDXDNT8B/4kPTazU+JNqMkNNthI7ahTedpG7vdByhiSrL
         KVq6JyGxvPuyf+60SQy2WnrwATZMwNklUZUoCpkEQ37UQHSxRRenp6WRmdy33KGjRbfo
         1DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770518944; x=1771123744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJE7ntfEvSYVWyw3WIf0KrfyfMPjDLGhWYcYr6XtYJU=;
        b=OY8Xh2CeDpbifVile7o+rPy1tnI7E6JPpz0YEWouVc7lQ2eZH6z0eOAL8OD6Clv6hA
         udcM4lHO4qLXwkT6ZISykvrz7hTmG9KoPi1Pl5gObvrKbUr0tfhm3QMbpC3NTbJvKXZN
         WJrobFmt1nPXCIylB3zc+hne5J6hWrajj6HQdy3idihsQfK1Ky5Xhs/O2i7B9RlyRunf
         VJ7lCBtEE2eAsVlAbByUa59zIwKm7taIVrt6do7R9+if2tIOH35s66WeXzFSQgxyPbup
         tPqc4CZeF57XJIDHtG/2V4JRawoxltedbqX4YjfGiV5v1nSE5x/8jYJ2gwL+8UMTRLSw
         0fHw==
X-Forwarded-Encrypted: i=1; AJvYcCUR7/X37tvFaaO9uu1TmFhWC31KPPA20YTiW+jdhTMejfVIuT7PQO5ho/M4/ET4p0lU+Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCw6d8YmwOpRfdOESqamlm8NXZddPiEG8T0ifs4UWM6inefOu
	CKltyBxJYsF9d9hw5VsZ/quBgPGXN0BXcqzAjfl6vW50xqB23z4ND5Ka
X-Gm-Gg: AZuq6aLGSZqlLpS+WZEIfX5LpKjzhg69PnbyCqv+s5KNxY2wG4T4puQL5UPFAN8EYM4
	nao3uj0Usj/iTRmsN94JtFvayvmfdpgszGffdkQU3kPRYI4BUiedYihZYMQhfOeFB1RpVotX1gU
	XNkFdRkEN4wbHdpvH7CZ8dV3X6XpnfN/37ac5owP5q+LrQ13jYOrCFVirNIpKZSqy2O9xP788zM
	gr2J0NvKonCuNAZmtooqxbybEKaMlEAJG2IycIR8la5HV7H84KWxxrPRPf/u6w+0U3qAhEXJdSQ
	hyR0n0qKnq0QkOW+cuVzeJ4pbHurj40cAY841kOxDwpMedxCv7V5Ax63bPuGftbT9yMTpcIpv3w
	vAQhtotODSIy5DVlbQQLi0gVVsoQxtAL1Ky8EUlCRRZlgSBQpBAcxdt8RZOvbme6jkXw/cFm06c
	hKmGeNjY0vnNRedjoFjioZlGhhaMD3IpLCbHnMnhUN
X-Received: by 2002:a17:903:1c2:b0:2a9:4450:abbc with SMTP id d9443c01a7336-2a95164f64dmr88105895ad.26.1770518943797;
        Sat, 07 Feb 2026 18:49:03 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9f5esm67194715ad.51.2026.02.07.18.48.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Feb 2026 18:49:02 -0800 (PST)
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
Subject: [PATCH v6 0/5] bpf/verifier: Expand the usage scenarios of bpf_kptr_xchg
Date: Sun,  8 Feb 2026 10:48:41 +0800
Message-ID: <20260208024846.18653-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

When using bpf_kptr_xchg, we triggered the following error:
    31: (85) call bpf_kptr_xchg#194
    function calls are not allowed while holding a lock
bpf_kptr_xchg can now be used in lock-held contexts, so we extended
its usage scope in [patch 1/5].

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
for a streamlined lock-read-unlock operation in [patch 2/5] and
[patch 4/5].

Changes in v6:
- allow using bpf_kptr_xchg even if the MEM_RCU flag is set
- Add test case
Changes in v5:
- add lastname
Changes in v4:
- Fix the dead logic issue in the test case
Changes in v3:
- Fix compilation errors
Changes in v2:
- Allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
- Add test case

Link to v5:
https://lore.kernel.org/all/20260203022712.99347-1-pilgrimtao@gmail.com/
Link to v4:
https://lore.kernel.org/all/20260202090051.87802-1-pilgrimtao@gmail.com/
Link to V3:
https://lore.kernel.org/all/20260202055818.78231-1-pilgrimtao@gmail.com/
Link to V2:
https://lore.kernel.org/all/20260201031607.32940-1-pilgrimtao@gmail.com/
Link to V1:
https://lore.kernel.org/all/20260122081426.78472-1-pilgrimtao@gmail.com/

Kaitao Cheng (5):
  bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
  bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag
    is set
  selftests/bpf: Add supplementary tests for bpf_kptr_xchg
  bpf/verifier: allow using bpf_kptr_xchg even if the MEM_RCU flag is
    set
  selftests/bpf: Add test case for rbtree nodes that contain both
    bpf_refcount and kptr fields.

 kernel/bpf/verifier.c                         |   9 +-
 .../testing/selftests/bpf/prog_tests/rbtree.c |   6 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/rbtree_search_kptr.c  | 290 ++++++++++++++++++
 4 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search_kptr.c

-- 
2.50.1 (Apple Git-155)


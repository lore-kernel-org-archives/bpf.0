Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D741A8F
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769915778; cv=none; b=V2bdymul3C7mA/CWcaN3QUAHrJSMESt+e/8QeWmdOJ/QmJLtZ+s9Im6vaahYfOUaOgeLdRCgsg9zVr8dei8ajeGYHKrv03O52N3jG983H1ZKKuYAaGzheVsC2PnRsQuczJkK5ZAfsl6LSeU79cXqEkHKaa+vbHeBX8FwINWxwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769915778; c=relaxed/simple;
	bh=5WD/B7mrVC63BXuNw4H+kZfkP5LiN+uYJLVKOU5DZf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZjDVamjVuIZ8bNQunE2at8dwA/mMBbOss4LhclWN3xuvM5i7rtTYl9aZC5kEzae8GSIIJyeibL2AMllsiEV1P8R27ucyWRNTYXz9B+6WUvqn2Ld9hY2bVK6Bg5VO66uA36q1NsFY4OnfPpCSWkSPsVSej345ano8jxrxThznv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mubs6U0g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mubs6U0g"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso2856455b3a.3
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 19:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769915776; x=1770520576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFUVb3zqdmYeViDQNZUm545T667JACpxtH5vUY33Trg=;
        b=mubs6U0gg1rlh25C1dswqOi0uOEj91Tp9JKHLb53SzIw4lfxGBc+m6meZcK7hvCcou
         CM+aLqQz6NAa0dd2ohZeIDvNNbeVUPrK0TNzBmDj+NP9R78GIEb24DdJorIZGESX67KQ
         hi7DAP6lafogfhYfkm7e9f3UsBPaYafGjARdCQiXMZrduJ2Sn6fNKHDF67UIF4cr6HSd
         KpPy5fYlHyfQIGU4lgwBS2GrRDhya/UJX4Ts/T2vB3c51iI1FASLLEc4fTOI8XSm69rx
         vm52GmZUt/1ks3/BT4q1vTQ6V6wuLj7nT2ZnU3DgcWMFJGu88jcg5Q8lJRBjK+597I7o
         A7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769915776; x=1770520576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFUVb3zqdmYeViDQNZUm545T667JACpxtH5vUY33Trg=;
        b=NmLOwCSQuujLwwBtsUP9+9p/4Z2Q7UinhfWq/h4gZqsQClq54e+06wKa+c64KHEPGV
         x5h3nmYEHzDFde5RfzJGF/imO+ejjltYWLowhUHFrcCG8zsTs/n9/eCGoAmRYBsBimyl
         PiyUHxHoNGxM80/m08YddVvtkEBx1a4fUnEY8cWBa0jrJAvXIRxznUcFkNp192dkT1NQ
         XOgZ7K9yJsxsG0TuWoeFx1jYJkfE8mYxNua2I/8HVVnpbck+TBzRz4ls/ZlIIc3YvWzr
         Aiuf7cPJZ0ADDT8kkEwqAAhxNA6Zc4/ICVqVc24Elf8DkNeApBCsAiAE+YPwOygNJ9Ow
         zuNA==
X-Forwarded-Encrypted: i=1; AJvYcCVGiblu4WwhsD/3yKBAXB1yHJjbpLTpKpb1DmKmKz//OPg7olRfoGkM0leW4T1UAkJw0xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqgqERA8PgtH3sMUpFZvPertyT5+IyMeHHgSCFTecaHGuVY8X
	xFhWWOKvdPpE/a0jgQNKkSdFv57t0oKCEZrHOwKHpnOaWWJg4oVE9ngF
X-Gm-Gg: AZuq6aJrOm06n87fNyu7r5wiJKkVUua7DoVg47gD0Vs0loFj3EydKcBoLvNUXlG3U+u
	CtsZkKCEDP4mCnEUn45RNHaG2fx0oF23bgdQKswjLB80nb+Hm/jXfyBqhwlYQsO5rBvcxkJvyCn
	EEJ9450VK5JaAieSq1t4m4gWukZKySMNIFlMEBwvy6Y4kwm0EGKlSbLaOGEI7/yTZfQiyd5Df1Z
	w0ZZ9G9Tl+X79iwaD5PPcUHtDlxKuznqCWNTXpGBMpcKKo+7QwNt7ivwzUoiUHy9NfDIlFvFcAw
	dyBtL0KVPuuKx1wxqIP5pj7qdl6FO5I3IL4gHZrm7pOFGU9l7E4n8alM+TTuRAhUtabQbqTKrBk
	y3tnzE/XVJGHq2pjz9ZNVuOpVdWdpzciyAdR3MVlv4DlIYvPcosZrqJWrWOfrTwihE1SpJyox6f
	Toe6By6gNY0npJKiDQ/FuK7iYijw1bPsftyKZy8hgUyw==
X-Received: by 2002:a05:6a00:1306:b0:81b:14e1:a17b with SMTP id d2e1a72fcca58-823ab9834c2mr7333418b3a.70.1769915776363;
        Sat, 31 Jan 2026 19:16:16 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b2bdsm11810818b3a.30.2026.01.31.19.16.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 19:16:15 -0800 (PST)
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
	yangfeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v2 0/3] bpf/verifier: Expand the usage scenarios of bpf_kptr_xchg
Date: Sun,  1 Feb 2026 11:16:04 +0800
Message-ID: <20260201031607.32940-1-pilgrimtao@gmail.com>
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

The above illustrates a lock-remove-read-readd-unlock workflow, which
exhibits lower performance. To address this, we introduced support
for a streamlined lock-read-unlock operation in [patch 2/2].

Changes in v2:
- allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
- Add test case

Link to V1:
https://lore.kernel.org/all/20260122081426.78472-1-pilgrimtao@gmail.com/

Chengkaitao (3):
  bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
  bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag
    is set
  selftests/bpf: Add supplementary tests for bpf_kptr_xchg

 kernel/bpf/verifier.c                         |   7 +-
 .../testing/selftests/bpf/prog_tests/rbtree.c |   6 +
 .../selftests/bpf/progs/rbtree_search_kptr.c  | 164 ++++++++++++++++++
 3 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search_kptr.c

-- 
2.50.1 (Apple Git-155)


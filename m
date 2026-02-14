Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2ED279336
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771043803; cv=none; b=AZTmS+WhLrTTl2/DGK4v+r1xlyU6hak9fhcox6XAk6I3k6OsgOjUrHFcoXxj2pscDJsXkOZUtZLIsLjtnZ41yVrpZNPGsDt3L34RzA6AkTsqk0XvcBUbBGmaGlirA9e1+1LteHLO3GfLtugerOvzvNfJxcjajiQn54ikATrmY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771043803; c=relaxed/simple;
	bh=kUZ3TAp/44GbGN69+FneMpT4zG8HXhDlDcPA1PDxXd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLBtMcSEQzsHxnSu8qS098lnnkLR2CpCUaE1oF2UCENz5NdhGVbRGXw0y66T/ow5NrEY5+Jhokp2vgXdhzG6OkE4x4XQUZrHdU5hdqjtVX0/RapiqQbeXF8DMTPnIjR5IZze5PnSiufTHCvwQOK3GD9Q+nNQDm91VqfpV2CXiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuH+tcKS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuH+tcKS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8249aca0affso908120b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 20:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771043801; x=1771648601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4gRHmoXRE/fcFPdbacL9d9KCJ6JNq7p//h36U0/+hs=;
        b=IuH+tcKS8CDE9WD+0vAlfeeW4jAfjWeqrTEgNdiwuV99TnDrkroGJUkhKF0kFmSbGc
         C+M4CPYPoPL9gaI6j6Bcwyx785bSnRt4IKJ+4ZtW27LGdvCzrjmpuxTfJK3QBZBPB3q0
         UWokrKdjiPZ+cN4Dy8CxyA3JE9i0wsCjN3NE/mhBAvShdE9oH39MjuWPmwyFluc4H1Zu
         apvbB/xuHO2jm8mu5N3v6017l06RB5d502Zch/FddRncd/UhvsjURIc+UvXIFOkK9GvQ
         7ZxJjB/YNDoM6Hw9UeC57zhuOyMvJAo2spanVYagw3aUtbWrE+8FhNP61+kRvyKuRYHY
         uX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043801; x=1771648601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4gRHmoXRE/fcFPdbacL9d9KCJ6JNq7p//h36U0/+hs=;
        b=qkvOvOQbOs2IAs0O2v5b6ge74uR9RHrayjWmaYivpBOxqYPMY7trdNG79ExqxDOVT3
         thxQh/M+DavUhg5njm6IS4oONypd5DrACkXxhw1jJs8q65gBdVJBgzR6EgVLsImINzAA
         O2rx+RZmDEKizC2/G2mYkzmSa2R3eD7Ek20H4+PIshFE6LCG9WEwh2VkvCMbvCm2RBga
         qIFAgZIIkMpa+0qrq4ICyzl+BGaOlJ7zyZy2tFmVxLE/l6N2wQnkbIN2ERWLLgdwRyZi
         O6PJ70BIg9YliVKwgy6LnaRXtOHH1IxaSKjyEgMXKIFwHsn0V9dQ2utxjKg9lPcaruqA
         AbYA==
X-Forwarded-Encrypted: i=1; AJvYcCUavRVn26vRMmyH1yJjNTicCrn7L4m0FGpFXNBLetSOnJC0MQXsHOxj1OTJMVhM8Ow1a7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFLo+8YgJECDK1CqLUVpzCfscb/sbFCGjs6Ib+12qxCBRV2xt
	4Ag0xHrrhy5ytl3wxq1tGTAoi1cNS6BlXu9CBBFqfLAOf72tP+5NPCFS
X-Gm-Gg: AZuq6aJ+R/qKGF1LjDFCMBk5rhU9rKV2XB4LHuI8PZ28hJAVxFxsoOBZtPBssD1rlhK
	chWoKY0N/ERMuMluo8Ozg01bDDsKnOA1SuyHfkz1Wza1923/HtD9XTKABFUb9+6tIUAyzNnuJEZ
	tIyH1eVGhIjF8ta/TCwwsPO3JUvQeiTxMDEdsklX8430owXanVE1EUkOQ2CmHfb+zJrMmnqalU8
	NEr/GP/C9mBvLQFDYDj+MOrKc39SQt5SOayBCMd7+za+Zs/9aI0SJdqq0EnINtbLZmgRjJuDPsX
	65gs6tUp1ryfmpARxThCAPvPd3GDlpvRGLZyOVFIxYiH2YtdMig6oWdRXR/8WOSPPoE5bokRE6C
	CgIfat2R/BcSiHw3ha/mweIo0ec9B1/bFixaKXnlY9mGn4Gab9aOQqJ9yI3kFYLQ+DvQFxOn/yL
	juypHTufmNEBgVzY++QVQsPH1BCXFGIPhijjrGaNErecTjt2Y6EBJw+lw5nOPUDCA=
X-Received: by 2002:a05:6a20:6a22:b0:392:e5eb:f04 with SMTP id adf61e73a8af0-39483aa9f62mr1438972637.72.1771043801018;
        Fri, 13 Feb 2026 20:36:41 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e53936sm13519815a91.1.2026.02.13.20.36.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 20:36:40 -0800 (PST)
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
Subject: [PATCH v7 0/5] bpf: Expand the usage scenarios of bpf_kptr_xchg
Date: Sat, 14 Feb 2026 12:36:25 +0800
Message-ID: <20260214043630.38644-1-pilgrimtao@gmail.com>
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

Changes in v7:
- Add a comma to the variable declaration in enum bpf_reg_type
- Modify the prefixes
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

Link to v6:
https://lore.kernel.org/all/20260208024846.18653-1-pilgrimtao@gmail.com/
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
  bpf: allow calling bpf_kptr_xchg while holding a lock
  bpf: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
  selftests/bpf: Add supplementary tests for bpf_kptr_xchg
  bpf: allow using bpf_kptr_xchg even if the MEM_RCU flag is set
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


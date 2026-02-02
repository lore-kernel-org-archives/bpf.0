Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B428B3E7
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022866; cv=none; b=E4+mzWFMeYzTwrfTeqNDrZzOoExZ1FZDj/f0y1+EdYUpTQP76hVHrB4B0DvP8hiIp7ASHMC6ZwFBj32uFvalttASl4GXWFVx+evpTsxDaMfldk7HdmZ/kZ1oCx/A4euaKBhopt3oQhXZChUWh8cUgDNgiUWCw00IAWCrf0vgiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022866; c=relaxed/simple;
	bh=vHVo42y6ijjUFOucAKUUTEeIvwo57Fu/RTWZc4Xvk9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeZYasFRSZSTp9/H+U5NUyRuFWHQeZXBVSfLQ9tqzFX1lMULOCErYDb5hZ+B/nUJXChmR0K3QYRiOPoP5CRlpmPSJb3NNROtd6RmFhYyvupX9aiFp/rQ+yd8gArPOgkoVCJVk5hGuV4RrVFJW5B9R+avDn91LDoWBhpxWYhD7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgW4W1sK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgW4W1sK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d67f1877so27549065ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770022864; x=1770627664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tcTgl/ZgUxP8ACOZMp7JNxSGHlL1J62XgSPByRPiWs=;
        b=IgW4W1sKPq3dAX2c+J2ESZezIVynlvTfI0zSp4mu92JAt7VeSgnHAB7TOpoucReKBE
         m0GN84PUkJ9oFMM4FMCf2kiAc1kjuOUU9vJGDhrAjy24BBdd2VxoR04dN6D3ujeq2bCU
         nkbCIVteUA3kbT4pc25rLeZWfmJLuxgw/JHaVzEMG5kAcYCCGArC2BHS+5mZ797Q5q9c
         qP/Fe0tnqgjZzxQnJfWErDnpUKegngHcfJmVTWDlVqk0S5feSNXy15E4GZH5Gb7Rh/qG
         mZUiOgi2IXcLnOe7i8NGF87Rolt0WsPet3alADiHqmEMQ+Lsuxis6KJ6prrMw8mv6Fnv
         ZMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770022864; x=1770627664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tcTgl/ZgUxP8ACOZMp7JNxSGHlL1J62XgSPByRPiWs=;
        b=cO1IITR4+auzVVgTTmTMMEbL4D45YTSMQ1VkY0tpgVvYWy4WxxAcC55YuiFyOD9Y4d
         V1v5N5mYAVOWn5wOeJvwYBkwniflEcLj8UFKKXhAK+ID0r+kEvgfYBIracJIF+wGU6CG
         8wp1NXbt9SMG1BJFqLMDMxyfvYiqYhghEtRzjqAPJqqxGJoWe5nGKFcQVgT7hexVmXd4
         QQJKWCBEjZMhRK+XVDjw/UCkuR6HxBMBdJmTBpEmuR6IEcA3kWqYbVchC8aJYToxkBT6
         cRoU9/2Q0JoL451+sjmlLv4hkPvLhD9B+Gco3J+f2sDGRxCiEyHYqidWYPtGrmto8fGD
         IFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwVqd7jb+C2eAc5Pk0FZ3ryuy+zzCXtH4c1FIKDdPkJUsbKSXlKCn0ef4udVqqp8igzUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbQH2llAu6mBJMj4XGl0UDz9A++8UyHdSUpHaHJn+oLc7Mu8R
	LJiY0/3SSgGnmIBPTd+GvDzeTuCedOw5UdTMsnkAyXswo+zV74J09/eK
X-Gm-Gg: AZuq6aJWV/lr7m/sICIrBYsRZJMGMpbEljLcPpoKDDckfmw0EL9A4BwOkrr4d0Thq3+
	huDdZT+mItOzRlnS/gA341XEQSO+gSW0aCA1W0KXjZjHar4FmNh2WAuWlTzUCWaCU0Wov8Cpn01
	0NJP65BMQxoLLjhbV/j2DHF2+5U9aSw4AyYkKJFXgpiu/uIBYDaHxHj/Yc9bP4UQKNfwibOOp0k
	/DDIiV3sGFsAwvRpHQfaB2M+cnRR0C85J8ov+tVM+G9Zq3x8PRnp4fU2vW1sgnNv8J1f7qD7EGy
	shxmx6vFXA28UqKhmdb+vw8VNhMBkU+cvTVrmfbROxYeE21BCRy/raJI6Wuio0DcsSfCEz/zQyr
	AYkHWEHt28FRo5ZrfGs1MJ88828C6tUzKGbQIluWTzyZWgo8WkZ8ShRAWU/G2mlLqOzjWrajg/d
	bhUdCaMtyqPWOyFBmezoDZDymx8iTW9OFwSJxbNZv42g==
X-Received: by 2002:a17:902:ebc1:b0:2a7:7872:8f52 with SMTP id d9443c01a7336-2a8d7ee6a5dmr101008815ad.26.1770022864333;
        Mon, 02 Feb 2026 01:01:04 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414f1esm139167635ad.24.2026.02.02.01.00.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 01:01:03 -0800 (PST)
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
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v4 0/3] bpf/verifier: Expand the usage scenarios of bpf_kptr_xchg
Date: Mon,  2 Feb 2026 17:00:48 +0800
Message-ID: <20260202090051.87802-1-pilgrimtao@gmail.com>
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

Changes in v4:
- Fix the dead logic issue in the test case
Changes in v3:
- Fix compilation errors
Changes in v2:
- Allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
- Add test case

Link to V3:
https://lore.kernel.org/all/20260202055818.78231-1-pilgrimtao@gmail.com/
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
 .../selftests/bpf/progs/rbtree_search_kptr.c  | 167 ++++++++++++++++++
 4 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search_kptr.c

-- 
2.50.1 (Apple Git-155)


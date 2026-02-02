Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED5296BBC
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019064; cv=none; b=O6BvO70YnAolsHlHKvbS0WfPjQZeD+2sl+vZoearFztLQQ2OaOkIB2hQ2PM3vjbfoGREutv9LwN4046VwcSiVnWP6C9zwqkJfQorMv1sZaNnj62oJDxn/XFH2Y+iFR9MVm2QQrYszSUIcS83XDXkFyZ9KcVCajsO3MnbzKgQ1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019064; c=relaxed/simple;
	bh=W0maPzPO5M3pfvomopBHHuSGpDn/zGTQOAOllm67+rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9N+z0b2UX4DPpRh3FxIJWJrAERrUwPI5WlOP7/c9E2mz0DlPvVz55aqQEO5Z0Kvggb+e4u5YjDx6M7yJSdZ+WIQuCqnIsaV7qPJpdZDJ2sJPvHF0CLXhtL3TXTPmSBUlyCQJg4HZIB9IIJctBPgq9UToNeTlVGPgUz8grzMqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFlMYq0p; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFlMYq0p"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b72e49776eso7768414eec.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 23:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770019063; x=1770623863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRIVmJL3tSUzEWbmHeuBiYdL6z2LK0b9AkJ41US+kYI=;
        b=eFlMYq0pYhoUvevC8y94Poiwr586QqcK6TuLET+oaxFB8B164xB5k81nt184UBp8ZB
         3zz6EzkM3fU8Bs93TBRihLWbJCUb9EmN5PPbIMN7fiK8469FpmYqZ4HpTI5wR3ZGmuhO
         skaeGYnHLY5NGYffqMD2L8MITLxEd0X1CNKapdUHYjE6l8VUJVy4R86Jkpa7zswmpZSj
         tJbQXEAjhtDtqDA6uM9Q/Q9Am0nPzUfuTnuqpHRzd+nwNczUHfLulps7jJOuS2WDNPOD
         DG9TZf8PJHm60ASC2ikm7J0fTLqOl39FV8mYBT1DQzuJZ7mOy3gS1x0NbIf04WFswwIT
         8GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770019063; x=1770623863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRIVmJL3tSUzEWbmHeuBiYdL6z2LK0b9AkJ41US+kYI=;
        b=gthW3OZoDc298qYH4/pP/WT5KGfA8Zuq2VTUKZPFuV9l6PvJNvv1Jounc+Eadd5lp+
         SUhz9i6ukELo34dpfB4vqjoO0rqfIlhpzOJeVcOVBBRgmnyvm7E7wq3fgnpIsN7fhrqb
         SzTIm7B/D3bsbaiZH0d5CQJ7JWa6O0xTvUa2dhc2SXl7zrCWxnqvqG6a01bfa2b5eZDH
         VSZqJBIIMf4RgLTVDmgqm0SkrXnClvpK72L8RcI7MlX8UpnFjltp/Nb2Q99R3EafNvFd
         huUG8KPHeeFT12/qVmv9Jp+ic1ejl8v2o3UWrDYzqg3ynSwzLg6r2eD3mnBFzpxsGy4z
         Nqlg==
X-Forwarded-Encrypted: i=1; AJvYcCUjHCE3WK/kzCSWCBZtoeGoV2xib96sdYNJyOxu2aIqIJGAdeqsLWBJ9nfyiBd/U0vD8Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaMfM6PDbpl83OUZ7ifVDGMsxIo385vOEuTa96cHwfiLBhxr1
	KAQ1Nyf8xlgVv/LI3xuk/3pM+E0x3CE0fNTWE6/K9cHGXs37H+H46nhacOW5eA==
X-Gm-Gg: AZuq6aKQxlX4pj7Mh+mqfu7oImZpIU3bjz0/GyK7qFpLxfnQ34bN8aNTvr58HLt2Yf7
	oFC6FItZi2kfUrRoux6hr6K6m3tQcNgu0lspLuQnMRMKoMbxcvaSeGtaBGsKo36zUw7PwM600xK
	vgZ28ISfc7S4uLR0/iuY76BR0Ktv2TtpFM6FhpdaEtEW0vdEi6d2sHD+QH2PvPwWZsBJazVWwuy
	+NUSbW3dBz7Oy5xYUX41CAD59FFKDIroNPUcczMvqPakYyzxGQFDVa6Lnv6BHD9vl9pOVkvSGkU
	gQJ8DYOO0ImBVemlhFRNkzwhLq6jfpHtoNATPfPDVp6X/QUJYg0/MkXIaDuewpNSmL7vloFUU5Q
	OW6TV2V/RRFupf4mRJW6aTGz8/lokqVfOErjkZARRbOEFEan+R393i18oIf9vv+6AuIcHvHlRd4
	5gb8ngbeUYi6y0mHxbkMqgYbI6kNw9VSspDDmdPqGneQ==
X-Received: by 2002:a17:902:e801:b0:2a0:d59e:3c9e with SMTP id d9443c01a7336-2a8d80382dfmr111267515ad.33.1770011912514;
        Sun, 01 Feb 2026 21:58:32 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4173a2sm139121185ad.30.2026.02.01.21.58.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 21:58:32 -0800 (PST)
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
Subject: [PATCH RESEND v3 0/3] bpf/verifier: Expand the usage scenarios of bpf_kptr_xchg
Date: Mon,  2 Feb 2026 13:58:15 +0800
Message-ID: <20260202055818.78231-1-pilgrimtao@gmail.com>
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


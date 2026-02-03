Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBF2F3621
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085653; cv=none; b=YzDIMWTmhwl+T0mvGf7biq4Babhz2LDOva6HI05YsKff+9miRjxWvURclwAm0a0IxMP6dobOSOna6D+w9nAiXD/WVxZYTH5Be+Wm8vtcBPxndDZqMFKiXkttJ/+K6A9aDmgvycRxcMjMUnm6k9iSVIMPboQnvBW1rTS0uJp995c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085653; c=relaxed/simple;
	bh=kPggzZIm96TRb/FKapQWnHk9ReIs7DNsMTFOONxjQzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIY1/04joL31Wbv+xcSqdHf8XzLda9RAiAH2EPDwn0FckER825ag9yuFhs3QdM7cljdkVDSNQ6W+77bmI+YaWZvdBOTyHR8zSkUFUGOw+DSziW4rOoLlHDTtiqBwIroxu/E7OYr4CAUuTSbZvI3L9vQ4J9+9i0FePN5zIDGoycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJzhVpUD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJzhVpUD"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2771854b3a.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 18:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085651; x=1770690451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkA9MaWRwNjxNhYn+Z2bOC8alIVsObfDtM0GupRSibE=;
        b=hJzhVpUDzSBgL6e2KAIIcjkgRhy6jgCflIxOPiDgsWU/R5EG1x80qhdgxTER4KGtap
         GibRYxfK0TPkLOu8eP4alb6I5Kj+QbV/NVxHFO7VlqQ+W5NS4Z0tNOSd7wdtE31k3xgr
         rzul7a39PGOa9m4BmrBx4QhVIRWskRFFyPu8G0UPpcNlVF0kbX8AYnpw0a5SqZq9Ku1X
         IZnyLxTh3noT2eidebcUBxCmuC8oyH+hm0A42uMvIi5stTIEtxvsevdOjTUcQwu2cZ8y
         BHcBo2XkcFWmW2Tgkj61WWFP19LS0+Ytcz7maA6XoxKjEp9eH0jm/9hUZuVt+DoyeouM
         hhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085651; x=1770690451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkA9MaWRwNjxNhYn+Z2bOC8alIVsObfDtM0GupRSibE=;
        b=TfytiAOdwk9SFa4H1qWkSqHBrkjsF5AcDtU0xIg3qXmPmgnqZ1asueN5uETbgcLSEx
         bxttkMYu+fZxkV0gxwHoob0Wq188cxXVrC+sPF3bet8LSeio89EzZ+D7xPBXNrJ9j0TT
         vjQvoZRIUN9Ja7V1mxthT21lkPR/rgUr8or0aTWgcPSAEPm7vAnYj96AmzupK3devh3R
         xxMWLc9ormHXPmSPwBBiaeU0Ble9RWeyb3cZ86xYQw3XzUyTKoAQiuunqb6cbVnuNrnb
         kwwaIvTlPnO+agp+d7Kul5nnrwedAf7/R+rdl5UM3Y9Ak1MNFPqp+wQlYIBttGaNQMhG
         wNPw==
X-Forwarded-Encrypted: i=1; AJvYcCUqVxxuhrpcXIflf9PJ91YQTMgWhpNrOlRm0z1qNPcFOSzH0SuTY2ITd5wnEFv3krLsENg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuF7inHmo64BRfvsfKTLzZF8oZqKnDQbuHKXdgbRdkvOvGYvUU
	MEkZd5mZyczQHQICsJBvI7ZKm2AGGZV6u6qSsqngRWik7yE7evaO6ZnD
X-Gm-Gg: AZuq6aKA57wZIib5dYrSSYngNjseXgVv36/zxB4soDmVTenwlMpc1J14TKIjJvj9n5F
	y2MzYH8+ZBWq5f5CpF7BJLgb46dkjwr6gDh047lhpc5d+G0o/PZQO42XuXDEEfd3PazwX5EQcou
	NQ0mIf+QYcenE12KDF+2ahYDh1ac+wD/Ys6TI8z2AVziG1j6dOnOXZd5SK11g0xdYqIeCqUJlPh
	r/UrkRmmPTDMtB+zGlZ3ogxgOgUzZFH6PTO++Q01ry8aHgdHc4aXdd5zGwPpzQmvHd++wr43Bpr
	KD6YAmnjo8DVoJIF7zrSMZDTZuD2mrW3o0W23CxLeXUv3ncp587spw9vxhA8mIkC0yjxBdHkQe5
	j4Y93476I1fiECjzLfj4wTmYOCyrRdAs3udjleQL3a4EMDuVlKdXTbHDUJMPiIpL4NupBoGcC+a
	5mZq934OOtABG1kQxN2j97TaM9Qu0wTvj4aofVOc5yGg==
X-Received: by 2002:a05:6a00:ad81:b0:823:69c:931a with SMTP id d2e1a72fcca58-823ab65a326mr13146087b3a.16.1770085650612;
        Mon, 02 Feb 2026 18:27:30 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm17803073b3a.24.2026.02.02.18.27.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 18:27:30 -0800 (PST)
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
	Chengkaitao Com <chengkaitao@kylinos.cn>
Subject: [PATCH v5 0/3] bpf/verifier: Expand the usage scenarios of bpf_kptr_xchg
Date: Tue,  3 Feb 2026 10:27:09 +0800
Message-ID: <20260203022712.99347-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao Com <chengkaitao@kylinos.cn>

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

Changes in v5:
- add lastname
Changes in v4:
- Fix the dead logic issue in the test case
Changes in v3:
- Fix compilation errors
Changes in v2:
- Allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
- Add test case

Link to v4:
https://lore.kernel.org/all/20260202090051.87802-1-pilgrimtao@gmail.com/
Link to V3:
https://lore.kernel.org/all/20260202055818.78231-1-pilgrimtao@gmail.com/
Link to V2:
https://lore.kernel.org/all/20260201031607.32940-1-pilgrimtao@gmail.com/
Link to V1:
https://lore.kernel.org/all/20260122081426.78472-1-pilgrimtao@gmail.com/

Chengkaitao Com (3):
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


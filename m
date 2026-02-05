Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0233B6CC
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330577; cv=none; b=dStABlesA6N3pEXewY7iLCmnOPrXjFaN6+ngYLcXlaLwLKukpt7UeI4SdafcRhcMCamg/hL3upaOZ+kVslw91G1AZxukH6sOEkqe28teGdwXsLRwOWcHxjbmvS9e5EfsF+F1SQJlt87oT3DsZaVnrD7u28YGstt0Aro+YewxvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330577; c=relaxed/simple;
	bh=CVxHcuu4T8HZtXjKX+jdBS7ybmzluxXd8M00RABLQKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1El5Vj9f6Z9K1VNvooCtQArtpzIRbiyedv0VMnf+YL2kUL8CcMAFU2HRRBLJOXiaSoQmBIcy90gZNU0iJbL2QNy8cK3+D8XCDHqvAkVpv1tulsBbRcYIfNyDFnonW4M9kSCWoFmhluldaufu7gycRXq1W/jYLR4N0fqwfgT1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfLW2C+t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfLW2C+t"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7a23f5915so10839365ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330576; x=1770935376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=SfLW2C+tkuHqxK2wHBRYmt/ArfcuBysmH2H5oNfBSy55O9CaP+SoLdLjgQQFrzpcxE
         SyL3hZt0O1YmNkiU6K0Eq1aVu9CQCHYCBGrp4DgOnwfjk9wLDAgpY5oRTlXqiys9wnr5
         Yt0lUenZALxSRErQwLpLms38sXvGWhS6R+WW71x5C88IUL4ZWjqPxVe4Dq9fJMr36RUq
         IXsVrrqTsgwpAoVNuDFOTTqxwZpKWe9OL6Zo9mHU0vNO99gZZPO4aLKk2UWYYdE8qNot
         NalGZn6j11e+0t+tTfIg/szf+oP3WWElBZNw/kzBMRwfZ8WyWJeaS2iwhSHGKozye0hK
         MdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330576; x=1770935376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=vRrrOnZWra5rqhSIpj7VJv74Mt7AGo0YEF1fJI4SRPNHI2LZ+u4w8Lxzf4Hfne5E4Q
         YT180N4b8S23RZOSI917MAZk1eb6mAir8Osh9XX2iFBqGCv4BNQuknHrGKmaZjIAWgUL
         hPOL1gXbO/1Yifu4wmtYD9DP4CgSHgiP+f6e2Qz1G2TIkEk3FBdoJ/Il3SkLjyk0LdVm
         aSwGc3qcwABlKs2XeuSHyZNivuhb619bZKpK5fNbMueAS2XJ5qSPYPwTun8hVPGSLHKH
         HHQwRcxZmBgTkFKMXfT6mNoSe6tCLAlkex4uLiv0Q1nPNKfroVrfTxKa8X2i8zEZRx4T
         1+7A==
X-Gm-Message-State: AOJu0YxfTx9m4QFgVRAKt1C+Lt3CvD4Su4kOrrC1Sw4wv/oEekKVRzaQ
	2wxuZ0P99i9l9JhS9XLaaKSvzMmJGdRXdp4YgqRBSTy9XBIWBS7yoiYWkAEMaQ==
X-Gm-Gg: AZuq6aLaS5nlchY4Gx/SfrZOCG3pay0A7j8zvTqW5MmAxx/MV/MfzDqWVs9P6LLBDOW
	6Nnth2W/eNBZo6SsvhYEIl7rekKqj7q5UA2krFn/9N6KAM8ilE4D+2YVnYhj0UchX6XZrtJV3a4
	+ERpJm4tOvkx4EGvY/WXaSYj+lcLpFNXnzSXn42nJ3B0+awOqkbe6TRs+L8Xo9kXNisyPDDgLyl
	EjImz20Gy2DgBgqulvajBnua2PGPnEpg3YP0L8oG/HG04aRGx4Sbb7+R5aS7jRirNFSsF2Xxcl3
	oBUmTuHCDGVpVEahNz+df8YTxxMbIqN95yyDFN/26KAf9N3zKk8t4TvOM9/0pRiMNU7kHiKqzz/
	RZYhgYNg8YE7igdEyYxTQhd1MnILmaY3RulWE3aKd/42mzRaaNQN3fmzwtdKBqzNOyvVJVxF5tb
	NWnw==
X-Received: by 2002:a17:903:22d1:b0:2a7:63e4:b1aa with SMTP id d9443c01a7336-2a9521f3ed1mr7143355ad.35.1770330576200;
        Thu, 05 Feb 2026 14:29:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:23::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521f8a50sm3811145ad.80.2026.02.05.14.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 17/17] selftests/bpf: Fix outdated test on storage->smap
Date: Thu,  5 Feb 2026 14:29:15 -0800
Message-ID: <20260205222916.1788211-18-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_local_storage_free() already does not rely on local_storage->smap
since switching to kmalloc_nolock(). As local_storage->smap is removed,
fix the outdated test by dropping the local_storage->smap check. Keep
the second map in task local storage map test to test that multiple
elements can be added to the storage similar to sk storage test.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/local_storage.c       | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 637e75df2e14..d0be77011a84 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -62,7 +62,6 @@ SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct bpf_local_storage *local_storage;
 	struct local_storage *storage;
 	struct task_struct *task;
 	bool is_self_unlink;
@@ -88,15 +87,10 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 	if (!storage || storage->value)
 		return 0;
 
-	if (bpf_task_storage_delete(&task_storage_map, task))
+	if (bpf_task_storage_delete(&task_storage_map2, task))
 		return 0;
 
-	/* Ensure that the task_storage_map is disconnected from the storage.
-	 * The storage memory should not be freed back to the
-	 * bpf_mem_alloc.
-	 */
-	local_storage = task->bpf_storage;
-	if (!local_storage || local_storage->smap)
+	if (bpf_task_storage_delete(&task_storage_map, task))
 		return 0;
 
 	task_storage_result = 0;
@@ -164,18 +158,9 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	if (bpf_sk_storage_delete(&sk_storage_map2, sk))
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
-				     BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 0;
-
 	if (bpf_sk_storage_delete(&sk_storage_map, sk))
 		return 0;
 
-	/* Ensure that the sk_storage_map is disconnected from the storage. */
-	if (!sk->sk_bpf_storage || sk->sk_bpf_storage->smap)
-		return 0;
-
 	sk_storage_result = 0;
 	return 0;
 }
-- 
2.47.3


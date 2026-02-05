Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07135E535
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274949; cv=none; b=ZkrQDGuImGCOjgls5GVcMZEDTlZs2BZFvNaHNiXj3lQI6tibihHNBf+SS3vSA+SihIhXDZ9BSWDUmGX3U00iXrES14W6p8xOid51f5klA72L7GnjAdTNujOTJQLy98pynj47cNIdSpla7DnKd9iTdb8iujD4q1MpBwsHUh1GCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274949; c=relaxed/simple;
	bh=CVxHcuu4T8HZtXjKX+jdBS7ybmzluxXd8M00RABLQKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6FpLbkmCIp27LM4uMA6+urshgUh3ch2mJHeisJbgwBBccVXrux176a+X9dvmGvnxL0SieYjG0FYciSNANCpdTXvaVwLZLD3CZELn/V0EWv4KOB6pkCjNINqPzb2USRO1jqjKL5GgrdD6T/VHoae3rBlrMfkNjPXHpWZFbbFMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB5yJ9D8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5yJ9D8"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81c72659e6bso423996b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274949; x=1770879749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=IB5yJ9D8cjwJuzWup4Fc7c79KFe3PAfG+p3U3wGBOYfCHqTEQhMjb9W4BX3ZHUbaRk
         y2VEChUnoJgbkeDJqCrkMFbxEm6utAVEnRx7dSaC2J7QDi/qMBUWN3rL60ypC3Q625aU
         KMH2hRUHJcFK8iiyy4mKVbWgGRpVoZ/FPrD/iWHcjT0bS+CPegX4x7RERa3vaY/uSZLN
         Wz6cNH2cqwoU3EcHspEq50NQOwb65Ot1aCrj8/ZTnF3UXZQrMUsonETQ7cYTfi8GMS+a
         RsHdGMYSzG8exoac9jVPTBZlTmXqYD9W5WE00sd8CcLlVDoKlI6H4dqmuD0q4uBzU+RU
         kEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274949; x=1770879749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ID1Rr5u4A781GTWL8cwP+lTOIhWrnwgmB+FcQHGuf5U=;
        b=CtWPKT0R8sYBng+2GyON89Q9b/xpabfAs8XimKYSv9cCCjZYIzjvJOcqLFjjcJ1ycq
         iceX5RVPM32Wqeu1+1wthsW0rL3mufmexpTEWq0OZWQXBT6IfMqgLnpTyEK4zdeSBNoJ
         GKdpGTYcWVqeOrzGIybFupkRHM0ylP5WhNLHUqL3/RpNSj97p88fC+Qowtj+pt67DdyO
         7ajuCHluBNcjBMg44P2I+I9jYJkLEenQVgXtG/waUq+PPEFNqaYLUtW7fUMTpCjnp3av
         hupkj4YxPGGvSL8rCJ6fW3UEUTrzMtSaMsSgJuKK2sbBck80ajKPZY442b1CJs0RvHlW
         6Yvg==
X-Gm-Message-State: AOJu0YyF2IyZoieCwVC38IVsPOQFq9cbfEkyzXtZj8YeL17+vvWKNsxI
	a1LeZRXK5thGcz3UfinGYhpUh0hqYiSRn3TO4/XPz3olh7cno8nWKygsYrKdcA==
X-Gm-Gg: AZuq6aIJxl+qwreU2gl18/59avpo1RQOnKVMWNCvk0z/qqVIqhyRNEYSEz+UVqrO+P7
	rYaZWZY3BPa0KvnNsGz0DBe6Y8xl/LD2z5XbbaWbk8W1OW//z8RKvBaHb7lApwtj1F9fPgQygcm
	ighFuxJbTXPEMsBulaJgHAFh0jF9sPrHKBFMXobvLyTiXPuVVJCtnkGLM4z9EHBIuwBbabaRhz8
	GXBvU5Xj96VJdFgxYa37Vhq/PHgKYM80HKRGR/ZMwPChBR1DzV/xwgLqw/YHJusp6X7p/a0mL8z
	NLiFPlGp+vY+s0ldTyEh8VBpDXW4qWJwbAZzMyW2lkC4Xq/VpeSehQ7xtUNtg6CFawo+eGtSWr3
	OCOebCZNod02cQT/li76d7buEaw0zoU/xkV0rr7WNC1avekD+Zj4lwZRPMNVdyrWFEO/mArkdJZ
	JD
X-Received: by 2002:a05:6a00:4104:b0:823:998:95b0 with SMTP id d2e1a72fcca58-8241c5f5db9mr4906578b3a.35.1770274949074;
        Wed, 04 Feb 2026 23:02:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1c08e8sm4834802b3a.22.2026.02.04.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:28 -0800 (PST)
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
Subject: [PATCH bpf-next v6 17/17] selftests/bpf: Fix outdated test on storage->smap
Date: Wed,  4 Feb 2026 23:02:06 -0800
Message-ID: <20260205070208.186382-18-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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


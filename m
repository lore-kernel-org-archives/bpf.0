Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536B3AA9CA
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255089; cv=none; b=tnsKXyIIwPkWV3SWZxf3ABi5RddDyygYbJ9QN0Z7vsnxA0/55TKcwHrpg+MYsMKJxnFEdojcDm2e7BaUPCvjjQP+eVARib3Wd4W6RWRtzlXyvUMNCX1g14NOl/VwKXup9kuOuQT+u1kthoa5+EmNHHpfcg0VeFy/JSVlHFhOXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255089; c=relaxed/simple;
	bh=k1zvhGigGSPLpGn7I1t+Ecg+NgN2CKsqg5w0eDmK1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdZFYiy4ug/sU8svEx1oLvDOIzFn6JVQuDxtvA89ujWDenFr7/LgepFgR3mJrPH0CY5BNF5kbzd3aVRy5zBwqL02vzMQWkPjeU2ljClMAriVl0gr/X64hokxD4IXmxMcK9XQM5M3YQZ8/tlsJWo8wLDoi+ikdYkzsc5i9x1t/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVlMdutf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVlMdutf"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so567304a12.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255087; x=1792859887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=eVlMdutf9BmRhjcL560lsYceBj9YDEUaaCvRIBrPqv0V11TXmTFFNbSalWi/OaLS+y
         zg4iguh7VOnK8KCiWMABclJRmz4mb4mBwxgvU9G5qISE4lKYKwtVggsDpob1L96GNsLk
         XjnefQFmXKhqzlyiy3JiubjFayUmmqHtQD6xAr8XB9ztmw5z4I1bbVKbi/wuDS/Hdevv
         Rw1cPI7n8yKVjApb5arDGvfLhr5b6g605LShiYqSPqYnblronGlVCARwZ0hiIIwLolix
         3yBHcG7yPBqDqc01ZMm1qN+GUeK+NXtMU5m8OBsTFLxnwjbhoY4y/zNzs5r+s38sam5l
         xHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255087; x=1792859887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=t8WYwIcj5M+xCf5oUFl1VNA21/YuvWhvsspjw8j78Hkl80xAc00C8rdK3I7tz4ZYQ1
         gphi2tjoYCb4HG1zG3uDPD7lL+Btw5wm16XQXX4F28cl6KO0hvqJkv5IyNB4Hy6scyHA
         IbrKouUfvlt5LJgF+sGT8Xf7CXuXwGqUXjw5xf/RwWwHLDmFNu56Dmbbp8CCQTOkibdQ
         mC3/3+EdeW0KUDBDS53ZnWHraIK+Btt1zBTxzzMDawIqUJcS+4aGD+fe6csIYUhAVQnD
         h+4nHQoiXgKKB+TjHoHti+1zb9SMk3dfzwUFp/kVJA1H5JhZRZTi1t1ZWwfC0+b/gym9
         qhsQ==
X-Gm-Message-State: AFq9FYKtYMqPxQnnhb4byDV6sXn8z8NN+PxquOG5VNTT9maxPo4XHn0z
	CzMe4OkUkpYdJl5lSKjYh+dWON+tLBqlrGynTVdbaScG0Z85T1BAwSdfQZ5xfA==
X-Gm-Gg: AYBFou1SBj73KD4n4VauE9tWTaGzqXrD4/yv0SqMHsZpqTasXyHAq2GK57W3NbYpqQw
	tYZAlGigKsqzNhN6QlwMwss+vS5h+pIc8Gl4lDewJh13Zeb8J06XSHPeGdo9ouftsl6MpkB1nPh
	ZM3OXFh4WBi9xRE+B+TDPIENhZZeiaxFmCSR50s2odNpELBmgusHz6dfDIHS2UIjgPHPJ6E0Pic
	bZ4exwPqHUYlLZDebAxhfdpE/H90xO2Meir7og52lx09xRroSDKfhZENCIMlVaJG5B+f1U/3DF9
	BNNJbWuZ2hRSEO/kVmfd4vOU3aOxJGu1YUum2lVFIV1vnlnvotOeCScCYxIah+rnOG7NZ5nuFIi
	iAE3RBPbOc5kwtLW0o3AB7r2P53ZgB0RwA9Xvh5VmxfdqpfI0ElO36YoE4dvXe6bSe/MED7rE98
	1s4DWe50CUJxPyf9fy0kJJsNk7CL4QWg3ZfkSmu7e24oMMXl64wMVKYR2jO8oTSFtfbbAmPJ48e
	6VMgs240eDCYEAR468EnLVYE15HWFPdG36RTv/CQYWfNcotA1yKMLuY/Tuk4tGQRKSlyH/HLzw0
	wqoh1UgDMnPv97P2m4e+wQInu8dFR5JUS72QfieJzJtQD2mCntz0IQ==
X-Received: by 2002:a05:6a21:174b:b0:3de:60e0:5c9f with SMTP id adf61e73a8af0-3e226114a5cmr2548372637.65.1792255087416;
        Sat, 17 Oct 2026 09:38:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fd010b47fsm1981842b3a.31.2026.10.17.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 03/43] bpf: don't leak the inode when token creation fails
Date: Sat, 17 Oct 2026 16:37:05 +0000
Message-ID: <20261017163745.3341787-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_token_create() allocates a bpffs inode and hands it to
alloc_file_pseudo().  The inode reference only moves to the new file when
that call succeeds: alloc_file_pseudo() leaves the caller's reference alone
on failure, and FD_PREPARE() does not even evaluate the file expression
when it cannot get a descriptor.

Before the conversion to FD_PREPARE() the error path did iput(inode).  The
conversion dropped it, so each BPF_TOKEN_CREATE that fails with -EMFILE,
-ENFILE or -ENOMEM at this point leaks an inode.  A task that is allowed to
create tokens can hit this at will by lowering RLIMIT_NOFILE, and the
leaked inodes make umount of that bpffs instance complain about busy
inodes.

Put the inode again if no file was created.

Fixes: 981bec8f698b ("bpf: convert bpf_token_create() to FD_PREPARE()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/token.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index e85a179523f0..19660ef95ddb 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -169,8 +169,11 @@ int bpf_token_create(union bpf_attr *attr)
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
 				     O_RDWR, &bpf_token_fops));
-	if (fdf.err)
+	if (fdf.err) {
+		/* no file took over the inode reference */
+		iput(inode);
 		return fdf.err;
+	}
 
 	token = kzalloc_obj(*token, GFP_USER);
 	if (!token)
-- 
2.55.0


Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28F12DD96
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071618; cv=none; b=gtitH6IUiVE2ioZ5TxYerCYgueVpc4ftRVZckzQVh9ZQGoDUUB8JYGTQFmO4g2HhnhkHfDwJlfMJfTxtT4DIfLVWJRR1NVcJO1XCnOd9Yb5b85aMnqZhliym7/mpsdIM4CXG/Zhg6E7AIUyKHYPWD9ttXEUy8aBmyL9N+IV6ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071618; c=relaxed/simple;
	bh=diSHjj3cBfpFyTaOacudwcNbs18dCRoLX/tLqNNWSSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQg6fDLuMynm2qpAAE0LzERKNQBL8aARVQSqGQniOowmyujb7opFjJNcqsee1iryIlS8+dANcxIghSRtEnaAdHBq5NWK05mBdfn3qxRE/NcquCo4+U/wRxDbmxse8TWTlezTw2oltCrw7zI8Qq1G6def5TCPQihT4+4v1tYXL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVfSz9bG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVfSz9bG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0bfc42783so44075075ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712071615; x=1712676415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyFGF2U/il33LsyjLF4WROQuetMmTq+Tao/JO3Ce1fQ=;
        b=DVfSz9bGUm3TRw+BzL3JIYruIxp/W8CFmGaE85VpjPFKuKKm/BN++e5+FOGfa19+Bt
         ifmvQA1liZem2tU3sX4KRDJ2hNH85L5Wa/mFXobgzpjV5i0ZHQZn0E8TJmeR3d7hc0Sw
         18iOzCXKYAR2/JHoBhgQCsuzdqjDqHYU+1tzOZhG4+Fm8/dbyxg2VN8tBU6RZ6fcNYVO
         2S0R/HOZynQcBguM9q3meAjOQZxpadT3dLOIh8/WkweHWtxZeCbg0+d66LYzvleDofRd
         vKQeis2PdrOi2tqxlwpRqQ59C3g1cHz8t79WeH/gZioA05l8p37fHZLhpBoGVFhuHAa3
         iZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071615; x=1712676415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyFGF2U/il33LsyjLF4WROQuetMmTq+Tao/JO3Ce1fQ=;
        b=CMP/4bnLk7ZdTcRSr98Be/8VlK5NNkNxWBVZIMSTOGMaHMqD+DwwY1VJZpF1OOChb3
         ZhiZWGw+TnhrZKmZQRm1LnZdXbiafwHWwLupj9RrFSJOFcaN/FjUEZ7w9rdm2qYZ10mB
         w39IewDdBL9tfYCqBUdkUwaIspRgGd1jGl6EfXEma0jGUToXRP+6Lodn5hSFno4+ujaV
         5fu/mb2/xW8gwZNZjygaTxYqfWVYzqaRLi45ze4r7Ug/kA3K5NDjwlJydhC7kZPbxwCk
         3OdUjUQDzXQVclkqa6uocCuYfZ1+iY9rSMPgdymEwgcGvfF6eFECmsOVqJgCCnUd06nI
         UFRg==
X-Gm-Message-State: AOJu0YxbausBr1dLHGCXA+7NhG6ZGHb+/aleDNUPrkSp+PxnAseeRW/Y
	oOB2OqNPOecoVTNmezINZRFXjPAwweuGO//gp/vCitw2XUr0Xf+kg9VdI9hI
X-Google-Smtp-Source: AGHT+IERyOA2AS8+m9kMFRqI9qhSZl3pUVv4MB58+tp4Sr4CwwT3n2EjXq3LLiz3XiIHCh7IBXiU4A==
X-Received: by 2002:a17:902:b906:b0:1e0:b62c:3ae2 with SMTP id bf6-20020a170902b90600b001e0b62c3ae2mr9943974plb.10.1712071614958;
        Tue, 02 Apr 2024 08:26:54 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001e0a08bbe49sm1640505plb.140.2024.04.02.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 08:26:54 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 1/3] bpf: Add bpf_tail_call_cnt to task_struct
Date: Tue,  2 Apr 2024 23:26:36 +0800
Message-ID: <20240402152638.31377-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402152638.31377-1-hffilwlqm@gmail.com>
References: <20240402152638.31377-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to get rid of propagating tail call counter by rax and stack,
it's to store tail call counter at task_struct.

Then, at the prologue of bpf prog, it has to initialise the tail call
counter at task_struct. And when tail call happens, it has to compare
and increment the tail call counter at task_struct.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b49..d0696fcabf14f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1501,6 +1501,8 @@ struct task_struct {
 	struct bpf_local_storage __rcu	*bpf_storage;
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
+	/* Used for BPF run time */
+	u32				bpf_tail_call_cnt;
 #endif
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-- 
2.44.0


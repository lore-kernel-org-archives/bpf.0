Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909372853F8
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771044125; cv=none; b=AL3S0Jy2FBHKR44U5RxfKxHsQZLJfI3hy83+mCGRu4ZmuI1klFhgg0dgKqAjHnHRZnCY17/661VQ5dH3lUttKXKkKkbbVDgXHkIXb08hPlDiSN0WUzw7jYxXGVpa4OsCs3vot5ObWAuiKlditLb1QxO8WHXxe2PxJTD2734QKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771044125; c=relaxed/simple;
	bh=2FB6FNEUmRqEvJrsfcm12S3WiLj52iwiiEsSlithQRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgPZoPkYuEdGgWATBKvRnvQ+kUP2HjgQvxq8ClNXhDwrqIfx6cXXG6L0WgPLhD7+j6AtaggN1UBQscBlMyGVvldmmiWSEaQpI2IgA+1SqGShorIki6l2P8HI2y8s8coYyp2GXZg3JxpxU3ChVeWNhRSDdTa7n3JVqO0kqldk7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNRkvvUL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNRkvvUL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7bced39cfso18071575ad.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 20:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771044124; x=1771648924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hL0biNfu0bCj74/q4qzrxVbBekW/yRDhJUFSh5YAd+U=;
        b=KNRkvvULkjTsVzyZECuf6zhVJSHXsgb5Ikzr/Nuw9ypDhV+stFMlpqqFQabVn6/D9X
         +jgFDewJjTZnd2/PR8aS4GyqxufqhMqAFx33H57hEh4lcKAmw6Ow3At9hAKK+bHUT7W7
         pCSPCq/PGAxQyqm459LOLHYX8z80+kFJRsLoEB/03gsuKVQM6384z7uEtyf/jEe9KupD
         HR9JcXW7fCsv7P/J/HysG093vgu/mNwC6HCoBlGUk1jgu5OWkATIAjs1K02g8a3IfzCe
         +TAxkE81wHrcuQhT0WAHqb7CC85DGSaf4Np4sCMSF+BVbRCD71hPUisYHk3PWQtZuy10
         aLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771044124; x=1771648924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL0biNfu0bCj74/q4qzrxVbBekW/yRDhJUFSh5YAd+U=;
        b=hnZU7DmY/+9aCGcky4YFFS/uMJUUiImjY9yif61VOVNKgwLWGb+k3a+Z3VcmFlCLoj
         Qr9i/PcGQIZ1SHqE3ZjqvcAqKT/djCLNbeJ8XczHkbMq9kh49F0kdXVaZOWdltsS+efv
         6yC1rQCshCdHwz5cRix3STYGbrKkZasPivtvmTwMdIkvFLmcBXZH9jqkelOxs5UUOvk3
         +pLxCXwyWo+0vtG8Y1DV+rzYsYXJtdGQsQ3Twk850Fe4rSL4mBE4VRgNFRhR+pRMMAPm
         5RSHg9sXmPzEt335sRWX/PbO0/OHiYf7wa8IFQQBtMPTlIe1K9aaKITOxOkU8Y+JYk98
         /Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCXjSSeFcsAq98sDqkViGqWN3XoYssg0y1Bk5EGAM8OC9qhR0eMQFMMnyHS/qrF1c56nwvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIiKdAqRNP14WLRS6gs1pbKd84pDo2ZtVJITqTpTtbUuwoTxTu
	Y/BcVQ9VuZO3IaV70r6toS46BB/Eq79d2A1ncmsClUHS7pAjU2rAjtw0DOPq9Q==
X-Gm-Gg: AZuq6aLAlpkaeCrKKQMiVsHJZjh72+RMurQ0ct4tFQmxkmymI5h3h4WUIYVYvs+eVsL
	y4Iwz5zM5t6E4RGs21LOACoB6lngrl8WMmq1HQbM7xIm6OCB48VNnx8Xs9sAHfgTqqepX/BqiR8
	DIRZYhrSJvZZ5NJA6mA+OsspVKwcSl/6oONVsmXLT7dS4EEuko4T7+jpYUa94bvsFsjZpJiUqLu
	3e0wxDpdsbTvnUigYt1dJ5r9TDPwi6APHwdfkFKw2vlCfAlVUuJYXjlIAMI+r2vWbrVM48cxgI2
	CtuLG5r2QvyuoYAD33QXj5mvBqfPuYoRLEDdgkgHmiiXWrPcBtd5UYlpKyRAJ5J7fTdZyybYxlW
	o3/4j0F4je3SIlcnHHUVnJbqfJyWGMivOjHbJVdFPqt66ohDNM8D8rO9YC6ueQp2il+dVxmPuLv
	lNm3HS+iyLrnwWpLG1ChwSQX6bXrwnYEqBsABbDYZ3qDIDITjWTF0m
X-Received: by 2002:a17:903:8cb:b0:2a0:8be7:e3db with SMTP id d9443c01a7336-2ab5050a113mr41560675ad.15.1771044123931;
        Fri, 13 Feb 2026 20:42:03 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa21dsm7218885ad.12.2026.02.13.20.41.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 20:42:03 -0800 (PST)
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
Subject: [PATCH v7 4/5] bpf: allow using bpf_kptr_xchg even if the MEM_RCU flag is set
Date: Sat, 14 Feb 2026 12:41:54 +0800
Message-ID: <20260214044155.38820-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

For the following scenario:
    struct tree_node {
	struct bpf_refcount ref;
	struct bpf_rb_node node;
	struct node_data __kptr * node_data;
	u64 key;
    };
This means node_data would have the type PTR_TO_BTF_ID | MEM_ALLOC |
NON_OWN_REF | MEM_RCU.

When traversing an rbtree using bpf_rbtree_left/right, if we need to
use bpf_kptr_xchg to read the __kptr pointer, we still need to follow
the remove-read-add sequence.

This patch allows us to use bpf_kptr_xchg to directly read the __kptr
pointer without any prior operations.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3536a91ff8c7..5baa12af3a4e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9320,6 +9320,7 @@ static const struct bpf_reg_types percpu_btf_ptr_types = {
 		PTR_TO_BTF_ID | MEM_PERCPU,
 		PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU,
 		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
 	}
 };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
@@ -9491,6 +9492,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
-- 
2.50.1 (Apple Git-155)


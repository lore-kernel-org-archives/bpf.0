Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBB30C629
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072875; cv=none; b=RjzwYPllxnMPkr3u5XY74wqILJKyQLyRQPOFOaDarDfiljNtOq4xPHRieOuwFYb11X1ThmGjDLB8KEwuQZV0C9Nsn52uSA4iGeZr/xbCUJUdPk+Bd/9nus5Q8GFUu+zotceOnS8DgLf+CNrn8APqfRAuCyfrdVDEjBnZ8IVCvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072875; c=relaxed/simple;
	bh=Ye+oWlYE72o2jiv4nukJNQWUydaCpWaI5XFqBC4XqUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIc9JC4/fcgl6CNNNb+i7IUpRMVb1Dn6Nnztez6145U8GqccPAerXdbDmbox5odG93lff3Heym/ga6MvKOfDt/ITSwbvR9k2TnFArXiHMrbf7gSvqSlc2enJlCzCnPT9S/UlzkWtMBuV4LPHnEa7dLn8D4yhwvvGz29p7e4fid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQAk/LAW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQAk/LAW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824adc96ad2so1838007b3a.3
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771072873; x=1771677673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbPLRwzzn4WS3fd519NwtSlQa9Kkj67LEXJEwwxQVcI=;
        b=kQAk/LAW9bgNkx12z+KU68iAKh+j4YeD38XOunQfVY0cCkWyap8sozLKzC6GQ6d47+
         KfOhx9Z9fTMshg+Lu8NFrm/Gd9N7yh7oZ6vEmJaWAxJEOjGqzllhkZ/Wy5rLiAK1v3NJ
         xJJznZ/ZXkczrgjo4ek/7luv/S0citc+i6GmfTfriNmyJjV66MytjpJIot6y4I35kgJl
         9z3I6lEvQaPqFXqey7uHX6jAvchOP9fwAZOlT8S4AMqf4b2LScY6S0t0uE/PFRTeo7nS
         epm3x9OBZq6f8vZYDQTXUgMAQ3OyYw1Sx/tuwVFZ0KlCi1wRLQ5+0ve6CDXfU3rZDMFb
         QJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072873; x=1771677673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbPLRwzzn4WS3fd519NwtSlQa9Kkj67LEXJEwwxQVcI=;
        b=GS98eCFbR7mJ1pmbsdCVrHB3YsF0jSddHJEcyfbt39u/4bO3WuIs+R79LCFBca1Kis
         f8ROyFAv+gKOXnlNkdAnsr0ooeyESsXjZXgT85zZqOOK4YJFebU77sc6o+NKNWDQQA8w
         ni+Yu2GAXjRGoDRyirJVjwbyTxbVT+uNhUP7XXhzzUqvlE0auVamG+GhQoMew4zoe1R1
         zpNR5+0glEG0tnH6Zj3lj5IGejqSEGcGDa0Ye7Vbzo1JzjQbsvpLG1Fqa8/ywKHevvRE
         shDUpo+n8etcShlXeCLFZZj6lawfJfAuXCaUTJGIJkfbJJ6YxTnZ/dFtNw95q2rQ/rzM
         paXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUklaNJdIZW5ny5LEUmTW8agMnCV8cRQto7plOp3lu7TN6Mn50+3KXo58hmvGV9H834UwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybN5qDuF7a06H/RnfXACqfLpeZ/WpdWlSM2R0szrIrqjw180W
	5+KxETQA1+0q6mEWtzVVfk45INZ0aAmq6inkY6a8S0t940HlpQympA7l
X-Gm-Gg: AZuq6aLjCdU5rmlzjc+eHZCIiIfUEWgjMxQECD2AdBz9YPvBckuBMSl5YPYrxSRkUFb
	r72pDhplcZUPDGSZg3v/xCBMLOsON+Q1VtzjLKpRfz0bHocIYANLhYD0Fc3gw3CxzL+i3R54GNw
	OJkuxhPFw1jNm1Rqbk5xzf1F1xQFNtonwLmQO2DWE9xIPKj5Y+hY3I+pec4W9fNpazRESN0GUTZ
	tyRW8g4cW0KVa6ufgwZLXIPHLZr9ofmOxq5ZK9HjaiZpeckoQW/VA5whSlwC5HuDt6GEmTrbPZs
	kdM0yPijLwCgXlvhHVmMn3d31dui1rUtXfOnecq6WYcS9vd3QtzrRWqWzl8MuQVtYcfAeHVSCtr
	Sy1cILCzGRZ/9OipOixqkZNPI2fMjzj6Y96sketS2bT0oQGZQzRqE6LD7LXnyx8/4q3djPPuRfs
	k0S3zI3Zwvh8q3LGrXi7z4kOgJN8+Q4oXhgWh1oFWsCILZnd5kH6g6
X-Received: by 2002:a05:6a00:4205:b0:81b:8872:ae10 with SMTP id d2e1a72fcca58-824c5d0f68emr5058863b3a.0.1771072873255;
        Sat, 14 Feb 2026 04:41:13 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e40bsm7064497b3a.11.2026.02.14.04.41.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Feb 2026 04:41:12 -0800 (PST)
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
Subject: [PATCH RESEND v7 4/5] bpf: allow using bpf_kptr_xchg even if the MEM_RCU flag is set
Date: Sat, 14 Feb 2026 20:40:41 +0800
Message-ID: <20260214124042.62229-5-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214124042.62229-1-pilgrimtao@gmail.com>
References: <20260214124042.62229-1-pilgrimtao@gmail.com>
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
index 3536a91ff8c7..f673cdb55961 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9331,6 +9331,7 @@ static const struct bpf_reg_types kptr_xchg_dest_types = {
 		PTR_TO_MAP_VALUE,
 		PTR_TO_BTF_ID | MEM_ALLOC,
 		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
 	}
 };
 static const struct bpf_reg_types dynptr_types = {
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


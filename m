Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C41367F5C
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643259; cv=none; b=PpukLTnvKwsOVCAjgLFM/RIBXV3GUwtH0CgtBAKBy7lxh98mX05px8ucz10qFU8an2Ff+p0Sd73BFTHvK5otkzqYDWLuQZem8mMsPRs5Xb1Mri10AYPiBnnMH8VZMJWzrinx7HmOvMSlxKrzxp1WoGA2raVySDb3qDoImdgxfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643259; c=relaxed/simple;
	bh=ZRDgmXWV2rTk18uqa+3nUo2ICoKg10NgIL4ScV84a7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/SpuzXFmnWejO+u/q76eY9A5l2zGgMDfEWU0fkgoh8NQdHzz1owH2ejPaE403PKn8Drxd36m6A6g02b5ACKG7Z1lF07zZXK96nKNB4KSSBRp341tUAnLejBOxbDPbqAuRSq1TXKbSf+svADmumJufqmnCwobH/q6qBVWzpsXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLFaEh4n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLFaEh4n"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee0291921so28158725e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 05:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770643257; x=1771248057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qI9FGuo5sVk90HD2IZ0DaJx8cBbfY90Hh1oyTpghi4Y=;
        b=TLFaEh4n62wk8yRmNUto4gf5a3xLX+cuGZlWzThq6oYqZZvzZligVAwHLMLwQpA2r6
         5zehUoFe16RF4id2YVYaoO3KnM3wMa1WwMmTIyezgVhLjSZD2wVsDJEvuz32UCd1Sz3H
         hlVk/YJ2yVFLZpHKpc253v3/2B/X7di1t2Tb7fJJHZ3ltOOwQIDVQ7CbL3eainlsEp8a
         Ftf5dk7eb9gzY8t1OxsN1EG/LNYkAomf0goX1HBmXXswwinMV3O04mhO7mm7ctavkntA
         glOS84QO7d042jZ15i7lZetRHxIhIJ5jjqMkBs658KPJRw6UBVwEI/0xB8+43ce7xQZb
         TDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643257; x=1771248057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI9FGuo5sVk90HD2IZ0DaJx8cBbfY90Hh1oyTpghi4Y=;
        b=XW8C/au51aqKSlBJyHpxcSSEcaEcpRrxHwT/YeA+pjgO3m0V2SUf2QuPUQkqP9qTxV
         lWbzrcL2nutC0bfXwvGeskH29p1AbHtD2qkInm3ve9yL4OgU2Sa9E8qUypDMhBz/SSMi
         Fis6Z8zJI09z/vzSqHhFiCswxufnZ9QCSwv6vfpTUEtXJy8D3j1AYGSaWRDRXOAkD7bt
         /GapoKKS67pbGbDr6+aIlREY9KxE7TAg6GtrsWxsd+5QOKutKDSdpXlnCBEGVKHYgtt/
         PZApKZDlqO7QoTzCsj8ZsS4SA1KSov3KThKXLFaWTgp5wWVNS/AiNsU4hKgNBA20Su6n
         mIBA==
X-Gm-Message-State: AOJu0Yw4FiypKFuhO2Ol6ff+MUTDkboHppaF9axyxirIi/QwQpPDaR/o
	mBwfSvRSJPRtYT9kT9KNNL2CyndEAULi6HObdHzNRJQKpWjtgMDSzZOathzT0g==
X-Gm-Gg: AZuq6aI0JX1B7r8c9uVVxonvvTptC+857X6WBVTgjm1JPvKAWNjzB+GY1Bk3OzO22+5
	jQ+TPYFOv3msi7lc5emDI57ZkZUqXTc7KE6hqzZ61q3ZBCM1dbOLRaIfoVfRjWfasSMlFpPc7ei
	jYCVkn9RLzXm3oftgtGrEQ1el7K2pCdhQpuk61AVwQ7oN23mi0iX6XwQKq4J8ED52HEqjggWJvB
	EWG79MPV7VG99XNNEsqAPiU9GCNidqwhSe/TmfrOkcEXdE6tcsS949smJ9D87lYWBh4fuO6nIsp
	pyQ7xN4/EmIxghX9d+vVc8jJeEGykpnJIwuGcmXVFxEbzLtOfK3J0yQ4UlqdUVMd48BIdX05bfl
	ElrvRlzDka/IQKX1GzokHnoUxAanxFsoJbUPpEnZsGfpD6lhpDHKCnnJzkT+brVvgM9RTQupFMe
	xkgPY9Sg0H/Wx8Ze2Uzx+Q75AH8UOg9Vz83Jo/Rkxu
X-Received: by 2002:a05:600c:6290:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-48320226676mr182000465e9.34.1770643256826;
        Mon, 09 Feb 2026 05:20:56 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4desm26981545f8f.18.2026.02.09.05.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:20:56 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Subject: [PATCH v3 bpf-next] bpf: Fix a potential use-after-free
Date: Mon,  9 Feb 2026 13:29:04 +0000
Message-Id: <20260209132904.63908-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refcounting in the check_pseudo_btf_id() function is incorrect:
the __check_pseudo_btf_id() function might get called with a zero
refcounted btf. Fix this, and patch related code accordingly.

v3: rephrase a comment (AI)
v2: fix a refcount leak introduced in v1 (AI)

Reported-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a0f1995634f7c1dadbf
Fixes: 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..d4afd571761b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21333,29 +21333,29 @@ static int find_btf_percpu_datasec(struct btf *btf)
 }
 
 /*
- * Add btf to the used_btfs array and return the index. (If the btf was
- * already added, then just return the index.) Upon successful insertion
- * increase btf refcnt, and, if present, also refcount the corresponding
- * kernel module.
+ * Add btf to the env->used_btfs array. If needed, refcount the
+ * corresponding kernel module. To simplify caller's logic
+ * in case of error or if btf was added before the function
+ * decreases the btf refcount.
  */
 static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 {
 	struct btf_mod_pair *btf_mod;
+	int ret = 0;
 	int i;
 
 	/* check whether we recorded this BTF (and maybe module) already */
 	for (i = 0; i < env->used_btf_cnt; i++)
 		if (env->used_btfs[i].btf == btf)
-			return i;
+			goto ret_put;
 
 	if (env->used_btf_cnt >= MAX_USED_BTFS) {
 		verbose(env, "The total number of btfs per program has reached the limit of %u\n",
 			MAX_USED_BTFS);
-		return -E2BIG;
+		ret = -E2BIG;
+		goto ret_put;
 	}
 
-	btf_get(btf);
-
 	btf_mod = &env->used_btfs[env->used_btf_cnt];
 	btf_mod->btf = btf;
 	btf_mod->module = NULL;
@@ -21364,12 +21364,18 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 	if (btf_is_module(btf)) {
 		btf_mod->module = btf_try_get_module(btf);
 		if (!btf_mod->module) {
-			btf_put(btf);
-			return -ENXIO;
+			ret = -ENXIO;
+			goto ret_put;
 		}
 	}
 
-	return env->used_btf_cnt++;
+	env->used_btf_cnt++;
+	return 0;
+
+ret_put:
+	/* Either error or this BTF was already added */
+	btf_put(btf);
+	return ret;
 }
 
 /* replace pseudo btf_id with kernel symbol address */
@@ -21466,9 +21472,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 
 	btf_fd = insn[1].imm;
 	if (btf_fd) {
-		CLASS(fd, f)(btf_fd);
-
-		btf = __btf_get_by_fd(f);
+		btf = btf_get_by_fd(btf_fd);
 		if (IS_ERR(btf)) {
 			verbose(env, "invalid module BTF object FD specified.\n");
 			return -EINVAL;
@@ -21478,17 +21482,17 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
 			return -EINVAL;
 		}
+		btf_get(btf_vmlinux);
 		btf = btf_vmlinux;
 	}
 
 	err = __check_pseudo_btf_id(env, insn, aux, btf);
-	if (err)
+	if (err) {
+		btf_put(btf);
 		return err;
+	}
 
-	err = __add_used_btf(env, btf);
-	if (err < 0)
-		return err;
-	return 0;
+	return __add_used_btf(env, btf);
 }
 
 static bool is_tracing_prog_type(enum bpf_prog_type type)
@@ -25368,13 +25372,9 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
 		return 0;
 	}
 
-	btf = __btf_get_by_fd(f);
-	if (!IS_ERR(btf)) {
-		err = __add_used_btf(env, btf);
-		if (err < 0)
-			return err;
-		return 0;
-	}
+	btf = btf_get_by_fd(fd);
+	if (!IS_ERR(btf))
+		return __add_used_btf(env, btf);
 
 	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
 	return PTR_ERR(map);
-- 
2.34.1


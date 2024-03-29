Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADE4A0A
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732486; cv=none; b=Jc7qRjoRTm032iJKxmqqeWSN9XRVCW92ovG30PoPsD9Rbw0ps2VmLLv01Eoa3TDjkjmPn56qGBd+wbQuhd4ijNXCbZD+CEMmbrr7ImnL9Z87vmRsp0zCJnQMOAn6T8SFw3/KsX/E5cYmyaeLSXaxSl5NX4jCS+FEN8YTSxj8ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732486; c=relaxed/simple;
	bh=FbJmmho8aS1tCpEyevcIq9kn7YdARBhd5UvcyITm7l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WldSsYMPcU+bFBqeD7hNYsr6LqWTKEErGJwYqi7HWMB1esly9azSa/FaShx87LbT0ed1MvdI2Syqj620DRq2rAZMAdtTNvkiqZjTRXkKvaUw5o1RjGz/z2Wiy5po6VYh2CCmDIAv4BDE2VBUombQN/By4yHGu0/N9IK5zdn6Nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYBup71/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYBup71/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a074187a42so1658566a91.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711732484; x=1712337284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdrnkTzqTYuHtTy3rl1CuRgLOEs7uYSqUC/7tRjHz/I=;
        b=MYBup71/2hTt1QS+qN+iHXmm4QvTV5d9NSgAEdduaQBbyMD/mA/Fk8YXB1mJ99gbjA
         juYdKLHalInkkhB71sJwKscCoKks3X16y/YLSUUXkFwPBaJ2cHbhP6gTXoNtd1r2mQ7c
         c0RWWZaAaYugSHM4504wQ/WK5QKcnTHeaT9v2+LxlsiN2y45uTJJrYvPdN+NgLqC0vFN
         9z5AUF/xeUngx4jWTFS3CQC59I4jyNeclzPloBEI+2XCLc/BZ3E2oTSgqdITXectFeRF
         A4fSksX8w0K4VCvs/BIXFXpDELxXyBLDCqHH/pKGhqFTYPXxtLa8YBhN+fC03b2XEVyJ
         eKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732484; x=1712337284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdrnkTzqTYuHtTy3rl1CuRgLOEs7uYSqUC/7tRjHz/I=;
        b=Xp65O8M2kTLcV7Mq4/COEqNqgDznLBP/fkE2FX/bNk7g+mXR+/UgCm7+BDA8NQR1/3
         erreZwJr31O7JqUfK6qdnVfzWG37q0f3AGApg/UmB59iH+hRtclZy/iZRl0CVsm7aKWv
         NsqnBXaesIaxIm9kHg9GW+wjyxPlvxBODnl2eHjhBU8Vr2YgnWBY69gfeX4XLbU4sn8Y
         qC15KXnRQBA+E73yl5XNUv8ywvtWVtwszpUWOP4fFy6GcMX+4tCuTCmFS65gbG2ALO/n
         6y/IcWUxEKlX0CY1SzC1PnwvkodWFYbYj8NhX1EYSJnBz/a381nrIgz6habvKZveFJOh
         pyew==
X-Gm-Message-State: AOJu0Yzyb0qJsRBFJ0qurLlkRZZHnh2nkVNdGdPuL8DJp8rSNh5ZEhQW
	FrZcIOg/Wjo+fclyEtMxMO6QPhedffgeGxRkIMuM2oCk0r1MOgyw/AqpG2n0
X-Google-Smtp-Source: AGHT+IHVijqIbVMrlzThfFsp4hIvf+UkqH3Pd4qnNjytV/a5+RnEQPJjmK7zC0fg5JMTmhDsQU+VUg==
X-Received: by 2002:a17:90a:be05:b0:29f:f619:7c2f with SMTP id a5-20020a17090abe0500b0029ff6197c2fmr2488710pjs.27.1711732483740;
        Fri, 29 Mar 2024 10:14:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6946])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090aa61500b002a076b6cc69sm3209343pjq.23.2024.03.29.10.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 Mar 2024 10:14:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	paulmck@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.
Date: Fri, 29 Mar 2024 10:14:39 -0700
Message-Id: <20240329171439.37813-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

syzbot reported the following lock sequence:
cpu 2:
  grabs timer_base lock
    spins on bpf_lpm lock

cpu 1:
  grab rcu krcp lock
    spins on timer_base lock

cpu 0:
  grab bpf_lpm lock
    spins on rcu krcp lock

bpf_lpm lock can be the same.
timer_base lock can also be the same due to timer migration.
but rcu krcp lock is always per-cpu, so it cannot be the same lock.
Hence it's a false positive.
To avoid lockdep complain move kfree_rcu() after spin_unlock.

Reported-by: syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/lpm_trie.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 050fe1ebf0f7..d0febf07051e 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -308,6 +308,7 @@ static long trie_update_elem(struct bpf_map *map,
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
+	struct lpm_trie_node *free_node = NULL;
 	struct lpm_trie_node __rcu **slot;
 	struct bpf_lpm_trie_key_u8 *key = _key;
 	unsigned long irq_flags;
@@ -382,7 +383,7 @@ static long trie_update_elem(struct bpf_map *map,
 			trie->n_entries--;
 
 		rcu_assign_pointer(*slot, new_node);
-		kfree_rcu(node, rcu);
+		free_node = node;
 
 		goto out;
 	}
@@ -429,6 +430,7 @@ static long trie_update_elem(struct bpf_map *map,
 	}
 
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
@@ -437,6 +439,7 @@ static long trie_update_elem(struct bpf_map *map,
 static long trie_delete_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
+	struct lpm_trie_node *free_node = NULL, *free_parent = NULL;
 	struct bpf_lpm_trie_key_u8 *key = _key;
 	struct lpm_trie_node __rcu **trim, **trim2;
 	struct lpm_trie_node *node, *parent;
@@ -506,8 +509,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 		else
 			rcu_assign_pointer(
 				*trim2, rcu_access_pointer(parent->child[0]));
-		kfree_rcu(parent, rcu);
-		kfree_rcu(node, rcu);
+		free_parent = parent;
+		free_node = node;
 		goto out;
 	}
 
@@ -521,10 +524,12 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 		rcu_assign_pointer(*trim, rcu_access_pointer(node->child[1]));
 	else
 		RCU_INIT_POINTER(*trim, NULL);
-	kfree_rcu(node, rcu);
+	free_node = node;
 
 out:
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	kfree_rcu(free_parent, rcu);
+	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
-- 
2.43.0


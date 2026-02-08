Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A934678C
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770546287; cv=none; b=kcgYvDC4o4CQJOPM8mY0yh68rJVsrw5cq6q/nCAzdM+vNWvYgGZKGo4OKDHigkSLFuwHmluG2TefCzxrb5iE3Gs2b5Hg0wjNkpO8PtVxlRaqHOPJtClBMOgk8kf/6uFgwePLCYELR2uVRW7hY4GetFPhjmjuxgEYU4GJFG0j4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770546287; c=relaxed/simple;
	bh=cVdowyqu9FgfWukgr8FyguD0AAJpvR9htYI4O4gK1NA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1yjQKGAMs//tF4L06ltR+PPYeAek1n9fGyy27TpCsSMfLBIzB6LMu0E62XbTrYBagHqNxh9vDwSQi0BwrukjFUmxRhh4S94K3C+1E0CkqF2di7Yw8CDiypKhnYyFx7Sw7tUajxd16+X3RYxlmc8Kbl0bHMrA/gSObYf+j68iPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEUKoNJv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEUKoNJv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so54059185e9.0
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770546285; x=1771151085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyOmeZTBFI+Byh4RTWX4pgkdebEC59t+q2vB7MuEzPY=;
        b=bEUKoNJv9lVOLsWAwyDZQPZF532nEiu7aesGWvOJiRAKmNo15cdXaCrzA8+ptiT1Ei
         caI7y6eafBlbrttZITr+qeJmxvltnnomYGMB/txjdWXxmte/tWZ0DzVIJOeUpMLLoybB
         LcBpsF8p1wYNfsm9WKMe34s0mxDDCEohS43xOzh7PyBYYtvW/HBKcY2N4hFja2CFSQuU
         WfJTBOYLoqKXR8EvoWMHNExSeAhJtQ6Y582VBTcy4wFcijD2eOdplkO2b/Svt6ov+7/3
         xEcHnwNOBZWwPe0TrclyUSsB08xBIKCoA7/2PmUVQ/FAoSRVYvavtedFbiZyx26QGGc8
         cnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770546285; x=1771151085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyOmeZTBFI+Byh4RTWX4pgkdebEC59t+q2vB7MuEzPY=;
        b=umhuZYXHV5gJYoli9LcwBp1J6fb2TVWtAhhYWUqrqgqqyzaBO6ENncgIHKUs+KEgaP
         gIICNFN3nGaHoGcYjfFIXaMH4TXAXAXZDOGex3Bz6jR32qD3Ce8aTmuad0nN3BXh3Dge
         oJIw60HEpwP8pl+488b6Rjqx/DxeInsADP0u2eZAS0Y0ASUM1hwgaJAy0/YSDADXLayu
         WibNjW9Xa+1hBLFQ8IcuXXRleF9K8LVdBaMnyTeWBSQMab/uphbCMpcVUvURI4jHwbuO
         Yi1mh0wwax+k1eEsUaocbEC1A6jKY4FDLjDMN1cWhgZZ2kW81G0LDGHUhpI9+KSkYEdz
         7QAw==
X-Gm-Message-State: AOJu0YyHiRQ96ixbSo6CIfjS0jrx8ObZAnL6mPAwSAi14gbYyYO7ip8g
	8p2Dg7nS9iutZKoEjfuC7KYOR4Ev4Ngz3+iu3ai3W9NlHj8bNB3VSXiOspiiPQ==
X-Gm-Gg: AZuq6aLEjBdoR9SDIEzUR9h1cAh43XFQEFJNol5sjS6txlxyuUQkPnHPHii7ELyZzJ2
	R3J/JTBCpzPsoCpvEX+Bs76zp8UPtvS+nnYaZioL59NmmQ7FId4bM77uDnGh1q6KkFKXJXPCjaa
	vfN3E7kXq5o2jB1rX4xu/EfILHAYeqDZkfneNU6uyoddaRqHkXz836gUpnXikUNVat8YwDs1imA
	pEE6jgDwmHtqH8XYx0xmT1FpntQmE/yo4KEjAqsyuoYP6Vxd6prOhdf5ETI21pTufqKU/3urBUb
	+UDtltq84dYkbpFRUToXFic+rZvEJoqUyB57bp/VLcxJ8nxY7IdNX8qXkcyBnRyv/682DbftA5O
	aK89DcSRbGveKZKjbxNwSHOjKw04dAzEIeSSF0uxdyaCldpGew34u7ouNewj4PhJg7fL1RU0hZw
	j+jl11afuSXyJyMM0sHp/0wW3noJUN3A==
X-Received: by 2002:a05:600c:5290:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-4832020023cmr112292595e9.7.1770546285056;
        Sun, 08 Feb 2026 02:24:45 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm19883599f8f.13.2026.02.08.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 02:24:44 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Subject: [PATCH v1 bpf-next] bpf: Fix a potential use-after-free
Date: Sun,  8 Feb 2026 10:32:40 +0000
Message-Id: <20260208103240.6268-1-a.s.protopopov@gmail.com>
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

Reported-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a0f1995634f7c1dadbf
Fixes: 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..30a3f90e9aaf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21333,10 +21333,9 @@ static int find_btf_percpu_datasec(struct btf *btf)
 }
 
 /*
- * Add btf to the used_btfs array and return the index. (If the btf was
- * already added, then just return the index.) Upon successful insertion
- * increase btf refcnt, and, if present, also refcount the corresponding
- * kernel module.
+ * Add btf to the used_btfs array and return the index. If the btf was
+ * already added, then just return the index. If needed, refcount the
+ * corresponding kernel module.
  */
 static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 {
@@ -21354,8 +21353,6 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 		return -E2BIG;
 	}
 
-	btf_get(btf);
-
 	btf_mod = &env->used_btfs[env->used_btf_cnt];
 	btf_mod->btf = btf;
 	btf_mod->module = NULL;
@@ -21363,10 +21360,8 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 	/* if we reference variables from kernel module, bump its refcount */
 	if (btf_is_module(btf)) {
 		btf_mod->module = btf_try_get_module(btf);
-		if (!btf_mod->module) {
-			btf_put(btf);
+		if (!btf_mod->module)
 			return -ENXIO;
-		}
 	}
 
 	return env->used_btf_cnt++;
@@ -21466,9 +21461,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 
 	btf_fd = insn[1].imm;
 	if (btf_fd) {
-		CLASS(fd, f)(btf_fd);
-
-		btf = __btf_get_by_fd(f);
+		btf = btf_get_by_fd(btf_fd);
 		if (IS_ERR(btf)) {
 			verbose(env, "invalid module BTF object FD specified.\n");
 			return -EINVAL;
@@ -21478,17 +21471,23 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
 			return -EINVAL;
 		}
+		btf_get(btf_vmlinux);
 		btf = btf_vmlinux;
 	}
 
 	err = __check_pseudo_btf_id(env, insn, aux, btf);
 	if (err)
-		return err;
+		goto err_put;
 
 	err = __add_used_btf(env, btf);
 	if (err < 0)
-		return err;
+		goto err_put;
+
 	return 0;
+
+err_put:
+	btf_put(btf);
+	return err;
 }
 
 static bool is_tracing_prog_type(enum bpf_prog_type type)
@@ -25368,11 +25367,13 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
 		return 0;
 	}
 
-	btf = __btf_get_by_fd(f);
+	btf = btf_get_by_fd(fd);
 	if (!IS_ERR(btf)) {
 		err = __add_used_btf(env, btf);
-		if (err < 0)
+		if (err < 0) {
+			btf_put(btf);
 			return err;
+		}
 		return 0;
 	}
 
-- 
2.34.1


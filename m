Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711021D5B0
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640731; cv=none; b=OSxkkVxYX0VLS+OgUGrH/cRYfPonEoNm2TpwT5w4+wgXPHDskgNPJ4NyUHj0VEfHLRcjreNevewO6y5CCZ3cv3ggUj6sRnC/l6iPLgUggBmaXIBLWMzla7qDLiaPykF1SyqBoedEu2FV9+XWha/CiL0ezoxaauOE+QQGZI2+1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640731; c=relaxed/simple;
	bh=94yLNV359DBD54UB2kiP7L/Az+I51yI9zwJGn98E7Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjZEovr6MihoubvVnLjDuUsOZgShtq+0/H0FMplJmQ5+0G8NJsDMmx5SwyethDoEDy6fqw/yxXhuhRaRP4gVyu3+l/KMz44dDf2juFSI4VwDZjE1FVxp3OwmYxbDRkgdaw38EjjDnGYs4TyuK7FkhidUf0pHXlUQxvHTN9uyWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCKPlWtG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCKPlWtG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so869911f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 04:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770640729; x=1771245529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhBdLlCwMQ8rTB6XZX4P89InaMU86tmWTtPrYGApbYo=;
        b=HCKPlWtGqtt6RhyDk6voHnQNKPWH2FYjUgDpyXtLCwPbFEVmcmM25YfBhF7Q8AXFkP
         wimkpOEgNEBxp2ADpLzWLOa2tpRjka8pDVz/JdnrvS5Mohl7u1JSagDWucnT4VXzHFPy
         w2l52etA8drpsPkzB3B12iIKv/wK2edDt41nRThHkFL4GSXdzC9tyBz+BLrYp9/7/8ef
         3ShCkS3kg8a7fill1hX0mpKE7qd2Vt6JMOMifKPzz3zjSaTgnDltPuSqbKdej8KtXDcP
         sYUu5ieG/p+ukw0zybc0xOtgTC31m1aLRnaaXNfdNI/g5viOMQGcBxRpwZjz42W8Xzv4
         Nu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770640729; x=1771245529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhBdLlCwMQ8rTB6XZX4P89InaMU86tmWTtPrYGApbYo=;
        b=l3F2gIewdCtAvuZIhAunrgrxm1IEuxTp2/8LreRRrSYMw5xLmyEpuR3fd9WlBUpZDf
         9P7/QLV7UQ0IgLgn8kxFKPiWxz3Z7nnx1oNy6/uynYo4u9+Z2Ng0uAcFFJ0+23O1wk2m
         CwBYNL6RiqaHnJFg8wn0FdUYBBx2NHgTWQnvkLb8zAyNUf/fUrzbuBvROrNR+D7ADpf0
         jyxTJUPqePOMf8S/HGkS/kk8wFJrHxfrEOx6JD8oJwr1jLr7pWPCIRW5yQGYw5KRX7og
         cDJOoBO5w8nGGW/Xt2hwSz100toCq0NyyFAwX5ez6FNqpyZ5QeI/m93fOnQ0oCWJm/Is
         i4hw==
X-Gm-Message-State: AOJu0YwlhJStD8/kPCTrZ8+IOe5PD2xbvGQEFBu3OSJ4bwMkB8Dahhvh
	8UIEwmvmsVlLv5JmpHVFhILPRwXKl02ShDBUT1MTLVwMe9FshJJQ+6tNqnWK8Q==
X-Gm-Gg: AZuq6aJjXhcim75Z0TsWOQJiNKofWv7qebcQAz3fW2QYqoQnzQogLv6pplku/n0mFbl
	u/t5IPfDreVS1xlp3buq7/HhrK3Cev4+dtR4zDi8hc1UsIWL3l/K7wnWXvZLgurGaCb8FqBAn2A
	q7Nml+2PDs+n8oIQAyo7OkA+NPjuzrozh38kvYWzAmXjBv8iMcXso9VL2vqp/zE34doUfB1by8C
	l5NGtia2Yl5bhOP2QjHBGo1ZEApBkuzRQK+IIbV+Ne/GFLqlyTeaZm7KlL5LWo8FK5E0PeP6UVr
	3l6IQWEsukuG8VWZXpLmNnKvVwYcXRYZ8N4LtTFATXXDtfWSe3qRp9zHVEQWk7zVykQcuKUsAfo
	DvyhzYLXlAFQ3VwVHfr3dK2HiXN2gyjoLgVIU37VlPhaF7P0+pmzI1fAZCA0RfyNX9PSbLtBI0W
	+7C/tnn/guKJ7YxtG7RT/efsk85CmUww==
X-Received: by 2002:adf:edc3:0:b0:437:6f0c:2ed with SMTP id ffacd0b85a97d-4376f0c04femr3625733f8f.34.1770640729217;
        Mon, 09 Feb 2026 04:38:49 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974b230sm29146970f8f.36.2026.02.09.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 04:38:48 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Subject: [PATCH v2 bpf-next] bpf: Fix a potential use-after-free
Date: Mon,  9 Feb 2026 12:46:53 +0000
Message-Id: <20260209124653.56103-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/verifier.c | 51 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..24de90357450 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21333,29 +21333,28 @@ static int find_btf_percpu_datasec(struct btf *btf)
 }
 
 /*
- * Add btf to the used_btfs array and return the index. (If the btf was
- * already added, then just return the index.) Upon successful insertion
- * increase btf refcnt, and, if present, also refcount the corresponding
- * kernel module.
+ * Add btf to the used_btfs array and return the index. If needed, refcount the
+ * corresponding kernel module. To simplify caller's error checking in case of
+ * error or if btf was added before, decrease the btf refcount.
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
@@ -21364,12 +21363,18 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
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
@@ -21466,9 +21471,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 
 	btf_fd = insn[1].imm;
 	if (btf_fd) {
-		CLASS(fd, f)(btf_fd);
-
-		btf = __btf_get_by_fd(f);
+		btf = btf_get_by_fd(btf_fd);
 		if (IS_ERR(btf)) {
 			verbose(env, "invalid module BTF object FD specified.\n");
 			return -EINVAL;
@@ -21478,17 +21481,17 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
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
@@ -25368,13 +25371,9 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
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


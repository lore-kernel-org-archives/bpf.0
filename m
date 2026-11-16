Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808651;
	b=HLrFHO/5p8yZH6uCIoBagNqRQR3ldt9hXktZ9Bqyq8PCv801ngmNs1GbCMdY1Hqa+TRk
	 mqn53hg/TIoIXMt+LiMugm2m9TDyBmwanP9aOHiesQbFQBbyJ4CFSsk7FuwgL4FGk4u69
	 BYUvsM45nOFKqkVCAWbUqEaQ76janguLCaEdq8zUAPO0IyiYHpyrZaE0wqLxsMdP5sGHa
	 8WsOZy0H0jJi2y6XNclfTVy0b83uLiW6gNAheSV01QpctM8ZwJgnB5Xq6l0/jO9ZTvMRn
	 XVvf63t3y/B1LfEXKSahW8j6QCPmOt8ZpiwdIsIUU3h5YH+cRn8wBKBI/y/Fz/eZZzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LEtoE8nteJfo7VF8of31hMHlZbOPHa3Prd2YK+vVVt8=;
	b=weeo0MN32LF7nNpj55un5Yr4Opj/adBeWQbWEvXjiiAb8xF5l+JZf3dSNTDOC77yP1Iw
	 YEWGBxEW8XRBNfmS5EBQWS4kYk8nZWn0FKF4EVyC/458zdLvnuIrPdLuqr1eWD87tNksx
	 hHkg9Ysz/t55h6q1W1+2lhzp5g4GWCQ+RLPXx5O3gUIe25sVjMp6Cbrt/YlNDdYB6MueJ
	 kfVIi7X/jkG1FlFVq+EN/7f9nuJVu5CxXJOjJ/jK6ieEqurKQqWq1HyS6k0l9t4aDP32B
	 fu0QTy3gm1dD6yNBnHWu5TsP1ewnWzqvqHVzdghp00rsM3LdfA56g2b7MIYPJ5YTChQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fke7Iavs;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85C606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F85C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fke7Iavs
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so30565765ad.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808650; x=1795413450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEtoE8nteJfo7VF8of31hMHlZbOPHa3Prd2YK+vVVt8=;
        b=fke7Iavszx89Wi+wqeLUUOoousQMTcNBibn6xdv8v8P0tVbqv4i5mM9coqiBFrtTvW
         A+GAQl/sbhk3hgjIKEoYmj52tADS0SQuNGOwwqPVHjQnxGqp80DtUuhG56RSP7nX5Dni
         8OVRt4gY6nD9fJWRq6KrUxWzwMPIJk3aSZ2WlgPyzqTcqqMSvjvEoWLUMaHcuCtunGOR
         GDc4An7u52cHGVx+WuQQOI5KR3FQCB/zvwMS+kLlIQBeAfSP0w9yO6LWVFqrfnBx/bAA
         wikbrxGVdHAXkn4CW7Wp54W9TNw1BwuKjPzrp4adssX8iT+l3jVMiHQetSvOMoXQsvaY
         jc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808650; x=1795413450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEtoE8nteJfo7VF8of31hMHlZbOPHa3Prd2YK+vVVt8=;
        b=m4lnths74wvm8WOTOsC0MhLI9VpjjsnavLdvkBXV7ZRFXk+j+xS03thKx9xIobqVRM
         r948YvM0dWWbw+Cr+jJ1ZIyCEnis6ndZ6JAl4Ep4QCgmldOjie5Mhjh4QLnTcxW8e8YM
         Jr6T6z1hbP05ZVuIcvxkcAAwjdy0hAI5P/FTQWKrKLrSw+0KGBIvCXk8t9OBBiBITcXS
         UvaxnfmBh+jtUasngk+rw5uXgnGJesHmJsWPVIny2zf2hOZBS8Of05Ez6eVEGoLn4wcs
         64eRTqgOPQ9Mt9G1i9lzt7C0gfBA1rgoTUU+J2C2KUsx4bDisXpjGQkd1MMlJwIc+pMQ
         sYCQ==
X-Gm-Message-State: APuU4Z+1KQJ8FIJ/pbxTVkrjfcgoGHKivR77MXFp/0FwwYbMGg1pJTEC
	Rkd2+O/+NL0QMkqqiJKXB5dlm40Xkx5h43YjBTlYiuEhDB8AvVmEI7HmAwSpIg==
X-Gm-Gg: AYBFou1VEbScQolTMwxX+SeIe6wryr+lXXfFVL5MgCrDI2n8azRLJ9FWqKkKnYTdHua
	/3SRVXubgvnfK/vo61M9R9/t/haGXQMijjrHIrKSBZvFI1UJWI95elfZ0Njy2oOVEZGeazKFQAB
	OtaFQHYuvRXYFtM9u/a2ZXVQASTE6HCkRxGvK57JAgbbE/AIlv16AHLmyjZuNFQQLBR70nNC/1p
	lBz9lShRAzszYQi3Igv/YcuoHmIcmsCG6hwNTnh9mDBXJlBPzDM/x6DuF8K8p3zwOAgsF5jRYV1
	O4Wr63d+m9SetFyKriWEW2C/n739SwSa3VSlM5wuC7iBRfe3iCTcqM/4j6RJT/42T3OJ4G5ARRF
	zsf2ibgNmOc6lthmpfmhLhr+jOZO/emMGXt9doVyEvIgWqIt3rNbfFu8ojR6kIZqTCa+oCPHmC+
	89Aad8+/b42BFsCWc3R3+auxuK4WH3MSepFXEpCH6piYqQsfngMT7Ozllee7KXTRiqJGxiWcadn
	sSbREs9xR5UDZzJr2YbVpm9PZ7bTSfQ3wSUxxnPQCzY0R9Yrkh82ThZ74ZLNa9sUpBAMqsUkOGX
	qpKG3QdInaICiUTeDpw4uZHHu7CkBoR0qTDm6kW3igUec6qBApd+HP6Q731Tbm0uynLd0E4tXEg
	N7jVuDn04gzNVV+7P9nkVm2VWph7mTI9xFYEawz6pgsQ4PFhKwM9XRU6mRqxLgffkA093N5rdBQ
	==
X-Received: by 2002:a17:903:32ca:b0:2dd:ad73:5b6f with SMTP id d9443c01a7336-2ee0dcd0ac7mr90572795ad.31.1794808650215;
        Sun, 15 Nov 2026 21:57:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e48e2sm32243515ad.36.2026.11.15.21.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 08/21] bpf: Do not scan all maps for each insn and each subprog
Date: Mon, 16 Nov 2026 05:56:25 +0000
Message-ID: <20261116055638.4171529-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The number of maps has no limit now.

 - The dump of a program looks for the map of each ld_imm64. Put the
   addresses of the maps into a tree.
 - The JIT of each subprog needs the insn arrays only.
 - The jump table of a subprog doubles.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cfg.c     |  3 ++-
 kernel/bpf/fixups.c  |  4 +--
 kernel/bpf/syscall.c | 64 +++++++++++++++++++++-----------------------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index c16b4a283dbc..92dc8d0dc22a 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -366,13 +366,14 @@ static int __compute_subprog_jts(struct bpf_verifier_env *env)
 		}
 
 		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
-		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
+		jt = bpf_iarray_realloc(subprog->jt, roundup_pow_of_two(old_cnt + jt_cur->cnt));
 		if (!jt) {
 			subprog->jt = NULL;
 			kvfree(jt_cur);
 			return -ENOMEM;
 		}
 		memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
+		jt->cnt = old_cnt + jt_cur->cnt;
 		subprog->jt = jt;
 
 		kvfree(jt_cur);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d1eecb95545f..20697eba9c5f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1950,8 +1950,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->arena_stack_size = prog->aux->arena_stack_size;
 		func[i]->aux->arena_stack_entry = env->subprog_info[i].arena_stack_entry;
 		func[i]->aux->uses_arena_insns = bpf_prog_has_arena_insns(func[i]);
-		func[i]->aux->used_maps = env->used_maps;
-		func[i]->aux->used_map_cnt = env->used_map_cnt;
+		func[i]->aux->used_maps = env->insn_array_maps;
+		func[i]->aux->used_map_cnt = env->insn_array_map_cnt;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 67878c6b0cc0..ad24973413f4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
 #include <linux/vmalloc.h>
+#include <linux/maple_tree.h>
 #include <linux/mmzone.h>
 #include <linux/anon_inodes.h>
 #include <linux/fdtable.h>
@@ -5015,32 +5016,23 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	return fd;
 }
 
-static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
-					      unsigned long addr, u32 *off,
-					      u32 *type)
+/* address of a map, addresses of its value -> map */
+static int bpf_prog_map_addrs(const struct bpf_prog *prog, struct maple_tree *mt)
 {
-	const struct bpf_map *map;
-	int i;
+	struct bpf_map *map;
+	int i, err = 0;
+	u64 addr;
 
-	mutex_lock(&prog->aux->used_maps_mutex);
-	for (i = 0, *off = 0; i < prog->aux->used_map_cnt; i++) {
+	guard(mutex)(&prog->aux->used_maps_mutex);
+	for (i = 0; i < prog->aux->used_map_cnt && !err; i++) {
 		map = prog->aux->used_maps[i];
-		if (map == (void *)addr) {
-			*type = BPF_PSEUDO_MAP_FD;
-			goto out;
-		}
-		if (!map->ops->map_direct_value_meta)
-			continue;
-		if (!map->ops->map_direct_value_meta(map, addr, off)) {
-			*type = BPF_PSEUDO_MAP_VALUE;
-			goto out;
-		}
+		err = mtree_store(mt, (unsigned long)map, map, GFP_USER);
+		if (!err && map->ops->map_direct_value_meta &&
+		    !map->ops->map_direct_value_addr(map, &addr, 0))
+			err = mtree_store_range(mt, addr, addr + map->value_size - 1, map,
+						GFP_USER);
 	}
-	map = NULL;
-
-out:
-	mutex_unlock(&prog->aux->used_maps_mutex);
-	return map;
+	return err;
 }
 
 static void prepare_dump_pseudo_call(struct bpf_insn *insn)
@@ -5069,16 +5061,19 @@ static void prepare_dump_pseudo_call(struct bpf_insn *insn)
 static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 					      const struct cred *f_cred)
 {
+	struct bpf_insn *insns = NULL;
 	const struct bpf_map *map;
-	struct bpf_insn *insns;
-	u32 off, type;
+	struct maple_tree maps;
+	u32 off;
 	u64 imm;
 	u8 code;
 	int i;
 
-	insns = kvmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN);
+	mt_init(&maps);
+	if (!bpf_prog_map_addrs(prog, &maps))
+		insns = kvmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN);
 	if (!insns)
-		return insns;
+		goto out;
 
 	for (i = 0; i < prog->len; i++) {
 		code = insns[i].code;
@@ -5120,15 +5115,18 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 			continue;
 
 		imm = ((u64)insns[i + 1].imm << 32) | (u32)insns[i].imm;
-		map = bpf_map_from_imm(prog, imm, &off, &type);
-		if (map) {
-			insns[i].src_reg = type;
-			insns[i].imm = map->id;
-			insns[i + 1].imm = off;
+		map = mtree_load(&maps, imm);
+		if (!map || imm > ULONG_MAX)
 			continue;
-		}
+		off = 0;
+		insns[i].src_reg = BPF_PSEUDO_MAP_FD;
+		if (imm != (unsigned long)map && !map->ops->map_direct_value_meta(map, imm, &off))
+			insns[i].src_reg = BPF_PSEUDO_MAP_VALUE;
+		insns[i].imm = map->id;
+		insns[i + 1].imm = off;
 	}
-
+out:
+	mtree_destroy(&maps);
 	return insns;
 }
 
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842841;
	b=g9EODyX4N2u2cWbiDj3Zl7RVRDBA4C7URByPN/s5FvunY2iQcc2p/6EAgIR1hrvIMxN3
	 +rfF6R0buJha1wY1NQIohCkzLSZpgsxhVdmp5NLLmbdTgbf3lt6X7fvgmoSgWEWayw02B
	 5Y8C6wrhSYt+CfOLUZq8NzogwsFKoPAjHd809HPJfdi2moQ7fURzVDBHQlK196nSex7bP
	 giCTPCAmKqA3t1V61UCrxD+vqPn63BhEyqjFox3ak01+QBjb3y0QWOgOA/Ikuimb2/jOg
	 J40HhV5LaQeVUQlN6qAyt1QnVKsH5CVFj9IN8FJuBFvg0Vd+O+Dm3PgGpMLkmmio+AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GBCJVYHsrMsuqqOVQlI1VYUho0rw9gOyNAJ6QjGity8=;
	b=R8dDe8d4BToFHvzXOjUTTl5W73LWcRPbzvA/ApuXCaFE+UVU1kjy3YVvMsIpUrcDqsZP
	 G3TfmClaVUumeqWkwo4MbcBshIxGgpCPofrHJIpH4W24HXBhhPi2rJVHk5a7PFQAh5sW2
	 5a7oWrKYOU4Y80kB3f9+IDJ2UcJJ2OTql8NqrhgDV1CiLKImmLUkNZKfNmiPg8aQ6rd+m
	 bDiPQM93oiZJxPPQn21dBal7Mwytj0bf6HVoe0z1/mpxKyZjFrxvIDUZNwET/PXdaAAYA
	 1Fsw6tTobna5PBETon2Zkyr76fEmE1vZuE+wZiPwU24Smv/K/SKyITLviRtx8E/K+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ArbEfxMb;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B0606A32A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469B0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ArbEfxMb
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed408b0d9dso13113615ad.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842840; x=1795447640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBCJVYHsrMsuqqOVQlI1VYUho0rw9gOyNAJ6QjGity8=;
        b=ArbEfxMb67grhyHm0XKpaq+kFqVU9UNR4L7CWstDzgFIOaN+vY6bQ1b30es6fc42yr
         ekGxyb76GdMwZhy6lJhejU2GHOEmp5D/UcHTt2sykfZ3+N6eVw4SQMkwXddQSy0SE+o1
         XmbE7ywKJR0cp3vqgTSYW7GZvIKiSs2onnXmBeDNaM5Q+06izce6zAEm7+olghggsK5o
         zX0Q9DSTEvQ4Gv/TN/uYN28nJs0kZxcO0alJq1qjzba3ZXxch9n/ihOWfI1CAzKj1tp6
         6BqwO0nXXXZqvqzA9qFnWTxy5ulGO37UP6Sh/cqgWhm4EQfdK4lf9cuhRDapVW1q0obG
         c7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842840; x=1795447640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBCJVYHsrMsuqqOVQlI1VYUho0rw9gOyNAJ6QjGity8=;
        b=zEKGdcLtWKyI5wfxF+lVtfas1zNU6F6ZZhovDV6s+u8ygusfbKUmIQhL/PXEF9blCt
         H260w+FRpjRJtiGu4KjobuAAz06QCqiWzo1s8XMby74iW27b4oNq5DDE6cAEnuBDFJp1
         rdjVLQAAcaobHanqR/aw7IgayLLcqqxV6ih3XEfDp6kHqxThT8f2loJajxm3BNwJvrnp
         HevKGsuYqGAZPLPzDk4S94CkFCJYg9/ySXZSvpTq9N9+jsL7uf9WYhEhjzDyG1wb5urs
         Ja8EpjHjJzQfEoxQ/LU5wFw1iVg6mhX04K3CXzJPYaSder1RR82ZPd/VITpmbrxRHmP5
         q/3Q==
X-Gm-Message-State: APuU4Z+7YT9w+l+Wg73SZl3m7IGjO0NV3sbqxegK4UmdmmYnj4vE25GD
	Tps503lcqOdDIKlFig/SSndgbv9Uox2kme7hx2c2v/74A67AXJAajPqTGZ/m9w==
X-Gm-Gg: AZFdTZfpQydqkAUHIyKfO+riydwdfwwb5pSthOCjCsmNjVmjqdPch1i+68Fq/SuDWHt
	r7QKNbI1Eh4meWvBCXgkICGk7XKuEPFI53kNOzrd2du4aut7wP32F17/A7a7Dud5m20a8MAXbmX
	CwM/d9wcLYgYcsGCDLWcaFLdsD8XEwqoQfbxOEA4d5InIaFluJicmqVb2AjJX8EVX9CbuPYQW12
	GY8j+8O0Mzeyc4afmqcFdTIfFBjE+5eNLeZnuLoOKbTWRZ4qvXR4OFU/C2gKeA249czhjqA0P6n
	5plKuEMNOEyu5yBzOB2o8GfWvdvNnyuE0qMhv5qPts8yco6Lz1oJgdYONipiBRZ8s03ud+Cry/m
	J+zmG2HtBoj6WwHuls1bs6b8NOb+8lywtEtuHt18VcD94Xhr+nP9iIx+YrYO4dtTAoZnFU14tIq
	1lj01RAAlOPT7qFyQywqlvg/SIbonpO9CweOAMXzORxL4FC8uDB0eb3VYdZPJLeC9ZgyEerAjVN
	x7+SulziqWyqP3J6xDiSj8C1CIX3Wrzd4KhIYZhl9eNoVC23OIOQ9JDtDSHul31Gf4qdg5Bbf+M
	/T+PNEV7ERjLCIflhAP3HbkhBTnFdQFf7nA3qHAqq5OrWRQYhWlDzdrvdWXJZtKA7Irv2sKfsLp
	bhSj4vJaSwy0hWl/Hbcl2PpPysXAAH8RpEHBJfElzwHbd7pHH7+EO+jWGE6XIdaUyA7T319Pu1g
	==
X-Received: by 2002:a17:903:4b47:b0:2ed:b7bc:d2a4 with SMTP id d9443c01a7336-2ee0e0b8ab4mr108426385ad.62.1794842840086;
        Mon, 16 Nov 2026 07:27:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd76d8315sm1132055ad.1.2026.11.16.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 08/21] bpf: Do not scan all maps for each insn and each subprog
Date: Mon, 16 Nov 2026 15:26:13 +0000
Message-ID: <20261116152626.4032587-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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
index 9b0268d6715d..82c9af39e342 100644
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


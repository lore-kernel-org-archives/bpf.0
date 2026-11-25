Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577437;
	b=O5oIaj2fn++HZppgNku0QpZKRzfcctxShloq21vvU2h0wc8kyuCpSmMlwULzIgsm1GVZ
	 LE8/ZcBiDufgoOATo0BnNOep15/cdG8o699PkBDVht5EXr+ovYCZnNH6Cl4olE2yQihIw
	 6Hnskd4Cubxa3n5m+XhlnO6vJFlMP3VcvKpeN74FKvu8sZdjs/9FoJ8EgauXUtn4T6FhT
	 6aPd5nQTLNvDqR0jA89GOm2RjpSPpErjZveaw8oXIGVM/8KssnTU8U4ZC7d5/Zo2rD/az
	 AKy9/Fq4zAzShIBQetQuPJZCwjCDAdyclw2AgzE5NmbYgHifnaOHI7aTzyUWd/wS4Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A7ptYyXeS64rDuh6zf7FsqnnO3bjT69b3YP1ylCDZ1M=;
	b=kgFTqVJaxM5Fex7uKwTHqvvaCIH5v9dpI99bfO5IH/zAm5Kn0jtLzNinPovxdu54vVTf
	 F388ZI+z+80e/lyUheHv+dK8X/3Mygr0+1G3Zv9QL37snXoSWA4ToB0gEeQ/G6LxpXVbZ
	 gUvZhqgLEoMsfWO0KZevsoIUSy3WdFan8seD2vdq/9wmffTMkSleWn/MHwbj18ZEX+beq
	 OzcT93v+69kuhmS1YYaDxorVmD9g4PkEJFDC3j5M2r1ZxOJ1M5l2g0dPxCFDoJQZSvwh5
	 Zmsd4iCqOTzVUl0vs6986zvGwPDYDShRY5ZLNWVR3b5fI6ZUSGs3nu8CR8o8tU6433A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dWy/00po";
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEB606A326
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DEB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWy/00po
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso2225315a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577436; x=1796182236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7ptYyXeS64rDuh6zf7FsqnnO3bjT69b3YP1ylCDZ1M=;
        b=dWy/00poIt9OvDaZwXNkPjgkxRYk/FnjmxDdxKADmBA1VT5Y2+C8ijdP5T1WnpOryn
         8+961PgoaJvTnZKj5alL2ubQ+V9nqQDef+p8UuYwC3jBQ1GSQrG5GpGEu21783ha9N1S
         /QU/2r84jx2HOCInI0C1bh/VIqiSm40hvuwgIlMqVJIJxYIBMdjTZ6pa8+G6wUCQ8eum
         YhDbKs67NMYRW2gY5/57mdDHQumq4u6rVnWt9gQO9BaornGj8EieyWIglap/xVL3yLq2
         2az/W3gr29XOogaliAs0aKgM0LoPJjzwJfmiHaFWrLMVYVk5EQ1LlSJilApNtAimk2kq
         lVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577436; x=1796182236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7ptYyXeS64rDuh6zf7FsqnnO3bjT69b3YP1ylCDZ1M=;
        b=U+BTdls2cd//dm/rJfBaZm9S/ChRc1TVMnKQRslI7F4viPQy0Dz1t/yu5K4fLBH4UR
         gChqBMhyflbyDZnc9RATn+t/+7Rub7dChzxNoN9AXV06CQQTnlP8mmf/IoaB+oN1h/pp
         +4xKt3CAHDEzNmwVtpfoz2qYWzybUt97YVACA9Vpn0ZLMd4peYdf637NOSCZ+ohBXP8i
         H0ieYTYBer2tqClwLnB9HuAe95VlRDU2HaV5WVjQeVEsYc6O48kY3trossOhY7anCeGb
         IYReE3f8/M0tZKi+1zHQm1kr4teFZWZZQYDef0FS1+j2LAJ6UWYFicCe/SoGz+jmcdb7
         kmCw==
X-Gm-Message-State: APuU4Z8Odlh8q5lMBK6p9FGk1EqEYscnZdXHMJkpqkXnTA6iH3nuvm+S
	sht0os/ZplYACvdNRgbxl3HxWFwCyHXVulUIFoTamunx6IL6cAN1cQXbNFUz9BXN
X-Gm-Gg: AZFdTZf3vVE/lzDKP3zOqt92dygomsV/iRXDJcUMP1ExWpVblzTopWsS9ivWutq+R7T
	7gxZmbLPMO0VaQrWb8UWL9e2TZcJSRHrLdHhe86HYJH5f1eRoWBCfSOCofNtTtMicq72S/M31I8
	WJ0zzD878BOJ1qPOuVkuspP3ppNJ7HCd+lcwpMTZTX5W5RxH02+nrUqMWRoPYnAIW1VEOQa+wvJ
	uLo7WfKlTFP5heI9Om/hGquHMvOmG7FchjfSNRyT51TStx9zWUMB4NoOUaYD0qwA9tzhxqOB56X
	hTjwrXcyiKzTZxxukrLCkOTzJMNqHhXaHUEtUeQVi4mHtvZt+hta6XHN4T2OWN7T7A9ykL0xCP4
	87yxeidWgV4sngwmMJUM/Q78z4w9X0rfLIPRcl72spblifGxAXdZmTphFUxtbpKmdZ05sWnZeFU
	+7W30ETX6sgy4Sf8dwccfumCNKevcqmQ5Zjnt4WN+Tfioz2a3GBWEgsQoRbPlynNPhBnOS1CKKE
	MFAYWGzCO53HDjyVq+xVnMoYF7cgN57VBZTCW0i6vzrYh56iNM9oLOBE42UtqW9ZA4ES/KCHoMJ
	zSyk72Czm+8iiXzBTqQNaDOYXkd3a8NhqB1kI2Tu8TRovqNsjMDwOeOWCLzpn5t7lVdFZ96rtoo
	+2TSENMUc0Oi93ZTUBRSexMKY6eyJc25AzmhNBYQT8GkbtosjOE7Jaz+CLGKrplX1FfR44ki2pA
	o=
X-Received: by 2002:a17:90b:268f:b0:3b3:afdc:2e5 with SMTP id 98e67ed59e1d1-3b41c9cf56bmr11842247a91.30.1795577435899;
        Tue, 24 Nov 2026 19:30:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm28441051a91.15.2026.11.24.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 09/47] bpf: Check that a program and a struct_ops map are for the same struct
Date: Wed, 25 Nov 2026 03:29:00 +0000
Message-ID: <20261125032938.670542-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

A map takes a program when the id of the struct and the index of the
member are the same. Ids of types are not unique among modules. Compare
BTF too.

BPF_PROG_ASSOC_STRUCT_OPS takes any struct_ops map, and the callers of
bpf_prog_get_assoc_struct_ops() take the result for their own struct.
Pass the struct_ops that the caller wants, return NULL for another one.
The callers are scx_prog_sched() of sched_ext and bpf_testmod, they
change with the prototype.

Fixes: f6be98d19985 ("bpf, net: switch to dynamic registration")
Fixes: b5709f6d26d6 ("bpf: Support associating BPF program with struct_ops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                                  | 6 ++++--
 kernel/bpf/bpf_struct_ops.c                          | 8 ++++++--
 kernel/sched/ext/internal.h                          | 5 ++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 6 ++++--
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5f2e386dc118..e98d26cf6ced 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2411,7 +2411,8 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 int bpf_struct_ops_link_create(union bpf_attr *attr);
 int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
-void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux,
+				    const struct bpf_struct_ops *st_ops);
 u32 bpf_struct_ops_id(const void *kdata);
 int bpf_struct_ops_for_each_prog(const void *kdata,
 				 int (*cb)(struct bpf_prog *prog, void *data),
@@ -2475,7 +2476,8 @@ static inline int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_ma
 static inline void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
 {
 }
-static inline void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+static inline void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux,
+						  const struct bpf_struct_ops *st_ops)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7c5cd6086e27..71235df99cc9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -845,6 +845,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		}
 
 		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
+		    prog->aux->attach_btf != st_map->btf ||
 		    prog->aux->attach_btf_id != st_ops_desc->type_id ||
 		    prog->expected_attach_type != i) {
 			bpf_prog_put(prog);
@@ -1591,13 +1592,14 @@ void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
  * Get a reference to the struct_ops struct (i.e., kdata) associated with a
  * program. Should only be called in BPF program context (e.g., in a kfunc).
  *
- * If the returned pointer is not NULL, it must points to a valid struct_ops.
+ * If the returned pointer is not NULL, it must points to a valid @st_ops.
  * The struct_ops map is not guaranteed to be initialized nor attached.
  * Kernel struct_ops implementers are responsible for tracking and checking
  * the state of the struct_ops if the use case requires an initialized or
  * attached struct_ops.
  */
-void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux,
+				    const struct bpf_struct_ops *st_ops)
 {
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *st_ops_assoc;
@@ -1607,6 +1609,8 @@ void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
 		return NULL;
 
 	st_map = (struct bpf_struct_ops_map *)st_ops_assoc;
+	if (st_map->st_ops_desc->st_ops != st_ops)
+		return NULL;
 
 	return &st_map->kvalue.data;
 }
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 58652370da5a..c0109ac98347 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2674,6 +2674,8 @@ static inline bool scx_task_on_sched(struct scx_sched *sch,
 	return rcu_access_pointer(p->scx.sched) == sch;
 }
 
+static struct bpf_struct_ops bpf_sched_ext_ops, bpf_sched_ext_ops_cid;
+
 /**
  * scx_prog_sched - Find scx_sched associated with a BPF prog
  * @aux: aux passed in from BPF to a kfunc
@@ -2687,7 +2689,8 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 	struct sched_ext_ops *ops;
 	struct scx_sched *sch, *root;
 
-	ops = bpf_prog_get_assoc_struct_ops(aux);
+	ops = bpf_prog_get_assoc_struct_ops(aux, &bpf_sched_ext_ops) ?:
+	      bpf_prog_get_assoc_struct_ops(aux, &bpf_sched_ext_ops_cid);
 	if (likely(ops)) {
 		sch = rcu_dereference_all(ops->priv);
 		if (sch && unlikely(READ_ONCE(sch->dead)))
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 76fbe64755ef..7c5255ac49a3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -2500,13 +2500,15 @@ int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 	return ret;
 }
 
+static struct bpf_struct_ops testmod_multi_st_ops;
+
 /* Call test_1() of the associated struct_ops map */
 int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, struct bpf_prog_aux *aux)
 {
 	struct bpf_testmod_multi_st_ops *st_ops;
 	int ret = -1;
 
-	st_ops = (struct bpf_testmod_multi_st_ops *)bpf_prog_get_assoc_struct_ops(aux);
+	st_ops = bpf_prog_get_assoc_struct_ops(aux, &testmod_multi_st_ops);
 	if (st_ops)
 		ret = st_ops->test_1(args);
 
@@ -2584,7 +2586,7 @@ static struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
 	.test_1 = bpf_testmod_multi_st_ops__test_1,
 };
 
-struct bpf_struct_ops testmod_multi_st_ops = {
+static struct bpf_struct_ops testmod_multi_st_ops = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
 	.init = multi_st_ops_init,
 	.init_member = multi_st_ops_init_member,
-- 
2.55.0


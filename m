Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577425;
	b=H51CpoP+NHn3Qfma8F8wwDIVcekI4Hik6fxdfxvq+i5wpMf4O1zzPWknofjOoHk5xdBa
	 yMuGOigqeCVAB2gR6H+9AqQtRE9EXi+qg5+YxbzRPPwrKXPlM7Jd56rXyvLt2JvOP5d6G
	 /MOMLAFnEJ28v0ZlnC/I3ITxO6VwUvNlPMN+gXOXl5aFhVocuIj8N80pp7nJRq0Q0BcU9
	 ov1pBK4ireV0MOca+bTfEpKrx96UNL0wfwThFkpz6IrMjLLzB2Qh/OrNuOMLzc5dwnXQI
	 e+oLaUxdTV9bv6BFJlbjcMKP7xD4MwHCGFvVw24OSK+V6F9C8/Jwn33em2H4ctpC2og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dQxmAA+NAZ7cgn795OCDXGTp9F2SjQ9Kxp82MaLRaI8=;
	b=5g3eQo+i8ScYxzrHBUTh3PrqyzQKcZeU2jL7J/noK9wFBSROf1XHu8O8OzrrZclgVQ0u
	 s517BWGBF2ykdURynl36vYNAr5vSe/30NKP6xIgfptgFCknJclzd+6YUHbNyfAM9D5VSr
	 nWVSN+GlL5ivSNPpJP/RSOZq9YP51t6Pi5pwdUZv2Iq0N2PtfRA97nuelch5vwFu/OTS1
	 VEv4kdwDKFohfStHdSETduwsbF7/QIYD+Ok63P6fbvcYfDUkHveFqH8zyTGzZe2rehKW5
	 yQ7NOdqkNSHmmQPDDKFmxKQyGjjhmEVSAtPD5ysCKK5xj/ZOEYd/ExVgiukOsGSztAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBj1OsVj;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCF606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BCF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBj1OsVj
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so3066380a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577424; x=1796182224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQxmAA+NAZ7cgn795OCDXGTp9F2SjQ9Kxp82MaLRaI8=;
        b=ZBj1OsVjzqIHvGyIrkWKeJtOFsqT3BBy6EmiXT/3jThWQzyc60fL+3Kx1CTYz8MVe2
         Z3suS02Q86op2s9uhaa1LsEEhSUGVvnEE6nY2pXu9fGqk7M414KXogOmMvPrKaNNQIU/
         STGAB1c8Jd58pgXNimr5zu3lSOg967c73EOM4NWUnQ36CH+4F8goQRR6rViL0pYtwg/h
         wywe/i1UdXvkLMMC2cYsPlN5IDuKGSyFo020z1nYepH+GQiYE6Sy1ZDJSeBql+0PtPo3
         0y18rR1ciqdQPAhnA5kwUjZHQauJ2np5N9r39H/CVGi/rl8VCOKVeR2aE3G0mq16gA0K
         N+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577424; x=1796182224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQxmAA+NAZ7cgn795OCDXGTp9F2SjQ9Kxp82MaLRaI8=;
        b=oBGbZOhr/SoV/oikKfX9yfLKEdA1aR0Pwrut558NeMGLygf/dygWv3JezHxB04LBmt
         eOzx5C/vDIiiXkWnmqSv3l1WTdElCA1qxJdc4ghClyIuaBs1Fiz0aE1lYZ/+7b9rRzOE
         T0qydbc2FgFtt18qbbC8jQWQO8D3E0Y3NNvZ5KrSZlnpaiUcFnONGCV//AgRKJFDhpoZ
         4RsWNf4+zLVVFIGnaLMsRJPfX6iDv8O86CpYvbbxnCxDQk8330Mtsl0a7wZWq3Pn8E8T
         GeEjQ93KKNPKz46EtONFtpEa+nkTYiPt01ZbusUJcN5c37tth1NJtnHb15T6U/SOJbuD
         WzjA==
X-Gm-Message-State: APuU4Z/eWI/9t3Nl0xT1EKFY8QlhxmnqaJCQ0G1MZs+ZR8nwCxclzN91
	5NpJLPTURHUO2I6Khfrmxv5UqEf8e8X5ze5HHH6Psx40v24fy8Lqq/seAbkjB0mR
X-Gm-Gg: AZFdTZeA0aWUzeMKAPvDsODZnko8KtZ/qe+CsNvXM+ueeRRY/MLoxJLfQtl4sBB/ouH
	oynfGd/nplfOFYewK/uRRGNm+3Cn0kq/QkWfWml4vM1gu5VPXTaTLTnHDUOHfdJKeGq+0aJbjLb
	yeeRjAqn2UJ93ut4JIP0+PrguDBVwSnnDo1mZ2G65bfe5l2hcMHsJp2JwGb4r+sbo6ZAEu5LVLA
	LBFBaxc5FPi8wraGq3Bxx6TgeMGBA8tl28aCl8M7xndPyhrR+nCLpKEMcWv5aplCHn3kZGmKBuX
	R0+xmF9042fxaJ6yr/ic398ISEBaP1ozqyMc5nWOgV+Vx6ZX6timbXV2x4vOjGeElBvpFg1dhcH
	cnKz2otm4ADQkdC9AmEI0InIJgFEw/TI5MQNXlP7QHs8IxgpmMkTC41Psbkx9DNDe+8K8Nfrq1J
	M4huL4wHpS0NDUYDuW0LDjXLOaFBGQAuHHx7It4xN1evmfbg2IOeD8ke9SQb5z12R2XKPrHHJZ8
	p1J28nm98B0GJG4ynOoL3BIjIEg12k6Kx1DI3seyoWeb0176Nd2v5zY/l8+AlaDLKaxMDvnGf8Y
	RDcRZ68/CswpD3qh3s04RuMPG/Ow6qo67bB+6lJSW7VsDyKZ8Dfjnmnr70FnOxZwt6jmYrjY6c9
	STPaaKPhVTMexlws2Dsh0rdHaBSNuCr6vXn3WxQkoE9ZLTSLSJZeFobUw4HmexcIWs8zEHHL2v1
	N3Fa6tojGAgCV9sOV+244=
X-Received: by 2002:a17:90b:3f43:b0:3ac:7406:b49 with SMTP id 98e67ed59e1d1-3b41c8e0512mr10836684a91.15.1795577423803;
        Tue, 24 Nov 2026 19:30:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm28001628a91.14.2026.11.24.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 07/47] bpf: Compare what a hook tells next to its prototype at tail calls
Date: Wed, 25 Nov 2026 03:28:58 +0000
Message-ID: <20261125032938.670542-8-alexei.starovoitov@gmail.com>
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

Hooks of one prototype differ in what the verifier assumes:

- struct_ops: two structs can have the same index and prototype of
  a member. Nullable and referenced arguments, filters of kfuncs and
  the prologue belong to the struct.
- tp_btf: which arguments can be NULL.
- LSM and iterators: what is trusted, helpers, kfuncs, return values.
- A tracer of a program: the context of the target.

Compare that. Tracepoints that agree, and tracers of kernel functions,
share a prog array as before. Two LSM hooks cannot.

Fixes: 28ead3eaabc1 ("bpf: Prevent tail call between progs attached to different hooks")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  3 +++
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 10 ++++++++++
 kernel/bpf/core.c    | 20 ++++++++++++++++++--
 kernel/bpf/syscall.c |  1 +
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a1c96ca14afd..5f2e386dc118 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -300,7 +300,9 @@ struct bpf_map_owner {
 	bool sleepable;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
+	const struct bpf_struct_ops *st_ops;
 	enum bpf_attach_type expected_attach_type;
+	u64 hook_key;
 };
 
 struct bpf_map {
@@ -1889,6 +1891,7 @@ struct bpf_prog_aux {
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
 	struct bpf_prog *dst_prog;
 	struct bpf_trampoline *dst_trampoline;
+	enum bpf_prog_type saved_dst_ctx_type;
 	enum bpf_prog_type saved_dst_prog_type;
 	enum bpf_attach_type saved_dst_attach_type;
 	bool verifier_zext; /* Zero extensions has been inserted by verifier. */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076f0e..7bb3cc973c1f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -159,6 +159,7 @@ struct btf_struct_metas {
 extern const struct file_operations btf_fops;
 
 const char *btf_get_name(const struct btf *btf);
+u64 btf_raw_tp_null_mask(const struct bpf_prog *prog);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7c83f3bdfcf1..d5e126dc5d3e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7449,6 +7449,16 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "amdtp_packet", 0x100 },
 };
 
+u64 btf_raw_tp_null_mask(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++)
+		if (!strcmp(prog->aux->attach_func_name, raw_tp_null_args[i].func))
+			return raw_tp_null_args[i].mask;
+	return btf_is_module(prog->aux->attach_btf) ? U64_MAX : 0;
+}
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 14b8ee05e506..06a0413da489 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2515,6 +2515,18 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 	return 0;
 }
 
+/* What the verifier took from the hook, next to its prototype */
+static u64 bpf_prog_hook_key(const struct bpf_prog *fp)
+{
+	if (IS_ENABLED(CONFIG_BPF_SYSCALL) && fp->aux->attach_btf_trace)
+		return btf_raw_tp_null_mask(fp);
+	if (fp->type == BPF_PROG_TYPE_TRACING && fp->expected_attach_type != BPF_TRACE_ITER)
+		return fp->aux->saved_dst_ctx_type;
+	if (fp->type == BPF_PROG_TYPE_TRACING || fp->type == BPF_PROG_TYPE_LSM)
+		return fp->aux->attach_btf_id;
+	return 0;
+}
+
 static bool __bpf_prog_map_compatible(struct bpf_map *map,
 				      const struct bpf_prog *fp)
 {
@@ -2522,8 +2534,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	struct bpf_prog_aux *aux = fp->aux;
 	enum bpf_cgroup_storage_type i;
+	u64 cookie, hook_key = bpf_prog_hook_key(fp);
 	bool ret = false;
-	u64 cookie;
 
 	if (fp->kprobe_override)
 		return ret;
@@ -2543,6 +2555,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->sleepable = fp->sleepable;
 		map->owner->expected_attach_type = attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
+		map->owner->st_ops = aux->st_ops;
+		map->owner->hook_key = hook_key;
 		for_each_cgroup_storage_type(i) {
 			map->owner->storage_cookie[i] =
 				aux->cgroup_storage[i] ?
@@ -2553,7 +2567,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		ret = map->owner->type  == prog_type &&
 		      map->owner->jited == fp->jited &&
 		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
-		      map->owner->sleepable == fp->sleepable;
+		      map->owner->sleepable == fp->sleepable &&
+		      map->owner->st_ops == aux->st_ops &&
+		      map->owner->hook_key == hook_key;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 		    map->owner->expected_attach_type != attach_type)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f2bc772e297..571eec4f0cf5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3091,6 +3091,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	if (dst_prog) {
+		prog->aux->saved_dst_ctx_type = resolve_prog_type(dst_prog);
 		prog->aux->saved_dst_prog_type = dst_prog->type;
 		prog->aux->saved_dst_attach_type = dst_prog->expected_attach_type;
 	}
-- 
2.55.0


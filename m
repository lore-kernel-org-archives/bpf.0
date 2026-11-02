Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650446;
	b=usOEbZ0GzhyXZt5R5u5ZTMoubEfeWRwHIO5KVHNLHFy5shXGsc0ILStyBi6NATG1kJR0
	 VjNofGo8IcTAT9MNqGLBHEld92sZ5+hDWEoKGRbflmLg78tRY95uPYHSm9w41gk5kaUlB
	 c3dRa10VVTQIV2lNg6A5z3wr0VUoxT2cPOIG6r49nEbZ5isRK3KqH9iuLlTN7TnNI958D
	 rGxUB1wbvDDD8RiYIkk++XGsOR/9CkWg2YDATNUVZd/9GpWE6YOg3Sync5rmXKkko1f50
	 s9xBf43AJFHMhj0RN4E1ckd1nDRTvbB6M80s888lJOdh7sq0hL6cUMwf3AOeKVK8pZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aG1zfF54TjAWIM+Fb11Hl4krYr3k+Q4kK3YH4SnRIgI=;
	b=G3f4MTZXRZzzfutzjQQJf2UfBz5QcpLjijm4SUFoYyBi0SZ0eVKegjhVFXrv2WHIY/fU
	 xhaPIuLj6NM8mNJ2XKzOjNyR5atvA19KzW52m8BtWqctcxr0Y9BNBjDJtxKFQKPn70MqM
	 ofH1dEYklstdn7GQepTRzFXuUQrKWKlKFT0L14xbGvG2ctRhdMITmskKT0XIB8OCVzUGP
	 M2fej2f5E6mbUbgY5C0mEchtFLvNLuL6zAdeSLbXIUmLJR8SVtRDzaR6T8pPRfQtwXvWB
	 oIzl8dBHIftaT30WK0JkENt8OercNuNPiZvIdAlCkay8LZ48rv2NhEWgpzE7S3C0tqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nWkqML0k;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57E606D80A
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B57E606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nWkqML0k
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e10a70540so1916009f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650445; x=1794255245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aG1zfF54TjAWIM+Fb11Hl4krYr3k+Q4kK3YH4SnRIgI=;
        b=nWkqML0kP77GotAyTokmOfWdGereQczxl3Xyx+YLroE0UPrg+89AJS343R9c3nuzUg
         B/OuEw/yIIZEW3ZJ6ABhz+EXbf4wZwDVbVQNssVWxHVmr116jyUiyImXTeHXwN0M6KW3
         07syxER3KRYS71APpQTt5HLVizXGi1YwXMiFCp604m02+nNBWaEj3JJMy+HIOVGzHB4A
         baeFdrB9SQPbptF5jTaE2mspWs9juyKYb5YlFii8o3cQpUBS0wbcILW0jJrNerCs3YRs
         bNFpwi2/3TKvqV8VegJ9ZCWc8GL/ijsTotr7bYnOwfbEHO7Qob498OdMZrGQWAtrx2n7
         5a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650445; x=1794255245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aG1zfF54TjAWIM+Fb11Hl4krYr3k+Q4kK3YH4SnRIgI=;
        b=X4Q7JWDfSk9PQ9NDJwKY6HN2qbGVfDuo7RLguW2zzchzup3nsdJotDZMm//Ptn1JHG
         pVdWvyQAkTA5wESSRD67WRuSqoYhPB9eWX+JwcIJkXSlZqfCJPXyoTc/DoglBxJvPEG2
         NP1j1KXVTHVDe38slLD5gNRmmxd8gGjf2dk5SBEhFjbXN8xpekyPgHM3W+FnNDRvNjm5
         U0eW/30EGi7AOrVrzaZ1/beYnaoWZT7MezDgFqYIz5MAg2NDakjypus8At71nhQTrxQ+
         2fCbFCq9AHngwC+iehzCDjqyUmmX8NAo/ZWntz/0UcAUrJ+PbQH8CXISaOFWnfPnmnsU
         pEng==
X-Gm-Message-State: APuU4Z/uSMsfmNEoJIFlREXo+IPBS+sXoxC8hSjeFy1146GIWw/5V5s0
	b2PwpbXbRH3NSLw8rrL0dC5Z8m9ZaTJm2AMlXCsFgLb7nB27vUde/ng9CHOZEAMHVPfmlw==
X-Gm-Gg: AYBFou1JeWd4s/kjjGoHR9v4lXB3gk9mjQJmDJ9qo/MT9RLI/AhuA3tbXAdizZJCJHZ
	+f4lqENN1kPU4LZMko4jSbJjHxrq9BBzKHgGxTq7ylahq8dqkUm+7HCUk5PNnzlQGsddATv+6ly
	hBPvh7GNjfdKeRqnSDIzjTk3CcVMyRriYkvlTifSouF7OzcuIWvp+Nu/SOphxh9ArLUBlIzP5lY
	NzMH6YZsL8eKkDa7Tt4fba90n8Bm9xHtcoFpGvWt5ejpwMHO7iR3Vz9+J1sTj7W2eFmvv9mS+hJ
	wlldJkj64yAwdSJd3cPyR9uAVz+0ekAGelMCIo7FLFu2XClF9I5VjLei6epVwwrnGDyIr6rlY5Z
	UXZO7PClEj7BR6lBpnRbYgOnVgAZoIvjCJSoHjhZqq4EvGH1Bs2VZhwJxnP/KmbfTYr6mXBZ1fO
	NeFnj66iNffOCJk1aF7HbunS0a0QH1NgHQ2Gy0TilpqWG4NOrc1/9uqDjHtX3/ltw3Ytl4c5fVn
	ATp2gMOWe3UC9FRx8yqdOKAyUMTdDDeBd0sJMc352wKLDV/jCn42lXwqGCS4LBKkVcMwQN/cA6Z
	TR+kWk3xlyguErfDFAiZJJnYNaEa8m3lOD60tVnjfbJ5jg5J9mzXyIL4XXMSkShVmUTRja9mlbo
	nfhgDr/EH0VPc7be3zB8u6Q==
X-Received: by 2002:a05:6000:29d3:b0:48c:4444:f0a2 with SMTP id ffacd0b85a97d-48e6e2c3395mr15418424f8f.7.1793650444644;
        Mon, 02 Nov 2026 12:14:04 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm21471805f8f.43.2026.11.02.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:14:04 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 3/5] libbpf: Emit BPF_LINK_CREATE calls in generated loaders
Date: Mon,  2 Nov 2026 20:13:54 +0000
Message-ID: <20261102201356.5798-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201356.5798-1-mahe.tardy@gmail.com>
References: <20261102201356.5798-1-mahe.tardy@gmail.com>
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

Introduce bpf_gen__link_create() which builds the attachment attributes
from the loaded program FD, emits the helper call then save the returned
link FD in its data buffer slot for context output or failure cleanup.

Generate the attachment instruction after program and map init and
before loader finalization. Keep a mapping from dense loaded-program
slots to context output slots so disabled programs do not shift the
returned program FDs relative to their link descriptors.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/bpf_gen_internal.h |  5 ++++
 tools/lib/bpf/gen_loader.c       | 24 +++++++++++++++--
 tools/lib/bpf/libbpf.c           | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index b601269abe45..1332094bfd4b 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -6,6 +6,8 @@
 #include "bpf.h"
 #include "libbpf_internal.h"

+#define MAX_USED_PROGS 32
+
 struct ksym_relo_desc {
 	const char *name;
 	int kind;
@@ -41,6 +43,7 @@ struct bpf_gen {
 	__u32 nr_maps;
 	int link_fds;
 	__u32 nr_link_slots;
+	int prog_output_idx[MAX_USED_PROGS];
 	int log_level;
 	int error;
 	struct ksym_relo_desc *relos;
@@ -75,6 +78,8 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
 			struct bpf_prog_load_opts *load_attr, int prog_idx);
+void bpf_gen__link_create(struct bpf_gen *gen, int prog_idx, int link_idx,
+			  enum bpf_attach_type attach_type);
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size,
 			      __u64 flags);
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7f41b5a517fe..06d056a326f0 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -16,7 +16,6 @@
 #include "skel_internal.h"

 #define MAX_USED_MAPS	64
-#define MAX_USED_PROGS	32
 #define MAX_KFUNC_DESCS 256
 #define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)

@@ -412,7 +411,8 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 		move_stack2ctx(gen,
 			       sizeof(struct bpf_loader_ctx) +
 			       sizeof(struct bpf_map_desc) * gen->nr_maps +
-			       sizeof(struct bpf_prog_desc) * i +
+			       sizeof(struct bpf_prog_desc) *
+			       (gen->nr_link_slots ? gen->prog_output_idx[i] : i) +
 			       offsetof(struct bpf_prog_desc, prog_fd), 4,
 			       stack_off(prog_fd[i]));
 	for (i = 0; i < gen->nr_maps; i++)
@@ -1030,6 +1030,26 @@ static void info_blob_bswap(struct bpf_gen *gen, int func_info, int line_info,
 		bpf_core_relo_bswap(cr++);
 }

+void bpf_gen__link_create(struct bpf_gen *gen, int prog_idx, int link_idx,
+			  enum bpf_attach_type attach_type)
+{
+	int attr_size = offsetofend(union bpf_attr, link_create.flags);
+	union bpf_attr attr;
+	int link_create_attr;
+
+	memset(&attr, 0, attr_size);
+	attr.link_create.attach_type = tgt_endian(attach_type);
+	link_create_attr = add_data(gen, &attr, attr_size);
+	move_stack2blob(gen, attr_field(link_create_attr, link_create.prog_fd), 4,
+			stack_off(prog_fd[prog_idx]));
+	emit_sys_bpf(gen, BPF_LINK_CREATE, link_create_attr, attr_size);
+	debug_ret(gen, "link_create prog_idx %d attach_type %u", prog_idx, attach_type);
+	emit_check_err(gen);
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, gen->link_fds + link_idx * sizeof(int)));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, 0));
+}
+
 void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a7cbe7204043..32f041e999c5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9784,6 +9784,47 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 	return 0;
 }

+static bool bpf_program_supports_gen_attach(const struct bpf_program *prog)
+{
+	switch (prog->type) {
+	case BPF_PROG_TYPE_LSM:
+		return prog->expected_attach_type == BPF_LSM_MAC;
+	case BPF_PROG_TYPE_TRACING:
+		return prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		       prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		       prog->expected_attach_type == BPF_MODIFY_RETURN ||
+		       prog->expected_attach_type == BPF_TRACE_RAW_TP;
+	default:
+		return false;
+	}
+}
+
+static int bpf_object_gen_links(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+	int prog_idx = -1, link_idx = -1;
+
+	bpf_object__for_each_program(prog, obj) {
+		link_idx++;
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO)
+			continue;
+		prog_idx++;
+		obj->gen_loader->prog_output_idx[prog_idx] = link_idx;
+		if (!prog->autoattach)
+			continue;
+		if (!bpf_program_supports_gen_attach(prog)) {
+			pr_warn("prog '%s': loader attachment is not supported for section '%s'\n",
+				prog->name, prog->sec_name);
+			return -EOPNOTSUPP;
+		}
+		bpf_gen__link_create(obj->gen_loader, prog_idx, link_idx,
+				     prog->expected_attach_type);
+		if (obj->gen_loader->error)
+			return obj->gen_loader->error;
+	}
+	return 0;
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
 {
 	int err;
@@ -9843,6 +9884,9 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		/* reset FDs */
 		if (obj->btf)
 			btf__set_fd(obj->btf, -1);
+		if (!err && !obj->gen_loader->error &&
+		    OPTS_GET(obj->gen_loader->opts, gen_attach, false))
+			err = bpf_object_gen_links(obj);
 		if (!err)
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
--
2.43.0


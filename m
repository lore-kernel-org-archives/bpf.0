Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728777;
	b=TjR6uFk3szu9tbZUA3V6SiqD0QtQiXag3BJGJlUbPDIVa/oZt2qDzopaiRd0dW664DBE
	 4FiweNHxtggPeJ8xD3jZZOrdsC/bWm+Ly7EPQTzEjn29ttwmbz75TKcamAfyEI4MU7Unf
	 mjaVmqstCfTmdjWZwVe9PlWsi8LsW/MGNHivuL6sRAU9a3I3ebaOSlXu9YmM/NaupfVRH
	 85F0pME2ciTlh9k0GU2jwBhI84C5gjt2PaHAV73nbVuI+qQrQvwd4DUz9UQup+VpEQw9U
	 nS5PtZSe+OihKHsl9LXUJZCqWAqgCIFDxM8qgCbReuzdAwi/ykVfrio2GrQRsBva1aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=2TUqSI293fsyrQWudSmrDIdAlCbevrZ1mBB1b508g7w=;
	b=k0bIBevj5LI/aSo9mJ40gOkEEAXEW0oHDNLTUjj5Vu//vocFCC+gwjOJeZwVLL5Yk/Rd
	 L5+9GQYZGwDYq5Q1E+zeTjk0fSLpzo+3Rs+k1+pCSWdv8iwFvPl8rCpDScGlP1EcIizwM
	 7czwY5DTexea9HKTiRZ03C5h1r2uF8M2hxVK0FibVjFX/4WcJb3CeBJTWAog9IrZwWSzC
	 tQRwvxBBGFGJalhdgno0BZE1USijsQj9PM9Kcqj3FgwxRoKeVE/MV7rA6eQJXeCrv0tz5
	 hZ9mfkTZkcRq7F8ZV1y560z/vXXmbCey7GTmu6Kibmc2xlF3soAKdyT5UA4gwlpYavw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFvxFiEw;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584D606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1584D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFvxFiEw
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so1578649a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728775; x=1794333575; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TUqSI293fsyrQWudSmrDIdAlCbevrZ1mBB1b508g7w=;
        b=kFvxFiEwufdLvpOT39N2UeNLxtqJQW9lb1AdQsz7LvIlds6tjDPQtbsiYMc3dozVhv
         u9IZEEbKHO7ElWHXy3cNMM6pgDBNk9VDRFDgblG6vlmFSsLIUvO5QdpfGvtmQ9+TBfof
         pQKAoo17o8oC8O/Ejc8aAzFSkO5CwhojZ2S22jYvxKAN/ABnDS87eQq4AlJ3U8PGpM51
         Gp3nYRRd5ZjAGdRPXezrtIt0DklYXuiJAu2vlMu4cIIS25sibSkgHonScjBxVO/Pozzn
         5Pj/YTPHQdrQGvNEAmAz9icNnz/OeqSCe3K9Rglr34+tlbi8xcc12zVSxmG+avNvVKiC
         u5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728775; x=1794333575;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TUqSI293fsyrQWudSmrDIdAlCbevrZ1mBB1b508g7w=;
        b=spNp7ipNwCGX2tzfmgtj81000bD9TyL9jD2amcKs6JS1vpAO3OZlTEssZy6EjTamc8
         StNHnBIY2K5cUK5JgI1TEIY6b5H0CM3bOmMtn+8ugWM7KSl7vIuBXuLPYJk8p4ePObUk
         aXLgdkkabR/txrZr5MA/vrD4nG00Q8dNsrsdB09xhOYbe0k81HWgn4dI0Hfk4UIsSfvX
         G/9W31lmrAKGLR/KImPfCFXre9D/wZjsEdHJB0uglUaMwoj8xKVBZEqYCQw9Jp4zFs4S
         /RBL4RujNCstYxNfr9DSlBB3axBqVbFzHLK1JtIesnMvR8Z12oXX8RSzKDbJckRtmjXn
         lKFg==
X-Forwarded-Encrypted: i=1; AKwUvBz48azWMg8EKEqycdaEO6Z0berO/w6M4+SF3PwYQJ3vifnUqbolnYrWGFSfPi097t2Eo14=@vger.kernel.org
X-Gm-Message-State: APuU4Z+way9zrthDSr4Gf6O15K1LpvsTsQOMAZTJxUD6KhH2ffDF74Ve
	zP5TpxCWgMbrGMm+0c6+BexGVsOJ+hpbV7+kIauqfwj3et6Ep++7x3a5
X-Gm-Gg: AYBFou05GhjnM86tLmh+cahHm6wtfgXCL6/3xWQVAjFBuae0N9e8DI/jzvp3CpwxVuQ
	nyx/Pq9TxBFe56OenkDxcz5mDAgHHuCEwMydGpzzB8tOz7QNo1qbmpF+hqcRBCwR5W5aq6CI8kO
	V3UMhl5KJD3eXMDl5M2Q3s10xQFTmok1iN/tau2KJZzzlLAalbzoEnx7SNqhy6T3bEXEUycJ2j3
	VAdgPwmmDXJ0w5DQJpVUglmn3JElqpBoWkPmSQf3rdBtg6xxz2/QQ1ReyuNGiF3tFE/uV/Sjamh
	pXnxDkjdaNLEN/9GxF3MGUnZQ466AbmW4KnYCmy8QJGL27iYZoS/T1xLruQe2dL4lONsrNKRuSd
	65qgype2TCW5si+E/JCCYkSkuLPJkwe1mJ9NneswGuEPQsSL8XynnJGO84QP0jjV4tBXKomkcYL
	GxWSiCFeB6I0QvPUnUiqCKWashoDR/QcQPWtTeGJioy5ZOtUeAaQtUD5agPWXOlpqUN1ks0bFSb
	/q8zIN+ZMXZwW81icQe3/dIeRIOMmGSooVc2FWmYc1C8bxtg8J3oJQpaYUpD2JDfHwqgWemnHL2
	gJ3iCiYQtsHKhcr6iTCZjcrqJgzaABK9/VnIadg2c2Q06RHV/U8ypcnVp9oA7pGVMIXb9K38wX9
	rwthg2WVBEU08R93JO4r625S55IY3AyeloUg4yqkcIrg19cTUZTIhuq0=
X-Received: by 2002:a17:90b:3909:b0:3ac:a203:e095 with SMTP id 98e67ed59e1d1-3ae89536c23mr10766358a91.7.1793728775284;
        Tue, 03 Nov 2026 09:59:35 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09369c638sm136047a91.0.2026.11.03.09.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:59:34 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:59:34 +0000
Message-Id: <DMLRS6Y81EGP.2YS38LF0YFGL@gmail.com>
Cc: "Quentin Monnet" <qmo@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>,
 "Tianyi Chen" <hi@tychen.cc>, "Gyutae Bae" <gyutae.bae@navercorp.com>, "Hui
 Su" <sh_def@163.com>, "Josef Bacik" <josef@toxicpanda.com>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 3/5] libbpf: Emit BPF_LINK_CREATE calls in
 generated loaders
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261102201356.5798-4-mahe.tardy@gmail.com>
References: <20261102201356.5798-1-mahe.tardy@gmail.com> <20261102201356.5798-4-mahe.tardy@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 12:13 PM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> @@ -412,7 +411,8 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>  		move_stack2ctx(gen,
>  			       sizeof(struct bpf_loader_ctx) +
>  			       sizeof(struct bpf_map_desc) * gen->nr_maps +
> -			       sizeof(struct bpf_prog_desc) * i +
> +			       sizeof(struct bpf_prog_desc) *
> +			       (gen->nr_link_slots ? gen->prog_output_idx[i] : i) +

This is an existing bug. It's not specific to gen_attach.

> +		if (!bpf_program_supports_gen_attach(prog)) {
> +			pr_warn("prog '%s': loader attachment is not supported for section '%s'\n",
> +				prog->name, prog->sec_name);
> +			return -EOPNOTSUPP;
> +		}

bpf_object__attach_skeleton(), __attach() of lskel and
"bpftool prog load ... autoattach" skip the progs they cannot attach.
Here one SEC("syscall") or SEC("iter/...") prog fails the generation.
bpftool gen skeleton has no way to clear autoattach.
Let's skip such progs here too ?

Also fsession is not in the list.
It goes through bpf_tracing_prog_attach() like fentry.

> +		bpf_gen__link_create(obj->gen_loader, prog_idx, link_idx,
> +				     prog->expected_attach_type);

I think it can be implemented a bit simpler.

Keep link_fd next to prog_fd in struct loader_stack.
The cleanup loop in bpf_gen__init() closes both.
It costs 3 more insns per prog in the cleanup code.
Then no need for link_fds, nr_link_slots, link_idx,
struct bpf_link_desc and patch 1.

In the skeleton __attach() skips the progs that have a link,
like bpf_object__attach_skeleton() does.
It attaches the rest from user space as before.
Then no need for the bool in codegen_attach_detach().
Attach after detach works too. fentry_test.c does that.

The diff replaces patches 1-4 and has the fix for the shift.
Doc and bash completion are missing.
Something like this (not even compile tested):

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
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
@@ -39,6 +41,8 @@ struct bpf_gen {
 	ssize_t cleanup_label;
 	__u32 nr_progs;
 	__u32 nr_maps;
+	/* slot of every loaded prog in progs and links of the loader ctx */
+	int prog_ctx_idx[MAX_USED_PROGS];
 	int log_level;
 	int error;
 	struct ksym_relo_desc *relos;
@@ -73,6 +77,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
 			struct bpf_prog_load_opts *load_attr, int prog_idx);
+void bpf_gen__link_create(struct bpf_gen *gen, int loaded_idx, enum bpf_attach_type attach_type);
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size,
 			      __u64 flags);
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -16,7 +16,6 @@
 #include "skel_internal.h"
 
 #define MAX_USED_MAPS	64
-#define MAX_USED_PROGS	32
 #define MAX_KFUNC_DESCS 256
 #define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)
 
@@ -34,7 +33,10 @@
 struct loader_stack {
 	__u32 btf_fd;
 	__u32 inner_map_fd;
-	__u32 prog_fd[MAX_USED_PROGS];
+	struct {
+		__u32 prog_fd;
+		__u32 link_fd;
+	} progs[MAX_USED_PROGS];
 };
 
 #define stack_off(field) \
@@ -142,7 +144,7 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* nr_progs includes subprogs and progs that are not loaded */
 	nr_progs = min(nr_progs, MAX_USED_PROGS);
 	/* amount of stack actually used, only used to calculate iterations, not stack offset */
-	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs]);
+	nr_progs_sz = offsetof(struct loader_stack, progs[nr_progs]);
 	/* jump over cleanup code */
 	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
 			      /* size of cleanup code below (including map fd cleanup) */
@@ -400,13 +402,23 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 	/* programs hold their maps with pointers to functions, nothing else needs them */
 	for (i = 0; i < gen->nr_func_ptr_maps; i++)
 		emit_sys_close_blob(gen, blob_fd_array_off(gen, gen->nr_obj_maps + i));
-	for (i = 0; i < gen->nr_progs; i++)
+	for (i = 0; i < gen->nr_progs; i++) {
 		move_stack2ctx(gen,
 			       sizeof(struct bpf_loader_ctx) +
 			       sizeof(struct bpf_map_desc) * gen->nr_maps +
-			       sizeof(struct bpf_prog_desc) * i +
+			       sizeof(struct bpf_prog_desc) * gen->prog_ctx_idx[i] +
 			       offsetof(struct bpf_prog_desc, prog_fd), 4,
-			       stack_off(prog_fd[i]));
+			       stack_off(progs[i].prog_fd));
+		if (!OPTS_GET(gen->opts, gen_attach, false))
+			continue;
+		/* nr_progs link fds follow nr_progs bpf_prog_desc-s */
+		move_stack2ctx(gen,
+			       sizeof(struct bpf_loader_ctx) +
+			       sizeof(struct bpf_map_desc) * gen->nr_maps +
+			       sizeof(struct bpf_prog_desc) * nr_progs +
+			       sizeof(int) * gen->prog_ctx_idx[i], 4,
+			       stack_off(progs[i].link_fd));
+	}
 	for (i = 0; i < gen->nr_maps; i++)
 		move_blob2ctx(gen,
 			      sizeof(struct bpf_loader_ctx) +
@@ -1143,10 +1155,38 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	}
 	/* remember prog_fd in the stack, if successful */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
-			      stack_off(prog_fd[gen->nr_progs])));
+			      stack_off(progs[gen->nr_progs].prog_fd)));
+	gen->prog_ctx_idx[gen->nr_progs] = prog_idx;
 	gen->nr_progs++;
 }
 
+/* attach the prog that bpf_gen__prog_load() saw as number loaded_idx */
+void bpf_gen__link_create(struct bpf_gen *gen, int loaded_idx, enum bpf_attach_type attach_type)
+{
+	int attr_size = offsetofend(union bpf_attr, link_create.flags);
+	int link_create_attr;
+	union bpf_attr attr;
+
+	if (!OPTS_GET(gen->opts, gen_attach, false))
+		return;
+
+	memset(&attr, 0, attr_size);
+	attr.link_create.attach_type = tgt_endian(attach_type);
+	link_create_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: link_create: prog %d attach_type %u, attr: off %d size %d\n",
+		 loaded_idx, attach_type, link_create_attr, attr_size);
+	/* populate union bpf_attr with prog_fd saved in the stack earlier */
+	move_stack2blob(gen, attr_field(link_create_attr, link_create.prog_fd), 4,
+			stack_off(progs[loaded_idx].prog_fd));
+	/* emit LINK_CREATE command */
+	emit_sys_bpf(gen, BPF_LINK_CREATE, link_create_attr, attr_size);
+	debug_ret(gen, "link_create prog %d attach_type %d", loaded_idx, attach_type);
+	emit_check_err(gen);
+	/* remember link_fd in the stack, if successful */
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
+			      stack_off(progs[loaded_idx].link_fd)));
+}
+
 /*
  * if (map_desc[map_idx].initial_value) {
  *    if (ctx->flags & BPF_SKEL_KERNEL)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8593,9 +8593,14 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 	}
 
 	if (obj->gen_loader) {
+		int i, prog_idx = 0;
+
+		/* subprogs have no slot in the loader ctx */
+		for (i = 0; i < prog - obj->programs; i++)
+			if (!prog_is_subprog(obj, &obj->programs[i]))
+				prog_idx++;
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
-				   license, insns, insns_cnt, &load_attr,
-				   prog - obj->programs);
+				   license, insns, insns_cnt, &load_attr, prog_idx);
 		*prog_fd = -1;
 		return 0;
 	}
@@ -9784,6 +9789,40 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 	return 0;
 }
 
+/* The target is known since the load. BPF_LINK_CREATE needs prog_fd only. */
+static bool gen_loader_can_attach(const struct bpf_program *prog)
+{
+	switch (prog->type) {
+	case BPF_PROG_TYPE_LSM:
+		return prog->expected_attach_type == BPF_LSM_MAC;
+	case BPF_PROG_TYPE_TRACING:
+		return prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		       prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		       prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		       prog->expected_attach_type == BPF_MODIFY_RETURN ||
+		       prog->expected_attach_type == BPF_TRACE_RAW_TP;
+	default:
+		return false;
+	}
+}
+
+static int bpf_object_gen_finish(struct bpf_object *obj)
+{
+	int nr_progs = 0, nr_loaded = 0;
+	struct bpf_program *prog;
+
+	bpf_object__for_each_program(prog, obj) {
+		nr_progs++;
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO)
+			continue;
+		if (prog->autoattach && gen_loader_can_attach(prog))
+			bpf_gen__link_create(obj->gen_loader, nr_loaded,
+					     prog->expected_attach_type);
+		nr_loaded++;
+	}
+	return bpf_gen__finish(obj->gen_loader, nr_progs, obj->nr_maps);
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
 {
 	int err;
@@ -9841,7 +9880,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		if (obj->btf)
 			btf__set_fd(obj->btf, -1);
 		if (!err)
-			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
+			err = bpf_object_gen_finish(obj);
 	}
 
 	bpf_object_post_load_cleanup(obj, false);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1990,9 +1990,10 @@ struct gen_loader_opts {
 	__u32 data_sz;
 	__u32 insns_sz;
 	bool gen_hash;
+	bool gen_attach;
 };
 
-#define gen_loader_opts__last_field gen_hash
+#define gen_loader_opts__last_field gen_attach
 LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
 				      struct gen_loader_opts *opts);
 
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -621,7 +621,8 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 	bpf_object__for_each_program(prog, obj) {
 		codegen("\
 			\n\
-				ret = ret < 0 ? ret : %1$s__%2$s__attach(skel);   \n\
+				if (ret >= 0 && skel->links.%2$s_fd <= 0)	    \n\
+					ret = %1$s__%2$s__attach(skel);		    \n\
 			", obj_name, bpf_program__name(prog));
 	}
 
@@ -639,6 +640,7 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 		codegen("\
 			\n\
 				skel_closenz(skel->links.%1$s_fd);	    \n\
+				skel->links.%1$s_fd = 0;		    \n\
 			", bpf_program__name(prog));
 	}
 
@@ -691,7 +693,8 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		obj_name);
 }
 
-static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard)
+static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard,
+		     bool gen_attach)
 {
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_load_and_run_opts sopts = {};
@@ -702,6 +705,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	char ident[256];
 	int err = 0;
 
+	opts.gen_attach = gen_attach;
 	if (sign_progs)
 		opts.gen_hash = true;
 
@@ -740,7 +744,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			skel = (struct %1$s *)skel_alloc(sizeof(*skel));    \n\
 			if (!skel)					    \n\
 				goto cleanup;				    \n\
-			skel->ctx.sz = (char *)&skel->links - (char *)skel; \n\
+			skel->ctx.sz = (char *)(&skel->links + 1) - (char *)skel; \n\
 		",
 		obj_name, opts.data_sz);
 	bpf_object__for_each_map(map, obj) {
@@ -1249,6 +1253,7 @@ static int do_skeleton(int argc, char **argv)
 	struct bpf_map *map;
 	struct btf *btf;
 	struct stat st;
+	bool gen_attach = false;
 
 	if (!REQ_ARGS(1)) {
 		usage();
@@ -1257,10 +1262,9 @@ static int do_skeleton(int argc, char **argv)
 	file = GET_ARG();
 
 	while (argc) {
-		if (!REQ_ARGS(2))
-			return -1;
-
 		if (is_prefix(*argv, "name")) {
+			if (!REQ_ARGS(2))
+				return -1;
 			NEXT_ARG();
 
 			if (obj_name[0] != '\0') {
@@ -1270,6 +1274,8 @@ static int do_skeleton(int argc, char **argv)
 
 			strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
 			obj_name[MAX_OBJ_NAME_LEN - 1] = '\0';
+		} else if (is_prefix(*argv, "autoattach")) {
+			gen_attach = true;
 		} else {
 			p_err("unknown arg %s", *argv);
 			return -1;
@@ -1278,6 +1284,11 @@ static int do_skeleton(int argc, char **argv)
 		NEXT_ARG();
 	}
 
+	if (gen_attach && !use_loader) {
+		p_err("autoattach requires a light skeleton (-L)");
+		return -1;
+	}
+
 	if (argc) {
 		p_err("extra unknown arguments");
 		return -1;
@@ -1441,7 +1452,7 @@ static int do_skeleton(int argc, char **argv)
 			goto out;
 	}
 	if (use_loader) {
-		err = gen_trace(obj, obj_name, header_guard);
+		err = gen_trace(obj, obj_name, header_guard, gen_attach);
 		goto out;
 	}
 
@@ -2005,7 +2016,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
-		"       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
+		"       %1$s %2$s skeleton FILE [name OBJECT_NAME] [autoattach]\n"
 		"       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"
 		"       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
 		"       %1$s %2$s help\n"

pw-bot: cr

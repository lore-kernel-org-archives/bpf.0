Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996419;
	b=nW2Mz9AKzCBeVitmZ+stX8QmX20DOqO3yFnvGdT5X+KL4vhLFlikarFlWhd0RAvWhHir
	 vooMgDDxm2KrXeZHxVoi+X3jm3MM7+bg4RFuN1YaARoGPfmfHFNYesO7bB/qWQYWRvKVu
	 tckQacXSNn+kUG/yCj6+2H7vLc0Hclix0foHSE9+KxtJ7YsG0kqJSDTy/k2wbbvkmrQkx
	 C20F1II4A4YhKSjPI80pJ1ISy/G2gW9HXPhKMsh68YT+JRqf1FpMUHfX42EuIYfoXQ3/c
	 fomsbtEqWvLbh0QG14fHUXz93AhSbPI/SBaSZluBr/4Fl+co1TThqnE1u+6bNYr4AEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XvewwKO9ZZowV/2pm8Mo5VjBvQePCjGPnCvF9vdLwAA=;
	b=JirxEoFk57vt/K8PYHIT3Vt+c8Sgg6Ip7WHS1pFYhlXCRpTpwV38QhUf9ScsmWndADna
	 fP6/yf0goJvVsZR1w7DimHss8zlWr/bnhc3/a7iozBfHgFepuInGiUAZICtAyigJVKEBP
	 C5nj0RUwCpVVSJI7q+Ab2rRgVgLuCAmW6+1AVOiR57FKES9Pmv+Qxf1sHL7NkFW+Hx8sz
	 OCuJVc+yKTQXzthoYf2KAeAEw2k7E040Ti3fHDDj4eWbGqU3TfMLL6ucdX97HBUvKBhum
	 wyaFftxm/geXv1PFq5MnqI5AcThOq9BOjCqDKQxo0eaEnxBuVUPNDTGaarrt8f2JRDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PpL+wePa;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84916606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84916606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PpL+wePa
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b0a13ae043so1419336a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793996419; x=1794601219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvewwKO9ZZowV/2pm8Mo5VjBvQePCjGPnCvF9vdLwAA=;
        b=PpL+wePa/Xpr9zYKCeBqYVHtUiYhe4jAZUSrV8ZqMjJEw6CZxDAdV7gFQUHuQUp2RE
         r2TcQV6fF39O1TnkPwLWD4eDX61yOTq2GopdS2ip2qe1jd0EcvIa+Iuq0KBCbPCBGfRl
         hfKaLp80YonEXgeKALAfdnk0ctGVN2BBJs6VTpaEsW9kRnk5N776/XuF+nok3mbCQhWO
         yITqFhJRvULfIJkhYZj91ffA1Wo1+5nrCsx/9nSmrYwEFxViq0GWQLaqEmZqqu2d/PmT
         re9Ixv9BFoMJF/+UaxgyY+L53fNux1B8N/lHe9GYIa8BhWINmW4Wn5ECgqKKB+5HvIm+
         zL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996419; x=1794601219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvewwKO9ZZowV/2pm8Mo5VjBvQePCjGPnCvF9vdLwAA=;
        b=iNRFMLP529AP2ipIZSlV9x5BUAEua58HIlv7q6G7JMlQ3A7qptWc1ODD+07PeyhC/z
         oFvcRc00rKw7yI61CnGzmcnFxvS/TDFDauvkKgNwUu4JeaNdTIYf0QFeMwxhBt7NiUZe
         3ECGf4LTA7KW5Jb59ZbyYPS+ksJHsjKiuAp2cHhitPcHwjZZ5QWDyP9jen/e0Gm4hDry
         P9KZ0nnxEzp+RQ7yaCg5HjPYuGgV5t4MdmuTb92TGYzbZUekCFgrIeAmjIZtm7Qfg5j5
         pqdP89sIuUeYhCbSX3veGOQKkaEx8HrEyDtPjYVUhR7wlRIdcB15NlzjhP0nAzHykD9b
         nfBg==
X-Gm-Message-State: APuU4Z/tGAN0EwljdX/rixwxGY1HbxrAWju9G7KzDkuuJk2HHPGFH3Xu
	Cgx1cddl5/osILTRgHotcPH6RsHuZUQ71Wp9lMQ/TbHGcWYV606Z8PI5X0BQ5NRXwTSyD0KbDMT
	Py60+lYIhuTMI4KvyDg==
X-Received: from pgca2-n1.prod.google.com ([2002:a05:6a02:6382:10b0:cc7:a4ca:364])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2792:b0:3ac:8897:7b92 with SMTP id 98e67ed59e1d1-3b0db70d34fmr3358993a91.57.1793996418673;
 Fri, 06 Nov 2026 12:20:18 -0800 (PST)
Date: Fri, 06 Nov 2026 20:19:52 +0000
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261106-lskel-struct-ops-v1-5-a4486ffc79cb@google.com>
Subject: [PATCH RFC bpf-next 5/7] libbpf: Implement bpf_gen__struct_ops_update_elem()
 for light skeletons
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, "=?utf-8?q?Thi=C3=A9baud_Weksteen?=" <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

Add bpf_gen__struct_ops_update_elem() in gen_loader.c and call it from
bpf_object_prepare_struct_ops() when generating a light skeleton.

Once all programs are loaded, bpf_gen__struct_ops_update_elem():
1. Closes the attach_btf_obj_fd stored in the upper 32 bits of
   st_ops->type_id_off.
2. Copies each callback program's FD from the loader stack into
   st_ops->kern_vdata_off at the dynamic kernel member offset stored in
   st_ops->kern_func_off[i].
3. Emits BPF_MAP_UPDATE_ELEM to populate the struct_ops map with the
   prepared kern_vdata.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/bpf_gen_internal.h |  3 +++
 tools/lib/bpf/gen_loader.c       | 58 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           | 16 ++++++++---
 tools/lib/bpf/libbpf_internal.h  |  2 ++
 4 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index b424410e8839..cd603f82f6ec 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -88,5 +88,8 @@ void bpf_gen__init_kern_struct_ops(struct bpf_gen *gen, struct btf *btf,
 				   struct bpf_struct_ops *st_ops,
 				   __u32 *vtype_id_off,
 				   unsigned int *val_sz_off);
+void bpf_gen__struct_ops_update_elem(struct bpf_gen *gen, int map_idx,
+				     struct btf *btf,
+				     struct bpf_struct_ops *st_ops);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index aaa491463521..6dcba83dcc09 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1573,3 +1573,61 @@ void bpf_gen__init_kern_struct_ops(struct bpf_gen *gen, struct btf *btf,
 		}
 	}
 }
+
+void bpf_gen__struct_ops_update_elem(struct bpf_gen *gen, int map_idx,
+				     struct btf *btf,
+				     struct bpf_struct_ops *st_ops)
+{
+	int attr_size = offsetofend(union bpf_attr, flags);
+	const struct btf_type *type;
+	union bpf_attr attr;
+	int key, zero = 0;
+	__u32 i;
+
+	/* 1. Close attach_btf_obj_fd (upper 32 bits of st_ops->type_id_off) */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, st_ops->type_id_off));
+	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0));
+	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32));
+	__emit_sys_close(gen);
+
+	/* 2. Populate prog_fd into kern_vdata for all callback members */
+	type = btf__type_by_id(btf, st_ops->type_id);
+	for (i = 0; i < btf_vlen(type); i++) {
+		struct bpf_program *prog = st_ops->progs[i];
+		int prog_idx, off_slot;
+
+		if (!prog)
+			continue;
+
+		prog_idx = bpf_program_idx(prog);
+		off_slot = st_ops->kern_func_off[i];
+
+		/* R2 = dynamic kernel member offset from off_slot */
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, off_slot));
+		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0));
+		emit(gen, BPF_JMP_IMM(BPF_JLE, BPF_REG_2,
+				      KERN_VDATA_MAX_SIZE - sizeof(__u64), 2));
+		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -E2BIG));
+		emit_check_err(gen);
+
+		/* R1 = kern_vdata_off + offset */
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, st_ops->kern_vdata_off));
+		emit(gen, BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2));
+
+		/* R0 = prog_fd from stack (stack_off(prog_fd[prog_idx])) */
+		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10,
+				      stack_off(prog_fd[prog_idx])));
+
+		/* Store prog_fd (R0) into kern_vdata + offset (R1) */
+		emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0));
+	}
+
+	/* 3. Emit BPF_MAP_UPDATE_ELEM command for struct_ops map */
+	memset(&attr, 0, attr_size);
+	key = add_data(gen, &zero, sizeof(zero));
+	emit_map_update_elem(gen, map_idx, &attr, attr_size, key,
+			     st_ops->kern_vdata_off, KERN_VDATA_MAX_SIZE);
+}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7754d6640167..d00ff5f8b0b0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9772,9 +9772,14 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 		if (!map->autocreate)
 			continue;
 
-		err = bpf_map_prepare_vdata(map);
-		if (err)
-			return err;
+		if (obj->gen_loader) {
+			bpf_gen__struct_ops_update_elem(obj->gen_loader, i,
+							obj->btf, map->st_ops);
+		} else {
+			err = bpf_map_prepare_vdata(map);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -10720,6 +10725,11 @@ int bpf_program__set_expected_attach_type(struct bpf_program *prog,
 	return 0;
 }
 
+int bpf_program_idx(const struct bpf_program *prog)
+{
+	return prog - prog->obj->programs;
+}
+
 __u32 bpf_program__flags(const struct bpf_program *prog)
 {
 	return prog->prog_flags;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 845d6557c922..94c3a4019b11 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -317,6 +317,8 @@ struct bpf_struct_ops {
 	__u32 type_id;
 };
 
+int bpf_program_idx(const struct bpf_program *prog);
+
 int parse_btf_map_def(const char *map_name, struct btf *btf,
 		      const struct btf_type *def_t, bool strict,
 		      struct btf_map_def *map_def, struct btf_map_def *inner_def);

-- 
2.56.0.455.g6c5a503b38-goog


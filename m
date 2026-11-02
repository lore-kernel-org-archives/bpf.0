Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641449;
	b=V488ZX+KW+A9CFTWFrnzaCvMQH7QRP/3yWTsgDZKmBTUz2h+QCh1lXAml8OfclW/nS75
	 76/TzbbxcK4CpZOSG9Bm+pev6fXxikYXcb7taAaSC2ey0SLobSM9Framm/5wc+gFnQNF3
	 uDfihWAY1XzxPxmXJbzfzsnI0jqJYUGDlUkNLSwTVjgLQ1XaSomCQKaIfKysF8xowMJCO
	 z4eE31vKzxhZpLcml9nUkgYJE0snQBNU9F9jGCYa0IU5wzf51zotZXEIoZqLy4jKpq9Pe
	 i1rFOEB6Cknlz47Gx5Mqt+JBBX84ogfBAK5n3eEHGb8mY9I8vwi6+vzo7bq1WZo4VPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R9/B73i0anbVr1qiVgwDikw6UHczgEUUyJI0C2f1LZo=;
	b=3bW80Z5x+yNC7mCSo14vmVn8Iox612z/Zix6SMpItX57jwV5B43pDS9+iwdWcdf0jQdt
	 FdQ9XBCukBm7MrsDn2/VQC2U1NupFHI3dxFprVz5J/YQ8FcKL4iYYiYP8t6hkgP6fBZz0
	 tCr6ZuWawE883vq8CmsxWiCzMz/TtehGatplQfiZowVjYO22he+zaJ80zxjVGGXIwhidj
	 s01sC/y8F8jYB1z80oCzx4FltjJ8W5Lz1mouykKmys5Qa6+X7ycQq7PnUq5ZX5p3VbJUB
	 +Xg5rAHJkhcqFDpRRh/vqiuy3c5pORp31fT8mM6/K4av+/DINOxfluFlbf+8UPoM4gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Btapmsu7;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF13606A332
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF13606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Btapmsu7
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso29208615e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641447; x=1794246247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9/B73i0anbVr1qiVgwDikw6UHczgEUUyJI0C2f1LZo=;
        b=Btapmsu7Z5XXAS00gB8CQn4fRdaU0ysFgAisG8uqL5Nt9kapPs5rf1oqMzrVqq8HsQ
         pSdvhBRXzgeAOD+Rq7WS1N+EKKi94r9IpUoDplmk553QcjtGVm37xSlwVKfOWazvmR8S
         RaVGf6Bt8KR1kbm9Dc1dio9+l3IhCMZ0g0nHqR3dRGU2o1DWKenQsZByd9oie2qT6g9K
         5Cp2Ziz/OIVNKbffFhxbco998brw7MSGRjX9re1L51L9ChJy3kOpzLiFQVco7rmIZT60
         7GzSVu1Ur/MoTVBsWbwF5Xp4XE7PZa/CJZccQsqjjp2MthHf5GPTim4cUIEJ3WQRQfZO
         pMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641447; x=1794246247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9/B73i0anbVr1qiVgwDikw6UHczgEUUyJI0C2f1LZo=;
        b=kQAVb7UmJaT9Y06aGk14yM3XGrst7DBmI2sTGmLqOVyZoXqIltXeMOqP1148KjEW6w
         4Rim1jRyY0sWsIpFYfyz2ZitMiw2H+UnHN0j4hJTpMM7k6QsiFEm1qeQ3dP5s/EEW0wJ
         QpcnGod3D1OrMbr+eVhbZ8J+XcscWcGWxP8DNY8pqH9oIiZNk5WITUwcwJhlk2c8pdqn
         MKl6mDarfxYa/KAQt/Yd+dyLbcN+jYiZge0khWzM/N+nlwCgWPHdRTTeaY1U360pnqmR
         JSCinPyu4NvCejwdAfteKPaMjMjF7+GaLbitZmhllEBTkqB5AyOqNZo6TH+qtvUoFLbw
         HShg==
X-Gm-Message-State: AFq9FYI5iMPE9/3B7AqrVYtU3XvM7ZlteeMIvhrx2TDQ5N3hT8LgNx/o
	WW+eJKzd/c8z7SpGxVeXcucSUg9CHZSxYkh0tM9sYqYRbBhwthc9s2QLkVHjNJpgdkqqow==
X-Gm-Gg: AYBFou38YXQeQhBL4VKqJYR+tQPyOhCroGfUekdqqN4MdY08zTuNzKnHAus2sILsgNu
	Fwu1cNki+cjIcZ3LmRr4SRzwoaKlg/jXnEoyvJppYGkGHnri8+ISEJzGNAzHwjmWpPaTHPzhbdG
	sTL9p/hD/2m9q1vx5Yf5I/TThx8Y4EV8d22VMXmUhGeEpZoz9VEMwRIb7CvusxVzFF2jBdrEsM6
	TOPTrgrCipItqwoZwVgY/sAPk2g7rciJI5C/7VmtrgDtrwWF94DnjayGZRI5f/vr0uV+gOrCGXj
	kNmS4q1mtF7a2fx+s44ISxYCWkKdwtJ0uMbirAEIKGquOhCT/2uvlTy3oXnbTq6pHKgUJnJS002
	/nxzyfFXd4O+wgeqk1EJTEC1Mt/7hZ1MUhGeIATgd0n0l4N7Yx4xDvy34m6eTuxvJkqkkm1HgNd
	Ebn7lOUuG3EopTYWb6Z/XXv8sKMT1XTRG6qY1WaEnUod8Wzw26FgsvBcDWrL0GiaNAubtm7+cP3
	vjgjlgGJjS24tNeuT5vXu1WLBMk0I0UnbJROgnH7tdt2j1goCHCI5DcQdXN1zjt6L/eyPjbFEK2
	9yExtZbrM0Cm7bWFcXUxxufyXKkfg9IRjUpTkQrk3UIl3hEsP1+NB1wJCgzwFqNzZvYiyTrG+t+
	tdMKgTj8ztw4YtLymw7KOMw==
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ac17b2be08mr248169455e9.26.1793641446751;
        Mon, 02 Nov 2026 09:44:06 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm196311865e9.1.2026.11.02.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:44:06 -0800 (PST)
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
Subject: [PATCH bpf-next 3/5] libbpf: Emit BPF_LINK_CREATE calls in generated loaders
Date: Mon,  2 Nov 2026 17:43:48 +0000
Message-ID: <20261102174350.472592-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102174350.472592-1-mahe.tardy@gmail.com>
References: <20261102174350.472592-1-mahe.tardy@gmail.com>
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
index 17690cbd299b..e39a6d3b6f2e 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -16,7 +16,6 @@
 #include "skel_internal.h"

 #define MAX_USED_MAPS	64
-#define MAX_USED_PROGS	32
 #define MAX_KFUNC_DESCS 256
 #define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)

@@ -415,7 +414,8 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 		move_stack2ctx(gen,
 			       sizeof(struct bpf_loader_ctx) +
 			       sizeof(struct bpf_map_desc) * gen->nr_maps +
-			       sizeof(struct bpf_prog_desc) * i +
+			       sizeof(struct bpf_prog_desc) *
+			       (gen->nr_link_slots ? gen->prog_output_idx[i] : i) +
 			       offsetof(struct bpf_prog_desc, prog_fd), 4,
 			       stack_off(prog_fd[i]));
 	for (i = 0; i < gen->nr_maps; i++)
@@ -1033,6 +1033,26 @@ static void info_blob_bswap(struct bpf_gen *gen, int func_info, int line_info,
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
index cd8ff7f42768..9118d95d22bb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10061,6 +10061,47 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
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
+		if (!prog->autoload)
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
@@ -10120,6 +10161,9 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
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


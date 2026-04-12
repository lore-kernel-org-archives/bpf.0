Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4254314A86
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775963523; cv=none; b=CA3JR6KbgIz4kTRwKxqpnUtpOqjK9IRjYlhEtSdwybrPANe5fU6Dmyt3zePTt5VO64sZPm7ZKggVV5grFzVPqSz/IkcGm46j0EgW/XwG2q+A4KfFccSRuxAglaNK9VSAoH+vfZjDC2KwVZu50ZTvAm4MBLMwCzJGacyPr4RCVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775963523; c=relaxed/simple;
	bh=il/wN2Sl9Mt13Sp92H/xXd38fjdtBRxqmTLr5OqW4yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDcwSP7w1k9hm3iRfVmjvucAcUJXyiQavVkAB8B0Mz/cdhpDLvRHdaTSQ+rim0cAnOu8m4SJ91b4in4k4yShlsGxsy0rfHg+B3OxfbWMJhR3x+hFPuLMniQbxHm2iV08DjL2XiTAxvfXsNXY/NdNtL2/0QJHRXXduZmi0vWeQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRansTMr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRansTMr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82c70e4654eso1457442b3a.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775963520; x=1776568320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkrxeD5w9KqUz1otXnV1hzQKyUsTOmsv8V/4Ci2JVXg=;
        b=lRansTMrN9EudcrB86UalATP1lSIQ//JZ4wTRcriU0hTXWS+aPL8HzeCJOtzR3Xinc
         YEY5uKIU79qDTdoJUrfS8Dw/QALgs+N6o0EFbapJE7W4JWZK5Dk/+jTEURezYjtakqKL
         W0O5YMmb88cEm3dxdMqseaT+h6b1+FOy6/1iY7SJ2k9ZDTpqnJcrpHE4pge4tNW+oGkY
         Izr6DllI6MgJ5Tef1MGvLnuPo6hbVaIGIQ5a17jwfrBq/iSLHhSt11l4kdkMft6gWVKr
         nPNg/Li/+cd7NnSGDYsZJuq5HQy1gE+y1yyMqUkm84K2uroSDm2fBCf2qLzNH/k1Alma
         Jp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775963520; x=1776568320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IkrxeD5w9KqUz1otXnV1hzQKyUsTOmsv8V/4Ci2JVXg=;
        b=BCxoshcpAMCfHH/5ZfW2t3Z5nyeYI1UXfzyjYBnjxYoU4Fz00u18vSr3+7Yxv6Df1v
         lRH8d6r8EZNOHC+TgBN+LsuAi+N5rSiW9X4Q6Yjsd5MDPYNCNKmS6phyGNtO989HpXfw
         8znMOP2wz4FkHaVA9HitoFc7u68oDsZTDKYoUjFKqBgoYjHu6rw4XeSL8a4ILwc+nMbb
         qz/y47bwOBHVrkxvYiJxZCKYc3HvFpCEu2jzH8PYiS+aWar0udTG4/8AijGj+Jlcwzqx
         0hwGBvTC/jDtNh2qmAUPdiR53pWR2H1ZAO7ofMACBidNkWHh9i8f3VPjBBy7A+SlmudJ
         Bm9g==
X-Gm-Message-State: AOJu0Yw+OcF6OwmI+nrKhMGw4FHQFOcELqKOYo5xDkRotckzGCDwQBTo
	qnTxXW3Y53+Vx/a8rFp1hA5v05YeFte72CKS4tOSWLnevs4DTlmN9W8rdIwlow==
X-Gm-Gg: AeBDieviv4RYFePINvx0rnL+UqD5cl5g/AZE/rKfCruOErfuYbt9ORFoldmPSHpCq2z
	otOZiJfszmTRPVYpj/D8v1yHIRGOjqqyVkjw1+pFI/N5ynw9qYenG9v/mse4rxcHpEkybNjjhBt
	3Y63GQ6NeJx3v8tC3IlQTQV4pqNvHUhS/CuyuKCfAvHT1pREGI2FExU41RpySGhLdk95V7U7CkH
	cL3czqDI3tP51LUCeqTGLqCdIEiDdotVb6rH4m+yf/Oj/c0EL4J/DhJTohi/1PCU3ZUJ3NNU1Sm
	ht080ESGmSPFfJynIp7pyoc2Mkjn149/NUTrIKdmgXA0yWFBaD95KiPYuIvjvlchxx2iFVNMwOp
	vbZP00mLvxVqk3QeVyXV1kiuTes8AGtH7gm44KX8t/7+YO8A/EM8/EjvdxDkgn9iRjTcmElkl5n
	2DtVPV5b6qnWcYxAyqMkWC6Il7WT6ZiH/5C+NplaXj7nXQruAs5lt/QLrR+UWgSI2GVVXNNaFuc
	euKOZMe1sjZDqYUqPYY4rlzltF1pP7MzkV9v4tIr+E3clh2ot5RDQ==
X-Received: by 2002:a05:6a20:3953:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39fe3da99c8mr10192364637.18.1775963520324;
        Sat, 11 Apr 2026 20:12:00 -0700 (PDT)
Received: from ast-mac ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc462sm6564677a12.8.2026.04.11.20.11.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 20:11:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/6] bpf: Move BTF checking logic into check_btf.c
Date: Sat, 11 Apr 2026 20:11:37 -0700
Message-ID: <20260412031139.41248-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260412031139.41248-1-alexei.starovoitov@gmail.com>
References: <20260412031139.41248-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

BTF validation logic is independent from the main verifier.
Move it into check_btf.c

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   5 +
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/check_btf.c       | 463 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 460 +---------------------------------
 4 files changed, 471 insertions(+), 459 deletions(-)
 create mode 100644 kernel/bpf/check_btf.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2fe3d6ad8565..a71b59009f57 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1061,6 +1061,11 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
+int bpf_check_btf_info_early(struct bpf_verifier_env *env,
+			     const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_check_btf_info(struct bpf_verifier_env *env,
+		       const union bpf_attr *attr, bpfptr_t uattr);
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index fd1d901b8d3c..399007b67a92 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
new file mode 100644
index 000000000000..93bebe6fe12e
--- /dev/null
+++ b/kernel/bpf/check_btf.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/btf.h>
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+static int check_abnormal_return(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 1; i < env->subprog_cnt; i++) {
+		if (env->subprog_info[i].has_ld_abs) {
+			verbose(env, "LD_ABS is not allowed in subprogs without BTF\n");
+			return -EINVAL;
+		}
+		if (env->subprog_info[i].has_tail_call) {
+			verbose(env, "tail_call is not allowed in subprogs without BTF\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* The minimum supported BTF func info size */
+#define MIN_BPF_FUNCINFO_SIZE	8
+#define MAX_FUNCINFO_REC_SIZE	252
+
+static int check_btf_func_early(struct bpf_verifier_env *env,
+				const union bpf_attr *attr,
+				bpfptr_t uattr)
+{
+	u32 krec_size = sizeof(struct bpf_func_info);
+	const struct btf_type *type, *func_proto;
+	u32 i, nfuncs, urec_size, min_size;
+	struct bpf_func_info *krecord;
+	struct bpf_prog *prog;
+	const struct btf *btf;
+	u32 prev_offset = 0;
+	bpfptr_t urecord;
+	int ret = -ENOMEM;
+
+	nfuncs = attr->func_info_cnt;
+	if (!nfuncs) {
+		if (check_abnormal_return(env))
+			return -EINVAL;
+		return 0;
+	}
+
+	urec_size = attr->func_info_rec_size;
+	if (urec_size < MIN_BPF_FUNCINFO_SIZE ||
+	    urec_size > MAX_FUNCINFO_REC_SIZE ||
+	    urec_size % sizeof(u32)) {
+		verbose(env, "invalid func info rec size %u\n", urec_size);
+		return -EINVAL;
+	}
+
+	prog = env->prog;
+	btf = prog->aux->btf;
+
+	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
+	min_size = min_t(u32, krec_size, urec_size);
+
+	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!krecord)
+		return -ENOMEM;
+
+	for (i = 0; i < nfuncs; i++) {
+		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
+		if (ret) {
+			if (ret == -E2BIG) {
+				verbose(env, "nonzero tailing record in func info");
+				/* set the size kernel expects so loader can zero
+				 * out the rest of the record.
+				 */
+				if (copy_to_bpfptr_offset(uattr,
+							  offsetof(union bpf_attr, func_info_rec_size),
+							  &min_size, sizeof(min_size)))
+					ret = -EFAULT;
+			}
+			goto err_free;
+		}
+
+		if (copy_from_bpfptr(&krecord[i], urecord, min_size)) {
+			ret = -EFAULT;
+			goto err_free;
+		}
+
+		/* check insn_off */
+		ret = -EINVAL;
+		if (i == 0) {
+			if (krecord[i].insn_off) {
+				verbose(env,
+					"nonzero insn_off %u for the first func info record",
+					krecord[i].insn_off);
+				goto err_free;
+			}
+		} else if (krecord[i].insn_off <= prev_offset) {
+			verbose(env,
+				"same or smaller insn offset (%u) than previous func info record (%u)",
+				krecord[i].insn_off, prev_offset);
+			goto err_free;
+		}
+
+		/* check type_id */
+		type = btf_type_by_id(btf, krecord[i].type_id);
+		if (!type || !btf_type_is_func(type)) {
+			verbose(env, "invalid type id %d in func info",
+				krecord[i].type_id);
+			goto err_free;
+		}
+
+		func_proto = btf_type_by_id(btf, type->type);
+		if (unlikely(!func_proto || !btf_type_is_func_proto(func_proto)))
+			/* btf_func_check() already verified it during BTF load */
+			goto err_free;
+
+		prev_offset = krecord[i].insn_off;
+		bpfptr_add(&urecord, urec_size);
+	}
+
+	prog->aux->func_info = krecord;
+	prog->aux->func_info_cnt = nfuncs;
+	return 0;
+
+err_free:
+	kvfree(krecord);
+	return ret;
+}
+
+static int check_btf_func(struct bpf_verifier_env *env,
+			  const union bpf_attr *attr,
+			  bpfptr_t uattr)
+{
+	const struct btf_type *type, *func_proto, *ret_type;
+	u32 i, nfuncs, urec_size;
+	struct bpf_func_info *krecord;
+	struct bpf_func_info_aux *info_aux = NULL;
+	struct bpf_prog *prog;
+	const struct btf *btf;
+	bpfptr_t urecord;
+	bool scalar_return;
+	int ret = -ENOMEM;
+
+	nfuncs = attr->func_info_cnt;
+	if (!nfuncs) {
+		if (check_abnormal_return(env))
+			return -EINVAL;
+		return 0;
+	}
+	if (nfuncs != env->subprog_cnt) {
+		verbose(env, "number of funcs in func_info doesn't match number of subprogs\n");
+		return -EINVAL;
+	}
+
+	urec_size = attr->func_info_rec_size;
+
+	prog = env->prog;
+	btf = prog->aux->btf;
+
+	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
+
+	krecord = prog->aux->func_info;
+	info_aux = kzalloc_objs(*info_aux, nfuncs,
+				GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!info_aux)
+		return -ENOMEM;
+
+	for (i = 0; i < nfuncs; i++) {
+		/* check insn_off */
+		ret = -EINVAL;
+
+		if (env->subprog_info[i].start != krecord[i].insn_off) {
+			verbose(env, "func_info BTF section doesn't match subprog layout in BPF program\n");
+			goto err_free;
+		}
+
+		/* Already checked type_id */
+		type = btf_type_by_id(btf, krecord[i].type_id);
+		info_aux[i].linkage = BTF_INFO_VLEN(type->info);
+		/* Already checked func_proto */
+		func_proto = btf_type_by_id(btf, type->type);
+
+		ret_type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
+		scalar_return =
+			btf_type_is_small_int(ret_type) || btf_is_any_enum(ret_type);
+		if (i && !scalar_return && env->subprog_info[i].has_ld_abs) {
+			verbose(env, "LD_ABS is only allowed in functions that return 'int'.\n");
+			goto err_free;
+		}
+		if (i && !scalar_return && env->subprog_info[i].has_tail_call) {
+			verbose(env, "tail_call is only allowed in functions that return 'int'.\n");
+			goto err_free;
+		}
+
+		env->subprog_info[i].name = btf_name_by_offset(btf, type->name_off);
+		bpfptr_add(&urecord, urec_size);
+	}
+
+	prog->aux->func_info_aux = info_aux;
+	return 0;
+
+err_free:
+	kfree(info_aux);
+	return ret;
+}
+
+#define MIN_BPF_LINEINFO_SIZE	offsetofend(struct bpf_line_info, line_col)
+#define MAX_LINEINFO_REC_SIZE	MAX_FUNCINFO_REC_SIZE
+
+static int check_btf_line(struct bpf_verifier_env *env,
+			  const union bpf_attr *attr,
+			  bpfptr_t uattr)
+{
+	u32 i, s, nr_linfo, ncopy, expected_size, rec_size, prev_offset = 0;
+	struct bpf_subprog_info *sub;
+	struct bpf_line_info *linfo;
+	struct bpf_prog *prog;
+	const struct btf *btf;
+	bpfptr_t ulinfo;
+	int err;
+
+	nr_linfo = attr->line_info_cnt;
+	if (!nr_linfo)
+		return 0;
+	if (nr_linfo > INT_MAX / sizeof(struct bpf_line_info))
+		return -EINVAL;
+
+	rec_size = attr->line_info_rec_size;
+	if (rec_size < MIN_BPF_LINEINFO_SIZE ||
+	    rec_size > MAX_LINEINFO_REC_SIZE ||
+	    rec_size & (sizeof(u32) - 1))
+		return -EINVAL;
+
+	/* Need to zero it in case the userspace may
+	 * pass in a smaller bpf_line_info object.
+	 */
+	linfo = kvzalloc_objs(struct bpf_line_info, nr_linfo,
+			      GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!linfo)
+		return -ENOMEM;
+
+	prog = env->prog;
+	btf = prog->aux->btf;
+
+	s = 0;
+	sub = env->subprog_info;
+	ulinfo = make_bpfptr(attr->line_info, uattr.is_kernel);
+	expected_size = sizeof(struct bpf_line_info);
+	ncopy = min_t(u32, expected_size, rec_size);
+	for (i = 0; i < nr_linfo; i++) {
+		err = bpf_check_uarg_tail_zero(ulinfo, expected_size, rec_size);
+		if (err) {
+			if (err == -E2BIG) {
+				verbose(env, "nonzero tailing record in line_info");
+				if (copy_to_bpfptr_offset(uattr,
+							  offsetof(union bpf_attr, line_info_rec_size),
+							  &expected_size, sizeof(expected_size)))
+					err = -EFAULT;
+			}
+			goto err_free;
+		}
+
+		if (copy_from_bpfptr(&linfo[i], ulinfo, ncopy)) {
+			err = -EFAULT;
+			goto err_free;
+		}
+
+		/*
+		 * Check insn_off to ensure
+		 * 1) strictly increasing AND
+		 * 2) bounded by prog->len
+		 *
+		 * The linfo[0].insn_off == 0 check logically falls into
+		 * the later "missing bpf_line_info for func..." case
+		 * because the first linfo[0].insn_off must be the
+		 * first sub also and the first sub must have
+		 * subprog_info[0].start == 0.
+		 */
+		if ((i && linfo[i].insn_off <= prev_offset) ||
+		    linfo[i].insn_off >= prog->len) {
+			verbose(env, "Invalid line_info[%u].insn_off:%u (prev_offset:%u prog->len:%u)\n",
+				i, linfo[i].insn_off, prev_offset,
+				prog->len);
+			err = -EINVAL;
+			goto err_free;
+		}
+
+		if (!prog->insnsi[linfo[i].insn_off].code) {
+			verbose(env,
+				"Invalid insn code at line_info[%u].insn_off\n",
+				i);
+			err = -EINVAL;
+			goto err_free;
+		}
+
+		if (!btf_name_by_offset(btf, linfo[i].line_off) ||
+		    !btf_name_by_offset(btf, linfo[i].file_name_off)) {
+			verbose(env, "Invalid line_info[%u].line_off or .file_name_off\n", i);
+			err = -EINVAL;
+			goto err_free;
+		}
+
+		if (s != env->subprog_cnt) {
+			if (linfo[i].insn_off == sub[s].start) {
+				sub[s].linfo_idx = i;
+				s++;
+			} else if (sub[s].start < linfo[i].insn_off) {
+				verbose(env, "missing bpf_line_info for func#%u\n", s);
+				err = -EINVAL;
+				goto err_free;
+			}
+		}
+
+		prev_offset = linfo[i].insn_off;
+		bpfptr_add(&ulinfo, rec_size);
+	}
+
+	if (s != env->subprog_cnt) {
+		verbose(env, "missing bpf_line_info for %u funcs starting from func#%u\n",
+			env->subprog_cnt - s, s);
+		err = -EINVAL;
+		goto err_free;
+	}
+
+	prog->aux->linfo = linfo;
+	prog->aux->nr_linfo = nr_linfo;
+
+	return 0;
+
+err_free:
+	kvfree(linfo);
+	return err;
+}
+
+#define MIN_CORE_RELO_SIZE	sizeof(struct bpf_core_relo)
+#define MAX_CORE_RELO_SIZE	MAX_FUNCINFO_REC_SIZE
+
+static int check_core_relo(struct bpf_verifier_env *env,
+			   const union bpf_attr *attr,
+			   bpfptr_t uattr)
+{
+	u32 i, nr_core_relo, ncopy, expected_size, rec_size;
+	struct bpf_core_relo core_relo = {};
+	struct bpf_prog *prog = env->prog;
+	const struct btf *btf = prog->aux->btf;
+	struct bpf_core_ctx ctx = {
+		.log = &env->log,
+		.btf = btf,
+	};
+	bpfptr_t u_core_relo;
+	int err;
+
+	nr_core_relo = attr->core_relo_cnt;
+	if (!nr_core_relo)
+		return 0;
+	if (nr_core_relo > INT_MAX / sizeof(struct bpf_core_relo))
+		return -EINVAL;
+
+	rec_size = attr->core_relo_rec_size;
+	if (rec_size < MIN_CORE_RELO_SIZE ||
+	    rec_size > MAX_CORE_RELO_SIZE ||
+	    rec_size % sizeof(u32))
+		return -EINVAL;
+
+	u_core_relo = make_bpfptr(attr->core_relos, uattr.is_kernel);
+	expected_size = sizeof(struct bpf_core_relo);
+	ncopy = min_t(u32, expected_size, rec_size);
+
+	/* Unlike func_info and line_info, copy and apply each CO-RE
+	 * relocation record one at a time.
+	 */
+	for (i = 0; i < nr_core_relo; i++) {
+		/* future proofing when sizeof(bpf_core_relo) changes */
+		err = bpf_check_uarg_tail_zero(u_core_relo, expected_size, rec_size);
+		if (err) {
+			if (err == -E2BIG) {
+				verbose(env, "nonzero tailing record in core_relo");
+				if (copy_to_bpfptr_offset(uattr,
+							  offsetof(union bpf_attr, core_relo_rec_size),
+							  &expected_size, sizeof(expected_size)))
+					err = -EFAULT;
+			}
+			break;
+		}
+
+		if (copy_from_bpfptr(&core_relo, u_core_relo, ncopy)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (core_relo.insn_off % 8 || core_relo.insn_off / 8 >= prog->len) {
+			verbose(env, "Invalid core_relo[%u].insn_off:%u prog->len:%u\n",
+				i, core_relo.insn_off, prog->len);
+			err = -EINVAL;
+			break;
+		}
+
+		err = bpf_core_apply(&ctx, &core_relo, i,
+				     &prog->insnsi[core_relo.insn_off / 8]);
+		if (err)
+			break;
+		bpfptr_add(&u_core_relo, rec_size);
+	}
+	return err;
+}
+
+int bpf_check_btf_info_early(struct bpf_verifier_env *env,
+			     const union bpf_attr *attr,
+			     bpfptr_t uattr)
+{
+	struct btf *btf;
+	int err;
+
+	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+		if (check_abnormal_return(env))
+			return -EINVAL;
+		return 0;
+	}
+
+	btf = btf_get_by_fd(attr->prog_btf_fd);
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+	if (btf_is_kernel(btf)) {
+		btf_put(btf);
+		return -EACCES;
+	}
+	env->prog->aux->btf = btf;
+
+	err = check_btf_func_early(env, attr, uattr);
+	if (err)
+		return err;
+	return 0;
+}
+
+int bpf_check_btf_info(struct bpf_verifier_env *env,
+		       const union bpf_attr *attr,
+		       bpfptr_t uattr)
+{
+	int err;
+
+	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+		if (check_abnormal_return(env))
+			return -EINVAL;
+		return 0;
+	}
+
+	err = check_btf_func(env, attr, uattr);
+	if (err)
+		return err;
+
+	err = check_btf_line(env, attr, uattr);
+	if (err)
+		return err;
+
+	err = check_core_relo(env, attr, uattr);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2c597c41148..fa6f4a7ba06d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17277,206 +17277,6 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int check_abnormal_return(struct bpf_verifier_env *env)
-{
-	int i;
-
-	for (i = 1; i < env->subprog_cnt; i++) {
-		if (env->subprog_info[i].has_ld_abs) {
-			verbose(env, "LD_ABS is not allowed in subprogs without BTF\n");
-			return -EINVAL;
-		}
-		if (env->subprog_info[i].has_tail_call) {
-			verbose(env, "tail_call is not allowed in subprogs without BTF\n");
-			return -EINVAL;
-		}
-	}
-	return 0;
-}
-
-/* The minimum supported BTF func info size */
-#define MIN_BPF_FUNCINFO_SIZE	8
-#define MAX_FUNCINFO_REC_SIZE	252
-
-static int check_btf_func_early(struct bpf_verifier_env *env,
-				const union bpf_attr *attr,
-				bpfptr_t uattr)
-{
-	u32 krec_size = sizeof(struct bpf_func_info);
-	const struct btf_type *type, *func_proto;
-	u32 i, nfuncs, urec_size, min_size;
-	struct bpf_func_info *krecord;
-	struct bpf_prog *prog;
-	const struct btf *btf;
-	u32 prev_offset = 0;
-	bpfptr_t urecord;
-	int ret = -ENOMEM;
-
-	nfuncs = attr->func_info_cnt;
-	if (!nfuncs) {
-		if (check_abnormal_return(env))
-			return -EINVAL;
-		return 0;
-	}
-
-	urec_size = attr->func_info_rec_size;
-	if (urec_size < MIN_BPF_FUNCINFO_SIZE ||
-	    urec_size > MAX_FUNCINFO_REC_SIZE ||
-	    urec_size % sizeof(u32)) {
-		verbose(env, "invalid func info rec size %u\n", urec_size);
-		return -EINVAL;
-	}
-
-	prog = env->prog;
-	btf = prog->aux->btf;
-
-	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
-	min_size = min_t(u32, krec_size, urec_size);
-
-	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
-	if (!krecord)
-		return -ENOMEM;
-
-	for (i = 0; i < nfuncs; i++) {
-		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
-		if (ret) {
-			if (ret == -E2BIG) {
-				verbose(env, "nonzero tailing record in func info");
-				/* set the size kernel expects so loader can zero
-				 * out the rest of the record.
-				 */
-				if (copy_to_bpfptr_offset(uattr,
-							  offsetof(union bpf_attr, func_info_rec_size),
-							  &min_size, sizeof(min_size)))
-					ret = -EFAULT;
-			}
-			goto err_free;
-		}
-
-		if (copy_from_bpfptr(&krecord[i], urecord, min_size)) {
-			ret = -EFAULT;
-			goto err_free;
-		}
-
-		/* check insn_off */
-		ret = -EINVAL;
-		if (i == 0) {
-			if (krecord[i].insn_off) {
-				verbose(env,
-					"nonzero insn_off %u for the first func info record",
-					krecord[i].insn_off);
-				goto err_free;
-			}
-		} else if (krecord[i].insn_off <= prev_offset) {
-			verbose(env,
-				"same or smaller insn offset (%u) than previous func info record (%u)",
-				krecord[i].insn_off, prev_offset);
-			goto err_free;
-		}
-
-		/* check type_id */
-		type = btf_type_by_id(btf, krecord[i].type_id);
-		if (!type || !btf_type_is_func(type)) {
-			verbose(env, "invalid type id %d in func info",
-				krecord[i].type_id);
-			goto err_free;
-		}
-
-		func_proto = btf_type_by_id(btf, type->type);
-		if (unlikely(!func_proto || !btf_type_is_func_proto(func_proto)))
-			/* btf_func_check() already verified it during BTF load */
-			goto err_free;
-
-		prev_offset = krecord[i].insn_off;
-		bpfptr_add(&urecord, urec_size);
-	}
-
-	prog->aux->func_info = krecord;
-	prog->aux->func_info_cnt = nfuncs;
-	return 0;
-
-err_free:
-	kvfree(krecord);
-	return ret;
-}
-
-static int check_btf_func(struct bpf_verifier_env *env,
-			  const union bpf_attr *attr,
-			  bpfptr_t uattr)
-{
-	const struct btf_type *type, *func_proto, *ret_type;
-	u32 i, nfuncs, urec_size;
-	struct bpf_func_info *krecord;
-	struct bpf_func_info_aux *info_aux = NULL;
-	struct bpf_prog *prog;
-	const struct btf *btf;
-	bpfptr_t urecord;
-	bool scalar_return;
-	int ret = -ENOMEM;
-
-	nfuncs = attr->func_info_cnt;
-	if (!nfuncs) {
-		if (check_abnormal_return(env))
-			return -EINVAL;
-		return 0;
-	}
-	if (nfuncs != env->subprog_cnt) {
-		verbose(env, "number of funcs in func_info doesn't match number of subprogs\n");
-		return -EINVAL;
-	}
-
-	urec_size = attr->func_info_rec_size;
-
-	prog = env->prog;
-	btf = prog->aux->btf;
-
-	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
-
-	krecord = prog->aux->func_info;
-	info_aux = kzalloc_objs(*info_aux, nfuncs,
-				GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
-	if (!info_aux)
-		return -ENOMEM;
-
-	for (i = 0; i < nfuncs; i++) {
-		/* check insn_off */
-		ret = -EINVAL;
-
-		if (env->subprog_info[i].start != krecord[i].insn_off) {
-			verbose(env, "func_info BTF section doesn't match subprog layout in BPF program\n");
-			goto err_free;
-		}
-
-		/* Already checked type_id */
-		type = btf_type_by_id(btf, krecord[i].type_id);
-		info_aux[i].linkage = BTF_INFO_VLEN(type->info);
-		/* Already checked func_proto */
-		func_proto = btf_type_by_id(btf, type->type);
-
-		ret_type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
-		scalar_return =
-			btf_type_is_small_int(ret_type) || btf_is_any_enum(ret_type);
-		if (i && !scalar_return && env->subprog_info[i].has_ld_abs) {
-			verbose(env, "LD_ABS is only allowed in functions that return 'int'.\n");
-			goto err_free;
-		}
-		if (i && !scalar_return && env->subprog_info[i].has_tail_call) {
-			verbose(env, "tail_call is only allowed in functions that return 'int'.\n");
-			goto err_free;
-		}
-
-		env->subprog_info[i].name = btf_name_by_offset(btf, type->name_off);
-		bpfptr_add(&urecord, urec_size);
-	}
-
-	prog->aux->func_info_aux = info_aux;
-	return 0;
-
-err_free:
-	kfree(info_aux);
-	return ret;
-}
-
 static void adjust_btf_func(struct bpf_verifier_env *env)
 {
 	struct bpf_prog_aux *aux = env->prog->aux;
@@ -17490,262 +17290,6 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
 }
 
-#define MIN_BPF_LINEINFO_SIZE	offsetofend(struct bpf_line_info, line_col)
-#define MAX_LINEINFO_REC_SIZE	MAX_FUNCINFO_REC_SIZE
-
-static int check_btf_line(struct bpf_verifier_env *env,
-			  const union bpf_attr *attr,
-			  bpfptr_t uattr)
-{
-	u32 i, s, nr_linfo, ncopy, expected_size, rec_size, prev_offset = 0;
-	struct bpf_subprog_info *sub;
-	struct bpf_line_info *linfo;
-	struct bpf_prog *prog;
-	const struct btf *btf;
-	bpfptr_t ulinfo;
-	int err;
-
-	nr_linfo = attr->line_info_cnt;
-	if (!nr_linfo)
-		return 0;
-	if (nr_linfo > INT_MAX / sizeof(struct bpf_line_info))
-		return -EINVAL;
-
-	rec_size = attr->line_info_rec_size;
-	if (rec_size < MIN_BPF_LINEINFO_SIZE ||
-	    rec_size > MAX_LINEINFO_REC_SIZE ||
-	    rec_size & (sizeof(u32) - 1))
-		return -EINVAL;
-
-	/* Need to zero it in case the userspace may
-	 * pass in a smaller bpf_line_info object.
-	 */
-	linfo = kvzalloc_objs(struct bpf_line_info, nr_linfo,
-			      GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
-	if (!linfo)
-		return -ENOMEM;
-
-	prog = env->prog;
-	btf = prog->aux->btf;
-
-	s = 0;
-	sub = env->subprog_info;
-	ulinfo = make_bpfptr(attr->line_info, uattr.is_kernel);
-	expected_size = sizeof(struct bpf_line_info);
-	ncopy = min_t(u32, expected_size, rec_size);
-	for (i = 0; i < nr_linfo; i++) {
-		err = bpf_check_uarg_tail_zero(ulinfo, expected_size, rec_size);
-		if (err) {
-			if (err == -E2BIG) {
-				verbose(env, "nonzero tailing record in line_info");
-				if (copy_to_bpfptr_offset(uattr,
-							  offsetof(union bpf_attr, line_info_rec_size),
-							  &expected_size, sizeof(expected_size)))
-					err = -EFAULT;
-			}
-			goto err_free;
-		}
-
-		if (copy_from_bpfptr(&linfo[i], ulinfo, ncopy)) {
-			err = -EFAULT;
-			goto err_free;
-		}
-
-		/*
-		 * Check insn_off to ensure
-		 * 1) strictly increasing AND
-		 * 2) bounded by prog->len
-		 *
-		 * The linfo[0].insn_off == 0 check logically falls into
-		 * the later "missing bpf_line_info for func..." case
-		 * because the first linfo[0].insn_off must be the
-		 * first sub also and the first sub must have
-		 * subprog_info[0].start == 0.
-		 */
-		if ((i && linfo[i].insn_off <= prev_offset) ||
-		    linfo[i].insn_off >= prog->len) {
-			verbose(env, "Invalid line_info[%u].insn_off:%u (prev_offset:%u prog->len:%u)\n",
-				i, linfo[i].insn_off, prev_offset,
-				prog->len);
-			err = -EINVAL;
-			goto err_free;
-		}
-
-		if (!prog->insnsi[linfo[i].insn_off].code) {
-			verbose(env,
-				"Invalid insn code at line_info[%u].insn_off\n",
-				i);
-			err = -EINVAL;
-			goto err_free;
-		}
-
-		if (!btf_name_by_offset(btf, linfo[i].line_off) ||
-		    !btf_name_by_offset(btf, linfo[i].file_name_off)) {
-			verbose(env, "Invalid line_info[%u].line_off or .file_name_off\n", i);
-			err = -EINVAL;
-			goto err_free;
-		}
-
-		if (s != env->subprog_cnt) {
-			if (linfo[i].insn_off == sub[s].start) {
-				sub[s].linfo_idx = i;
-				s++;
-			} else if (sub[s].start < linfo[i].insn_off) {
-				verbose(env, "missing bpf_line_info for func#%u\n", s);
-				err = -EINVAL;
-				goto err_free;
-			}
-		}
-
-		prev_offset = linfo[i].insn_off;
-		bpfptr_add(&ulinfo, rec_size);
-	}
-
-	if (s != env->subprog_cnt) {
-		verbose(env, "missing bpf_line_info for %u funcs starting from func#%u\n",
-			env->subprog_cnt - s, s);
-		err = -EINVAL;
-		goto err_free;
-	}
-
-	prog->aux->linfo = linfo;
-	prog->aux->nr_linfo = nr_linfo;
-
-	return 0;
-
-err_free:
-	kvfree(linfo);
-	return err;
-}
-
-#define MIN_CORE_RELO_SIZE	sizeof(struct bpf_core_relo)
-#define MAX_CORE_RELO_SIZE	MAX_FUNCINFO_REC_SIZE
-
-static int check_core_relo(struct bpf_verifier_env *env,
-			   const union bpf_attr *attr,
-			   bpfptr_t uattr)
-{
-	u32 i, nr_core_relo, ncopy, expected_size, rec_size;
-	struct bpf_core_relo core_relo = {};
-	struct bpf_prog *prog = env->prog;
-	const struct btf *btf = prog->aux->btf;
-	struct bpf_core_ctx ctx = {
-		.log = &env->log,
-		.btf = btf,
-	};
-	bpfptr_t u_core_relo;
-	int err;
-
-	nr_core_relo = attr->core_relo_cnt;
-	if (!nr_core_relo)
-		return 0;
-	if (nr_core_relo > INT_MAX / sizeof(struct bpf_core_relo))
-		return -EINVAL;
-
-	rec_size = attr->core_relo_rec_size;
-	if (rec_size < MIN_CORE_RELO_SIZE ||
-	    rec_size > MAX_CORE_RELO_SIZE ||
-	    rec_size % sizeof(u32))
-		return -EINVAL;
-
-	u_core_relo = make_bpfptr(attr->core_relos, uattr.is_kernel);
-	expected_size = sizeof(struct bpf_core_relo);
-	ncopy = min_t(u32, expected_size, rec_size);
-
-	/* Unlike func_info and line_info, copy and apply each CO-RE
-	 * relocation record one at a time.
-	 */
-	for (i = 0; i < nr_core_relo; i++) {
-		/* future proofing when sizeof(bpf_core_relo) changes */
-		err = bpf_check_uarg_tail_zero(u_core_relo, expected_size, rec_size);
-		if (err) {
-			if (err == -E2BIG) {
-				verbose(env, "nonzero tailing record in core_relo");
-				if (copy_to_bpfptr_offset(uattr,
-							  offsetof(union bpf_attr, core_relo_rec_size),
-							  &expected_size, sizeof(expected_size)))
-					err = -EFAULT;
-			}
-			break;
-		}
-
-		if (copy_from_bpfptr(&core_relo, u_core_relo, ncopy)) {
-			err = -EFAULT;
-			break;
-		}
-
-		if (core_relo.insn_off % 8 || core_relo.insn_off / 8 >= prog->len) {
-			verbose(env, "Invalid core_relo[%u].insn_off:%u prog->len:%u\n",
-				i, core_relo.insn_off, prog->len);
-			err = -EINVAL;
-			break;
-		}
-
-		err = bpf_core_apply(&ctx, &core_relo, i,
-				     &prog->insnsi[core_relo.insn_off / 8]);
-		if (err)
-			break;
-		bpfptr_add(&u_core_relo, rec_size);
-	}
-	return err;
-}
-
-static int check_btf_info_early(struct bpf_verifier_env *env,
-				const union bpf_attr *attr,
-				bpfptr_t uattr)
-{
-	struct btf *btf;
-	int err;
-
-	if (!attr->func_info_cnt && !attr->line_info_cnt) {
-		if (check_abnormal_return(env))
-			return -EINVAL;
-		return 0;
-	}
-
-	btf = btf_get_by_fd(attr->prog_btf_fd);
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
-	if (btf_is_kernel(btf)) {
-		btf_put(btf);
-		return -EACCES;
-	}
-	env->prog->aux->btf = btf;
-
-	err = check_btf_func_early(env, attr, uattr);
-	if (err)
-		return err;
-	return 0;
-}
-
-static int check_btf_info(struct bpf_verifier_env *env,
-			  const union bpf_attr *attr,
-			  bpfptr_t uattr)
-{
-	int err;
-
-	if (!attr->func_info_cnt && !attr->line_info_cnt) {
-		if (check_abnormal_return(env))
-			return -EINVAL;
-		return 0;
-	}
-
-	err = check_btf_func(env, attr, uattr);
-	if (err)
-		return err;
-
-	err = check_btf_line(env, attr, uattr);
-	if (err)
-		return err;
-
-	err = check_core_relo(env, attr, uattr);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-
 static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 {
 	switch (base_type(type)) {
@@ -20424,7 +19968,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		INIT_LIST_HEAD(&env->explored_states[i]);
 	INIT_LIST_HEAD(&env->free_list);
 
-	ret = check_btf_info_early(env, attr, uattr);
+	ret = bpf_check_btf_info_early(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -20436,7 +19980,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = check_btf_info(env, attr, uattr);
+	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.52.0


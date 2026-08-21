Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFE413D99
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355328; cv=none; b=Uy8O2xGbAxdYKVWhTtDOv8q/ONNIKwMV62j9lwzJy7qf5TYr0XATC9GgZBry2vsx9Zd4SWfG/sAreccR1IW7z3ZabwAvUkEx+9jwfCIMBCIQgojwMg0cRXs/l34sfbFx5/q7+FBhsOBDxPxL8M25julQRmgGZxGW8kpiPWXIJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355328; c=relaxed/simple;
	bh=k/Y8O3J29F8OqnSVfrR1r4qzju3TZHMDewz5XTZ2jjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMDVA+iSF+gBF9s0o48TN1znTcVIbhlMad4hT+qX8u+8KE/+QsN9SPOFF1+CNIdszGEch+VANwQCBgK1IvTtuo+x1Juh/Sck63Zr2eHNHiYleH5VqUXVpHgwpJRZpIu+RmRlNrkA04JRFFpNg1LlKyCT+4EKhmBMZ5aPSWyNZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE/4+Mg4; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE/4+Mg4"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c219353e5bbso98204266b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355325; x=1787960125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFSNpCkeySHNij82shiSmpjz/lUvqMsX6TYZHiViObw=;
        b=fE/4+Mg4Dfb9akhT4MpIL6DxA7KkEdKnBequvoCRaeu76SuWOSrDeXHrMtKET+o7wm
         YGJFiSnKnxR1WjwvqLTkPTC8EtdbcQGhruKcUIQV0KQ1pwYHvpEw9RBxIvaa5XSmItEX
         qTmzkLuXjn8eE/eyy3d+un/BvNxTNsuG049wZxEgo4YtnIZKh++qiuccesRatD2MJu8N
         3HLVeb5I+defAGpPYaqVnUII8wc2Xmc/nUjAGnKf+lbIMTfUxnkazyqz5rugbFG6AB3m
         oPqju74GtgTksrhn2y0zWldZz/8Z0AX7r8NzFMeR97D54xYEeeN/T2mzg2dp27LCYp8h
         owRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355325; x=1787960125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFSNpCkeySHNij82shiSmpjz/lUvqMsX6TYZHiViObw=;
        b=qDeu0QTYAIaBYSP+riTU+dVrCS0MA8ln73xkRRHaAJnHDOrv7BElOyLlmCPUj0oXnq
         2+66CYwbpWqSGYI3zchoQ293rKm+nXFWqdi8+ZvxWHWiLcfNivDBwywRAJY+KjKi9/VS
         IBYemntLgwdnfesqbJG7BQUduUmAhwNuHlCObrvVt9d7t263ATXyfMjFSu69t7fqzk35
         rr8/Bs8gwQwlgBGg2RU2gH5sVd6W4n/1eUNlF1DD9nIFkb1J8i0Aea7Bo7PH6mIM+0kf
         O902JK7tHtqoX4izQrzAxVMOqt6uXAzMb0fbtAq+cIPm7m5/U78uKU2XakAHTX79Kumx
         9pEQ==
X-Gm-Message-State: AFuF++kMHxbpf7wRJkGOWWLgOhgtCkPm5gaypbk7E5HKRnw9QA/wTnmv
	7BZ+5RvcvKIRJyb9QzpVgWRUqGu+j7ULBxyTr7FrNyes7VZg7i1sPjUnZKQpOJem
X-Gm-Gg: AR+sD12kGhv+ERHdBkLx+gme4HML6alL7JOmbPkvI2QqIdEBof/42o3wOzDQyOzoW0y
	jx5mk9/nVPwm0nT0+eQxZtCdEzsLmzAr9tQ/f7L3VYKIRylgucuITBHEQnSJTudvnaz2Er/VrnA
	4gWAYFA1xjgI/rfWx4hP7RgMDHRhB+Hq8zh/UaLQsMncxCr/gS2gw8Bbhlud+GPEZlfdf3UcZH2
	n/SpwUFgZOE0exH9UTTOedg61fVmxybbqOb/8qFQpHdJwsqDXmNvRsxUUjNJu1ei+jxiSmmcer0
	EWNIJNbJwxwP6K88SSiy5/Is7Od8R0gh6JuRwzwLkoSFU1dZy9JzmHt3Fa6b3EmFwZyyCKcFuG+
	KofFep/+AvKg1HF+oXWWlVDWbOji2eKxtHwNrpHfYB3Ch6cnBemly5+sH2tIgLnzm2s3irX6V6W
	1bwCGS3YnYnXJl6tLdlDor2PQVBpAjhrPFfI1e6AtCkUyr422iF7yUqBC6vAZ63ZnU23VRuxjVt
	dv//IVgroe0OpBy1NqceZrSU+2KjdiZHgn5JFPqFDMVzHORh0GrkOxJhJEmrOfkSGCTPRrs0XDM
	p4mtMPSQYUJFrXkzGB7SmTtBd/Q=
X-Received: by 2002:a17:907:3fa0:b0:c21:3c4e:cb90 with SMTP id a640c23a62f3a-c2491d27855mr204979066b.0.1787355324973;
        Fri, 21 Aug 2026 16:35:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab63sm36115466b.50.2026.08.21.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/14] bpf, s390: JIT arena kfunc argument rebasing
Date: Sat, 22 Aug 2026 01:34:59 +0200
Message-ID: <20260821233516.3426127-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3115; i=memxor@gmail.com; h=from:subject; bh=k/Y8O3J29F8OqnSVfrR1r4qzju3TZHMDewz5XTZ2jjE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQe/Ti3OWb9+4WTryYby98BWxfbmXa54vTSrl33kz9 GxmaHRARykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACayRYLhf3bDS6vXcbt3X07+ l1q6NdU18Jt20gzZpDD531dSLxdJ+zIynImr6sv+s8+kdGHrq/xdZ0wYvv3QSTyfnVYVFFsmu3w VIwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kfuncs with __arena arguments expect kernel addresses, while BPF
programs carry arena pointers as zero-extended 32-bit offsets. The s390
JIT does not translate those offsets at the call boundary, so advertising
arena kfunc argument support would pass invalid addresses to the callee.

Use the kfunc BTF model after the existing argument width normalization
to find arena arguments. Load kern_vm_start from the existing arena
literal once per call, truncate each tagged argument with llgfr, and add
the base. For __arena__nullable, test the truncated value and skip the add
so offset zero remains NULL.

Advertise the kfunc-specific arena argument capability. Struct_ops
trampoline conversion is independent and remains disabled until its own
support is added.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/s390/net/bpf_jit_comp.c | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c46872b071ce..20b6e53999b3 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -946,6 +946,48 @@ static int sign_zero_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
 	}
 }
 
+/*
+ * Rebase the __arena args of a kfunc call to arena kernel addresses,
+ * rN = kern_vm_start + (u32)rN. A nullable arg preserves NULL by skipping
+ * the add, tested on the truncated value as arena NULL is offset 0.
+ */
+static int emit_kfunc_arena_args(struct bpf_jit *jit, struct bpf_prog *fp,
+				 const struct btf_func_model *m)
+{
+	bool base_loaded = false;
+	int i;
+
+	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
+		u8 flags = m->arg_flags[i];
+		int arg = BPF_REG_1 + i;
+
+		if (!(flags & BTF_FMODEL_ARENA_ARG))
+			continue;
+		if (WARN_ON_ONCE(!fp->aux->arena))
+			return -EINVAL;
+
+		if (!base_loaded) {
+			/* lgrl %w0,kern_arena */
+			EMIT6_PCREL_RILB(0xc4080000, REG_W0, jit->kern_arena);
+			base_loaded = true;
+		}
+
+		/* llgfr %arg,%arg: truncate and clear the upper 32 bits */
+		EMIT4(0xb9160000, arg, arg);
+		if (flags & BTF_FMODEL_NULLABLE_ARG) {
+			/* ltgr %arg,%arg */
+			EMIT4(0xb9020000, arg, arg);
+			/* brc 8,1f */
+			EMIT4_PCREL_RIC(0xa7040000, 8, jit->prg + 8);
+		}
+		/* agr %arg,%w0 */
+		EMIT4(0xb9080000, arg, REG_W0);
+		/* 1: */
+	}
+
+	return 0;
+}
+
 /*
  * Compile one eBPF instruction into s390x code
  *
@@ -1867,6 +1909,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 						     m->arg_flags[j]))
 					return -1;
 			}
+			if (emit_kfunc_arena_args(jit, fp, m))
+				return -1;
 		}
 
 		if ((void *)func == arch_bpf_timed_may_goto) {
@@ -2459,6 +2503,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_kfunc_args(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_far_kfunc_call(void)
 {
 	return true;
-- 
2.53.0


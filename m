Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FA421227
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963886; cv=none; b=lBltgINg0KTmZfBG4Od8ZN+glim1lj41fQtLdaf4uDrTHIzu+8IaIjw7f4aluyV6aWGEIRX0XrvF48Gq45v3D6bBlq1BzFL/EBsoLfnt7YnbPvzHhVwYm85+wniW7UJY/kkXTslosWxqHnFeAm11m6MezKa2V38p7Jv/aYFk3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963886; c=relaxed/simple;
	bh=73ogM+BCbNjrskwR1gxeMnlTg5ha/pC6qa1UvLBZXxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3BegsFgDqpVxESEu39wpJdEkwiFWVa3ASTv9ny6aJu412dXweOmJrSbhxT/8XRWfyE9zg2guCsN3zTCpBtOaRf1Kx0GJEY53J34m+fGqdDnjKkJ8yIOk1Y7Zzs/aZzOS+m6o/CbXW4YfXl+tz/9htZn/tW8rEXHeot2h4HfgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mojnQPDV; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mojnQPDV"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso333247f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963882; x=1786568682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhFi7CQnq2lpwxjAxXCFhJsj5zt1MWjmEFF/2yQ00QU=;
        b=mojnQPDVIvsKNpR60fWEZ007FMvr0FZPWrTMgLoJXeDVV7x9G8NSJoYY4vnqrMxQwB
         1xxDSwROW0pT5qeGi8VgG6wZizZarsMuQy7AiFGuiU2kIp7fZRow976yt6Qx53k/CyWN
         Lxf+aC3fy4N/BAYt5ksjtA7QE9x9i8SWS6cQqIPfeSL7cF3vOoRJpX+NbrsJWgoheZbH
         GXjPXsKJL3HrRHSQC0eSAPGf6w2HkFQ01QaX3qsb/aP7QlE2/lSr2hKhqpBbDKpimiG4
         OpcFHMYynvnidsF9BNbkRDIUAMz0THjKvdJx9QYMAs27rDhLIPYhnUVG5sYRsBOlrQUy
         CBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963882; x=1786568682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jhFi7CQnq2lpwxjAxXCFhJsj5zt1MWjmEFF/2yQ00QU=;
        b=BK6JUqa+CMX7aczdtTkDftu+tNQ5V4K8ruqXtHI6ZDelWVnNNLQNY7zkctI3duCCiK
         zbXAeE8AoFTlqcrtT7x6jtzD1bo71Hd8EO5wlx8YHpPZbOYJhv1I2QgwTjTsP6a3rnhK
         FMiFfv0uAW5NPRJTnI2dBGYzKkXVVUeT+2crpij2NO9a3WD2eeAVXZoabIpXbxhy3Syc
         0f1Bdr/TC5tuvutDjRIdABkpb1zo1Wi/DvQCzi1r2jDuAdYL29DiC+QTbSJUmbkjf1my
         JmAbWkr2z0QsTgLr+pKBtbha6VjvNm2CKDwH6RCo36p8Q1C26i/6aUGJasArmjQ62xeC
         74Og==
X-Gm-Message-State: AOJu0YzcuO/TjFdN2ZkQjahRBX26nzXC7Pco7ol0AmXahi3BZAPefdQF
	1X+TiTOZSa4hSzgK9tJLVCrU2W0bR7P5B6txnjmIrYbUCjpIhc8gaHJISAU0HBZm
X-Gm-Gg: AR+sD11FtgKXvhAtZ9g8lDDuFfl5JKWD4pDjtpS0qcvCSXNbthrW+h2LpNqsL6rZ8cq
	RcFN36p8ZrKSymwtpQTRenNt7gv0+96W2bpPR7e8/ZcXrFpvVYhPFCNh5okZmIi7aHu0oawyNrK
	XFfYYaHpsiN+MV1o16LhqLwj/v57eBfRoVnQI0SCkgvR8YjH7Gn0WMLZ0HjRkynF0f5diz3h1w2
	gltwA/PS9IW6cV1XvHZCLxHmll5C4xI7OeL/hGZkhEMjs+hXh0I+czlQvg6nTKlCzmxBV4HW8+b
	e3MFHsNrc79Q4an4mOb3fEJS2RI3RZOiXwzb0iqo3fVg+vX+zXQugbfJSIHFDHGmzIjfJ2+CnsC
	xPjXMswWqg5L9eLDU6n91ETvvQCaiu+o1pE/jp/ub02l0kZMyzBCfxrIx0/GpIM6id7S5Kp+Mrx
	8qNq/OuxFdi8pD8goTxvARwo0zuy6RPL/DJWh1AgViwZJWdq1GAY8EdebGRITKYolDwJGkcu1Q4
	z9WleHs8HYkcwykgRSApLpcfRr2mOOVP5W2SkqphKMneR2RQ95Vn4BI4KuH2TKvzwO7SGuozZwI
	GitHQmXyPlM+YID4EmzgUwa2tQg=
X-Received: by 2002:a5d:52c2:0:b0:47f:cb39:10c4 with SMTP id ffacd0b85a97d-47fec510060mr13894293f8f.12.1785963882508;
        Wed, 05 Aug 2026 14:04:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b329cbsm228261f8f.37.2026.08.05.14.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 13/13] bpf: Reject tracing progs for struct_ops with arena args
Date: Wed,  5 Aug 2026 23:04:24 +0200
Message-ID: <20260805210427.3218326-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180; i=memxor@gmail.com; h=from:subject; bh=73ogM+BCbNjrskwR1gxeMnlTg5ha/pC6qa1UvLBZXxk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40TRR294NH0/XyzbsD58+NfG/z4Lu9jIZ51jh21dT6 o24I6s6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJHtaxkZHj3/ryzNGjcvbu6n PDcZP/3aM0eZMqZe3z7ngJTi98JcNUaG/2d17De/aZQ0tD0/nemhibPl/5g5WbOqI4xFF0qctvX nBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Reject tracing attachments to a target program with arena context
arguments. The struct_ops indirect trampoline converts those arguments
before entering the target, so a generic tracing trampoline would
otherwise expose arena offsets using the target BTF pointer type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h     |  1 +
 kernel/bpf/trampoline.c | 10 ----------
 kernel/bpf/verifier.c   | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 00aaa23b4f7e..68ff66787ae1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2367,6 +2367,7 @@ static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_nodes *nodes)
 
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
+bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog);
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b349e0817184..e07af35ed040 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -529,16 +529,6 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 	return tnodes;
 }
 
-static bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
-{
-	int i;
-
-	for (i = 0; i < prog->aux->ctx_arg_info_size; i++)
-		if (base_type(prog->aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
-			return true;
-	return false;
-}
-
 /*
  * The arena base against which save_args() converts the arguments marked
  * with BTF_FMODEL_ARENA_ARG. Only the struct_ops indirect trampoline
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6897b08dd010..60d1ea9a094a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18868,6 +18868,16 @@ int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
 }
 
+bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->aux->ctx_arg_info_size; i++)
+		if (base_type(prog->aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
+			return true;
+	return false;
+}
+
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
@@ -19255,6 +19265,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
 		}
+		/*
+		 * A struct_ops indirect trampoline converts arena arguments
+		 * before invoking its program. A tracing program attached to the
+		 * main program would see the converted offset as a regular BTF
+		 * pointer.
+		 */
+		if (prog_tracing && subprog == 0 &&
+		    bpf_prog_has_arena_ctx_arg(tgt_prog)) {
+			bpf_log(log, "Cannot trace a target with arena context arguments\n");
+			return -EOPNOTSUPP;
+		}
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
-- 
2.53.0


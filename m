Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062CC354AEB
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783305; cv=none; b=GjBvbMpbDwgE+b54nj98OMoj5BK5svxUPffxe0Uqz8LS9Cfr30sqiBa9Tio2rMPqws1jHXyh7wiTso87uTnImkV83/8kn+tOOHUopuQN3uI2XhkoqSHD1VbIcox6gAVDoCndf2I3CzhL9hE34b55uBde8Ide15e4i2r1CHLa4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783305; c=relaxed/simple;
	bh=6bqZd+22Xf1fzGyGKL7tYfyFfGL4heVUaQmArhtQbBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr1TwJz/H0KmwLUQgzcfYEbSmaH1EY/Um2iEm2y/P5Yv1FqMpG+YUvja4/8sX/xGqsCLw3+Xfp69HdzdkYoVj1XQPAGzfdwyA0n3AZqwhNdDThR3jXazWNTZOOvHxfAakIR4HdZTzwWZTp8rtX1DmbMM7G4fK/cSb1C4ZTkwcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5amyxB6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5amyxB6"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb662575d3so141368a12.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783303; x=1785388103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2GWijz5lTHhwxQcUunzqDREhFU36/AbQV/K8iI6ZD0w=;
        b=O5amyxB6riVfILzxNmsnlRAPwXzQFVbjpXOakF5SHo1MEtS/xUJO9gXGgLPRcAjQ98
         8AqxvbW4PnADY7qcBjv+WfG79V6//yHbqG8yidaS6VpBS/ep3UPHKKbI6Wipm3Npkixw
         0+a/K2fnBhLU4h5va62YMgO9O97Kb3DjcBS1qhLV5b7lSbVsIN/HsfQLqlCCXa3Gj8S8
         T0ltmbeCzrekIk5I3iAoCFWhv7zxQiMz2yxpoSqJwFKWyqagd136rpk3sMZrE58SR6BU
         ByKTU7iY8jpgwXwu5cH89fHABWkbxIgrON44Mjashx6YaBWoAVakuUeZNEkbfhpRVpOZ
         3QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783303; x=1785388103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2GWijz5lTHhwxQcUunzqDREhFU36/AbQV/K8iI6ZD0w=;
        b=N4/8oZg7m3ny/JSr8OPLK6eYY8/l+Y411bTlNIF0rltwyXlgTCWjL9cySsdkfNaoYu
         Wn4ClWDKfZWh5uVqk/1qX6EjX7DSbEuQ9EK9sit8yc9837uRazDbE7wdSLSW4R2UpxKj
         w2xKWo7Z/aEMzsEGP0su03VhdhX0CohkpvEL/5dkykD3UkSRNYICJgpTsZ/Ebd4GcifG
         xGiZ7jfAHBbAuuNJCSzKX2R9EbGGnU+Xbql6UqajVPE05OK9SaXff5v3wZN7l2laMeLL
         l7p/zyP4xo+q0ln4Ld/boIBhyQPHgP2tjIMZAp9EM2fUaVwvjgfXxttU5NbimIG0LWFR
         jJ+Q==
X-Gm-Message-State: AOJu0YxOSy7ZH4D7NZhm/Mr0MiUhSZG/qx3RXTZlOvjwOs233HzHzJ/9
	47uZu2W0YS+nFO+x+q50HEUNwfDio0xAqRIGWUWWHFCwGoo9YaFEHV1ArUf/vw==
X-Gm-Gg: AR+sD13X/yg9MZKCD+JzGUeGMgp3F+fPWwr/ZZlZ4FMzqQVvyPNODKdwgVCAW9RMnu0
	fi6ZtSqlxf9TV2P9HXnNw87M1nw9a152tKVmD5Y4EJEscnOuLqYgHvl462T+ojVqMQNYk3iHVZX
	LbCahHD3rQwwgn05Vvw+j0J9r1I2rL9qL8rw4YyziYXI1eU2nkExnqNRm+YvHMuhtqzrE15KdwV
	HNjsBUoJyQLl8k4EQRz7xV83ZEg0rLWy/rZFbdSIKsmAXDrnxXUSoeopWtWkKqW7UL16Y5uP/ZE
	cE5ivW1fej4+l9zxs9o1KQSVJXochjkSQzV5N2+vX5t5hIfwyj8nLUU6aL+OvwylbrWtFehJr2q
	7kowu87/FkbMHO2v2WHADa71C7P20TQWfcYMqRkxpSDLvKuDShfFyv7Xg7n27w8mum/VR9cGKjd
	PVhz0=
X-Received: by 2002:a05:6300:14d:b0:3c4:4297:d5a0 with SMTP id adf61e73a8af0-3c44b1ecdcdmr1641557637.40.1784783303246;
        Wed, 22 Jul 2026 22:08:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f18f08asm2098857a12.21.2026.07.22.22.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/18] bpf: Classify kfunc mem_size args from BTF without register state
Date: Wed, 22 Jul 2026 22:07:59 -0700
Message-ID: <20260723050806.1158442-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() already makes sure a scalar value is passed to a
scalar kfunc argument. Drop the check in is_kfunc_arg_mem_size() and
is_kfunc_arg_const_mem_size() to further decouple
get_kfunc_ptr_arg_type() from register state (a prerequisite for
generating a helper-like prototype from kfunc's BTF).

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 83f7afb86dfe..d77b590e0469 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10801,26 +10801,24 @@ static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta)
 }
 
 static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+				  const struct btf_param *arg)
 {
 	const struct btf_type *t;
 
 	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+	if (!btf_type_is_scalar(t))
 		return false;
 
 	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
-					const struct btf_param *arg,
-					const struct bpf_reg_state *reg)
+					const struct btf_param *arg)
 {
 	const struct btf_type *t;
 
 	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+	if (!btf_type_is_scalar(t))
 		return false;
 
 	return btf_param_match_suffix(btf, arg, "__szk");
@@ -11354,7 +11352,7 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static enum kfunc_ptr_arg_type
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *caller,
+get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
@@ -11368,8 +11366,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 		return KF_ARG_PTR_TO_CTX;
 
 	if (arg + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1], get_func_arg_reg(caller, regs, arg + 1)) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1], get_func_arg_reg(caller, regs, arg + 1))))
+	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
 		arg_mem_size = true;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -12100,7 +12098,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 
 			if (is_kfunc_arg_constant(meta->btf, &args[i]) ||
-			    is_kfunc_arg_const_mem_size(meta->btf, &args[i], reg)) {
+			    is_kfunc_arg_const_mem_size(meta->btf, &args[i])) {
 				ret = process_const_arg(env, reg, argno, meta);
 				if (ret < 0)
 					return ret;
@@ -12145,7 +12143,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta, t, ref_t, ref_tname,
+		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
-- 
2.52.0


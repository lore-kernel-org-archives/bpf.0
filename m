Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00933CC9E0
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304493; cv=none; b=gTgUZBk/bWxc+QJwK8cWoGWAgfOPdNxp0IConDEDS8bXIkse0fLdoiXC0c6Yd+COuOwXaYSQVPGncMP0UDPTnAkeFC2FUy7Yk2LGINZtObXFjXRwzjeYyG2QJpSe6OFOaBFXYd5aSXOC8BlWmSJsoowcmXJvFlqs3+mGl7g3grM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304493; c=relaxed/simple;
	bh=pfSg13fn/PEzGh+Ms1LZa9+2WDu7wDYLFdg/yrRJD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeBMACmmNxv3bsy0o8n1PY2lOWSlOVnJq6UmEjh0RlwyXAU6grYsRxCoBT83v4P0/RkkmvAFCmCm+ouo2dbMjGh7eauiYlw/AxYzR4c81tXOHjb89U4mTAVZjTngdI11Xd/pOr8ckFGNaLUu9jb89LKd/wsIP3ItnDnc2NAiJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=29mjR3hk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="29mjR3hk"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50336cffef9so28050591cf.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772304490; x=1772909290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n7xEluV7jVEgZP+6IBLPft9A2bQkO178govlL6jwxQ=;
        b=29mjR3hkL6f6h6yrYVXuM3czOWgkzV/CM7GeLJW/QDb7XlhnqB6e+MJyq6iK58wQd6
         lT125X5POA48KcTs+Qi0xUkwisxTE4Z8ZZjbtXj1S74IFLlpJarr6RVNBPZqwSlArnSt
         ATiSBjspIg6j9pXtSbFbCtq51LGBNEWN4PXu47Fzj6iz+j4HSnBFF6mkxRbDIw2aJNbM
         BdOWNI0d59CvDXQx8ShxPJYDhahD5kw+NrHVL6gj6DF+yYTblt35fVe6qEtNkXLKS+Vl
         d1hDz5/PAcxLcoIDlntnDm5I8DlV7EUTSv7E1OYeHGU69ooiy8E5GbqKLziPYTNDr5v6
         zJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772304490; x=1772909290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9n7xEluV7jVEgZP+6IBLPft9A2bQkO178govlL6jwxQ=;
        b=cC4w547x8q8Z3niI9TJItxjkHEj46+JuFaJplyn6Mkl+o2vpua6jrSr6Hobsv5Jj+H
         XkjwgpT9Z3yf8hCFUUDx+7uj/uz95mLrZi+DpRRUzJgZ6mRIKm/9cXyfMljXz4dq0XqN
         DcrJSCUT+RNmqRci3UCeqdhNI8NYIgDMfreJRc6yeo5tldLslVqFmRz04B3JbjB6X3yH
         uCrpQqQIG38OvnRMoBrnqjPfK/b6mCZpOEOAU7brUGkGh2YC83ItiW4tjQ7aM+d92Mkz
         /284aPPpjsRyEtnhc1+oFItBc3excF0ItKBkGa+H1Rgxvuq4FYavmiPeXccaiuxBYtd+
         GPLw==
X-Gm-Message-State: AOJu0Yz64RU/v/GfiWOnM9RAAa/RNsK2oVc1Mx2fY2vUehtmEdVePk2i
	C83t4LMc4BLQU7leqnicLPlO1V5bzq+pKCw4yUBwfEcqxLm9JfB7Plhb5fb/0Jq11GttIBCm9TQ
	xV03K
X-Gm-Gg: ATEYQzyPu0aMa5atUnOtQGKou6fuFKKmTaX+01z3p7gnQ7iQxh6odStcRGtmM6w9Y/N
	oBpWrz5vT+k73HZPfgWZq6utgX5BvAaFxMXjJrGLYzxLD/Pb+F4nY9/mU87y8+ZXMESCORcUWpL
	gKbuY6V0slVDxCIClZPnzwLrSksxPz1EBjXC84/+IiokCm+gzSB3BNOpTeBRjLyyvQ+jdKXvpJe
	+dGdhEFAGHe0tB/iXz0QQggiZrl1hqLwsb3GnTOtjcRjPg2Nhy7XiDAC7tPfgUKZW81m/O01ODV
	xw/a2II0BpnghAFEB8fgLU07uanN+ZpDxkL1VKrCmRyFFbDhW/+FNak8u1qnmfLI7CAinRZUeMD
	NrgRZUVr++2I352rbUQoQcx8vE4xSmbkFdTxZisOJpdASvVgPtlzymajgohwHIU+kHrEcVkZu2/
	EtAasxLBpCdMIXIQsvAgdxTQ==
X-Received: by 2002:ac8:7d4d:0:b0:506:b77e:5431 with SMTP id d75a77b69052e-507529b9984mr90520381cf.55.1772304490409;
        Sat, 28 Feb 2026 10:48:10 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3d88sm76160561cf.21.2026.02.28.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:48:09 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 2/5] bpf: Extract program_returns_void() for clarity
Date: Sat, 28 Feb 2026 13:47:56 -0500
Message-ID: <20260228184759.108145-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228184759.108145-1-emil@etsalapatis.com>
References: <20260228184759.108145-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

From: Eduard Zingerman <eddyz87@gmail.com>

The check_return_code function has explicit checks on whether
a program type can return void. Factor this logic out to reuse
it later for both main progs and subprogs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 64 ++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0847d2b1fa5e..80b6fb821456 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17912,6 +17912,28 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 	return true;
 }
 
+static bool program_returns_void(struct bpf_verifier_env *env)
+{
+	const struct bpf_prog *prog = env->prog;
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_LSM:
+		/* See return_retval_range, for BPF_LSM_CGROUP can be 0 or 0-1 depending on hook. */
+		if (prog->expected_attach_type != BPF_LSM_CGROUP &&
+		    !prog->aux->attach_func_proto->type)
+			return true;
+		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (!prog->aux->attach_func_proto->type)
+			return true;
+		break;
+	default:
+		break;
+	}
+	return false;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -17927,35 +17949,21 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
-		switch (prog_type) {
-		case BPF_PROG_TYPE_LSM:
-			if (prog->expected_attach_type == BPF_LSM_CGROUP)
-				/* See return_retval_range, can be 0 or 0-1 depending on hook. */
-				break;
-			if (!prog->aux->attach_func_proto->type)
-				return 0;
-			break;
-		case BPF_PROG_TYPE_STRUCT_OPS:
-			if (!prog->aux->attach_func_proto->type)
-				return 0;
-
-			if (frame->in_exception_callback_fn)
-				break;
+		if (program_returns_void(env))
+			return 0;
+	}
 
-			/* Allow a struct_ops program to return a referenced kptr if it
-			 * matches the operator's return type and is in its unmodified
-			 * form. A scalar zero (i.e., a null pointer) is also allowed.
-			 */
-			reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
-			ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
-							prog->aux->attach_func_proto->type,
-							NULL);
-			if (ret_type && ret_type == reg_type && reg->ref_obj_id)
-				return __check_ptr_off_reg(env, reg, regno, false);
-			break;
-		default:
-			break;
-		}
+	if (!is_subprog && prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
+		/* Allow a struct_ops program to return a referenced kptr if it
+		 * matches the operator's return type and is in its unmodified
+		 * form. A scalar zero (i.e., a null pointer) is also allowed.
+		 */
+		reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
+		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
+						prog->aux->attach_func_proto->type,
+						NULL);
+		if (ret_type && ret_type == reg_type && reg->ref_obj_id)
+			return __check_ptr_off_reg(env, reg, regno, false);
 	}
 
 	/* eBPF calling convention is such that R0 is used
-- 
2.49.0


Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434E41A919
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121141; cv=none; b=pl2JYKZ71XhUmdgd4fndaDmDIsGJ/x4zN14paPZyENIrmeljQXyGPGxFmtGq/hmEpaRAiIXmhMr1kvHxG0hWohGh8dwgCKEoDzziggg4sn9gOxDKl3CFnyBX+pAgkje1d+OS3OQLp0b+QonxPUGsiaB95usaenMhYVeEwk+7mRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121141; c=relaxed/simple;
	bh=l/dzTu5cE4Bey/quqUzqPOFac1I9mKoIJG/gVVdxZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO78VlYYb604CV/1QxGrW5Tvtb4DqjwJ6JiradOGhUrxZCJGVR3IZ9zZDD+ArXNGCP10EOGviHXaCmxGElMbCUADvCYL4aKPviRRk6UPRhhBGruJWJqpZTfLqjovSLqESgRF5OBTwS81ggHGW0eyC+bWAWX9x3HBQad/m7Bs+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNKRwmww; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNKRwmww"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09dso298314a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121140; x=1791725940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=saHKoLqZNZ2EhOZG2XXWYjluid99iSWA5z4Ccp/T8yk=;
        b=DNKRwmwwIyqLJ2C0SUkVsslV/SrC5KhJwT/pxjzLNwrcPQ7OHo7FcKGR22SGVt6CtL
         tuRuLAsj234Rudwz31cji/xCQGd/s2tP50bkhEwzZBNf5NdPzpcqVqjySt2jcqleff7j
         ktDlWIlz8dMgqTYhaWRHgW2EOOC7kx7yKHy+hVeHBdAYD0E7FNzaZeu2rRgBKtKPvtxz
         uqWWguhGZuNvbIhB806qB7R2p5Ii9mXGDB4koCQoVBNSrzGJu+flpKw63pg/fELoJL0x
         ppr7yIkSSg2v/ZZ+GFDaFx+J7xU3kjQvEoPg3kNktSPExw3FKAtGSho1j4t3GVZrh9g3
         Yltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121140; x=1791725940;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saHKoLqZNZ2EhOZG2XXWYjluid99iSWA5z4Ccp/T8yk=;
        b=Fwwa7+88aD+svKTxZJaY+yQyUwWl+rbN+jyMMB502zmiuIePgVN7wEvN2tlxV6UIxP
         chI8kmhRkyM+asPgxiyYeStEJO+5rvqr/L/jpAl1ENVzn8DSotkn+8Hi9EgfrAXZL+6P
         nBM4KvhnKhEaEVcRz/3HOCCJWgzq3ezENHkhEfPxiX2hKMt8xgE0sro6B/yljlRwcKiR
         ZXPuNppKF/7hUVunws3bc/ZI3+DXgFJhFBUINNJvBCCsjbmub/E29bLi9KoQnElBph+E
         jx3mHPmZrI3uY0yVHpPL8nvjGUY+DXiRlRwo13wtKkB2zfNcWU20iuYFKXCMV8b5CiIh
         B7dw==
X-Gm-Message-State: AFuF++k6lzVcelav5xeE1J7NlXwJvyc2aU8qAzgJQ2j25nTPkQO1Tv9i
	eGIzxER5BmUZdOhncjOTOGQOcLIALCO1veDAr9U9VhYlH+JjuwmzvNm1ZUyWAA==
X-Gm-Gg: AYBFou0MM8VxO/CQeieansipSJ/Nim5QBWoy65X7f6092ui2ZERAc/8foS+IDEZ9aS0
	yF0TljLfl/fnROR8J9E/8UV1ZdBS5HITeq7UT12PEg1E0zWybovFZSDK8ZCfDmM+IL2BN8fvtsT
	0hvND8m5PdGkzoFUeyFD4Cv67sb1ys5HXsqQ+gGynxA+fhKCSGRq66jEraOASUqzkzv6i5RsrZo
	kkXd6OsGaG/6jUF3JUIc7YiOwx5bH2DhzYLtw0FFAxQR2mtRor1oBExq5jyc1W6Zg6VIlkVTLPv
	/F7ayid+t3AGpMjfb8DbQXtj7AM2l5iUarLGDVGxRWv1EhA+GW41ARxxQEANJj2TjzU48zvSV17
	H5P2h1tnKcETwfwtftNxn3lNFUcMdFQbi0BRfGVZ5o99T3uS2w/fHTFcvex0cD9iUt+EerSehCC
	FzFl0kRVBtMQ7J09nUWEUjAM1g8KjBnwLTZCUySLuHADWmEojLnCqjAs0W7rpm8NdsUXY5AdjN3
	c6Uthn1toUVq+o=
X-Received: by 2002:a05:6a20:d74c:b0:3de:7854:854a with SMTP id adf61e73a8af0-3e0bcaa8497mr8129416637.6.1791121139787;
        Sun, 04 Oct 2026 06:38:59 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 26/43] bpf: add bpf_same_memory_origin()
Date: Sun,  4 Oct 2026 06:38:08 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-26-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When dealing with loops like:

  for (ptr = ...; ptr < end_ptr; ptr += 8)
    ...

Scalar evolution needs to know if ptr and end_ptr identify a same
memory location (possibly with different offsets). If they do,
it is sound to attempt to infer iteration bounds for such a loop.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 13c7825bb8b5..7e858bb05dd1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1814,6 +1814,8 @@ struct arg_access_info
 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int arg, int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
+bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
+			    const struct bpf_reg_state *reg_b);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 base, u16 step);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28c16e35b1f3..9e1c08caa0db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17153,6 +17153,51 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Many checks done by this function are quite conservative.
+ * This is because main verification pass does not maintain
+ * enough information to track object identities for some
+ * of the interesting types, e.g. PTR_TO_MEM.
+ */
+bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
+			    const struct bpf_reg_state *reg_b)
+{
+	if (reg_a == reg_b)
+		return true;
+	/* Require matching flags and base types. */
+	if (reg_a->type != reg_b->type)
+		return false;
+	/* NULL can't be compared to some base+offset pointer. */
+	if (type_may_be_null(reg_a->type))
+		return false;
+
+	switch (base_type(reg_a->type)) {
+	case PTR_TO_STACK:
+		return reg_a->frameno == reg_b->frameno;
+	case PTR_TO_MAP_VALUE:
+		if (reg_a->map_ptr != reg_b->map_ptr || reg_a->map_uid != reg_b->map_uid)
+			return false;
+		if (reg_a->id && reg_a->id == reg_b->id)
+			return true;
+		/* A plain single-element array has one stable value address. */
+		if (reg_a->map_ptr->map_type == BPF_MAP_TYPE_ARRAY &&
+		    reg_a->map_ptr->max_entries == 1)
+			return true;
+		/*
+		 * The rules above can be simplified / relaxed if:
+		 * - fresh IDs would always be assigned for map-value lookups;
+		 * - direct map value loads would always have and ID of zero.
+		 */
+		return false;
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+		return reg_a->id && reg_a->id == reg_b->id;
+
+	default:
+		return false;
+	}
+}
+
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 base, u16 step)
 {

-- 
2.53.0

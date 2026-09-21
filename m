Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59530E838
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958346; cv=none; b=MeUSKrEwxoaJFu4PZ7r31DYaGQaZWLknQwxWBV9z8U784uAIDTSEoOywa8WH5Gs1FrblXhLZbPfc0W/suQs2tizLkKfpuNm8HaPhBlwUNPu0AKqh8oni8/Q0cg1gFfwK+MnPNSSCOWSkeHKm2PsabpRI/FdRvoUCiMQCNRT7QpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958346; c=relaxed/simple;
	bh=HfxpLlhXDYLlKoHco7BTajt+0mykRR4uHLvOjH0w/RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN7U9WXhSIMoLycWx1uhl5th3V/kDzS+m9eTRvUfC6NpZ5eeFXXmIZGDa80GbA+FsWc6mP/HeAiog3APpg6Bll3FgbcQ3Pbybb38clIN97/BreoLMp3kSmlwJh7yg02lC70jN9iQMUp7bFALCmZOFYOi9jikgBgvb1mbikpsMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/czRByc; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/czRByc"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49814d35686so1139725e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958343; x=1790563143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+eFkr1T0HXaLjJgVy8FI+UsJJdAfLhWQUXMI0Qge3o=;
        b=l/czRByczBiDQkj7Ez4DuQBQVQYWJp4jd45JnOSePpCtiRBt+BEO1bccGh09KBGiDh
         etfN7bHJiyXUJHl7C3ua8Q7h/9L56KBJrpkN99SYv7CprWzPhTPwKKRU9sUHM+8rTicm
         DNyt8w6cyN1i+mwndWOWgwYeHSyalsehYPLUSuItg4o4h7z7kd1ZAFw2N/Ik0/uXlluZ
         pPdrGG0EsoiaGXxM3VptrViURZ6X9/cbEQa1bbopYvSzXitvNKb8Bkc0+b2is+QqUoJt
         RAm/3kyvVRspUqmMzIYjFO02eZEtJDQR3unBEnr57mHX9s8NdMb9Ezc6CsZBjjIrqIwm
         bBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958343; x=1790563143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+eFkr1T0HXaLjJgVy8FI+UsJJdAfLhWQUXMI0Qge3o=;
        b=bQr/HQ3IS/pQOwm7BG+9RnIXlMLEh4xvqe+cj9ipHRRJvc1FAdxGXQLaiLbsTE+S9C
         Twy1q80uW1/M9021F5U+Cf64BNhR7Vt1JGDF6i8hbJFLnWRKLuokgOnQ6kqYuMMODRmx
         RlIOJlLoYoZ0NYp2YkQnq7yaNNBqciV9wD7cOIPYokyEaAQShgH1QDGQonyvNXY3U3lf
         sTCylynwZc7rrp/niQHqa0CG0ShcIqKOsS0kpkBNY+snduDyMTLXq7iFzcOQjCtSls78
         WMGwFHPvOvczMXjjQS91flMv+biFwhQ8f2Cx3dzxkjB+b/IU4hoqq7p6P/e43tSfOTAT
         x1Wg==
X-Gm-Message-State: AFuF++mi1pGmRvxk+DskdXWmJo3Hwi+PHXilqPvCrA7kFkkpf/QxtCWC
	4d5S5iOzZfMEyo29oecqHk02VyPaOaAR5YNNVsweQ1T4MJlmHfHw0LeQ1CmbauEO
X-Gm-Gg: AYBFou0+NeHmLAoHJSw5KR5VUVi4wrYhDUrOTJPNHJ8MsRI3rFxHDsow1bLMc6J1zNY
	Sr5+5tLhtuHJ687xloYv6ozbtcwMDucLnKNq2FjfHIEimdPp8hsije4J54k34Qva/6ZZyp0Tb5B
	Ya5pLv/y8ND8JRIBxW8833aXPwjEAYvvDNM5cvpTNkX09l+CkXlxFgoxJj4u67WOJ7LsgVtrcBq
	5GTaQ0pMKq0hNL8PwOZA0stG9RrubUNcjd48Jyh5G9hP8HyNVlIyFwNWv5hSZcEnk9j3J7lGxpF
	YcMyKTPa8fGFdTUBECq+2Mh9pukdJ/PdNSCHSweWvyOIq0kfXtS4oc3Ala2I1+Hpw48TZ0SlQ8S
	jo0cokEd8E7uNsShzFl8pxB11Enby5Ef6qjz8nSY/h/50ABgWZO62rSAo/zSEQd2enZLvAllYjy
	/UEIcPoIjWpb2Zilmgs79iOZf6DijcGa8WS2SqigQZzFSATQCeMkaqf5j1//xR8GgK+9bIjj+gI
	sN3ZmG2NOJ/tsYf3W7CYIZPBxxwQtZhKoj2+l3rtGlLcei94bRShLQI5xklC5GGDhndcTXzizNl
	syL89ANgavwIRBbU+m2yzyPmQnV6DtcM81FBnQ==
X-Received: by 2002:a05:600c:c1c8:20b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-49fc5aa9f08mr93344475e9.8.1789958342972;
        Sun, 20 Sep 2026 19:39:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd068059sm200182415e9.5.2026.09.20.19.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:39:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 10/11] bpf: Check read access for helper input/output buffers
Date: Mon, 21 Sep 2026 04:38:34 +0200
Message-ID: <20260921023843.411943-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916; i=memxor@gmail.com; h=from:subject; bh=vBQcRrB9dkFmOdA6M6Ay+H/vkUc0XizxjNP/72UKaxA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9K2FC/6ITbugJqroe2FDx2Pt4AtxdTn1qa/PGvR+f TOhuzO7o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5/5nhD7frLMm2N0ui7Hu9 L1lwBPUcqL/OtOXVtWPWP3cnnLupuZORYQGH7TWZ3YuK9x8Nbr92YIusWH/aeVvZyMpPGzNXMay K4AIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

MEM_WRITE without MEM_UNINIT denotes memory that is read as well as
written. Helper argument checking requests only BPF_WRITE for it, which
checks stack initialization but omits read permission checks on map values.
For example, bpf_check_mtu() reads its mtu_len argument before overwriting
it, but the verifier permits that argument to point into a BPF_F_WRONLY_PROG
map. bpf_fib_lookup() and bpf_load_hdr_opt() are affected the same way.

Derive generic memory access from argument flags: read-only for inputs,
write-only for MEM_WRITE | MEM_UNINIT, and read/write for MEM_WRITE alone.
Partial-output helpers such as bpf_snprintf() now carry MEM_UNINIT, so
their write-only map destinations remain valid. Generated kfunc prototypes
already encode the same distinction, which retires the kfunc-specific
access override.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7f1cc115456f..d62c0f74cff5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8907,6 +8907,19 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return 0;
 }
 
+/*
+ * MEM_WRITE alone denotes an input/output buffer. MEM_UNINIT marks an output
+ * whose incoming contents are not read.
+ */
+static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_type)
+{
+	if (!(arg_type & MEM_WRITE))
+		return BPF_READ;
+	if (arg_type & MEM_UNINIT)
+		return BPF_WRITE;
+	return BPF_READ | BPF_WRITE;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
@@ -9199,10 +9212,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (!(arg_type & MEM_FIXED_SIZE))
 			break;
 
-		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		/* Ordinary kfunc buffers are input/output; __uninit buffers are outputs. */
-		if (meta->btf && !(arg_type & MEM_UNINIT))
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(arg_type);
 
 		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
 		if (err < 0) {
@@ -9248,9 +9258,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (meta->btf && bpf_register_is_null(buff_reg))
 			break;
 
-		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf && !(fn->arg_type[arg - 1] & MEM_UNINIT))
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(fn->arg_type[arg - 1]);
 
 		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
 
-- 
2.53.0


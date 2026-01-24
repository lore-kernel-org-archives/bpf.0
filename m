Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499653EBF3C
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225538; cv=none; b=RzI886+MLPvH7oywuQZ8Ec5QvTLEeO/JyKFQtROkKUmAkkJ/JHfcHJGJwdiTR3ZAS8rH06tVzFWABcUBTSFuOaQtuR8d9TFKWMQAviRYglh9cm9/+isnaz42q1tkK/sIv3bLMlPCT4Pw2Z0f3kM1DtOxTbgmVsBixjfbBiTlecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225538; c=relaxed/simple;
	bh=kjcr3U+Eej2jkvLdErMnd6YR7FAn98KttpJB/4PZM7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJgtNsLjxevI+DwuLrBWU+3D2YN2JwQKsWA+22q68139nTgQAamPFkZTPk9q7iWc9wm5kWFyNZNtP1V/1q0aKPVK5Gjh3c/ZCEOxyZAdpvstRVsgcfxQWWdYeSIKVKaiQqgZzl7ENXAcFXqRCeLJV2LN1Q6cRVT1oqlTcbeZOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS6IdWkj; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS6IdWkj"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a7bced39cfso31215215ad.1
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225537; x=1769830337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRFPc/7UJMwRjQVl87T1d/8z+6sYjAGIhOZdpUb7X2k=;
        b=eS6IdWkjCUdqG9J8pG3uEMgxQGAr9KOVpwPoKUHj3GbIh90zP22hIvD9YWdiCsnzPs
         wwY8fwoG7Nxhjs6dGwGX9lbqdO/BYvac69UB5pEyq3OYo58R97ZPfOlcLCHPbPMAk+UQ
         qrQRaoH/ZnfGtgrFsrLT7tUGX+F99dfj+vHVBCL3qmHfSP36c5rsP/3YZ8rmtAqfjdX+
         IIg8JtbMMYpgfFYq2sKb//pOECAevwd/pdMsaR7gslVsa7VqOxjk0U/0Fq/vyTrJV7lf
         74vJ9cLYvKzUE2A59yVE/r7CllnrkmCOEM4/awtYKEaCGFgjtDxyAwAzign7SSkyRFdV
         9HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225537; x=1769830337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRFPc/7UJMwRjQVl87T1d/8z+6sYjAGIhOZdpUb7X2k=;
        b=mEZXgFffBkBwABheKDxMInOLdJ9GCIX95gMuoX6GNw/tkI1uuOcOUO3b5e+Isulkog
         aDug5qo6m5YUj3R16fUzJoSKgf3DysYL8bhXziUWD4jqWjRy4gp7Sfbqy06b/n1yFAkb
         Q2DKK7E1QeB4nP8uvGAnrPrkQPw1nLVz7qlBI5LqcLJmSXYyTcpDpJiWebYPQSxPZENz
         7jjml9cC1L7cCpXz/u8AvDarCkCdZB6lptFlSJGs1D7ggKebn+eAKmP9/5edIXVyx2bL
         othiQbSalYDIFtFsMkr6MUdDLEP/nFbS5RcVD5PKKPMyTWJsAQLabxyr9TbPq04YYFbr
         SsfA==
X-Forwarded-Encrypted: i=1; AJvYcCWfq1B79HMDcA0aqRDS12TiM9IecQDCl8q0+lzVVoUG3d6wJQet83ADQGcOVIPoSSqtQ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05Uzo+mgfyJBpFyZvT1h0h+xPKFFs8Dh/+iZgHCwA6+OW7UEW
	l1/7znQFv8B14G++BrSAQQ4sRC1aRF7EC+Jy659x3igCCvZ/EmVKCSOt
X-Gm-Gg: AZuq6aJQO8IVTH/y8tG9CM0w1vUG+dfNC7C2k8olLTQPeEsQM8tkpANnhUGx8xwNfu6
	EubSJqPIgcgJZRFQ6y5dkmNxvgCXQ/vvniIQY3mBgWRAefGRVgC6dKwd0He/mkbC3fAZkBPV7Qk
	xlZ7rzBYJmLecbhpXlN4GdsmXOic5tuWttzLv8LPtK9H4V0gBmgOlRqFEDryh7q8QhAEfPzkmR7
	P6miuomAy3fFmXTUuB+N01G6c0LPJuN41rYyusu9WG0wJHEfsgVuQ2n7iTej0FpKbYZRPehKx05
	IsjpmZEkfZHCeEfHzJ6CIawNsGC+ZCG7qw+H3vndBDgQROElavQISIUI94a1wUVcogajsiMP2q5
	RCfC2jynEzs6YXW7TkdbC+FXpCd5LvmTerSrm6Lev2gHL0V7LPd2020mupDoSSPbklV3CMf6yaR
	IlMjMs1OAB
X-Received: by 2002:a17:902:d2ce:b0:29f:2b84:652b with SMTP id d9443c01a7336-2a7fe625ffemr60090195ad.29.1769225536593;
        Fri, 23 Jan 2026 19:32:16 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:16 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 05/13] bpf: support fsession for bpf_session_cookie
Date: Sat, 24 Jan 2026 11:31:11 +0800
Message-ID: <20260124033119.28682-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement session cookie for fsession. The session cookies will be stored
in the stack, and the layout of the stack will look like this:
  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ip (optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

The offset of the cookie for the current bpf program, which is in 8-byte
units, is stored in the
"(((u64 *)ctx)[-1] >> BPF_TRAMP_COOKIE_INDEX_SHIFT) & 0xFF". Therefore, we
can get the session cookie with ((u64 *)ctx)[-offset].

Implement and inline the bpf_session_cookie() for the fsession in the
verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v11:
- rename BPF_TRAMP_SHIFT_COOKIE to BPF_TRAMP_COOKIE_INDEX_SHIFT

v10:
- describe the offset of the session cookie more explicit
- make 8 as the bit shift of session cookie
- remove the session cookie count limitation

v9:
- remove the definition of bpf_fsession_cookie()

v7:
- reuse bpf_session_cookie() instead of introduce new kfunc

v5:
- remove "cookie_cnt" in struct bpf_trampoline

v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h   | 15 +++++++++++++++
 kernel/bpf/verifier.c | 20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 29eecd79352e..4427c6e98331 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,7 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_COOKIE_INDEX_SHIFT	8
 #define BPF_TRAMP_IS_RETURN_SHIFT	63
 
 struct bpf_tramp_links {
@@ -1782,6 +1783,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_session_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2190,6 +2192,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
 	return cnt;
 }
 
+static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->call_session_cookie)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d04aea235a12..c2f2650db9fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14406,6 +14406,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -23024,6 +23027,23 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline bpf_session_cookie() for fsession:
+		 *   __u64 *bpf_session_cookie(void *ctx)
+		 *   {
+		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_COOKIE_INDEX_SHIFT) & 0xFF;
+		 *       return &((u64 *)ctx)[-off];
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_COOKIE_INDEX_SHIFT);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


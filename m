Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288434;
	b=xBvoWdo9ZLH9T0CdKPsoZvU2xp7dZ5IVhB0COr3DJbdY2Gfs9M+AEp6LnX5FBqH1NmGh
	 GlfmftBQcM3rVF9INgCbtP3e23/F8INnysMD1wS8CSNDJ9Lkbg6+/dKoM6EUM4ppBdt/z
	 n9XAoltqnFpYQ9ram4yNcc56DaTKR1gwdWlhbHwpjzAxajB27MB4yGOR8pVfG4gSSbnym
	 DsDlCwSjsQ9yfrjnjYRl2jJJRXngHJjUjjQavjOZQJUj09eICafMMI1iGhtSeo/2PchrO
	 beXBIRMOWVOad2twtd+YCtf6L7LCXfst6j54bV23gdCqdxhVmoAYMsAPjRJQggCxuhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EItnk2TUiYkRHAssZpPJnX2nGrmzPiOHtNCjtj7gsa4=;
	b=DhMwyvbSExDBGTDN25k/dln3HQopoYlmiiyT+b0oo7C3zwXOnLwdhTBoZsNBfc53d5bo
	 todnlJwpT0yXsj+Erh1xauUpnNBZvVzSAWz564gn93tzJNFW4m5BBrkIvmnK0+YBK2qIn
	 SPI3YtjFOoFVKM0p30jbAo265yPxKonVNPkzSCMfFu/dkX56lIKKMXx9Mhzhlg10UFvp4
	 RCZrpaagbDPJN0WsomhDBohJfv3Q9fq0yN2tuNQ0oNsUibtz++pvTMO+mOLRsx6d+Xp8A
	 s+AAGIOw9zrwTc2i69A5pk+O4td3J3VwmN1iN40b8GlyljPchYz9ucWfuiC8UwZzPMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSfPbtrR;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D155606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D155606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSfPbtrR
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1044167b3a.0
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288433; x=1795893233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EItnk2TUiYkRHAssZpPJnX2nGrmzPiOHtNCjtj7gsa4=;
        b=uSfPbtrRGLsQw4mppo4F03Wf7Lu6ZfIIWNcKnfZlbapbAIATNqSTlWHmgQ8pHUL7bG
         6LpSjZQDOYiJ8hkWrGV+22w5CZlfsJAbewOoTReNbZ4+pl1KJI49YmMPU7zWKoRT8bI6
         iza/w4LXvOt6uN5QGXk0RAHqeJqqEqVK1GCFt/jjIl/pgAaVEidaLDB9r+2ixJMBK9y+
         r3DL16MVxlHIwgb8T1hUVzcd7KNABynlYdWKmqTPdkVb3/xOol3fLaNVWA/i0bgpImaz
         zE8DOtXKrYsW27xPJJIS+bTw62IX+jIdJ4gweQz99mh5A6W0ithcR62t+0cR7UDtXDUN
         +A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288433; x=1795893233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EItnk2TUiYkRHAssZpPJnX2nGrmzPiOHtNCjtj7gsa4=;
        b=B+r+JsRL7LOzIXqckFllRcjqBTQrbm3+OuT/B2FVdidgS0FYBvVVVhC3g70BBxwewl
         VCpaVa4gfQue2k/14rD4ubbqtvKhRIGTCRptL+fnpVW9c9EfwYC3pZKYQ7sSZhGc81Rj
         ZxJ22vXhL/maTxZJr6IEo84AQ2iQFP8Ukz4MIQ4PIhXr9NB2tjQ6ttmVr6qxQRpFTtxd
         E0WeiIIarjrBHyTMfTeNV8H/6Ek4/B3F7jyo5ncPYaw5pvTA3dfjWO/2YBWcQRl0R3Mb
         TXl/Qp5uR3lpChUFlZVRLt1fTc0CL0+0BilcbpVLWaKg/xNsmph1xBmWkLNHj4WC3mRM
         EGPQ==
X-Gm-Message-State: APuU4Z+ieJ05WaPNIuRrh3cp3g9VfHlL8W5XNA4hU/4cvQMXqTVRMrL6
	0bTwQgtDOPcYxHvFQomYRG/zZOXtv+FGwRn36naPGSojxvQja3ZxMm/vFuzblA==
X-Gm-Gg: AZFdTZcDaUTAIwhpmqxCK0uhZCTuaXiNZURVyps48U3WbZCyZrolcnXzT/SyDsSuHe7
	QAzMdz2eL30cgL4Fw1G+0gk5roSOqdx5DYo1KNdmkZRbQCR4YN6hshjWbUbAbK9RjThaTxWeJ5W
	HYAC5I3W2rwcPb5Sotr/KcABIcoAkmuhtaTmHmgbpkLOaRcUYMjOcQ5mIJsTPP4xnpXrDWgUINA
	segSUf2glsm81tjg7/QlYml0DhlUBFxrKD0UE26U/u1YEibkklEh1pMsmiVBmgq1VdWGoh8PLyv
	fBqSfFjy7+oAMo4uqptLLzY/b79xQmZWaRALqL55chGsFAbNCroHBA6/zuk8NLHNHdctqMdabgy
	MNJnwx4DX2QaNhw1JGH56/mPmm42j9O+cJ8sDOajaSIkVaO3miDR9C7m0CfBkyAP33Hr7imq7nr
	em9h4UurqNGYySkR7tQu7IBXOahm8iAZVufm7OL1liSNG1vKqlIFi+kgpGTdgzMwzBJMzqvQwC7
	pW/1MoabcfMFnwsLRxrHgpG1AbZE/GNoo51OhJQm0KqS6WFp8AMFPErHFi8jePPuZZ/MAfwNAkv
	sM78lwtUi2BqFpHTqyPVAYUG0z8T0m29nqjtKmNn3TBwaD13Wp7X/k1WjoHT+0i4IeouS7jl447
	VnBTwozhyiJM86juX89Q/IOvFsqba4mp22nO0jBvuv3HD6Qh3OI1Fd1oLVnpv8TKJc6qND1DzBP
	O7aa+h/pbzCvTLWFz/gIY=
X-Received: by 2002:a05:6a20:9187:b0:3e2:b15d:56a8 with SMTP id adf61e73a8af0-4014de5ba17mr7389421637.50.1795288433070;
        Sat, 21 Nov 2026 11:13:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0100ccsm2815011a12.17.2026.11.21.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:13:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/7] bpf: Fix the build without CONFIG_NET
Date: Sat, 21 Nov 2026 19:13:36 +0000
Message-ID: <20261121191343.3670609-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

offload.o is built only with CONFIG_NET. Without it the verifier links
only if the compiler removes each call of an offload function as dead
code. It does not do that for two calls:

  undefined reference to `bpf_prog_offload_verify_insn'
  undefined reference to `bpf_prog_offload_verifier_prep'

Add stubs for the offload functions that bpf_verifier.h declares.

Fixes: cd97aa1387d9 ("bpf: Do not let a join raise what a program requires")
Fixes: 09c84023b0b4 ("bpf: Verify in passes")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5385075105..7f9594436e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1663,6 +1663,7 @@ static inline struct bpf_reg_state *cur_regs(struct bpf_verifier_env *env)
 	return cur_func(env)->regs;
 }
 
+#ifdef CONFIG_NET
 int bpf_prog_offload_verifier_prep(struct bpf_prog *prog);
 int bpf_prog_offload_verify_insn(struct bpf_verifier_env *env,
 				 int insn_idx, int prev_insn_idx);
@@ -1672,6 +1673,32 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 			      struct bpf_insn *insn);
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
+#else
+static inline int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bpf_prog_offload_verify_insn(struct bpf_verifier_env *env,
+					       int insn_idx, int prev_insn_idx)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bpf_prog_offload_finalize(struct bpf_verifier_env *env)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
+						 struct bpf_insn *insn)
+{
+}
+
+static inline void bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
+{
+}
+#endif
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
-- 
2.55.0


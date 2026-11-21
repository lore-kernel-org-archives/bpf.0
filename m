Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299233;
	b=feHE5rEEhgKZsn2lEFLDodgxg0Pvmwg9+Wy/YirLBy8IJHXOO5W4oa+nYKfa3csGceFW
	 KUbDor98maEjDm3DrpmD3kPwyICyg49m2biCuCDKqXqfhNM92uzln3XNN1XHmZzzvsMZy
	 Nj+MFGac2o6lnjBS1b1UTr0pQvPiM7IVzNa44Hqf6ZbMwbqRd/3vOuEMtLgb7GNyEGO17
	 cZ09TN3DOTOyWzOIRQopQJOqLBKvo4ArPC+hlUNGPPs7NUvymJp7d+71cd5CTOfXVtCct
	 eNnqblrNvSIXijkR7R/yuLz/guuwk1R8ESe3+ptPcmNfddvEaFdSHIZLoHWmwq4hcaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mpyNsW3HBFVmjb98ThlFcNBIEJ4d2JWHAS5N3oxz+x0=;
	b=10T2y7rT1dYYPU9dcoImHHFUpxfrhYaVSfo4yj7tNBJjTPkny4QMO2w+m8RjAcTZ4wnu
	 gBI164HjGxNmzbAOrAvdOZRMMMflcX00pxDvD38SMLrc/7nTLD/yjRaAL6TOXqmZYg+c9
	 gCrFCM8wm6yvPNuhlHxgZRcchdkiqssaLgc/zdkhUer204pscZXzMnW9mLhZxDegP0wMy
	 EMrWPDDCRj8KN7uIqy5WCWZ46NSpYd0hTpbaSH3tQZpx/bxHCay6msAxHYGEIgQbPNfn9
	 7fGTSP3SGMdatrr6deXUK1LkKw7HxxLcnT97uLd5XbVXud2LL5Zzymv8ZkWsVRZzx4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qhOVCnmu;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF69606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF69606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qhOVCnmu
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8ca6a12efd9so175328b3a.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299232; x=1795904032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpyNsW3HBFVmjb98ThlFcNBIEJ4d2JWHAS5N3oxz+x0=;
        b=qhOVCnmu+v+QY0B0539i+2cuhRpPgEjZmFG/r1OXSNfRjF70lo+B3V4vtMX4qw6hqK
         ONVhPrt8dM+glQt8Qgca6eBIRmEELNFpmnnIwTKADgtm1DMG4s5YsQ8SusSe87DlTGOy
         d1o4zKjCquTjtkybEFTk9VgPczeEcDMAcixy6ejqf15h/gohU4EwaOzQY39VQ653IYO1
         L2zOjnQ0LQpMpZN0WSl1RAy8Shx9wHKbUkcQbN27NcfyCuh9qLORqIxNHgTX8mw9maTW
         uTK2Ev4k23hem9o5cUCPgby5ZbHP8u0m3MYBX4VBdxQyUOuUmsNCIAdV7WuWHghc06vf
         M/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299232; x=1795904032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpyNsW3HBFVmjb98ThlFcNBIEJ4d2JWHAS5N3oxz+x0=;
        b=WkJBaFFtNTpsuA4T8dOYLAsJmSJ2bPv3kpALDWnos52CLNvSjlK1abizdY2Cd30jpr
         l4j2jeddN+O24NWAthPuZSAP7HfAzHSeYZGazH13+08ZgF5aEIIBG8Nnax0wVuzDYHrx
         pScX7Rg3p4ofq/X08PWr0bT7coggyoAWcyPB45gDPqd4a6jGy8wvgPOyL7D45Z2eCJOD
         rUBX5PFnqQ3B+BG93lEU4DqnybyjwAPcQESx9w+1+2cA3I3FafNZzZfqcWZPUomqVwSK
         Fi5u/FWnYMb9QfFNUXGEQtWKB8ly+HgB7ggURNxn3spaepOz58n6bRvSA6yqjbr0wGAw
         XEPw==
X-Gm-Message-State: APuU4Z/qyEFn7Giemdc48VJpl3CMQOILREeXd4G26JtHJkMPl2MT2+cK
	9aoyg3HxiO+tzK5xM0QrDEKVZojaTPCCZJOSthgQYpgc9tAO/O5EwEugL8f3aA==
X-Gm-Gg: AZFdTZf3H9UJf3JUww0ityphf47DoBWm+eDuDXgS2x89xtTHwKDesO7BI6js4qvFRnw
	sVP4TnnwzRTj+qQ1uZl6MO3hYFGa9XqPs5P9T4iU1e9vK9W4sjEPu43A4iGSU/Yaqxm5fU49Y8h
	bWraxnUqrWJQM6anZ7Q+326N6kMm5I+MtJkT4KdUqFB15EBkvAjlBn1urOk3hG/XSkNHo/u6+9U
	Iezv1RDDnYfgZfjYe19ws3kRJ4zH8Htyo1TO8hD6rlPXPwHdxC3dPpwTBHYlH6axCJddXUtmHrm
	2ee9LT+fUGA5fs/7nXMQ7wq3a9NX8nIyT1PoURxU0F7L5y30kQ46MAJEckXntIAjEHPnq7RX7x7
	LyLVUv6zzOxskC1MxWX212DGwrjQT/84LKo0v4dMUbRYi7QfdiPWS7roZJq9h13JxPZ6j96Q6Ya
	ffzGQ1HBdz6TYTbgbB3SFbgTuCItf7TCQ4yy+sP6V1WAnhUj1McDjGORikbogJIQMibE5lN1gVN
	a4RVBgCfdTml6rezRBvou3ipFObcXcDKKaIIrSeoq9PEln1EDfuZJzTMeE9cGIx3+9CmsOUuYBC
	KQ9Nk35Oqgo1A/3fRS1yPvHKZBGO/2srF/cUf9Seef0xhAZeMhcp7FWKpTDccc18Y7enuvtP4J+
	3Ti/AXuvxFfKu3nppRTiWTgSiqGTxh6JRy4C8hTzCq3B1Zh2zUdZh8s+ebDoIvfTkxGAytRDa5g
	==
X-Received: by 2002:a05:6300:6ccf:20b0:403:f912:7fbc with SMTP id adf61e73a8af0-403f91280afmr584502637.27.1795299232417;
        Sat, 21 Nov 2026 14:13:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfec090sm3047168a12.14.2026.11.21.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:13:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 1/7] bpf: Fix the build without CONFIG_NET
Date: Sat, 21 Nov 2026 22:13:38 +0000
Message-ID: <20261121221344.3958866-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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
Closes: https://lore.kernel.org/oe-kbuild-all/202611220224.dm18oPJv-lkp@intel.com/
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


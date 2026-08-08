Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DB2BEC2A
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150085; cv=none; b=IaBNcMjZGoOPDV3UR2OpAiB8DoTHc4AIkG5GUjtS034hBy+AxP6WsaOtgG1Y9CWRkfZwrFtnhdjFTTLvAvxFp029rZrC+v/k2f9mEgU7IPMWq++yt3LII3+4LDFOvutTVMGD99Ke2kp8HTRjshieW97A/MKnGq2jWvQY9UYmw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150085; c=relaxed/simple;
	bh=zmQZYRa5Z9ODp2cjyKbDBjtJe/njrAAy53m9HOIfg98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDtitkVPJWG0PTuN+CwPFJZ+HtkZzcFjXU884KSQd7etsJLuOehNMml682Oi6p6Owx3E6P+qKaVbPMCnbmQHHhs/UTTlN2BXO7nKxC4UlL9r5VK85SdaiWJlINCi3CgVDeaJfmTerAbY9eNG+184o51t96nTfQ4slXziO8ke9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLA1VfcY; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLA1VfcY"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso1241335ad.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150084; x=1786754884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBYzrXqYDWHjBUle2hBQHEGS5EbHr5YsQDepjgEiLtQ=;
        b=FLA1VfcYD3ByVMsynwA7q2NeluxCrXmX4UPE2plM4zYBEpMZsFKUR/cH+aVYofBOf7
         mlyjOkS2cY+VxF3KQcY2evMFdTbtgU3zlV/99jPQX91BGTWJgcOnRV+7pHW+JGc9Tm58
         +jEesBXHxImhmzUdQLz2qtm8JlqIrWLnQ22DE1dkKjOY5LywGMNxxazJ4IiKqWdBEsPo
         YS6O81hfEDtn6ozqA+Y8awv5fF00zppA6rcnsjr2DY80AfMppDFPwC+Kn+wesI59mzy5
         l4Esg/GBiWtwNpSqsaHDy+/H75FM9bqwqAGfFE8QBaJwvhi4MkW+O2n54CpT9oZ1hoTr
         0mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150084; x=1786754884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBYzrXqYDWHjBUle2hBQHEGS5EbHr5YsQDepjgEiLtQ=;
        b=bF15K8eOxzfO25Sb3fzE4IP4XMbEXBlCSubpgGXsUaiiAq/DQo0a/fdBdZ+dbrIz4l
         /jxLIkaDZIgNImcdb1gZFwIuaB+tCVrUPLwNg8CRFDr67zWo1/eEBXyNSx5pq+A/LLJn
         dDunRGanAq8iunaNLTr+ocdL/+jzJeSOhjKzRHDK2GKM4g6QRj98bWvi84/yJipZgp6c
         QcOUmbNUMJNlRQtVXHH2lgqL+dT4ZUtm/pT5swAOwUq5kfJm/8UBb7288vgWZsNzaBuM
         odmduzXM4T2ZlA6foxbaMv0OcpBk1IZlAp0cZYinVuI9uvO3iueLDkw5d9XZwAjND11l
         dmkQ==
X-Gm-Message-State: AOJu0Yz/ihCUmh4P3xTNGFxCEp8XNaWqGGYGuvR6MGCfWNvAUwezdLfg
	Kuy3Fpnj1poNDqXyX/MKQ0N4vuQVI6z4lSUu9NnqmN//FEFwKLqdlOXIyhLeq0yY
X-Gm-Gg: AR+sD13wJF6iQ10AlN8uDwCJ9xW1+mGYURLlD9/65QOTPR/xYl4USnjeizO/dJqV3rU
	Yb0fEMCVFF2EoWsfdSXOwZ7qvb+Ukup8Ah6j2AbNYwZFkiPhFsJPclhG2zqJZFMJmXjVndQWjD2
	c/xf/XP6IO5dVfut/4gzayGMl4RfmBZZw5Cvw+OB19n/ZljqR4sFsmelepEowrnPgTSdphj+/d9
	O8LNdd1Da6mXHcR44E/WMkXHlJLpr7T2xKCzDFiB4RP1ICa/bImDiM8A+yTNDS41NmlB3qv1CtF
	46YBFPQkdPPNRQKA5tUiu4eHo9XiZmu9ksUlkDhjRSCM/bZyK23pb0HpuPrk5UDOQUfudZD5ZSu
	6LNKxkHpzrqGY2ifKpV97YbSpLOV7u8/MuAd0WMeeJ2AifoJN7o54Tnk5zAhb8PzwMU9wuv82Yk
	IcPA1IpHysfA0vInbUcy36x+wBR0J+vJKdRbwkXU4Kv93IIThqDIA23sedTXeqX0mDzdE4URfCS
	MeKfKbnr1Vl3KEyByg/tT5TSiF68udXgmtKAFnL4ipRRGHsKPtaGyts1acborkhvrbTafc=
X-Received: by 2002:a05:6830:82fc:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7f35ef276dfmr5703345a34.1.1786149588639;
        Fri, 07 Aug 2026 17:39:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:14::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b76fe2fsm2285280a34.16.2026.08.07.17.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 03/14] bpf: Collect kfuncs after resolving program resources
Date: Sat,  8 Aug 2026 02:39:23 +0200
Message-ID: <20260808003938.3486067-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; h=from:subject; bh=zmQZYRa5Z9ODp2cjyKbDBjtJe/njrAAy53m9HOIfg98=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausquI00+1tnIFrCk4+NHhnKaIjZv/WdNoEzrvfrl5Tjn6p wnO5o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPR9WP476zlLP/7hrFRrMLS7ONhvt u5VmxhWt564cJvydLat5O75Rn+yjCJxBQ7FdY0d8wzXlVp6fpMcznf1j0RK+VWH471vFvIAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The kfunc descriptors include argument prototypes generated while calls are
collected. Some argument classifications need program auxiliary state derived
from referenced maps, such as the arena associated with the program.

This avoids a footgun in get_kfunc_arg_type() checks where we do
validation on whether program has prog->aux->arena and it hasn't been
resolved yet.

check_and_resolve_insns() records used maps and populates that state. It must
remain after bpf_check_btf_info(), which applies kernel-side CO-RE relocations,
so that instruction validation and the program tag observe the relocated
instruction stream.

Move only add_kfuncs() after instruction and resource resolution. Subprogram
discovery and validation remain before the full BTF phase because that phase
needs the complete subprogram layout. Add a short comment describing the
resource resolution phase at the call site.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4573df98b1ce..7936a42097da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20352,11 +20352,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Collect the kfunc descriptors used during verification. */
-	ret = add_kfuncs(env);
-	if (ret < 0)
-		goto skip_full_check;
-
 	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -20366,10 +20361,16 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Validate instructions and resolve the program's referenced resources. */
 	ret = check_and_resolve_insns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Build kfunc prototypes after resolving program resources. */
+	ret = add_kfuncs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
 		ret = bpf_prog_offload_verifier_prep(env->prog);
 		if (ret)
-- 
2.53.0-Meta


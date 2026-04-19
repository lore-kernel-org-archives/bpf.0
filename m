Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6713777E
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776571200; cv=none; b=JZ9BlvIqk8yfjt+MKo5RYgs3AhY7wECtzP/2yz8NIYhb61l7dJY36NDHFhsEs/3xOgyPjIYfEOS0BVECXRu64UrE2ISKYOmeL6sCN5zDLLV3TxNQOWtbeBJjCje1XXDUEOrvNrB5vanUB2DtMdO0OrGhwcGkSVdt3/JVLCuulWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776571200; c=relaxed/simple;
	bh=u9M8XJ+TuJc+FvvsgLZJVLKmaQWgnQjZ4K3dES/btwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fV5u6ZLvDHmMd+5SHSexUD0smcMgJgV9OII6Um0EkD6vBftvW9PJTe0VMoPAiH2LTmGNGXSBEX5voamTjKQ8jhgGMhehPDb2/TEcM22C+zfavnhOg7YL1kCoyymKBCL1WKrL9thqs709KJcePD1DSKWhvhRFRg2g3N/p+nsCCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpXft9+f; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpXft9+f"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35fbca04006so1036507a91.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 20:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776571199; x=1777175999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=ZpXft9+fBUb5xYYB15m6ZE3u9KwSjFRM/3ad728RMgesNN+kSFUB6AHCRey+VQ+bTN
         5ErA4yeW5ecUFU9dwiU3ic6hj2xaV5n6s44HHpkfEO3reB0H4AshhhS4zs1imDTm5a0q
         sFLvw9hX1XYHM8/qpdP3/79gQFiKOyDmsNywtXt8dI/kxo5ANHs6q3gN0e0euoCIAx4I
         X3Q5GhrwhM++NUbaQb80I/rRt+g8DOm/HIuIzyiEMv0M1HmY8Cs2P5HqT0u+1Zdsut6g
         cm4+eDUTUfyGCt6WvvPvQJOkmMC0KfNCJqGp/kjUKgyuZztMG5iIiAjhkz3wuWhSDbNS
         iVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776571199; x=1777175999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=Faoe4MuiJC9z86Dqz7k17+cYiaZ0td9WH9oipxjQGwRfEawjKwGAPvCPDFCpHcsN6B
         OvumYkr7iXv/DBuBt6jNZTBre/oWN2bA5Yy4FrWBlx3GIpq5RNrvKEbKgU/oLrz//V1W
         xN0tdPADjcycwWWbwfLgzpIKNka9pAyZYLs69z+ncKgkMsWsB7jl4wOJwZsVA4qp+aTd
         0wG9AqjtfRUU+f+A3laTyyHfk+XAg+EvJdSwdyXP1jz2U/P1RxfzTeuQmz6vPl4Za3IB
         ssCB60BOoucUeJq5YMHrjw0k/+2OW0cgi5uVI5yhklab0joaZQQ3z4eP/RM0jlvfNsng
         Vs+A==
X-Gm-Message-State: AOJu0YxUQYjUhPhKyKaeiICuoiBPUSD2OHNrfvwuLHZSLZFvg5BAXLb5
	lGEaWSmPw+znahAooVfHythD1fL+uawtRhpdOfCLzxcPQsgMg33EZlgC
X-Gm-Gg: AeBDieuwkE9JNjP3rA9cFCsdi24aBsDQ9Y8z1USRnMmyHv20VbOvQichkJXt/pC8KH2
	69F5yE+SwYTZKFDXykrqWSgt1V9aJtxrQRBRVaadMV8oahlZZuuTGr+se+SWiFNV7tfTqs9l5QX
	6QRzqcP4zUbdPC59pthzItudUsDZEfPQrnHZk1LdpC3IlPyI1AeN3e7a+z9urI/E8PceRs/D0iM
	jGasp8Fikp4sg+jGbYLeGbFyiuaTyiw3i9oznCEzgNO9OhHYaYXhSsnFKNhnkGsqqbr3TzN0cD7
	TFTJXR2lFJTVGZS4tPcOtl5sVq905hKPY+DKikOO9wwOqtgNaqCfKp3LU+sXTdt9WVLSVyEc6pq
	pxCtInUb7oTeO7Etq9SyyYs+dy+HdvxiwrEDWOPBqV6UPZEp2Cb5p4X5Th7LH8uBfY1J8sgiOnD
	HSgriePL+4HevY2W6tmIqNFctDpyP/0vFCCxQ=
X-Received: by 2002:a17:90b:3e88:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-3614048e396mr9233870a91.19.1776571198830;
        Sat, 18 Apr 2026 20:59:58 -0700 (PDT)
Received: from fedora ([2401:4900:8838:1107:4b02:340c:af49:3bdc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613f5766c4sm3355358a91.0.2026.04.18.20.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 20:59:58 -0700 (PDT)
From: Avinash Pal <avinashpal441@gmail.com>
To: avinashpal441@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs
Date: Sun, 19 Apr 2026 09:29:48 +0530
Message-ID: <20260419035948.9498-1-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A NULL pointer dereference occurs in map_kptr_match_type() when a BPF
program attempts to store a scalar value (non-pointer register) into a
map slot annotated as a kptr (kernel pointer).

Call chain:
  check_store_reg()
    -> check_mem_access()
       -> check_map_kptr_access()
          -> map_kptr_match_type()
             -> btf_is_kernel(reg->btf)   <-- NULL deref

For scalar registers reg->btf is NULL. map_kptr_match_type() passes
this directly to btf_is_kernel(), which performs a container_of()-based
offset access and triggers a general protection fault:

  KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
  RIP: 0010:btf_is_kernel+0x2a/0x50

Fix: add an early NULL guard on reg->btf at the top of
map_kptr_match_type(). If reg->btf is NULL, emit a verifier log message
and return -EACCES so the program is rejected cleanly instead of
crashing the kernel.

Reproducer: store a scalar into a kptr-annotated BPF_MAP_TYPE_LRU_HASH
slot via a kprobe program — verifier crashes during bpf_prog_load().

Reported-by: Le Chen <le.chen@bugzilla.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221372
Signed-off-by: Avinash Pal <avinashpal441@gmail.com>
---
 kernel/bpf/verifier.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed..15b8f71074 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4545,6 +4545,18 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct btf_field *kptr_field,
 			       struct bpf_reg_state *reg, u32 regno)
 {
+	/*
+	 * If the source register has no BTF type (e.g. it is a scalar),
+	 * it cannot possibly match a kptr slot. Reject early to avoid
+	 * passing a NULL reg->btf to btf_is_kernel(), which would cause
+	 * a NULL pointer dereference inside that function.
+	 */
+	if (!reg->btf) {
+		verbose(env, "R%d is not a pointer, cannot store into kptr slot\n",
+			regno);
+		return -EACCES;
+	}
+
 	const char *targ_name = btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
 	int perm_flags;
 	const char *reg_name = "";
-- 
2.53.0


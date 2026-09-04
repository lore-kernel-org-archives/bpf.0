Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4693F7A9B
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510825; cv=none; b=M6SInMBZkDteC8lELo+ks3f8HuSZhybCz6bORLVtImJTgXdQ/zEarAaG1wb5Vritu4+jdZTgGLebeJs1hQ9jBPNHNNCfhsBYHIoEd6sgyN7QcIiawn3jfs/RckkWAxSdMxMpgfc7/pdsTNXxwi0L56zifTpkEauIE3oagfNgmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510825; c=relaxed/simple;
	bh=9SuxQmo+IPQ1+KHNlhn9pc0Pi8UT5P+EDzBvMyTQR3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRMNXD3gssvGKEPau1j8mkOaJSZECeGz00zSZ7WsZyqJT7Lh8yyb5+H7PRygUHwAI4tXR567SR2C7C5Su0rmGKA6RD5h5FwRQB/fgjlEdP1DsORbp75FTVOq3PyQ+rdCBkshVDLMiA1wyuwnGOtCAK4NlNYn+mwQnCXt8uEQBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T20NupEA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T20NupEA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso8611615ad.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510823; x=1789115623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+JCGvJNm1yD3+Y0yjmDEt2KX3WFCxx1RPBuqWCUcA8=;
        b=T20NupEA/7nh3ptYlxHzUcSC0U03/ojn6QSRsAOzBYh6Y2CYWyzMKmwBAi3mXT865j
         a4i+XcIDxpPmSkH4GcKPUkEkxDJmhEXADbqJ0syVs/31QtDkDITzIFsoaBrTtTuD5KCF
         ozZ1gWE/8szLset6uUCJTtkZe1mKoNeCvWYUm/wNkT0Ar8FEiw6ajiY6ROsFFJZIB+Id
         jDHnugalHwaN/fZNBapXnbzx7e/+9E+nGGUkc4P2sHrukGbJhmrew7vjuAPa8KBk8l2F
         QL4ljaeWVwnNtD4nGcteX8qEaxshZB8y6JYno5YQ1FYNI+D6D+9mlwoL0RpcziXyxgLn
         B0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510823; x=1789115623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+JCGvJNm1yD3+Y0yjmDEt2KX3WFCxx1RPBuqWCUcA8=;
        b=fF5IENQ3Z1B1AUbrMK5xdxDtaBsP8V7neWFJEmBvCGsGTGxQnBBTBvsDah6yu+Xe5R
         pvNaQzAeEvkM5h+E44HuqCiZddDMARs7kuxZB/TnpCMdCPGrv/YvAvCfTK4Su/iQls4j
         ZoepM9RHJGEPK7YvtBMl0IIO8Y4+ZU3MA+j5DtkOOxjVkvBIQmWh4etEZ9cpUxDIxXOW
         yUP9daE5G5brt5h0qDdqGt3YNGQJuhNbrDphSTuxolQ0kSaYmPa8bdCZE0+dIjhiByIM
         82A8H3rMppW8WsJ7eYbfn2TQzUhxCbOiPjtiFmMZnRRFPa8oaixICxFYTWy+k09UEMui
         +sSw==
X-Gm-Message-State: AFuF++nzPXEmJE57RnE2JG9ToDOGJOOtFe8HmDoj3HcpkBGqDQNkGLm3
	Giiq9eGkZDbVdPx/hkyE6hNV7+TFeEkFYryxPPryxl/KT3bh8S2SK6UqAC37Rlr3SgU=
X-Gm-Gg: AYBFou1BNdKYCSQCuuc2cWmBHhCMCgQe9TBceFTWnxHMoqYKJgXXLZ6j/n/dTHITcJ+
	ZiFPvOq1SBszGF0q81O3bPiyRlMJ0Fb5dNi9gE64OGH5lRwMBP4yby+A1r5kLPizYt5HVA//Gfg
	wOTeUaMtfBpenACNYvozYSlwBqZVvYP3tCQk17stVRiwH8HoFoNaTpF9aPiXce/kHO4fXZ7PRsl
	Y85xcBFedW/TV1kHDFqMKHtP1RdkEDS2VApJJGCJwkt7Z7oKLUSuwyENe5+yagOxp7aUNOAxetM
	hCv5JowsMGynKZWArtv7L5rwkfJQVuYpGtUKUhBI8rdL3oCSeVv1R7KrkaQIlEUqfDkDY/67s84
	D2gdOEjDRz0V5P8SCrNpDH0qw1uNbaq/gT7rRxpG9lkI/xcZsQxHMmF0wymtcedgqzwmetyyWuL
	fonth5gbFUHATaxUy5ilVGlEWWtPTE0Ecnj/WK/ygPYPk1H5uLCMv9D4BapqkTg2B+35/bqTnDT
	a4M0CefMfutvpHxH85XhGIKPJhUh9bfpFzUBEB6jpcf
X-Received: by 2002:a17:90b:2781:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39b26289136mr7609769a91.22.1788510822861;
        Fri, 04 Sep 2026 01:33:42 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:42 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 5/8] bpf: don't predict JMP32 pointer vs zero comparisons
Date: Fri,  4 Sep 2026 01:33:22 -0700
Message-ID: <20260904083325.2083493-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider the following program:

        r1 = map_value;      /* low 32 bits are zero at runtime */
        r6 = 0xdead000000000000;
        if w1 != 0 goto l1;
    l0: r1 += r6;
        r2 = *(u64 *)(r1 + 0);
        exit;
    l1: r6 = 0;
        goto l0;

At the moment is_branch_taken() reports the jump as always taken,
because it does not distinguish between BPF_JMP and BPF_JMP32
comparisons when processing 'if w1 != 0 ...'.

Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d16dd1fb08b6..bb8e9efcfbad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16309,6 +16309,13 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	if (__is_pointer_value(false, reg1) || __is_pointer_value(false, reg2)) {
 		u64 val;
 
+		/*
+		 * The low 32 bits of a valid pointer may well be zero, hence
+		 * nothing below applies to a 32-bit comparison.
+		 */
+		if (is_jmp32)
+			return -1;
+
 		/* arrange that reg2 is a scalar, and reg1 is a pointer */
 		if (!is_reg_const(reg2, is_jmp32)) {
 			opcode = flip_opcode(opcode);
-- 
2.55.0


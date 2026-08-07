Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF343DAABF
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136402; cv=none; b=GDMpeMkXScvJV9buEZ7zSSDs3vuVrbXam+KXMDKancy6Bfe3QJXHs3WAc5vsM5kJS1ohZ4/HyaH7I3f0n36qYeBdmrLPHf/tzst0kwdP5ZEVMfmuyxwQWSgWc41vMM1fcOtDu7HRj96OLHE83f8a3xrAd7xgYzodqyJmi1MGu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136402; c=relaxed/simple;
	bh=0OlFuozEC9xvd+FU1Ghb4aUqYeIVvIMR2F7X0GeutxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0dZnWQyDLbLFrhWLdNqmo5eHpejB3owkY63qpwrz5gzmPcglKdcWdQxDMdbLiiYTiAPwsLOPoaXKh82s+HuHxPP3fXqpOVYF/WOMr8ddHbwJhoWEoT51NB8ajILVECg3egJSSRTnjpdQzMSZqCl4Rn5NC3Wau63Jt6YSeoY6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHOwSK0k; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHOwSK0k"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1918a91.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136400; x=1786741200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HOiMGpoj8z5dQM1pucGpH2OCQoRfJTNWjAEa6KLV4b4=;
        b=AHOwSK0kJFkOvRTow8DAdW6VySD9yiWy+UmxXn8t8XWWn8EF9aPDzj+lezxw88vMk2
         SyAiO6muAdpDGhZUthD2aAwAu+jyqDykPKZfjdgWH6P1QOxMuURvZRxcMt94SMSb/V/A
         Ox75ffTcPc4/jUm0MCgeFFMHcLvijYeZ/HurfUU0hejbOS1V5Cu/O78Z8vmkorSeETWX
         PXdI4ITV0/+Hwcs1MgpgpQEzCmMUT74pwULQZ/2B7o/LIRbFGIAcv0PtiPPM5EoAdb2g
         vfsSXYTPycEPJkhfJ8iT4KdDkLmeorTJQ0L1GBjYRUPa9FuKp4OYK8k/CJcf6o4CwUj6
         qF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136400; x=1786741200;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOiMGpoj8z5dQM1pucGpH2OCQoRfJTNWjAEa6KLV4b4=;
        b=p7MKmzyCvIvxyWo+bfPj3zZRoTrWz+ZO2PIDk+HCv6N1+ybOfTXrNhDwhoiwdM5AZU
         +MEqPi2x+WgLRVFgT6m164jC4kfSOQZqGtqRQo8Pggoqwm7z2Y6uLU+TAowvNrNr8K0r
         Sto2kpiL0hWDsAfOz/T/0yWRub0InVp2khR0BrGKijD+vZL66Gqt2CZM2ZC9Vk+1uw/T
         Md/A2U20xVbun4Q9vLVmHhR76pUm9O9ADOzkkQD88CFDRPruTuYiv0v5ARHwn4qTKSfP
         SgLqqjIU/prxwaDMixDYgqLcKzTciwZsNiXDOtLYwh2M9KYA2wBrcDkxhauoS4Nxs2Mi
         c63Q==
X-Gm-Message-State: AOJu0Yymg7hegcS6XSbIBmKiPJva7pCZcvkD+LKR648yzHK083ZK3on1
	8v5HfVhwLcNvjHZB7mklfNnjarxJSwPiZ8zjeRUWFoOqGerqxDH6PB5WV6898NC5
X-Gm-Gg: AR+sD11EhnKSztw6krGvLiH1rve3fpXvF+GU7viZcj9A6bK2s7YSTETvPhEvOYBn3Lm
	8I+RILyOK0ljncDwOMKcHSQhQe+/2UxmexjVWaLC4l1TIlcf/aGP4KytAinFSXF2GRMjIWE/LWR
	Gh7Sv81smiW5EO5+8RYCNJoeF6yE1zmpJp6idt9TEoKD51AzTJhmTEW4NAzJ/MgNSOp2jKjONFC
	ayDy95Cj1mQj2AA1ZYlde0Yzh+HWQEfMyIbt9lDqUqRlJ6mqOaOX1/tK+2fjp/qx+4U3GLtTiWX
	4AfWvE7vWgMAtOypDV2y+qae8jEMBFp5YvVA/QhcQPDVRE42PKdSdr9NWyCCKQS1XUMiO86704M
	fsiKZ6RWHXTez9Hv4XM/6+1ifctfnrNtsgJWx+5JF8ONTCH6wFnUtKwxDe2Zh+4d4ZkDRc9RpFa
	gOKgh3dMr2t2jyERdX6/aAZX5Hcq2By4HTKm3uRmxvOVcn1R3EDEIXy9bGc+6gVmCltRteREqxs
	zCI86xN3Uwx8enBWxkmxAA2nRnOn7GYu45KbN31WoMR
X-Received: by 2002:a17:90b:4c89:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-3903c5aefe9mr24952745a91.15.1786136399502;
        Fri, 07 Aug 2026 13:59:59 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:59:59 -0700 (PDT)
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
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v4 2/7] bpf: extract is_addr_space_cast32() utility function
Date: Fri,  7 Aug 2026 13:59:31 -0700
Message-ID: <20260807-static-zext-v4-2-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bpf_do_misc_fixups() converts the following address space cast
instructions to 32-bit moves:
- cast from address space 1 (user) to address space 0 (kernel)
- cast from address space 0 (kernel) to address space 1 (user)
  iff associated arena map has a BPF_F_NO_USER_CONV flag.

Extract a predicate detecting such instructions for use in the
following patches.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a0bddada7964..5f7843648189 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -20,6 +20,26 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 	       insn->imm == BPF_CMPXCHG;
 }
 
+/* Returns true if 'insn' is an address space cast instruction translated as BPF_ALU op */
+static bool is_addr_space_cast32(struct bpf_prog *prog, const struct bpf_insn *insn)
+{
+	struct bpf_map *arena = (struct bpf_map *)prog->aux->arena;
+
+	if (insn->code != (BPF_ALU64 | BPF_MOV | BPF_X) || insn->off != BPF_ADDR_SPACE_CAST)
+		return false;
+
+	/* cast from as(1) to as(0) */
+	if (insn->imm == 1)
+		return true;
+
+	/* cast from as(0) to as(1) */
+	if (insn->imm == 1 << 16)
+		return arena && arena->map_flags & BPF_F_NO_USER_CONV;
+
+	/* non-BPF_F_NO_USER_CONV cast from as(0) to as(1) should be handled by JIT */
+	return false;
+}
+
 /* Return the regno defined by the insn, or -1. */
 static int insn_def_regno(const struct bpf_insn *insn)
 {
@@ -1513,15 +1533,12 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt;) {
-		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
-			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
-			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
-				/* convert to 32-bit mov that clears upper 32-bit */
-				insn->code = BPF_ALU | BPF_MOV | BPF_X;
-				/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
-				insn->off = 0;
-				insn->imm = 0;
-			} /* cast from as(0) to as(1) should be handled by JIT */
+		if (is_addr_space_cast32(env->prog, insn)) {
+			/* convert to 32-bit mov that clears upper 32-bit */
+			insn->code = BPF_ALU | BPF_MOV | BPF_X;
+			/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
+			insn->off = 0;
+			insn->imm = 0;
 			goto next_insn;
 		}
 

-- 
2.55.0

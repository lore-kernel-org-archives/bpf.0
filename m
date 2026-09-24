Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0D3DD87B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219490; cv=none; b=NjGsl0SKFH/TysZJYuiI3ElQdrupVUQHeBEy+mDARSc3fXz1DKdqLRrfW1GtwcOrP8fDhSZwRQeJDTrJUP43DZ+QOfXtrQWuRmxWOwFjX82/P7G8JwZShX+iA+3a9O596VD3a2gyCUAlod4vd1nzzwSKy7QTOwoYLHk0C1q92mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219490; c=relaxed/simple;
	bh=L9kYbUCMg+1HckbwIEz0IDibMPh8uGroF8QeNMyLeRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbIdwPC1JF9VDENGa5RYvQ6x49hpOVPrgOUGaX3+vEfYDV87jFWqpt0NrX/c99XucJp8bl90JizeSP2+Ika7sxRYDZaoeGRoq39tC92SvmGPi4AzeSpotJndcunmDa9zEPUA9c9bx9ztqVo+8SVHEA3nMXc6E2yeLYrI+EnmmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ2TyefE; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ2TyefE"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so14606635ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219489; x=1790824289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mofFm3mu4i8sCuZEjiojXfzaKjR15t+gkMnTdKxgpkU=;
        b=HQ2TyefEUZihuX0PVl5VzLtrV8wdJcLP42jB00gShK2o9D+tEJhiOTa7OAGiZJuvyO
         9kV66woCcA0I2H8yUW7sTXVPUO1tLDP+J++J3Rkr0Q9RWEjSt6yPF2aZMFAgFIVEm5xw
         wLbep6AtZ39xbEqggxjxJJsRy+ZpyX/kl6+nXSbeeevZmvHYpk7k6/Gajlazig+YWde+
         Ci52V0f2RQhk51NVoPk2OJO2nvmnkYEQ0Bk8/Nah/YbQ5SAfHofw2dQc229AAxKr1qqp
         nxx9QDWivdx9FYC+baeQKRmhRCB6K+GPqfq7wRBFBtQVwI8QBxJCWeKnf2SczlVAGMEB
         5zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219489; x=1790824289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mofFm3mu4i8sCuZEjiojXfzaKjR15t+gkMnTdKxgpkU=;
        b=YbkkZRDS4v9sKhb4x7Vntc7HS3ahqSUCfb/lZCtX4LvodMo78FszeQHeZFMg2Bv90O
         OYAixujPVpp+2amwcRBnpSffsFVHvr0PmJIT6i2FvqlrCYZVsUjbvgPVn57aJN/n2M9z
         f0n7hezNJSqdKmdeIxIBERK/SMcCwVhH15CPOAavRcZ34O74XqdxVZL20BqotrKOhi/G
         yHNw/JWi7DjG0H+nOtsU+CKl39Ss56NHXcc3gRgjRBn/Eq+fbauK1CtLFfMcwDwTxh5F
         nVgJUnRGGJVVUESqUpEjDowERVatYhhD80VnRKM4XbFrj9KHsNR4+rCVyUt5LnCK/NCs
         DrbQ==
X-Gm-Message-State: AFuF++nGIn3fvKrx4vjLicpyLrcCeLD+zTPWi7VM8TABkExQEVgKdBNE
	dpw41SLmWvBokFSJyiFg5hEyDWsk8E8zHUp2mTiNj/7Rldrs66aLaWW4MuvbyQ==
X-Gm-Gg: AYBFou0OvEOQAhOIPVeaUywCpRYR1xPEWLdXsaz7dG3yDqsBhX7JruI0g9iXX3oa5s3
	FU2Syt4hFhvdXnoE/bWL9d8V8Sjs/CmUbITH7rxV6bPiiafj0/LH8IL9gNMv/11kpSMZDXkIJ26
	zJtnilQyTeNHVQ3RXW+CfoGhxm3bJpi27XyGcFhupQTeX9XzqtzIpSP77Y9JT7EX5yB6vTf56Qt
	sAL2jH3qE3be7rzmj9YV6P+DVD+7Fn2EniVpFDLbpAJdqkCtfYiqdCKjUXr2U5V4BGHgb+s4Kpo
	71EkVdNtae8nMHXVwsMJhdQjFxqyJPjqr91DidSWixl7qzpWWerJsGPbu82U1QgfLPJA3I/xJz+
	YdBvRJmxh08KxVK/jzzXojsMEXVUsKcorb4W8kBfW2gFZQ1plAr/WAOcfWM36iE9VCvQN5Ibt1e
	FKKAItpBiSQdvrkk48PWJhOhhQVegFQCSSGM2cud01RGKlxAEf55oR12dQhjEVdFzXw8BFkM20r
	LdiJgky65omTkdOPqqh3kZ1rODnVvJ01kBcOweFXJJQ0UUYus49G1j99BM2ldA+YsxEQYkNLbr5
	DGHRM8jy0SQT2WfPrTxmb3gL9d96GXPIYqJC68/i3yshEV/tLUopmg==
X-Received: by 2002:a17:903:3c67:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2df7e24f3a5mr9069955ad.5.1790219488652;
        Wed, 23 Sep 2026 20:11:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d976asm18662105ad.51.2026.09.23.20.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 13/17] libbpf: Treat .data.rel.ro as read-only data
Date: Thu, 24 Sep 2026 03:10:38 +0000
Message-ID: <20260924031042.1690890-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

PIC code keeps constants with pointers, e.g. vtables, in .data.rel.ro
instead of .rodata. Nothing writes there after relocation.
libbpf treats every .data* section as writable, while the kernel looks
for pointers to functions in frozen read-only maps only.

Make .data.rel.ro and .data.rel.ro.* maps read-only and frozen like
.rodata and collect pointers to functions there.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fc9b7540aca6..2e0cf7c5ae23 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -546,6 +546,7 @@ struct bpf_struct_ops {
 #define PERCPU_SEC ".percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
+#define DATA_REL_RO_SEC ".data.rel.ro"
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
@@ -4062,6 +4063,17 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				err = bpf_object__add_programs(obj, data, name, idx);
 				if (err)
 					return err;
+			} else if (strcmp(name, DATA_REL_RO_SEC) == 0 ||
+				   str_has_pfx(name, DATA_REL_RO_SEC ".")) {
+				/*
+				 * Constants with pointers in them, e.g. vtables,
+				 * that position independent code keeps here to
+				 * have them relocated. There is nothing that
+				 * writes to it after that.
+				 */
+				sec_desc->sec_type = SEC_RODATA;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
 			} else if (strcmp(name, DATA_SEC) == 0 ||
 				   str_has_pfx(name, DATA_SEC ".")) {
 				sec_desc->sec_type = SEC_DATA;
@@ -4114,6 +4126,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" RODATA_SEC) &&
 			    !str_has_pfx(name, ".rel" RODATA_SEC ".") &&
+			    strcmp(name, ".rel" DATA_REL_RO_SEC) &&
+			    !str_has_pfx(name, ".rel" DATA_REL_RO_SEC ".") &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
-- 
2.55.0


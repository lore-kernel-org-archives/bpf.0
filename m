Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F68456E17
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546183; cv=none; b=ULerCU8EC8xC5p8nOrpHu9jYLYqZcSMHMJUGUwOuphwQX+6arSCsBrtrbk1u7+McoatuZgajreexPaV5+xBPSaeRNlpt6axFYomqBa2OIcigPP6X4BeSufXzaPA5WrUOEw+yMQNMh6QG4jLuXdFDjEC48/AWS9lhn5iFsxNQ07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546183; c=relaxed/simple;
	bh=CeEnvwNBqfl0pl3Jq4JuKVoi0i/a4D4c0UobM31wa6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ibqVlX2HJTrz66VvYWfFYkPbTf2hQPXeMeq9ugrKzGA5oP0z9RCbPsV157StGqlR12N2ncAPU77VnorB9q0l96TFEXKt1gMZ+4JVIrf4nV+yf14qm0XHtHyH7eN3YxiYXX7fWTo6mDOlkYTEgFqVHcr/nRX57EwcA9b7fda8euU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llnNr68D; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llnNr68D"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-448de0cc236so727623fac.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546178; x=1787150978; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ICZrencCdKxVp7QlS84p+6PaVpH/+Rs1Ck1v8v0fxDs=;
        b=llnNr68DaxHAGQRCtkwGmLrzkaz/lH0IySRTg6Uv0GjbyAGFlWLRKulUjKh/Z+5RhO
         zyKumZQmjaJYakdthHBShngwuUeE8/4Foe9JKwbq/JIdOF6q1BreUOhUcvG0kw27QMeZ
         psiTFDeJlwxrpQ0RHZlhWq+fILlRoDvTj9KWUe+AgpMZ0ANaf7LvM9zjhVmoSLyH4g7b
         2E/YxMx8FnlEeMcLCPysDzsa0pHPIwlTc6RyGm5T7H0kzzKWyzDa2SKWshw6i5zyLZpK
         OSD6oVKlB5PFJ9PqCoIDySz169GF3s3VfN5RNfxC3+YHxReFxzxZElWNO2UmUDq70GM4
         IXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546178; x=1787150978;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ICZrencCdKxVp7QlS84p+6PaVpH/+Rs1Ck1v8v0fxDs=;
        b=FMR2VFi/Cf/fmqTiTDmxOUU/mCbZUe4bc63ermwqd+xvf3WYVZaZhmMQwi2NAHpU6P
         xasjhuRxPVeCVIaFaTBpm6oHMSs3W8Gbl1ukSir/GF2PSh6LhB7ubLA+jLCsISUk32Vl
         zLrZ3V8XOIwejj3QASw+vjhIa9AHiDDHo+bkMhaKoR9h8pYa17VkHJqC8uzV3hoAB+Wy
         1o3nbFQ2D8QmA/IIfIWxTaagX7zzMn6uv1rn5Yf61CHykriVMkr9GbfSfuLBuTXsKjQc
         rjyYYr4+iW/msQiEobnhj0INzV45M+F/2JhOQ9GJ3qU1JeUeAeYopT+jTEc+ppxR7asP
         MEHA==
X-Gm-Message-State: AOJu0YxU4QDIvsWuuCmpUor64A91IcYZ2YAUr6p2vrwSnGmCTsJZ+pE0
	PwtRgAkwDEdGfRosO//VuDsRkkpTCU75gyxbsMZIc6VL8NRevioY9fZG
X-Gm-Gg: AR+sD13ZjrweSObSbh8j3ktsI1yeHHwjZkHymDBKJApc41XVVPbXpgszoVg/lKiD41e
	Po/pCKmIbhPelxSNyTGvMRr0GvC2ah5eDb11L6D2ln+ka30A/KyqYK+MZ4OdMBCO+BfgHLWP5b3
	G26sKlIyqbsE/JdgjPOViQPsUzhOEpAXYiZhhuex/A2LRGsq5SaSjgPhUpZEHRG/LH4H4vzcUjw
	4SS8O4MCkvg0nqWbhnIRgh47dS3JQgpysqw7Egs9tOIu3dDm9nKWTt6Dy0v4yYoboZ7He5Rjgme
	uKhUZTiwdvVMOFmLbieCoSA2ImTxxAJFkVtV1r57oXZVsdJQoDRe9pf86UxwFWFvR3BQ3AE3u9w
	EIrDvOiYm4fP/IRJrMHB0KFuWQa588wAK5NMGb8SPfrOzI84hz0CkGW+yAMuJPcePNP8Mlg7etC
	Ov3wLQe20SOxnwz2Bp7jIc537M4Rn936W9M0GuYhB/NKDIr1jgcPk=
X-Received: by 2002:a05:6808:4fcd:b0:492:3ed0:9073 with SMTP id 5614622812f47-4b210964bbcmr6116158b6e.4.1786546178472;
        Wed, 12 Aug 2026 07:49:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b223491335sm12276b6e.7.2026.08.12.07.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:49:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 12 Aug 2026 07:47:22 -0700
Subject: [PATCH bpf-next] bpf: Fix arm64 KASAN false positive after
 bpf_throw
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-hello_world-v1-1-c3c2ddcb362d@meta.com>
X-B4-Tracking: v=1; b=H4sIAHqHfGoC/x3MWwqDMBAF0K0M99tAnD4o2YqIJM1YB0IiiVhB3
 HuhZwHnRJOq0uDoRJVdm5YMR31HeC8+f8RohCOw5ad99WwWSalM31JTNBzsTSJ7/wh3dIS1yqz
 HfxsQ1tlkOTaM1/UDyVhRdWcAAAA=
X-Change-ID: 20260812-hello_world-2b03ed2aa5b4
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546176; l=1687;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=hsGrZb8p8/ufH20C9r2leOW6ZzztUWr8rwUqvM6JRXk=;
 b=FWsEq5uROkS4MzSuh4VI+GvmNmRyqaALqxOp+Iv4SQjrrv8KhDXd94MMXQAK3e+5FbqgyT/08
 G1n2YDYH1a3D7UzMFMh0IWC+MNwxjmVWCx6Okrl2HAgtqCEGtxSZRZ4
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

arm64 passes zero as the stack pointer while walking BPF frames, so
bpf_throw() leaves stale KASAN stack poison after jumping to the
exception callback.

Use the frame pointer as the fallback stack watermark.

Fixes: e74cb1b42213 ("arm64: stacktrace: Implement arch_bpf_stack_walk() for the BPF JIT")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6388b6b23e49..bbad75895331 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3395,11 +3395,13 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 		WARN_ON_ONCE(!ctx.aux->exception_boundary);
 	WARN_ON_ONCE(!ctx.bp);
 	WARN_ON_ONCE(!ctx.cnt);
-	/* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
+	/*
+	 * Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
 	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
-	 * which skips compiler generated instrumentation to do the same.
+	 * which skips compiler generated instrumentation to do the same. Some
+	 * architectures cannot recover sp while unwinding, so fall back to bp.
 	 */
-	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
+	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }

---
base-commit: 53cc65185a51fa9dd288cd1137a21467eced2df4
change-id: 20260812-hello_world-2b03ed2aa5b4

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>


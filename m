Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0644A724
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689751; cv=none; b=gJf6O8MoPbof8i1y7yYXf7Ctc6Do5DqMK4HRguT+ik6ahxYcqY15XT9prOQ9s6E2zv7e5BJLTNMGXMW/NNFAKqCcTNnrWNcheY4UqZKPVzaFgZ7XEdXvWXmmkhg56+5/SOzV1ekzstS8ZtZBpirunrBDTFBfsqMITkegUopFFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689751; c=relaxed/simple;
	bh=ga/GaeF7RQuXBAbWhIuVXHI6+3MN5+3NaqWQNfW6IEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REJREG6eGPDlomqI1+j7+fn4OsTezmPtntAAsxnB0Dq4z9DPQkXnclEKSz126lRJd+NkO48CkKk5RZTNJiJYH/imr/Y09U0h5AyocAdK1V/TS5T0v50KuUpfpQLvW8EjRIqZBs1Y+6VaQG6cXJdv1lW7MYelueCMvlk5n0ywUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnHiP/mV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnHiP/mV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so117487475e9.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689748; x=1779294548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOc+Skhm2gYZJKUxRuM/yUCFNYfH507QF3U6ghPOViQ=;
        b=SnHiP/mVUAa2NmmpUN5N/vE83hDTD14RyCaC4buimKk+Okxe9TlqsdB+NOL3c8Ys77
         WrfHpQzj75CdMwNKuTUovTUZb4+o3KZIyv6g1dWaJ1NnjvzTBA1/+zBA5qNdsyWFQ0xy
         uJ7g28+OPnDiUUOrXYOmf/HGOz7f3QQBXvL7zwl+yovwhfrdEMchv80XNF0qzRGX2Lrl
         x4idBgischNFaTP+gKEXcW9CH6DOOGE7zVtZOWZWY1o6IEIEmKkw8uIaPMDxhrwlab7T
         24gu2IvcZldmcX411ScdrR5pVhbJgxsdx0wSr6sRmD6xTP2m9N0rpTvu+UChJCH0B1Uf
         VTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689748; x=1779294548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOc+Skhm2gYZJKUxRuM/yUCFNYfH507QF3U6ghPOViQ=;
        b=QjTCG56QWk8ZQyJDYgV6iyFs2IaeEOHrMrjHga2Q2+/VwXbGbTuxaXVP6x5+yPi5n+
         KLztZ+xo3QJO69cvWpkD4vghFT3CtG6rXue8WwCSJYWjDJuryQ2vI5/jxMZSuIXel7hL
         /rG20/EyHNBaPjm+O1XsAx5JdIFp6WRJ5+a3FCOrGwckjT8LEY/DQCFD7sBP268P/s3X
         uIgcsL6ZvJ8p8re+/lnt0NuFXuDLZ2HCizAuDom7DfIyECJxsKdUrW8wsKmLMaAOBZnp
         P6hee8sDr9kOT9q+nDMz0Ugt8g12c0semkUMEe5IBRZV7tuaXuvQNtbCah8nYYTLpH+T
         z39A==
X-Gm-Message-State: AOJu0Yydp3REXftxZDDJkzCdkAJ0wBCTaTXiKpSiR+aD1cfZTPQ0v4DS
	7R71F99E1TH0FariJGBIIt4eiiRk9TJkZhwgSm/RkJaT+ybpcJuP/bDsnKBX1w==
X-Gm-Gg: Acq92OGrWXwtjZ4hxGVwtpaj92Nii75ubgPqgAhghcHQfOoxS+cNxJp9QYhUM4SGnd0
	poSUkR8M/k6H6Kcf2D2K+pkaXN3Y5tdWlswJAqd1YKGWL9g3tghwkcHaL7rm0Dm90Y2OxtDtKIh
	cap0XP4RKD2MZo/wGUVtrIUGAOApwcr8F6jnu7WBPeNxLC8pyjm3wnG/XjfTRR5h5vKDS+YVSjo
	ctbIbHIBweeRqc9b9vTzS/1eUKlEvDatpuLCZJof9PZso+Es1QY40lr1yhQ9jyKrILAEcucw/du
	A0seCf79CGThDZ92IxNM/mDaBMj6WEfa8S7XA+xI2ML942o4QV7rT4YTPOSdwfQluq24QLihcmE
	zyGFK4w9cIHa79UU9y/TZHIySmLmo9yG5g2nDgzOTXZqIdJ2QvgncQcBOXYHouj0mafp95jnjFi
	VrLm+nV/OdLvjZW3jPROhg2aQ43jz81FE1XmaWA26M05/74i49n893qyXrTmmu8XqQ+vJyYRwlN
	gpj4MI/IQiBBGRACOb8Ey/PYpdqziCzNhMBhT0AXumz64D0NifA0bRB045td1cbJseGoJR3EIew
	Gd+XVbDHDCFV6MGZRR5RsAwkjeLCOvDHwvDev74ktUc=
X-Received: by 2002:a05:600c:19ca:b0:48d:46a:6e5b with SMTP id 5b1f17b1804b1-48fce9b9fb4mr49319585e9.7.1778689748229;
        Wed, 13 May 2026 09:29:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm44539648f8f.25.2026.05.13.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:29:07 -0700 (PDT)
Date: Wed, 13 May 2026 18:29:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Test reported max stack depth
Message-ID: <075d22efd4338385a92f13b7817025cc3f04ec60.1778689025.git.paul.chaignon@gmail.com>
References: <cover.1778689025.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778689025.git.paul.chaignon@gmail.com>

This patch tests the maximum stack depth reporting in verifier logs,
with a couple special cases covered: fastcall, private stacks (main
subprog & callee), and rounding up to 16 bytes. For that last one, we
need to skip the test when JIT compilation is disabled as the rounding
is then to 32 bytes.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bpf_fastcall.c   |  3 +--
 .../selftests/bpf/progs/verifier_private_stack.c  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 0d9e167555b5..8d7ff38e4c06 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -799,8 +799,7 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4)
-__msg("stack depth 512+0")
+__log_level(4) __msg("stack depth 512+0 max 512")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 646e8ef82051..2c00dd8579d1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,6 +86,7 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
+__log_level(4) __msg("stack depth 512+32 max 512")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -324,6 +325,8 @@ int private_stack_async_callback_1(void)
 SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
+__load_if_JITed()
+__log_level(4) __msg("stack depth 8+0+256+0 max 272")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -344,6 +347,18 @@ int private_stack_async_callback_2(void)
 	return 0;
 }
 
+SEC("fentry/bpf_fentry_test9")
+__description("private stack, max stack depth is private stack")
+__success
+__log_level(4) __msg("stack depth 8+256+0 max 256")
+int private_stack_max_depth(void)
+{
+	int x = 0;
+
+	subprog1(&x);
+	return 0;
+}
+
 #else
 
 SEC("kprobe")
-- 
2.43.0


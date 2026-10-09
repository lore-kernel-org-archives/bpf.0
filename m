Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760994BD780
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542953; cv=none; b=szt+YIvhM56lL2kzDz3wuReX4m0P15A5BWzginroOl91EIGigqSyO3x+1e25+KKZ0ehTyW+tMKYtRhDqWOxMCRtSckHjNr7VXRr7pQjTnF6jTkcBbi170m3XCiqOJTwf5DAedJWWbirQ7LAGPZdxhI6WLsolO77SGYXkV7oNimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542953; c=relaxed/simple;
	bh=b2tN1sxIxzJaJVRbhilXrC+iYCZNnA7WgUxURdCF5sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YadOBkau7msyMCzKbYINsUurh8L6U1sMkRUk0coNHezUBQwMz7U06KhNYm8kabQkGmdLjlucbGkfF3gGT080oDuIEjyBknaNOX+YIZwD4hw6sh0Sz3gsD3Izo0Qpdp0CcSR8FH9AofQ2T2bmiQc2fBOH3N7J0xOC5tYNCOnoth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyMop40n; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyMop40n"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab33730821so370358a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542933; x=1792147733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QdilTpoK010aqeiPO4Fwzl7zzmaifIfY0zG2tlDdfQo=;
        b=kyMop40neMavgEkcaSgA0QY3V/Y8imh/hUMDN9H3CD6HWt5AfOMwTKSe+Jey6Rc//7
         7HujV6+RdWO6BhKapThDncCyiICNh9kCpei86GAfP0HVHiT4soOMa60lj+Ey0trd0GmK
         qyBPMrE+QU2UgUUFX/TiFnzw2bea0W/T5OnoZsXm06WMfEE2KRsxcMq/2IUjgSZKG8NW
         GCAtmCiNkZaDxVWv1h6+XSV2OfXWfBOpQ3/3cakG4k/2zq003kMdZS0LJYCPtGpCx+dp
         /MYgmsgvksSAaIUplCAapht0PT8wX+fJG6s+Q8lmfXEiCsUZzG7gLBm6jm5jIDOyydT9
         0PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542933; x=1792147733;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QdilTpoK010aqeiPO4Fwzl7zzmaifIfY0zG2tlDdfQo=;
        b=tjoyqlBdhr6aOa/elqpO76Tkx2AtfrmMe8bBUQ9JTWbzD/aHgM5aj3MgmywvFWdc0f
         83SLCFqGUN2CqouFMo9y+Iv0Mr4k2kekAnO8T3fxGQmx/qtC4NV1QhCwFklrWFhNFwp5
         4o5v2fFezZba/PxIk0UX40pLOYQeMPaJHkFk1oPta5EVVohKceGtQJANQ2k7s51atqnL
         6cDMNGiZw3BDygTGEno+cj0mwyjoMeKLawsYwwpJYT1xTVCzmVcFu503wDcDKgIKVPJk
         doEACJjOkrHW4kfGPakLXPUqGp9JbRGPaY949wvQmagaRBMXbBFt/b29ttwcqYjj1h5j
         2YWA==
X-Gm-Message-State: AFq9FYLn2o2WeFjZBT6y1FGVdyfmgooSLxbtD7ZHHSRboENVRXbdcbIn
	dXpkgBue2v0eSKLzMrfTPXT69JWtg6HjDVcRQjMOk5LL2wcgE9zOPmxOrl5WaQ==
X-Gm-Gg: AYBFou3P/8Q00ylHp7vbdg1EcEmn67gE01E5wEV4NQXkf9hspdMZpuZYdcYlyvYkuwN
	BvZLQiCwwj+zlLAguU0ikKJ6dxT7TNwu4QC8gSy+4xgkRBIQFks/vnFZQSbESxuq9ZK2hwiFjLn
	Sc8w6NvGis25D0QpYJX/ocEH1olhlZCuuh6KniQuSOhfK7uhsLxw53PEEnSqvDYkzyyjJy58RIG
	aii5NzvbnR38qYf2fECvf/skrs5L57PKzhz1BUk87tLbGredtfqWghyRSPB7VqjT9T91wuKmp2s
	3OKv/1tgExVIoIQrTsfpBKcB+WTsBRa5eIj2Ed5LWLrYSnhAEZyJ1zuzBIE8OLvj4TVgYR554lH
	HnlSvFF4HraaQIWPB/kXLny3h94CluHDZLms3i8ck3Ts7wXFpd2WgU9CHnCOOrwvVnqBASpz91E
	cVvbeeHjySBlgUy+H5OaPtZMh5OdP3cJjdasSXvksZQ7CTWuizCqMi8j/CzQuS9TOV99SbmVVgX
	qKN/DRtG6RN2k4=
X-Received: by 2002:a17:90b:5444:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3ab3a60cec9mr1371162a91.16.1791542932812;
        Fri, 09 Oct 2026 03:48:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 45/51] selftests/bpf: test for register liveness of subprogram arguments
Date: Fri,  9 Oct 2026 03:48:03 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-45-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A static callee contributes the registers its code reads at the entry,
a global callee its declared arguments.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/compute_live_registers.c   | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index b274a20ed7bd..b0aaf5961ac9 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -414,6 +414,35 @@ static __used __naked int aux1(void)
 		::: __clobber_all);
 }
 
+static __noinline __used int static_two(int a, int b)
+{
+	return a;
+}
+
+__noinline __used int global_two(int a, int b)
+{
+	return a;
+}
+
+SEC("socket")
+__log_level(2)
+/* a static callee reads r1 only, a global callee its declared arguments */
+__msg("2: .1........ (85) call pc+")
+__msg("5: .12....... (85) call pc+")
+__naked void subprog_declared_args(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"call static_two;"
+		"r1 = 1;"
+		"r2 = 2;"
+		"call global_two;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
 SEC("socket")
 __log_level(2)
 __msg("0: .......... (b7) r1 = 1")

-- 
2.53.0

Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12639FCC8
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551506; cv=none; b=CvEI9ZzBItP5tYtkw/1EqNU38ImzVNn7E0OOxAsjhBBZ9xRQfbyUh80p3DJSkd2wRTUV7Tk/afYZDaJmv6FntCHsEWnZXASxgNycxC2FgGgcaKFC3a+gbteRLEUaTkogtsptilVu2cd5iJSsktg75zALrj8u2qSgvI2J1lNzHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551506; c=relaxed/simple;
	bh=N6DaW9Fp0YhcldyMvN0Ck3Ujv+hbxY6t0zjeP3rCe0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDyN9nowdCf3qgyMkLhALStboV2ozoZ0CjAYtTRvlIJEIs36eBUUMTv+QguPUXsKlzhmi4QA4RApvJwseOU+ZWQ9Lu0Y2Xv85OYSMR0KkUBzqLsKZdaAygShoJ330NYCWlnuGeNo1tYRBCDVav5WsRnbbU/00moxRE/4LvcUJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USxSswep; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USxSswep"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1393162b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551500; x=1789156300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQVUWoA7x45iUD9G/BjlX2mTaB7Twjm1Fp1QyKVPw8I=;
        b=USxSswepifRtwFepO5whC0ZBBBFpwiRKBjsXb51zcbI/5J7VOy0yZ4Hk0orohUMWkA
         0rVAqIhcshm8DmnBSkFL49IdXSHWzAk2S4qAgYNnHKMAWN1wUX2Vetuqfz0tyDKQGjk3
         xsrX2v/bsIP7apvCm6ECUgDrxbyLWiaY7bU5F+DSs13LAwm8ySvvFQWyqO8QL6N6ab3a
         u5cfvvqpSEGRC4fZQRXVnDjkosi4C/2n+00eshhS9Rxp52exK297jg00fhPo/SbnSpyG
         sm2kj2VV/MVMBl34AN2ceV6gKPO7knQEHBo7ueuZYLo14E5+nQhzWh5dzvJ1gD06IP18
         gAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551500; x=1789156300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQVUWoA7x45iUD9G/BjlX2mTaB7Twjm1Fp1QyKVPw8I=;
        b=VkzsUR3iq/O3wsib12QmizV6JdpIBXVUF3nRWoAo3mo5iNwW9F0Tx+KTVF0Xpb33bx
         q5UKU0TBZtKIZ11Q1RPAtLW2vx61GUMvmuM1VgZ9KvdPxysvIHsuEjyNAIl4cwia5GBJ
         sNCMmhP/BrR/zBWuBe+XO8143+UmCFkRz5O1E+Tsgb22zCrUItKwWy4dRoQmdof2sfhr
         qvH64Qb1B/9eZAMe+NYmsaeq5fiVJm8xk4mdeNgyzY2F8MSnpz1hZS/yZB9PUMWqa653
         iLeZM3ephwRraoSboa/a9/3zaRHQgYrvjVla77SjAzd+PxaUXXQEU+9mJw6b2aEggfYP
         OfiA==
X-Gm-Message-State: AFuF++kALc4OmO6DPRt077VDHmE+V8aaWlsWSZBClOc+CGFm7aZyrgwg
	k8KSj62bvP9AAkRh/xbrIKxsdKzAhdr9ZEKvZnEdPN/7/dHatoXU4WdwVx3Kgg==
X-Gm-Gg: AYBFou1WifzkJdcGxdwKJ3uZQKdyp/8UNSNKfwYNyJrGUDAudIsINeSi8xCLALrnDYA
	H0p0HGcA/wraPqjdqt66HXA5hk34MITCiUsbDkiVMIv46UyIv9RK936ShWF6qkGJRpZhVZkSn+F
	+sokMZuYwC8oExkMqeU7e7KX+OhklvPpUaW68jxxqaHnAEiOxkWLGeOwdZ9IjShwh7fyYD6JsKb
	vBLz7BiRgojx37/+C+wyLuBHoBMTRQklA/4y96AfSbs6IU1fmoZo/qw39txv+GmZ2qxcPas1wt1
	n2fKWRK9lgfCzGrUwhaCzQy6VFka3EGz9k8PAEwSaYZC1M7vlx2jO5c2nwv2T0Y1r7K2WvAjoW7
	nulsCY+u6KO6f8YZ1irlQzb6zXlFknfkncm+sm24ka/j6ZnE275sRxoRx6txu3jJIhJNdexbF76
	wKSLDkJxfpmKM5wY/Ia5xVOtQC67bAciVxFMwAlCdWnyxuR76p+iZlJapR/EL6xigugY5phUYPb
	xN+otJN2yavsS5U7bmSRJOz/GU8oBnU0YJivjQijTaShs87qwbKX/XQr/6zJj1agwXS6A5shvZF
	/CfKhrIJL0ulcK4bW3gqBcBsGYnPnT0+npF7sOAeXhkDcHX2jgpnafnBaYE6I2C/4mhBfYWlZxM
	=
X-Received: by 2002:a05:6a00:159a:b0:84a:65e8:137e with SMTP id d2e1a72fcca58-85ffe1099ecmr11049338b3a.17.1788551499491;
        Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 4/7] bpf, powerpc64: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:29 +0000
Message-ID: <20260904195132.141068-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timed may_goto fixup now passes the resolved counter pointer through
BPF_REG_AX instead of a stack offset.

Copy the pointer directly into the first argument register rather than
adding it to the BPF frame pointer again.

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/powerpc/net/bpf_timed_may_goto.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
index 84ecf6fa7f5d..d88825dd34fe 100644
--- a/arch/powerpc/net/bpf_timed_may_goto.S
+++ b/arch/powerpc/net/bpf_timed_may_goto.S
@@ -8,7 +8,7 @@
  * arch_bpf_timed_may_goto() trampoline for powerpc64
  *
  * Custom BPF convention (verifier/JIT):
- *	- input:  stack offset in BPF_REG_AX (r12)
+ *	- input:  count and timestamp pointer in BPF_REG_AX (r12)
  *	- output: updated count in BPF_REG_AX (r12)
  *
  * Call bpf_check_timed_may_goto(ptr) with normal powerpc64 ABI:
@@ -32,10 +32,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	std     r8, 72(r1)
 
 	/*
-	 * r3 = BPF_REG_FP + BPF_REG_AX
-	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
+	 * BPF_REG_AX (r12) contains the count and timestamp pointer; pass it as
+	 * the first argument in r3.
 	 */
-	add     r3, r31, r12
+	mr      r3, r12
 	bl      CFUNC(bpf_check_timed_may_goto)
 
 	/* Put return value back into AX */
-- 
2.43.0

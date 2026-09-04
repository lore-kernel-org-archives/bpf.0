Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B433BBFB4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551506; cv=none; b=iWMuZ5tO6ERbbT3IXD+ReZod22ewX5vBxMceaKN12dJjzd8cRtFAYPH0HnNuSsKIRoIOUA6J6gzM+tfANKTyUITI4cJCeWXfsX6z1+8ijWJHfDcQZA8X5kvx7dm5LbDFehaELoUW32XUB47iS3ShXfYck4rBLBAnXgJm6oVYhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551506; c=relaxed/simple;
	bh=7B1nbhpmBWLmPjG/0jbHLb3RgyBVGkoDinhLmCcp2wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY6doQFJw8jPAlJNwn/SgY5XzmWXKY41y9BjpYklmiKUBSqjuKO7RVJWMCHHJzsGXDXo93zMT2fOFwJGgPBF6+enNPG3cuFuMnKfzpCff5PLBOOelUfH0rGr+z8yNUfR+FoTBQfo5i5x1QcuZQmKEwj0QXReoub6gvSW7FYanxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX28FTNs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX28FTNs"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so1058743b3a.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551502; x=1789156302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
        b=gX28FTNsWgriqxF27as6e/N4RLgetAMKvKEJBswYBr0pyjVguaLz7DskNO3z8cxJp5
         Ki39bMyZjhI6GuGwLpswaHSOdb831sCg9cAF2Fn5VJQEbRkCc+fECxzsDBhxp2TQM3NI
         sOt8TPs4twOUA5Xa5kSekJG6e/+TcUWmnn5wlH75fPZEmiFjiem5l5WujT10akJT11Dq
         FfarvdnRvkTvNlrw4oYvh8VSt9XirfRWM2vFI0L5MW4q5PBCyqvyA6533TCO4st0I22A
         VziDpQSmHqEFsrHZLcaZsag5jjOYHyyERPc4X+MQxsgQ1m8sd5X3Fh4emL3VCf79wLgq
         ogDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551502; x=1789156302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
        b=sPI2k8DHKw8tA+ie6QByYOUw4qaljd2kTz2UnYz4cptoFKOZwBE50YMnsiuSGsN+wh
         WyGBwjmhA/8KGWjzSOVvwH+Vmxx/gnGCeeKC1NaWwRHGhmsgwYYo1Z7Lt0ecSVvEAGlx
         Kil6X6GrfnNHuZubf7tp33HNZL05c3lZZR0Ttg+u24eNJmebxT5l4P/mQ3sqratxdSB4
         iYCjbvyAcULvfLf9eTLwQaKcNm+f83yHGDQG4F4jO6JNMI2iSQfLe81+MOHIipQSz8MO
         rNsW4eST0chIVGDnSBLjLYfCDglvPPgwDLesrgFoIqHHHtNTUvFZDR/mB/GDSCtqeKaO
         dwmA==
X-Gm-Message-State: AFuF++lSGzBi7v+Quf+5ySGNgY0hjEyUjiXUO9kB0Uw/AmniyLJE+3HR
	C4ufVDG86FGQbCFAo2qNLMKPc+SY4tFiy5sQ7pcyinM8tdv8X3fLdG5G1pfNeA==
X-Gm-Gg: AYBFou3vH8ZFQ5vp/tLdSE92RKo/GLA/ecihyLSsYvmmnBx+xwJ03N4FFMwCkOBBsK/
	yvtaAixTxQ7zqNwlD4UDiNc1tg2enDrDSKV8ksjnSZhrB7Ez/4QuqA9vSgdYNa0zfCKsipDWsh+
	wS2seTD3xuM52LFMxXQysd2UQBsDoN9aQOGTk9gNDECpxeDN+KjVbiPj8V/ssj0g0S8db8wjNJF
	+73aGMhROCeaxB2z09M23dM/u6Lq//k3yQ6iuIfsNL4cOHwFnyA+0oRDvhGnXWfEsJA3BEA1qHu
	0v65gzEwFZ3ywIjWXOyCb9QSKqN6H9EJsDR8rqPi73MEkgnziIhMRVYmVC4zkGWArF1VM1F9haJ
	L76oEJr9NZAlr7hHqd58951nBuFnMMQ00GdipYWz+85trleyaShqYxVgRno7KwlB/vjIq3UKxVU
	7gO076yI5d6Gamm64FGej2jKPqalKgPPLznUpxbIwvjwwK79UpWC+6FF3Df+Bi3LEgEzBL7bWie
	LQf67+gp/pAapYOFOHJeRcF21c0fWCnYEd+jsbd6SeF8v1KmgK/DeziKWnoh+lCRfYCrux4qRlr
	YNSSNo0F81CzBbmoatGpdv5ul1YSEi1a1RJSSlBnR8EhEn1yqcSV7FpLetT1BmjqQ/oNALT5xqJ
	MqUkkuoT5f78=
X-Received: by 2002:a05:6a00:2994:b0:857:7384:b5fc with SMTP id d2e1a72fcca58-86169f6cbcbmr14428608b3a.24.1788551501408;
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 6/7] bpf, s390: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:31 +0000
Message-ID: <20260904195132.141068-7-sidchintamaneni@gmail.com>
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
BPF_REG_AX instead of a stack offset and BPF frame pointer pair.

Copy the pointer directly into the first argument register and update the
special calling convention documentation.

Fixes: b8efa810c1db ("s390/bpf: Add s390 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/s390/net/bpf_jit_comp.c       | 6 +++---
 arch/s390/net/bpf_timed_may_goto.S | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c46872b071ce..4098c3377c21 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1872,9 +1872,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if ((void *)func == arch_bpf_timed_may_goto) {
 			/*
 			 * arch_bpf_timed_may_goto() has a special ABI: the
-			 * parameters are in BPF_REG_AX and BPF_REG_10; the
-			 * return value is in BPF_REG_AX; and all GPRs except
-			 * REG_W0, REG_W1, and BPF_REG_AX are callee-saved.
+			 * parameter and return value are in BPF_REG_AX; all
+			 * GPRs except REG_W0, REG_W1, and BPF_REG_AX are
+			 * callee-saved.
 			 */
 
 			/* brasl %r0,func */
diff --git a/arch/s390/net/bpf_timed_may_goto.S b/arch/s390/net/bpf_timed_may_goto.S
index 06f567a460d7..e34c99982c4a 100644
--- a/arch/s390/net/bpf_timed_may_goto.S
+++ b/arch/s390/net/bpf_timed_may_goto.S
@@ -21,9 +21,9 @@
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/*
-	 * This function has a special ABI: the parameters are in %r12 and
-	 * %r13; the return value is in %r12; all GPRs except %r0, %r1, and
-	 * %r12 are callee-saved; and the return address is in %r0.
+	 * This function has a special ABI: the parameter and return value are
+	 * in %r12; all GPRs except %r0, %r1, and %r12 are callee-saved; and
+	 * the return address is in %r0.
 	 */
 	stmg %r2,%r5,FRAME_OFF+R2_OFF(%r15)
 	stg %r14,FRAME_OFF+R14_OFF(%r15)
@@ -33,7 +33,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	lay %r15,-FRAME_SIZE(%r15)
 	stg %r1,__SF_BACKCHAIN(%r15)
 
-	lay %r2,0(%r12,%r13)
+	lgr %r2,%r12
 	brasl %r14,bpf_check_timed_may_goto
 	lgr %r12,%r2
 
-- 
2.43.0

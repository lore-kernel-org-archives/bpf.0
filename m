Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19E3750D5
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812241; cv=none; b=o6PvptWTCu3h3BqA2KT/ARvlTAtu5F5NdtIHVLxsPjM5ovz4RRLpfCTHBM3u90QAZoa4J5mppKG8eA2/3r1iaSleZX1iHecCgrkcv5or7Vw6ub3mH2ciZaxw7/O4fegty7v2UsapeasbouVBcbpYjysDeNr87/mfJWysD4wsSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812241; c=relaxed/simple;
	bh=t7Ln/IuDVwV2Gh/NYDdesfc2WRWqWh0L7iicESGQ0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrMsIsso08xftiPytTCNRFmw0khfudZHG3XkJvhq6V794but2MGuWEaS1VMEj5Av0Fv7IuNPIow/lHVIEbphTaZqH9pIutX5P4KSqScVrBB/2ZKORnVsVfo81ujBCSgMIOOPlWIaj+2ZfWiNdxXAJn9q3Mqc2R4tY01iOFqPKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqCcfbgA; arc=none smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqCcfbgA"
Received: by mail-oo2-f9.google.com with SMTP id 46e09a7af769-821a4a69647so929566a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812239; x=1792417039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+xEAs8Cym1k7nPLCuR91MjLbRNFmHcnKdg4A6RMQbg=;
        b=rqCcfbgAWaP/ZYS1In5YS/52ei4hvUZU4lvS12v9RSxaA+UgjDuZUzd7iU4dtA+ig0
         P0s+Zax/4NGp+YI2mi+B/wqGM4okdBCiWO182gmWwWQlkFiu4+9iLAoxhEqUOX9B88he
         ZwA9g5VlLl4jZZ5CECkZNAw2/yf9E3WinfBzcbMhzeL0ATipgzKnx4K9wbUKDEXlVI3a
         9OFzFZTtqq7lcj1JCI8TsUwjSgJdSTPbcR2pIUGXM5gFNQer9igbIsV13SitRczXKnT6
         lN2jBWfDtSe7cf/+7WjQrM6Uw3wDh6IyU4SuFEIu7Zw6L3KFs5zR872O17c0QyETwJnV
         W+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812239; x=1792417039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+xEAs8Cym1k7nPLCuR91MjLbRNFmHcnKdg4A6RMQbg=;
        b=XYShQrSjXOQh4Q6EytnTFsBpBhhaP6cQdlKIp1VGmhf8mAIOeKPH4x5o1ubrmTR2V9
         GwTgwIId1x4gNMNkIZp/63maP3KrzNjvKpawkeaGYhP+0zrg2lwiSX+hHyLdKJ1w7GyF
         TwubAwcxRG0kpso57PrjiRjxj+gRsL8ReB+7YheGr/lg9Y1yCFjBjWYWMBA6FelrJMoq
         27h58QzJDbSD61BVE8Ejl3GVpNwI86QaYJ5tGTvVGgV4VSVcW6FVrENQ3ivWlXPIEVAK
         RNmLzAurse/F8DPAYkn3NKAs/cbe0dqo9R1TiqxBX40ri2au5hi8IFyI9U+96thOTcRw
         z5nA==
X-Gm-Message-State: AFq9FYIxzcx7+ITgzP+4aEvBB7eyThvgC4xZl4CRb63c92W2qAjRTYmJ
	8ZAr1mDErwquL3XNNeoqK8aPCFz891B9ROo1xc9qTKuczSLuaXg83a3JFbC2LeqjfPo=
X-Gm-Gg: AYBFou3Cc2kfb1xQr1b2/4Ktsh5KIcfvRU/pBX9sEBlilkwLlIwu02zfSpjqwU/ZikK
	3E0GCGGSSMB5UAmZKZd/KFJZdCvAR7pLxFNEk2tvMRFI/fS6nOSIa0mofvzyjUlpnjWeWDZuFVe
	nXVd8kJ7gBOzsKZV9j4uMc94KwvoEPqtnmu3dzp7lde1iQyG/Op17Kh51hpIPXzk3+/twoYDvr3
	TTXevclVi1eQDMMND7mrXeE4LxvgG8PDjYRue8ESeEgSQcH6uZmeDOhCiKaJrr1Abezn6+mwjJi
	VRcooizpmVkeaGon4kVkEgpHvSB0TyyRrDuZ3X3HH1wAbCPRdq/Vi+JD2fIRbcmdWciQdFNSWpJ
	qtDZQuP0+WVoeO58rZvt4GlQxzF35dxiqnl/uVtYrdNu44SrOB7LWehIonNLI2WCyNGmQNLGTsk
	6P/TlQKrEDalh6ACN2y9Cf00T2k2CfKUEymGcw4jxkhk7OF4gIG/OvhUXheyQ88IJOD9yQBWqfm
	isetpg74yY62evPtNWJSOikWPaGhmZQo79OlM5n+qRnLWUGiSuRbVvjj9MMDjafjZ4FACrj2NHg
	DKzd0g==
X-Received: by 2002:a05:6820:198a:b0:6ca:3ce1:ed36 with SMTP id 006d021491bc7-6ef100968e7mr6899650eaf.47.1791812239495;
        Mon, 12 Oct 2026 06:37:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef01dba775sm9541283eaf.9.2026.10.12.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/10] compiler_types: Add __arena and __nullable BTF type tag qualifiers
Date: Mon, 12 Oct 2026 15:36:58 +0200
Message-ID: <20261012133711.4030594-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; h=from:subject; bh=t7Ln/IuDVwV2Gh/NYDdesfc2WRWqWh0L7iicESGQ0i0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMwzVnf1a/7q+zTNTm1ntvGSPmlDopfurR/rCKlMQlN2+t my/XUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn8lmH4p7AsUZT353qD5g/XzRhWvN nhIfH5wxF3vp5E7llBx6JV3jIy3LVM5XB9cf7i3qeSDwMM1wZu2P0t4pvS2/Luq7P2zU2r4wYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kernel structures increasingly want to publish pointers into a BPF arena
to the BPF programs they are shared with, and some pointer members that
reach programs as trusted are legitimately NULL at times. Neither can be
expressed today: a pointer member reaches the program as an ordinary
kernel pointer, and sched_ext resorts to a plain u64 holding a
pre-translated arena address that programs cast before use.

Define __arena and __nullable as BTF type tags, the way __user, __rcu
and __percpu already are, so that tagged members survive into vmlinux
and module BTF and the verifier can act on them. To kernel code and to
sparse the qualifiers are empty: the pointers are ordinary kernel
pointers. The verifier side follows in the next patches.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/compiler_types.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..e97ee2d4d1df 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -51,6 +51,8 @@
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
+# define __arena
+# define __nullable
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* other */
@@ -70,6 +72,14 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __iomem
 # define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
+/*
+ * Qualifiers for the BPF verifier rather than address spaces: __arena marks
+ * a pointer into a BPF arena, __nullable a pointer that may be NULL. They
+ * reach BPF programs as BTF type tags on kernel struct members; to kernel
+ * code the pointers are ordinary.
+ */
+# define __arena	BTF_TYPE_TAG(arena)
+# define __nullable	BTF_TYPE_TAG(nullable)
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-- 
2.53.0-Meta


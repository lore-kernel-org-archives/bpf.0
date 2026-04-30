Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E204657DD
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564939; cv=none; b=BtdNI/c52mf0/alwxCdwk1Tos+oMPMTucrxn4UpAsGlYIbMd3sMkQ6ZpWU1k4WPgJpRUs6vQrBqxzUJqDby0U9qJ0bAhuyVpi2tVfrDu+WdkGPCIwCmn8tOMCtuY1E8m9r3fYdhQXwoPWWUFnB2eQ1K8JyUaxwd0F5bzhCaiAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564939; c=relaxed/simple;
	bh=/jGlD16wwf+LKViAk9+60yGEYsvt20pYf1s5W49VBcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpelkrvvWqUdyaMGSqcPvR8M4AFwjOpz47EVRwlHWbmj0EUmnP8ePcA99AmzL00L5iDuTQAMgRioU/pKPXod8wJF7nqXcD6RfLYo2OUyJbxZB6clx3Z9Om1VPDw31W14Vy568Z7cfKaP1mZxE+oaEFtoJufbliaPAmjWe5nDd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IeOMxe8W; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IeOMxe8W"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so1441420e87.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564935; x=1778169735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+aXTQmh1BdIEplotgCd37rKzWea3sfpPCHgEBxHTL4=;
        b=IeOMxe8WQdn4C06HNCCgDLPsgRsOMfz1EmZIHOx4r/LSApooHjQY28t6YV9ZXBPpHR
         bhGea/2ZO7y1udRA7hPaqGTxhtmp90uzbS1XjKSoBImnzKRoVHd/mgAvwNiDsAafAQ4F
         mxR15PJHkLXnsF6bN98zw1HNmnRBeE4vF4rfDge8zviy13i8rwUmfMVGwHyAq0MSqpWf
         zcPquwDF4MGoDIyCApFElIky3Fb/81eX2BB1gsGKlcojDp5mhawRjZCj7S5qtQdI4Spw
         Nhea6kBBAZ+R0h4DJBG5xO0wyskbhOPgBV436dq1PCzbH7TOyqPStdeU9I5WI+YkiFpa
         BM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564935; x=1778169735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+aXTQmh1BdIEplotgCd37rKzWea3sfpPCHgEBxHTL4=;
        b=LX2fIqA6h1tAteNAJ6p74Xn0WDt65FVvCjKadZ5NOZ8KofZBUNN7tP5MDV1uXAwXH0
         fcNHczUAvIRZEc+f3u8RMGM/xIfrFYJgtlaemmWEVncGmIx9WTiMmHklTBwdHmtQz/Ig
         nt+AdCnSX1UGO3CWQZd9vuQng2DNXeCOwL8Krj2OHJlPgcJMngPZJSv5VpifzNxQaC9c
         JibJgSryPCgPOYMq1o18KtAJfYSt/HCCiqKvg4qcFzGikdHsayIecDdzkshkcc1Yg4ES
         eM3SCIgckqFZb96yM81sFxOYfbXkZPZzIv1BaXiilCaHTP6FHu2sY2pxtbFI06mFJT7k
         6W0A==
X-Gm-Message-State: AOJu0YzunBfA0esBVmBMd+otx+149SZBc0owiFHvvXO9wmWjkGfkOkC6
	+hIdj9rjyk+6DNgo8PYYZjSoasXc0VseVV4TqiRPLr4g3asmVPoKVzUcR0D7TrmHFd8=
X-Gm-Gg: AeBDietpHv9ladoUW/j3z78p89J0pDF70bVog0f/TI2aXuTmRaBX2McBD60AFPZ0Ftp
	9c57WpDROacjdD1Fr1rTaGOjXv9dWaR7LPi40sXrtzpvUJm4Q9UWDEBOg05UC7L2q9vQ7YDnKLq
	Vp1tBzuqHf5vHRgHKrIjQcmn/a/zP62PpEVfe47Drs5ZPP4a1nBlfR2EWOLjbn6tIyFb0Y0E80/
	2f+XbqQzNZdzvOskUGJVOr6EHfm5hwl1JKCpcSBs6nCD5SUDZ/JH6m/S2U00CGYoiUsGUoBQ+uO
	pOxQFJM+u95H7ZuZYyH69hInKR9zLSur7F+sQQtJiOmQGM3kDMd6BWMbbOrEk2em6BKVoR8dxuz
	fYzpl66FZ++HM08svO3QKRMYHqFouXtMCuYctiwnpXv52p3AaOqHp60iKqBSgkz+8J7DG5DzyoV
	YSVpIjf9kLA2NRHT2obXa3rlqM
X-Received: by 2002:a05:6512:10d6:b0:5a3:eb4b:37a7 with SMTP id 2adb3069b0e04-5a8522ab50fmr1319526e87.6.1777564934664;
        Thu, 30 Apr 2026 09:02:14 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd551512bdsm10152657b3.47.2026.04.30.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:02:13 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 13:02:02 -0300
Subject: [PATCH bpf-next v11 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v11-1-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777564926; l=1573;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/jGlD16wwf+LKViAk9+60yGEYsvt20pYf1s5W49VBcc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJUVh+79E1cnGOyYiZVVw/mextbzRhPani9Cm+ckZYGaMiLsJdxWMvImXEI3Gf7pAz2LU6gJTqa
 sWme+Rx4bBwA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Distro kernels often lack BTF types or kernel features required by some BPF
selftests, causing the build to abort on the first failure and preventing
the remaining tests from running.

Add BPF_STRICT_BUILD (default 1) to control build failure tolerance. When
set to 0, the PERMISSIVE make variable is assigned a non-empty value that
subsequent Makefile rules use to make individual build steps non-fatal.
When set to 1 (the default), the build fails on any error, preserving the
existing behavior for CI and direct builds.

Users can opt in to permissive mode on the command line:

  make -C tools/testing/selftests \
       TARGETS=bpf SKIP_TARGETS= BPF_STRICT_BUILD=0

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 97ee61f2ade5..6094fe99b5f6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -44,6 +44,12 @@ SKIP_LLVM	?=
 SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
+# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
+# benchmark compilation failure is fatal. Set to 0 to tolerate failures
+# and continue building the remaining tests.
+BPF_STRICT_BUILD ?= 1
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))

-- 
2.54.0


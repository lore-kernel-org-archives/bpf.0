Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FB3B5302
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342099; cv=none; b=JzfLqbCSoN4lDDWQ6VeI1SMLbQ1HgljDaCr7+ymJ77KIDORsyGk6ANmSCPH3wdglNC5UWk3Cy9j7HHdJ+RTlKbh5K+pqMkcT3XIYfvcZQ1tLrl9v0KanLqSrYa9UyOwq/vKJDwpf5eDbbfmx0r71CwqUZWvmwCjwMmjU+ObHkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342099; c=relaxed/simple;
	bh=r4Eeeqlnty5JWhyFFs4PmBr0ldtcOWrItly6lcvC8Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKkwFHAfxMsB/BvUK5+/dlM2Dxs4I7HN4h0ObH/FF5no6BBNYVa+Zpz/a0ZNIix9wLijktVvUTQGZiylM+ovg8/2xSxUsgFrKKrnqFkJwheXtC6dKwgUMUMG7z9RWn9DYcmfxsfqhjdzldy466GzKOdZb3Ugh7u9QfwGJclrh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OvLTR9nn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OvLTR9nn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso74081325e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776342096; x=1776946896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg2etNAfQKZBd7rcNCY3p33XRFv6QLBK/6YkWrjaoRM=;
        b=OvLTR9nnkUjqofBJqfc1Di0qjWYEDn6IJm+pFoN018SP5viSbn1YUeL+3ftZlSuxED
         +b/YmNdslq2qM0YTfW0mRWBddssKKSNLee/aFlmqkwO85xhRNncTQGslIzeUurLO2t5s
         bpIOpxm5qrAwmwG+x0k+xZurzcEbYpUhimFCBC4RSvy3dbLQ50LqIcfTgjkEebvYbxdV
         HjAPWYRIQOOlVt9L2mdk7aG8w2wTYBj4WQw1pHFhw/TMtpyFs0P/WInWk5rA6XW/WrQU
         mdSchGFbPy626dPOU09Dn9l7WLLQaRcj1U+wc2ouYOJs2sIrNuLC8uyMNHc/XFnwmZc1
         U5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342096; x=1776946896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sg2etNAfQKZBd7rcNCY3p33XRFv6QLBK/6YkWrjaoRM=;
        b=l3kHXU4TrbdAgl+RmHOvpEZUcl+kB7tab5hlLbkRumHoGAmb6dOmbvCEaLeFv25CR4
         ZOrNZl0SY+Ck/I+MIopzb95x76AyYl4pYhTQ6uPmTZaDOlBkJZpNLgAc4WcMGaUktwgA
         vOsV2WqqoJrvvc/1TB85xXmyopHoUmPW/W5D1huzZKQbGaqqT7vuME5vZx5z4WRZBDB/
         s7ZnHyCbJlvwpBDcDDn90hiGv4eObzuQM2prsoeuE4hdqjp7YsPkZAfHx8r42ig+XPcR
         oQuuq+QvyL8U1DJXD7YTk/P6Vm5pFxkT50brDC8uU+p+yIpHU0XjQXWW3YnvXH2P9GRr
         +S4Q==
X-Gm-Message-State: AOJu0Yz5Ar703O6imhpm9caAuChdBNoLsbwaX/0PqhC6VLWKIJ4iao2M
	9udo+Z353/uN/4vnHbWsSeZv5K0Wx2KqJxYEqHHK4DRGVFd+SsssAH4Y0uOCFGEKq4c=
X-Gm-Gg: AeBDieuD/dAD0/MKPu9THAlckn0VeSfM1alrUwuoA/ZreVQwtinjLgF2R9Tri3Seap7
	DNy2q5gFQenSMsvVqEwzkFY9x79hZEnakneQjQq9NJ77/L2cbTPI/GV7lJXczAyoC0chMfn2WrL
	vrCP3eHRLkbMYm64kerAtJwRw2KKZ2qeIsiYfmJyMoM8cmSEfKXGr95fSk2aUi311VLfL20NefI
	V5y4L4+97HnYxUW9RHLRvGo6jQpomlmAm4+khjz58W8ZfS/BNTKOsiImy+YiwEB+8NUNBTsDOO4
	6aYUmCetygmkOz8Z2ceweN9pLtSprR/G7bfuRS5PUHqqEx816zzuCA7oZyfqEEdwRMw/zWdR1wN
	kDnvkL40C21DIgU7AxqCevWycKKSwNx3nZ1uHwJuGHJF7Aedcga1s7e090yV4Tgh+ESc7NPYN4k
	K/bx8/9ARAWiE=
X-Received: by 2002:a05:600c:350c:b0:488:9661:2570 with SMTP id 5b1f17b1804b1-488d67ce8c2mr352427795e9.8.1776342096400;
        Thu, 16 Apr 2026 05:21:36 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f569f4bsm6849514eec.21.2026.04.16.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:21:35 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 09:21:18 -0300
Subject: [PATCH bpf-next v6 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v6-1-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776342088; l=1377;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=r4Eeeqlnty5JWhyFFs4PmBr0ldtcOWrItly6lcvC8Ts=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMp7IYcl3451BzQO8aHK4F4373QgzlaelKKslfNxqJXSlPxFdg8eg4NfZcpJgAhyK95KEuAxrkG
 9g5UX8B023Qc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Add BPF_STRICT_BUILD (default 1) to control whether BPF compilation
failures are fatal. When set to 0, failures are tolerated and skipped
objects are reported, as implemented by subsequent patches in this
series. When set to 1 (the default), the build fails on any error,
preserving the existing behavior for CI and direct builds.

Users can opt in to permissive mode on the command line:

  make -C tools/testing/selftests \
       TARGETS=bpf SKIP_TARGETS= BPF_STRICT_BUILD=0

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 78e60040811e..c8ba8ccc2c6d 100644
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
2.53.0


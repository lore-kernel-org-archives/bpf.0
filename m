Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7C3D333D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405406; cv=none; b=e8deJ7P47RJ+Mx4wwTGv3ezISCp0EvLdpxe7arLya6VwTbcHIxUZScRRoge2nu6PuVF5QAwXdX06fNlkqqLtA0aJw5M5AtdP4umQYNsQI+rQ6cwuleWV7JZX21uRybnnAmpmOSUKXveGtENXzcAzrHn2JrBeA2OxOaNw7h5O1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405406; c=relaxed/simple;
	bh=GDZbYvQUamOFYqe+wDRuXBL1KE4AYy5pkKArBFAUAWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvwZwoQIjJmtl8vYx1uPR6DOhJjh3m89NOS2ROpJS4skIdqdjzDvyinWEacgSQ3O3XFMutC+J6UG5vrcXvrSYL3lze21Ivh5/ZzKs42WHA7WrXlUE6vinv7GBN37iQxMVTakYqB6j7TUgV7AbeYgqkiAiuKskL6wogGi0OpcK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VvcGyynQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VvcGyynQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-befd83e0521so94340066b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405403; x=1781010203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZypcCVdQoLHHXNUwPT3EyFR3TdxTd7mb2pLyq2WFR0=;
        b=VvcGyynQ2HtbsI3DV4lCMhzcq42FWTy3LtGVqZoMbZrSJIGhi/wsoB8wby/L7MPRv+
         K3ganoO5F227NgfF68y7nctlqEKvpTbSUSg7CMM3p9OWUTi5XFQpHm4gF1xknwyBaArG
         UknMjsIF1uH5f/r26Yujs2t+uE7rpc/Gc8pBalQvK+Ln+orqt5RKJFlASPpcq5UdC3lC
         g4/DI7ZyCeHdN6Epw4w50INMQKidOj90c1WNVWTyxhveJvnkQ5hJjVaN/ypsPkc9ikVW
         BEt3YExf4xso0rKgGer+xMiJOSnNRd+oQLL1ZtZJENXbo32zhZyr3aGvHkzcif3lgZrc
         K6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405403; x=1781010203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZypcCVdQoLHHXNUwPT3EyFR3TdxTd7mb2pLyq2WFR0=;
        b=VAIy0VMssmWzEPjf+AA/bM0j1Xx9B3dfZrBbK5uq2ENbDnPEzzK7EVmtpT6w+NjQf8
         ZNQHmOORc8Dn3E6JObf6RHaGNR6grWXiFW7eQTVXgmgkbfGn5nyxQJyG/kXPwKp2xBHL
         QDNLirF7K5XNNi8neuzWA978nEQWHf6MC91qU2OPrHBpYiv+Y8l63+TOKvce/t2C1rNC
         OrgORM4iKWA1mNOzPEV9oGdKuMfkzGHgUpG+/a9Wt4LyweNMuQ7zcdRQcP4eiAfiDjjt
         xF3kmm0iGQOQilKddLbSs2rJU8UbQR0ZSv4xjiY9xcCdSbjWBefoaY38yYP8MXXyjRHE
         LI7Q==
X-Gm-Message-State: AOJu0Yzq90Lo5ksuiUCCM6gOz2+xsNMgXjxaI+PwHtQdkzu8uIdNf3iR
	TYZrBV7O72ATTFtCN6sto5iar7Gu0l2GGOC+tWjmEh/PpqcxhwLF1CM955yxVpsV1T0=
X-Gm-Gg: Acq92OH1KNYJD2wQntuERqqwtDZKSZV5f1ePtf1gTb5BRLNzfshjGlzi0gJSL6zBC6p
	NqPkcPs6nGbjillLPVoBq/HXZE357GpRuUInmUtrq58Py3H5olMCGW5/43+Mn+mIGx3kTOkmgSd
	TIZwnJPU0TY1GpE0p1fBuw6KR+e+FWRT2+hXXidMmAi4iIqhq4lp4dqsxmrvDWxIp5V0NGJ8EJl
	qj0ikw4aekImM0GiICbgZri301NrlVZXAc80gPa60kIPGeuv5LsgsOMCZcvrLieV+lfjl4QppU9
	pbYYevDSG6XU9hHkfPi3lb4HAf9/M03la0NUNGeDTVuVw7wznPGGnlt962KYcP3bBmBeU8WCckL
	rgdpJXQNfXCwu1D7wC/Lz8nmTvjp+i5f+fr6lOIKXNaO96wFyVRHdjmMkpwwOs2qF1YUXbC/rSK
	lnpm+Ti5VhQShwacQslFP3ydIg9znsuytd
X-Received: by 2002:a17:906:c14d:b0:bee:d554:f33c with SMTP id a640c23a62f3a-beef57fbdebmr208259266b.0.1780405401970;
        Tue, 02 Jun 2026 06:03:21 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bee8899dd5bsm176361766b.23.2026.06.02.06.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:21 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:02:50 -0300
Subject: [PATCH bpf-next RESEND v12 01/11] selftests/bpf: Add
 BPF_STRICT_BUILD toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-1-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=1573;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=GDZbYvQUamOFYqe+wDRuXBL1KE4AYy5pkKArBFAUAWs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPZE5O73neptr/nVHQlz6qoj/gAhVpUqQ41Slol1ZYyw3dxCoSxmAPVUrEPlcTP7dTwRAKVf8wo
 JaX29rXsJVQk=
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
index bc049620c774..75036c1b5c4f 100644
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


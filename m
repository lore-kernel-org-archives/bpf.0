Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EE351C35
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473247; cv=none; b=Ww7MEzhnZm0E4IrmTAmNw7tK57eeIkk/+yEqRTN1nwBeNRAN0+DLvIDspgPwgmVG6TPRqrn0pbVYBzp9P6KPa2ssXnD4+M7g8fK9gSYBKTKLjKg+7DiSLSRv8wivKB3Od7glVHnjUg7Ul+J5h/dp15andVgKieNY6tgGlKVUaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473247; c=relaxed/simple;
	bh=/jGlD16wwf+LKViAk9+60yGEYsvt20pYf1s5W49VBcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+JAIM8PeuHNLR15I32+Dn0Lji8FQYV9JUSM1gYkrpZcanBA76A/qWwPzKB8EZIYJVvEcV3gGrWevr+6mDwuhD3MK0c85siuU57tRjW56P0uykog5bOxApmFNO5OgFWYKoRq/gd5+Z6GGQjKwljqo5sL7jdcN251TBiO+WWMXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BmS4Jyh9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BmS4Jyh9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ad135063so116164675e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473244; x=1778078044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+aXTQmh1BdIEplotgCd37rKzWea3sfpPCHgEBxHTL4=;
        b=BmS4Jyh9E0EmReORmI4X6oesHJskUJHEthMkSVrMaFbfMUrYkLfYKyYjFkxGZnxEP/
         eJQClibtcSTNwfa/PqAANs2ZTBp+InqFB84BxqfT/5/CMj4w4w2NJ/yw6ugLoM7p//Tq
         /xNYgZSzdpd9O2eDJcSUKZUjuFGDyZ6r994gCSqjI84owtCXgEWCSoc8TJldwByRksIR
         MDq4aiyZsrsOcuY1JWwL9ZEPsFuvxPw7KYWuI/eDpv6ZsHS3P45qPfNFTP9JfcLE2qvZ
         g6ZO+0uXy422sJ8NpPy4MmqmRiizjLMTDQrVIeg8HnS3uOqXYKnabrHCW35r1BC2/jbx
         G3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473244; x=1778078044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+aXTQmh1BdIEplotgCd37rKzWea3sfpPCHgEBxHTL4=;
        b=rAVzrCDJPtez5Kg3RT7FcrpRplnPtEmBiMjwtUJPiFPFavDX+eeHw4nF8yREVgN5UH
         R9LQq+tClbAdSgxIZ3S4hWSaphk/WITKuNiFJoz/pk/YBYAMumka6hMspsuNMz5YXPqT
         knexsntnWEeDdRnXJiilmvyHrdc5VU5pvu8+mTHME9+9N5NVFp/aR30F5Npm5Zf+GcSP
         6mo7LZRS9CjaaiofC5SxNXClBPaxYp7g59RfWXPbpeTzcHVa/JO9BiPndTHYpqjSEmbV
         JWeGeEOGKdbLcsx5RYFK1GTPjoGEkVvA1n5gZTuDJNu7srcgtzjqi5Tv2agWWdmKRdHC
         +qdg==
X-Gm-Message-State: AOJu0YxQOadrSznwa9uj9oru+SFbygodicMtJ+J6bDDI3QdrG8C2pRsQ
	TM3t6fB4GLKZHvpPzyZg9Lxv0EYTPWVkoaepcuosF7/8dcqN77U8TWRDeA4d50KICEU=
X-Gm-Gg: AeBDieu66S37e4jJrsGkYcIQZrzactdvVQWM2njlI1UToDqpJ/XI99bngfC9Rr9lIH0
	MuP3ZkrXbkZ5bmf8p5MPVXROkgdK0thErzxmCD/dAeTWpr6sLEsTbZNryrBeHdor7MuUAjv7jgX
	A68Xb6uPWQsGy34ywc+X1O8uO3j3JvH5D2IIR1Z3TPhwpGLblJpxVz9hPm4wNHmEx0cAE4AYHz+
	Ftc22tLlZw9InulVXyq7EjWe10r3vAuE78JeK8a1Bjp56SyQQGRinLshvlrCWqJDqWgNOtCRAvu
	k1FviTgT2IYbZyr6/Nv8+3zaxQzWaQGpDFaP8aYt/v36qGZYNgZQtgF+B7XcImxj3v9IBiW30S0
	aCjdYmPbN9dTgCE+OVFYWApB5Oy73Ay3NCbVrKoSd9ZitcRVGfHqYh/ob2A2MHIOvyAeD7kddYT
	270U0t7uVhRB+LtytzLUz9dHdY
X-Received: by 2002:a05:600c:4e47:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-48a7b51afc3mr73608905e9.7.1777473244392;
        Wed, 29 Apr 2026 07:34:04 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6dfa5b4sm1169873e0c.16.2026.04.29.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:03 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:43 -0300
Subject: [PATCH bpf-next v9 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-1-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=1573;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/jGlD16wwf+LKViAk9+60yGEYsvt20pYf1s5W49VBcc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEGDVsC8EGeTXG071G4XgQef138ami7i7vTJ1mqjJaT6WCeOJy5D2FjPUcqICYhbPBNduoybfNX
 mgv+KrqPWOA4=
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


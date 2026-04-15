Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BB38C433
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286776; cv=none; b=HbGiSPwt1ihc/WveliL7WksT69nSORBnzYVq7sZmLqxIFkqsGgG+n0CYJl/3+FDLcL5XK1nepAd1OGwQaAxN58h0bNSAF3Gq7hqUjCiixGqbFatm0JxzS5X9Onc5wP1DhP2mxyeyRNcZDEhk5OHwg2aQTSjrDgLL5BgqLcvBE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286776; c=relaxed/simple;
	bh=r4Eeeqlnty5JWhyFFs4PmBr0ldtcOWrItly6lcvC8Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EV5DVBfbkhfo08tcPC9yWUGbqAupuZryV6I9NEEb1Q660tgF2WyogRSOZmGueD5Hf4PZ2GnjCYRLI/RBbieHOLbwi345P/+Kfr2S25uGdt1mOTOjzv2jYwC1xefy+mMj0aO8iPJzwE9xbrLT4EmOmAW/PyLW2K49yF78m/QCa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UO6xBlmq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UO6xBlmq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4888375f735so72231335e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286773; x=1776891573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg2etNAfQKZBd7rcNCY3p33XRFv6QLBK/6YkWrjaoRM=;
        b=UO6xBlmqDVBc0rPzQXvG9lOWiReITyiPcTQ7ZwnlUAYuMuk7jUq1S3xYMdAbYdaYh5
         l+fO09VyoopGQXmw974+vosU8axuUd92LTjwttgndsAHy4L6u6VP4somV00FvBwTPRRO
         uGBi144giY35IPE56yObbdNKKI1Vb44vgG87o6V7Kx02RFQeX6bXS559YKTpmjXAl9DR
         fk8KeV6VGcchCqXMJ/bDZgX+VpLgA/8CNw+E3jf+aXKklocuhaR4VsyUmsnHsA+VNQ+S
         1nEM1c88yPl0x9nV66gvtKzBng9KW+0jbAXSRmy8Ix3FA2U9gux5l3dOyIJceBG1eCO0
         r/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286773; x=1776891573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sg2etNAfQKZBd7rcNCY3p33XRFv6QLBK/6YkWrjaoRM=;
        b=Ibp/z4C0YmxGNJLeBXyRAOnV/hzpH5FGD3BUDLXTHuxMXAZJzROURa9fr7FK7+dF2t
         3A0zBuKlSyvKLvtY4pKKEAAbQckew5WnYD5FZ3BQwO5lj4rmBhUWu0fHToXSZuDNwnkq
         86fTDdGAnPXdcYl514SkYq0G036u8noIQ5LNWou1XLNZKclmh65gHDFI41l6aiQkUyR6
         YL8moG4yPQJgHjvkvxTAT3htX5smmDd5/ZTDixaQ8WtCo41HkyxmKEOuhmDq3gBbuueY
         rhwFukPj/yfJQOJXwDfH5wNXEzk5G+ac0R8K9yYlmC64Nvp83nXMsn22NS+Y1LTDJ5wS
         QHgQ==
X-Gm-Message-State: AOJu0Yxln+a3jT1M1tMO7VCGSMGaBzErKSe6N0jNbfWcpTLG2vAuLYs3
	BsN9rcoX8zkwSnS+aTDUHNTW+529ntwwwdJpvXcUDTqgv0OKfDpT6euKzJnJw3CGN4U=
X-Gm-Gg: AeBDietIRfNpdDVUp2IaaQeRIA/Z3ievddbPkg8Vn/KB+68j3E/MHhjoQAPYlvLPHzf
	wb3eQtUeugOtRkViVQ5+kDmMqH6/Rwv6y+NoVoOeicEsTHnYi1twrH1wHi1WLJuZTnGhM/Lgg7M
	ZJs1XchmQmSIrEROS1rnykRSs5djYDjjf9jndEUKHSiYzvLp6rg63YdMir3ZFtn/5oiIPJJU/Bt
	LBpWrdQ/RfN6Pc3SSLUKvhLvxxvTl93xq3AL7uxJEc5cSXDNNtXzW/Ariv67c/qC7VOqxgzehZh
	kaPqbG+JbnzVLVRPJhDNH1+ye8TJw+dEIN87RaZmsLtSLJL+3lFNRjDV4cqHStAugvMMIbkHYwj
	CCJcgg0FXULvX7l9YIMXY65WanW1sV89dYarbWmrvg9cAFFNqzMLId0PtzHBXkcYn1Na2+eiYro
	ks8NsCn9X27t8=
X-Received: by 2002:a05:600c:4e48:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-488d6858368mr328090195e9.20.1776286773498;
        Wed, 15 Apr 2026 13:59:33 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606925sm5430460eec.12.2026.04.15.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:32 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:19 -0300
Subject: [PATCH bpf-next v5 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-1-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286764; l=1377;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=r4Eeeqlnty5JWhyFFs4PmBr0ldtcOWrItly6lcvC8Ts=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFYAv4WgAhzm3x9f07EKaYC1RXISsv6qSmiucrI5tHvTzF/Rk1cy8FTrC/AbeumqsIE8ElCxr0k
 76aamKQT2lgM=
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


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6A3EF658;
	Tue,  2 Jun 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411658; cv=none; b=LHkEnpNK0SSUus0dTYcbcRQxMPGzYr0+LCjv1N8jK8HkljTBDMcMKLPkf9fxpJEZ2X7/gqmuZxjwlbo8cwlv6/ihPLRG8O7uC0dgyCk8oaJ6Q+2EcDdKIwEvdSOskTz1AtCvkxNaDSGzOdmXgazVUTR2A6BE0mlMrNhhJ2e8UME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411658; c=relaxed/simple;
	bh=x7cZMt2bdvciDxx6hGzYMUYeiKiePmRdhY+wP37FvBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSjdM1EshduqfEOX4ZL3mdJ+f6ihKDjeqAdkTLy61g/9RoDxqLnFxnbJeoFsCUa2HL7Mw5Pj7LbYDQrPE+u0jn/LS89LFB3geMXAoPqv6QDm4eBzRMVDBwGqUax0sDe9PFi7zG9l0NNQkMIB0RKXwoq2ioONtQWL2/mqWwrpCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bAWV5RQX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bAWV5RQX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899C02B;
	Tue,  2 Jun 2026 07:47:31 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32463F632;
	Tue,  2 Jun 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411656; bh=x7cZMt2bdvciDxx6hGzYMUYeiKiePmRdhY+wP37FvBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bAWV5RQXAxIvK4CZtbqhPng8ge68XfgTYs8SRPm8Dop3NkYMC9P5tt5puKEvK/AJN
	 TX4E95jKFrpMa+pEYTb1Wwz58ipqocBxnjeXv8C8H5EkcQuAtMJbq3zrX9wXdH+yjU
	 JXjEtlT2OfBK8zECm+8TYrxJNeVKjmboydgyF2wE=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:12 +0100
Subject: [PATCH bpf-next v2 3/8] bpftool: Append extra host flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-3-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=824;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=x7cZMt2bdvciDxx6hGzYMUYeiKiePmRdhY+wP37FvBo=;
 b=7LNfWhRMlyI7VhOkEtDSekJ3ixPBft1J6UrrC+T/O+LuO713EeVH9Z5m9SBp3vviYH2zg6utx
 eP//X95OUEJDOQaTBV++DsA86oAhG8tHe3Wah3Liy4G1+BxCVqh5rbU
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append HOST_EXTRACFLAGS to HOST_CFLAGS so that additional flags can be
applied to the host compiler.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 616c14247e4bb690e16ae4ff8c1992e6d4fc863e..96be5647f0e1370247025d65e813db376b146e52 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -87,6 +87,7 @@ endif
 # including flags that are not applicable to the host compiler.
 HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
 		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
+HOST_CFLAGS += $(HOST_EXTRACFLAGS)
 
 ifneq ($(EXTRA_CFLAGS),)
 CFLAGS += $(EXTRA_CFLAGS)

-- 
2.34.1


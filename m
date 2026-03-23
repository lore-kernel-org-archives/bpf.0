Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C63B4E8E;
	Mon, 23 Mar 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280435; cv=none; b=qeQWsWBV0wPyp29/kkHrf4VgzKT9/4bL3IBD00kni/QljiSyIuonofMIaTPZQNWV/trjX1H5SU/2K/LkbQwC150V7C1DddOTTlKwK+x/ydlgewnlHrTvAT6XeYBq+60pWYwo/yk3SXk05Wy12nu2+ZWA4x0JYzcFbwCJfq7sXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280435; c=relaxed/simple;
	bh=RbzWvHVPMM6ZwIg9QOtNftjDOGjDOKJxSvUCxQ4+gxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oo70kzFhxZhj65w3TXaEeGLYJ1tmIYN2wA6X8o9OfJH/7ROEvymwja2PlPB0YAOzQeFVpuvLAiuKhmjqoERuA8JiWboUjSKy/rECqdwo1UmTcGbIMY79avH0ki30YvigNkFdeDVf3OW4FJpEJmHLtRbeFHfSQewBQThco1YTUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE48C16A3;
	Mon, 23 Mar 2026 08:40:27 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10FE73F694;
	Mon, 23 Mar 2026 08:40:29 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 23 Mar 2026 15:40:03 +0000
Subject: [PATCH 2/6] bpftool: Append extra host flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-tools_build_fix_zero_init_bpf_only-v1-2-d1cfad2f4cd1@arm.com>
References: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
In-Reply-To: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774280421; l=824;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RbzWvHVPMM6ZwIg9QOtNftjDOGjDOKJxSvUCxQ4+gxQ=;
 b=sdT2ls0ptgMiCSYPqtZDxFu3HyRPrJnVyuA366Nciznm01sxzXVqEGNECEp51pVCc0f13Fstc
 KgdRbMBR8W5CaUO3vwJZ1/VkBIswsbOPkknqKxuxEdNHPaFgA5dW1m0
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
index 5a14185407a2895ba0167802e555c1113e1991f5..adec4fdf43dab525609d7d378843f5d3ec072213 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -86,6 +86,7 @@ endif
 # including flags that are not applicable to the host compiler.
 HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
 		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
+HOST_CFLAGS += $(HOST_EXTRACFLAGS)
 
 ifneq ($(EXTRA_CFLAGS),)
 CFLAGS += $(EXTRA_CFLAGS)

-- 
2.34.1


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F63B4E8E;
	Mon, 23 Mar 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280432; cv=none; b=uEv9DUiwf1VXmR0pAHwrbFqPG9n8GC16q1wP9UBhihUQUeAmK2VmSBvoN7svRjaWHQK4yP/9RPwzsNcQ/y0Er6KDqralBftG55UWdEfYfSgFL5kIXHFHdcyur/ii3AbWc/50v4kgTmDuchgU/y6oeHD0MB0xueaCebOm6QbCsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280432; c=relaxed/simple;
	bh=/OoRSyce1xBSzRHNQcVKDJadSwKzqz+190gXk0b+TAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGJLxFZ/YGcukLSVG9B24ZP0mXlXqZeqI16Ib9HGrntdk73Nz/NfH6g0d6K9d2XJT9C0j3r432TjPKNtsgbTlGp68YAiyqRMA7BRQotchLmNoqBSs8xlauCyekWXDzqVCOmwurLQn0gIH0OQ2XNroSUARPUF1smKN02wMlZQ0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17A1169C;
	Mon, 23 Mar 2026 08:40:23 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050643F694;
	Mon, 23 Mar 2026 08:40:25 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 23 Mar 2026 15:40:02 +0000
Subject: [PATCH 1/6] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-tools_build_fix_zero_init_bpf_only-v1-1-d1cfad2f4cd1@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774280421; l=1436;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/OoRSyce1xBSzRHNQcVKDJadSwKzqz+190gXk0b+TAg=;
 b=AZJ3LqrB+yZvRm5iiP4Mcnx6Ey+IpRRf7xjtO3J1rH9y7IIBdGIFlcKS5eIqqn9e88MNRCCWi
 ztGXXMbYBd5AGi9Wv5EgTdVneHWaQhvgwNcQRMUpAfGZQk6Bp3z6M+n
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Prepare for future changes where EXTRA_CFLAGS may include flags not
applicable to the host compiler.

Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64656035dfe93cd15cba090015587a..5a14185407a2895ba0167802e555c1113e1991f5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -81,6 +81,12 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 ifneq ($(BPFTOOL_VERSION),)
 CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
 endif
+
+# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
+# including flags that are not applicable to the host compiler.
+HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
+		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
+
 ifneq ($(EXTRA_CFLAGS),)
 CFLAGS += $(EXTRA_CFLAGS)
 endif
@@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
 LDFLAGS += $(EXTRA_LDFLAGS)
 endif
 
-HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
-		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
 HOST_LDFLAGS := $(LDFLAGS)
 
 INSTALL ?= install

-- 
2.34.1


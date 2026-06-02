Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272C3F0755;
	Tue,  2 Jun 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411663; cv=none; b=grK8v8EhtTUaCi7GsUQZPhQE+/0jHe43tI6LPcHP8i6g+Qkqj4avUxSPdQKyUIsHGPoii6LHDIhIV2sUMBN4V26g4YSfXiK7F37IlaWRC9ornql76JGxN7JdGzVrgvyeK4SZi1JKNd7wmy2+Fh+nNy74ZvWHpXzVmTA+wxI7ijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411663; c=relaxed/simple;
	bh=IWbL8s6kDVXxb7irKM9RRyKWD+H39SbNVArY0xlKstw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soPeyP9AL2YYvDQZbQK0srbgg4/ZsGdhP9KaC9+hFIlArGPSF6+w5ns7CuEgwSx0PUduz/dX+x8sJTaJInlEcMb0ZfZdGgQb4mB7AZheXOSDWjZpqdSg/Phu/Q01CIIBjTliC1CrG4fYvzX43BjtHUpHIe3jbX6xz+jP7fVWu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=swGmSUO2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="swGmSUO2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65C13497;
	Tue,  2 Jun 2026 07:47:36 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF49F3F632;
	Tue,  2 Jun 2026 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411661; bh=IWbL8s6kDVXxb7irKM9RRyKWD+H39SbNVArY0xlKstw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=swGmSUO20NIisccu2dXjhTuNBjmK8mt/g0D4vcSM8Wy43i0eksdVQv/WidZXWyrcP
	 ulpECny9XHIjjwnRpNaRfZxvOga6V31dA81smNlxx1EaYak3FANgVHM81Ky4THPD3v
	 TUHxa9ygFscjIMlEMVWPyPGaApKzWIr/vpNEzaHw=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:13 +0100
Subject: [PATCH bpf-next v2 4/8] libbpf: Initialize CFLAGS before including
 Makefile.include
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-4-c76e5250ea1c@arm.com>
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
 Leo Yan <leo.yan@arm.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=2272;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=IWbL8s6kDVXxb7irKM9RRyKWD+H39SbNVArY0xlKstw=;
 b=vNpyYO6ES8PZJyibEbEj9YTGBHPGfwezz/gUbInMy3sGfNdwzrbxn8DJgkYusI0tD/7AjF9pw
 GRMgEJcWoH1BbK1P76l+UnWMMoUxdzdVInNi+OQP3Tob1iacv8Al3cv
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

tools/scripts/Makefile.include may expand EXTRA_CFLAGS in a future
change.  This could alter the initialization of CFLAGS, as the default
options "-g -O2" would never be set once EXTRA_CFLAGS is expanded.

Prepare for this by moving the CFLAGS initialization before including
tools/scripts/Makefile.include, so it is not affected by the extended
EXTRA_CFLAGS.

Append EXTRA_CFLAGS to CFLAGS only after including Makefile.include and
place it last so that the extra flags propagate properly and can
override the default options.

tools/scripts/Makefile.include already appends $(CLANG_CROSS_FLAGS) to
CFLAGS, the Makefile appends $(CLANG_CROSS_FLAGS) again, remove the
redundant append.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 168140f8e6461bd06db40e23d21a3fb8847ccbf4..eca584fb061e16013e76827e4203f6be0477a73e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -49,6 +49,14 @@ man_dir_SQ = '$(subst ','\'',$(man_dir))'
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
 
+# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
+# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
+ifdef EXTRA_CFLAGS
+  CFLAGS :=
+else
+  CFLAGS := -g -O2
+endif
+
 include $(srctree)/tools/scripts/Makefile.include
 
 # copy a bit from Linux kbuild
@@ -70,13 +78,6 @@ LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
 LIB_FILE	= libbpf.a libbpf.so*
 PC_FILE		= libbpf.pc
 
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -O2
-endif
-
 # Append required CFLAGS
 override CFLAGS += -std=gnu89
 override CFLAGS += $(EXTRA_WARNINGS) -Wno-switch-enum
@@ -84,7 +85,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
-override CFLAGS += $(CLANG_CROSS_FLAGS)
+override CFLAGS += $(EXTRA_CFLAGS)
 
 # flags specific for shared library
 SHLIB_FLAGS := -DSHARED -fPIC

-- 
2.34.1


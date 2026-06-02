Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287CB3EDADF;
	Tue,  2 Jun 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411654; cv=none; b=Ie5ZAoQkDTUrzk8/RrecWObkVkCXIyQyVPHDadMfp48mDJWCi+u0sxgfIGP+dHbDwXJLlr4KEie9Ct1e4shL+orIYH92ULf/uESo4PDMpONR9LaMsyo3cnmMJNLSFBgotT1YACcFBnBNvmvawISXN/sEaxX+6TChfV1/445P12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411654; c=relaxed/simple;
	bh=ftrGfPlCpSuFDSQHacVgFrG56NXWBlICsaIhKhYspOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQMtoHGzF9FfgrjDWrNdNxJylhH0UH3w/J5yuSkXdKZfbUroL24bR6dw7g1p1mOpSbEuFpe2WSCIMC17E7fBWoESNDsaH1rhmeUND9xj+zLh+SxbLWfbC7zBe/5bmG0UsPG0i0/4h/GUlLgpyTiKaOOhZ7JhOInr4Z+Nnn2hf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kz7C7LPY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kz7C7LPY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABCDF3576;
	Tue,  2 Jun 2026 07:47:26 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36AED3F632;
	Tue,  2 Jun 2026 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411651; bh=ftrGfPlCpSuFDSQHacVgFrG56NXWBlICsaIhKhYspOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kz7C7LPYODIKIqfd5uOjRjmm0FSiTgiFxsD5SnXCq+NC1it0enSnZ9PsDlfY5C/8N
	 5JOdu0idcRRgVsGvaPVEwbQ1cKoOLvy8sb2LvH4eaDu5q8OoqvMG8UIMN/FdngYmMU
	 0orJR0UTs9pJei071XKoO5kF68kXPw5koHvpCvYM=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:11 +0100
Subject: [PATCH bpf-next v2 2/8] bpftool: Avoid adding EXTRA_CFLAGS to
 HOST_CFLAGS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-2-c76e5250ea1c@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=1462;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ftrGfPlCpSuFDSQHacVgFrG56NXWBlICsaIhKhYspOQ=;
 b=Ltv4m0kswXfh6oi4eVR3XrM95ptbINRZyDvGwqzaj/PJqOAH4qarP3lCKMgP/1QlhwTJhuFIG
 5EiCMNrc6cYDHFCAVI7DyWAHbg07JYw6y20D+okGlWMb2jL8HSLjAjU
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
index 1f033e578f90a2d6b93168ab41399de758bdf659..616c14247e4bb690e16ae4ff8c1992e6d4fc863e 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -82,6 +82,12 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
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
@@ -89,8 +95,6 @@ ifneq ($(EXTRA_LDFLAGS),)
 LDFLAGS += $(EXTRA_LDFLAGS)
 endif
 
-HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
-		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
 HOST_LDFLAGS := $(LDFLAGS)
 
 # Remove warnings for libbpf bootstrap build

-- 
2.34.1


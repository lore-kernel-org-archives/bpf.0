Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533973EB7FF;
	Tue,  2 Jun 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411649; cv=none; b=SAZOV/krCNYg/xynYd6A37lIl016x5x7zKdZbQsKEQk1nUFZO1s1T0EL2cEM5tSGWKmTrv4lkb8bpwXULfCmLLE6i+ECNRNgUYC+Qan8S9hYfSc62gLWxfisiI0ntRHvmDUIT2bBFcI+pOayUWmjhXMEFNP/GnTkSl2mi96sh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411649; c=relaxed/simple;
	bh=+bPMqBjWhP4el8DDzLN3UmoeC6gA35HpOFjMwmSxEuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJJ/Ckv09/wzXTNmHIGSyFt3QYM8bQtrjnXpPMmKBI607yX8oqGBa370aqlfzTCvDWv4dWDLJ3neFfg7VXMHUkfwlCKxz6SBqgp7K7fbM9jzgopL/MyO2PTNNB5bzTsBGdXgclRCOz0qOGheEBTk3DFWC0KZc1ewSzGpWWDdRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AKR3BxFk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AKR3BxFk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4B1C356D;
	Tue,  2 Jun 2026 07:47:21 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706EF3F632;
	Tue,  2 Jun 2026 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411646; bh=+bPMqBjWhP4el8DDzLN3UmoeC6gA35HpOFjMwmSxEuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AKR3BxFk7xb0YlmAfRzyNzx2sm6EcZVrNNd+zeQEImE7ip8DGl6VYQN+XVxORJ7X1
	 6yrkrxgQat9ymy1JMFLi2KauKj6Bq0MXtqr85RAva/mL62yNrIRUN7KXzQEu2JXob9
	 eISO8Nfmr2XK6Ge0BXTtMkxMXiFIYHzm5giFsBO4=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:10 +0100
Subject: [PATCH bpf-next v2 1/8] bpftool: Pass host flags to bootstrap
 libbpf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-1-c76e5250ea1c@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=1945;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=+bPMqBjWhP4el8DDzLN3UmoeC6gA35HpOFjMwmSxEuo=;
 b=PEHBmgSuakarM8vWBq6KZrpVfK7rlR0JRdLE08nDVmieBHCg2ve2luSMU7W7N0CObN7GkLSey
 KR+SGo+dTg5BjY3ifzGxSseD3C/yheTKKdiKxLyXqk/O3CXaR5lv4kq
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

bpftool builds a bootstrap libbpf with HOSTCC, but the libbpf submake can
still inherit target build flags through CFLAGS. This can break cross
builds when host objects are compiled with target-only options.

Since HOST_CFLAGS contains warning options that are not suitable for
building libbpf, use LIBBPF_BOOTSTRAP_CFLAGS with the warning options
removed to build the bootstrap libbpf. Clear EXTRA_CFLAGS so target
extra flags are not mixed into the host bootstrap libbpf build.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64656035dfe93cd15cba090015587a..1f033e578f90a2d6b93168ab41399de758bdf659 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -47,7 +47,8 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
 $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
 		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR:/=) prefix= \
-		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" $@ install_headers
+		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
+		CFLAGS="$(LIBBPF_BOOTSTRAP_CFLAGS)" EXTRA_CFLAGS= $@ install_headers
 
 $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
 	$(call QUIET_INSTALL, $@)
@@ -92,6 +93,9 @@ HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
 		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
 HOST_LDFLAGS := $(LDFLAGS)
 
+# Remove warnings for libbpf bootstrap build
+LIBBPF_BOOTSTRAP_CFLAGS := $(filter-out -W -Wall -Wextra -Wformat -Wformat-signedness,$(HOST_CFLAGS))
+
 INSTALL ?= install
 RM ?= rm -f
 

-- 
2.34.1


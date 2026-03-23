Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA553ACF03;
	Mon, 23 Mar 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280427; cv=none; b=dKKUgj74I3jaMgIpVvglsv5gYZPdJ1xdthuOCkZ53oFHI7AEv+d4mYuKIFxI6+zNX036qMaN1oi7MtRz9n7W9Rsck+l+3drtQfqTKOeXcN4lFGoxumUAc7ULP75XH8SOPDMcNjuwCLzB6OUshNdFA7En9HZVR3MAyF3Fwa+W8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280427; c=relaxed/simple;
	bh=dmJtugznhbCVBxfks7NXmKAW85qMgx0JwEiyM2WXk1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dFkHlM0DLMknrJvBZNK7zFGacMAXm+rF4p2yUZDnWRIvZBKTm08QJu47qUtLe9G4Do7qqUdtLhcYIdvZ6dHNQhnSA3RDAu0172DXM+iiHEf1+8uN21bio76NxtyYGt/4cyS9Clota0ZLjSg+qPEhfQlsJ+2WIhHnarvsLV5wY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B718714BF;
	Mon, 23 Mar 2026 08:40:19 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC5DD3F694;
	Mon, 23 Mar 2026 08:40:21 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/6] tools build: bpf: Append EXTRA_CFLAGS and
 HOST_EXTRACFLAGS
Date: Mon, 23 Mar 2026 15:40:01 +0000
Message-Id: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFewWkC/x2N0QqDMAwAf0XyvIJLUcFfGSOsM9kCpZHWjan47
 ys+Hhx3OxTOygXGZofMXy1qqcL10sDz/UgvdjpVBmyxbz16t5jFQuGjcSLRH22cjTTpQmEWshR
 X1yF6lB4lDAI1NGeu5jm53Y/jD2DunYx0AAAA
X-Change-ID: 20260323-tools_build_fix_zero_init_bpf_only-52232f62fb7f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774280421; l=1746;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=dmJtugznhbCVBxfks7NXmKAW85qMgx0JwEiyM2WXk1M=;
 b=pDk+t/gZoGl0LBFFRSGG43Xc/hBFWqXeTrVVzAClNhU8kWi8VmLGhVLQ3S0WrAE0rpkfm3QeV
 ToRSQjY5ZnGBkY614IsqMTJ5S8YAz5ZviEMcdjPPEVUTEIoITR7oyj+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS and HOST_EXTRACFLAGS to the BPF build.

This mitigates an issue introduced in GCC 15, where a {0} initializer
does not guarantee zeroing the entire union [1].

The common changes under tools to support EXTRA_CFLAGS and
HOST_EXTRACFLAGS are sent separately [2].  As suggested, BPF patches
would be picked up via the bpf tree, so this series only includes BPF
related changes.

Verification (bpf-ci):

Test 1: With full tools changes applied
  https://github.com/kernel-patches/bpf/actions/runs/23439834394

Test 2: Only BPF changes
  https://github.com/kernel-patches/bpf/actions/runs/23440507945

[1] https://gcc.gnu.org/gcc-15/changes.html
[2] https://lore.kernel.org/linux-perf-users/20260323-tools_build_fix_zero_init-v6-0-235858c51af9@arm.com/T/#t

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (6):
      bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
      bpftool: Append extra host flags
      libbpf: Initialize CFLAGS before including Makefile.include
      tools/bpf: build: Append extra cflags
      selftests/bpf: Initialize operation name before use
      selftests/bpf: Append extra cflags

 tools/bpf/Makefile                                    |  1 +
 tools/bpf/bpftool/Makefile                            |  9 +++++++--
 tools/lib/bpf/Makefile                                | 17 +++++++++--------
 tools/testing/selftests/bpf/Makefile                  | 10 ++++++++--
 tools/testing/selftests/bpf/prog_tests/verifier_log.c |  1 +
 5 files changed, 26 insertions(+), 12 deletions(-)
---
base-commit: bfec8e88ff6022b056615ec71506703e7e54de82
change-id: 20260323-tools_build_fix_zero_init_bpf_only-52232f62fb7f

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


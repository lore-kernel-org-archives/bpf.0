Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487363F2115;
	Tue,  2 Jun 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411672; cv=none; b=t8ffYfKOq01TwWkvTAZ42VkuQEjiJeviZBfyVU7xdkjBtZCl2Hsb1PIuyRPqggfkjAnWdHEXPJozSFE9tn3Cmqs8pb7mwUgoi73nbsejhWF090Clk74mxGSV50PCEzgnZytVv3ODwCKgrc1uJ9h+opIWxJiBb0GVKeclImAqr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411672; c=relaxed/simple;
	bh=GLUFbbIEHS0K9sAkY65AIMIBJlV7lJXIB46SducMo/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN+VvlvX+9HhE0K/yw5nmDVKS1wCkp5q1PvP35QXvmZbL7SEZZmWSHaZKxcFPRpxXS0GOpsndNdxNYwx6/E2SjfoayRnc+FE3mSC5Czb75xZXR25pswoZHZCIO1KYODfJgt/ABfFIc8wl0o5wzIFxlBJD4pOVn14Jy/ycHC40JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D02CeUF/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D02CeUF/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA7E03560;
	Tue,  2 Jun 2026 07:47:45 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7269A3F632;
	Tue,  2 Jun 2026 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411670; bh=GLUFbbIEHS0K9sAkY65AIMIBJlV7lJXIB46SducMo/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D02CeUF/kZjFaBUr2nqAaink6RjHRSFLEhkOHVwT7nZmeYkPJCkEACzeMoV79AyU5
	 4FMx2kamJbQDZkvaQfBoZC6OtNcfphmb3HlvT+GgcKG/CdtC1BD1FPITCXAZNvFeUo
	 9VPXVKaMz/a8A4QGJLc28Auh0Ytr3HjlCmvlgJI4=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:15 +0100
Subject: [PATCH bpf-next v2 6/8] selftests/bpf: Initialize operation name
 before use
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-6-c76e5250ea1c@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=1077;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=GLUFbbIEHS0K9sAkY65AIMIBJlV7lJXIB46SducMo/c=;
 b=63cu9sDDg2Uz0Wc5e/+QysEkWtM1JbgeG8xJVPiOdWZ8bRfEo1F7xW3cTb/FEeWG5oWNMfs19
 qrfEQ+WzW7UBJwEEFH7HkCgTVsvwvacSMBbB0QJmlyodoAa9uj3JJ53
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

ASAN reports stack-buffer-overflow due to the uninitialized op_name.

Initialize it to fix the issue.

Fixes: 054b6c7866c7 ("selftests/bpf: Add verifier log tests for BPF_BTF_LOAD command")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier_log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index c01c0114af1b7476d27885ce380d90400a4bdc89..4542bb586d723b8fda2faf8261066f16102c60c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -317,6 +317,7 @@ static void verif_btf_log_subtest(bool bad_btf)
 	res = load_btf(&opts, true);
 	ASSERT_EQ(res, -ENOSPC, "half_log_fd");
 	ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
+	strscpy(op_name, "log_fixed", sizeof(op_name));
 	ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name);
 
 	/* validate rolling verifier log logic: try all variations of log buf

-- 
2.34.1


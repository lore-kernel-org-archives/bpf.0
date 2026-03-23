Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EBF3B584A;
	Mon, 23 Mar 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280447; cv=none; b=mFPUSZocDXulAydtUMMzJw1U/0B/vP9dtntxW3w/+aENPzhp23v6VC9QkEHaShH6gnnyRyZOhDZB8DUkGY2M6ciyccJ78Bc0ulqjLyFieiLbj71SUZfG0U2KN9dVLQ9U5zrTqguWGmQ1QKAkmcoO8nuXGjG4JywiMbgNy1TE+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280447; c=relaxed/simple;
	bh=rYNo8XPHR13NOfEGctHALckOR9FuoNu5duTDbJBWXzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdCBRr38+78mmjGTt4A9JYjl+nTriA0v7XTbQeTnC6b6jLMw7HVmPpeXxV4Y1MT7SdvBcz/io1AiGmbJW+K54UTop/tuAkuAY8SlGASSrRCjkJNuI6X+kroqC0ZV7xnilEHcpMXHJAOi9DIjJRWx8kgxOfI2dAb/C7hfkC4S7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F13DB16F8;
	Mon, 23 Mar 2026 08:40:39 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351473F694;
	Mon, 23 Mar 2026 08:40:42 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 23 Mar 2026 15:40:06 +0000
Subject: [PATCH 5/6] selftests/bpf: Initialize operation name before use
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-tools_build_fix_zero_init_bpf_only-v1-5-d1cfad2f4cd1@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774280421; l=1078;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rYNo8XPHR13NOfEGctHALckOR9FuoNu5duTDbJBWXzY=;
 b=yD0flLirzs1eHaIrDMPcyYaiJjUVV25J9vWKzOg/3Ot0P4YbsVRXrDEoGpUiQiNtyENh/BQD8
 o5FmdwFXyQlCk24+/h2G5xasRczDEk9jppae7kn11853DvY2kQ41vND
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
index aaa2854974c0a91cbbb9fc13ae0f966de1bcc818..dcbe2ef995c5b211c2b86b9555c02144e11ee7d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -317,6 +317,7 @@ static void verif_btf_log_subtest(bool bad_btf)
 	res = load_btf(&opts, true);
 	ASSERT_EQ(res, -ENOSPC, "half_log_fd");
 	ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
+	snprintf(op_name, sizeof(op_name), "log_fixed");
 	ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name);
 
 	/* validate rolling verifier log logic: try all variations of log buf

-- 
2.34.1


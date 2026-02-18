Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B661285060
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374678; cv=none; b=fhaQ2tjUlkHeRRuw2gD6ujYTR5TdXXF9yKIUMQfPvKr7qxTpkUSOdz7nnF3DL5ZHu475sGtWpSy1q1vBhQUhrIcFCFwjbuXOirm7zmr2O+FMOH9BeCiRFwyTAvVnLXiL7J6uQmSr/PckYHf0tDLdVuDHjqweuYQ2xLGgzZF1BGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374678; c=relaxed/simple;
	bh=M+dUUNDfpAIzgLSnvfWveVIwWVTjzjuQu5215zF1QPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOaOS1djQNGITh7ig7VmdMC/6RhLzaVowGAjI6XOcytDUyVFnQtBlAhyf6sGLYv4RxW0YW9vt8uY7CuV+L7hb0LdP8dSTJ8tY58JIlhoTl06/TtHLoOATok1zlfn2hVrV87SD4Q2Ccp6+5LVKtRLjE/sKmFxA5JxjdCHV/+IP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KiBMagpm; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KiBMagpm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Isk3MgJEdESYLCNKsJ/YFa6h9vV90ljBAfMCZ/hOcpY=;
	b=KiBMagpmF5+CVJVGTkfiOiNCfgUv3LBbMdACi5/mCKJ/+6OxnKuSLq5dAZQ2/Ip3gtYeX9
	zbb47e7GrVRxDnHF2Z2c6fMqrYa8ykGx0m7QyakgoqKNK5YP9GrLbkP0eJj7LCtYtOztSn
	uLcW5zg4F5b8GSMyecXDqwXoAnqbhJI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 03/15] selftests/bpf: Add DENYLIST.asan
Date: Tue, 17 Feb 2026 16:30:29 -0800
Message-ID: <20260218003041.1156774-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a denylist file for tests that should be skipped when built with
userspace ASAN:

    $ make ... SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"

Skip the following tests:

- *arena*: userspace ASAN does not understand BPF arena maps and gets
  confused particularly when map_extra is non-zero
  - non-zero map_extra leads to mmap with MAP_FIXED, and ASAN treats
    this as an unknown memory region
- task_local_data: ASAN complains about "incorrect" aligned_alloc()
  usage, but it's intentional in the test
- uprobe_multi_test: very slow with ASAN enabled

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/DENYLIST.asan | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.asan

diff --git a/tools/testing/selftests/bpf/DENYLIST.asan b/tools/testing/selftests/bpf/DENYLIST.asan
new file mode 100644
index 000000000000..d7fe372a2293
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.asan
@@ -0,0 +1,3 @@
+*arena*
+task_local_data
+uprobe_multi_test
-- 
2.53.0


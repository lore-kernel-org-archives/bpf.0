Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94D20ADD6
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858866; cv=none; b=QlbTAwQX4NETKLQFbm8VuNUosRzI9Y1DZPT4l445lZneAAghbzhAGOhDQqDv16oLp9XaCQ9YZ0UYZRmmCNCbpzu86qH2WDyBcF7WQlwZsoUlHdTn75Le0kFk4UzYeffuGYduiHjHet+rZdDtnPRCna6e89u3LRUJQ5iCIp7ckRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858866; c=relaxed/simple;
	bh=M+dUUNDfpAIzgLSnvfWveVIwWVTjzjuQu5215zF1QPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQekrUHiqXgsxqRGSI+ByLzZUAstebt/cf6ZNRjp9C1rH7oWT8G/lxdBckTR6WX9Y/vTP9aGNTrIU6UNVyLIQhV6TicOzh13TQO2DfSrd01/vprgZ2jyMOAOdm7sQ0AhXHSSAQKxrPkuQS5NdhXiGn6j5bMCMpnhXzZpGw0Bf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4JPOcUa; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4JPOcUa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Isk3MgJEdESYLCNKsJ/YFa6h9vV90ljBAfMCZ/hOcpY=;
	b=T4JPOcUaSu/ujXXPp4R4wXZX23a4Myxc0mo/Qw1X9j901BNS8IxRyu/GT6MzpLYQbjkVXq
	5Xidjk/p9Vpa2RqH7ykMIQpWkw/xHFiwp/mO84Z/fsY6VO1DZ5uYSB0IxfkLykX1CqzzCo
	uyukM4pAsnaa2kAZXkIpZAxVcPoWXSY=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/14] selftests/bpf: Add DENYLIST.asan
Date: Wed, 11 Feb 2026 17:13:45 -0800
Message-ID: <20260212011356.3266753-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
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


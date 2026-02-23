Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEE36AB4F
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873705; cv=none; b=thA6n2rg7Rp0bxdgGhT3Q3HfWpcKJy6z3jLkK6vtDdlP02Wah+Bz4c3dnhqTo6J8o0M23H/2JU1e0hHeUAVBVq2bMHcHeDgE8/DRJ1RjL03MACBbLruxWdJLHuxhK5lsjf3ensCiHaFrPYCoRSx0cXrOv8t6x+oF68X2D75ZkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873705; c=relaxed/simple;
	bh=M+dUUNDfpAIzgLSnvfWveVIwWVTjzjuQu5215zF1QPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHM4ZH+zmrgiQy+4sFaOWD71CJal625LIOAwIPF2esM1o0Ta9ypW8ydbIzekyAw6FGTDF11Kqbg6ak2DeNT4i3IqlelgJELRAOdvj86TXYYTcfKOQrda+dbk1ad0+SkdfHN17B7xvey2AUoOlCNpXnc7I8yJC7Wzz9FafnRGqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o6WiMp3X; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o6WiMp3X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Isk3MgJEdESYLCNKsJ/YFa6h9vV90ljBAfMCZ/hOcpY=;
	b=o6WiMp3Xuo6fhpu6HIbdKkICFOiD5Gxw3x5eYBC0aQ8zdsFfi1itG6nPoujDq2uuH49iBh
	cfHteoAk4SpxLPAnBPbzlnFvR8dNODvcDFYaVWBJmb9jcRPzE/MwnUWIryvsf4017HhbDK
	wui2bKljsJLPcxoBrE6yBgkbvQRyoqI=
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
Subject: [PATCH bpf v4 08/20] selftests/bpf: Add DENYLIST.asan
Date: Mon, 23 Feb 2026 11:07:24 -0800
Message-ID: <20260223190736.649171-9-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
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


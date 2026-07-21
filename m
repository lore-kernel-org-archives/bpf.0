Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF54071E3
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654505; cv=none; b=UfbYK+TdyIKrII38aPw82Cp8sVJ/LgZyNANfhxJAU49p5CHlEjxmogjWn3jPFITagpdIyl9EsEcgp89IP8S6bpOlfNrOzHg6woNn05qkutqnuMNDhchUndAsTrHzeW6q8ekog5GNluCkcwRrvtGSnQN3OEqLhILnFHsxv/d9qrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654505; c=relaxed/simple;
	bh=OTpnmaxOY+Q0rjxDgWTVI6wJivqIDUOJ6x15A7Z37TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCEGCT4npFfqyb93K42P8i8Jp+BiPOeMZlQRasLlLY6VHkdLxgOu14noVfZ469Ghuhe1dhH59D8k+ARRDlagfDKdo5JmrlQGEhDhIGZJJOh3qTT3jP5EDPDK+tkKnATQvoL9ntvMCVvRNi/MTRWbh2BCXe5s0w/U2jMV2oa/izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eletlQnD; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eletlQnD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784654500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bfcoZvf38Y3wNg8KQgGVFmAjslIy2xMAIjpkM2biAVw=;
	b=eletlQnDXn0+eENapvnfznpCMSVQVyQxq11Hd75127HohLjrTC87n/a31I29CGrde8Zryu
	6YQRVfpldSTsglmXXMpyB9YzL9VqnwKi6HibsuWcnpgzh/AkpqBcJRIiFfDA1LUQJ19ISo
	Pk+VNCrdCH688dliGyvpNqASekmgGOw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer
Date: Tue, 21 Jul 2026 10:21:04 -0700
Message-ID: <20260721172104.3689982-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add myself as a reviewer for the BPF areas where I've been active.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a674e36529f7..e45807bf019e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4916,6 +4916,7 @@ R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yonghong.song@linux.dev>
 R:	Jiri Olsa <jolsa@kernel.org>
 R:	Emil Tsalapatis <emil@etsalapatis.com>
+R:	Ihor Solodrai <ihor.solodrai@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Supported
 W:	https://bpf.io/
@@ -4976,6 +4977,7 @@ F:	net/unix/unix_bpf.c
 BPF [LIBRARY] (libbpf)
 M:	Andrii Nakryiko <andrii@kernel.org>
 M:	Eduard Zingerman <eddyz87@gmail.com>
+R:	Ihor Solodrai <ihor.solodrai@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/lib/bpf/
@@ -5041,6 +5043,7 @@ F:	security/bpf/
 BPF [SELFTESTS] (Test Runners & Infrastructure)
 M:	Andrii Nakryiko <andrii@kernel.org>
 M:	Eduard Zingerman <eddyz87@gmail.com>
+R:	Ihor Solodrai <ihor.solodrai@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/testing/selftests/bpf/
@@ -5055,6 +5058,7 @@ F:	tools/bpf/bpftool/
 BPF [TRACING]
 M:	Song Liu <song@kernel.org>
 R:	Jiri Olsa <jolsa@kernel.org>
+R:	Ihor Solodrai <ihor.solodrai@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/stackmap.c
-- 
2.55.0


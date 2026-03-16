Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA213B9D8C
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679184; cv=none; b=rNtlTOlNpw91ZAQY6WPHOOt/zEgmTvdSaS2RdiLg8CDPBrcjRZX3u6L8RaMS1uhe4V776qGPp8HuSbEkriXmt6EaWhz0Y9wK82IPFE+EdWaW4hpmPpIXPgawa2fRJjgYSJZtWVZP2JhBs/yGr90QvSGvE2yfXHk1A8nUAtkncjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679184; c=relaxed/simple;
	bh=0D05SSbbOtH9KHf+uzPWomtPJhcBI4UTYryhu4sgQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG9hg9M5PunKBDWq5mS41tTrO+08dYVKf1nU3T/j4RJmf7x+RGyGFk7386DsIf4q58wOhdW5d7I031BRGf7pkRf4b96jnetx2m1zjGlmcfjMxCSS7gLPsjZdQDkpTU6f3B/P6sTmIyN/eEpgUoJEEwX+xK1MjVdwN/6HNnLzYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S9sfEU2/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S9sfEU2/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773679179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MBpxxSBk39pQ2ubP8iPWJ3nl3q3sB13xGSQQNF03I+8=;
	b=S9sfEU2/rls3aNis3q+7ETlgs8kcSe0MJ7W22z1sZIHFnlafUBhKdL6ZIxXyeTT/lMOJAm
	hktb/Q+4nb/SCu1yOtPaUGVPPPGcxruOu9wV6mE0aJsxsIWDsOkziKCq9osNafOVapb70s
	f/rXvEhXwhSFT+b3WmQMM8e6SZfwlCM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: Start v1.8 development cycle
Date: Mon, 16 Mar 2026 09:39:16 -0700
Message-ID: <20260316163916.2822081-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

libbpf 1.7.0 has been released [1].

Update libbpf.map and libbpf_verson.h to start v1.8 development cycle.

[1] https://github.com/libbpf/libbpf/releases/tag/v1.7.0

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d18fbcea7578..3526c937bdbe 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -455,3 +455,6 @@ LIBBPF_1.7.0 {
 		bpf_program__assoc_struct_ops;
 		btf__permute;
 } LIBBPF_1.6.0;
+
+LIBBPF_1.8.0 {
+} LIBBPF_1.7.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 99331e317dee..c446c0cd8cf9 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 7
+#define LIBBPF_MINOR_VERSION 8
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.53.0


Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC92F49FD
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611632; cv=none; b=CAw1dgmkmSt6rZQnyvpJrj4v5Jm1Oci4alb6D/GQuAJVo2BxE2blHumrlcamf7SC03+LpbH/sOs+zfq83fleLAkwmjg22w0VY1DtIEhWyL6PI4ze/VCB4MdgZzPzGWtPtHmVeTW4fGovCRBvY352NKTx41mvcXRCEWNw5tF3p4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611632; c=relaxed/simple;
	bh=h63tPitGQTOEsgp7IyxevOgPfZ7aaGbP/6iva5qm2dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inTDTjjNkmXJ9vqxjc0ROHZ/RqPO9iFPlgGfBOZ+JnghuA+BI1Fd6MW8rQxDfnc0KZq19FjyKodgM0mo/3L0CRO6gdgMDdn4D2Co0iqdzTkkfjPXRYCfwhm9Mg0u66NIhQ8qnukLisUMvmN3Mq+Y2xOUdvJYld9nZ6//4L5qCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M3TEKyAl; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M3TEKyAl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCihQ6qjS+RPI+DS8xNyMGMASH1EpWMeASa7I1Y5ymw=;
	b=M3TEKyAlq2KYqv7OxiLyaq5/kwV9YSYrV2bJttbmrwX0C1fPvOzg1fPF2Otw6h22SNsjgS
	qOqMEuKb8zHWQTSKAZK/OLSg2xnXln1G6fUeOrxdLPnnIQ90ARg3JDb0a70s1OudnNO6hr
	5VH0+AprWFhW6ZyybhapRVff26FDInE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/7] selftests/bpf: Add strscpy_cat()
Date: Fri, 20 Feb 2026 10:20:06 -0800
Message-ID: <20260220182011.802116-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260220182011.802116-1-ihor.solodrai@linux.dev>
References: <20260220182011.802116-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add sized_strscpy_cat() to bpf_util.h, which concatenates multiple
strings into a destination buffer with strscpy().

Add strscpy_cat() macro with varargs.

This is a convenient helper that provides the same guarantees as
strscpy(), but for a case when multiple strings need to be
concatenated into destination.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpf_util.h | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 8c95ef7ed7c0..61bb22c3e517 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -52,6 +52,34 @@ static inline ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 #undef strscpy /* Redefine the placeholder from tools/include/linux/string.h */
 #define strscpy sized_strscpy
 
+/*
+ * strscpy() analogue that concatenates multiple strings into a buffer
+ */
+static inline ssize_t sized_strscpy_cat(char *dest, size_t dest_sz,
+					const char * const *srcs, size_t n)
+{
+	ssize_t pos = 0;
+
+	if (dest_sz == 0)
+		return -E2BIG;
+
+	for (size_t i = 0; i < n; i++) {
+		ssize_t res = strscpy(dest + pos, srcs[i], dest_sz - pos);
+
+		if (res < 0)
+			return res;
+		pos += res;
+	}
+
+	return pos;
+}
+
+#define strscpy_cat(dest, count, ...)					\
+	sized_strscpy_cat(dest, count,					\
+			  (const char * const[]){ __VA_ARGS__ },	\
+			  ARRAY_SIZE(((const char * const[]){ __VA_ARGS__ })))
+
+
 #define __bpf_percpu_val_align	__attribute__((__aligned__(8)))
 
 #define BPF_DECLARE_PERCPU(type, name)				\
-- 
2.53.0


Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F936654E
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611630; cv=none; b=VcsYC6jkDks5BxX+pRo4r1LfqmO7N0ZakYgQz8F+RWIKk2GWcutvenqjrXJRqgkUOz9gUJsLmnNHIBoUy9UfIQtyUrGLEwz0jal4j6IQpaOTJDAFrDrxO8LViubb3NNogkfWOe8muHZm51hm+HOisCoZnwNyb39pfovdiyaRVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611630; c=relaxed/simple;
	bh=5rGPeJPf6w4YpvFN5Ca2c5lafn9ScyA2xpGvxTnzCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju/YNPIEoW+S6P8jMM2SyHUnadyVXi0iHrrm6nKPLQgwIgLzPUl6YxHBWRMAAwGOv09Jj1d+MJ+1coP9jVyZL6MKFwLmpzPTEYRqrx2rBE1KqkrnAGnWE3ReYW8iKgEXKAXhTcxUYR8OD5FBJaEDiS1GhKmYcZN94PJKjRc22p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jMfe4WZS; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jMfe4WZS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zM4hi2wr/55oi9+YRDxF/pe1IGahl9NLf8Kax2WDvcs=;
	b=jMfe4WZS/NXHkZAUUZl4D3nvFHAiNwZvy0H3NAgo6reMRtAYxpcgdk7nkX87w5c/ICr4Fi
	9w+Rb0b+ge6LnFTcfKzzfx89DxOr66uKFKTo1nSYJekw84D0SN02ryTtNHswsh1b8cegUx
	WR+o716VgMubZxMQqkEQ5EdvhYpaJBI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/7] selftests/bpf: Add simple strscpy() implementation
Date: Fri, 20 Feb 2026 10:20:05 -0800
Message-ID: <20260220182011.802116-2-ihor.solodrai@linux.dev>
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

Replace bpf_strlcpy() in bpf_util.h with a sized_strscpy(), which is a
simplified sized_strscpy() from the kernel (lib/string.c). It:
  * takes a count (destination size) parameter
  * guarantees NULL-termination
  * returns the number of characters copied or -E2BIG

Re-define strscpy macro to sized_strscpy.

Fixup the single existing bpf_strlcpy() call in cgroup_helpers.c

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpf_util.h       | 38 +++++++++++++-------
 tools/testing/selftests/bpf/cgroup_helpers.c |  2 +-
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 4bc2d25f33e1..8c95ef7ed7c0 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -21,25 +21,37 @@ static inline unsigned int bpf_num_possible_cpus(void)
 	return possible_cpus;
 }
 
-/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
- * is zero-terminated string no matter what (unless sz == 0, in which case
- * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
- * in what is returned. Given this is internal helper, it's trivial to extend
- * this, when necessary. Use this instead of strncpy inside libbpf source code.
+/*
+ * Simplified strscpy() implementation. The kernel one is in lib/string.c
  */
-static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
+static inline ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 {
-	size_t i;
+	long res = 0;
 
-	if (sz == 0)
-		return;
+	if (count == 0)
+		return -E2BIG;
 
-	sz--;
-	for (i = 0; i < sz && src[i]; i++)
-		dst[i] = src[i];
-	dst[i] = '\0';
+	while (count > 1) {
+		char c;
+
+		c = src[res];
+		dest[res] = c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Force NUL-termination. */
+	dest[res] = '\0';
+
+	/* Return E2BIG if the source didn't stop */
+	return src[res] ? -E2BIG : res;
 }
 
+#undef strscpy /* Redefine the placeholder from tools/include/linux/string.h */
+#define strscpy sized_strscpy
+
 #define __bpf_percpu_val_align	__attribute__((__aligned__(8)))
 
 #define BPF_DECLARE_PERCPU(type, name)				\
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 20cede4db3ce..9661cceb62be 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -86,7 +86,7 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		bpf_strlcpy(enable, controllers, sizeof(enable));
+		strscpy(enable, controllers, sizeof(enable));
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
-- 
2.53.0


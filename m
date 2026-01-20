Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30440B6CC
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906834; cv=none; b=Yynlz/fZpZLBORdFFaUdfYJ43calvXBKB9IN6O7o5iAxxy2zEFDAljc9nws4mbXjGg4eHcd6E5TIBsmMKnr8PTekSBMdBv5h5cLb6QzTqYh2ibPgO9KqxqzCK8lA9XR4d8GPPKyCdOiMoJmLZc4z6lGCMGMs9KaHKyNVbQhKUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906834; c=relaxed/simple;
	bh=8+Zmx/iAJxe/zaasGpX4p/DH7QDaBlAn0s1osix+pho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRJI+XESd9CeB76uno1IJMDH3g4o/xbzVQGwbDBlseW+NgoCZiZ8IG8n989ptQJwq2k8zTyvw0HQFafoWpPSp3gaClcefAgJ566nstXGWQ9GumdseJX9RNlP/x0rdnNQEnJ82yuZbfvtbOn6U4U1rDtfQ7+Tj5ViVbsrTUKh1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: alN1IeM/R8epPS5qSpjxUg==
X-CSE-MsgGUID: wWk2xP9sSFO66mpF6rEPlQ==
X-IPAS-Result: =?us-ascii?q?A2EPBAD5Xm9p/zcImYJaglkCglWCW7ZoBgkBAQEBAQEBA?=
 =?us-ascii?q?QFaBAEBhQcCjHonNwYOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQUBAQEBA?=
 =?us-ascii?q?QEGAwEBAgKBHYYJU0kBEAGGCAYyAUYQUVYZgwKCdLBngQHdei1UgSYBCxQBg?=
 =?us-ascii?q?TiNUnGEeEKCDYR9hBp2hXcEgzCUDkiBHgNZLAETQhMNCgsHBWphAhkDNRIqF?=
 =?us-ascii?q?W4IERkdgRkKPheBChsHBYEiBoIVhmkPiTOBXwMLGA1IESw3FBtCbgePE0eBP?=
 =?us-ascii?q?GsHgQ57NpALB4d3jw+hEYQmhFEfnGhNhASUFZJSLphYpFmGZoIATTiDIlIZD?=
 =?us-ascii?q?44tFst8aTwCBwsBAQMJhn6KbIF/AQE?=
IronPort-Data: A9a23:KN1qTq21aRlxFM5XR/bD5XVwkn2cJEfYwER7XKvMYLTBsI5bpzwBy
 DYfXmrVOquOZzamKot2Od+x9BlUvp/QxoIwSFFvqSg9HnlHgPSeOdnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+an9T8nk/nUGtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn/glaYDkpOs/jd8Eo15Kyr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2zhc+RK9
 Tl4ncfYpTHFnkH7sL91vxFwS0mSNEDdkVPNCSDXXce7liUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwITQrNzGOoqWMkL+jctIxn/87LtnWM9ZK0p1g5Wmx4fcORICGT6jO5MFVxiZ2m81FW//VI
 cgBAdZtRE2bO1sWZwxRWNRjwY9EhVGmG9FcgFOOpasm6m3a5Axp2/7sK5zId9fMTM4TnF7wS
 mfupjynU0tCZIPPodaD2m2ThbXfpXLgY6w1SuO97tA0mnCrwlVGXXX6UnPh+KPm1RfvMz5FE
 GQV4SovvKE3/WSrVtK7Xgb+vXOP+BcXHdhIe9DW8ymI2u/Y7gKYGGUeX2QHddEt8sY9Az4yv
 rOUoz/3LTVrluS0RFfazOeZtQuJZDEuNW0SWCBRGGPp/OLfTJcPYgXnbO4LLUJYptjlXD39x
 zGUoTIv3fMOgMVN3q79/0ivb9OQSnrhE1FdCub/Bz3NAuZFiGmNPdTA1LQjxawcRLt1t3HY1
 JXE8uDHhAz0MX1yqMB9aL9URu72vqft3Mz0nV5iV4Qn9iqg4WWiYZEY5z82KUNkOdoefnriZ
 0rWpAVQ75ZPPXysdsdKXm9wYux0pZXd+SPNDKCEPoATOcMqKWdqPkhGPCat4owkq2B0+YlXB
 HtRWZzE4aoyYUi/8AeLeg==
IronPort-HdrOrdr: A9a23:kXvVHqmvwAuLCLtyDQq6HQ5FfqzpDfLX3DAbv31ZSRFFG/FwWf
 rOoB19726RtN9xYgBEpTnkAsLrfZqyz/NICPYqTM2ftWXd1FdAT7sSj7cKoQeBJ8SWzIc06U
 4HScdD4bbLfDtHZKjBjjWQIpIN5+bC14iNqY7lvg9QZDAvR4ZeqzpIMyrzKDwOeCB2QaMDMr
 ehzPcvnUvHRV0nKv7iJn4LWYH41qb2fZvdEGM7Li9i0imi5AnYj4LHLw==
X-Talos-CUID: =?us-ascii?q?9a23=3Ar+XtP2rt9w9b5gsen71duxHmUckhVCT8wVKXGR+?=
 =?us-ascii?q?1EV5SFaSuUV2Axawxxg=3D=3D?=
X-Talos-MUID: 9a23:aVEVqwXeahiBYRvq/CDTh2tyDJZz2IqJVh4IibtYoeS8MRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106920879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 20:00:28 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 1BF8E1839FBB;
	Tue, 20 Jan 2026 20:00:28 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v4 1/2] bpf: add bpf_strncasecmp kfunc
Date: Tue, 20 Jan 2026 20:00:10 +0900
Message-ID: <20260120110011.1805037-2-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_strncasecmp() function performs same like bpf_strcasecmp() except
limiting the comparison to a specific length.

Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
---
 kernel/bpf/helpers.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..6c36f0fb5da7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
  * __get_kernel_nofault instead of plain dereference to make them safe.
  */
 
-static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
+static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
 {
 	char c1, c2;
 	int i;
@@ -3417,7 +3417,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 	}
 
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
 		__get_kernel_nofault(&c1, s1, char, err_out);
 		__get_kernel_nofault(&c2, s2, char, err_out);
 		if (ignore_case) {
@@ -3431,7 +3431,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 		s1++;
 		s2++;
 	}
-	return -E2BIG;
+	return i == XATTR_SIZE_MAX ? -E2BIG : 0;
 err_out:
 	return -EFAULT;
 }
@@ -3451,7 +3451,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
  */
 __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, false);
+	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
 }
 
 /**
@@ -3469,7 +3469,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
  */
 __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, true);
+	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
+}
+
+/*
+ * bpf_strncasecmp - Compare two length-limited strings, ignoring case
+ * @s1__ign: One string
+ * @s2__ign: Another string
+ * @len: The maximum number of characters to compare
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1__ign is smaller
+ * * %1       - @s2__ign is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ * * %-ERANGE - One of strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
+{
+	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
 }
 
 /**
@@ -4521,6 +4540,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
+BTF_ID_FLAGS(func, bpf_strncasecmp);
 BTF_ID_FLAGS(func, bpf_strchr);
 BTF_ID_FLAGS(func, bpf_strchrnul);
 BTF_ID_FLAGS(func, bpf_strnchr);
-- 
2.52.0


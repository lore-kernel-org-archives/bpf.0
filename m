Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C043C1400;
	Wed, 17 Jun 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695443; cv=none; b=HXyDl9lSU5BM3yf8XuvAUJq+o69AmAuLD3wbtMNVVH8cJEWlFNzZpzaQK72WaB5xGiUTZE1456ogZHSi0WLIoCQrevqus7mcj+jaUK5STpG6t2fOjvBdKGgP2CvQKoUO1XeMX0amQ6JyLSV9IMChM3Y7L/BlHZI+Gd4hXkLtzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695443; c=relaxed/simple;
	bh=FONYNlnjtYQKKhWdd3PPsq2YJhbR1niQBio60BndP/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ni8zDcvMzJcHh3aIj2UdiiKFL62X1clrYtx6R61oJ9PPTzkqVFXzRMVIFBr+R6EMYqRik3NPgaixoIe/0DLgssmJSL3LxCW2a0o+0rZ969kt/wEq6hUMsygfbMNE9F5ybdkCd2fJZ7wEtkMbHsNw0ArvYqdafeFe7e2oz56zwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uqy8FSAu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uqy8FSAu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=edR1O+4zo8Kn4wUlhsD/K514WXfjjVwDAwj4dTB/RZ0=; b=uqy8FSAuHlXLJAEiQBJFUyvzty
	x4pfXYbbpHD2oMn5GJyL8SOW1smIjMXbkec5Oh9MEDIe3eHo/8Uve/lqRsoyNySWT/kC9yWvRrZlK
	TKaF65uLxMvASVsvnH4u4BzB/Sv5iiMjAlxqy25RCt1Z/znIobknRAqoMRfDLog+1wU0NbyPxVWAf
	M2HW2yFpjsNsMkMVe0ggkZ5vlyWAhbwW2WYe7OC79fmrLwwJqQ6+1zHAVmJ6CGnl39VwSUQQkDMgV
	W9iGsANzVus1i3gtuqabDHNZYjmBgRW3q7cRZPg+I/cvpvqrGRw+maGp4ExGGWr6iE8ndgQ1kscuN
	QNEdx9+w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZoN4-00EaBy-2a;
	Wed, 17 Jun 2026 11:23:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Jun 2026 04:23:33 -0700
Subject: [PATCH v5 1/7] bootconfig: fix NULL-pointer arithmetic in
 xbc_snprint_cmdline()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-bootconfig_using_tools-v5-1-fd589a9cc5e3@debian.org>
References: <20260617-bootconfig_using_tools-v5-0-fd589a9cc5e3@debian.org>
In-Reply-To: <20260617-bootconfig_using_tools-v5-0-fd589a9cc5e3@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3061; i=leitao@debian.org;
 h=from:subject:message-id; bh=FONYNlnjtYQKKhWdd3PPsq2YJhbR1niQBio60BndP/A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMoO7hHviQWupZWLIoU3/np2JZDdXn3qQlwTR2
 Qv9wueOHomJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKDuwAKCRA1o5Of/Hh3
 bUQ0D/9NZmyjwnQjWtsEd3UB20ocfITjkpSFcgphfLVvg57NTMMtSagVCfqctaGI2HjFb5YXDqj
 AvDI5aSQwgA7L8VFnFFn73x7FlgEpSnfhC07L9aA+hDlIU9jpfLFE5zLcWdDFDFmtVVIxpzrB3q
 XPjvIetvl3LO4NSeUomAmk/8lbY74Hn9N7SznjY3+1j6ablNigW1fnWyzj44z/M1wHCct8QOSM/
 hf+JnOCUuuQB7zWTbN8yZs/BIRmdb92HUf5Ls+Vw4pZUe4drfJo0txLrTwJ6nBf/AqSB1/rKKKY
 XRhgBYh8A/CRFKSRsRPRfNIjUPsWNz0a4q1iEhgaficq8Sy59X44j5qCYrWehbirKPKXiKLRL4f
 PxLSDB1RtCwhoPdOTfw3zz1NQKSFfgs11huMDc/LH2XOqR8LvBtFma3+/pahrSMiBi3VTxOXwu9
 9ZUHWsoy1vP/niyfwR4YF3480uuFbj82EV4wDLzls7cDmXH8cXDLZqUGdbv3NvSdcvz2WVJv6KP
 ztCsPcfBKOPHjKKZKaY5ANk5cWzF4VYdVsZ3RZgOikPPPE5xo6Apm3NpH5l8tdWJ9N+l7wGjjaa
 u+MWdzE0pRVNt51fbR5LlwQfS4ORpymon4U5sP2F1atFXeAHONG3whABWgLSSdYrDI8CCvhXKSP
 eIE9ut5UWqqsmgA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

xbc_snprint_cmdline() is meant to be called twice: first with
buf=NULL, size=0 to probe the rendered length, then with a real
buffer to fill it (the standard snprintf() two-pass pattern). The
probe call makes the function compute "buf + size" (NULL + 0) and,
on every iteration, advance "buf += ret" from that NULL base and
pass the result back into snprintf().

Pointer arithmetic on a NULL pointer is undefined behavior. It is
harmless in the in-kernel callers today, but the follow-up patches
run this same code in the userspace tools/bootconfig parser at kernel
build time, where host UBSan / FORTIFY_SOURCE abort the build.

Track a running written length (size_t) instead of mutating @buf, and
only form "buf + len" when @buf is non-NULL. snprintf(NULL, 0, ...)
is itself well defined and returns the would-be length, so the
two-pass "probe then fill" usage returns identical byte counts.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/bootconfig.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f445b7703fdd9..2ed9ee3dc81c7 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -427,10 +427,18 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 {
 	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
 	const char *val, *q;
+	size_t len = 0;
 	int ret;
 
+	/*
+	 * Track the running written length rather than advancing @buf, so we
+	 * never form "buf + size" or "buf += ret" while @buf is NULL (the
+	 * size-probe call passes buf=NULL, size=0). NULL pointer arithmetic
+	 * is undefined behavior and trips host UBSan / FORTIFY_SOURCE when
+	 * this renderer runs at kernel build time. snprintf(NULL, 0, ...)
+	 * itself is well defined and returns the would-be length.
+	 */
 	xbc_node_for_each_key_value(root, knode, val) {
 		ret = xbc_node_compose_key_after(root, knode,
 					xbc_namebuf, XBC_KEYLEN_MAX);
@@ -439,10 +447,11 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s ", xbc_namebuf);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
@@ -452,15 +461,15 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 			 * whitespace.
 			 */
 			q = strpbrk(val, " \t\r\n") ? "\"" : "";
-			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
-				       xbc_namebuf, q, val, q);
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s=%s%s%s ", xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
 		}
 	}
 
-	return buf - (end - size);
+	return len;
 }
 #undef rest
 

-- 
2.53.0-Meta


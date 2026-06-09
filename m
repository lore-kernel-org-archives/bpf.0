Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD53F39C6;
	Tue,  9 Jun 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000933; cv=none; b=sZnpGlT/AtNSPA5IDkArUKiYbNnT5zPmJHw5m1gkPrcE/Mk0RK1E2aplGf04xWHHFE3+69IwQ90aTwPk9uxqJ6Dry8R1eQQwAZdFUSc6+AhAk1xv2YLhBykIojQcAUTKq6IXTGMJJulnzEuEH+OzQfbcjVPj5Gs2XPUWWRoZOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000933; c=relaxed/simple;
	bh=EAWSBZHUbvF+BebKTrcH7f4eYwq+NcrjSdvoq/taW5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pr1q3LCFKK8xTMV6Dl+IPNGTJ0D+fMCY6Gv73S7vV1Ote4Jimn/5kCgpEfZYjFC89rejD6KxN0Wl+2VVN1JisnUXhY+IV2F+Mj7lyiM9ctnWZdoHbnKCgB2XLAGoc+FpKyHoVJWAwnWKh2HhzHZsFwBhHxeY7C8IGAeaK66/Cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JHCHXRPg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JHCHXRPg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pBa18RzXk1ANKaCmnnGIArgni6qzEnHSHRPoGBtodfY=; b=JHCHXRPgNQi7crv5L/N25OnlTo
	GpLkCmFlvfoyPRniLEaDhTpcSF7oimcC4DStzHOrEFgj9Y6V3Xq0PZcTK6HPd94te0gjabABCssnl
	7uAqlDQKvFfbT3fxws+JploynPKc1H837HA+fZVK2L7wW2zmH7ShdHMuA3dK3QQEl+jj1BYu1JuWu
	AGC5/+M2FVeL0Zgq+fS6xS+ncuz9D6cgZE3vCQoppMnHiurgO1ago6+f11hPInqlE62zzH6xXRtwD
	6wr7SEyvc1k8DGVuIXlnifEfjlf3wc1byRpvghMwcKwWfJjz/RjYdvBPgRIBgxd5cm4Ug3ckdYD/I
	BtXXKXiA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWthM-008Knk-0b;
	Tue, 09 Jun 2026 10:28:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:28:28 -0700
Subject: [PATCH v4 1/7] bootconfig: fix NULL-pointer arithmetic in
 xbc_snprint_cmdline()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-bootconfig_using_tools-v4-1-73c463f03a97@debian.org>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
In-Reply-To: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=leitao@debian.org;
 h=from:subject:message-id; bh=EAWSBZHUbvF+BebKTrcH7f4eYwq+NcrjSdvoq/taW5o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ+rQ3CwtHGVnEwWTpuT3INi5a42CT/zogbVem
 fI3x+ZtYfWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifq0AAKCRA1o5Of/Hh3
 bSZID/0fL7D0T0mxBWVLsVk+zmb31GGQGeqF0qlhx1/PXzdHpt/crpCHqXW0Ilnz6dvzkbwNVPR
 wQCFchMS5ZJiBelESqSIu+Jln59r76E2/XxWjmOTHQNf+JOxJG1NybvfJCmmr+2uTMV62nPpM0t
 3WZHzYYArVQqOoMguuLC3Cuhhh5ZFZY7Iw7tuvl45979JcLwgUQAk2H+vXeBWRG3aVr/T3G/djj
 kD8xGFZe7AaBSY6hwWiwT/dcwsx5r0CM/uKCiliXBciFzHTHY5yqPCBVe0trcofVPb92kg5MCF2
 T4kFfInteo7hS3Fngo74K6Es4jYDwjRF2gcsDp2TG8nSHucTTOYhtzkybAbyM2zR03iQd5qv3z8
 XjaGJddeOqXKjya5bFdYFnuWtLaYTnUQMZw/AA3P4bNHBcZnsggvVgZWbIfRGvsbicDNQuVb8MX
 tF5DTmWC2oWpImk5ztiJsFZ4WOo8cVpj+7VmcDXt/vf7haJE/mUrdRK1S1VNUjwx5hlG+xPklrW
 Fwv+gI1CcqJ49z1PBMYPuZmARMTkoQ01HLMOazuBmViX3MzWz3yeHJrxRbzmEEHrrxMx1+khryj
 ajUf+LMXsoViqAgyNggkQoKMpKXEoshLo/5ibBVsYZrj1EccZMexzZTADoTT2yCnJaL6nqLBTEc
 ZQB+lEU5LjIjwJQ==
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
index f445b7703fdd..2ed9ee3dc81c 100644
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


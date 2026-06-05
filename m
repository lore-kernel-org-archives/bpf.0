Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D622B3F7ABE;
	Fri,  5 Jun 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661046; cv=none; b=SB1L3jGb30OoQgDLDA1FfSjxbu9T27KEmpUtB4gw3S17/DHSYPzSHlN9jm50JKJPFAfeP/cv9/EEnYrY1nMsjAnTVc2b0kJyJO4XhdZ14d25b6dVd80UiF0hFpodQe/nqzduibzDLPIbMaOEKPZKw/4aghAy9LW02FFTsgg0FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661046; c=relaxed/simple;
	bh=EAWSBZHUbvF+BebKTrcH7f4eYwq+NcrjSdvoq/taW5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoxM1korA17qvFrTvUJaYFs4MSvLm2X1Fyuh3fDJPPTDdmT9uLDeLh9yI7jgLe01WwgVgCjKbM3Pd1ai4NUQfNuf/gwD7lSUoERtYivgbCySntE2Je1cyqN0fGg60on6XHHK2pcxZPYoZUnNteiQR/mbPSEziOIb4KcoQPXPqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ITRYmA44; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ITRYmA44"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pBa18RzXk1ANKaCmnnGIArgni6qzEnHSHRPoGBtodfY=; b=ITRYmA44/zI/GMI+pN0J2KYDDJ
	BAVFYOAR+cFwwESFEugIvcQd741ieXKFE+BruQdE/POfzyC5gk4pzg5b1pGk4x7ga+vZnbdQPUQgO
	Me/kj8fqiT6qVlv6wQiVNlYdoXZOMvlhPWMEerpbgQ3lBTGpwaqVunbX2ND+Pvakv1gHTaCx10F6w
	gjUrt8QzMXov6lDf+xevGM7j78uK+YKsXuBiIa0td9HSq81LXEn38WlXOnPJimHrhHLLZlRWsH5Wk
	tGOPIZV1njnUw4qWynLnh08/C6MEVJjU3WKDgwirmbn+VgTBe+V7Yt5QqjSae/Ou6q7rOJhhQlhJy
	GhRd5hGg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVTHG-005HGz-1r;
	Fri, 05 Jun 2026 12:03:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 05:03:32 -0700
Subject: [PATCH v2 1/6] bootconfig: fix NULL-pointer arithmetic in
 xbc_snprint_cmdline()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-bootconfig_using_tools-v2-1-d309f544b5f7@debian.org>
References: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
In-Reply-To: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIrsf5U0d8IB5M6BXmxOmCe+JLmQ6LX0iXZrj4
 IgfUMlBYNuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiK7HwAKCRA1o5Of/Hh3
 bdbVD/92AKAbzkJE1onq0ANafyihWaN6bWblIBx9O+HhwipD5Ix70DxIhOkWYPcSeeb12ZYdKnq
 G52xfWd/mZV89ghFZmkFXQWzf1tPGad03mfki4CL0U2onRA75lKqKXmBWUIKm4YApTkZ/T4HV5s
 Bws9cJ5+1MyGTh7cUm2UDpFGAiL4f20Q9GDEVyQz2DblfHJHCD0ZMQd6ICojxH1GjRALKMBLg5x
 /ex9HRLGbSLuzg378UNy3hHwFc2AmTCztGjk48y7D9cmHuoWAylWX5bMgeBQyRrAnSLjkfPAPcF
 7dvvGWjNC+XNJUp+6fBvA0rzHhZvi7PtMdQ6eMT4r3aQmZ6z0Y0Pp1wV/pI3HfKwOPvmn5Vr75o
 55gr191rqw3b2JBV9g9oZCKWPyxpQPY5ol5glqLc3fY9ZJiZ4SjKznkLaDwYg59WmpwPmJQQ8MD
 RE5pMJX0kfKLZamCwX1MKTGNQhMTNK3amvjj2xdD3xfRbBaba0CMoNMUvde666ms7NKByU9tq3g
 I6YGTFYrSPO3fxnl9DHo5rm68l4QzEaapHpb2GhiIO7SBEzkRtA4J8k030bJd6Pjowhe2WO5eWs
 SWJz0zXFpMZ7+WIf21W2+M+xPIx/cxTbk6MyNj3zXp4hgwKF+nexnYaqrKloO9+KSmlX9v4A7oG
 GfIiD5Htw1n9qBw==
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


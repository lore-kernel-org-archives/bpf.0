Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAD2E717B;
	Tue, 23 Jun 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231408; cv=none; b=BAs2lTtRPlOptU8v3L1JM9TPiZPorzq1uUwoN90/TdtYq3Oa/kOTbkjzW4qwj/0mdO0QuyrJg782HehQEi0kDBSXcR6Syd/F0FQaIAgbuvrJ96XzXTomEyDCMhxR34+HwcXI8H31IgdA/o8FjXXurNw/JI0NR4DwBOqTW3/HdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231408; c=relaxed/simple;
	bh=Xdn8aTKfLHRCFT8EStga2lUPDXTNGyNHtqyDe2SiHbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfCNoPCKhM0VlCx+neibsIhLy3q88iCsKzDKp8uwLYYXLv3cLMFR8mOe01toADuM0agFX8TvgtdXLFg5C9ArgWTpHpCKAp/Kr90G5S+8IQGXNWAzY+5M5bGjDArbS0UHGxFkVDGKCjT+bsjn10N2txcbrnQNd6SnikwNgwC0bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jAByraoO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jAByraoO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YS/E3SNm0maYx/CMNAdmU5c9HXJXz1ONrwxfiTO89Ec=; b=jAByraoOrC2/877jxObrCWdBya
	jBWtBSfJX8cbS4C0Dfs/oLz+TtB8AdqM0eU7H9hmmnJmn5fvld4NJAXWaTngyPPfJ6MnnLyEmL7Hx
	lLBQwF7IaKreDzmukGuo3TqIR4E5qCiAF8lkpAjQoAtWYP/HSBlHHs1asXNXszo5wLHBqPrXWdwgs
	C3lXy4sMp9uH5cqbVL+Xlb8QJQmrVI0F8m2YfITUIuLphzcfbNyyBf2Voy4SE8gE8bX/cXJLLZStp
	N7VpGgD+NpP9yGI2jJsmk4jtzmWHSKiopVEe/ypRBhYJ7WkOCHZX62nJxrKwDC4OpiDpwDfzmcYgm
	K+IAclQw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc3nl-001m2G-1d;
	Tue, 23 Jun 2026 16:16:41 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Jun 2026 09:15:29 -0700
Subject: [PATCH v6 2/8] bootconfig: render descendant keys when
 xbc_snprint_cmdline() root has a value
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-bootconfig_using_tools-v6-2-640c2f587a3c@debian.org>
References: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
In-Reply-To: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-doc@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xdn8aTKfLHRCFT8EStga2lUPDXTNGyNHtqyDe2SiHbg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOrFXzAuMNPKK40KdiUorxf8QWb9YyLMtwGw4K
 3Pl+xRpaeWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajqxVwAKCRA1o5Of/Hh3
 bUp5D/404t8tuYC0/zGRswbaOmcWgRPP672MR1heJM1XQ7kHWzAf00wIOA0dgogMFP8gqXRzGRQ
 gQKXNeRz3kmqQ15lKvrbtCopz9vag4YSwjzHY3QaoFS6dQYLhdNGjAMhd/dYlIpA4arrX/7BkAU
 s4BEyeXZApdhhMEHZYEQoNsfT+2D7nNyjawyNQNux7cbhhxDs1GiUPhf9fbHbdqcA0HFgX/2z9v
 nY/lXVd5VvmZDuOli+C+RkFPs1WFhKthFzARMBAs9bNkSJ1Ryb97eDBR6V/9R+ddmIBZzfIb+65
 onRHhZRP44X7WGQMN+U6vqLOnQytlKDqg0yPKBwl3h81z0UGiiP6DM1PQ91pGic7PHX9HFi5Egl
 EV0oFoqdyc6QGqkIOjwl2xgujVf+2jlyY9qLIum9WcxuugwQIn3dnb+r2qnJsCi6WwoRuFlUQYO
 BSXOIB5/l4tz67DnlFcDLFmNQyUEKNUKpptSUNAbTpZQJW130QFMI0HtnIGzC/xK3nUrh+vlF0w
 l/MEe6gqNl8zrCU7aSowYo/DhvJKUpgnKODmol7xkOTJhMrgaARtW1lAMXw7/mwWc5mCai4+bCd
 zBjjB8J1jD8HTu4U6YGzjfoGyrW/skHmGnDkXmd/W2xiUvSRewQACKjtKPrAvKxGxSGG4DwNj98
 /lLpk8bpOwiimlQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

xbc_node_for_each_key_value() walks to the first leaf under @root, and
when @root is itself a leaf it yields @root. That happens not only for
an empty "kernel {}" subtree, but also when @root carries both a value
and subkeys, e.g.

	kernel = x
	kernel.foo = bar

Here @root ("kernel") is a leaf because its first child is the value
node "x", so the iterator returns @root first. Feeding @root back into
xbc_node_compose_key_after(root, root) returns -EINVAL, which the only
in-kernel caller papers over with a "len <= 0" check -- but the
follow-up tools/bootconfig -C user propagates the error and turns such
a bootconfig into a build failure. Worse, short-circuiting the whole
call on a leaf @root would silently drop the valid "kernel.foo = bar"
descendant that this patch should render.

Skip @root inside the loop instead of bailing out: the value-only entry
is dropped (it is rendered through the "kernel" cmdline path, not here),
while real descendant keys are still emitted. An entirely empty subtree
now renders nothing and returns 0 rather than -EINVAL, matching the
"nothing to render is not an error" semantics expected by the new
build-time caller.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/bootconfig.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2ed9ee3dc81c7..926094d97397e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -440,6 +440,17 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 	 * itself is well defined and returns the would-be length.
 	 */
 	xbc_node_for_each_key_value(root, knode, val) {
+		/*
+		 * An empty or value-only @root (e.g. "kernel {}" or
+		 * "kernel = x", possibly alongside "kernel.foo = bar")
+		 * yields @root itself here. Skip it: composing a key for it
+		 * would fail with -EINVAL, yet any real descendant keys must
+		 * still be rendered. An entirely empty subtree then renders
+		 * nothing and returns 0 rather than an error.
+		 */
+		if (knode == root)
+			continue;
+
 		ret = xbc_node_compose_key_after(root, knode,
 					xbc_namebuf, XBC_KEYLEN_MAX);
 		if (ret < 0)

-- 
2.53.0-Meta


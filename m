Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2B3B637E;
	Fri, 26 Jun 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478241; cv=none; b=lnO4dyKbwc1rgg1RGQUMGtLCQgipbc+Ql/eCvJhNDpQaR0z2FSyZaSZQWQY3vdDq71RpW7y5Yh5xGOTS3UsVo75o2Z+unY1InzL/1kYuBZeURdD2q+4S4NN6S0q5VfqEx7Sm+ZSBIBvwqVVGzYwsj5y5S+8dGjJw8YsBeMK/94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478241; c=relaxed/simple;
	bh=Xdn8aTKfLHRCFT8EStga2lUPDXTNGyNHtqyDe2SiHbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqNdmpLXRd/BjpXw22A+JltMm82jzhwRhNQ65fTosOG2vfAC1Oed+4vGnUx9aGp+YL3A+hommqlrBQcG+mkOK39u/FEvEnMiGeBklnMG3F2dcFlLGyGmxPkG94sYmtq0uTJ9urPvWCQgrEh2zBnU1PWZOVxk6kLMRtgl0gLogaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gEpAaj0V; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gEpAaj0V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YS/E3SNm0maYx/CMNAdmU5c9HXJXz1ONrwxfiTO89Ec=; b=gEpAaj0VszQ9ebZr5p9k/A0pZa
	FGFCKD51jGjc3m6qnu6W+BN2jCDygANBqxcKiPdwGOYhKV5XOM4dDr9G+0WbrVsE879sOqlP/8+0d
	YRgkEpiPgB3RWHrBQtNrzhSLi+h4Fzid/lge2CuldBPDQy9dM48vqQyoQ4ok9m7zh+zghFdnHGtK7
	NrRF81xLVkDG/PNBQu5vN1AouS9Ljtr+tn2QRklsyjvlkvni5G4KlXEbQDhH8koJKPyamR6OpILgv
	MxlTZMsyx0bkBJZvapBWSYg6LnB6csDit5zC9j74B2yETB/4y8A86qLxk557rHBdTonqBbW3ifG2A
	niwVYi+A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd60z-003ykz-2o;
	Fri, 26 Jun 2026 12:50:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 05:50:11 -0700
Subject: [PATCH v7 2/9] bootconfig: render descendant keys when
 xbc_snprint_cmdline() root has a value
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-bootconfig_using_tools-v7-2-24ab72139c29@debian.org>
References: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
In-Reply-To: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
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
 b=owEBbAKT/ZANAwAIATWjk5/8eHdtAcsmYgBqPnWLRO1PQrXLqiEoAYsTfmPaHfMXvMBYqnEFG
 1B0tFv5JBqJAjIEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj51iwAKCRA1o5Of/Hh3
 bS1mD/Y9bXsI5L3T6jE9M9/okeHI0yJH2y2ZXkbVRCgtCttWyvBRzj7wZscwcRQlAKUmXYiFqph
 LfijN6rw7b3JVDLoDT1p5KSiPw4w7MQj4PG9iKaxizzlVB1XYBKMj2ntpIxgHtdl4z+7eIgTNUh
 DV8KldvWupd+t7BEuOWHaT27D4EiNC8n38qhve1Nppo5D+Om+dAe9iSVWW80qTWCH48U3wDn7bz
 JCyeOok5PbOypRAguXRyjdKvw/AnEvaQyEhdg8oBwNkp+1KUi6U0RV0wc31ovb5tbcE+AIBMAA7
 7/54tnBdwz+QOAg4CsJTXGpUmMMed1wxlGCXnU2Jd24AJg/n9qsRYCBXH9s3Q41jpMWyOOshGHY
 Jl2sT3OIEme6PSh8KmIg21fPXSzNVwC7s+I1sJ08KgHSlkTzVzSQq+OWa5KIxbjjOHSt9O+1k7O
 G/SCuzj5u6F/hIMe9cQkiZLIPNocF6vnImc+qO0Y5/VH+9+uF863ejzeiMMzs0NNu8YxYUnnvk1
 fFL15JTND0DVxR0aPuNJ0f6vdI7xiQeFZpkhl0upUZLhpx+/+UYJ64SAvPkT2lSWsAq1X/cIF7K
 kOWbHDy3GYDYQYid7OyDDLQf/dQX1ANs7lsqM06GAytnmBYJAZ8z4h8UWzpqfsRN2Bs2x/cEtpl
 /qr3iKoSuuemo
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


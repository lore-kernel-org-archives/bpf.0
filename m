Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9A371072;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619034; cv=none; b=CUgeaN2SlBxmh2y6LAk8j3CIP7oi+Gd2aeqRFbegDYqSja0OQ8AMl+St8oO32o/oJXRakCjmUDvOePKa86dkZC92o5avM/VNgjLW7KCIuvKIgg5+VUiYE0p/3ZjaaFQGN6gQ9rB6bD4tlsCvSpdIcKkc/+zd7mT4AwiLAt/jQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619034; c=relaxed/simple;
	bh=YVVe7KRzqnppyn56cGxlJApAQyowTVAxdXTJwpP28d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlHU78XcHEDmTraZEfHTK1SHTXKmEwyiVyOjoa/AgWUdK6peQJOUL77mQhbnd6WCYnzPn7KRw01aIklUSRy9i3EMCs6YA+AGqFKnCsKxotwqicy+JRhb0Eh0iklYsgr8NB2NGKeCvR4Qs4LDWJ554keEOjSjLMzXRnHpquUVqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9wZo/gM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9wZo/gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E0CC4CEF7;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619034;
	bh=YVVe7KRzqnppyn56cGxlJApAQyowTVAxdXTJwpP28d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9wZo/gMca0BPI3ua8PMHR0Oryi0fX51PLksQhUhVfiZo6+UAQGPy+4R//p4QEqC9
	 blaeNAIMIA9bDX7MmmS2225YB3YQq4MkfPSptohmJiHrmGEsSK5dfhb69mgl50ezO8
	 3DLiHNINq4MvKt0HNYWLkZIkfp5wuuY6kJrWyVzT7hIRWA5xz1IQF5B9CaMbLZMDG0
	 4BxzfFCWTXkgjy8uPNygVxnBQVwhLEP2mzF1sLgsJQioG/WPgQGc3p1+8YZL4IzrSk
	 VFDD2OSxeFupft5Ix4d8+qAvbSLaLU0gWF8vYw9HIV0/oEppQU6wGt5EwW6iQTqyOW
	 FYFn6P6eo6Kcg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kS-0000000DAxq-0iTm;
	Wed, 28 Jan 2026 17:50:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 12/25] docs: kdoc_parser: ignore context analysis and lock attributes
Date: Wed, 28 Jan 2026 17:50:10 +0100
Message-ID: <b85fadd1fc9eef164c8961adf79cfdbfee629019.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Drop all context analysis and lock (tracking) attributes to avoid
kernel-doc warnings.

Documentation/core-api/kref:328: ../include/linux/kref.h:72: WARNING: Invalid C declaration: Expected end of definition. [error at 96]
  int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
  ------------------------------------------------------------------------------------------------^
Documentation/core-api/kref:328: ../include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
  int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)
  --------------------------------------------------------------------------------------------^

The regex is suggested by Mauro; mine was too greedy. Thanks.
Updated context analysis and lock macros list provided by PeterZ. Thanks.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20260107161548.45530e1c@canb.auug.org.au/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 21cc4e19a1e8..92b550189988 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -81,6 +81,8 @@ struct_xforms = [
     (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
     (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
     (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
+    (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
     (KernRe(r'\s*__packed\s*', re.S), ' '),
     (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
     (KernRe(r'\s*__private', re.S), ' '),
@@ -165,6 +167,16 @@ struct_nested_prefixes = [
 # the start delimiter.
 #
 function_nested_prefixes = [
+    (re.compile(r"__cond_acquires\s*\("), ""),
+    (re.compile(r"__cond_releases\s*\("), ""),
+    (re.compile(r"__acquires\s*\("), ""),
+    (re.compile(r"__releases\s*\("), ""),
+    (re.compile(r"__must_hold\s*\("), ""),
+    (re.compile(r"__must_not_hold\s*\("), ""),
+    (re.compile(r"__must_hold_shared\s*\("), ""),
+    (re.compile(r"__cond_acquires_shared\s*\("), ""),
+    (re.compile(r"__acquires_shared\s*\("), ""),
+    (re.compile(r"__releases_shared\s*\("), ""),
     (re.compile(r"__attribute__\s*\("), ""),
 ]
 
@@ -195,6 +207,7 @@ function_xforms = [
     (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+    (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
 ]
 
@@ -204,6 +217,8 @@ function_xforms = [
 var_xforms = [
     (KernRe(r"__read_mostly"), ""),
     (KernRe(r"__ro_after_init"), ""),
+    (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
+    (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0


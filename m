Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E63148D3;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619031; cv=none; b=qe6u+w7srHHDC2dpS+w1aora37csYdCDqjEgE7sML2hACmOiu43gxS8qBrMJUt7oXRikItMrFMKWCHsXRZ53LSHPU0oAzY+w5wi+E1IkqGZ7jgAzyoaT2BthcaS/CV+7hGfmLgZa3Z27LZSYEsD+ELApcY47ltTFonEMUc6yi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619031; c=relaxed/simple;
	bh=cuKy1d1D0xiQwJcdcAdfKB7F5IpylCi/Hc8WUScKfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWMyGF2D5ubPXuE7wqtF/Bcjvs+JkbITTZ2jc9LQKu76OdsKo6x1EMQnFzmFWwOcLJ47+CI0YRU4Aypc1APxjDKtKm7DXVujRrYXBkf9aP4zJJwELdC3UyuRHOlrBxVDaUcImB1zAvMzYQIxB2hIDjRbqVsb5vPbuurfFNgpO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnuH8udN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnuH8udN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29A8C16AAE;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619031;
	bh=cuKy1d1D0xiQwJcdcAdfKB7F5IpylCi/Hc8WUScKfcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnuH8udNWV3JcvZ1e6laVHL0sFlIGbyZ6iWd8jYwZx6/7G4qJNtaF80Y+Cp87/bdz
	 vk/e0AZUIXJlTyQGjj64algtpG8eAfAf1MjNDTMD5xQOn0DLCQaaA/z6+jMCWbYphs
	 whcNXpuGtleC01nJ45Oy9wPKrBCEaVzthZ6cZQtf1Mmv+f2XMrJHV354VHBgPbgZDY
	 Ej4CGDN9f+KS6fzg0oS+W1BnE3kyD9Zm3WLLB36rYHbN/wPaOn62m8kmC9bhslgK76
	 0DzEOEH8xViMIgyHE1GwXif3L5CcCoNjY4+sYFfLUBuDWPj9fM1ThFpJEDuVEy1Dlh
	 yvV6j99dJ5QGQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kP-0000000DAoJ-3ZM3;
	Wed, 28 Jan 2026 17:50:29 +0100
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
Subject: [PATCH v2 04/25] docs: kdoc_parser: don't mangle with function defines
Date: Wed, 28 Jan 2026 17:50:02 +0100
Message-ID: <05cf7e030b659f26ebc4fdc65e264ea9616c9d9d.1769617841.git.mchehab+huawei@kernel.org>
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

Mangling with #defines is not nice, as we may end removing
the macro names, preventing several macros from being properly
documented.

Also, on defines, we have something like:

	#define foo(a1, a2, a3, ...)			 \
		/* some real implementation */

The prototype part (first line on this example) won't contain
any macros, so no need to apply any regexes on it.

With that, move the apply_transforms() logic to ensure that
it will be called only on functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 0b68b140cd02..3ba2cda2487a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -163,7 +163,7 @@ struct_nested_prefixes = [
 #
 # Transforms for function prototypes
 #
-function_xforms  = [
+function_xforms = [
     (KernRe(r"^static +"), ""),
     (KernRe(r"^extern +"), ""),
     (KernRe(r"^asmlinkage +"), ""),
@@ -1065,10 +1065,7 @@ class KernelDoc:
         found = func_macro = False
         return_type = ''
         decl_type = 'function'
-        #
-        # Apply the initial transformations.
-        #
-        prototype = apply_transforms(function_xforms, prototype)
+
         #
         # If we have a macro, remove the "#define" at the front.
         #
@@ -1087,6 +1084,11 @@ class KernelDoc:
                 declaration_name = r.group(1)
                 func_macro = True
                 found = True
+        else:
+            #
+            # Apply the initial transformations.
+            #
+            prototype = apply_transforms(function_xforms, prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
-- 
2.52.0


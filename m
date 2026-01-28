Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9132D7FB;
	Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619032; cv=none; b=tHzuL5tF+qHwc8wZ0X78wmza2z8xdMUsrTS5oyjeE4QM6qY8yCunET7BGUMmPc6IUdoy45TwV/7J5GeHIH+NufaLSP4RNBvPkjU8WliV6/rVdRX0y4x0CR4LfhCKotcpJr4gy8LWQktoMMMw9gA/8Ig+PRBqNFGBi3rpxCxzWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619032; c=relaxed/simple;
	bh=Rc+cvBbCrvl5gHPyjY0jltfZsAtkaYF+V2rrj3nvojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPD7cXCZEegThUUFDFsD2BPUMf6FJ/n9UvISzBvF6OibQhIxvMrlMpLwbX4yTgB3F8uPCP0FgSWYjCDaVVHlL8gmoAv3Eir3WAhv64wzVYWdtRyNDIVtxAR5KZAyanhcKidQWWI0jgd3pl0380VDKjLXsNO5XBOpvb9hHP4y8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cScZw03Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cScZw03Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DBFC116C6;
	Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619032;
	bh=Rc+cvBbCrvl5gHPyjY0jltfZsAtkaYF+V2rrj3nvojw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cScZw03YddUXVcztOtXAVx42vO/hlulf7PHru1VjgHAhVSmXdImxkmdeBTi9dIaXo
	 rbRTQtEPWPLtq5o3abyVEDEeEY6C0H11KpiC9lRC6aNem/KzxY9KM8rbE9ZY81TyIb
	 Db0P/2CSRJYIxc1uuFYpTmsy8fQu3ync9SAaqplq1K/rBwS6KaPcHLi/znGZyK80kC
	 lHUu9B+td2Sd/DmCn0MF1AMkXRZ33yzh3rH9COWRtpOUrouLNnQK05tK5pAh9gksJv
	 Y5jSylUilJ1ykhQEt6DTrsnT1SbHR1at4RaLTEBDNCrnafbzBwALUf/4q2ja9CyneK
	 3ks4m1cN6PR2w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kQ-0000000DAqf-1hgM;
	Wed, 28 Jan 2026 17:50:30 +0100
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
Subject: [PATCH v2 06/25] docs: kdoc_parser: use NestedMatch to handle __attribute__ on functions
Date: Wed, 28 Jan 2026 17:50:04 +0100
Message-ID: <9c77e55b771dc19f0c1203bc107f69c8c2c371c5.1769617841.git.mchehab+huawei@kernel.org>
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

Some annotations macros may have nested parenthesis, causing normal
regex parsing to fail. The __attribute__ regex is currently very
complex to try to avoid that, but it doesn't catch all cases.

Ensure that the parenthesis will be properly handled by using
the NestedMatch() logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ae5b2ef80f75..64165d8df84e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -165,6 +165,7 @@ struct_nested_prefixes = [
 # the start delimiter.
 #
 function_nested_prefixes = [
+    (re.compile(r"__attribute__\s*\("), ""),
 ]
 
 #
@@ -195,7 +196,6 @@ function_xforms = [
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__attribute_const__ +"), ""),
-    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
 #
-- 
2.52.0


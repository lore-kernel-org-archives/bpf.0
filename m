Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866F372B58;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619035; cv=none; b=edwBYG9Vs1nsuu3jYtyJ1BSDtAAEXekOP/hYJz7r4DRwE+g4XS+Zh0yGHJb6uec4tSawN8BdVxzL7pxMj98/9aK5U4rpl7C49dkmvsK7pBDe+FTpuwMTqo9ZBvuKWpzZLaxBrcTX9WMxfgBQxfh2EHxNhNLTNg5PkRiILvJTlgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619035; c=relaxed/simple;
	bh=LaLUXoY/KS6WIRVp9iorgFncFjJ1rGpIWKLw4YbQxJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LED4iHXPCG2t35lDHOtkKuNP7PPfyXMQDO9d8EeTCKnmW/7zadtTmYa7k2w4ZsG41hVAhvj9Zvje8oAdktcZmMo1yciGIKVE36BcvBL4loDxcJLb/0CZAOeQ3GDe8lzilW3tj4kTKTdcKZvUnz7l/KDWzxMouvird6qxBoQTlVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAdy0Pn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAdy0Pn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E3DC4AF09;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619034;
	bh=LaLUXoY/KS6WIRVp9iorgFncFjJ1rGpIWKLw4YbQxJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAdy0Pn4PxMBzSJDBYcEr2AP0/IM48hX+BjDM49cjB/+BzdvguBKB2hNMO1u0NqP7
	 4SmciDVlxhTVqqriuOudMQi8GYQbH4Xy0RZ0FmgmzswS+auffCPCrYdLKDS1NaSD8V
	 2f2lJpVto3DW99L5agFfQJu8lSzSfceYwuKR83ClL0nOQ5H3jD4Fh1gAy0DTjXfkFO
	 OcN+1L4D8BImAEk/VWN1ssCz4LI1sPJuPapJwM7w+vJJ+NGbhRpboig/+g9Ya/p4Ul
	 jFpaZiVxoBtbUeuQJHfbrQAhXUBzEsUIClExRvCwVqczKtkqrxG1hsFn/MeGXBVUWn
	 j+dwWzxZgAhBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kT-0000000DB1Q-0LmB;
	Wed, 28 Jan 2026 17:50:33 +0100
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
Subject: [PATCH v2 15/25] docs: kdoc_re: properly handle strings and escape chars on it
Date: Wed, 28 Jan 2026 17:50:13 +0100
Message-ID: <934f61b22277dd5575c77edde96dfa7a98c8d79b.1769617841.git.mchehab+huawei@kernel.org>
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

The logic inside NestedMatch currently doesn't consider that
function arguments may have chars and strings, which may
eventually contain delimiters.

Add logic to handle strings and escape characters on them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index a0402c065d3a..1861799f1966 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -195,6 +195,8 @@ class NestedMatch:
         for match_re in regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
+            string_char = None
+            escape = False
 
             d = line[offset - 1]
             if d not in self.DELIMITER_PAIRS:
@@ -208,6 +210,22 @@ class NestedMatch:
 
                 d = line[pos]
 
+                if escape:
+                    escape = False
+                    continue
+
+                if string_char:
+                    if d == '\\':
+                        escape = True
+                    elif d == string_char:
+                        string_char = None
+
+                    continue
+
+                if d in ('"', "'"):
+                    string_char = d
+                    continue
+
                 if d in self.DELIMITER_PAIRS:
                     end = self.DELIMITER_PAIRS[d]
 
-- 
2.52.0


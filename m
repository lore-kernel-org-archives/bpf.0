Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197E37C0EC;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=sNP3/Fgmm063FsZBevEIiKYpcxmduTbaJi1UP5+/HlLnzCt75S13epP4yxJLCfiOu4O7DPgwXymbjZWmqURBZIvCxvAGmwxDovC8SMJkx9A3K0qaA1o/v8+SeEsONH5BW3VkViao/E2oDT4zL/bN3NFdbzelvhQ0Hgd9f7AwdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=IMy+0Ya2RXQo7v/hj8y/wU7iFOGEnBMPK5mE8t6wErI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DscttxlNwnsTzvA4h2BiRC48zCbRBv8EiBj7estSen0luyJyfxFwlkeAPn/LBrrDFnkvJAjM7AMqEyYsr2WksDzpFBDmhEoxdWTNV+MXrEGdVnXH7+Y3OHeevq4/sgjXXIWeeGbRL8M8fjKVRtddnSz76JrKzIqWiRBMCSr5XUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVDoK7RV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVDoK7RV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06D0C4AF10;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=IMy+0Ya2RXQo7v/hj8y/wU7iFOGEnBMPK5mE8t6wErI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVDoK7RV2De5lMoh9xFIjFW36Xn4xiO+ZCn9lNN83XJWKr7vlvmzvYVCvMc3GUAld
	 Sdy6KYa7nHzCbYjuu3w7YHbw3wLoyozY1UZl54hlwCKezmMqqJOlI2qxgGz4ZSVBeG
	 G8KIqX5PzQEHuN2F7JQkrV3i/C+dWyfps/nxxrvOrtSb5DawA0t0/NiGcO0MXaLN5F
	 L50AO1wMZ8tzN3wUOjqebmi6TU8FtVXhg45aHHOlm41GiPQe/RxP84iS7eQY3qR/1F
	 oWaekbBFNJHH8DERwfqpBkLqh46fyrhbBKkVfEed0EJZS1T/VyShSIBy1u14nqB4AU
	 TEs0JQjjqrNEw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERNp-0t7G;
	Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 20/30] docs: kdoc_re: add support on NestedMatch for argument replacement
Date: Thu, 29 Jan 2026 09:08:11 +0100
Message-ID: <fe4539f5573c62301fd1a94af5126266b023d4b8.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, NestedMatch has very limited support for aguments
replacement: it is all or nothing.

Add support to allow replacing individual arguments as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 84 ++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index e34d55c25680..858cc688a58f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -177,29 +177,6 @@ class NestedMatch:
     will ignore the search string.
     """
 
-    # TODO: make NestedMatch handle multiple match groups
-    #
-    # Right now, regular expressions to match it are defined only up to
-    #       the start delimiter, e.g.:
-    #
-    #       \bSTRUCT_GROUP\(
-    #
-    # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter-aligned.
-    #
-    # The content inside parentheses is converted into a single replace
-    # group (e.g. r`\1').
-    #
-    # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to:
-    #
-    #   FOO\((.*), (.*), (.*)\)
-    #
-    # it is probably easier to define it not as a regular expression, but
-    # with some lexical definition like:
-    #
-    #   FOO(arg1, arg2, arg3)
-
     def __init__(self, regex):
         self.regex = KernRe(regex)
 
@@ -285,6 +262,59 @@ class NestedMatch:
 
             yield line[t[0]:t[2]]
 
+    @staticmethod
+    def _split_args(all_args, delim=","):
+        """
+        Helper method to split comma-separated function arguments
+        or struct elements, if delim is set to ";".
+
+        It returns a list of arguments that can be used later on by
+        the sub() method.
+        """
+        args = [all_args]
+        stack = []
+        arg_start = 0
+        string_char = None
+        escape = False
+
+        for idx, d in enumerate(all_args):
+            if escape:
+                escape = False
+                continue
+
+            if string_char:
+                if d == '\\':
+                    escape = True
+                elif d == string_char:
+                    string_char = None
+
+                continue
+
+            if d in ('"', "'"):
+                string_char = d
+                continue
+
+            if d in DELIMITER_PAIRS:
+                end = DELIMITER_PAIRS[d]
+
+                stack.append(end)
+                continue
+
+            if stack and d == stack[-1]:
+                stack.pop()
+                continue
+
+            if d == delim and not stack:
+                args.append(all_args[arg_start:idx].strip())
+                arg_start = idx + 1
+
+        # Add the last argument (if any)
+        last = all_args[arg_start:].strip()
+        if last:
+            args.append(last)
+
+        return args
+
     def sub(self, sub, line, count=0):
         """
         This is similar to re.sub:
@@ -310,9 +340,13 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \0 at the sub string, if \0 is used there
+            # replace arguments
             new_sub = sub
-            new_sub = new_sub.replace(r'\0', value)
+            if "\\" in sub:
+                args = self._split_args(value)
+
+                new_sub = re.sub(r'\\(\d+)',
+                                 lambda m: args[int(m.group(1))], new_sub)
 
             out += new_sub
 
-- 
2.52.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618737BE8D;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=IgY+Qe/Dek5GjaSQXxaxAppTUpzPNKGek3yfERPZsDooJ6K66YKRQt1gjeeRHMcWT/ZkDKYYJLIwAn0huqW59BIUmMDoRR/jTdIOzn2Coa5BP263/4wyivF6EWU99mQCJxZCihI5Q2PpV7XwlfvS53yDpyK20fwsPH3/FuXk+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=g8cGRz7h/9tP7TX4V9PxMZVBTj2F64+M2ftVKqF0XCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s29i0bcTIEMDw4ADwX89zjaly5mR4mPVqYnTROt6MGe2g92efGhi+2qODddOVBAUS7bRrlmMdH5DiJmhuUIOERIsvXrse9oMrmeDMSw1prJ4Ysp9Hb+DRTkjtaQYcqohAMQtJNgB+dxhr8b07h4z/pWLl6BnDs03YHAbKLkW+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiHnDL64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiHnDL64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7263C2BCFA;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=g8cGRz7h/9tP7TX4V9PxMZVBTj2F64+M2ftVKqF0XCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiHnDL64Fb7vcErOt3fgGRtQCv0Y0HNgJJ3VKPWjXb/LMlum5XlBPW6ToArO9Tp6V
	 ur60nJ9xts83zPp23GmZhMZxnDnm2BE6R1jNCPr8+N6AUk1ybesCXtubHIbV5qko+p
	 B9EfjVe+rGe3CsQefkHQl9KhlrhWA6QQd7P+nvARpFZQGFg2bSFcbTpb9Hp+S+5MBI
	 SVEjxVbVioIdihffhiFKBh3V28tp7eWcIZAtv/gfwct1wTfDnjHw8iEyJzC0ElyVB9
	 eP+tWD+2R8/vuL1I9OWXx+a0roZqs7ndKww36AoazQS/19akI7TCd51i/uOzLYXSAj
	 cC6Sgm3eYuTQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERNZ-0Q97;
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
Subject: [PATCH v3 16/30] docs: kdoc_re: better show KernRe() at documentation
Date: Thu, 29 Jan 2026 09:08:07 +0100
Message-ID: <a81e9e61cc961fb710e3aa1ae9b55ffa00a701e7.1769673038.git.mchehab+huawei@kernel.org>
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

the __repr__() function is used by autodoc to document macro
initialization.

Add a better representation for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 1861799f1966..3f405addcc58 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -52,7 +52,28 @@ class KernRe:
         return self.regex.pattern
 
     def __repr__(self):
-        return f're.compile("{self.regex.pattern}")'
+        """
+        Returns a displayable version of the class init.
+        """
+
+        flag_map = {
+            re.IGNORECASE: "re.I",
+            re.MULTILINE: "re.M",
+            re.DOTALL: "re.S",
+            re.VERBOSE: "re.X",
+        }
+
+        flags = []
+        for flag, name in flag_map.items():
+            if self.regex.flags & flag:
+                flags.append(name)
+
+        flags_name = " | ".join(flags)
+
+        if flags_name:
+            return f'KernRe("{self.regex.pattern}", {flags_name})'
+        else:
+            return f'KernRe("{self.regex.pattern}")'
 
     def __add__(self, other):
         """
-- 
2.52.0


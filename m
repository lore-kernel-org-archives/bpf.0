Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07C37417E;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619035; cv=none; b=spVQ3NuysFmWIGEv/JtwE2uYQvnUOcBVKCHNXqDJRfClfrKEjoHL4A302dfNJQRv8xjSd5Yqe2XA8O5phm99Gl/asv6Px/wEXH6itRlh6B4ItXopeVlULHJMPrYrFnu0M5bztf0MN8SRokVg05JEFPeV/1NiG+psepNxDdWB/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619035; c=relaxed/simple;
	bh=ARtXC1+LQ3gRcThfqj9ksV0v7BRfUWm6DuW6ltrwGzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHpHsX1MfvQdVQ4WXSYV3p/UpZnLqV4zj8279GfE5GiPm3RvYLDIgbybJ4EL0gpjAwfLA3Y1KI4WD1wyILdKtIkp4bfQTICBUKGhdAZRvBXFRUYTtMm0tnujqGIiL3xzjg/Q9R6tu5ktrNZK2rBfM4lK3Ae0GCSBRLtt64y6wtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBNzgPTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBNzgPTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA6AC4CEF1;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619035;
	bh=ARtXC1+LQ3gRcThfqj9ksV0v7BRfUWm6DuW6ltrwGzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBNzgPTjrZhoGqDIQIiY+NXA39lbLYyqKMf9BI0t9Jy5mZjv+t55LMKg6QSQKbgCg
	 3WrUkbkcvzxmimjvvXVS/hkiCDaAP1MmUsI4T3hXXIWv/cve1RHlKBK1uuBTSNeXl8
	 ZvwZfmubafYJBzaYiP0MEbTExnpWUTQpxtjiC/U6JWcZ05AzOhv9S0Yl42rPLPK/ZL
	 nNcIefSmEVlMiEe03yazL/NGpkoOHi3nYktqRngA3UF6Khf0UAx+FRMUX3lR6jALOq
	 mByAd4NZ3XkyE1KcAtbhNvJTjMLlbMR8CojwlgwBFg1Jwcx6zgqaEwWXOclSv/L0DA
	 mOxCKsbId+Etw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kT-0000000DB2b-1Xnf;
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
Subject: [PATCH v2 16/25] docs: kdoc_re: better show KernRe() at documentation
Date: Wed, 28 Jan 2026 17:50:14 +0100
Message-ID: <56e007be74d8572c7c695d811e72e70447c466aa.1769617841.git.mchehab+huawei@kernel.org>
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

the __repr__() function is used by autodoc to document macro
initialization.

Add a better representation for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 1861799f1966..f082f82bad67 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -52,7 +52,10 @@ class KernRe:
         return self.regex.pattern
 
     def __repr__(self):
-        return f're.compile("{self.regex.pattern}")'
+        if self.regex.flags:
+            return f'KernRe("{self.regex.pattern}", {self.regex.flags})'
+        else:
+            return f'KernRe("{self.regex.pattern}")'
 
     def __add__(self, other):
         """
-- 
2.52.0


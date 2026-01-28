Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B536922C;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619033; cv=none; b=gnxl7OYLK1Cfka48IQuR4FyMYY3dpcI0c91JIdnV7DvwRw3SbGA+/rJHNBUSmx9+pvvTuCiRqyFCIB3wM9Og7IHOl8OL6OZltc7FGf8jayXTguagYuZ64iQ9jiJZNC1p5+GWKVCphpzv3HlH2xdikyopno/nTTkIYqHBhyB5eUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619033; c=relaxed/simple;
	bh=Fd24Q1nDNP9DgJx33rkWp9Vbgr/MiR1kgk0MwpCT/0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV4OWY3UsfVWOD7EOPghbtUp5mOamoik4zq3dWQCG1Bs37yNTaKtGDgbwSaNy5zk+ElPuyXjgCPbOgDiMnFrBjSEh7FLQInuUxGPUMMwRCW+hfqJk/HPSYL0JutmEIUbOVzBg9/VTbrHZa47oydtfG2E3arHfghSnJCIf6b3WQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2WzK3GK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2WzK3GK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236B2C4CEF7;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619033;
	bh=Fd24Q1nDNP9DgJx33rkWp9Vbgr/MiR1kgk0MwpCT/0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2WzK3GKPpX6XNswPV1tPHmLNUbg0OoYFItmwL8+7+H6wVJrI+lTkcz92KUplj3uo
	 qqb/TjkCg2jsEj8QjU3xBu/t0s3NsL7EB19gLflwyRQGFzZp4LxbTzzaDvOgP50Uhu
	 t+t5exuqf4ePQNJRtpPYUYrbAMg7PH6UXqHGQuhLWAUzhtCuQkqoJvaLhbqMzf8Wq+
	 Bfo+/Fqw57BSC89VafMf7EffxH2nnazulOFegJz7I1119FYNEPvq3gCCJDh+r6LIuG
	 Rf19q6F3kSPTem4QIwfWaikg0owW4ys++2/UidymKkpHT1zJOJuz6Q9E5paHeZbLZZ
	 /OMzFVKAjGyEg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kQ-0000000DAt2-45tn;
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
Subject: [PATCH v2 08/25] docs: kdoc_parser: fix the default_value logic for variables
Date: Wed, 28 Jan 2026 17:50:06 +0100
Message-ID: <a16e78e794b01b68355d472f9e6a4a1d42591846.1769617841.git.mchehab+huawei@kernel.org>
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

The indentation is wrong for the second regex, which causes
problems on variables with defaults.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 201c4f7298d7..cbfdaba39494 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1035,9 +1035,9 @@ class KernelDoc:
             default_val = r.group(2)
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
-        if r.match(proto):
-            default_val = r.group(1)
 
+            if r.match(proto):
+                default_val = r.group(1)
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
-- 
2.52.0


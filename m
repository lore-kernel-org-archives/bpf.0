Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAED30C626;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619034; cv=none; b=fK/+ZPMDYxtoMzqg80K7Ju28Si5NwOlHB09yLzlyGmoiS3cPRAKYBiRmSvSm6gx6LwjmtCtyPDk/OOkwPr6fhcK58o22vpfEIVs8D7j7A3Mza7yBSCNFYmUmE89RPdFnVFy80WGwcr/NiryLGv5BS59UFmcSfHHnEIO0mSzzeY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619034; c=relaxed/simple;
	bh=+PHSHQk42n1s2eoXmKBeCEHsRg0AhUmcVaeG8R0cpiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjJUIF/9gGguv+OenGW+FgsjZC4Sbh70ANqStDr7/YZ+IK5rRLAn9pr5S6H+lugR3SxW0WZOZ31O/nVn/D+3lBiN/Dfs8+RKCPDmttAyqusAC5m1mR65hoa588jMrispr37kSplfb47VN3MrfiL0lhRjM6MlMHh2CZgFDuGyZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUDxbWwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUDxbWwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0229C2BC9E;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619033;
	bh=+PHSHQk42n1s2eoXmKBeCEHsRg0AhUmcVaeG8R0cpiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUDxbWwUpvODFtK7Bn0IDVqUo4wRl4FZ2y9tMSl8n6OmeL6FaTaJaETZ5HletL/27
	 u8zCMurLOPRvtO/7H7AQe96Wf8qEBLTNx0Aw36SaM+fzSuEMHw5ZCQhwyBXtywuX2E
	 ufdxiWhrr5oS2RxdPl1QJlXpIHzMqbDUpLV+WhA1dTiPyuq+nHo088Q0At0522ASsm
	 Ts6u1Lw7NlGhW7jxOvGMK7DM6rvGvPdUC/qyPO1+N294RvCj7H7W9lapR7ZCd4ciSi
	 wHdhYOHvfvIYkRUJsrqDaLONAREIdqxtJMQE3N86mlUzpNSfM/2pfGVddAZI8cJ4Ry
	 xCQHCMdaN32JQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kR-0000000DAwc-3XJq;
	Wed, 28 Jan 2026 17:50:31 +0100
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
Subject: [PATCH v2 11/25] docs: kdoc_parser: fix parser to support multi-word types
Date: Wed, 28 Jan 2026 17:50:09 +0100
Message-ID: <ab5e7c447c49dd000d7bb32788e434d23569c46d.1769617841.git.mchehab+huawei@kernel.org>
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

The regular expression currently expects a single word for the
type, but it may be something like  "struct foo".

Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 0b6cba442d72..21cc4e19a1e8 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1026,7 +1026,7 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
@@ -1037,7 +1037,7 @@ class KernelDoc:
                                   r.groups(), proto)
 
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_\s]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
-- 
2.52.0


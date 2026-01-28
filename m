Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD436EAB7;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619034; cv=none; b=RM0cMl82VhhMyFRgGB8aZw8M2b9VtjhQDaYTGZwN6yO2tH1VaB0bV2xY0Nm8yLlOwFWF7GLxKq42L3qh+IvyaQY92REdcgrBAmhpIjsqvxhnxO6iFn9/ctlgGFfcp4AtBLlrKgAAmjlUFNADPYQJFAMVjlJxc3B+dOmcVk97CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619034; c=relaxed/simple;
	bh=BGmC9Ub+EwkCy+50Wez7U2hU9ogTq3RfJ1GhpzG3syM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukXbUxX1opmGEPJUmlM05Zc3JVo3QDbKmQ52+eRo8eZuOaIWf1adBKK6qJwXDTy+6sI5qHQkZ0EgcpEFDsTo1/rPZdGgsHYnNI9SmFM7XInwqupYrTrR2G8zqtyDxbFOoUuaZOkQVSrzKZ6Cnstz3A2lKhEN9zdOfIvByM1Iv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKIcnr7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKIcnr7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1452C4AF0F;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619033;
	bh=BGmC9Ub+EwkCy+50Wez7U2hU9ogTq3RfJ1GhpzG3syM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKIcnr7vb6QYWKKmZ4MGNRfluhiMvv/ZcGy9MRlgaglVwusL3E7V9SXbnHp7unAus
	 FaAqm6AK8bdWSag9J0h47RjwmEbhuXZNCFlGtJgzLPYCtYNUOjzjXyRT+m1f+Qye+L
	 /oSX5sWi2me8ioxXIY22KYg4zPSHfTZrIJTILp0+pFN7rc0GO5wx0Zfz8fr6Z9Y95e
	 kMCeE4LlYLU9wlOg2xrIKQLMkAWZN2lWJ/iI8oaVry73ULwb35sXtdaBn9FXthlcNi
	 /9aL5ZqrVPJS4sjDYkRRCsAwWeZv6ZSho4TAK66ZdtXpqCqDIZVf/6YuiXrsTiJJFH
	 9zOOQk4+KDTfw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kR-0000000DAvP-2CUa;
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
Subject: [PATCH v2 10/25] docs: kdoc_parser: don't exclude defaults from prototype
Date: Wed, 28 Jan 2026 17:50:08 +0100
Message-ID: <42169cd386170c650110a62a4fe467ecf83d757b.1769617841.git.mchehab+huawei@kernel.org>
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

If we do that, the defaults won't be parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ccee4e0bcaab..0b6cba442d72 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -207,7 +207,6 @@ var_xforms = [
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-    (KernRe(r"=.*"), ""),
 ]
 
 #
-- 
2.52.0


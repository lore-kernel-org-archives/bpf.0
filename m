Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575D37BE8C;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=bCopkJ/UUYOBVM6BXxDk2IOD1spzrkeqF46FuKXX62YO/nxY6G8c1bbaq+y96yOvlFDElJ/+xiiu3tMvZxk2k4LI5ssbdjW510B0ALyRzcetVx5d9QD78oiylBMSEFEDtBtchjxJ6rUgi8m424ISvAszLY42srWVPHv65dnUfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=FAGo3vp1MYKDT8O2fN+VyX3S2nX5qeOzVDn265Hyrg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLtaQd4wYlcFQsSQ8yrx/gIb4dACEkTgF+hXllofg1Nm5Ow7VQCiJlGmt3vw1BcZgJS4EL8Z9yNcwZ4WoFMnFNdkMet/BFnAsSQvO4CK4VUyTfpDkMGo8jycQroAvFxnw/bXgzYOjhrlrMUKb3Cnr5JXq0wDQeH40F0nTzerHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYIXG4Pn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYIXG4Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C469FC2BCB5;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=FAGo3vp1MYKDT8O2fN+VyX3S2nX5qeOzVDn265Hyrg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYIXG4PntOUltCSEcvyS+98lAzjHGgYgoCfAR2ObOHOQwAoPHNqHuL+GENY8MpXYX
	 aVrxzzSXeVGrTJP7ruAICt3nre+KhGAEQVhJDCoOKLkkKWCi0Va5XVXq8LhVAtfetW
	 GwLNOXehMcLI4eZ97Xb2h2ko4fQAumc6/JMzBBr891wehhvVqPNH8XtJBVxJmkoLl0
	 3tlLkKoB88w3eSU5ZGSyt7HRB0k7eRUxCDZ8xisyLldDdwk4JyiXxt31gnZcGxH8bD
	 9NVS77OCFVPa+jYVkedLi2nc4cCqjH0yV180GVmB5oRJxGd3xkJVEmmGU6k4iene/+
	 ekd7boTnh2sjA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERNN-04ED;
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
Subject: [PATCH v3 13/30] docs: kdoc_parser: add support for LIST_HEAD
Date: Thu, 29 Jan 2026 09:08:04 +0100
Message-ID: <4f024c9e51d9354ccbf24443c88e1eb0bb5087c4.1769673038.git.mchehab+huawei@kernel.org>
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

Convert LIST_HEAD into struct list_head when handling its
prototype.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 92b550189988..33710c4be145 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -219,6 +219,7 @@ var_xforms = [
     (KernRe(r"__ro_after_init"), ""),
     (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
     (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
+    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0


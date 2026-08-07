Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0A233938
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064622; cv=none; b=mVTqNLvuU1SSvdNdw+eP9Pv9NK5+KyMLEg5bWS3VqThB3PUOFvMMco5l/fHaNmvvPuQc/2tKucf+MOJ2VIwCV1yKDAi5xnW3SS/zDHH1utHjnmY1PvBhMTtMrtda1NRnXZA1UE2IX2v2YzXDcDe72iytIJUkSvDDNxIyjVBAJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064622; c=relaxed/simple;
	bh=vpE6vWGn7zm2VJ/uQG0coy/9aI5tROi97JLcHBv5qnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZP4NtxpTfAmxmQ4SJxnqXji1QF7l50e8r0u27cQ2OoT4XxhLJKcCiR3P6GZq3XKCQiIexccdoelGEX85bo1oU/SxgNjac6GqV00y1uptl1OeVccw37Rh+N4N8xGXSimS6evraCdWnm4eB6EEPcRMdMtoxEVTbAiqrmYLhkpexEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DK/v3Y56; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DK/v3Y56"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786064606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4NPMPfYvs8YO3COzwGcfWMaaWC300S3yD9dfuIoNJs4=;
	b=DK/v3Y56xjFrF2K8N+nAgaSF6Xik8ghGF389/1ErJLjR7yxWtsXOwDMdmUoFnpVVF7J2yI
	HuntldO0cCJJ9DkY+kOrjYj+AJ8k4Gljl28gvoJ/18Vw6jlYIawDeHx3kqyxOLXjs7LJyL
	wxVaRnlWpAOnlipMDPvrR4M4jFO/Nv8=
From: JP Kobryn <jp.kobryn@linux.dev>
To: shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS, mailmap: update email address for JP Kobryn
Date: Thu,  6 Aug 2026 18:02:26 -0700
Message-ID: <20260807010226.8995-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch to my linux.dev address and add previous one to mailmap.

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 01453c5e1ab4..52cde9c10c28 100644
--- a/.mailmap
+++ b/.mailmap
@@ -458,6 +458,7 @@ Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> <jorge.ramirez-ortiz@linaro
 Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@redhat.com>
 Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@us.ibm.com>
 Jouni Malinen <quic_jouni@quicinc.com> <jouni@codeaurora.org>
+JP Kobryn <jp.kobryn@linux.dev> <inwardvessel@gmail.com>
 Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index cfee5d47b214..2fd28489c4c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4973,7 +4973,7 @@ F:	tools/lib/bpf/
 
 BPF [MEMORY MANAGEMENT EXTENSIONS]
 M:	Roman Gushchin <roman.gushchin@linux.dev>
-M:	JP Kobryn <inwardvessel@gmail.com>
+M:	JP Kobryn <jp.kobryn@linux.dev>
 M:	Shakeel Butt <shakeel.butt@linux.dev>
 L:	bpf@vger.kernel.org
 L:	linux-mm@kvack.org
-- 
2.55.0


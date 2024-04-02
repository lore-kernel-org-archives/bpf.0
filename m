Received: from boethin.uberspace.de (boethin.uberspace.de [185.26.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AE12BF35
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070659; cv=none; b=E/P73SpcrW1+zprM1BMeOdIC4DpKwMoJty+9e67sy9446ajcRQJ3Qposyvzhy4SuBqs3Euf31+f6DzhmGNINCocV/sTCEUVAkwv34AVRzoQayo/gEWOcqJ71rrYNApFBX3fqwOIspMRWoWplBLK00u60Oo0x908BcGHQ+zgnKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070659; c=relaxed/simple;
	bh=+Tj9N/ii3a0N317+KpRF9l+hzmoX5TKw5ide84KvAWw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VXMpZgrAuj8G/rXuG6p6orHUZgOtRWSo3JulB15f8FVN9eM7wX13W+OLfq7EadRErXhetDcE4uKE99k97DghbLGLsn9HdlUpyLkaZ8cL5NaSPs+Exerv+zwAuQYks9EWOkc4u92nz7o6Qb+zGcSQLiGMzgdOMRiyuxlEHzRJvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibor.de; spf=pass smtp.mailfrom=aibor.de; dkim=fail (0-bit key) header.d=aibor.de header.i=@aibor.de header.b=El0J0XBy reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibor.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aibor.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aibor.de header.i=@aibor.de header.b="El0J0XBy"
Received: (qmail 24330 invoked by uid 990); 2 Apr 2024 15:10:54 -0000
Authentication-Results: boethin.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by boethin.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 02 Apr 2024 17:10:54 +0200
Date: Tue, 2 Apr 2024 17:10:52 +0200
From: Tobias =?utf-8?B?QsO2aG0=?= <tobias@aibor.de>
To: Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH v2] libbpf: use local bpf_helpers.h include
Message-ID: <q5d5bgc6vty2fmaazd5e73efd6f5bhiru2le6fxn43vkw45bls@fhlw2s5ootdb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.000456) MID_RHS_NOT_FQDN(0.5) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.399543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=aibor.de; s=uberspace;
	h=from:to:subject:date;
	bh=+Tj9N/ii3a0N317+KpRF9l+hzmoX5TKw5ide84KvAWw=;
	b=El0J0XByVr2nInZ1Bxui9vjPWNe46LDh7pFHiJ50Pe+Wm9agvCYQE6qCMInAKILx8fQwSADwrz
	zhkbStb33IcYTq/zLT9a0AqI7s3OVXerBhi/IGUnSpbmbvOL5LK6jua/2Yo3y0fVFl+XHxNwxA4Q
	KFArF6lJ+BTSDLuRr2J1Die+Eeuk3o2yu6JHspyH4AEMEceEfGhE5itmzqHNV5W6Av8o8Ybd95Jd
	k/8kxpXFtWA9Mxhsv1t2KxX/CG7XzKzi5tCYyCcqJ9lVVmyCdH4RN75hXqYNZ/2AMQP8k3MITxHy
	Q/jz0HZdvBMF0sa3qX3q3gh8lv6yX9Vh6E7szpvfCOsMM7Edq3P7hYmZVtM92VfFsKkmIYqLeneL
	99vCKoheiRoIfGMOzaTQQQUrDeDFrIVb9gBi0bTKPx0hr9J7hIkldxZjP/oDqO8YfvXdTTRPHnpg
	C6gE16dbOapNK/jNtbaYlfAPWoirPVLZ5zA8upsxhRserrDQP8+M4Vy275np3C8a+CcTyAbvTo5a
	M+JMd+kQ3tGuze9avocwJWJ5XoNEYLaax5Q33WRw/9eKxCJV6VDCZyI4mNahVqlIHr6gbfw1T9L7
	5n+q0rpKt9r+2rPrs29xT3yRBxCW4KrrReCkHgMNRjMv2WsAakJZ6s3Nete0oQIuIqAhXYWsxbuc
	E=

Commit 20d59ee55172fdf6 ("libbpf: add bpf_core_cast() macro") added a
bpf_helpers include in bpf_core_read.h as a system include. Usually, the
includes are local, though, like in bpf_tracing.h. This commit adjusts
the include to be local as well.

Signed-off-by: Tobias Böhm <tobias@aibor.de>
---

Sorry for the very wrong first version.

Changes to v1:
  - The patch was based on the libbpf repo instead of the kernel repo.
  - The description referred to the commit of the wrong repo.

 tools/lib/bpf/bpf_core_read.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 1ce738d91..b5c7ce5c2 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_CORE_READ_H__
 #define __BPF_CORE_READ_H__

-#include <bpf/bpf_helpers.h>
+#include "bpf_helpers.h"

 /*
  * enum bpf_field_info_kind is passed as a second argument into

base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
--
2.44.0


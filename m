Received: from boethin.uberspace.de (boethin.uberspace.de [185.26.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8484FA9
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066492; cv=none; b=BMc2pfJaxSdGL+OKeXA3HUC9k6fmH9SQcGsu+z7avk66M7eL2y245AwSB7lKkxCMFRv+ed3NFeVxvastO8a43NAjumjcvwBeQbmYweudCOG4gBeWaoRdlpi9BF3vzedIj9CHyUUeVC58LXjbnr73vJD22XKq19+iPlXI+EmvlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066492; c=relaxed/simple;
	bh=KBKWO3K3hukulM+pTWKZcjCnizMwXPQI/t5LFC+V8ss=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JmKwRink002ofhobPaelwHduz4FoCo3ZArlXKuH0mPJpL1S9M8JxplHJVWl7dkcbFDRiW0EhyeeyjmZVDYodbgWigtBw09WvuvrM6OGGPCXmSoMumrrRV3T5m4MBRaP2itDPxD1l7AGK+Vf0vG3l5AD5MUHFb8O4mIFgqOIn8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibor.de; spf=pass smtp.mailfrom=aibor.de; dkim=fail (0-bit key) header.d=aibor.de header.i=@aibor.de header.b=PrW2cJ1w reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibor.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aibor.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aibor.de header.i=@aibor.de header.b="PrW2cJ1w"
Received: (qmail 32542 invoked by uid 990); 2 Apr 2024 13:54:44 -0000
Authentication-Results: boethin.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by boethin.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 02 Apr 2024 15:54:44 +0200
Date: Tue, 2 Apr 2024 15:54:43 +0200
From: Tobias =?utf-8?B?QsO2aG0=?= <tobias@aibor.de>
To: bpf@vger.kernel.org
Subject: [PATCH] libbpf: use local bpf_helpers.h include
Message-ID: <w36pchgaowqqzx3whsiu4ikp3lyniman2gc6fgi6n7w27tr2fm@25ijjwxxt67d>
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
X-Rspamd-Report: R_MIXED_CHARSET(0.555555) BAYES_HAM(-0.000348) MID_RHS_NOT_FQDN(0.5) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.955207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=aibor.de; s=uberspace;
	h=from:to:subject:date;
	bh=KBKWO3K3hukulM+pTWKZcjCnizMwXPQI/t5LFC+V8ss=;
	b=PrW2cJ1wJT3xcZjAjMx2YNLaEchRd4nzxyX7DHtEV9f3mkvXDvmGz+Y3jtu20zat4b/QSqZwZS
	p+YzAOaFgph0j0f22tkLU6DmbJfnxa6vXnw5/WL06oqCsFgkyfpLRYgSnag+nNqs6kItOqDldQaI
	QPWXs6LIyISTWrPLPTJZ70fCC9vLZDD6TIeuVkVKS9250MLtfUW8nD/clOycK0g2TWYa6t/Yj5uI
	ZiuaiahArwPCXN+LP5jAuahvAi8OQfsRrYlFRlMH8jnexbJ10+3ArKgNB9DKPGNoaZ0jA7o8nSZo
	vRoFx2dY7nqB6xiq2cU1pYU5FEAP4XnBQJPC56u3BluXs3qBSHOKZDqD5//MHFXiflXIYhme6Vtp
	YCw/mz0jRcGpEFlzhbaICsXl7KoQ7LXNcgs9dG2kiBZoGyr9kBwn/rmKXcjCLBQ+ABauG74b1uId
	e4amPyq5SBPp+EFjgSETxSWaEuTuIKKQFt0xppHDlMCmdFp8J//C2lwPCiy+UPlmzFz4VGNwQ44E
	Wg5B7wIovRpa6y5adYd0y8sD89K/J21thI8S5FZyXoh15MSoK2TtBS5Sh3fGDgF2An5uUiwZLUKO
	1Lhxdu9TC/UBx/F9mmi/YU6LRHjmZn7FgaNlmW6YN6YmngjNtW9O0EYEhiLt9qy4aLzqMnI0d7eZ
	Q=

Commit 688879fb0176c2933 ("libbpf: add bpf_core_cast() macro") added a
bpf_helpers include in bpf_core_read.h as a system include. Usually, the
includes of are local, though, like in bpf_tracing.h. This commit adjusts
the include to be local as well.

Signed-off-by: Tobias Böhm <tobias@aibor.de>
---
 src/bpf_core_read.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bpf_core_read.h b/src/bpf_core_read.h
index 1ce738d..b5c7ce5 100644
--- a/src/bpf_core_read.h
+++ b/src/bpf_core_read.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_CORE_READ_H__
 #define __BPF_CORE_READ_H__

-#include <bpf/bpf_helpers.h>
+#include "bpf_helpers.h"

 /*
  * enum bpf_field_info_kind is passed as a second argument into

base-commit: 20ea95b4505c477af3b6ff6ce9d19cee868ddc5d
--
2.44.0


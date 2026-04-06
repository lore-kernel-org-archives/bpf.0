Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F463845B3
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487952; cv=none; b=M5Q5PSpXGiyd4PnaklFcS/5e0cyNFsrTGn84ckVUg69zS0dGYvFQqiXudHWgyOub1GzeUWRIlHVdnroojjsW4j21A17MfvyYmtoB6uFVUEHHIKCLckd44R5DBtQKUvmhgR99nhMvOhG1W7+xSx3Vy0O3qdMoAMKgcLn23JmCxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487952; c=relaxed/simple;
	bh=2IA4Y/tl3V5Ta7iY6whiVQvZjcB/w6cNSs04L0nBtjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwWKPufgBtLM/XcQs+S6Hvf/YXRXYh3dpLs8t/+rTx3oKJhBWeXguBpeFVrjgCSfjiE1Z0HUEdk0Xb6Pr7uewhoHLiEcS8DWTzTdEQE2u78DTDtvylly4Ucw/YC4QXT7NBxcijKQ7ZCWadog81/lkDs7fKXyAg/q6MBbTbyZOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3eEENin; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3eEENin"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a8fba3f769so15391915ad.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487950; x=1776092750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3P0pfEV2a2MBjN4CC+4NkXRN04LThjrq38TbAQ5P1BE=;
        b=k3eEENin+k4DnjgVkrW+rgyMQ+iobdxO7WIlG8pPx8CsOu93yODGFJ1V1hy3JtKjcw
         A2rfOqc9VAx8+xlB1ROx03k8mVgHecox5pdkN31snQO2Btcxua0qHKWzEVhvASDgkWAm
         S1zBXdBw8+uiiuplFm4RpomGYOBTcbugn98o6Hjnkiin3jOCOa8bbfzp8isozVAiHzNS
         hQkmYNg+7sVErPEgBvV8LakIMLn1otfgAizFRSNUN9wa1NGGBR82u6K/GJqRqG1d5c0B
         CnJ1NCg8bN4e89tEAiY1gU1TWjg8cOOVOSEYMvM5aGwAFAANAkgErDElu3MxUgeil2+r
         7cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487950; x=1776092750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P0pfEV2a2MBjN4CC+4NkXRN04LThjrq38TbAQ5P1BE=;
        b=FPbAjgvNhQngfHoP48MD7kyTHbizf3yleIXvGmCTAQo0f7t5VY3jJ/M3zuR/JFM505
         pPAFx4668i/n4R2fcinOPmw+hpRVpYU21s/mNbCuyLd0J5wZAWf0ykY+EyVPUxu4+GZR
         isDfi2m1iWGnY+PyouZ35SjrttBJ6xaDQQ+GVvj7N5C1gpbJUd+Y0OQi/1rZBl+Evb2E
         TriCBDdqz5UyLdWlFuHOdbEUr3ptT9IFxbPQAR59XT2zJE9qMwszC5eRm1sii0+2gV4v
         b1DonVv7yqK5K4LSaeqgQO7lAeDyMtVUEIsS8rr5ILMdoczYhUvuPAudCxjsWDRkUeOt
         A62Q==
X-Gm-Message-State: AOJu0Yw/nVoCRILHfxbtbkyubtyWzsbyim3NqrMqpM2QkmiXKosI63x1
	/eduyoh/R69FRfoaZOkk+krGjnCk0h54Nx2ExQETnzI0q5XdO3/FccFzo5obLw==
X-Gm-Gg: AeBDievEwCdxHOV5qaoaeGU5mQCxZ5zT3An9MfovSYVpwuDWGaJDoOPxyvE8k/95BRs
	+FdoS3X4ENL+c9IjD0rOA5S9BIkACKyMZzPKle2i8KPJJQGnmjuOwFu8jutem9j4OhZDgazX4/y
	934iewegGqCFCSJncWATQ0TeXvbMJMp+df94YR7Yh9ByreAvoVdMsjcbNr59YLcB+oVNB49w8lm
	RqW7jKkqnfZBpjlNjrot0fP0VJSZDJhFkLxez0h67Hw3YuoCHdr9jiffpWMWE6Qh40spfCa4M3W
	41g7OsK/pq37IGix6DhRBZGdGwoE2OaVcwYulX1duuYkB884zm+CEh1qsD5fjniCdUwU3sG5RGL
	9RLdFnC28WREWOWVb289zKZpfx2J5vJJsfmLnRDPa1PR6+ka/imZZwpFAWsa6hPfKOOyvex0MY/
	OgIaV26LIm/3gsxw==
X-Received: by 2002:a17:903:3b83:b0:2b2:5a5a:4f2f with SMTP id d9443c01a7336-2b28184bfdamr133478315ad.33.1775487949854;
        Mon, 06 Apr 2026 08:05:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27473583dsm143092065ad.9.2026.04.06.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:05:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Allow referenced dynptr to be overwritten when siblings exists
Date: Mon,  6 Apr 2026 08:05:46 -0700
Message-ID: <20260406150548.1354271-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset conditionally allow a referenced dynptr to be overwritten
when its siblings (original dynptr or dynptr clone) exist. Do it before
the verifier relation tracking refactor to mimimize verifier changes at
a time.

Amery Hung (2):
  bpf: Allow overwriting referenced dynptr when refcnt > 1
  selftests/bpf: Test overwriting referenced dynptr

 kernel/bpf/verifier.c                         |  23 +++-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 115 ++++++++++++++++++
 2 files changed, 136 insertions(+), 2 deletions(-)

-- 
2.52.0


Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B235975
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447383; cv=none; b=lTYlBAOfMK3hICHEgoZjlfXWiSdm3SDtdx6xtCCpAH8yOM9+a8/AJT+0eo19EGDeA3OMGIj5vMAMiQIWcNlm6VIfqqdMpH3phIXGTnRqXveDalAhgYiVkfFaZEgrKvaWxhVSdzxk06GVdkMM/K300hPD60PR0o04BdKrM+r85FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447383; c=relaxed/simple;
	bh=WEP/xiKJ7Ytn8NZhEWeRF9t5kOOWbCVtFKZZ3vRNGFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtbpX6irIP/iGcFydumIQUlAXfduhgaVLP7RwvaxZSJcRQriMmPmiNPqf0Oi90byU3qD3AO61brOvWQT3usXW0sxNtQKJDLASLS+Q1CiZD3RLtXIa5ntFXsLWRN23dZLKCwRD0YfDRB/YdtplSSx4HmPuW2Cz+bprp+AhIRCg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdkeZOmh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdkeZOmh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caed617615so23698925ad.3
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447373; x=1788052173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8miRh1ZdGGKCW2NT2qVvXgZK5Yz5UsBCYc4UUu5cVsU=;
        b=pdkeZOmh7Va4MGIC//CVqNkebCW9ZN8GNBy8VbN9LuZQHd4hvzU/yrQfO2WdOsGtxq
         p2NaFkwHpyT/wjhBTqqFz5LDgHk3xNO3sB5gbtj6KKdfxTTOKjt+9YSrlyMZrpKBB78j
         3Fwvwqe3cvQoRYAgCtNr2B5fwqxB9VAwqU3bdyiwMUdGvNY3mI88macpwnb29hHIqSBn
         OVFaWOrAtRgOZmy7aidxYy9ilzm+qzYpR2LC2vb2afNcSrmaQ1ofcpM71b+iBS02bTQr
         qdWNwpTY1KbYFZayHqhs6JBBJu9ugDTEGuUAMe2A/fND3niNDlnrE5rzbPFxkh1K+U4c
         kT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447373; x=1788052173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8miRh1ZdGGKCW2NT2qVvXgZK5Yz5UsBCYc4UUu5cVsU=;
        b=AG8mhPdIHA4roqim4ObM742ivecNj19gPXHOCXe+aL6P1yrgbn/1quvbqVfwKmM+Ji
         hC3aRZ4wfaNVr6tk25SutdnanTO6FXUYp34YFBa6TjlM+xW+MncSSkXnBSCBWrhCb8cA
         gfXXv5AWC05CT6sOUYsvGIefZXYthk3ZH8lVIcT4RHk38s21R7ADJX+s1dRY5l9OUH5k
         XOWJUVZrSQgTuZ5sFKKxJONBhpagG5MWU8X6M4pRL1V+IEEIDsfZwC4cKitoam+xn43u
         VCTw4RhQZDwAOxsDrWzoCZ17bNg/83d0IL6v95qVAnhZjGk3xMUsk6ZFkbVnEIpU/Wxt
         TafA==
X-Gm-Message-State: AFuF++kqwvMsM8PJ/NBxqcJL+Q+1Ii2gUecI2d88iw1QYZIvgvConOV9
	+/R0CknVl/HHE+RYB8N2AIsWphr8SWrR0hUir0St5wItd32vpz92B68g2v5ULBX7
X-Gm-Gg: AR+sD11MHyjuKNzH0KLtFjn9RTxq5xBUcs1LLkBiQcdcrvEuFqarUypKPoMRMjVNDcF
	ClGYcxJFRmFUi0xDCOKiA+Ha92QhWHCeq7F3qGkzB68XPsHpoiHt0GvOapiDe52yn2taAwWPEq6
	YdcTuJO76jE0HEFVpMpeNR+E5obOFs4qPiZX1CcW01ZnDNT24lAYz8950Ydl1Z2kidkaJrpngsp
	4nJJnldFSqXNUL470MgD4+H/X4B3gQkPnzcJKgzQaQixnsSkSORTP58kLJBrvoXD1MidGgjA37j
	ZLkM9G39L2UOHbpqWwAjaAe6dYEB4h8/5m6w8ub5gza1g1uPfyO1mxc/xmZYlxhyBX2TukRIRJe
	SQroepuM88qP0sLMReTTdxkgarJETsErVDLxWPf+8dDEVv24tiD2DYuCeDMFl4mWsZjrgEL/c2l
	7oaCgji9iLc6inGcSow06oLiWqRZJXj7k+ODz1P9t0n+3n9ErSoEjhtRDgWfVI2/l7yqK+MND6/
	nWBiCFJR8SAJySswVOKR9mKrvzt+wtMXz3tYfhBf9qieudsQ5BUKWvpG0vkBhi2lQ==
X-Received: by 2002:a17:90b:2808:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-395df289c4bmr15612760a91.9.1787447372605;
        Sat, 22 Aug 2026 18:09:32 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:32 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [PATCH bpf-next v6 5/9] selftests/bpf: generate verifier/tests.h in a regular recipe
Date: Sat, 22 Aug 2026 18:08:56 -0700
Message-ID: <20260823010900.1730708-6-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier/tests.h recipe is a $(shell ...) expansion: the command
runs while make expands the recipe line - including under make -n -
its exit status is discarded, and the resulting (empty) expansion is
what make actually executes. Turn it into a plain recipe.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d30f2e46b136..2a99b040301a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -915,12 +915,12 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 # them (e.g., test.h is using completely pattern), that it's worth just
 # explicitly defining all the rules explicitly.
 verifier/tests.h: verifier/*.c
-	$(shell ( cd verifier/; \
+	$(Q)( cd verifier/; \
 		  echo '/* Generated header, do not edit */'; \
 		  echo '#ifdef FILL_ARRAY'; \
 		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
 		  echo '#endif' \
-		) > verifier/tests.h)
+		) > verifier/tests.h
 $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-- 
2.43.0


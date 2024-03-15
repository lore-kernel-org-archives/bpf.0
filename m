Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3A612E
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469130; cv=none; b=RM1COx9K/wF+ZJIxjYbzr3CV/FPdXPfsVf1PuG7DNdogA49OqLlm0xXWA0mxAFqaWGNMUXAxjAjMP6uEzEDAKJRYQKyU5iGPD73+LTIoRJdNxhut5buAzfFNgjnTiR5CELzYP1S8i+5CnF8f96HZ0AURgeMD4KVHoGyGHphjXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469130; c=relaxed/simple;
	bh=Ma3gWJpDDdEY2PHAX9uxB0hodqqLz6SSTDTiqh0msx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCRY3Nnossb7djPNo2GZ/qThSofVnm+jQu4F0K468XyjyADiY7MYViCWve6eIkaR8t9VFeG3i5Hbxl9ckpoT2PK9u9IxvFsAbz82Isssp4aj003f8MGJyQjNq8FckCal5mCOHqxRYMxLVVq9qdacC5f9whUY8fOLWKEWJ7WYtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxQnZ4FY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxQnZ4FY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd955753edso14126465ad.1
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469128; x=1711073928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zx7uP+08rqU4RWjEF5NIqdDD1npSQ+tlO45Imu6axw=;
        b=AxQnZ4FYrv6QDxy0FwUy/DXiFR8elykny/BgLNc2+qjL87MyeTX0jVcLgYevnvEV2w
         v4TC0bQ/EhaXdJEOY0SVpYOUzu7E5ZcQm7isG9+XpiYpOXSKs1cfiugdtASlKP56QD2T
         tcvMqsKwccXhbvlv+SUo3okuY5kFhygpg0cMvwc2jvLVFbyIduXJ08vl22sUCZwfdZrm
         au0B+w1ZkTJFQThVYqBytFhGkgp0vQo159w0/KhPS5oAz+nDrXgG0C9IqE5sDzfK+bMt
         AeeKLoKLFanZT5/526yJAlstFescuK+QcHb6WHNBWXNmXNqvjsij3eocFjTvBV8um8dH
         EnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469128; x=1711073928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zx7uP+08rqU4RWjEF5NIqdDD1npSQ+tlO45Imu6axw=;
        b=pfV1eXBwNjvfHgF4dJdj17o4082dW+iWmy2umiseFMCEA9jmI0P+gT8XIe5DmqCGwl
         1SXq5rerlMqyvvvN0bFzLLPapq3wM4cUXzMFsVEIxTWD+VlCQkqdLJe3xR99z2BexUut
         71eyWyL83uOYkIyKczqFCaIMJU6UbBffXAsCyhpOJV7za03037PLZSxFWfSO/fXtVRSn
         okjm/n+SgCxLvxxyYnWg/6l+gMPCTcJC1bTiIrLmDLKZnVzWOMdOZVZXVx8jD/3uFZTQ
         pt2cnVRGu9CQMyxSxzY4cA0ZZ7p6bcUcpwX4EsPT7u77/nQiG+6eGd9M4ErcyEwVKJNI
         opHg==
X-Gm-Message-State: AOJu0Yx6qo8+SoBBfMby1fXCKOdI7I0XSLCCClJCeMfnmPXHaUBhW8Hi
	O2PpV3X/oTBmJ9IhxX+hMi5XJ3liwiW0T+cOoZKGwmHcyJxlxSSYVsDl059x
X-Google-Smtp-Source: AGHT+IGI+zFrOc/Rqmpv9XDOzSo1uZFmdk/W/vFxrG4YH/f6UafrgD2mx8n6tPB5wv1YL/7MErn6gg==
X-Received: by 2002:a17:90b:2348:b0:29c:718b:7b8f with SMTP id ms8-20020a17090b234800b0029c718b7b8fmr1702476pjb.28.1710469127773;
        Thu, 14 Mar 2024 19:18:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:12e])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090282ca00b001ddddc8c41fsm2478072plz.157.2024.03.14.19.18.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Mar 2024 19:18:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 3/4] selftests/bpf: Remove hard coded PAGE_SIZE macro.
Date: Thu, 14 Mar 2024 19:18:33 -0700
Message-Id: <20240315021834.62988-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Remove hard coded PAGE_SIZE.
Add #include <sys/user.h> instead (that works on x86-64 and s390)
and fallback to slow getpagesize() for aarch64.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/arena_htab.c | 8 +++++---
 tools/testing/selftests/bpf/prog_tests/arena_list.c | 7 +++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_htab.c b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
index 0766702de846..d69fd2465f53 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_htab.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
@@ -3,12 +3,14 @@
 #include <test_progs.h>
 #include <sys/mman.h>
 #include <network_helpers.h>
-
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
 #include "arena_htab_asm.skel.h"
 #include "arena_htab.skel.h"
 
-#define PAGE_SIZE 4096
-
 #include "bpf_arena_htab.h"
 
 static void test_arena_htab_common(struct htab *htab)
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_list.c b/tools/testing/selftests/bpf/prog_tests/arena_list.c
index e61886debab1..d15867cddde0 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
@@ -3,8 +3,11 @@
 #include <test_progs.h>
 #include <sys/mman.h>
 #include <network_helpers.h>
-
-#define PAGE_SIZE 4096
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
 
 #include "bpf_arena_list.h"
 #include "arena_list.skel.h"
-- 
2.43.0


Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75E3DD854
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699720; cv=none; b=KytifSm/tegWyj0v902wF45BvKObjfoYUBZVIotLIjBkq7EthHKsofyr+os9C0WyfWs6orzIdMzAeS84f1s/ltNYo5GJNflH2GAkXaOU50n0WDLXrEmmjmRjG7ImnHf5O3ifw431Z5GXDr+SefACnNZ1vQQhsv+cxnnImQqJ6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699720; c=relaxed/simple;
	bh=uA8RnXxses9eHB4e+5mSM73hHol2C1wgINLbrKMtAiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEri6+cKPKs8Z+ASHBnRJUJmGDFo9MaUiIHgKJnXlVPxudxTv/ithjX68YprJrZOs3yYx3Z38RfRs3G3wTvWFTS2zzAqiYrXmpHb7h4AnGpXlpunLP7RfPBFNQ7VGv7Yogi+rIHBDruXHmQBHdgajMzJbYE7xEai9VRm9Ki8NEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxesgct9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxesgct9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-88d48da248eso673510b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699719; x=1792304519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=804cKzdzNsJIGyHCdLqQQwJKDCbd31dDak7kUu7eQT0=;
        b=qxesgct9jzEWjWYplO8fDrv/Nr46AqTLq+6bza33GMR2mCin9syQ59phHFWXkTvyIU
         clvQ2gb0ipnHhW5C93C7YB8V+5Rlhwg+Xm0Q5FBafpWRWGm3lSuk26cFgOWVhsuQytlK
         kKwAAtIaaLrWLm0I75UiA57lRpe1trNIMq4rReuZB1CJz5sWSTBV1jV6EXd8Q3jqfAK4
         9avikAPE62zR0tz5e4QwsToS9IkLTQhTjHWkJUGa9ZCv2myaf4iLdgjv3AOif2TLFRiL
         nPe7sFiy3mI/t1tHnBcV0P3EUW3Xm1IFqKsSMpKbfh29wzIh/+g8i1Pab6g7V2lkTN6X
         Vsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699719; x=1792304519;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=804cKzdzNsJIGyHCdLqQQwJKDCbd31dDak7kUu7eQT0=;
        b=VxK3CLCYulVOiQmvfK/yUOp6nW2eDd0lelFkquLo1wsvUqbRcjbERFQyfS5X1VyXv3
         LIL0XK8li3tIuAPcpcbns/9CBDnI1k7UiSZWWBdRd/52KT+AmgQacJYAqim1bpW5NU5u
         0bt4mD1jPg+qEumbfXzhXX9q3tBhrd2c499YTczSDKsTzIO59O//ma87fnr/T/dYQwga
         9rjgwHEIX1WthZwerB+dzBfJzkYOqHKiw5dQnOWsL9x8s7f2Wg4BRshZLYaB1odd10zG
         aA3uqsJkYjm53wh7Rrvf+WC1CcebO+qZmUBDiukRapzItUMZJg2JT01WcYfU9p04Judq
         NicA==
X-Gm-Message-State: AFq9FYJ222e0ep464cGiYjD8joCGRHEWXFSMct37IB/9HCV2tg+ZVfJ4
	JS6o40XLN9+K169c+cNrVIIMQY7FNFUtZc8qHQCcNX1r9L/h6wLwcn6xWGpIQA==
X-Gm-Gg: AYBFou07Z1O7JAeUUfcFx9VoYpDL8egzAqsOpwlgZ26gwyQTYdr1oPNVcZuk3OwLc9L
	HgmooFVeA5pkWqY3mpHz9cM0tU03jX+KYmBOjfgbmei532jWSDuV/0y4aNxvhzqyIHmPvlZ81Lu
	kFw88D+5rhDT/+dSgeEIG24PKrMg05bbrNn4sBTviLrpkPn2g6I+DjGkaYyDfEXs/w2VVg3V6RE
	rKm+N6o06KQHkzUnfSEVa8DadDv6A+IYmP/3+UTfraTxHI+I/sdFv3t8ChFHWvp3MF/PGU+Sj3K
	dCNys275uoka1530/wAjD7StZ3o1Eu4msyuyM4EB59WAWgO4jb5qzGjkaNBaVDJRXb8PRXCd3pv
	uFg5ISAi+uh/o0WEGFqd6KTrd4VZAMfW7VsKliiuMQQ/rgmyjQ8dQK0ksWSMXNrsaxi3C41ygT1
	fd7weTSnzz9TiamAc5kJsSNg+2La2ZNIQXh/YlPkc4Evk51nbMguvzm2l6vvQOx3qmzVp7Z70u8
	FA7HJFzETPHLp8=
X-Received: by 2002:a05:6a21:3511:b0:3dd:85a9:55ab with SMTP id adf61e73a8af0-3e16be2877amr5092912637.36.1791699718653;
        Sat, 10 Oct 2026 23:21:58 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 5/9] selftests/bpf: static subprogram argument side liveness tests
Date: Sat, 10 Oct 2026 23:21:39 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-5-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Verify that liveness at calls to static subprograms includes both
the argument registers declared in BTF and those that are actually
read by the callee.

Cover cases where the BTF declaration matches the callee's register
use and where it does not (as might happen as a result of compiler
optimizations).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/btf__compute_live_registers.c        | 21 ++++++++++++++
 .../selftests/bpf/progs/compute_live_registers.c   | 32 ++++++++++++++++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf__compute_live_registers.c b/tools/testing/selftests/bpf/progs/btf__compute_live_registers.c
new file mode 100644
index 000000000000..b6633fa88030
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__compute_live_registers.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Use both parameters so clang keeps them in the static functions' BTF. */
+static __noinline __used int static_two(int a, int b)
+{
+	return a + b;
+}
+
+static __noinline __used int static_three(int a, int b)
+{
+	return a + b;
+}
+
+__noinline __used int global_two(int a, int b)
+{
+	return a;
+}
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index b0aaf5961ac9..61605385b3a3 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -414,9 +414,21 @@ static __used __naked int aux1(void)
 		::: __clobber_all);
 }
 
-static __noinline __used int static_two(int a, int b)
+static __used __naked int static_two(int a, int b)
 {
-	return a;
+	asm volatile (
+		"w0 = w1;"
+		"exit;"
+		::: __clobber_all);
+}
+
+static __used __naked int static_three(int a, int b)
+{
+	asm volatile (
+		"w0 = w1;"
+		"w0 += w3;"
+		"exit;"
+		::: __clobber_all);
 }
 
 __noinline __used int global_two(int a, int b)
@@ -425,10 +437,15 @@ __noinline __used int global_two(int a, int b)
 }
 
 SEC("socket")
-__log_level(2)
-/* a static callee reads r1 only, a global callee its declared arguments */
-__msg("2: .1........ (85) call pc+")
-__msg("5: .12....... (85) call pc+")
+__success __log_level(2)
+__btf_func_path("btf__compute_live_registers.bpf.o")
+/*
+ * BTF declares r1 and r2 for each callee. static_two reads only r1,
+ * while static_three also reads r3, so its call must keep all three live.
+ */
+__msg("2: .12....... (85) call pc+")
+__msg("5: .123...... (85) call pc+")
+__msg("8: .12....... (85) call pc+")
 __naked void subprog_declared_args(void)
 {
 	asm volatile (
@@ -436,6 +453,9 @@ __naked void subprog_declared_args(void)
 		"r2 = 2;"
 		"call static_two;"
 		"r1 = 1;"
+		"r3 = 3;"
+		"call static_three;"
+		"r1 = 1;"
 		"r2 = 2;"
 		"call global_two;"
 		"r0 = 0;"

-- 
2.53.0

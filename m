Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117B4A35
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059611; cv=none; b=IuQTFzl+bKmddNeYozvVf/G9lsRkiLfz+KNdE0vWKJamBmMe9yxEbdHBh2jto18ykTyd44sUoUQjjGawy8JB2+9w9xU4JLtY5C7GxYFt3pEMVZcAQm627Nd/9OwUxZDoyBUBdp3c5lXybYA899VwhWHooYvzLEaCbyobcO/NkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059611; c=relaxed/simple;
	bh=83OuN09KtZC0g7TBc13FOMsZMNpF/DqV8HiNImcpZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfWmZegL63RTN7pg780KuLC+ba2vUK5mSRdCwymujOsXXL+wK5cCWDFl05B8KFAzxVYHlsuYtg7o1nJ9eEfZ5RV206GHaYfyvecrzg3wpwQcGtV9bjqzz77/OMkwhe1+ZeHauA5f9HYBvOqx83Zn2kG+FssMw3FQM1OTLzlZGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFnzYnu1; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFnzYnu1"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so456633a91.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791059610; x=1791664410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jChyzsT0KLD1kawe4WO0y261MDLARTQJvVqH9Zy4alw=;
        b=ZFnzYnu1FMzXYwKpisy8YWAapnDidKznbS4hmxKY2wV+nyemXfEhyjHY1c6g7FSmJ8
         XIfHkFyPFIAkg4LcAb/SadZNamvBKuUJOgJ1TLFidmXlIfqvD7PgX809YzxENrwK0wEa
         udKwYKGMBzTLHLiIHU7to+/medZgKjWRS8g6TMLOCkQHP5PbN/ribmOXJWRO+essg8h6
         36Px37i3bBKUEG4oiZmBBnmsXOE6RWGnbcNK+deCk0jLSm/+5ryFR1amjCvwyQEOcecj
         hxghh/v/Jaj8Blz2JvK0VYNUOEqJWa3Wb09044ctO3E/QqhA4GNuSyUtWnT/qJMspTd8
         a5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791059610; x=1791664410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jChyzsT0KLD1kawe4WO0y261MDLARTQJvVqH9Zy4alw=;
        b=MFkpZCbBcA62NuiQgNwSWsuT9Z+5Zdk7pgzikcG0E2SJipNejyB8F5TtIzUnjYpFqV
         YY892LYXb0kDmaVY5DQ+2uT+wbxVtGdDJc5IlVrazHC7QHzGdnHuTshS2TtBArNNlwWY
         DpFaoKYorEPU8jpwxqJ+ku34aCSPOI57nYBN54SwADgxSGJg0xptpSOlZ/CkEAsjHn6E
         jZQPVKgwx7D8KfXDnkCPmlfyj8c6elF5N+TXMvb+AD90azDifh6MzFe/fWXUhIICqeC5
         xQ8htmOIgGd5zHvaqegELkUgXyr1vTIKW1ZZb2WaISpgU6E7Ap9WOHlIn1MeoC9H5Kex
         Y5kA==
X-Gm-Message-State: AFq9FYJdZlW+xxsMln/S/3E6+duf3Wg20+jarI/1rS3+0NlGPtP9DQ4h
	8mN0HNlUNZH/AkvWO8Py5UnFadloTp/EpbTF/zx1oZhN7sJZAbm3ea2IfcafaWce
X-Gm-Gg: AYBFou0I2auC8Ok5gy7UMgoS7eef17vkF0yXuciGXPiGcOV2pHG8cikTi2ifC0frN2U
	yY1aJlKTYqgpUtcxMbtfv2zUK/3nmdvQ+hw4Y2o18Sus5pkmO5DJpnRHfbajnwAMaCTwEnETfMc
	yhQrNSmsQ4BsZruUjrKrd7sc70Hv1v848hTPgG1bOrbLmSKfVYvtui5Rv6brWbqC0Zq5vxDbI5H
	t19pJta0VSWhqGTNc3fIs4ptbGQHcDrt4iFCTffwSrC3tWLJcOQJczAoJqNyw0KteZ3+gn5Zpin
	+NwikmNnLqbUHJ7K0oJLymj/zZ9qpzCfFrrt8Uqh2FWR97K2Woqtkde9uEDF0XEOwu4ELwQ0Sve
	QTz3btd337FVGsLj6iWfEi19AvGwsp8w1ecd6kWyuuYR1CUCyeKfnxr4t12t3Afzyw1gXMvl+0T
	wbTY59zIBazZWqP7NRKMR5Bb6vCBYvu3iZp+kZK35XcrZwANuuOybAxBYhz1XSVWzoAw3dnfSDE
	xb5wzxX71kgXvisXQBYMTzvvDMHCn0YJ2tHyX0Xq++gHJiluPgsnpPOJHSBoxATT32YY6UGbNlq
	Q8fSVU5pyUU0Fid/pL92JiX18/7pCTyNBbcvLHj+GPl2gU4+dmVI9g==
X-Received: by 2002:a17:90b:5790:b0:3a0:49c5:d3c3 with SMTP id 98e67ed59e1d1-3a6ce97042emr5851665a91.53.1791059609831;
        Sat, 03 Oct 2026 13:33:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d7cdb31sm4012009a91.16.2026.10.03.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 13:33:29 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Format data_in_arena_rust.rs with rustfmt
Date: Sat,  3 Oct 2026 20:33:26 +0000
Message-ID: <20261003203326.1086454-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

'make rustfmtcheck' checks every .rs file in the tree and fails since
the test in Rust was added:

  Diff in tools/testing/selftests/bpf/progs/data_in_arena_rust.rs:42:
   #[no_mangle]
   static IN_RODATA: Node = Node { val: 3, next: None };
   #[no_mangle]
  -static mut IN_DATA: Node = Node { val: 20, next: Some(&IN_RODATA) };
  +static mut IN_DATA: Node = Node {
  +    val: 20,
  +    next: Some(&IN_RODATA),
  +};

Format the file with rustfmt. The code and the data of the program
don't change.

Fixes: e86cb7315451 ("selftests/bpf: Add test for global data of a program in Rust")
Closes: https://lore.kernel.org/oe-kbuild-all/202610032132.AVJhE1qE-lkp@intel.com/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs b/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
index b69128487a0f..3dd9d4208232 100644
--- a/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
@@ -42,7 +42,10 @@ pub struct Node {
 #[no_mangle]
 static IN_RODATA: Node = Node { val: 3, next: None };
 #[no_mangle]
-static mut IN_DATA: Node = Node { val: 20, next: Some(&IN_RODATA) };
+static mut IN_DATA: Node = Node {
+    val: 20,
+    next: Some(&IN_RODATA),
+};
 #[no_mangle]
 static mut IN_BSS: Node = Node { val: 0, next: None };
 

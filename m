Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA552848BB;
	Tue,  3 Mar 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522668; cv=none; b=pugC6aQgGQAVqrHsqJBunWlCI/19N6TQHZWimkW9T023ZWcTLzMM2GHGz+D/TKPcacotBEL8hlj4JpE1QLZxOrmJwCOhz2fiLCDCCqYcJdhnWGNq3HQksknt51gTrNQ+0Sq8N/Wpq+wnCx8Hs8BOM8YJcO6nSrJFk+30HH6654Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522668; c=relaxed/simple;
	bh=Es196YeG+70qw0n2ceX/lhCeIW20rSH3pl2LHQseJDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVfdEI8bEhpjUqq8xhO8yJSaDVId4vVBCIHkxgJ6YHYAatAFyQe8gc/15Sbk5mcauu8TMhdqKqLCE54tkJsDR185b6FrUPtD275YR8vmEjLkX13su1CNMZxIhCMoAhYoWK4uN+M4+LVgqGmR9kSOLT8ecEB8tdI3amAVEe9cl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=o5BTgwgA; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="o5BTgwgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x3
	rn7gZpH9mRjTDX/QjdbmjaJA3AHIVg1ikqiO27ZMk=; b=o5BTgwgAkV50N3oL6W
	fiUCzwCAApDl1N2NbV99Zn2OMqbozbgCb8h6UyQj0+UOVwOPLdgdM3772/giC9ou
	Y1pCtrnlwA/38Co2cE5rjRKMkrnU81bojjTE6yQT8CMdbnY1Pgb34U6ro+qY/Fyn
	BKJDfOqAZvU3Q3fjdxBW8l4/s=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnT3h6jKZpVDeAAw--.53445S4;
	Tue, 03 Mar 2026 15:23:40 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 2/3] selftests/sched_ext: Add -fms-extensions to bpf build flags
Date: Tue,  3 Mar 2026 15:23:16 +0800
Message-ID: <20260303072317.76035-3-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303072317.76035-1-zhaomzhao@126.com>
References: <20260303072317.76035-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDnT3h6jKZpVDeAAw--.53445S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW3Cw4ktFWkGF4DXr1UWrg_yoWkAwbEyw
	4fWrs7AFWDCFy8tr47ur15Grnakan0grs5ArnIqwnxZw4DZ3Z8Ga1DuF1jvF1FgrWjgr9I
	vF4vyFyrtFn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8VT5PUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqhxGvWmmjHwHfAAA3J

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Similar to commit 835a50753579 ("selftests/bpf: Add -fms-extensions to
bpf build flags") and commit 639f58a0f480 ("bpftool: Fix build warnings
due to MS extensions")

Fix "declaration does not declare anything" warning by using
-fms-extensions and -Wno-microsoft-anon-tag flags to build bpf programs
that #include "vmlinux.h"

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/testing/selftests/sched_ext/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 2815a875bde2..a3bbe2c7911b 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -93,6 +93,8 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     $(CLANG_SYS_INCLUDES) 						\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -Wno-incompatible-function-pointer-types				\
+	     -Wno-microsoft-anon-tag						\
+	     -fms-extensions							\
 	     -O2 -mcpu=v3
 
 # sort removes libbpf duplicates when not cross-building
-- 
2.43.0


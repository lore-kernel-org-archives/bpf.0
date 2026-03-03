Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F0386559;
	Tue,  3 Mar 2026 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522672; cv=none; b=mnvfgzhX4c+Z5fE+OYbVvCDXlkyPxe3jv0vr10QzaHLz04zqlIwRuN38jJf3E9qQ8iCPZnV430aw7s8sWrLABOx6xtUPIqz+urWcX3Wc+K2sSI7u0wR2tip/yTlkgJz7DoEZzfvi7tYxkpIYbtF9GWnutVlaOSCj/05abBYho3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522672; c=relaxed/simple;
	bh=ZhbS9+zj9pm46vg3/tJUFUvyCl6pcK9oDTswYyYcr0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUqNWOnpYg7NioZat2AhneI44uSKOqMgfku6fvnhOhpih+tXRWKyWrMd9KJszeSaI90pyYVWzogApmiEs1KRltqNykOINTPmP/NLkN0Onv8XfhLTw3x153YvEu32Bb/DEiXmd5MeDam8lPFNLlNPVOmWa3OLDkx6PmNHSjEpQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bARPAhw0; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bARPAhw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lg
	4B1zeTRguD4yHmSHP9S8HLeBsC70QVg5urFAZPiwQ=; b=bARPAhw0dN7qeY4AGb
	RuNqWiYTp0QOSXYifyrS7lPy2qjyqzt+bbih2xtmoxWpRVx+ucpwSqzFbEnXaW9b
	cLzYaTqSQrqiTM31lTDtpZUu0N9GmqntUZT+M4uhdc+i3pXniy1XTJgsZFDpYdei
	5ELIUxMDnlagsvIBUt7isuqtI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnT3h6jKZpVDeAAw--.53445S2;
	Tue, 03 Mar 2026 15:23:38 +0800 (CST)
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
Subject: [PATCH 0/3] tools/sched_ext: fix compilation issues
Date: Tue,  3 Mar 2026 15:23:14 +0800
Message-ID: <20260303072317.76035-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDnT3h6jKZpVDeAAw--.53445S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4xuw1xZr45CFWfXFyfXrb_yoW3AFcEvr
	W5WrykCFn8Cw1UJw47Wws8Jryak3WDKFs0vrn0qFnxXwsrXF1DJF4DWFyUAry0qay7Jr9I
	va1vyF1Fyr12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUdgA3UUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqhtFvGmmjHsHawAA3c

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

This series addresses compilation issues in the sched_ext (scx)
tooling and selftests when using Clang 17.

1. Add -fms-extensions flags to scheduler and selftests to avoid build
warning like "declaration does not declare anything"
2. Use signed div for peek_dsq.bpf.c to avoid clang 17 crash.

Zhao Mengmeng (3):
  tools/sched_ext: Add -fms-extensions to bpf build flags
  selftests/sched_ext: Add -fms-extensions to bpf build flags
  selftests/sched_ext: Fix peek_dsq.bpf.c compile error for clang 17

 tools/sched_ext/Makefile                         | 2 ++
 tools/testing/selftests/sched_ext/Makefile       | 2 ++
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0


Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C93F7A82
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087211; cv=none; b=CKP97/XoH9JkiJnqKmfEAi2mJsoNhsYUAZCw0EkOoF6Y3C3/41QzB4bwGuWd2B/CBIFLJeN7o92L5eGQQXqnH37bfugoJSEafScR7auenXslVw9Jpqhe1IoaKNgp4h1joLbb9qdcObVtK2W5lQ8P1Z+3+rTFVFzaiVDIyXwNsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087211; c=relaxed/simple;
	bh=99Awv4p/YpHh8uIlL20PuCOZqFAaXfStCugn2/mTAzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxrUuxbxiqJ7WGxrC1sUOaiD/d2MjLtgPRykv39P09ur25PDwOSwqX/q7CwiAGXZFtOtY3vFL4wmuCeJXRx0nN9igDu3m1enm3NRtaSB6wiMl6bx+Iz+vP4jJzqhB8cG2+RpD+AN/z15k8NEoJeloxALbUNVbuaCsIJEXO1Dy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PWQpvtEB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PWQpvtEB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780087198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XFVOIICd/CtvKQr1GYXFlIipfXLzMt6AZz01mWTQiLo=;
	b=PWQpvtEByBDge4lKFQt/y6bA9QTcCQ9zsPrtJERPIFdIrBmNMlQTJNyRqRr5gOjvf929Qf
	qQOOr3prPOMcmBEpOP/AkotZDHY9H3LnTduMpf8dt0DKgH8GZK/CIuZX8XcvijtiB37009
	6MAr+TyrAg3zDmdfhWc02BLmyFLhA8E=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
Date: Fri, 29 May 2026 13:39:09 -0700
Message-ID: <20260529203909.1222164-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

I am making a life change and will take a long break
from my current work, so I will step down from the "M:" responsibility.

I am currently a "R:" in "BPF [GENERAL]", this part stays unchanged.
I am folding most of the parts into "BPF [GENERAL]".

For "BPF [BTF]", it is long overdue as I am no longer involved.
It is folded into the "BPF [GENERAL]".

The "BPF [STORAGE & CGROUPS]" will also be covered by "BPF [GENERAL]".

For struct_ops, its usage is no longer limited to networking,
so this naturally should move back to "BPF [GENERAL]".

For the reuseport, it will continue to be maintained together
by "BPF [GENERAL]" and the "NETWORKING [SOCKETS]".

For other "BPF [NETWORKING]...", I am moving myself to "R:".

Thanks!

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 MAINTAINERS | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfc621ff629d..d9caa2d980f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4766,13 +4766,6 @@ S:	Supported
 F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
-BPF [BTF]
-M:	Martin KaFai Lau <martin.lau@linux.dev>
-L:	bpf@vger.kernel.org
-S:	Maintained
-F:	include/linux/btf*
-F:	kernel/bpf/btf.c
-
 BPF [CORE]
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
@@ -4905,18 +4898,11 @@ F:	tools/testing/selftests/bpf/prog_tests/tc_netkit.c
 F:	tools/testing/selftests/drivers/net/hw/nk_qlease.py
 F:	tools/testing/selftests/net/nk_qlease.py
 
-BPF [NETWORKING] (struct_ops, reuseport)
-M:	Martin KaFai Lau <martin.lau@linux.dev>
-L:	bpf@vger.kernel.org
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	kernel/bpf/bpf_struct*
-
 BPF [NETWORKING] (tcx & tc BPF, sock_addr)
-M:	Martin KaFai Lau <martin.lau@linux.dev>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	Stanislav Fomichev <sdf@fomichev.me>
+R:	Martin KaFai Lau <martin.lau@linux.dev>
 L:	bpf@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -4951,14 +4937,6 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/testing/selftests/bpf/
 
-BPF [STORAGE & CGROUPS]
-M:	Martin KaFai Lau <martin.lau@linux.dev>
-L:	bpf@vger.kernel.org
-S:	Maintained
-F:	kernel/bpf/*storage.c
-F:	kernel/bpf/bpf_lru*
-F:	kernel/bpf/cgroup.c
-
 BPF [TOOLING] (bpftool)
 M:	Quentin Monnet <qmo@kernel.org>
 L:	bpf@vger.kernel.org
-- 
2.53.0-Meta


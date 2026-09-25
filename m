Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E34C150A;
	Fri, 25 Sep 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351398; cv=none; b=R992ED8yH5hKzYrTO1I2uirH5Tz3oB8MEvbRj2IzyhvBNwEdKFYk5ZgYoTD8RjOlaUU6yxtlxC1SLgtWGuz2SI9diEFmG6cnZqYYevgJ/MNchErK7LAR+/H7+jkKv3ubePLfJMZOlWT0WSS6XjMuW+lbt/BR11tLB0XuVe7KcYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351398; c=relaxed/simple;
	bh=F4ibQWODzZomGlt2ywAO+0t4ahK0XWx4HOEa5XUaYEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaxP9V58g/XjuzRlVq/f9Ioh0p59BI1nKVkBKLE3Yf8xjVWFzzkUVdc+VcOr3tKS5GRQ8RbEDq/t1aXmzJXvo1xC4HRQmXtuEzMRJvG4br/WsIGrBmyTpVW+yiFj4pq5LhuZTr37KG3EwLTICdHi0HHJCxNCsEV2cNNhMF3mqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=oIcJh32C; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oIcJh32C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=GTNAdLGCgHPXPJLlo0W13sa5PuyffoSxT/9I12DHV2Y=; b=oIcJh32CDxe0
	nWinriNHkKqSTACHNHnZAwuny9zRdlY0BwfKKNIRbWYMjIf4WEwEAZmxLVPPZFeDiQZZC8pBHu+Cw
	ISb6TMo55Z67NZyPVRBbwX1dg+m8T4C4Mu51NzLkJJgXF6gk6KvJT/x0BQtV6FX5994L06BDc6yhr
	fI56LUN28PTEseXuWCsvFHRe4a5JwRArBkrZ2Bfpe4CR1JszX4aHQ+KxPJE/sJ0+ZAqsVI6vLQ2Aa
	s1cWweyU6GRxeya7hcwGc94OMezPkz5Xvr4JM6XRJzByjbra7dMKkK89ANsSMkhnyJ5DpGO379+9g
	ggF6t3l7Id57TrGzpQXdYg==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA88H-00B2AA-33;
	Fri, 25 Sep 2026 17:49:42 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next] samples/bpf: build the BPF programs with -fms-extensions
Date: Fri, 25 Sep 2026 18:49:19 +0300
Message-ID: <20260925154937.3677406-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 835a50753579 ("selftests/bpf: Add -fms-extensions to bpf build
flags") gave the selftests the flag because the kernel is built with
it, and the generated vmlinux.h carries anonymous members declared by
tag:

  struct slab {
  	...
  	struct freelist_counters;
  };

samples/bpf did not get it. clang without the flag reads such a line as
a declaration that declares nothing, one warning per line for every
sample that includes vmlinux.h:

  ./vmlinux.h:34528:3: warning: declaration does not declare anything
  [-Wmissing-declarations]

and lays the struct out without the member, so the BTF of the object
describes a struct the kernel does not have, and a program that touches
the member does not build at all.

Add the flag, and -Wno-microsoft-anon-tag with it, the way the
selftests do.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 samples/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 95a4fa1f1e44..c28e65046986 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -342,6 +342,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
 	$(Q)$(CLANG) -g -O2 --target=bpf -D__TARGET_ARCH_$(SRCARCH) \
+		-fms-extensions -Wno-microsoft-anon-tag \
 		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
 		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2D3859F8;
	Sat, 14 Mar 2026 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524915; cv=none; b=IQX6ufP4xOkkQK5CuKFQtVmN7vJM7b4due7kOsmc3TTI7qsiaD/l3gF2Di16TBAg5ugzK48Sz3EjiXkBxC2L3eTAiWy0a+v4srQ2ukgVpW99ti0lfMWfUGeUPNBn5YZj+K9t6TjYUK/1bMAbyrEBF03j4AsndtM+DtTK825YlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524915; c=relaxed/simple;
	bh=em46XdrIrOoHd6/gCu07GXtwkxyZAe9Ut6Kz5qyQZEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM7N8lI0zN2kxz0dYmckJ9YpymOjwhswj36cklhmctUE/EogMlXVb/dqmAD7iYj8nt2xr343bWfHP8UqSau1FyFCICjpGFlJBC+pffOMJwLQns2NvZDHN5Z/VCBy5LttmZQYsh4lKPdWVv5O0q12jlTdZswNTn0FK/SMS7Pnrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL07JSU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL07JSU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EDBC116C6;
	Sat, 14 Mar 2026 21:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773524915;
	bh=em46XdrIrOoHd6/gCu07GXtwkxyZAe9Ut6Kz5qyQZEs=;
	h=From:To:Cc:Subject:Date:From;
	b=IL07JSU9ojQJJ410gpQiIUnUqezsUVIr9y88Hb+WPQ34MlWTS0IRUMOQf28OCdfHH
	 OTvACZ+5FBzsJJXFHqoFgAkWieNCSqNZNWKEMpV1dXUf/85DDs75lROq2g9pLC3s2Y
	 zaK8g+FwHVcv6hPBDKfRzd1tLTN9ZdUavFtXQUQTSX+rulRfNTKr5R6VBIiOKLIpSX
	 2nLRHCUxonPM6dyLr0hzJWadXyI66xMC5wIUUS4cncfQYU7+mJUqU6gjWheX3a6php
	 LfB65MZU/qdF8brdv33/w7sn8T3X3C2TLlynPUXlcfrvw9eGijDs84obtSSiRTJ9ad
	 c7LKABIik1fdw==
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH bpf-next v3] bpf: Remove inclusions of crypto/sha1.h
Date: Sat, 14 Mar 2026 14:45:55 -0700
Message-ID: <20260314214555.112386-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use
SHA256") made BPF program tags use SHA-256 instead of SHA-1, the header
<crypto/sha1.h> no longer needs to be included.  Remove the relevant
inclusions so that they no longer unnecessarily come up in searches for
which kernel code is still using the obsolete SHA-1 algorithm.

Since net/ipv6/addrconf.c was relying on the transitive inclusion of
<crypto/sha1.h> (for an unrelated purpose) via <linux/filter.h>, make it
include <crypto/sha1.h> explicitly in order to keep that file building.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

v3: update net/ipv6/addrconf.c to fix transitive inclusion
v2: update include/linux/filter.h too

 include/linux/filter.h | 1 -
 kernel/bpf/core.c      | 1 -
 net/ipv6/addrconf.c    | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44d7ae95ddbcc..e40d4071a3455 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -19,11 +19,10 @@
 #include <linux/set_memory.h>
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
-#include <crypto/sha1.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
 
 #include <asm/byteorder.h>
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625c..f11ab6f354e2e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -16,11 +16,10 @@
  * Andi Kleen - Fix a few bad bugs and races.
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
 
 #include <uapi/linux/btf.h>
-#include <crypto/sha1.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0e55f139e05d5..04c1e856bf7fc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -34,10 +34,11 @@
  *						status etc.
  */
 
 #define pr_fmt(fmt) "IPv6: " fmt
 
+#include <crypto/sha1.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/socket.h>

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.53.0


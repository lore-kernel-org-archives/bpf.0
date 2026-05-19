Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C8492511
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208606; cv=none; b=bPKaJkvsI1KsA2G3mJwgfAKS84b8TiS7XIV8b5La5GKvWpjfFZQTiWzRhAQy19nIcxJvsoomavZ9VmejRSxykX+cdz2PyHSkJ5YchUZIjf/wNESpuu2o50X6UmZiAl16zEf0b2DBsz9IiwtoQMQEIS9OpoI7nH1NAyqDoaUommI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208606; c=relaxed/simple;
	bh=I24jaPUwmsmtWLF5u4QeWb+I/xMcc/SaKDRU9iIoWic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYKVIqBT1H865NWfVOzrQFIJzxZsOIfz8D9gTRa1QJNivddlE9x+D62Ypl2KZsi3o2hkKBDy4Kl+P469ZXh4vJBvUfP3D+qCVIK8JbGsglVSPuj2zQ3RHsqaf+OOrVF/zkry2bcMW6ubDFYfkddmWpB6d1Zr3c8XJZXKsw1ND1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsfCBZQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsfCBZQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FB3C2BCB3;
	Tue, 19 May 2026 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208605;
	bh=I24jaPUwmsmtWLF5u4QeWb+I/xMcc/SaKDRU9iIoWic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsfCBZQS/VJ4MRP23KdSiXVdB0Li5X+QIUdD+TBDzT2r5/ixvWT0kvnQi9p9Xowzx
	 0T/6qP3eK1COmrKRsX7XerF2OVRGsXHuj3EHZvANGdAYQQKirHYv2aDPHfnop4CGm0
	 airX/ZKPkyWMXmk8HZ+e5d8l3XZzgd3LfjCrjGsqvIbWUbDz5X12lGw+utzBGUKFg3
	 DA7WEbwTIkUyAO2OJs0rj86HkP6kbU13n/fOp+3ALmYuHfXbQxGh6fiHHl1AKYaFK/
	 yy3217q5k4kr/xpggq3zRTLgNZbdLto+3FHwj2XM3LTOzBsVKtKHXojht1x+WzsNHg
	 itDdeFP+zsr/Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/4] selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark
Date: Tue, 19 May 2026 09:36:29 -0700
Message-ID: <20260519163632.2220753-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519163632.2220753-1-puranjay@kernel.org>
References: <20260519163632.2220753-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cold_lru mechanism generates a per-batch hash to XOR into the source
address, ensuring each batch tests a fresh (uncached) flow:

    batch_hash = (batch_gen ^ cpu_id) * KNUTH_HASH_MULT;
    *saddr ^= batch_hash;

When batch_gen equals the CPU ID, the XOR is zero and batch_hash becomes
zero.  The source address is left unchanged, so every iteration hits the
warm LRU entry instead of testing cold lookups.

During validation, batch_gen is 2 (one increment from seeding, one from
the validation run itself).  If the BPF program happens to execute on
CPU 2, batch_hash is zero and all LRU lookups hit, producing:

    [udp-v4-lru-miss] COUNTER FAIL: LRU misses=0, expected 1
    Validation FAILED - aborting benchmark

This fails roughly 50% of the time depending on scheduler placement.

Fix by forcing the multiplier input to be non-zero with | 1.  Since
KNUTH_HASH_MULT (2654435761) is odd, the product of two odd numbers is
always odd, so batch_hash can never be zero.

Fixes: 4b4f2229104c ("selftests/bpf: Add XDP load-balancer BPF program")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/xdp_lb_bench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
index b9fd848c035d..f40e36aa183e 100644
--- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
+++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
@@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
 		__u32 *saddr = data + saddr_off;
 
 		batch_gen++;
-		batch_hash = (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
+		batch_hash = ((batch_gen ^ bpf_get_smp_processor_id()) | 1) * KNUTH_HASH_MULT;
 		if ((void *)(saddr + 1) <= data_end)
 			*saddr ^= batch_hash;
 	}
-- 
2.53.0-Meta


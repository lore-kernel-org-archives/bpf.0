Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03223394B
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284038; cv=none; b=N/9ZzWnpMpLD9SHHvLtn6c8TFHg1kF1l86avDv4t3ESEeOsagEF9GtFZ/jpMUpL9uJEEXG+ajUCnF3SGS1IFie+AR4fZ2OWgrDE5NmgaVjcM6Xs1fc7MWPclFZk8pDePYKrlyXL+EVfSSovs1foxD2O9W9xQSoA0oj1h+sycGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284038; c=relaxed/simple;
	bh=k9hwrJHxRJhuOVy3O44koLyq0dWNQ0Qd+fBOI5U9IMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhCSDiDOj3aztJuuAiFl6LtBmXe1pbGiLKgAahrasAMVL2IH1eBQXfQ6H5Atftqmk0GV5Ij06gDyGBXK2jtb1dkNuwBVo72ng2j/cMq5ers8Ax4hoE2NL3RvrB8isN655CavyvNXM1tz/tJVhqCQBNDpAv3f12KXu45QadYC640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4pGh2UA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4pGh2UA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF1D1F00893;
	Wed, 20 May 2026 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284036;
	bh=BxpdYJzaLtXddl5PW4U1iOc7s7kY0EV5hycp/w3T9Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4pGh2UABc9Yi4cdg2dQ9JXETAHQh4tXmlYEAgSrr3cxkOLKjkRKB+/z5Uv0yunez
	 pGJS8pccBvRzEzeIHkijzpNHiyDp2Fnjl5SActtRq/p6SAkFOK1jvy1l35ObS/Awc/
	 KtUH8qiv2wruiKQmkKt1wtS8tC/MWPR/GmLEx1lEuU5VkePfImwnn5lGwGFxRBw85H
	 tpfFzxOKsuh8vTKKARR/poJQ/n3M+sm+R5w8yqvLwfvYw35fu4GExATbje8gL6MZ8p
	 TEi0cL99Y5Wjl0YDKC7TGar8I/in2wozS0tkbBGDbun5p0s9ag/qaANyYj9s9OZVuo
	 J2t8mCjRPHghw==
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
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark
Date: Wed, 20 May 2026 06:33:30 -0700
Message-ID: <20260520133338.3392667-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133338.3392667-1-puranjay@kernel.org>
References: <20260520133338.3392667-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    batch_hash = (batch_gen ^ cpu_id) * KNUTH_HASH_MULT;

When batch_gen == cpu_id the XOR produces zero, batch_hash is zero,
and *saddr ^= 0 is a no-op.  Every iteration hits the warm LRU entry.

During validation batch_gen is 2, so running on CPU 2 triggers:

    [udp-v4-lru-miss] COUNTER FAIL: LRU misses=0, expected 1

Replace XOR with addition so the multiplier input is always >= 1.
This also preserves the per-CPU salt for multi-producer runs.

Fixes: 4b4f2229104c ("selftests/bpf: Add XDP load-balancer BPF program")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/xdp_lb_bench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
index b9fd848c035d..13777b3dcac8 100644
--- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
+++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
@@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
 		__u32 *saddr = data + saddr_off;
 
 		batch_gen++;
-		batch_hash = (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
+		batch_hash = (batch_gen + bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
 		if ((void *)(saddr + 1) <= data_end)
 			*saddr ^= batch_hash;
 	}
-- 
2.53.0-Meta


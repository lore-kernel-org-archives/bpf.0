Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFD3C0605;
	Tue, 14 Jul 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031399; cv=none; b=WHz8CjR6nA9JyTjUndHZtld+AUlYEEJkhs25/t6s9LZW1PFmhL9tBpjLl8Jt06pJ+KMrzL5vg4F8TZv9Z8KQHyiXqz4HNQSf2H2ez5E8ZC/IhYe+MCZJxDQerLIOkeeVEMmHzp2GoErhNc8jE5gwEnJpLOlNcQaqlYMaXUZbW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031399; c=relaxed/simple;
	bh=3IUxIAMwAgJQi/w5DKjB1ynDyfv07I0GZbRiVejHe9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhU7NZ/47aVkhiEM3Uy3s+W8rJ5EA3cqCyBWIvjlR4q8xAYUMGKt7bhI+Bm8tktcxuQUETuLcrPPFjTMMZUC9PwWsPFD3hJNdXCCh1JpmkmDJm0UzA+oMscaUtswuaMFS2Sr5glFovvJm1CnEtS75YJ42W3h3guPSIjpomUGkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d40b551c7f7d11f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6ebc2989-9d4e-4cac-8341-8829a453cdbc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:2b8b25a171b65b0ae0ef429c63571512,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d40b551c7f7d11f1aa26b74ffac11d73-20260714
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1685286094; Tue, 14 Jul 2026 20:16:23 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Tue, 14 Jul 2026 20:16:16 +0800
Subject: [PATCH v2 2/2] selftests/bpf: enable timed may_goto tests for
 riscv64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-riscv-bpf-timed-may-goto-v2-2-eeb6201aedcc@kylinos.cn>
References: <20260714-riscv-bpf-timed-may-goto-v2-0-eeb6201aedcc@kylinos.cn>
In-Reply-To: <20260714-riscv-bpf-timed-may-goto-v2-0-eeb6201aedcc@kylinos.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

Enable verifier_may_goto_1 (raw instruction tests), stream_cond_break
(250ms timeout path), and the may_goto_interaction_arm64 fastcall test
on riscv64 now that the JIT supports timed may_goto.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/stream.c                | 1 +
 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c | 1 +
 tools/testing/selftests/bpf/progs/verifier_may_goto_1.c   | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 92ba1d72e0ec..8d8e53d37266 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -64,6 +64,7 @@ SEC("syscall")
 __arch_x86_64
 __arch_arm64
 __arch_s390x
+__arch_riscv64
 __success __retval(0)
 __stderr("ERROR: Timeout detected for may_goto instruction")
 __stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 8d7ff38e4c06..e6671c54e53a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -660,6 +660,7 @@ __naked void may_goto_interaction_x86_64(void)
 
 SEC("raw_tp")
 __arch_arm64
+__arch_riscv64
 __log_level(4) __msg("stack depth 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 4bdf4256a41e..f47b9d540a17 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -11,6 +11,7 @@ __description("may_goto 0")
 __arch_x86_64
 __arch_s390x
 __arch_arm64
+__arch_riscv64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -31,6 +32,7 @@ __description("batch 2 of may_goto 0")
 __arch_x86_64
 __arch_s390x
 __arch_arm64
+__arch_riscv64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -53,6 +55,7 @@ __description("may_goto batch with offsets 2/1/0")
 __arch_x86_64
 __arch_s390x
 __arch_arm64
+__arch_riscv64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -79,6 +82,7 @@ __description("may_goto batch with offsets 2/0")
 __arch_x86_64
 __arch_s390x
 __arch_arm64
+__arch_riscv64
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r12 = *(u64 *)(r10 -16)")

-- 
2.25.1


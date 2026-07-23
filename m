Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226D3909A4;
	Thu, 23 Jul 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785319; cv=none; b=b73JiycIFFR1bso+UZaNqQO8B2TrmPJUziOK95Me69yW5s5sZO15rjGKL/iHXz7JSwd6bTgOjqSP37T/aAjPv+1AxkgP9ELIEYDVSSjxOcWcurulJBG0SVeIMiMplExrNJ0RxarrJjvIXrs8kK5x3uM7EjNO9zzw1T0FfiJMGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785319; c=relaxed/simple;
	bh=uDd5tNYduRkYXRqylKmtFKkryYiwk3mUXyQHhCo29zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hdc0lMJBuKFAVKZXIWHYD9kwIgNzR14f/NEwBO1UroPWGNrA7PtB0aroj/jyxds/Hy3rfKXwxuwivAKcOLtRFyU/715qRm+VI/N9QxJL2YTJzUoNhsgOajJiJjK5pKXer8WFHvw3E3eMuGCHe+mWJz8PnjTRzVPhmtIqfl5ejRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2f3b94d8865911f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8b73f118-e106-4292-9956-820ddf859940,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:98fb09498250e5c02ee766237887bfaf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f3b94d8865911f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 774362690; Thu, 23 Jul 2026 13:41:42 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Thu, 23 Jul 2026 05:41:34 +0000
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: enable timed may_goto tests
 for riscv64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-riscv-bpf-timed-may-goto-v5-3-86acb54e5642@kylinos.cn>
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

Enable verifier_may_goto_1 (raw instruction tests), stream_cond_break
(250ms timeout path), and the may_goto_interaction fastcall test on
riscv64 now that the JIT supports timed may_goto.

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/stream.c                | 1 +
 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_may_goto_1.c   | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

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
index 8d7ff38e4c06..83707faea049 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -660,6 +660,7 @@ __naked void may_goto_interaction_x86_64(void)
 
 SEC("raw_tp")
 __arch_arm64
+__arch_riscv64
 __log_level(4) __msg("stack depth 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
@@ -679,7 +680,7 @@ __xlated("10: *(u64 *)(r10 -24) = r12")
 __xlated("11: *(u64 *)(r10 -8) = r1")
 __xlated("12: exit")
 __success
-__naked void may_goto_interaction_arm64(void)
+__naked void may_goto_interaction(void)
 {
 	asm volatile (
 	"r1 = 1;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index cb1ce4d13cfc..0e211f030d0d 100644
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
2.53.0


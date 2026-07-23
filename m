Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D53A875E;
	Thu, 23 Jul 2026 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785311; cv=none; b=XZ1TBead+dV3yUa8YXARFqES/xn83ZQt/kTORJ03v7KdVSO5efN4LvJxGOfxWlEvpLS1gaQBLb8Waf8MjmetsSl1QVvRVnyvLosVHQwqWXU4bF+Usy/h7lj3TzpzrK8HA6vYTYCWIeNdJfOnHZaOPFuzVQowgwpQilx6mMWWbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785311; c=relaxed/simple;
	bh=QXGUUwr8r7UuDcNGIxEhO0ZUdlwKcgzeI+2RxnKctVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kv6eDFFYmz9dy+GJ1J16OyZNnFIFjTu3pp+BbVkFn3+jXwBwJyK4gEFnYYQj31gX8tph6PNoEzNOgkQpgT8GYLaGvhIcQForu+j+9WuJ1MoH6tauJKZwlhAKlvyEZElIO49V4bvhx9MM0ZRFfbOtYdc/5b0TTdQyOcVxShVt3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e9d4558865911f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d549539a-596e-4b32-8d4f-e5554912d50c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:28fd9810108bc453a4ed04c95b0e54a7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e9d4558865911f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 653154881; Thu, 23 Jul 2026 13:41:41 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Thu, 23 Jul 2026 05:41:33 +0000
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: test timed may_goto
 preserves R0-R5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-riscv-bpf-timed-may-goto-v5-2-86acb54e5642@kylinos.cn>
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

Add a test that checks R0-R5 are preserved across
arch_bpf_timed_may_goto() calls.

Use bpf_get_prandom_u32() to avoid the verifier removing the checks
via DCE.

Suggested-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 .../selftests/bpf/progs/verifier_may_goto_1.c      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 4bdf4256a41e..cb1ce4d13cfc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -106,4 +106,62 @@ __naked void may_goto_batch_2(void)
 	: __clobber_all);
 }
 
+/*
+ * Use bpf_get_prandom_u32() to prevent DCE from removing the checks.
+ * retval: 0=all ok, 1-6=R0-R5 clobbered.
+ */
+SEC("syscall")
+__description("timed may_goto preserves R0-R5")
+__arch_x86_64
+__arch_s390x
+__arch_arm64
+__arch_riscv64
+__success
+__retval(0)
+__naked void timed_may_goto_preserves_regs(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"r0 = 0x1111;"
+	"r0 += r6;"
+	"r1 = 0x2222;"
+	"r1 += r6;"
+	"r2 = 0x3333;"
+	"r2 += r6;"
+	"r3 = 0x4444;"
+	"r3 += r6;"
+	"r4 = 0x5555;"
+	"r4 += r6;"
+	"r5 = 0x6666;"
+	"r5 += r6;"
+	".8byte %[may_goto];"
+	".8byte %[loop];"
+	"r0 -= r6;"
+	"r1 -= r6;"
+	"r2 -= r6;"
+	"r3 -= r6;"
+	"r4 -= r6;"
+	"r5 -= r6;"
+	"if r0 != 0x1111 goto 1f;"
+	"if r1 != 0x2222 goto 2f;"
+	"if r2 != 0x3333 goto 3f;"
+	"if r3 != 0x4444 goto 4f;"
+	"if r4 != 0x5555 goto 5f;"
+	"if r5 != 0x6666 goto 6f;"
+	"r0 = 0;"
+	"exit;"
+	"1: r0 = 1; exit;"
+	"2: r0 = 2; exit;"
+	"3: r0 = 3; exit;"
+	"4: r0 = 4; exit;"
+	"5: r0 = 5; exit;"
+	"6: r0 = 6; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0)),
+	  __imm_insn(loop, BPF_RAW_INSN(BPF_JMP | BPF_JA, 0, 0, -2, 0))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0


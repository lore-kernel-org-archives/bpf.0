Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F33655FD;
	Mon, 13 Jul 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923424; cv=none; b=hccus6T51hyk7czccsmnr16TaBNGTDc22+sFeWVE5lJxbO7WSMvWlVFjL4iyMXzVEnl7KbEgTUXM+30YGQf5eDKI2uYVtnkPrGK1mn5FF58vt8fXffNaCJDEHV17PHKOVCE8aXQyCeOv48c02wJQXL1sPixHEQ4CbUp1c/DZ1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923424; c=relaxed/simple;
	bh=JiKuvEK5TwKlotTplfcewv4m2HSMkRixEVxEm5janGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/llzq6x3i/3lVM+qTLlU0KDzO9P1hbmaeo1Ok5iBu/sBJKLaYpuRBH79Z5q9ivNhKRBb2tmpLKxtGhKrNTDaIclbcTtPsCWCHfJfLWjJyDI45ez73o5WKvUpyXHxmmw3kNJmVIIWfTOBZrNiyp8hp1+1U+EQuqyipT0XQO1MIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=MFL7W4Fi; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="MFL7W4Fi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=YlwYcQQTP50tWS/GKB6PAZ0J5qg1x8sJTR
	1dOrjh0R0=; b=MFL7W4Fifk064Tl+crrBr2TWDGWMoTBGsEPr6f1iydGlAYB/Ph
	X6y3eYRklHSkjo4k/5cEd0IDMbrlA3ixrMnFfhA7cog5YMQ7p+yvTQiNau6NuUdy
	58+b5D9/huqZ0DFwVoyGfeZlzIpFD5Ejc2E8eVPyJ3MXSIwzupR2/2X/8=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQBXpJGwglRqEFAjAw--.21425S4;
	Mon, 13 Jul 2026 14:16:45 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover helper reads of invalid spill siblings
Date: Mon, 13 Jul 2026 06:16:12 +0000
Message-Id: <feb30511a4b3e198253666b5ea2499d0944c153f.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBXpJGwglRqEFAjAw--.21425S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw17ZF43ur4UZFyrKr1UGFg_yoW8uF13p3
	4DKaya9348Gr1xua43AFW8AFyrJF4kurW5XFs3t3WUurWDJw12qr4Ika17Cr1YkF18Xw4r
	ZFyaqay8C3WUuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8AwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUaZXrUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier_spill_fill case that passes an untouched byte next to a
one-byte scalar spill to bpf_map_update_elem(). The full-capability load
retains the existing uninitialized-stack behavior, while the CAP_BPF-only
load must reject the STACK_INVALID helper read.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 8b166c42c4e0e..e686f6d8d5656 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -11,6 +11,13 @@ struct {
 	__uint(max_entries, 4096);
 } map_ringbuf SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u8);
+} map_partial_spill SEC(".maps");
+
 SEC("socket")
 __description("check valid spill/fill")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
@@ -1307,6 +1314,32 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("helper read must reject an invalid sibling of a narrow spill")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv __msg_unpriv("invalid read from stack R3 off -7+0 size 1")
+__naked void helper_read_invalid_partial_spill_sibling(void)
+{
+	asm volatile ("r5 = 1;\n\t"
+	"*(u8 *)(r10 - 8) = r5;\n\t"
+	"r2 = 0;\n\t"
+	"*(u32 *)(r10 - 16) = r2;\n\t"
+	"r1 = %[map_partial_spill] ll;\n\t"
+	"r2 = r10;\n\t"
+	"r2 += -16;\n\t"
+	"r3 = r10;\n\t"
+	"r3 += -7;\n\t"
+	"r4 = 0;\n\t"
+	"call %[bpf_map_update_elem];\n\t"
+	"r0 = 0;\n\t"
+	"exit;\n\t"
+	:
+	: __imm(bpf_map_update_elem),
+	  __imm_addr(map_partial_spill)
+	: __clobber_all);
+}
+
 /*
  * stacksafe(): check if 32-bit scalar spill in old state is considered
  * equivalent to STACK_MISC in cur state.
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801557;
	b=it1wp/N22nCqpc6bB4DDu1E2tBLjJqM4ou9UXHI6iwG/Ih9IoAPSFYY0skFL4zCp/lGP
	 +IMi5W5zxRUhjZ11Pmp7p1J1rnnJdlu8CGGrPgo9jHdYWlBTpJVSqPWS4efhzGyBymZcp
	 mph2zpbhd3K0MskI4FYADiV4R6Xym6f8NVK5Um/HgTGTw7OO4eRZe+oh0XK+MbIor8fyl
	 T9+QTShPPWSSC2EnE/DJF8cr1/WG3GCItyXrJZ9+VpopWku37gne11qVlUXDLb7XbJsF7
	 YBmHoJ3ybnazoCqXyFqAdQn+43qmqm5SwXvC8/0aSUUDnrECHNNlkfSGO55XlsxR2Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801557;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=j5y/xB7R2/Z2LDaXzlFtsMtmuvZKAkljLigBDMKHnPI=;
	b=iSzJHx8mPNl/g0p3hc8tSwj9F1fEK8qvmhkLVY4EuARMy5GEs+gB3nhpvovzKzWwmF0I
	 dEPgCzLelrkMTprZGX3XniQQJSDiJOWK/yefgXeRDgoswQkWQplMfHj55OB/DvDURqVo5
	 H6bqW4b1e9SSpXF1SxyObujHMpEGjl0AbvD0B5n5QiljWRzTetlEQ/dDA2T4TwAzf7fT9
	 eZ9P//uqbAqgEBLzo0MidumJ3M5s7jYWlsNkuV/tSV23yC5gJVxHTTYXPfDc3OSPU4zPS
	 bjbkKyu+0Bu5CU80HV/SSCGqDIkbBpNlTBXpEsnvaLeU68xEcs2keaMBnaWtjbOTYRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9D606A89E;
	Mon, 16 Nov 2026 03:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C9D606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxW_CSf_pqSQAgAA--.26723S3;
	Mon, 16 Nov 2026 11:59:14 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs2Mf_pqKNE0AA--.64529S5;
	Mon, 16 Nov 2026 11:59:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Fix unaligned access failure in fexit_bpf2bpf
Date: Mon, 16 Nov 2026 11:59:06 +0800
Message-ID: <20261116035907.4215-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261116035907.4215-1-yangtiezhu@loongson.cn>
References: <20261116035907.4215-1-yangtiezhu@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxJs2Mf_pqKNE0AA--.64529S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1DZrW8Jw1rAFW5ZrWDAwc_yoW8KFWkpa
	97A34jkryIg3W5X3Wjyw47GFWFgFn7tay8Kr1rtr98Zw1DJry0qr1fKF1UKF9xW39Yvwsa
	vas7KFZ8Z3ykXabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

When executing "./test_progs -t fexit_bpf2bpf", there are 5 subtest
failures on platforms where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
is not set, as the BPF verifier enforces strict alignment checks:

  ; tcp->check++; @ test_pkt_access.c:98
  226: (69) r1 = *(u16 *)(r2 +16)
  misaligned packet access off 2+(0x0; 0x3f)+16 size 2
  ...
  libbpf: prog 'test_pkt_access': failed to load: -EACCES
  libbpf: failed to load object './test_pkt_access.bpf.o'

Rather than skipping the tests or setting BPF_F_ANY_ALIGNMENT to
bypass the alignment check, fix this at the source by applying a
bitmask 'off &= ~1' right after the initial range check.

This explicitly communicates the 2-byte alignment state to pass
the verifier and run the full fexit_bpf2bpf test matrix.

Before:
  $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
  Summary: 0/10 PASSED, 1 SKIPPED, 1/5 FAILED

After:
  $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
  Summary: 1/15 PASSED, 1 SKIPPED, 0/0 FAILED

Fixes: 6dc03dc71387 ("selftests/bpf: Add test for freplace program with write access")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c   | 1 +
 tools/testing/selftests/bpf/progs/test_pkt_access.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
index f4bbf87b82dd..ed06345825e2 100644
--- a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
@@ -173,6 +173,7 @@ int new_test_pkt_write_access_subprog(struct __sk_buff *skb, __u32 off)
 	if (off > sizeof(struct ethhdr) + sizeof(struct ipv6hdr))
 		return -1;
 
+	off &= ~1;
 	tcp = data + off;
 	if (tcp + 1 > data_end)
 		return -1;
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..21f28a762d60 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -91,6 +91,7 @@ int test_pkt_write_access_subprog(struct __sk_buff *skb, __u32 off)
 	if (off > sizeof(struct ethhdr) + sizeof(struct ipv6hdr))
 		return -1;
 
+	off &= ~1;
 	tcp = data + off;
 	if (tcp + 1 > data_end)
 		return -1;
-- 
2.42.0


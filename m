Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197532;
	b=35kcZQ/YTOioPItNjgobX7YxaRvBrxjwGXcsfox4MPPZkEHNuj2Y/5zTQCFbJcao6dxO
	 5LmfYnyM7akzYu+sDsyZFnnr0rnX7gGylrI2iELH+pHY9khKei+3UDBCgv+PnUjNqI/wx
	 SkQgAIbj2ZppYgvs2ouH9m/F3LFalh+Am2iLWdMz8Ro2lxnBugai7kEATtdKrY0jK1z2C
	 oWjEw8+0rF46h068LjJvn4eldwf7jgbxxD5GBlMTxAvjasqDDYzEIS0hmc1KuvD4VqpK0
	 zeGVyN7DCenodDmNbPGyJCz6hjrRGbWx4XXEtp+JZfKEECOL43WBCoxqMK0QJNxpOyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197532;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=mLjYcl7nqSfbqI9MLwtzTNFgLBO+qZayfevupvctII8=;
	b=dmvTYYXjcOgR46r3zI82y3z+cIutUBMfaTnPyaO7iv0LvBbfy/b/VShmlBCFVLJRYzBk
	 fwFPDoidQpdTRZCKQC8POUNDyLZtLT8j1ZoQwr5l/Rb6Iio0Ng8yv9qNu/nd7oyGH69h9
	 AD2FZmHQALrTr2+biDQTHHZrZxy0/KKBbo+mGi5C3IgGHhbT1gEPAiOIpm9AcaW+8ioej
	 c2N9hnqLsVsBYwVMNKjfljX6FawIP4j5DvlstnJe/3HRt9ZqHKHuJa2ykJB+eSwqNEAIk
	 hlkdqauZfRrO5ICQne9vVnhF1WHXFE1D/AbaDiT+DVqWWEBgaxZgTUfq3Lae9v1EI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5554B606A326;
	Mon,  9 Nov 2026 04:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5554B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cxf9MaSPFqn7MdAA--.20150S3;
	Mon, 09 Nov 2026 12:12:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxxMwXSPFqQRwzAA--.11813S4;
	Mon, 09 Nov 2026 12:12:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Fix unaligned access failure in fexit_bpf2bpf
Date: Mon,  9 Nov 2026 12:12:07 +0800
Message-ID: <20261109041207.15221-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261109041207.15221-1-yangtiezhu@loongson.cn>
References: <20261109041207.15221-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxxMwXSPFqQRwzAA--.11813S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1DZrW8Jw1rZw47ArW8uFX_yoW8tFykpa
	s7Z34jkryFg3WYq3WUAw47GFWrKFn2qay8Kr48tr9xZw4DJr18Xr13KF4UKasxW39Yvws3
	Zas7KFZ8ZrWDZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0E38UUUUUU==

When executing "./test_progs -t fexit_bpf2bpf", there are 5 subtest
failures on platforms where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
is not set, because these platforms lack hardware unaligned access
support:

  ; tcp->check++; @ test_pkt_access.c:98
  226: (69) r1 = *(u16 *)(r2 +16)
  misaligned packet access off 2+(0x0; 0x3f)+16 size 2
  ...
  libbpf: prog 'test_pkt_access': failed to load: -EACCES
  libbpf: failed to load object './test_pkt_access.bpf.o'

Instead of skipping these tests entirely, fix this at the source by
applying a bitmask 'off &= ~1' right after the initial range check.
This explicitly communicates the 2-byte alignment state to pass the
verifier and run the full fexit_bpf2bpf test matrix.

Before:
  $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
  Summary: 0/10 PASSED, 1 SKIPPED, 1/5 FAILED

After:
  $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
  Summary: 1/15 PASSED, 1 SKIPPED, 0/0 FAILED

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


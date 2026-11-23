Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409413;
	b=B+58/QEIoaQDgWnUefsBReoJnW5vf3sSxqKfbZlv7dKMEg0wjmozsEg+GhOd2FUMsRRg
	 Urmi/VrErhebobmiFYtFFi7RkjY6j8m6YVPmv/g0dC6L1DOrLyQEPlawSZkLJ9PwoWeka
	 rp/zBZpaYhcDyyfY1RlF+fi0tIFf/rLMyr/iitGXKdMzFUp53zYZVFGpskhz3Ne/yH/No
	 iA8a7JVVzwsUZY3f1w4yMA2xxhnO4XUY2GuoAruUmEUZrOHQoQzSbzEOTOKfhgzj97J8f
	 Azqdxe1R+SEcdqwXtmlVVBRIUoevhoS/WoEHYmGJ2momp/ekv1MfwdtcZKxIiAIh9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409413;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=r/+cSEXj3IwI++X6dcNtFJlJAe4ePfWeqb2U+jEzRlE=;
	b=MfbMvHSOfnpW0hwj3vuid4/sr71xub22gZyhRQuvbAVprYwYW1b774oUvT6E9lx9Dk4v
	 vx7ZsovFjWUyfUwngkNjFuUQsm65CKDZtaHyYYB9r5l8TkJdCsSImsAAFQTr/+rcu8zyf
	 eHEuZdauK+QX5cChq17Aw92dMMX4v2euw3GfCKW1vYJAOuoLjkQGi3QgXXvHDAeqnx/gm
	 pAkRbqSeuPf8VI9iUE2RgLK5ZqThR89HYm2izUefSptu0YO67x2+t7OacAXHSo9RucLVf
	 qv7GIY0X6mtapxhlnVR0kPc2+wTzHaAhKsIQH8p1WJ0u5lEvSaIF/Zt9ox4U6uJbEcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F1606AE38;
	Mon, 23 Nov 2026 04:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37F1606AE38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxhvADxgNr8R0iAA--.31560S3;
	Mon, 23 Nov 2026 12:50:11 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX88AxgNrIsw2AA--.43924S4;
	Mon, 23 Nov 2026 12:50:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Allow unaligned access in callx_rodata_misaligned_read
Date: Mon, 23 Nov 2026 12:50:07 +0800
Message-ID: <20261123045008.23691-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261123045008.23691-1-yangtiezhu@loongson.cn>
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxX88AxgNrIsw2AA--.43924S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWxCF47AF45Aw4rWFy3trc_yoW8Cr18pr
	Z7ZasI9ryFyr1fuF4xAay7GFyrWrWqvay5Cw4xtr1YkFsrJFn7Xry8KF1kKryFgr4kXw1S
	va4Iqry8uw1kZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8QB_UUUUUU==

On architectures that may lack CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
(such as RISC-V and LoongArch), the verifier rejects unaligned 8-byte
loads at offset +4 in callx_rodata_misaligned_read with a "misaligned
value access" error before reaching the intended function pointer
overlap check.

As this test focuses on verifying function pointer overlap rejection
rather than alignment enforcement, add `__flag(BPF_F_ANY_ALIGNMENT)`
to the test case to bypass strict alignment checks on architectures
lacking efficient unaligned access.

Before:
  $ sudo ./test_progs -t verifier_callx_rodata/callx_rodata_misaligned_read
  ...
  5: (79) r0 = *(u64 *)(r6 +4)
  misaligned value access off 352+4 size 8
  ...
  Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

After:
  $ sudo ./test_progs -t verifier_callx_rodata/callx_rodata_misaligned_read
  ...
  Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED

Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 0389df720db2..8034e736d03a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -770,6 +770,7 @@ __naked void callx_rodata_partial_read(void)
 }
 
 SEC("socket")
+__flag(BPF_F_ANY_ALIGNMENT)
 __failure __msg("read of 8 bytes at offset")
 __msg("overlaps with a pointer to a function")
 __naked void callx_rodata_misaligned_read(void)
-- 
2.42.0


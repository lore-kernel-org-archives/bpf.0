Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE039A7EA;
	Wed, 24 Jun 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290392; cv=none; b=opeA2mUfI8AQuQZZtx5XcYyhpgM5+B5goqUlx/Z1qcDHxvCFyF1PRSkppee5zH3F6ELG5skmVb1FI6SGe7o74Wye0JWlt8N/QDfjhT4joWN58/as/9YSOa+7fTM1K6JGvNFzGghtQeoQAaeLa30mqp2LDLVSAoO+RASA5DAou3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290392; c=relaxed/simple;
	bh=TYpxeAJhJUy+qGp+Re96RXbhqMVA/7vgXZSu9t/CHNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Doro9Jeg389Cu7BnMzE0Mw5fjhmNVj2q3HkOGObh15o00Y0LF1sCTyM3LXVgPcCpkYugPxNw6bMS/AyZYa2x2BRuiyDUstFuM/XvYWDOpnnw7G09U549Xk7urAHn0UHTbcZYLlXXKUROLO5JhdWZIbhX0X3tt0aDnU5coKwE3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=dZn99NvZ; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="dZn99NvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=y8rgl9L8Uxe+0HgTrR8766zBevKJrMS
	YT4Xbc1Q9fgM=; b=dZn99NvZYoWZNgaBd1tswh398uQEDwMnH3bwf+eQb4Fh23z
	EUF7xbZJVqIFOZ7PMgckkTGPXJxVngQE+zPdKs2b7f6h2C0KdTOBI3HeUTr1vIBc
	87M1+0xDqIdVfs70CNjtYCok1Tg0HE5MsbNRNVJfjij+z/5sKdMHqqragR5s=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcJjFlztqpEWBAg--.48810S4;
	Wed, 24 Jun 2026 16:39:34 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Wed, 24 Jun 2026 16:39:34 +0800
Subject: [PATCH bpf 2/2] selftests/bpf: Cover fastcall helper stack reads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-f01-12-fastcall-helper-stack-read-v1-2-e0a86085ef77@mails.tsinghua.edu.cn>
References: <20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
In-Reply-To: <20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290375; l=1666;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=TYpxeAJhJUy+qGp+Re96RXbhqMVA/7vgXZSu9t/CHNA=;
 b=5dgFoeo6Yk0+s8lfQwN5MM0qrpRJo5u8uH8QAQKmEl1ygCZVeyL9TRD/JhjRbH6Hqs0xhCDuw
 PJGSfSfENTdCLliGr3lRHGBLqEdwhg1swW93f0YpFtk/KCiKBZ3BMtN
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcJjFlztqpEWBAg--.48810S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5GFW7XrWxGrWDWFWxZwb_yoW8Ww13pF
	929F9Ikry8AFnruwsxCayDAFW5Xr4vvay5Ar4ftry5ur4rXr1UJr1kKFsrJrZ5G3WI9wn5
	AFyava4Dur1UAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjcIDcUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEIA2o7idQ5jAAIs6

Add verifier_bpf_fastcall test where a spill/fill pair initializes a stack
slot. bpf_csum_diff() later reads it through ARG_PTR_TO_MEM | MEM_RDONLY.

The translated program must keep the spill and fill materialized. Otherwise
the helper reads stack bytes that no longer match the verifier model.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index fb4fa465d67c6..aab92e69673d2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -500,6 +500,38 @@ __naked void bad_helper_write(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("...")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_helper_read(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	/* bpf_fastcall pattern with stack offset -8 */
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	/* bpf_csum_diff() reads fp[-8], so keep the spill materialized */
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"r5 = 0;"
+	"call %[bpf_csum_diff];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_csum_diff)
+	: __clobber_all);
+}
+
 SEC("raw_tp")
 __arch_x86_64
 /* main, not patched */

-- 
2.34.1


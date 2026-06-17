Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA39376497;
	Wed, 17 Jun 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718649; cv=none; b=NI2bSpNXp0ErlokQsU7byow9zHO8rJTYe7Z0z8EfeZZj1/7+9StduWp1+at3hnVctT+qOaFOLnwY0ToO8zDaYBQ4yBaKrWu/z/jzEKs1mtJ4uLjbiUBpcTlPYDkMrxZCeXSpdMWJS5ilSIAlpXBdwfR7BACx4eMA25sVBYV4b0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718649; c=relaxed/simple;
	bh=Ft+QwchdqOIpmsUxZ8HcwZPUuDBPrCD8WYYuBMFr3To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7OOjT/E1R/apPseUGajpKX/mhN9RxguQtzPGdWix0Lfovly+AgVn8kBHQFN9TZ4mXx3vpoi4v8ZJMe0s1pFwYUUQ92oBxS4dJseK9kXio6s6+SXyFH0yKveNCX+x5MY1j61li2dhGkt9tuKNM+tifEEjgCQSQ9aVahYBC+R+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=I7ojLdJl; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="I7ojLdJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=wFAEN8lPUjghylnam62xB/cWBafMQoY
	ww54ICbqvOig=; b=I7ojLdJl+Jb0HoC+jPgQ2OWSX3xXu4fzjL02hNwzQVp9Qdz
	djG8RSZXIM8wsAdxoW5HJeSsMvkeSw8u6EkaxOLe0TQBrNhB5ANi3LollwhfiSZj
	GnDgiZ8ZBrHCTKNJn4jDczCWngmsOENxF7y0OKoKgnuqDeeqAZ/4K0B+bKRY=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQAH5Jtk3jJq2CFbAg--.21290S3;
	Thu, 18 Jun 2026 01:50:29 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Thu, 18 Jun 2026 01:50:26 +0800
Subject: [PATCH bpf v3 1/2] bpf: Fix stack slot index in nospec checks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-f01-11-stack-nospec-slot-index-v3-1-780297041721@mails.tsinghua.edu.cn>
References: <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
In-Reply-To: <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781718629; l=1631;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=Ft+QwchdqOIpmsUxZ8HcwZPUuDBPrCD8WYYuBMFr3To=;
 b=4mTqHrO+Clk6woxtrNDgxTsP/IxeRaw5TDqhSVeeX4buDc9hfTXoUNhYzvRB2Pjz0/LWEYIO5
 eHADRaK8BpbA/WOSOqb5t1Z8iG/0G0DF3OdR6gaOXHouA5/l/pqqkXk
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQAH5Jtk3jJq2CFbAg--.21290S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF45tF1xAFykCw4kAw4rGrg_yoW8WF1xpr
	ykWF12gF4xKasruFnFvF4v9r95GF4DG3y7GFWjv34FvFn5J34kWasagry5J3WFyFyrX3WS
	qF1Yy39ayw1Uu3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY
	02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU4na9DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQABA2oytN5J7wAAsX

check_stack_write_fixed_off() computes the byte slot for a fixed-offset
stack write as -off - 1, and records each written byte in slot_type[] with
(slot - i) % BPF_REG_SIZE.

The Spectre v4 sanitization pre-check uses slot_type[i] instead. For a
4-byte write at fp-8 after the lower half of fp-8 has been zeroed, the
pre-check scans bytes 0..3 and sees STACK_ZERO while the actual write updates
bytes 7..4. That can leave the second half-slot write without nospec_result
even though the bytes being overwritten still require sanitization.

Use the same slot index in the sanitization pre-check that the write path uses
when updating slot_type[].

Fixes: 2039f26f3aca ("bpf: Fix leakage due to insufficient speculative store bypass mitigation")
Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281c..50e80dbbc1784 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3479,7 +3479,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		bool sanitize = reg && is_spillable_regtype(reg->type);
 
 		for (i = 0; i < size; i++) {
-			u8 type = state->stack[spi].slot_type[i];
+			u8 type = state->stack[spi].slot_type[(slot - i) %
+							      BPF_REG_SIZE];
 
 			if (type != STACK_MISC && type != STACK_ZERO) {
 				sanitize = true;

-- 
2.34.1


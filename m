Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE1389E1A;
	Wed, 24 Jun 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290386; cv=none; b=GA3hLLmHQl7F7rQAjfbKZdEbag+YLIaXD3d0sMiu9OLJ88i4SyLa80e5fqFM5/j2kLykGmIR2Q63J+cLC1/css+cySH0uRJhAp0rgJ4waqALYWvvcylE3C0CziVzXi1cB5JxUfv6TXm8d75mfodbpfjty5HFBH7j23lFrrUd/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290386; c=relaxed/simple;
	bh=mMPadTpfViVxiqjJjC9KZKyMiSaBZktmUqUDWcl9xy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3wCyt+J38Zht2zE4z7tQb6zxLeKKGZ+5Ydrg5C2I07aeqtcbYpFpkc/2i0flff+Rjytkl7FVy+19HW0l83NjKLW5R4Zx+SJmYoIvXifCK8TtSAb6wMwFqCnjQNQqbu6exvD3Xw4X0oE8b9Y8I0RH/IFWGiseO7UOOvTtyfUWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CfLrgoNj; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="CfLrgoNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=PYpL6vwEBNdaYyq/TESmvHxh/8chgl8
	3fT5RJbbrcfo=; b=CfLrgoNjK92Zxyfxy2lxEHJHoXyUL3c5deqsFeGLj7r6dBM
	1axUao0rC4f3SU75MggBkg/AeYN/ASfMnm5j9YnGPG8aAJrxs2gsZRSrZy1a3fCl
	hpqYNAhDDyx3ywVazdbIuUTn2fy4mB50DCFxjVvlmOVJAz4mbKVlMMxw86h4=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcJjFlztqpEWBAg--.48810S3;
	Wed, 24 Jun 2026 16:39:34 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Wed, 24 Jun 2026 16:39:33 +0800
Subject: [PATCH bpf 1/2] bpf: Keep fastcall spills for helper stack reads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-f01-12-fastcall-helper-stack-read-v1-1-e0a86085ef77@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290375; l=1604;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=mMPadTpfViVxiqjJjC9KZKyMiSaBZktmUqUDWcl9xy8=;
 b=vlZLku9e267Z3/EBGm5kGjfLsZE86iAs6E6kw+ROl2XbV0YOL6J33MrHWDWyyK+hWckCSvyfE
 oic/b18UNicClJxbgVGe1iNOppi67qFEwBsNqyZ665/ZXY4p06VDq/X
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcJjFlztqpEWBAg--.48810S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kAFWrArWUXw1DZFyxZrb_yoW8WF1Upr
	97uFy2gr4kKa4vka12yr4xZa45Wrs5A3yxGryYyayYvrnxW34jgrWYgF4jyFyYyFZYvw1I
	yF40vwsIyayUuaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjcIDcUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgAIA2o7ifQ+0gAAsJ

The fastcall spill/fill rewrite is only sound while the stack slots used by
the pattern are not accessed outside the pattern. Direct stack loads and
stores already call check_fastcall_stack_contract() to enforce this.

Helper and kfunc memory-argument checks can validate PTR_TO_STACK reads
through check_stack_range_initialized() without applying the same contract.
When such a read overlaps a fastcall spill slot,
bpf_remove_fastcall_spills_fills() can still remove the spill/fill pair.
It can then shrink the subprogram stack depth even though a helper or kfunc
reads that stack address.

Apply check_fastcall_stack_contract() from check_stack_range_initialized()
after the concrete stack range is known. Zero-sized accesses do not read or
write memory, so leave the fastcall optimization unchanged for those.

Fixes: 5b5f51bff1b66 ("bpf: no_caller_saved_registers attribute for helper calls")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff9b1f68ceca4..d77332eeab359 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6873,6 +6873,10 @@ static int check_stack_range_initialized(
 		max_off = reg->smax_value + off;
 	}
 
+	if (access_size)
+		check_fastcall_stack_contract(env, state, env->insn_idx,
+					      min_off);
+
 	if (meta && meta->raw_mode) {
 		/* Ensure we won't be overwriting dynptrs when simulating byte
 		 * by byte access in check_helper_call using meta.access_size.

-- 
2.34.1


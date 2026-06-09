Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66A2DA765;
	Tue,  9 Jun 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016960; cv=none; b=bpSQJ80uhI2TxUwBjOS58BzArMHyDlS4XR5UgRbHhuga0qmYjU6AJMgPnGKW/9uDFL2A9EByXfRDlDGQ7liuf4NP6IREJm4v4ws/i9jyJxs8ari12N+OL9svygBAaubiXNXviUtyqc1VhBTzRKqXGkrV7XylkwOsLzQZQFgs3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016960; c=relaxed/simple;
	bh=ZuWGA/kMKspTQF5vqcm//og2gLLY9DL+cdoQNe9mZcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axHRdFiUJCvUyYdr321XU543nIe4dT9sKQssnJFqtTOf0JtSVKuvGskSEb/i/SbLBxhjfoDNUBrf9qdSJAATib5DjRhPRS/DwBjfRtDm9wIxTLvQkdU16FksvbOUVpZrTR+0ZNkABR0vmNN6CJZQ3gSPTYtMTuo35sMopUlGrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=k+SzwQjO; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="k+SzwQjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=W0NHYNVYKqNo//xZEgW10TZ+pwXXZsT
	D6dAve04rqxQ=; b=k+SzwQjOPdJf3Du2GMcwRr37N78nzjL56Eu5LISiqcIqL6k
	EWIBV6CVvUyUCCqlglqlKUT0g2//jHE1qQSacKzbIN9aHBTnOv3yYrxBomH1ae36
	p7BJ8EgT/0ExtthvYDDgW4KEjRiZlDjnCoe3zYR0nKT2bfIdTyz19Eo+/4Co=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQBXEMBqKShqQodBAg--.40025S4;
	Tue, 09 Jun 2026 22:55:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 09 Jun 2026 22:55:19 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover scalar addition from
 rdonly untrusted memory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-f01-03-scalar-add-bpf-next-v1-2-e6212e274155@mails.tsinghua.edu.cn>
References: <20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
In-Reply-To: <20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781016941; l=1229;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=ZuWGA/kMKspTQF5vqcm//og2gLLY9DL+cdoQNe9mZcQ=;
 b=QeHLXJkR72On696CLgYdyyhTh/Ckou3j9cCA7h3vMPGiLkJQElO7za+JPrr5ATxguTxCY7EFb
 B9MhryKX7y8CgAaQ1keFkF96tCiZmvV5Gunmu9JXOQZk/kKh6BZBsFM
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQBXEMBqKShqQodBAg--.40025S4
X-Coremail-Antispam: 1UD129KBjvJXoWruFy7Ar1rJFWUZF47KrWfZrb_yoW8JF1Upw
	4kGryagrn3JrnrJas3Cay7XF4rKF1kXFyYka1Iy34UGFW8Jryxtr18Ka1UXrZ8C3yrZrZY
	vFW7K3s093yxJaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUIKZXDUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgINA2onzACdTQAFsa

Add a verifier test for scalar += rdonly_untrusted_mem. The program gets a
read-only untrusted memory value from bpf_rdonly_cast(..., 0). It then adds
that value to a scalar destination. The verifier should reject this instead
of preserving stale scalar state.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/mem_rdonly_untrusted.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 5b4453747c23..303b8ed3e70b 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -77,6 +77,23 @@ int offset_not_tracked(void *ctx)
 	return s;
 }
 
+SEC("socket")
+__failure
+__msg("R1 tried to add from rdonly_untrusted_mem to scalar")
+__naked void scalar_add_not_ok(void)
+{
+	asm volatile ("r1 = 0;"
+	"r2 = 0;"
+	"call %[bpf_rdonly_cast];"
+	"r1 = 0;"
+	"r1 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_rdonly_cast)
+	: __clobber_all);
+}
+
 SEC("socket")
 __failure
 __msg("cannot write into rdonly_untrusted_mem")

-- 
2.34.1


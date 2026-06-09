Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0542B74B;
	Tue,  9 Jun 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016960; cv=none; b=cO9ySSj/XnYEBLO+RHfU25ELlXgQ+PPaT+Ht1Fe5qiLcV3PXoBR+EQWfPBhrnu0hagoN5EnlTXtoBlgN0R87TEeVxPquL0i2//HdlJDuB88UfBlppyLIQemraT7Q14O/URECZyrj0vyy4oFJ4z3+bEd97hvbvGycpLvGBZOByAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016960; c=relaxed/simple;
	bh=f1GtDHYavZM/VY10dMvSenAtCn/h1MCCk2FK1el+UyE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Od7jzuly8WhC2rXPjIO4H8rpL56ItWfEhpeUerzIKZsqEZKhZ38JlmGTDLA+H0cryRNPnn82PqTMytak/PM31Te2htpvsmIAYdTxS2MCUAA7Pwe4bLP2AFJZXUieOq/aZPN7FS4m28ZCIX+a+zorv/8sD519LK0Zp3eIh1kbE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=S1Uk/7kR; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="S1Uk/7kR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=iw/2JnR+lvZnQGgGf3w+49HqVwjVY390Bjd+q6hztJM=; b=S1Uk/7
	kR0KoiGufK0zP5LDKqAJbwnWGE9YLPkLoDoSXK2FMVLeV5Em7nGfDbMUD755sz2G
	mdR4XJxBzDQfkH1Fi722HgsPNhhtPuLZDpAQBN1UgG8lF3ZFWIOyqY3OuA3mJQlI
	ghDQevVND+iWh17qkHmbYdf07cMktdq0zz0U4=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQBXEMBqKShqQodBAg--.40025S2;
	Tue, 09 Jun 2026 22:55:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Reject scalar addition from untrusted
 memory
Date: Tue, 09 Jun 2026 22:55:17 +0800
Message-Id: <20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFUpKGoC/zXM0QrCMAyF4VcZuTaQrTqmryK76NJEK1JHM2Uw9
 u52Di9/zuFbwCRHMbhUC2T5RIuvVKI+VMB3n26CMZSGhpqWWjqjUo3k0Ng/fUYfAg6jYpJ5QmL
 Wzp+O6lwHBRizaJx/+BX+L+j3xd7DQ3jabFjXLzt5x0SIAAAA
X-Change-ID: 20260609-f01-03-scalar-add-bpf-next-0ccf8a54f338
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781016941; l=1398;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=f1GtDHYavZM/VY10dMvSenAtCn/h1MCCk2FK1el+UyE=;
 b=mZjMM2OfUrFWQdRAcTLr7KPsT1zgYSqgfsLv4PgS6UFM8HVO6u9W8su5TanY5pOvKD+vHHsjp
 MT8ReL2Ht8XBMQ9CN6u2wnJA9dCzUDCjAEAKafLeXS6h6s0RxUsu+gt
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQBXEMBqKShqQodBAg--.40025S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF48Zr1UuryxKF1fJryrWFg_yoW8GrWUpr
	y8JFyavw1ktFsrGa43ZF4jvF1F9F1rG3yYgF1xA34UCasxJFy8tF47KayUArZ8C3WkZayY
	gFyUZwn09a17AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUIKZXDUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgINA2onzACdTQABse

scalar += rdonly_untrusted_mem reaches adjust_ptr_min_max_vals() with the
pointer as the source register. The untrusted PTR_TO_MEM case returns there
without updating the scalar destination, leaving stale verifier state.

Reject that addition before the early return. Pointer += scalar remains
handled by the existing untrusted-memory rule.

Patch 1 adds the verifier rejection. Patch 2 adds a verifier regression
test for scalar += bpf_rdonly_cast(..., 0).

Validation:

  unpatched bpf-next 8496d9020ff3:
    BPF_PROG_LOAD -> fd=4 errno=0
    RESULT: verifier ACCEPTED (unexpected_accept)

  patched bpf-next 8496d9020ff3 + this series:
    BPF_PROG_LOAD -> fd=-1 errno=13 (Permission denied)
    R1 tried to add from rdonly_untrusted_mem to scalar
    RESULT: verifier REJECTED as expected

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Reject scalar addition from untrusted memory
      selftests/bpf: Cover scalar addition from rdonly untrusted memory

 kernel/bpf/verifier.c                                   |  8 ++++++++
 .../testing/selftests/bpf/progs/mem_rdonly_untrusted.c  | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)
---
base-commit: 8496d9020ff37a33c2a7b2fc84350fd03ffbde78
change-id: 20260609-f01-03-scalar-add-bpf-next-0ccf8a54f338

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>


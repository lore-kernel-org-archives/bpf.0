Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196753;
	b=gKdi9JcmLk48CzG72HOLnFp9z91MXW7zlO55zGwML97MrTjx+Kdcd438OIr//K1maaET
	 KGtVlVg9lB47uxluRfGCyAEm3ZidK4LsIDwXTo0r6dMXU2zyc+y9HJ7MSRdQ/F4fmzdqg
	 4V8TffKN3Rda1oYupjAdf13DXr0hbjX+3n9nEstCuQ2RYCkRQJuKyEs88RUoJfxMeom5f
	 0vu77foByirIzMGrhtyyRqyI2uiYhTA1Ze1w+/mL3cCpkKrB/t68awptr53StwUtdX8vY
	 VchwthLXIN5v3NV8FC/wgvdYHpjpGuwXyj5UJ1vjgUpjnuP8rw3Ax9dbrRynLPSCMpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196753;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=ME3PhzKv+3KgT6aXu12teusJRCWDcoOwJXl3TiAU6IU=;
	b=JbWolcrNPO1jVpd4QNtu9ZwPOlVTEOwDt4C/64srj9gd8olyyoIQaDENcI4YYbvmicbX
	 uYM0cqQtH4jz60uIG2nzRCxrB+228ndODgCiStLC+c1tz6dns+5Rv4/N22ZQi2bmbvLR7
	 kQNx4mMdStXbxmQpI36mTbTd+CLJHcJwC96yjNAzRbYtETxXhPnSXmAbZzavcKwmP25c8
	 xSsV7MrhpsDwplhQy9894DaNbAMbo3WJMrwBorqIwHf2XjA3rQC1PwNSnmOk4R7XukFFX
	 D6w7rw4t61n//w6drGH5LWtHBtp8RhGVuLPDY/ON62B4rAl0jaZb6MYfMhaPMCZq7ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C929606A31C;
	Mon,  9 Nov 2026 03:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C929606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxC9INRfFqtLIdAA--.20237S3;
	Mon, 09 Nov 2026 11:59:09 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxtMwKRfFqyxszAA--.12328S2;
	Mon, 09 Nov 2026 11:59:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/slub: Genericize x86-specific cmpxchg16b comment
Date: Mon,  9 Nov 2026 11:59:06 +0800
Message-ID: <20261109035906.10857-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
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
X-CM-TRANSID:qMiowJCxtMwKRfFqyxszAA--.12328S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF45uw4UCF4xKw4DKF1Dtwc_yoW8tF1rpF
	4xurW7Xw4Dur4S9a47Aw47uw43Jay8KFW7Ca1rK343Zwn8Krn8KFyIkrWrXFZ5JrWI9a1U
	Kan7trW5ZF4UAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

The kmalloc_nolock() infrastructure relies on slab caches with double-word
atomic cmpxchg capabilities (__CMPXCHG_DOUBLE). The current inline comment
in __kmalloc_nolock_noprof() uses 'cmpxchg16b' as the prerequisite hardware
capability.

However, "cmpxchg16b" is an x86-specific instruction mnemonic (CX16). On
the modern architectures supported by the Linux kernel, this double-width
atomic primitive is satisfied by different hardware implementations:
(1) arm64: satisfies it via LSE atomics ('casp' instruction)
(2) s390: satisfies it via native 'cdsg' instruction
(3) riscv: satisfies it via ZACAS extension ('amocas.q' instruction)
(4) loongarch: satisfies it via SCQ extension (using an 'll.d'/'sc.q' loop)

Update the comment to "double-width atomic cmpxchg", which provides the
following advantages:
(1) Accurately describes the cross-platform hardware invariant.
(2) Covers both 32-bit and 64-bit platforms.
(3) Aligns well with the __CMPXCHG_DOUBLE flag.
(4) Avoids misleading developers of non-x86 architectures.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v2:
  - Update "128-bit atomic cmpxchg" to "double-width atomic cmpxchg" to
    properly cover both 32-bit and 64-bit platforms, suggested by Harry.
  - Refine the commit message to format the architecture implementations
    and advantages into structured lists for better readability.

 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 45e077c7526c..090302f1daeb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5589,8 +5589,8 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
 	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
 		/*
 		 * kmalloc_nolock() is not supported on architectures that
-		 * don't implement cmpxchg16b and thus need slab_lock()
-		 * which could be preempted by a nmi.
+		 * don't implement double-width atomic cmpxchg and thus need
+		 * slab_lock() which could be preempted by a nmi.
 		 * But debug caches don't use that and only rely on
 		 * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
 		 * to allocate from debug caches by
-- 
2.42.0


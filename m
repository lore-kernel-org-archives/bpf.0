Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608056;
	b=xRj43mY9w6nhDeBv3zwx8A4V9pf4eCO5K8YvkHdboH6E+QpnsiW2SdYpTBrN9IwNnuxJ
	 St2NEG3Asm+Aet19XVxS0kikaAUFOqSlrXv+s4ztNcsxyEMFE7i+kEbaLNBH8F6CYZb9I
	 8hye1fEOxTpgPNRX6VKRrimRg8mhKIV4yRm19+SaPBQUEQLF9QQnlgBSZE2XtqcPWY6Zb
	 VJyQk2KCWHw8C1pFw/LNH8RAg5Dz/xQJF+Ld6zKUsfEn77l3EbqALY6d6PxKpV3aKgH0C
	 uiES63UxjXyXbDYNV3CHLdnWmXqhC4B1Qswo+GpOGi2FDiD79W6O1gDWt2sgfUYVgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608056;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=8rzT69sai/1JVMZrPPxqbIhnSUltQ4xUL98H0qfUrjY=;
	b=cqG3WS5jJFeU2DdJYroH0SjRYfoy3XsCDNAzIS3l4vVX9eMHMbDpXctIcsRaLPXgyYdE
	 JnIQ68y+eIvZ9k0VrjD7Hd5i21T2gRGcUcZ5+UiweBTt58fwtdV5UZ43ytpQbehIKAt7m
	 O9hk8EGBjieMazRY/mBsi5XP6LVeINvfrKiBngYRgNI/Lwx+gy47HuaOCcM688mDNdkHV
	 ZhKQzwtnQnCj1fS7pD5b03oEpEUeTJsd4U3d64x85BwL57uOlQDhB176mGdoOzVaP9E2G
	 fLZKn4vd9YNG8hnNRUHtq24ocQA/eJnIhbQLuv8w0eJ1zT1MOuTjyTqkGHh4I413erg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85578606A327;
	Mon,  2 Nov 2026 08:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85578606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxC9J0Sehqk3kbAA--.13995S3;
	Mon, 02 Nov 2026 16:27:32 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBx5cxzSehqyc0xAA--.10726S2;
	Mon, 02 Nov 2026 16:27:31 +0800 (CST)
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
Subject: [PATCH v1] mm/slub: Genericize x86-specific cmpxchg16b comment
Date: Mon,  2 Nov 2026 16:27:30 +0800
Message-ID: <20261102082730.12430-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBx5cxzSehqyc0xAA--.10726S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF45uw4UCF4xKw4DKF1Dtwc_yoW8Aw48pa
	17A3yjqan8ur1I9a47Cw47u343Jay8KFW2k3yfCw13Zwn8Kw1fKF1xt3yFqF4rXrWfua1j
	qF1ktFWjvF4UAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==

The kmalloc_nolock() infrastructure relies on slab caches with double-word
atomic cmpxchg capabilities (__CMPXCHG_DOUBLE). The current inline comment
in __kmalloc_nolock_noprof() uses 'cmpxchg16b' as the prerequisite hardware
capability.

However, "cmpxchg16b" is an x86-specific instruction mnemonic (CX16). On
modern architectures supported by the Linux kernel, this 128-bit atomic
primitive is satisfied by different hardware implementations:
  - arm64: satisfies it via LSE atomics ('casp' instruction)
  - s390: satisfies it via native 'cdsg' instruction
  - riscv: satisfies it via ZACAS extension ('amocas.q' instruction)
  - loongarch: satisfies it via SCQ extension (using an 'll.d'/'sc.q' loop)

Update the comment to refer to "128-bit atomic cmpxchg" to accurately
describe the cross-platform hardware invariant needed by the lockless
allocator, and to avoid misleading developers of non-x86 archs.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 45e077c7526c..216bc6b5d776 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5589,8 +5589,8 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
 	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
 		/*
 		 * kmalloc_nolock() is not supported on architectures that
-		 * don't implement cmpxchg16b and thus need slab_lock()
-		 * which could be preempted by a nmi.
+		 * don't implement 128-bit atomic cmpxchg and thus need
+		 * slab_lock() which could be preempted by a nmi.
 		 * But debug caches don't use that and only rely on
 		 * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
 		 * to allocate from debug caches by
-- 
2.42.0


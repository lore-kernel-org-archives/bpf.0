Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359477;
	b=fr4+ZikM6i8LZwuYxA2S622WUhhSvfMPuBSmQELbj2dbOHYfbW0I7amjHxzUBzFzxq9w
	 roI8hM90buslO30Y9AshhGrzKgnWGzCTQj5Aj4WZkwKeucI6/3axKReiOwWej/uUqzcas
	 Y5sqsO9Rhd0zFUviu6u2jOxa0EcTIAGxZ47WiH45KD/sJVcJFMfPQtjXNZZFxWcWHiNUy
	 EkEuMHs7VsqwygfCZowuwjSUN/SgA9IM3msIbTBPMk3PeKzqaCe6fmRuSteOXczBmwDfH
	 rHlouw80cV0mfCASKKlsATC+YjwYcSo7WuEThxqgkNVw7HEjw70dhEfH87mwLzyN8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359477;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=zKSEdF9+1/4Is5GWGmFxtOqEqpvl78JV1G/SHbLFOjA=;
	b=L3pZcKKNonp5UpKBhokLRt1xUDUnJrvYguZImIrNBPCdI2Xix5TmQRg2A3C/D4ZTpAOo
	 siX98WOVQ6YPIOqvHWfDnSUBSsv/z9XQ33l7todj1cPDItmGGJIAWtWmrOhcaj8+mDPqq
	 q/LV6DGF3prArk/h8omK7yIucmftkxFxUL6RkSoMkR9FaWRCQqNBy6TNmfiZp9XzMNHZc
	 uvrLVK0A+EPkUG0CeBJybfNMcYg3vrQ02IId0Wzc8xKlM/It7Wc5n/gv3X/aKjf5mvbqq
	 QcGhuYUI5AjnWW3BzaXytGWpvv8Mn+LGfgiYVmKBylWWLqdQgWF43opEdw/5r4XbKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF2606A320;
	Wed, 11 Nov 2026 01:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFF2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxjdKwwPNqQmMeAA--.21968S3;
	Wed, 11 Nov 2026 09:11:12 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxxMyswPNqH5wzAA--.12474S2;
	Wed, 11 Nov 2026 09:11:10 +0800 (CST)
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
Subject: [PATCH v3] mm/slub: Genericize x86-specific cmpxchg16b comment
Date: Wed, 11 Nov 2026 09:11:08 +0800
Message-ID: <20261111011108.29311-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxxMyswPNqH5wzAA--.12474S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF1rZry8AryDKFy8Kw4UGFX_yoWkWFbE9F
	4fXr45Gr15JFZI9r12yF15uF1Y9r1kuanFgFW2vFy7JwnYqFy8XrWDZFW5CrWrWFsakrs3
	CwsrWr9xGr17WosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=

In __kmalloc_nolock_noprof(), update the comment from x86-specific
"cmpxchg16b" to generic "double-width atomic cmpxchg".

Suggested-by: Harry Yoo <harry@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v3:
  - add missing Suggested-by tag for Harry
  - use shorter commit message as requested

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


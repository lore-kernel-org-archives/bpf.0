Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787492;
	b=3GYp/F6NlQgAguiV1nqTlG5NjiwHWMkRSs0isFpqPJKA5AvPUVna4/2c039MQnK4urGB
	 La9+2L+ft2OpmHrlcAJOrOiYrjDPJGIJrAWX5O4Ag78aoo91TB3Z+Qktx6M8XFAMtbKCw
	 +C4lo0MYQnX0fc/BAG6G7bKTMy+31VnPYu2LSn7tBApjvZq1v5AYntGCqQPC95+ChViIy
	 +WO3bU+P+x8yqoKGoQEmOpJnce+hP1iDUMLEY1nh+ei2L0akyWIBuZyAcjJZB/f7n+j55
	 S6E5q9zi0IKszfdpxwLqqqiwFRz0Go8vFzrgA3XnZdASkjjja909oWvebU4gs7LEbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787492;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kzlN/YSlDBcWBl/PHuR26tChnN3ik0juVI5FwAqXzXw=;
	b=OjBp6avo2hkgB5M2YRb6ulcoHchE+Brc1t7fI8BG95AzekZHg2Qhgu+alOmwXh+C4qrb
	 /Z2yVAxZ7bY9vh2KqapRAQOUQgcF/zYqp6Q4ZKvtBfg9UTlVJcAKWpOgCLXn9fsUMepaj
	 NpSEY94ig9QW9NKWLzVvTDXJj2QiUVtQGWNyeoe/vhkyyWr7lX78Dl/+xu8BH3Vv9pxiL
	 CnYamNTr4IBv9g1RFhjByvG00EpL+cK9KD/zO5eaTVRIyehHeJZiQKMwNFdnYgSv4Y044
	 5uRzNHRnKBp0PKtgyBtcyggcN+AQKW9oc7XwVN76RCtiDbaaNdCpa1QF5xK5J9m0RoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="s/Dw6yqL";
	arc=none smtp.remote-ip=95.215.58.39
Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C842606A332
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 10:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C842606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s/Dw6yqL
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QICrwvJ1q+p6O5FfC7tO/QRvFz9LYnqsPT4idoPDTMg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793787486; v=1; x=1794392286;
 b=s/Dw6yqLjHgjK4hC+q3he0UIo9WlnSbuhHZictdeYHfn0g5eLA+/jLTEsDkKqQY+gbMBbTFv
 E0JxTJeYiHFf5PxfyrFlG4LPlvNpuBlWmQasw907mX2iCbXTKmT3DQAlg/i7orQfFNco2MRDl5F
 /JMtvzwzP+ultA/y2OOC4zBo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7af79601e9f84b4;
	Wed, 04 Nov 2026 10:18:06 +0000
X-Mizu-Trace-ID: b7af79601e9f84b4
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: yangtiezhu@loongson.cn
Cc: chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ extension
Date: Wed,  4 Nov 2026 19:17:53 +0900
Message-ID: <20261104101753.20704-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102072808.23080-2-yangtiezhu@loongson.cn>
References: <20261102072808.23080-2-yangtiezhu@loongson.cn>
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

Hi Tiezhu,

On 2026/11/2 15:28, Tiezhu Yang wrote:
> This is because the arena range tree uses kmalloc_nolock(), which requires
> 128-bit atomic cmpxchg support, provided by SCQ extension on LoongArch.

There is an existing SLUB debug fallback worth checking before making
arena support depend on SCQ.

In __kmalloc_nolock_noprof(), the rejection condition is:

        if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
                return NULL;

Debug caches do not require cmpxchg128 for this path. They use
kmem_cache_node->list_lock with spin_trylock_irqsave() instead.
With CONFIG_SLUB_DEBUG=y, booting with slab_debug enables this path;
CONFIG_SLUB_DEBUG_ON=y enables debugging by default as well.

The proposed bpf_jit_supports_arena() check would reject arena maps on
CPUs without SCQ, even when the SLUB debug fallback is available.
This would prevent us from running arena tests on those machines
with slab_debug enabled.

Could you rerun jit_insns/cast_to_user on the 3A5000 with slab_debug
enabled, before and after this patch? The claim that kmalloc_nolock()
requires 128-bit cmpxchg should account for debug caches, and it would
be useful to preserve that fallback when addressing the error reporting.

Thanks,
George

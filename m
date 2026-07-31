Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E414E2F2
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528185; cv=none; b=cW1f8AUQlY+syQf+oQcfN+i2M60KPrBtG2kzZv63fvfja/vZTllpmaSiF9gqL5hbkSkXJugwDORX25zosXpI6dstNt1c5cLYNgaMs58DTe2IWIJa7gbUOvbAU9XnRk/MRTdp2tMS+605ZEGW1PfRQmPwX6AlSTL6OQaHE0lA/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528185; c=relaxed/simple;
	bh=CJE8GVvkniAQqCaYsAR2gmJYmQ8gaUT7KofGyLTuXh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2mHbL2VXV43neHaec6Bb66KbnloVGJtKmlJArvfJKzQKH09BEzgNEL5Gc6VK6c+ikC/1KcB/f+Lr1/xmeX610KhTz8+hPTXnzBDyTmBf9Uw5xH0jxcVeko420EPQJrQC24mMn+3QNZ/5234tcT7JjcuXbbSaZyAHQe79wMZLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYOOdbQY; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYOOdbQY"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so7637185ad.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528181; x=1786132981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4O9q9bJyh69H6ktbFtFylGU/5hkkYd5RvJo0zQWtYpM=;
        b=MYOOdbQYkmHfDjb86sAl03Q1PFN9QMgoK4mFLpQhcKgLz9xNsp5cYBrWmNjocBWZFu
         GamQuaULQ3W9J2GNviac2s4g4iF2iWd4h1Um6HBjnBr342paVcJ83Zyw6gO7iQdBV9wS
         EJ9iWwxNHSbp8qsy3gBRIihTh1aoEn9mzDImjfo4KvElc4Hg/HDesWyFeTOC7fsEzL0n
         vyDHMIIuBaupb9beZ/sZG5c4c+M11PK9dFYEsIkfhZwdBN6QNlmhkPr9eY7gSI+4nH2h
         C6GFGTQRXcBUzMa5Zm3WYa5QXHJM/MNWtJoHcFPIfT0Bu2eT0QWDymZrh5YYRlRp8qNI
         vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528181; x=1786132981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4O9q9bJyh69H6ktbFtFylGU/5hkkYd5RvJo0zQWtYpM=;
        b=RcytKVejUWiuXj1HjvtQtXK/ndMCJEdwiP+Wr8MiEfrAtWtOrEtg1KuOGeQiEe25yx
         wSCHPXlCD2YNuUaJcesejDao1Nj5/wmkONvGBK8Db+nxncR40zgeqSm/i2hs+sSwaItV
         7y6FsL1KRGPEn4MMtcPyP6zZ30NuSE3k9mGHmFcqLnGEY/FfcrTt5MbxqhxtyRoF4Z20
         nQMniqyRj4QGM4F6K50J8lfoI57WCaStDU7Twc6mypaKWKOgCWQX691KtFIqZjnr+Vbp
         WXUaoKs46xxWLxTVkJ74LUY2kRosGNK988JtFx/o6RPV2gLDmeYuSi0699Bco6/D2+9r
         21Sg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4UeES55PEFgwes2y5dWGqmAInHfSe8ryL6zeoGTC6Bawen2YEmoaeaWJ5QiG6jFlJTdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hmzMjDEQ675ItiWgwLcoZcCnG/fDpqUJQmdZBSRTCc2NqQYZ
	+7O1NaYbIx04DvhKKeGSDaYTI0aVzi1cT9ZbQaz0yKb4cMoY3MbLThhl
X-Gm-Gg: AR+sD11d18HJD9bvRvgh5ZIBn1J4txG8HxHtJxlxy8xGDFgffyn1s4K9FuSdr449iqH
	vzBvQ/6v2UwmelDvck80Gw05v2vYSCC067CCqKhgWuRRS/b3QEkgCEbVF8J+YwXlWHQ357ZRjOQ
	xUJ8TMOTh5a5HdFt4tBAQ4bUcL+pAcUa6dZ7VCKZMe3iPFneenGDYilQplDNHCQHp16tDmJzHWz
	81y/vd2tat/1SnkzjNJ+LT55EdRgzXxYVUK53lrjJPASs4KZ/dhmVPgWD3tTq8Mc2SdLJGXFBuP
	JPSgcGlChI9jPwm/wjIeb0MyY0pXkIh2vBxFOpeNsxB3r8q84aBmvOvJ/SzhfFo0J1NJ5zSz37L
	cCTcemCQyRmyIIb5l5WykoMvW5f3rlcP+D/lILozq9OUSaVqSEoUOfPbHQ6q76rK8oyOptXTvHG
	vj05YTMAUBoQeNq3XUY4BiyS0yLyDnWDKYHoQf5gC+kY2GBlN9xgyRHg==
X-Received: by 2002:a17:902:dac4:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d05221d386mr11733105ad.13.1785528181495;
        Fri, 31 Jul 2026 13:03:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b9asm10138675ad.1.2026.07.31.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:03:01 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:02:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] xsk: account ring allocations to memcg
Message-ID: <amz-5UfOV4OZuj3C@devvm7509.cco0.facebook.com>
References: <20260731164623.4694-1-zihanx@nebusec.ai>
 <20260731164623.4694-2-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731164623.4694-2-zihanx@nebusec.ai>

On 07/31, Zihan Xi wrote:
> AF_XDP rings are allocated from setsockopt() and can be mapped into user
> space.  The shared xskq_create() helper allocates the ring backing memory,
> but the user-controlled and long-lived allocation is not charged as kmem
> to the allocating memory cgroup.
> 
> The current implementation uses vmalloc_user(), which allocates the
> backing pages with GFP_KERNEL | __GFP_ZERO.  Use the same VM_USERMAP
> vmalloc path, but pass GFP_KERNEL_ACCOUNT so the ring backing pages are
> attributed to memcg/kmem and can be constrained by existing cgroup memory
> limits.  This keeps the existing zeroing and mmap semantics while avoiding
> AF_XDP-specific optmem or RLIMIT_MEMLOCK accounting.
> 
> Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v3:
>   - drop the v2 RLIMIT_MEMLOCK / user->locked_vm accounting approach
>     after review feedback
>   - switch the AF_XDP ring backing allocation to the memcg/kmem model by
>     using a VM_USERMAP vmalloc path with GFP_KERNEL_ACCOUNT
>   - include <asm/shmparam.h> explicitly for SHMLBA, matching the
>     vmalloc implementation's dependency
>   - retarget Fixes to 423f38329d26, the original mmapable queue
>     allocation that introduced the missing accounting root-cause fact
>   - v2 Link: https://lore.kernel.org/all/20260730153832.11238-1-zihanx@nebusec.ai/
> changes in v2:
>   - replace the socket optmem limit proposal with RLIMIT_MEMLOCK /
>     user->locked_vm accounting via mm_account_pinned_pages()
>   - drop the earlier socket/pool lifetime coupling changes and keep the
>     final code diff limited to xsk_queue.c and xsk_queue.h
>   - retarget Fixes to 423f38329d26, the original mmapable queue
>     allocation that introduced the missing resource boundary
>   - v1 Link: https://lore.kernel.org/all/cover.1785313094.git.zihanx@nebusec.ai/
>  net/xdp/xsk_queue.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

From Documentation/core-api/memory-allocation.rst:

  * Untrusted allocations triggered from userspace should be a subject
    of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
    is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
    allocations that should be accounted.

I don't like that we are calling (seemingly) low level
__vmalloc_node_range, but commit 041de93ff86f ("mm: remove
vmalloc_user_node_flags") removed the previous wrapper and open-coded
it in bpf verifier, so I'm assuming calling __vmalloc_node_range here
is ok as well.

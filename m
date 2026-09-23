Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE87472776
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203326; cv=none; b=UZFXpZ2qVTvDYCBKV4sZYGtFQNz0FWTbiI7cuu7QeG0EVf1csZ7MncLwmB6BLu2XipjaMVAG2DVnDVrivO73Tb0tXjUx3MsuGfJzxnl+K5B1UJcLpEKhVgDeOzAcQEyXqRS4Zr7JYK5Ds/93UFU6wYLdDW+SkCjubo3uDDFRqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203326; c=relaxed/simple;
	bh=kMX5ROv7UEeGEJkgwsgzJJV2hVtb+8jFVhSplML3BX4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ZfOHkQgpw9fJ9ZLzV4AZNXZJjwncp8IyRNSfy6ugQLlGbFvYGFnXcKm8gT/2cMGn4bL5WkK+gFy/Opzcf7VFJe30TjQ4s77mT9my4PRP3Va8sDofe75Bgvhtu9uCnUJtN2BzKRMf6NCQQboD15qo3talhH65OOZft9Mee6HHcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAH1samP; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAH1samP"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso1084294a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790203324; x=1790808124; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zclXiUnqBLskeouRhcDR8p1ePofxfGXSiP4XXp6A1jo=;
        b=sAH1samP1m7QGQZr4fSPHC8zKHj61nPJ4jQdznGDXVjv1f4hrsDo5jmzpQlIAXAMOL
         y9P/U9vZdVVNh2q8plwYhps2KvDYPXDAhNR4VrMvl23sWNMxgeyZjPf8vURQVnN7XRfB
         Bl6UR3f/EpfxcGbaq/dqQrI7I0X5tEhebShaM2do53C+1YEPcEePfiZQVSJqrRU/TpwV
         NXFzh8VdgLv9gPnV9fwG4muJFbInX2np40viK2nz2Cx0/KeaH7Fags5Ce09GZaU+hgYW
         bO9TnCOYbaG+4b2ZvJjvcQvJtFa6aip5L6613sP1Fi4qogCLVhXHOcXmkIf5f+7L3RxG
         xtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203324; x=1790808124;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zclXiUnqBLskeouRhcDR8p1ePofxfGXSiP4XXp6A1jo=;
        b=gIR4nU3W4gGv39X0vgHcUNbwhLqm14X1hie7Xmou0yP5WMInij4I2QaCBHKdD4CikP
         0Gbv/D7xrcnAQf3W7MgiFa8PcFUBqcPD7Lr2SqGDIgiowKmy++sx9UGfN/RgvIhlWlN2
         j8S9OIXF7yUyh82Dkvt8kfCVIPRAjXH/fuemWwIjHQV6AgyaWHR2dgFmXc97NPVmfjCQ
         jBEjLwlkk90LqmspV1vehjb/L2n67xUS7bD6i20C1uox7QZwOKH4LIsfLdi7WOu/PM0p
         LiWce+05kQkO43ApO+DijhZoQf9qNEvTA4T4s+6iPmW2KZvdfuzeaGRbvu4F76sqsAe4
         x8oQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/y0BDAjU+6F30WBws3vIgPG4U+LsKHg26ZK8N7dCaI08ANEXRKnYce5QR760ztaoOM6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lK5+8cvWFUMPLXFufVimXovbTrngit0LlhgiLOg7srt/h5i7Bv
	XAqWMtUDdUofc0qPhkMbbJXkz9yZtujkZ9FauqXqmauKmg7mNaZjTu6nvOpQrw==
X-Gm-Gg: AYBFou2fcukMiLKiYIG/LA+4x2AlYfD+uDUiSTaWjp3Bb5asDx4rdvulQQRjNuGzZ+O
	qr4uhVS9X5Lsrw9ytUnCvtHevZuE7fsJXDdbqLibBCCNXa8yKOXBEWgtLhouh5cjUg54iAPFKio
	jRezKZf/aDBJObH6pHkg0AGXsxEaDKZMSXPj2msL6XyUfDChEqrb8fhRQGebE+RWsRCZWuZX46y
	OasVQqnKAtNMerl0hDWTpO4HOArSH3mMdWy3qY6vzfoIhOMtpDBXm1dA5s8ebAp5mIdEiDieVnN
	1/AZr8T/w/5ahy7lOKYuHXzvyJYVfu9AjeeVu+lAkUUQZqOOed6j5GVVsuJHLfr8gWijRdy+Aqe
	/g4S5mTTE6WsWOTT01xPebX6OQFOBvfwlipyFgQjuvpTcUA+P6OtCs52N4g7w9zRInmTxbIbZra
	/lL0loXR/DSBj4yqJJE4LUOUtrN+nLKTRjIWKWl79UXOWdLg7oA43O05yhY6B+6vk1fjaP89hSf
	njhZ0ZXsKM0Cg7EEDgER+uO2L/x3qtNA8uFqOHnRrGz6Wh+tb7KcrrwfsGLjnuYscUwVzzo4Zky
	l6o/Qqo2eHZeIw==
X-Received: by 2002:a17:90b:3c41:b0:39e:6c68:c78c with SMTP id 98e67ed59e1d1-3a098e884b0mr453463a91.66.1790203323557;
        Wed, 23 Sep 2026 15:42:03 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5c4sm1092112a91.5.2026.09.23.15.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:42:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:42:02 +0000
Message-Id: <DLN2450HFL9V.1JUQ5FJMYCMM0@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Fix arena race between page free
 and alloc leading to incoherency
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260923191125.5311-4-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com> <20260923191125.5311-4-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 07:11 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Solve this ABA problem by preventing range reallocation until
> TLB invalidation/unmapping is complete. First, mark the range
> freed but unavailable. Afterwards, drop the spinlock and
> flush the kernel TLB and zap user page tables. Then pick up
> the lock again and mark the ranges as available once again,
> completing the free operation.

The range is allocated in the range tree before the free.
can we keep it allocated until flush_tlb_kernel_range() and
zap_pages() are done and call range_tree_set() only after that ?
bpf_arena_reserve_pages() creates the same 'allocated without pages'
state. arena_vm_fault() shouldn't populate such range, I think.
Then there is no need for the 3rd state in the range tree.

[...]
> +		unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
> +		if (IS_ERR(unavail_node)) {
> +			ret = PTR_ERR(unavail_node);
> +			/* Kick off another attempt at the end of this call. */
> +			if (ret == -EAGAIN) {
> +				llist_add(pos, &arena->free_spans);
> +				retry = true;
> +				continue;
> +			}
> +
> +			/*
> +			 * An -ENOMEM failure is the same failure mode as in
> +			 * the defer: path of arena_free_pages(). Do not treat
> +			 * the leak as a bug.
> +			 */
> +			if (ret != -ENOMEM)
> +				WARN_ON_ONCE(ret);
> +
> +			kfree_nolock(s);
> +			continue;
> +		}

This makes it worse.
Unavailable ranges don't merge, so range_tree_set_unavail() always
allocates a node. When kmalloc_nolock() fails the span is dropped
before the ptes are cleared and the pages stay mapped until map free.
Today the worker unmaps and frees the pages and range_tree_set()
failure costs only the address range.

pw-bot: cr

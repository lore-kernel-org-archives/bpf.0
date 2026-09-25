Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F144FDE67
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371556; cv=none; b=YMGaUjJDx0+6c4/GwjfKvh7sS5Mt/C3nvN8OTv184BwkZDbkuZ2GrTwubMypz7waOVgyK0a9/VKcsyUHctKJUq7wJpKVXOPTX3Egxwm/59M1haQlQC6joXaX574VBcPX8JJCnikHk7jZmN9jMFLNKd0hHAmJTIQW6uBZIf8ucVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371556; c=relaxed/simple;
	bh=R5sr4o7wmU+Eg3JIFHDUTZPH0S1FRsBZmkjgkK7CIlk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=VgBjKYk6wQ5JCe91lmOAE3vULxY9uyj3E078K9r0si+5yRu8BwgHkH+FGMIf/ItFjpbcQuZldyWDFPqZKCkLtibXsF0CycY7+drhT1Z/BSBC13hppdaLIRDzW1IqhRggb9846NAiazRmGtbhkFkhdYmZcOP+v0lqj3AU8dWbymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze9anYxI; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze9anYxI"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc02279so830689a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790371549; x=1790976349; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbyFlmhrqJuhrmr+8olke6V70SZTO62ggrdRiX4ueG4=;
        b=Ze9anYxIrtII1cRmJAKVKp3sEUooL0nchvaIg0J6tpy8FHsZ4VP1gMbs6N4bBDljzV
         MBe1zAssQTueNrBrmEuOZ2f4YP44aKpz2uL+1+iusvpAM9wbWf73mZ2PmweD+3ouh+Bl
         m6bzb3clWK9bMA/sbEM2I7eVAthrbVxGbW/nLqIop99ZN8u6GHb4zNgj/uitBikBk6kh
         UPSHfpHuQIK70N1qdebNdbqBOODw9CWNLjLa5x4LJHxTghJy9v6Zke8M/KjLFs5zR+7M
         9kCgiIM/EC+dhqEOO1ns2rhDSId1bvVtqVPk2xggDi4KhidS2T+G+kwY1QbjEcEcRHB5
         P61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371549; x=1790976349;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbyFlmhrqJuhrmr+8olke6V70SZTO62ggrdRiX4ueG4=;
        b=e22rW+JVmzazdFLGGl4CWJyVHJaiSVuIoTxB1+1SKBTL+KGjHbfp6PNdf8BaS3JW29
         wDxWyeQ4uPak10gyXpI1vg8oXzX/TO4OgQLQ0pNtiz8pdTvgaOysqPvFdahhkdRJykNU
         tpHZi46op1j51tjteLXSrYaGjKCumxfRw41vDnL9yZxf1Urn7XHUMXu9d2SsofGNLDZL
         v0uBBLxPmF9t1eoV19Ri09gUu6Tl/+X1cNfh9NcESvSPpdHT2D2+e6zGdgtpj+jULVE6
         +m6nsbfxoGWBl5dz3J3rWcrderG96nIDZ+M2JGf0dArmbR5MpwAu7MLOrES/qM4HUbd1
         YcLw==
X-Forwarded-Encrypted: i=1; AKwUvBwzXi7AcsD7xrFdnAQr/ItyGLB/q5MBtBPoidbVWjClt17ec8jZn6wKbBpSWmIG3YhbON8=@vger.kernel.org
X-Gm-Message-State: AFuF++lnfJNHboErwhrmNCUWbtkRXHUb9caMVIPOhHL2Kzq5yLDPSJQS
	hU6u1G8kwsf21Kk6CHli/PIOA+1v/9c+hrs9sEsiQxJLjmV/9Wxn4+6i
X-Gm-Gg: AYBFou0v547zDtiKXS8ASMbPS/b0FLb3NlT1Z7BFO0dXsLXUqa1IZdFL2grWmnXIbv4
	NvLy/8tRYKk+gZfdG7c12sTk4DK/74OLpGhFPt9T5J3zjZWWggJrPS4aHYlsHIELj3YgPjPANPV
	Sra7Y6n2X99dpjg8XEJ8y2j1tqHlGLIHX5Xe/9WDBgWzjhh6DDiPYuoKzVN5gS/AjCDkfMeGToy
	WtR4TVYAenJ8+9tkPCbQgOzKX4hkB9EBXgXuw54dK6k4nxMx9rfkLr4v7b/mufXjd3ja8uZsEUS
	IznTcZmfDcNpYlcvuLVNLS8tbSnhTzwqdxT+SbM6ou6yLgYXiPJeTWk8pe3NPn4tEAZtmn8vW6+
	gmq3gfgFzAN7jbC5epElEcPmG7N3RpqT375KC3o+5GCguH1LqQ1UQrs0nvEO9GE1tdgJ4dQl/J7
	ZLsezSATsE9kzDZxbdmSPmX+ZryA0CjMM5CR15iCWEG+pY0qZyJQyUCltSJSj/OeOEG4sIxAIIW
	WRM4HJPPCUP8PjvT8Zkr9NiYWp+mLIGq/beUX+W1bThBCokDwT455Rb8X0Y504vFD0tBXJx0aZl
	JVhX
X-Received: by 2002:a17:90b:3c12:b0:3a0:b210:643e with SMTP id 98e67ed59e1d1-3a0b21068bcmr3819020a91.22.1790371549024;
        Fri, 25 Sep 2026 14:25:49 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm6461176a91.0.2026.09.25.14.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 14:25:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 21:25:48 +0000
Message-Id: <DLOPQUOW1A97.1KXFXSEUUNSFT@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v3 3/7] bpf: Add sleepable arena page allocation
 path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260925203939.4105-4-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com> <20260925203939.4105-4-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 08:39 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Since allocation now happens before range-tree arbitration, concurrent
> callers can allocate pages for competing requests. Bound the aggregate
> number of pages in this pre-arbitration window to the configured maximum
> size of the arena.

The pages are allocated with __GFP_ACCOUNT. memcg bounds them already.
Let's drop nr_pages_inflight. Seems like unnecessary complication.

> +out_unmap:
> +	if (sleepable)
> +		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>  	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	if (mapped) {
> -		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
> +	if (mapped || sleepable) {
> +		if (!sleepable)
> +			flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>  		arena_free_pages(arena, uaddr32, mapped, sleepable);
>  	}

v2 leftovers? It doesn't depend on sleepable ?

pw-bot: cr

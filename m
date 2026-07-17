Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772A3DD867
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327252; cv=pass; b=BdW3M6BlFUjWVbudVwuL3msTPd5HmPLH2v0G64Yb8stvF/kUtVAI0BzAub93M0OC+4Za52lJmQqYg2vNfMlP6x3WXtAO3omOJQ1pG2vv9f8qaeAIu8nHjKgStmtZsrpaFkUPtVd6B5LI1t6iTstCXVitZIwE4e9agrDnxY+FnwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327252; c=relaxed/simple;
	bh=bjghg48MCQnWfaww4o0x4WM8WDb7dld4aNeQe9GF5iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ73gu/yid4sNRRZLWaU+X8jWx0evsnRHMHVo7iEdHC74IBZAG993SwK4hJMe455VeNMtqHSIH/oKi4O6LCGBj68xvoYLzJoHjkxxvefaEtgb1GbMcMNekbZce7OQJut2OxEflrKjYpjlcUGDVBupLb6bTejtx3WYQAX7NqZKt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVN6z4mC; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVN6z4mC"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1712a04ddaso216436866b.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784327249; cv=none;
        d=google.com; s=arc-20260327;
        b=KRW4mxqEHxbMtbObLTF04YF5QQkMgNM8aZSIi1oWE4h6Q0LFsHWS/PN1dqQrQkIz1J
         sG5yOHHJC1o2vOYDco5qq6PsWxfNcvkN2sw7pP4cz4U1hBg38K1E2y4Kq2KgAy/NGDO3
         Uv74eYn69KR6oJ2Wf2EzlNrXrkxbUcqu6o3hdxgI/cxMUcwt9G+sT9Xuvt3her00fNEh
         sCob06nj0recYWNqEnKnkxYNwjA8+zqSMDVcQfhSxv31o9X2u2o0ctwuVjY3OwavBLPs
         h2sZRWmhqUvNb8/SGaji1Xrgz1X3C5w6lyo0MUmBOhciVLAQDD4hP3hfx1vtZbptgY0+
         VKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9YZKl/gN+TySOtwCRRmaPismCx9J0DS4d88EwVV/LDg=;
        fh=/yvFrEP5ux9ZpmeyKQjfuXOHUXeO5Am16cx3awZ6fP8=;
        b=OZTl9RIOGKD0pv9KccfVxXoleLOvuq0udgKNupOkG9XKMT4H2vG6qyFntlP5OWV0Ry
         av94LHUpU0Y3ZRCUGogOCPYImnK3vqvDfwmpspN6N3jWUzPsf671BPY34kQ2q8GF/lGv
         Z5CjsIQRiJG5NAwHl1R2fp3hDo4o+6zFDpymS7EIY5J1Yfsgud68WaL6goqdfvislUap
         DnyGAkxTQqDadyLAAsB2fSaDXkqe6HzYcyJfzKjaM8x7Bmgej3wsakE4HC8oPC7etfny
         lkVk66oTFV676Lnh2/dvDtH5b1m64zyB1XQYgdAVPL8+KNCtjyIg2NsXb1DY07OXjazy
         atyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784327249; x=1784932049; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YZKl/gN+TySOtwCRRmaPismCx9J0DS4d88EwVV/LDg=;
        b=nVN6z4mCy6O9kRcTcGAA2oMYfwtn4gHlFEr/wfJuA4JbGjH3klIoJSb0SutEAVzLps
         1NVAHJLmZ5jSc7Mh+XIeOh4VftCdi2TKKfu60bW2vOlmo4DoqP2tvHTmc1Dr94AZRspo
         bQwU0sD/Z5HcgrsbEwwZ2fRVq2cp2USKDWkUFGwYsvnqwzEH3ZLexO9hWs0kMUs9C55M
         ATnD4PdemJg5cruqD5+FB3qZqL5+e6+AAllAWcKV93HkJ8p32rOVeWJ6os46bxC3gNXs
         bkwrUvMz4wOX5wJnR+JQzHl1dwVZ4zc/q750q0Bnpq+RZNtWdKRUny1Jj9/jV06kDo9S
         WdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784327249; x=1784932049;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9YZKl/gN+TySOtwCRRmaPismCx9J0DS4d88EwVV/LDg=;
        b=J3ZL73zYb8qbWTO5J0oy/j+TyT/YbnaIXvScx4/DUGQadXcdx9S/yQjlQw0m+/cAK5
         a9DZopdFp1kh9rlA3ChNE6yZYexPPOGD51cLR63zdClyJiFvK/HAnQef91zwcia4AL7c
         RPDE0yYlkoP5rJ1W0JrA8xzVwYl7xXpBAkOMtBU6FoLKmfGvQRqRpQ9qSNhadVzgPTux
         uW7xMpwUPMbcoqlGF38YfKvGiSODemYk+bwkaTglS56rosIO7SVDaYTDqCZUhy89w4ui
         X3uWfwBu+ao9xklrItO0ajXuR7+3QS+wm2MzEv7wAMTLpQMwkE+93jiOJ8m4D8D6FU2n
         TSCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/F5y8rzomDmVeP/uG0gsWA3rbgCm7VkhXbMe8eu+SUl3r8m9SSe7aqs6SptqRaOyY0aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMoiWgD47UQXkdUW4rGg5jK7H2PNQRfUY0xstQ7AaozlOr58p
	X0n2eKjNUX/UUs6pTnredvJiJA5cmq4f/nV9sJz5q/9ac5L2L62ymA5gBdOHNy8+MPer02jRWaZ
	MG3GqQXPiICeGc09dm/U1iWjjItbBJ6Y=
X-Gm-Gg: AfdE7clV+YOzILFbFgcrxo436nl28JU6GuU3J3OQUh/qyyERjVwLHLfwl6F+i+GTArY
	xxhDRigSbliEPQ6csTawRIAGzczlAZTEH3P9Kbjv37JOSqsIQwiqpJhuugEMvdqejyugDiMDD8c
	4cReMSEmM5eni8pbCbrz647w9f9rnJr8oaffCI5O/f04/gvR5cGPzqlad1ncZunCz4FJrB86/ZE
	cNfPmtZDwJFwOHzsTnGksAL2XnYbBq85kHT97l+kF5MwAsKzn4xDGSDGPkI0BSJ
X-Received: by 2002:a17:907:3f22:b0:c12:330e:ea76 with SMTP id
 a640c23a62f3a-c16b47c4aa8mr188756566b.37.1784327249022; Fri, 17 Jul 2026
 15:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717190544.257306-2-main.kalliope@gmail.com> <730b11181226fe2aa47c5add541431bb8bd4b4fa6af6e3b41bd8a09161d2f51c@mail.kernel.org>
In-Reply-To: <730b11181226fe2aa47c5add541431bb8bd4b4fa6af6e3b41bd8a09161d2f51c@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 17 Jul 2026 18:27:17 -0400
X-Gm-Features: AUfX_mzdlcMM_kt_muK1iCKqT25JZxMJD6-eLCFt_e0NS7uPIuvrJHYlbzOH2Rc
Message-ID: <CAJZwKkgG2Ct3KipN4cRgg4v=QQwj9LhA8pveqQvT_gQ_GpzJ3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc64 JIT
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, deller@gmx.de, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, visitorckw@gmail.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 17, 2026, bot+bpf-ci@kernel.org wrote:
> Should this carry a Fixes: tag?
>   Fixes: c95e269773b3 ("parisc: Add 64-bit eBPF JIT compiler")

Sorry, my previous reply here was meant for the earlier Sashiko bot.

On the Fixes tag: this follows the review guidance on the i386 patch to
treat these signed div/mod additions as added JIT support, target
bpf-next, and drop the Fixes tag (Pu Lehui's suggestion [1], relayed by
Kuan-Wei Chiu). The sparc64 and mips patches were sent the same way.

[1] https://lore.kernel.org/bpf/fa8a040f-64c4-484f-9538-fb0ec287639f@huawei.com/

Nicholas

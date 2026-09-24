Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C5386C22
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285617; cv=none; b=loTboa4F4ttRmZDugZFkAQeFQ0gyDmF+oSuayyDt5m+q4yvW8LvzaYHQ2/XTO8p0IFTiZy7VcNYYh+r1yM3meKsF2uUeGHe0m+sFWW7vhqQhcrlCdOjryW/61YKRYo8s2yzRRsTCXGskTc7gkm/SThu808ixSLkT4SKGPaPNSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285617; c=relaxed/simple;
	bh=78kNCkBoZO2pm6qwrAH26nCKPTYrBrhvIoFqsqd6K+E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=sQI1ENZvDmmPbJF2lQzCtKUnj0gJPNA9+wrCDuBdhV/d1N+JoAyo2WLhB7ccSE3lz4Ep5ao+X2ZOPO9s6J2iEAO4oEd41CB2ixEbSz1uvlST560P4elndyQneofbHV0YUgZFVlupTGCTwHsHF00Wa/mVWLkKcJ7ami06s6dL4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o95vdywt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o95vdywt"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so1561845ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790285615; x=1790890415; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78kNCkBoZO2pm6qwrAH26nCKPTYrBrhvIoFqsqd6K+E=;
        b=o95vdywt++EPML+Ntm+48FDpjNksw/lwm0NS3dqSG1D2LYI/4i4tEOJe09JLYrJT14
         aBnpwt7sPvR3QOE838iFcHhKTMkZcadeRIgUqxzAul/r3F0exDevDglFcx21duqQjDq9
         huuSvjw/aKCZprb9Nz7h9G+2GODzhywuRz1WNaGgtxud/e4/5t8rQ8YcnRaUEMKXRojV
         aK20Vwh7PdJwCn/Vxxj6r/tJLPMOm4N9bf/sSIYjmLCUiS/zsdnSyP/RZpXiO1UuOlpf
         8IvA/7/uBRR9/g+Hov8NHzUT7whdOgCGXHIvYXSV+DGUfRu/RYOFjHii+pedw3Q5uUdm
         Y5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285615; x=1790890415;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78kNCkBoZO2pm6qwrAH26nCKPTYrBrhvIoFqsqd6K+E=;
        b=LHErJMCRri+WSYQgCff68yJI+vHVbo6vZntdKj/XYJXNXKsk8MH0gE1rOS4ItMll9o
         O+GM1on1wx/dUDKgWH8KdwmYlKBob0302Ae5lHNFog/VHVk83ef1P8a6SHBelErCze/f
         ITq7Q+Tpv1+tavdseV/5t2XY6r3HWwSHNB9S5so2IPnFHka5hdqX0dAys+Tuw74RKHyl
         HEN178dQ7bf1kk8E3X4rI23fyJtXCihRAWDzG0H+hIpJWQekjRM0Pq/o3y+qp70PN/rL
         uGcaFMlzogSINaZQ7cYyNvcl28Udo6Bi8SAs4kRIrVFCgpdy/HwVvwbl8gKp4lxnnGTs
         wPrg==
X-Forwarded-Encrypted: i=1; AKwUvBw7KH8LHBxO8t40BTDpl2Dw3lTuBJ8rEbzBpuS8u/yNMAmEbcSFIYo38q+qFIrXC4gwCjs=@vger.kernel.org
X-Gm-Message-State: AFuF++ltFadbUjv1hXC8Du3kt0A90wn8hqdBzI9QAYE2DB7LYjHVd1IT
	qB6dyC7nZAZsGfgeBu0Dm5bRhTHZOBCX3I2QmLmRaw95pbdoKu/tw7od
X-Gm-Gg: AYBFou3vz/Cu7pz6IEM+bC2LiA1jcWq7+f/zJlF8y2kypU07v+V4vM8ZdQSVtJPEwO8
	kUtGbnfj2UfZoMvbx1RWOuW54CcNCZShyp9rnXyKm+tqgxOLY/YSO3/NwExUSVOD6/SpfM696E0
	eZqFEdl+LodXRg/tihfwttJMBGz89T2zyNkTvPYVlHwLJiU2vv/yhxFlDnfDqoWxIL7Zya5seh4
	FmMr5yAvPyFLXC6qFSrHd5O5cVSvdfsBL0wT9lV5Agwaq6sQA7E8Z6BNJfQVsBqWjjxSEuPTVZY
	wOlJhvxbeTxltByJe0ZfE6jYFPlhsGMWOYxyMVT5L5QFJTNfDjXi0YRKVJQREz9sa/y9IV9FFOL
	Icin0Ia2VL57NhtwrjHwUPlvDNhNJRddtgwMsGKkH4jwk19VoAJjIjXDebmH8Rm60S5aa8n1I/9
	zX1NbzkWlV5itB+PdKZtxKMsrR0gmPlTvNhsHlb1AvgcURXXRIuPAk8jcqRet6xPbfhsYAFb+3O
	OFT2X0yynQDk1lG370f5nuf38j7xa8R4NtJK5E5HYlIaf9hhIKg4Ncmes2/yQYaffQnZMLq8t1i
	MME=
X-Received: by 2002:a17:903:1aee:b0:2dd:c100:a5d8 with SMTP id d9443c01a7336-2df7dc5fb72mr36726775ad.44.1790285614937;
        Thu, 24 Sep 2026 14:33:34 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbac49sm1671695ad.3.2026.09.24.14.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:33:34 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 21:33:33 +0000
Message-Id: <DLNVA9111IMS.2GQ5DERPDAH6I@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation
 path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260924053621.7076-2-emil@etsalapatis.com>
References: <20260924053621.7076-1-emil@etsalapatis.com> <20260924053621.7076-2-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 05:36 AM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Add a separate arena page allocation path just for sleepable callers.
> The path preallocates the arena memory to be added to the tree before
> taking the critical section.

Another idea...
can we drop pages[] and link the pages via page->pcp_llist
the way apply_range_clear_cb() does on the free side ?

Then both sleepable and non-sleepable allocate all pages before
taking the lock and there is no need for kvcalloc vs kmalloc_nolock,
batching, etc.
The whole function will probably be much simpler.

pw-bot: cr

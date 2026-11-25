Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577242;
	b=jUrT3yx8Q768sk+exAiYoPgG64lxLA4pgl9xBuYOxm/K3IvHLcxXi1DuRKRed7KmQ7QJ
	 aMGlVxym840dtPzrAaire7gmlObpAqpSs+cmk/1uZVW32FV6PhSYVx9nBtn41mWMuaGNJ
	 eMKDoxk5npwVOCRX85PX80L41qC7KLZbfBdHdQJqYly+8vatlJo/h/kNbJ7wJtU37htrX
	 J/C4PNHWFcr4lya6/gg+yLqjw/kqd25fnTFRS9s1xEf/ELjMM0naFHi0IF+hClsWkSZY8
	 4f4nxzPm++wFmI0F2e5rZIGGTPOrOX2Rq2aIKVN0P6ndGx+sl0VrvOsMnG9ka11KLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=5bRyP6KOfL9XhmOssL+lcx9o6qqIInqeGasBfYuP7vQ=;
	b=bEC1soLYxyfgaXsowkzL2HN/urpxb1eE8z2MOd0PjzmZvYL4jk0xvJc8xskLzD86TD/z
	 qaVNNB7d0aqR8Cuflf+15j4WqgtIZVdwJfyghGRP08tr7M3pRkyZhtTyOA+jhT7MMxdQz
	 SOrkMYZiYbxnOgG1A6LxI4mmLj58hChDe3obdNRFQ/lgIj++IsWbIl6ARK3GeUvBwsv4r
	 IVbK3TvI8OrRRZoyzWzUgLzvFp7gowTdvC/0gmSF0INnF+pAn0BLF7JHEl/15EBJXA+MU
	 7wF4oJZtHhV4iaDj38scYOdzv1yw0zvEYTclwlIv7cC1m7Vkdpha5Ww6tnOulI57vcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FV1u4XTS;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A3606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3A3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FV1u4XTS
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f04244c3d0so43054055ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577241; x=1796182041; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bRyP6KOfL9XhmOssL+lcx9o6qqIInqeGasBfYuP7vQ=;
        b=FV1u4XTSdDcGYv+Wnu/myw1a4gdaFVJCdKx105w1wQnVNnukJXD2EGG2otptXOwFRF
         acxgfrfjBpeb6kvjPVbRThzYWFJ6VEcmzzHAjUMYqimj4Jpi0wZU089VXQy4LflVTlr/
         SlrnXAmneuaXGrxTad4SCziYhSAii4Lv+Cct12k93XQrjuZ7TfgC0Jhi+btclTsUcT4O
         iQ2GMKsT2glymqqTRIFsAWx8pfUzlVTVj1lqHsMj+DiGZb+7Wtlk8ugfoXK7WlMF82PP
         Eyu7M5x71UuCQ0kA9zWuTJqNdQmuq3sifbpsTguXO+841v26fRTXjnW01ztmxlg5n1pv
         IIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577241; x=1796182041;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bRyP6KOfL9XhmOssL+lcx9o6qqIInqeGasBfYuP7vQ=;
        b=gtM2wxYCv856HgZXIcZNOPdOAxdkkmGPhl9MIhQ57XvC261YZyDUt9hhNa4H/X9IpF
         mDwx/7pWElV/tT68D2cx7T3ldf1k6U9r3l0+tqGrKppxeoaEp/rdOAOKgwkHNvBj6HsS
         cViNqNKy4n8HBSRlYI449IyRBDqu1B/lVz04N03Q2xjT4mnwNhg3xpHO3DDQCnd3Aqoa
         6U9V21Yn8LYQngbAVN2nm6sRMeQ+KuVJ+iYz4Y+XgCunM7s+JMABq2WXuiQcMg6cYmb8
         KKMsHpxPYFFuOPvRCxiAKZ3/ODufZFD3Y4ZkEaSmLrcvevWCW0NJ5y6Skzc+iy1uz7uX
         WS+g==
X-Forwarded-Encrypted: i=1; AL+hErFCzeUF4Onm1crZBbdm9f2rilrn9ZUoVKl7BKPUaxRh52vHRCsCVfdIHAKpT8XZDtMSixU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GGqpbe9uwBN6zrnt0+UXJ3z16M2/S8Th82XrqJ2wxPbZwqq+D
	hZG3HQYDz+3yeCqa5JQrBNLh8T3YRyU6FgHHPz2BNd4mmKVAalqGq/ccoPXpyKHC
X-Gm-Gg: AZFdTZcniZyuSJKZjWAYiIEqvTYhEHKVWjXwUIF/T3JJcAm1D0AzirzJiLitxT/z1RE
	wU7JXN9srji2KNqIslqm97ujZe5UzUTPYpyUMZ4QxmA+hHY/e4ZQS4hTYjM8AjaZDmV8n1qKJbY
	zCxAUNBZrmxgRau2dmw/ajADeqpFtbJ/JcPCec+NOdkYKw29fPp7F+9eP9H+BHNbTU0IY0a46g9
	5Rda+YrsL0RKsS3dfOK/eAEmmWr0aVLG2SnoRY3dBRz/c9KkRfp+MaqVz68oszIpcytWj3iWVv5
	bGxRpHaWBOfuY3+gg5dvArervJMpAHN1aqKEigaeX2acA5JFM0wD0ywdJk1oG4n3g0retdBOYYg
	vlguJ6t/HnQ/tD4EP6fjWSRlk9X8L+3BA2646Wab2+GBOQGYOzKTScHsis4D7OUF/mct0K1x5Zq
	Ch6BLSLwWoe5CEmcgxNeBR8QWlyuFMfgFGkVeGDEsaZUiMMIdLIoDZsOrNNY9RNLvxSULRMWC5T
	nlXZmN+YCeEFnYddXROfz9arfMfC4PJETc140RendXpuoicsKEP1Dl06e5jKBHF+KyyWc2l4F7+
	1nyZHOSDNj/7ESN0uzWXKRyQARZM74xGX55dfO+y1eSkINFNfazlnISnKkQmZeOpEeWl4lRbIwP
	fQyyY/pBYcFwHIqp6a2S14PQw2CIHjI/CsXA8SONxJxiVDX2Y453UL0cG
X-Received: by 2002:a17:90b:3b52:b0:3ab:9c73:130 with SMTP id 98e67ed59e1d1-3b41c9e4b34mr15289788a91.33.1795577240949;
        Tue, 24 Nov 2026 19:27:20 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm9716313a91.10.2026.11.24.19.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 19:27:20 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 03:27:19 +0000
Message-Id: <DN3Z0CG5YZRG.3G71W1KED656L@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andy Lutomirski" <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, <kkd@meta.com>, <kernel-team@meta.com>,
 <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Borislav Petkov" <bp@alien8.de>
In-Reply-To: <20261125021733.GAawZFPYeXUtqNINJ2@fat_crate.local>
References: <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com> <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local> <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com> <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local> <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com> <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local> <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com> <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com> <20261123185124.GAawSLLMoWwJ71nq5j@fat_crate.local> <DN386F271FUR.35EWQWGMEMX7K@gmail.com> <20261125021733.GAawZFPYeXUtqNINJ2@fat_crate.local>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 06:17 PM Borislav Petkov <bp@alien8.de> wrote:
> The hurdles are more, which is better. I guess we can try it and see what
> catches fire.

Thanks. Let's do EX_TYPE_BPF check then.
2nd JIT patch depends on this one.

> Next time, when you decide to touch core arch functionality like the #PF
> handler, please include us in the design *early* too so that we can chime in
> and check the sanity of such proposals.

Sure. Will do.

Kumar,
pls rebase and respin with the EX_TYPE_BPF check.


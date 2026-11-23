Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459913;
	b=jup64O3ldTtGdGFIHep0LaaJh3enwwIsJfhZnHqZ3oCTNoYRwBXXJdqP2KsCJYFPEm1q
	 zL/EVTIL8giZ+IAgy0AOZJcfAPgd7Tb3q1+q2Weus+kqHweqmeQJhRH7/RfnQ032bPs3C
	 ZOm1RQmgd8DpziPKljLC/diWyfY1EUTxrycpm3TM2mReyNLe5VFeF452aokvw9REJPIKT
	 ZSqS5w0IkNyvdQozKLl0mycSzw/YpEG/JMduYEGtNbG5mXQ5DtV/N8I+at5bHlOaLpLbE
	 +MJn8/Y8G5saCuO2oXQn47GjIbweGpOB1ziPqJDt2vXqCWDHGKNQtIZMg/fbIJK178g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459913;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=V3IR9keD6I92cN6dz0hkf/bvxjfGr8L+uZp++Dwjb5A=;
	b=3vpzqzvpVEs4Mcs2MBZVQfWWJomGDnB2oEkWCrGj7SKvuGRKmhTGxO5FvEe/MUkw5uOx
	 XMkQOpGkVYFeKHii3YASNO2ZpZETi5tjcboLAPH4mqB3Hcr1G6QiDjgqApO77aOw4qdgD
	 R9k3lv7AhOtWjF2hUjyYgV5ztataJaRBA0AtYtvxhoidBmJbVF9cIVCaizWtjIsaxDlMc
	 8+0rrAr0BCdWB8yHKhPbhNykcVYOgTpMzwhV9oTIwft8YaJwDLjYpjgUyv1l7Bap5+MBG
	 8RXkxpemNoRPjnFVhFwjUfoCF6k20/G82IudP0dlVT2LAgViCZMD/CF5IRJ9wU9NVug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=DjECTCpW;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A92606A31F;
	Mon, 23 Nov 2026 18:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A92606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=DjECTCpW
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B1D3E40E0219;
	Mon, 23 Nov 2026 18:51:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XLowJlXBKQ6O; Mon, 23 Nov 2026 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795459906; bh=V3IR9keD6I92cN6dz0hkf/bvxjfGr8L+uZp++Dwjb5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjECTCpWYinvh2XCS8a+AaNBkS9Oo8wIC69nFE/UOv4VpvKF7PGnQh6Yb2quvSKcu
	 lA6EATI44OBbzEUlV4TThh9SrsM2DqfpGGwD04AtclnkjmO0g4HY3wKnMLeMXndTOJ
	 KKNYvA11TuSsWZxpkpwa7ta7n7t7vfGx8EmFrmXJzAOr7lujaRMKPtU/xjjsQpAnJE
	 yXs4fFH7mycOFlh97sWcNc7i07ZDiYAU/vCEtVNE0dUhrrVRSu7mdlCHq2Vo9nwGAZ
	 qJmRpK+lFvGk6F3LOW107vR1MPZj/0Fql25PwdZ0vWoi4tW3Krl/lY+8DltVlfCSEn
	 y3kapItHqH2k5Wg8azV1UudECycjKsJhCIFpuApe8SL4cidWiO90P27nu7WWiHV9Wy
	 nKoUh4XiLKmYMxi4vFomsSCEJN2dNnZfF+tMXyzTY9u6nxbUe1xMi4YGoEuIrOCzQf
	 V8s8u+++y43/4Q0SGfaOwwyN4sY4pq+5chOtdb2PoScZgpvpJweYvkV6T9mPZMSZ5Z
	 Vd1XkPeEb6Furu2JJozykp0ZWd+JYucGmq6X1RIDNndbtOLKuJEQTqDXwx/wM+cRxM
	 y1aZuXrHo46zuuzkFf73IEa46d95E5H5ALinu4prEiN58Sd50Oj5pQdXFkY0Og8rlE
	 Zfv8EpxYbrFFtv0ScJljl/i4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1A9A40E0240;
	Mon, 23 Nov 2026 18:51:27 +0000 (UTC)
Date: Mon, 23 Nov 2026 10:51:24 -0800
From: Borislav Petkov <bp@alien8.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
Message-ID: <20261123185124.GAawSLLMoWwJ71nq5j@fat_crate.local>
References: <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
 <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
 <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
 <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local>
 <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
 <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com>

Hi Alexei,

On Mon, Nov 23, 2026 at 06:58:13AM +0000, Alexei Starovoitov wrote:
> SMAP stays on. The SMAP branch in do_user_addr_fault() runs only with AC
> clear, after the CPU refused the load.  A wrong answer from
> is_bpf_text_address() can hide an oops, but it cannot expose user memory, so
> your concerns are unsound.

Look here, our mails crossed last night:

https://lore.kernel.org/r/20261123043409.GFawPCQT2M-hz0mvZP@fat_crate.local

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

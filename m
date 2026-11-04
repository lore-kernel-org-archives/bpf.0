Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759440;
	b=scP1GoH6bgWyN/FEI2YFc+2KUhnjZHbra3Fi23fu00ixcNtGCWl7ZU2D8o0qi3jlubAb
	 qpwjIV6WxTAW3DO6ny23Q/8pf1IYfmf1DR8G8j7esVpNoihQ50z68Fo+j8x2I9Mki21Q6
	 ejyY+TtV5frHbPJRQ2anOwncKq7yxkbFFhqFC6Sw9WnG9KAwZP1R39o+ewOZIxxTysEMs
	 dJ5IzyNuYmTJTvftSn6Wp/xpcGMTcMprWLQ4iEpv92FP6hjPyyGBJ7U7QkQ4Gk4Vl4Kfg
	 3eBtEdbF9N7b0KBmvsS9iKlj/P+g41cMM+wqsrauF/edFuudKeeSx57h3oWcHNGBKMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=q0xjttC6XAY6HbtPBR+gBQ3FRtpzoADnZUG71NQP4Nk=;
	b=zIek3S/dVFUMZnktdXh6OyxwnwNoaudsnQmiO4zBOIglkEPfsU/NmF/aFBoNMfMvrgvh
	 g0actz36i7HyxowkYi7aGeK6XJM/8qUMfalCqnMDbMcX5rIZBGyXdiEruWBZa18ZtFEoE
	 YSTngLT7Yz+5HEU4mY8Tic0vMUMlwgyMiApw1vmlwcuSP4qnsWCIFpsXqL25LgOonU13H
	 trKkN7owYBjy0I3x/2HS6fWPiZy7mSEEmcHWHCwTMSqtRokqVigWWY8+ulOPV9ydIClwE
	 qcS6hYx1PkoGkKIKNrMimNsIBg9OFlCU785S82xLuSm8lA771mFzV65y6D9tbedxhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUdr9lVl;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1338606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1338606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUdr9lVl
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso155341a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759439; x=1794364239; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q0xjttC6XAY6HbtPBR+gBQ3FRtpzoADnZUG71NQP4Nk=;
        b=aUdr9lVlqdsiMTuZQ+Y7K5axxXpGgj9Ybsnjx4X/CDRJ8xd3D/0V9fAA1bHSB6Yj0+
         PzdqIIMq6edmUdn5o0WlCsx8c3OsIy0zpWuWQbPSdt/mk2trVh4AVy5ygPuJxqmnomMU
         nlg4z2Q6ROjM4wMEtiOHeQuQUle1igfALaGAS/4DB10UYMPXJRr5ieHHeynN8m2zxvOU
         OPm25fNTH+8CdFZWjxqrJ+/NhfkACb9EiORxjiWdDA9v8+Aa1ouNihBuQJPtsK4qftIz
         8CNv0NFQdVFsNe9anD12Q/HF6Zendi8xOeGMUzoGjw4XLp9WwGFHqIpFtqcZwL5lwPrl
         lmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759439; x=1794364239;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0xjttC6XAY6HbtPBR+gBQ3FRtpzoADnZUG71NQP4Nk=;
        b=i66dWAk2JIfP4wS9daLCW6w7FGFpvPTG/HnnRNapwHwGkj1AF2SioQ0A6bT4WwgA0e
         A/hssYbuwMAP0Ntll/GXLwNY2afSU6Fvaic+1zkQcoSubK9yTojyfjdKRzpe0VPAvtJ7
         DyvOFXzG41kfA4ZVYgLAPUuC4DDzYT+/fJiSYXqmmU8vq/P9s5mKwfClaAbkVjSNJVZn
         cL20hkeOCUonMGPAnb1dV7yGmOSTY966IBE2jok06N4GEVsY/vYb7fuBYLhNZq/CM5o6
         8AOxlkcREiE87fMadzVAf73Dv78o4gHKczfHBB9HGD3leFUxj6ODVyQJwDda+0/qQsOK
         ULtw==
X-Forwarded-Encrypted: i=1; AKwUvBzbWvALaIa5xfgs1+JZnS4mgLD1faJq0gF8iI/dDYkjhCBZecaTR1SBXxsGRSJ9GNnQzRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PN/P/V3l77cVDVxKGxqUAhhEz6j48hEQ8whdc9bIgJBVGHkr0
	F1mVmrJawcCVhm1FvrP6Qsj9ntGRnLBztG9GyoSwQ0jqrTBdCrUoU6mD
X-Gm-Gg: AYBFou0V+SV8yRdDfDqKjWcYkH0c4m3Nebhf+FNuQ2Y48LZoXafGV25BdC1EsyzojYV
	bIcb5MzIQBzu1EfrJlVm+muYNZoLhPyQGP8LGt8O4RhAyMSISq4QXtr2AkrzaKlFNkPpj9BsMYn
	YhBxN7jXQfhchapogX+lIf1ODoRFOIlkHRtQfmzN59Fo3LaVr++fWz+Z551nVlCnaYMThWg9wHl
	PIxon8EWcq4tK2f0Ij85eglmnReqav5Zk4Usq035ctPoCQTad3lr9Eiv3K8PHV8L5cJ/3GJ4ZfD
	sEib+8pAGObEMTQcGI37+VA/zkYSoNnCYh2anO7gs3pExAGgQCs2gpQmBjf6SfFtHsSXpq3ABvQ
	KrhTKEWn5Nxtxf5NlEmr5lqrlTwAxd3Np7SMTOSHPyAHSksAuk6QAI5JCzZa+g522tSa9LX1yk4
	eSEGVePKp4RdepmwV+dISdm7FOCQR7gRMMrcHMZK4FGhXj4U6azj/F6MFg8oHYh+BTO9gPFZyjL
	8nviyKy7LTjLcdHpQDrPoPPU5aa3en5MWTuFGUGRB8oEi9PHulGscgcOgtwyEdTRbfZkfNdyP6M
	WPcA4+YeBaKr+WKeZggzM/YBDNfKRnZGy06MYwgGzr8Za2MydsxkcfBkl0qtLkZTR69ub/VzBM9
	gdFdCasntpy5pmPC6ZOE7YcXkKylahGA7smA=
X-Received: by 2002:a17:90b:270e:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3ae897ccd0dmr12086781a91.18.1793759438875;
        Tue, 03 Nov 2026 18:30:38 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1462783a91.10.2026.11.03.18.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:30:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:30:37 +0000
Message-Id: <DMM2NHPR2UJS.P9V6P9HRJFK6@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are
 stored in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <f4144b15c814d1c4ed9be5e4e4f4f8f5746bb7638ad8234210e5dd2524b1e151@mail.kernel.org>
References: <20261104012401.1354861-7-alexei.starovoitov@gmail.com> <f4144b15c814d1c4ed9be5e4e4f4f8f5746bb7638ad8234210e5dd2524b1e151@mail.kernel.org>
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

On Tue, Nov 03, 2026 at 05:59 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +		ptrs->off = rel->r_offset;
>> +		ptrs->targ_off = sym->st_value;
>
> Can rel->r_offset point past the end of the arena data here?  It is stored
> in ptrs->off without being compared against the size of the .addr_space.1
> data.

[...]

> Should this function do a similar check and return -LIBBPF_ERRNO__FORMAT?

Not a bug. Only a hand-made ELF has such r_offset.
The input of libbpf is trusted.
I thought bpf CI knows this better than sashiko :(

> relocate_arena_ptrs() would then read past the heap allocation and use
> garbage off values as write targets.  Should a second call be rejected when
> obj->arena_ptrs is already set?

No. See my reply to sashiko.

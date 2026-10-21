Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601464;
	b=hF4dwiGuCiRPtUyVuXPcASMI7Snm0+LTluDd1Q5ttLJMxYRXIspkYDzYwUCBgMsrGnKx
	 sJ+YRc6W2ziX1v5slzime6pyZn+I+sxWB/4Yq2XgOh0dfhyRKMxjmeoC7ZDh4jV92Q0fy
	 NnUbymuusigXNL3f8/Kefr/+A9YIPYPxDN/haGhxGBUtPvXoA/ov2KwjlNzyMCjeqMdFW
	 adesCeRQwXrh9hG8KbGjFjSTcyxQ2CJfL4g3BT5w5yZhQXT4kl02e/gJZvkXq9iGkVXsj
	 lU4EKF1jK/PrGZRBvAlLWLdnHRKNQG9Oi6LEZmZ4N9A8J4TfJ4ysf8UjEWHL0YXI8Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=iL5JVRjlD1j58Hb7M9pwob0a5n+pyjZoFDG4rdFHll4=;
	b=hqEWuLnn4ojowJAEibSXnaAbek5PX9y4baU7HCYf7KSQyBE+0ec5DuyQjcLIG/cjEpH1
	 Z521To9EjYuBQ9+UlWaXliXW8imHSX+mJkvtWcCJTygKXpIbda29lmKFAQI8ApRFQ+Z0u
	 CRpnR41tonyHwkiazXpKp5HvaZxM2hGG+Kp43U9j3B9VLuVn3PfXPtBTtnpMURiGjo3CJ
	 4rF1itnBgL0x0wfzxsH5RiTDzGBLNj13XaJAA8gIxP2k6ns9JBD1CsbOXEgqqB+xxbi7i
	 9dRUWT4JqZuptU0nBFvm1L4elcDHqNJgFKx89UW0sDlvLWUPOY8ig2cN4DMyElzkDtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QY9gqmy1;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3D606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE3D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QY9gqmy1
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so1004532a91.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601464; x=1793206264; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iL5JVRjlD1j58Hb7M9pwob0a5n+pyjZoFDG4rdFHll4=;
        b=QY9gqmy1u7YSvXLC72aO0Oca14+6EOwVT2NDLhK997vpb/IGOheyfhyQEBGY6sctQ6
         YB9USZS8MlO0nE6t3WC4yGhqkg4P5v0LL6DAhXfRa07IdUAF9KUzzfRjkWH5T/MHiX7i
         M+nSWMYMAopH2EtIJeO1WdT7/UfjUhQig/bIfb1mOsOZNbnqZ1D5W3OIvJcYI4HUOHiT
         FZ7KcBd9Tbi1zfQM9bo0zVtqkrxi2qb90Q/mYtSqUqWPVRyAvzqZ/cDcVXvNcptquei1
         dtOKrRBjDDKfqMFXmIOckWeTsjlC0hFgst695sb9H4+jPAy4Q5LxTwiks3tiYHBzECXi
         UjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601464; x=1793206264;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iL5JVRjlD1j58Hb7M9pwob0a5n+pyjZoFDG4rdFHll4=;
        b=YgxAB1eNEVHlIMc/bLlsSYdb4jNafE2NdRdDDQS4NyuDFgH0ockL839U4BQm+mgDRQ
         fBl6z6wGR3dHVpdPgaHwwnScSXQoEKTJGMY8p615csfgM28wOU+zln2OuLWh4pgwREWz
         ePJEfP1tpV33VLdhnKfNJvGrpB9Nv3Dpp5MceAWLBHeVctXts9B+YrIoNaPBxZPrcXvr
         JaM3ojxUvg6D/wM/5JSTIxowqL0ByXpqmTbihyZ7chsPgHRDfZA4kpulSGp6n1IdP1P+
         FzVuKbJBze/GFk+HtF3lwsVdlWSIKvDFUd/DbHE6JWYZBZq3en1k3KF91LNVyQUY3vb7
         fjsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOMWw8Oguf9ibkxD461I9B6/o09ppKQ2Pc7hsPsmkyFUry7gWQFdyITyE3SpbxM2QVWy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQyAMXGiDlJ/KR5VdthrdRpyTg1UreEiwEweVZKH0GrKBG8c9w
	sbP0jwPwPrMcWR5vIFR0LPiSfaKJzMcQPBA/KNLbsboeTAE0AZXJECg9
X-Gm-Gg: AYBFou0LVR+5v/OA5N2qk6Ii0G+zPJqqGQ+wOyZZDaqqS2fsNLImoJ7jlQWapoRbT1T
	ThnlbQNqam3+2Rv65+PgGP1QH5xRdH3j9t5Q4ma3ksgO9/AvHXkViyFCZjw3lTO/UYfIw04Q5Y5
	CWYVGa9GYO6zQg2wfiSIBMarBVEZ62e8IrClskD+xT7UCWoTBtwtyGn1PWeYdho8ieGqH+yWCuy
	/oq1W+cv54iabMbPiA6nhCpKXL51+Fidx2FVDEF+4OxGCqVb48KZdMk/PT9JSq6t57mI6JAi16k
	FRKBTyDDAyJXKTiPA0a8wOjTr9CMVOssXXRa2nnIDvl4B9O3d/NHtiptrz3vIiW7r47aWWlBoU9
	GtmIbCDHwcuh0lasdP/lPvdyY0bBxyQDAQfzcWvxMaUs4aqhVrvjraQbop1v/tzwyABotinVP38
	4GS2QTLwDFwpfeRdE2+JqDxERvghzrPQIs48DVv/bpToq+JgQdR7tK7xsdtqGoIs1jpWjmDb8Az
	s1s8FXB7DdUwPLeOPB7Y29l9/VGW/RaKotGG4P6fgodbnrD3znvLqa1hkoIwUZDwrddp44HPqrT
	L0liT2CIJnJgOytEfPA62qLf1rvYbaU4kBjcuYIktXZJGcQC/ZjLQf++hGzF
X-Received: by 2002:a17:90a:c107:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3ad86cc6b98mr2131764a91.61.1792601463629;
        Wed, 21 Oct 2026 09:51:03 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890bb2sm263916a91.1.2026.10.21.09.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:51:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:51:01 +0000
Message-Id: <DMAO6MR4SCMF.2EQPVBE2JH740@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 00/16] Add percpu variable support for bpf
 arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <3f5446dc-7e7a-4f12-89b8-6e590b2ee1b1@huaweicloud.com>
References: <cover.1792503001.git.xukuohai@huawei.com> <DM9QXVWZXOHM.21TW53TSXHZ9F@gmail.com> <3f5446dc-7e7a-4f12-89b8-6e590b2ee1b1@huaweicloud.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Wed, Oct 21, 2026 at 06:53 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 1. The table wastes a pointer (8 bytes) for each non-exist CPUs, as the
>     global data is populated at load time by libbpf. On my debian machine,
>     the CONFIG_NR_CPUS is 8192, while the machine has just a dozen CPUs, so
>     the 64 KB bytes per variable are almost all wasted. An alternative way
>     is to allocate the pointers at load time.

Right. It shouldn't be per variable.
'type' can be a struct with all percpu variables of the prog. Then it's
one table per prog, like the kernel has a single
__per_cpu_offset[NR_CPUS].
Allocating the table from the prog at init works too. nr_cpu_ids can
come from user space via rodata.

> 2. For small variables, the page rounding is a big cost as this series. A
>     better way is to make percpu copies on the same NUMA node share the same
>     page.

With the struct it's one page per cpu for all variables.
I think it's better to share a page between variables of one cpu than
between cpus. Copies of different cpus in one page need cache line
padding to avoid false sharing. The kernel percpu units are page
aligned too.


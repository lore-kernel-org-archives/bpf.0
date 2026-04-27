Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECD2C11DF
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327225; cv=none; b=VcW0kMptK4Dq5Uci2NUEtZAb7FuE8MLSFbMpBe8L7kIQdHvSgUbBSwRx2dgywM43fElpz18sCzgmaU7Wi+EGp2mhssh3NbDLDoFVQz6nURjJdYrxJbPuY8cSDHA93jv8BwPITqJIf4HR27F0bgtT/zZo60tah5qQoN/Z0sCPIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327225; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJV7laFOQu3QA29I754JgkxcferI/EHki+Dzvd1fdwbOt/Y6ji8Mw5aUclo3sgWa1AMt3xMwBE7y6JblC70YBoK6ix4pc+rwB22T6OS1wGI7X6RtWYcVqKtb5zNOX1ZIE/6au8Qw34X9nGcYBq5soQtadPiyVDsFZiJD21jeaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KpttWVcD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KpttWVcD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9401011a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327223; x=1777932023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=KpttWVcDGB3O5dJBcMxKAfiN1B99w3cD91XFGmnRO+U8qtvB/fvJsiDQhIhZti1XOa
         50L4BSHVmcSfkJAt3ciSHxb81ZHc2Xx8S8XFxgxUP36a9BdxjRviQLNIjlkDhuexjNCh
         h96Fa0VESj1pAoxP6Ja82aRYNfdIv1VQ6EQx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327223; x=1777932023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=fNQgmz1MewRQ2SPuqUbh5gr7yuDNOH75+XlG8lqJUpMkxEWMpDmqBMwxXvI1kXM+oI
         RZ9ytYV+O6WQX/MY9P+brqg2EJo5bUpwkupe5dhkJv045pjayHFkvZ+GpdGl7RetDs0O
         qvAeq9EKRHCAVLLBUMN7uSEvHDrlr0ebiTYPGQvXpsjvgGwdEBPc/LBzi/ECkUtbOfLE
         K5io7JjOqlHWh4ezEIrKXTq58v19fuoMkK0boQxadaOnBAFeqbk/2iNgzKw80ZKh7Y7G
         1hsvUnboabp8wPgvMgJkz2uByJMDMgJtg8ktGOqBEwMzORt7GmCN3RL6kXnl2E4ZJqir
         7tyA==
X-Forwarded-Encrypted: i=1; AFNElJ9RRL9AKMeyMDk5szFqG0VROlPalXby8Yhi2hsMu0Mc2feNxVn0y+goWJIv6vCtMiK2isg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDnN2Vo3VzZV0p5JqQNbRbekhwrTlVbjdV4pm+3l5QcyiUHZG
	4WnYTVA1uzIgXuzFsPFkgcrLRN6hJJA79eaDBAElelWJmkBmqkh9XLgOr0xXD4t9w6jzg3Zv38m
	lM1ebiBbIEg==
X-Gm-Gg: AeBDietq8okjDLhgI4lzFoKwliQrcujwnlwczg+FioDuHa05ikoGZidcdUuGWBWsbu/
	Ask/IBuapMBzLalqH9mWwkBRA1BqX023diHJ7CXmyY50kYwImcoP0AHrydIvmi5q5Sptr2zsYPR
	irs+0EPqJqaaQl8MOLgvh8QTEU4YcY8mpNbDBW4dlWxs7GMamFBt8ZY1ElRWPPhQctW4mpZhyFH
	lSZBDlxa/pBkVd/+pRb3J0fVpdARSpnjv4Za1VhRO9pTx1FOuSaKsR5RZu6b8RDs3M5bqHWOtCo
	d8pDp3FvGXXK/nIgZVEcjppID692YFWbBa/E6rF+lwqtypAEIWbx2QQFnHMcTd9cpvdCx86jJR6
	brYuoTa0YxTEkAuUlOuyuBMyjR5gXT7kRoPnRft/4F+DDvqtaibpMsEDdNvyVSyS60arViZ3l87
	qjm6JB0wXcM181g8ZOs/+fbiPOBdp4TyM5HK+21S9/bl5RnPnYqqnCfJ+ra0KOR9Hq1EMxSG2MX
	N40chTCzSA=
X-Received: by 2002:a17:907:1b05:b0:ba9:13f2:95d5 with SMTP id a640c23a62f3a-bb803779990mr26110766b.29.1777327222564;
        Mon, 27 Apr 2026 15:00:22 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a35fdasm11267066b.19.2026.04.27.15.00.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 15:00:22 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso10762139a12.1
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 15:00:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ83bgDgc8QB7wVZZPFlW+pFq755H94rldozjvoi/8scOtHOURuRWj9YqNYVSfC4igOT598=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

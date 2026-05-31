Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D63594A
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780186492; cv=none; b=mnqlZw9pwyGlWqYNlgxrWHB8+YnmSlq1xdTVaqlN1KBJnqjY2vtriEypHv18HANGWZQjp2f0RuKwolPzrm6KQ+5Zu5X4F7wxV2DsJ4lX9hALtSFWT9M9DpPwFsC19CUOff6AeL22NRhngJvMdfNLfT2pAXosITd4iH8aXB/qQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780186492; c=relaxed/simple;
	bh=3Lniljo4umQFyHf4Oydjd3iBsVbqqEjUbFIyY4I5ij0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XosNKsadO0Gd/TRv/eQ+3UwVtWQQzQ49eEZvAeO5/8SqlpEPBdh3wSM9N6hEb6Kk1lTHgyRNRK8ykyAWudE8UGWUMXmwwuVE/6xmIgV6koSJn6V7vMUulvmWM6VkB3S6wZK4iWaJV7mcsBjw/UuDgEk0aNAfPuMp4HWKwR0ZqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6R0oolu; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6R0oolu"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69d8f70cb0cso5273458eaf.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780186490; x=1780791290; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6WHUv35EmdQ4QWk4JR3Y1fgG/+v8aK/cHw1Gj0rc90=;
        b=s6R0ooluIo1rFLvZcBx58pKndbOk0oPrpbFdoXgb4VEJGR75AEpICwtdUwS7o9LSHt
         rRayx1iB+wivCAoEtEfWHymB3r+9SMueogckl+clyXeN3iJXsVEC4CiAQljqnlgXttN3
         29ZDQOQPc4sNFxvBam9i/oXe6/Z1W9cSxaN4YuxbwDD4TKMnyhYhPrkSW3wwVo+Dwib4
         Y6dRFAE77VNPdGyo2Gx36x1JM2s2txqNALhPz050YrF/hABzSt5Ux2hE3DGA/Z7x4PYB
         ckCom+A/GKAR92QazjD9ORQeEeFwIwmTdgIzpXZ2fJAmaJIrBxTni5rGp+0F8LTpkZ3z
         pDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780186490; x=1780791290;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6WHUv35EmdQ4QWk4JR3Y1fgG/+v8aK/cHw1Gj0rc90=;
        b=QufWZAErp+zkIgN5D6c/AwJ/YwteOGdcopt1sH9uJTV0DzpcaI+I4G1mEuLctHLj3d
         A5sRHxgtYCk15B8oevk2wUtqJ0Mq01tm3/ADguTZxTi+Cmyoq0MaVBjkM9Z0DwxKA5l6
         5jMI50Gh3ZWoYWOf06vK5gowTlnwGdvplmbcIPlJBhM4kGvXYU29t5Q4s/jQDz8urVy1
         mgmfY79euI+4O6d91+1bsb7409DidhAC1/51pNhuKTnP9T9aO5yZ/3+b4NgxRn6oMfnK
         Pqf25QWSF4ME3NBS0DhqmMDiF556v17KDePadBo3PUeZZ8vaBRn6kPPpd82/tIPw/FmC
         vShg==
X-Forwarded-Encrypted: i=1; AFNElJ9Jwp119pS+P/CvEs9QTthX0aIGtrQa5G8jUwoXU+NA6p3mmr2ZfzncUtXCSg+PqsEVVZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIZnB719gRIR45aHvpIniepcDENSrOQwt3E3MI4z6oNMwXOdC
	B5mhpVG1bsDpS8K7GUOlb2hGkqMyLSi4AGLnDFRjCTdr23KacCnskeZJ
X-Gm-Gg: Acq92OFswvqMw4rq9bbFMxx/k8stlv25lyIK9BQaImwqter2Xn05Lmot7Rr7wqGChEP
	6rKe07KbmQ6rMom2UGsw2efDj+4X7+ovM+7NGWAheLVm8ClcjI/kD8JxuP/jOME4IQxp2dijNfY
	QDAbe+xE/4Zd+OLn1TDIRNZFfIs6iwkTtH4aUSKDcW7pxBPjR24qAR82fl943BEt9DkiN4vfWdH
	f/1CMqmM2YzrgHlGxpRUHZ+IYAFxYp8BdKNqDTEUQr2pjOHAqYFSmnglDQn0YBWopGW2vmEaQHu
	hRZtc23ON9sDPDzdyBimgKPaBeaJjxp92OywlN0hxYTp9ND47q87pwRubn45Z5STPSkP2RHnz4d
	8pcp7V5IJL6XLeM4iYXjuoxgG/9dWKxTTfxTjVfWTPNGacCHwKRCYYWHh8Y1jxifL9Y5lH5tASZ
	dykftK+cRa/2DDCqrR3xZA6YqfCWpYE+rrMrE804MEEj3Mtei/aIcaY+7Xffby7FE1UevwM7eDU
	GmWuPML/BvYp0XNIOcXyv1Q4LKk
X-Received: by 2002:a05:6820:1c8c:b0:69d:7a88:9cdf with SMTP id 006d021491bc7-69e10469737mr2718415eaf.15.1780186489512;
        Sat, 30 May 2026 17:14:49 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e069b55ddsm3918373eaf.13.2026.05.30.17.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 17:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 17:14:45 -0700
Message-Id: <DIWFFX9PVY0Q.2CKQ7GZGFW0TK@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
 <eddyz87@gmail.com>, <david@kernel.org>, <tj@kernel.org>,
 <roman.gushchin@linux.dev>, <peterz@infradead.org>, <linux-mm@kvack.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>
Subject: Re: [PATCH v2 bpf-next 0/4] bpf,slab: Introduce bpf_arena_alloc()
 kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo" <harry@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
 <7f62762d-fd91-4c07-9917-7d977441e17e@kernel.org>
In-Reply-To: <7f62762d-fd91-4c07-9917-7d977441e17e@kernel.org>

On Fri May 29, 2026 at 9:12 PM PDT, Harry Yoo wrote:
> [Replacing Vlastimil's and my old emails with new ones, and Cc'ing
>    Hao Li, who's a new reviewer in the slab subsystem]
>
> A bit of background for MM folks who may not be familiar with BPF stuff=
=20
> (including myself!). Please correct me if I'm misunderstanding.

Thanks for great summary.

> BPF arena [1] is a 4GiB area shared between userspace and BPF programs.=
=20
> The BPF arena can be sparsely populated, and therefore the kernel cannot=
=20
> assume it can reliably access it. (There is a patchset from Tejun that=20
> addresses this [3]).

yep

> Since BPF programs interact with the kernel through kfuncs and=20
> struct_ops callbacks, ideally the kernel wants to share kernel objects=20
> with BPF programs; however, you can't put kernel pointers directly in=20
> the arena, as the verifier won't allow directly accessing them [2].

Right. Technically bpf prog can write kernel pointers into arena,
but they immediately become untrusted scalars.
So no access can be done through them.

> So=20
> the kernel instead wants to allocate objects from the BPF arena and lets=
=20
> BPF programs access them directly instead of current workarounds=20
> mentioned in [2] and [3].
>
> sched-ext is going to use a gen_pool based allocator [3] to achieve=20
> that. It works, but we need a more efficient allocator for BPF arenas=20
> without re-writing the slab allocator from scratch.

yep.

> This patchset achieves that by enabling SLUB to allocate objects from=20
> pages that are mapped to the BPF arena. Since the kernel cannot access=20
> the BPF arena directly (at least for now), SLUB always accesses objects=
=20
> via the direct map while BPF programs access them via the vmalloc=20
> address space (kern_vm_start).

Right. This design: slub via direct map, bpf prog via kern_vm_start
is done for performance reasons, so that bpf_arena_alloc/free
can do page_to_virt() and virt_to_slab().
In my earlier design I used kern_vm_start based addresses
for both (slub and bpf progs), but it meant that bpf_arena_alloc/free()
needed to do expensive vmalloc_to_page() translation.

> Given that BPF programs can access slab pages in the BPF arena=20
> (userspace programs can't, see arena_vm_fault()), one interesting aspect=
=20

yes. had to disallow mapping arena-slab pages to vma.

> would be to make sure the kernel avoids panicking and falls back=20
> gracefully in case of errors in the slab page (while maintaining=20
> reasonable performance, of course).

exactly. that's what patch 3 achieves.
slab needed very few changes to make the whole thing work.

Don't confuse this slab-arena with orthogonal work to
introduce call_rcu_nolock() and typesafe_by_rcu_tasks_trace
to remove bpf_mem_alloc. These are two different things.

Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A63A7582
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558105; cv=pass; b=ddrCcei6dbkPmUpqyNqQF7ryWfLhGPZmgrTGM1R+5TeIH3OlDoyNKx/4IyllMNachu5fhXIDtg7V5P//jd0/H4UQ2F9j01IXpReExokVKgSvPj6S66Dqe+wrEhsW93nhtSzqh8+5HbtWcWIRZUk4vwuZYUb45FOJjKeHCbeu6xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558105; c=relaxed/simple;
	bh=BO6I/yukamIKSkYlpU9MS9R0m8D2lMIA7Y4zW3jxxaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNJKNXXtr5IXcJGe9EwiB8m72Y5ZcVLo8MyPkNpS5Ld4L6zL1V0o8+0LKkG4qBZ6Skxaesg/5coHo5AL1FJjk2+S/E+EDZdr1CM3XCcjZ3ecnIcrsc4XwxjkTh+4JFClFL2RsY1unlEopUYqwyTifiWNq/CdUsYRhN14pItNgsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXCW07Qn; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXCW07Qn"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so3328a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774558100; cv=none;
        d=google.com; s=arc-20240605;
        b=FEDpsjFDXQtKqWCejAJtRR5GVe2gEWqxEor9m7swJby8MA17YMxeqkHiycdwsKJrch
         ViedHt0zVgFZxNndRM1GYU2dIXi3Cz/PCGp04Hg4eLDZflLDd9mfR3+bXhKJcYzVPzMn
         uBzXfUMhCJikT/lZ8GBPeD4rTChuDHb/IoGXaOdzjI6R++RFOJGGRZRM3TSe6OE+ENdw
         afMmp+rVTIyIjey/4NXHMPfQT+0mFwu0aPATNlsaKBRfVontak03MO2lGZlis/oxc3ZO
         7pYGDQGOgtzsdj5Xli3wZaGEDCT9DnMjn5Gljwd55TsciaoyIcfgbnZDxep9Fl4UuQkt
         Ga6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FM6ckp+68IcxeglLaEaLrNIkWIjcigeiQoeOq6MhKHE=;
        fh=3c9i6GOQOk+Z9kYWcUIL55Jwkg4S8xoGioKTT2DA0+Q=;
        b=RPZtPaq39ecYPge4ZAKm5pMgAyCAHv95hL1xzlYxshBl241N1tjp0oDIz1dh4VV30B
         M8pCcA+XIwXnmJHXBUo0H8rMv2YlkhqautoFpnuEGL8eAd494Pooy9lx2MGSL5hVrAwi
         baGy/d+IqaRwVv5o+Yamg/xQoI2fVWoDXjXk662EUgcCulD6jxkEY2OUrASiX6iMt3Ut
         YCqey8ogbGnqVS1zB0C1ggCcUlIyStHBFdvCVz8yWz0/i7QbUwNUCEncFE5+X3hrNnPG
         7jdly1wxt+lvmJ8fkqAFQG1DejhB2Gt9Lpe2J97SAd69qlvoC7quSKVONkh2bYNSMt8Y
         nwiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774558100; x=1775162900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM6ckp+68IcxeglLaEaLrNIkWIjcigeiQoeOq6MhKHE=;
        b=TXCW07QnH51a2xnLzBrI6rxrE1B6zA8nnP+txiUkD/o9fp7uyhqxqeH8zGxS44+x/W
         GRSxdue7I9pxwRThu8iwmTHoVu89BJ2CvFMJBylSwVwQsOGLLfrNASaYWv2KRE3SFDWR
         z/wcKUV+O3JStwVmklA+HplLtkn8zIugiodVCZzFgEGRrF+UkCKqO5Bs0O6ZkRXWD4Xz
         qIiWmlURVz3Y+Hn+u4nlpesn/v2JgKYvEF12zpMo+AwTtPuXIypMcmlMSYuxPgDJE15u
         RRTw4pUIp+Z14Jp8ymvzQDf6TIywKIDy5ZXrKvkH/GglhIMaAYKSSptsiLmY0ZdUdZPz
         nN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558100; x=1775162900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FM6ckp+68IcxeglLaEaLrNIkWIjcigeiQoeOq6MhKHE=;
        b=lAe8le2dAvAAInbDKpjrnf6GqxM+5dY12OOMVu1mpkIW55Fma982CVi8CvTdniGDy8
         Jz7zyHX2Gg3YKJvasvkyQLEHnoWzxG4JZDJFGUHWqOEX1LCioQ5d4X66KS0gjyYvRgeO
         +KLQwLk3lIK7AeyQtu1UhkOeUWd4hAnp0n35LFfIWzGN+Md88fXRghsSYXe/iW6oMwUt
         HB9xupZgPFTNi7C91qVMEZIQGIvSCxXfQlkvG5SOEtI7+gOPs6iY49XGKEfohrkgmqhu
         tdYifBUpKz+TSBIN2EBCXvfBmuqmynDOdG75C9l+s7zgLpTosTxFu/6m4iFp+8wRiOKq
         zAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnuYgGUfzCmrH0do6pNfiQGcxjqL5zCPYZLXtxwJkvM0NacObrU73Ih+HC5rBiv/9w/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XrZ2D68L6aELIn4y2sikDF1rw1pKCbL471ZF95HlhYJRuzVs
	yim35GpKU5/8hzIuvQzUQ0ONTgP1U7rZNzwFwhgtEmI4CCz1tiJi50GfZ91gXp+G5X5JUhIuhGv
	h/RN/qwoBv4TeaWoAZ/2zWGs4iFB7OoMoDs4n76Hb
X-Gm-Gg: ATEYQzw/76UPZCZSbVfkzZ4caIAw81UEh4FonAHKadNb3XfxGhV1A/ktg1Yqe+OfDOE
	pzlq3TBP3UR2oIvMN8nwjVyraC7RqqAoziHKdd+aiy3gM/hrL9ojvNFioDfZVbEtC4wXG49Y51p
	DkZ/1WAvNVW7nOFBwqxuUJ51R+JTehG8f+bd6KIg21rRoPI/j+FJAABAqKqpMpVnwb6ybZRZ5b/
	2vyBkhB5RgHEr92liXUECf4Zc3741YTWZkusHme+Bu0XqAbqsNFlDRKT+C7s4i0CxRxBsGnSJID
	Dr9ISvMDnU/wBn7f303HUYVdLQVx0hEcTBSu
X-Received: by 2002:aa7:d51a:0:b0:660:b029:3d4c with SMTP id
 4fb4d7f45d1cf-66b19d0164emr16240a12.2.1774558099955; Thu, 26 Mar 2026
 13:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka> <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com> <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
In-Reply-To: <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 26 Mar 2026 13:47:43 -0700
X-Gm-Features: AQROBzAHA4ptrGJWFLow7x6MKJvJgvIZ9qDDLijMZz14WwQA2JSL7ISC-0-uVLM
Message-ID: <CAJHvVciAmX9OFLBSahwvXL=E+3xnDsL2aE4WKfDBFqaT1Gu+Qg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim (reclaim_ext)
To: Gregory Price <gourry@gourry.net>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Kairui Song <ryncsn@gmail.com>, Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Suren Baghdasaryan <surenb@google.com>, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:30=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Thu, Mar 26, 2026 at 01:02:02PM -0700, Axel Rasmussen wrote:
> >
> > I think one thing we all agree on at least is, long term, there isn't
> > really a good argument for having > 1 LRU implementation. E.g., we
> > don't believe there are just irreconcilable differences, where one
> > impl is better for some workloads, and another is better for others,
> > and there is no way the two can be converged.
> >
>
> I absolutely believe there are irreconcilable differences - but not in
> the sense that one is better or worse, but in the sense that features
> from one cannot work in the other.

Right, agreed. I mean a case where we have workloads A and B, such
that there does not exist an implementation that can serve both well.
If such workloads were "common" to me that would justify a reclaim_ops
/ pluggable abstraction layer. My thesis is that they are "not
common", so I'm a bit skeptical the abstraction is worth it.

>
> > - My sense is MGLRU is "close", meaning as Kairui said in "average"
> > cases it is substantially better, and the gaps are both fairly narrow
> > / edge-casey, and very solveable.
> >
>
> This is a really, really bold claim.  So much of this is workload
> dependent, and LRU has decades of battle-testing while MGLRU has barely
> been around 4 years.

Fair. My basic thinking is, MGLRU is enabled by default in some
(admittedly, not all) major distros like Fedora or Arch. From that, we
have some various regression reports on the mailing list, but to
Kairui's point, nothing that looks super hard to resolve.

Then again we can always be surprised later / as the footprint expands. :)

>
> ~Gregory

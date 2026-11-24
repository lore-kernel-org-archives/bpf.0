Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536364;
	b=FfYffkOHBPvHbnR0rxYu4Y0V/hUIBehHbsF6YlxbLIJpogxPWADAqqJnTtDv1eM3jA6u
	 M+zu8AYlAjGmq1t+5HnvqImv+MUH0brdM6QL73d9OURmIwizFcgsdwtncJr/17fh9qQw8
	 pFGst+lMyJ1T3l8bhYthqArtjw33Y6BSPLbEdWkk3qhllM4A18FutFIgVDpANS0AB4I/6
	 bDfUh50RS0OuKXS7/heQPScQq6zRMDyPrGkbakhoXx0F5MkMRYMzvgU/Jn39HEibaYNLQ
	 egEjjplCaR10ZQ60BIM5f0QaDvvaGPaA61G6iDvJ3zsW/WN/RsoNUt6Kzge9dcGKA5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
	b=2P/hmqyRAKk2C+DSCpv37Pw+R+Hg9pg3VRDqXgfDi7iSjUkIARWgyNR+q8eIUNeNPTTD
	 qoTIXv5jOd4jdyDEJin3BzHOc6UHVdwcFDYRtBwUZzJg31FL7Gy0cj1OOm/Bd2bAsnwiS
	 shoLh0i5WHntdzfc/EAvChir5qIGwru67Q+MwNEzZsTnYQOq+c4hGMVJhcK/wLZwGd5cL
	 pE+BgkE8lca8TeHs8xqi3M0dZZ5F0GAC4uoEDBRxMcD2XIl2kYU55uILjkopUA3fvdomh
	 Ud0zhFMt36pRN64X3vPGdyRYftlFqIINuTExqbs0/BtGpt44w6ZXFgtDHug+cj/K7iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="E/NXh2oE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C01606A334
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C01606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E/NXh2oE
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso10376769a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 08:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536362; cv=none;
        d=google.com; s=arc-20260327;
        b=maq6jqKJWqB/gmG7zHbTOCyU5f67tva09PFxLNTDumLFEoo5abvDiCRhg4aUMIQaWY
         Zn1QnJCIuhB63NqPaSCjlAVfRYVSmzxLUPYk5GpwJUQdGX7bOgmJ/mu4xWsD3m7sEL/x
         Lq9iQpuj1YGi0hnMbg4nlzZ3IIuYNLLMmQGN8rQV/v9LeFkvPRXcukiATrIaWO9F8P1I
         4BK1hibbfXzpmiaCjAsQqfCUY1AYXtMJt31AZhquHwW1btQLovWNvYAfz8ARQY+Q/TcI
         s32aHzGzeHBzkFkkKtijf6zYriHv637uO5vJFRKBZstcqyeEi4uAtJJWlTcXpzghNK0+
         z1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
        fh=YG2o4IcwMZjuzjdzEcKFX6u73KAZ6jWDDkNNKQRuWM8=;
        b=o8YoK7iA2hHoJ36XbOYmx7WULv/E6XF+wpDmlC66TCfdu5/5GYZ6dqsYemf/N/aTPu
         DN5+VkxqaVp2Ujd5Got8W1oKYev/ArKanzagIkaBMxL/tBMaRhI7R1KMi2L1ZD0ahVjd
         sMIZ9+PgMTvTJrvxjOZp1ftvxYl116f3Acmig+a/f4G4RF3Fi+EjSkaeRahMF+o5GiHj
         /jIxe7Fekus1M4HlWO41UT7wK4Gf73yGp52+zuLzzymIGrOHsl3pRA9cY0jR2UjZxaYr
         pHRnbLDaUD1on8TkrUaBoR/3Fb2K73DiJhar8En+fIVdrtDlROFiHXn2ophcjxB7AzPS
         m8dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536362; x=1796141162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
        b=E/NXh2oE2nEKSp1Nk9q/YlLPFggcAo4/RYF34vpQXstWnUL0v9VAbvpcmp70EeBgRn
         f2BF2jCWaA6bR9UN9EbZhPArzSmequgjr85BP6axfLkoDByL2qJCOW4VTUsIEsSfL2Nc
         TvwGUu8yW2CsGVHAMadwAwe8lxOiepnODue8PfCUkQmOVjnAofnNBX/ZtMaZyKark1Ow
         aF1bEwFqlKnP4bdaiVJWN4uVX3KqbQ+i1nWK57JbtB8lnUyGdTofAuhyGbPuCoC6mUk6
         I9y81VSMSAAVSUB/yIk6pqj8o9M8SKaUGemsg4aNAixUxGGz9k0DHm6ck4NpFQ3YVzhH
         VGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536362; x=1796141162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
        b=YW2BwTlRwS/yVTLd1TmWzSGpc/JC6Tqh2Lhm3c1RaLKXEx28W9IRw3i1SrocgO+pV9
         f6I++T/ErxD9DW4B3EG8jz3OIEnIO8dZm59oaJz/D/sPfsZ3/Gch6ZATB6LSP9tQJxR6
         Vb8zsJau5B4KsiExzSjKgFWiM9gZOAvvc16q42SJDgrOWzpxakUBEi4iVx7TBYQunQYL
         7MLFP5/pFYj7MJQ0TpjL9XP+nVRkdY0nB9UW/NY2aTwpMEyAOtXGRb3UaRaerTCUzHOo
         EDpPGYwQcONLWT6cwZ0gzH/D2G1ffTol4LayHzck3h0BbXOWx9xKmKlItjVeRXDwPn0h
         YzEQ==
X-Forwarded-Encrypted: i=1; AL+hErF8DhhBv4hJI2hsIUAsCruIRcdwKolgPVNBXiz+PkvqINZHIswY7ConspfyDbCPs92FkBg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oSkiNLjxKzyJ1rfEyQh78+GJ/V48prfOfFQiIoOy91bvbMx+d
	eDR3GU89a8nOkFSbX7IU8b9zOgk7FLclhgfh0oDr+Gf4SxbOdq6Rzm76uZkANo/R1ojJbsSGGBW
	D+mW98H6LbcH1LUR2MZbSSwr3zSaJSX0=
X-Gm-Gg: AZFdTZfijxujegYlgaTFfVhxkqRlvfWFvIvzIWWNU1cSvCPP9x0UpF0FbLHYGmqdcer
	WnJH/V7j+NYkaa9vvVflYCb35usmvxkNfo14nTzigKNystyTjnbm99rszvoD1eeahrs67R3YoiP
	eT4LovcyWKptIM71Ft1QQ7jGcV/twPIxpiMridgAscCnUL0Qv4X7V558dfuVumAX+NkVm8vlNsF
	Ns8UTenIByRQE8CiVEETr6OM+3t6GrJgYb6mZ9n9jmz6RghvFZOkXTaLaL6gJWdhUpnbvxt8Yhr
	7ki8c/It28zTtPqwQIUrhRZ4Pq9v8qK/rFGfsmug4Yl43x9Sy+NspzFwoRuLZz8a9YSFOCAGRYT
	DPfhUjZsNzH15BD+r6ZZ1A1lEToSsKVtACKQ=
X-Received: by 2002:aa7:d1c8:0:b0:6b7:37bf:13bf with SMTP id
 4fb4d7f45d1cf-6ba1fadf982mr9292482a12.4.1795536362117; Tue, 24 Nov 2026
 08:06:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net> <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com> <awWz3nc_b8x3mIXq@gremlin>
In-Reply-To: <awWz3nc_b8x3mIXq@gremlin>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Nov 2026 21:35:50 +0530
X-Gm-Features: Aa3M54pSMtL_EaeBSS6GmhvCgL293XFN6RiH4uS7LjK9j2GLa6vMCzrMZ8KZVJQ
Message-ID: <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> > that RCU unlocking move you don't need other_mm copy and the comment
> > that comes with it. VMA won't be freed until RCU lock is dropped.
>
> Yeah but they can be reassigned? They won't be _freed_ until a grace peri=
od but
> they can go back to the slab and then allocated elsewhere  right?
>

Yes, they can go back to the slab and become a different VMA.

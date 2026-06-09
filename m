Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64C3F1AA6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029549; cv=none; b=gQShaCcRiotAyaulot+UpZyQDCZ9qgU/gqMEBPjI/KAsUgz/1QBMIBLHk22dZyQoAdx/RyXxm1n/58lZvoSE5uvOSUR0xhrqAUIZoHb5r87bc5KzLqo128wXmoVzCsMVj72y8iCWEWcYsvJAV71ZrcDSmabSJpXL3CC9RG76UM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029549; c=relaxed/simple;
	bh=NbaRYw61bOR1p7MXHPpxV5tZ5SxZ7OVKFA9zuWc3bBI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cPZKX0zWCT+eQ3A056CpNq6sMM0oNyyyHRZKeVjMJGeL1pdqJd9G+avBiQLPYC74DK8MW2HR9tYwHEtT4IHKdYVRwOkp1PjOS7iu7gcWLVqpA0dp0ZyGFegN9YVsmU3RwTWEapzXWNWtxzw9N59JCcNaZ/UDSUi6FInNYHZMnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paKFfQJ7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paKFfQJ7"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-486118ecd5dso3687029b6e.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029547; x=1781634347; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq36UDZ4+f+no94YaPKFhTgujqNZEmF0RCHQTwYwfLg=;
        b=paKFfQJ7l0Lt34ba/EksYnOILs9hi8o3WLAADFWe3mHrdA8M2+wiVbJ9UD9R1uY4FG
         1JJY+vALZMI8yH7is3U+Vdfcvr4rPI2rjgbOk5z++TyolQwYk6uUu6XkFH5al9K7nYkJ
         UzzlEzSm6FvCo/w4ovmKCosDMR1Gfn98Nyt+HI9TwPMXCNs1js52wVkqCFWY6HMpU+ev
         jMJkda5FSPCCehGgmc8SupnHrf/j2eXQ3UCUGV3xXuqVL2/AmBYBX80AlTqBMDHN7a26
         p8WacltV5OrQwckkuJfYp3T5fweJAM1xe4bvBaHUCT9IG/4thezqFq4mxhU/CPw26/2h
         KqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029547; x=1781634347;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oq36UDZ4+f+no94YaPKFhTgujqNZEmF0RCHQTwYwfLg=;
        b=hJC+YVYqkal5rAFSMAB7OJd4vznt3ImhEUpdRQSyKflUmEGuO0srMGgt14TUWgsxzk
         V6xmeIYyOVqA4qJv5rNHT3coCR51Wmjcg4KkDgfWeXqkWTlDMvMXfOqC1IuSZovSqqg8
         ylTatebTBb+XogRrBpYDlq0T2aVhwgloODq0eGX0fy5Op+E8qSBPQO2ocqhcAtPrKZRE
         G2lZ27HPVhkNjRlFDwf5YV4TI9SGqDAn5LXWRDFDXgTdBk+CNBidmj768He8HBDe/lNq
         mkr7VQ0hG4F1+d4EbjeQMx223BDbqvKm1zFMwMpn8CbOrsGC+8SoB6j7029tnS6pd+tA
         U9AQ==
X-Gm-Message-State: AOJu0Yz/FDl/pGZOgn8If3uTEpwnwBB7b7qg0AMX0CVvyfTmI/PXCnwg
	h+DvTemTOlpmPm6532i+0f3LLRRB+1yJNsbUyPxBD9qKl35zsiLcr5El
X-Gm-Gg: Acq92OE9n6hDbh+HI8fFP5X8yuzcEHkewEZ72cLaEbYHFTNu3G6i5+JoNKr82kZFLy3
	YarrGbCdDcVJa4gBDY+sYob7rPTPKEaiyu/GGHjpCbjP5I+SX66tBxAMfRkzlpLqAXN+VATNncE
	9n83GsA9AT/JSzQXCsILLDp6VJF2mbuVzuP3ljBr/j4HxLwMC5DMrmnsxueLfuZd+dInDz50Xu5
	j3WoXUGuL0TprMcdB+DNYh/BCqM/enJEgyVEi6Rbs3g1Enduri+80dWdxlTC7F7nAcWZeGDhjE2
	Kz3DTYNdxxV5WIk6hHAJJXFEVePQJsalltmQi7cKWzsr9tUQruD6gvLGwmY5FOmVMhHVnDhiu/a
	e52WDHZCiNtj76DyOwH0sNOzHt7Jph3EQvZCwpx3PfiP3L2uH70Mfrnv4c7YfXElakPikLM001q
	L3HHaTSiIvu8TucMKvyh2tGfKlVZsSrjE98m64H6PGcxXB7Fp4I71U97x98O2K7GeGt0C10PLtI
	rqicVAJGXqjogDWCbDjvh6JbDB7
X-Received: by 2002:a05:6808:181c:b0:485:29ad:d1a8 with SMTP id 5614622812f47-4868deffc25mr12406135b6e.36.1781029546614;
        Tue, 09 Jun 2026 11:25:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b32f372sm16380233b6e.0.2026.06.09.11.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:25:44 -0700
Message-Id: <DJ4QA5I3YRHJ.2C8RP02UQ0TPB@gmail.com>
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>,
 <yonghong.song@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <puranjay@kernel.org>
Subject: Re: [PATCH bpf v3] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260609105216.3536839-1-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260609105216.3536839-1-sanghyun.park.cnu@gmail.com>

On Tue Jun 9, 2026 at 3:52 AM PDT, Sanghyun Park wrote:
> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> holding a reference on the mm. On a foreign task, a concurrent exit_mm()
> can free the mm_struct between the lockless read and the trylock,
> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
>
> For the current task, task->mm is stable. For a foreign task, pin the mm
> under task->alloc_lock and release it with mmput_async(), mirroring commi=
t
> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
> Use spin_trylock() instead of get_task_mm() so BPF context does not block
> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> foreign-task path because dropping the mm reference is not safe there.
>
> Race:
>
>   CPU0 (BPF program)                  CPU1 (exiting task)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   bpf_find_vma(foreign_task):
>     mm =3D task->mm
>                                       exit_mm():
>                                         task->mm =3D NULL
>                                         mmput(mm) -> frees mm_struct
>     mmap_read_trylock(mm)
> 	// UAF on mm
>
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v3:
>  - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
>    trylock + mmput_async(). (Yonghong Song)
>  - Reject irqs-disabled contexts on the foreign-task path.
>  - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
>    falls back to mmput() which may sleep, and bpf_find_vma() can run
>    in non-sleepable context.
>  - Shorten the foreign-task rationale comment and trim the changelog body=
.
>  - Fix the v2's whitespace damage.

Pls use [PATCH bpf-next] subject.

pw-bot: cr

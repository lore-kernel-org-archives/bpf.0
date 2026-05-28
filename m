Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2A35C1A9
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003833; cv=none; b=fZBsDLex2vAmUfhm4+AE4rxWie7MSSw8rhGNmpTdLrXcJnfKE7ICCWI6ZiIdbkM888tOMR7DDoGFs/GX8aS/U/XtzdeUv5XqwM8j2mFSADdFrK12rxFirSt+4A/p05hv7GCJqSlt0GwdyxDl0kMN710Zu3nZvddZRqFzVb9NfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003833; c=relaxed/simple;
	bh=Z5fwT8m/j0scgq8nZY7qsq1dvsdBoBnzZKP0fDmds4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Gtc91lxf1MVQNgEnHOgwlNkJAQbdjqvuHsoq/x08i+awwLgKl9OUf9KiOvXzybS+MVA87RGyOs8fY1FHWvlKp3c2tAHjxUEijT/bpR4CL3SA4cgJ9R2IBNFbaicW1Q0VJXSKPtKCBHIl/Rv1qml+omq2Y6q3obyJJeBrb8bieKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu0ZIIUc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu0ZIIUc"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso11831861a34.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003831; x=1780608631; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpHrgIeXXcvDfmuKsXXjHhEfFrUsBGF9Cp2mPrCFg1E=;
        b=Wu0ZIIUc85en9tHUNmjt+lK/rxEPFaY8RvLYvA+1ZLX3L4EWBnAHHPawcR3bVi0t4E
         29l/4r953NkIMku5rjt5WtRTL1A5J9NeXsmGnytqTETg5alvRo04noF/szbznPvzgKht
         PgbpKvqwK97OSKre8gBQC0QVqhGgo3qlqyRLIN+iwc8vijBXj+1rQbCc/0IM+CgFX0Ra
         pLbrx6EN6ZIqr7GU1xpiA9gqAoUyGqrGBVHGfA3gJ8OzKxR3UEefpYpx+p8N0YXnt0Xt
         uXH3O5j5bY8kNSk4PRsW4uXbAkGfL6CwFQFFJPOgTcTfVcQEqeMGWJzdJq2HGl3iL3an
         R+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003831; x=1780608631;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpHrgIeXXcvDfmuKsXXjHhEfFrUsBGF9Cp2mPrCFg1E=;
        b=a4pkK17mjChZJmfoNrHHmAev+LbAcYe3qVdkWZZH8aHggHRbqR7Cc6kMAevzgr8Y79
         jj0ClqZhBLWLuAudYY5QEIILolSEA6GXVCXJgRDcYYbn3V2kp6zxQb8QrYLwk0lbAJWN
         YpS3RwYP8wiVBGe9kk+zxbcwkqwcGrMWzbk2lTGChayQyspuYNRw/pb/u4OEaGfLQdoV
         8jMPtHT6QDt3VDKIGmND0jT+rsxQypDPb4joGVsiYS0zxcW/ZMBV1culeYNSi7zC0Sa4
         n0rGtUn4tna750EJRe5v1cAE1ZZq0qKd0MWbhs5bA1rFSuuICHEUR9tl4eStH7PC7tTF
         P6Dg==
X-Forwarded-Encrypted: i=1; AFNElJ/QpBiIGaq5ZtOeIP/Y9MUgCsCmE/6nRMkBYc2/ynJsq7+cRTsw6mAMXHSwv2uh3L1YM+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFq8T9fNFj83g4z6eUsKaQ4RODPd/tb3RDGaw7l1RutnLluAwf
	Gx2ZipOtXUKNsrG6LtIyXpoJfKCLfW/H9EbDxzFhuAKVxZ/kDnGLsuwD
X-Gm-Gg: Acq92OFNH4esN0CGX3tQWtO3wBpTdT3uQejtVYcMrkMH4+p8pkiqs3AuMSb4SVSNKiG
	WkRQzkQx6SjHlGYJCrQ2Zgkxa9IG43uwM2FL3ficNvlE2BxmGIpzujvpJGIddgzNyrkE2QYOUdq
	c7qB5Enbsh5Wx4O1dQe5rNN0Y3xwh9sd+HopyZzPQiXSjtHYRLAMBJATMb66AI6E7Jf0M6ltBEP
	vGzTO+6l8Hyl3eo2/KMsOTW76oRZ0z1KfVxLk8j6d4y7+VHA92l5sQPw1rGx9ywThZqk5jPcrAD
	VxoG1JMnH+YG4h1vDEZg24i/QfSzDxMqGJ/LfIDfmzN75iMfgONUJ2zRhBRuDOioUPMPWhP726K
	UrtoHMNDl4e2Wwj6CxkOlDaswupvYCjaZZMwh/nonu5Va7+3VIf9x/Z0i98sxnWeLy6hc3spEOM
	zMu1ysTKjSctYxC7klWriyPXZ4HAH3lVSpeJrLAWHQ0ZYQB87K+kKde6smoF2jdgEeQvxcN1391
	dw2KgU4b25hHdQKVq9TS/26Ly2Y
X-Received: by 2002:a05:6830:81e9:b0:7d7:570b:6800 with SMTP id 46e09a7af769-7e694e30aa5mr218271a34.23.1780003830565;
        Thu, 28 May 2026 14:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695212f9asm129362a34.13.2026.05.28.14.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 14:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 14:30:28 -0700
Message-Id: <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mike Rapoport"
 <rppt@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>, <x86@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
X-Mailer: aerc
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>
In-Reply-To: <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>

On Tue May 26, 2026 at 5:45 AM PDT, David Hildenbrand (Arm) wrote:
>
> There is still the chance that apply_range_set_cb() could race with scrat=
ch
> insertion, right?

yes, it can race, but the fix is to remove only:

-       /* sanity check */
-       if (unlikely(!pte_none(ptep_get(pte))))
-               return -EBUSY;

It was sanity check, now it's simply in the way.
It should do set_pte_at() unconditionally.
It's totally fine to set it to proper page instead of scratch or empty.

Tejun,
do you mind sending a patch to remove these 3 lines or should I do it?

Changing topic. re: zap_vma_range() issue.
It's not forgotten, just complicated, since we can't just take
mmap_read_lock under arena->lock, since arena_vm_close()=20
is called with mmap_write_lock held and it takes arena->lock.
Will figure something out.

> Shouldn't we also be using ptep_try_set() there?
>
> The nasty thing is handling whether ptep_try_set() actually works.
>
> Something like the following on top, maybe?
>
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef5..086bea3f3698e 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -122,19 +122,27 @@ static int apply_range_set_cb(pte_t *pte, unsigned =
long
> addr, void *data)
>  {
>         struct apply_range_data *d =3D data;
>         struct page *page;
> +       pte_t pteval;
>
>         if (!data)
>                 return 0;
> -       /* sanity check */
> -       if (unlikely(!pte_none(ptep_get(pte))))
> -               return -EBUSY;
>
>         page =3D d->pages[d->i];
>         /* paranoia, similar to vmap_pages_pte_range() */
>         if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>                 return -EINVAL;
>
> -       set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> +       pteval =3D mk_pte(page, PAGE_KERNEL);
> +#ifdef ptep_try_set
> +       if (unlikely(!ptep_try_set(pte, pteval)))
> +               return -EBUSY;
> +#else
> +       if (unlikely(!pte_none(ptep_get(pte))))
> +               return -EBUSY;
> +
> +       set_pte_at(&init_mm, addr, pte, pteval);
> +#endif
>         d->i++;
>         return 0;
>  }


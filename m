Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDF3F39FE
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420689; cv=pass; b=HKAE1vP6SnOuuGVwzev5oUN2KbF7+ciNae0lDbkHtDOtrQ/xf9NfcoBgDZp34/t7Gfzq7Ynnil+N5+O580X26vctV/3tov8kDRFNRCBI2Wy7SqVUVQ+558Q+zUMoOsL+RExZn71EKK2ZSE1Oaf8YVU+wGL40LzudRIELMZGhE6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420689; c=relaxed/simple;
	bh=Cuy1ZYzlDHLofhVO2V7SoYtCBIZF9r09W5LEgOVW9tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLypQEY0AuJqdbrxB+AgDdWj47zRaudl1Zl7Xj2Cf8YvoXWyhqj6Qkd+V/4Vin3tPJrJL4S+UTBiIxExSDO/6tCL3NAMw1UndPg0A2XDcw2RDTkxd5llk2vpZ4q0pbiQgX9Ti4Q5UqDjcAr6QBsCiGSR3bpODkTBbD4ld3Myntc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSovQWz6; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSovQWz6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso18355165e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 10:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780420687; cv=none;
        d=google.com; s=arc-20240605;
        b=JjpjEMDtASD1Lg8WYs7KLeSccpb+R9UhrCMtIOC1biMXZrlUi58pYIa88Tz45SeVED
         cBGy2nshHjXbyMDgkep8NzIXvPVTnmn6bGlpnPIe0OoCs/FGjrn214YLTn8Gexvh5G5J
         r0tATgRjy0gDFF2zeNIEeWH/BWcFPwiLKHh9fGPcbiz5yEDf0PzBHfLwINsTgbnN8IRv
         nJ87z9EcnX5oxBjOgX9OdH8kFmIucyJYjomDt6UiK/EhG44LInYcQEIl5neCbqRWes8J
         KNRFcZv7r0DXp7NLr07xiqLwOP2l91j3VIqlilQ/LgBIf2EnSCdBnYIvgMCWKa74je/C
         xtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDwFnt2lpR6e1TlOQ3Hpe10nl9gubFxS4NYr9ytPIQU=;
        fh=9rZN+v2suJcMoN/zM6kEkkQihO0x5/snMhtOVAqHoYc=;
        b=InTmfXsRvB2gsz4J2Cw21i0kc9krH0WScY2MByEf1qU3YVppcAXe1rdXRp2z2viWEO
         pXfJ0fLBkbs6oYKCBoCeQt9qLOfK0LYgh6CyJK0/nTA74qLkDNo1ex0kcoY6OMwwxg82
         sBHuY70DhCajkmIuOsu6ppvFUzgrHc95oXNeYrN/4MDt9YVg4bikTN9aNxOfXoSnuu4p
         M33AcWHdl6IbJdnYDhPBu0YajPwgsj1MShq6OTGhIyx8ZouvcXYQnwMSV18w+TSlAfWt
         /MZdzCMzXrN3ekimEtjxprBOlmJGN8spBnzOdSmwSHre7rRn+wJTltWGpzbKsKgpFAkY
         rTUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420687; x=1781025487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDwFnt2lpR6e1TlOQ3Hpe10nl9gubFxS4NYr9ytPIQU=;
        b=LSovQWz6NfNzKOt23geySjovmhbGH5kecGlQD/rpMPPhyeyqlxqMFRZNNVaypfrHBd
         hUGJZoTTom3/xXQ6Rz+XsW6ci3buMB1MBhDGqFGvUCFSHuxCK4Xt838wNuEkxHtVS8UV
         yZwd42VAX9s7oh1rqlWWjnTr8LhiYdseMfk37OqEZ0rX6YduA5GpD7bZhC1ZCM2V4UwY
         kKdh9R/hxnzz5jBMQtSlkIUqRJMXhAEnkBBMT6+cKHcsZfG+G1AITuj4re0f0/0L6crt
         IsVwEGSdNyDwSBIMEZl6d6MC6HJNwykDE2i0S3uBNutjiDxIfB0A4b6EYjrsEfDV1dLG
         RKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420687; x=1781025487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDwFnt2lpR6e1TlOQ3Hpe10nl9gubFxS4NYr9ytPIQU=;
        b=ombF9he46YlZqukJlTBE8kvvGqYa1IcDU8J6Z7VepDDltiCo9ON18PV11r4xf7kBfM
         sxnk05j3UTr0xeA8P/rQn43msH10OJxRRWoKX2oCNtLqGCzY0DgINfjP0E5Iga/sn0kw
         kfT3HhT7PJbcFjOVqUa302J6id7BVbZNLg8jXnr8g2dImBfaGkh9LlH5Aj62txKSqanK
         +YtbviHn1MDP0zM4UtKlnCZCbS47/9WpPEkg1HXx42pWi9v6AGSEbAsa/X7+FGX6hhXD
         OqYLJ9Y4P1vJbV2WeLRaA+bShUB2teA92Kb/mQLqJbY6lVsbDN/xR+NbxpXdGOrZkTZd
         N6Jw==
X-Gm-Message-State: AOJu0YzmN/wITENTBG4+Em3oYO4YsVX0fRpKdB9i23iTBjn/M2+Ywe+l
	oSsAjzRICax7vXzsuvS2XU/Sa0pIa5gUGM9VEn/sFvuJ0q+nui7fmiRMstwYmXJkpUMzLB5EKwt
	sKzL7dE66DvCq79xMokcT9gX2J8NxJBc=
X-Gm-Gg: Acq92OEaBLw8ZkUN/XRhiv7VjTIqUSU63EL3/LAszIj8dLwRGymWeCPcAVrQUAD6ILh
	uVf9ErfTow2SsB+XtSOuvb73kR8XRnAfFQbfIFHRTd3He4wuM/6av4XYu0prYsmzdpsHSAMVHtQ
	C0V9pWfR0SWbplx8VTxJfLc2gytEaHTgsugnOdamBVWMn9TR/FXkYDndvKgTjqQkup7X9dE55Rp
	LNlnn+tx/TMfnnBDtaZXbucofR0KaBLtWqEvh+Lh9TAppXLI+1c8/F/1gJyWhiK/SD8h0spEJex
	1jom78xfjoo29aZA7tvSI0f4sRSibhg1Je7MYhxyX6HX3ukAPWlffBzUWnEauAjhVgl/v145CaD
	UhA==
X-Received: by 2002:a05:600c:470b:b0:490:aef9:aa3b with SMTP id
 5b1f17b1804b1-490b50b9f14mr10005675e9.32.1780420686539; Tue, 02 Jun 2026
 10:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com> <89920f87-3638-4182-aac8-23b06784be35@kernel.org>
In-Reply-To: <89920f87-3638-4182-aac8-23b06784be35@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Jun 2026 10:17:55 -0700
X-Gm-Features: AVHnY4KMH09YtzIOxEyKEisCim5jPQOzJv_tH2MC0NSB9YCozVfyRLw49W6OGGk
Message-ID: <CAADnVQ+Pv+-Eb1qRrf3r=3WTZzip72ScwugX3iMSp0q1v+=-5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:37=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
>
> >
> > -     guard(mutex)(&arena->lock);
> > -     /* iterate link list under lock */
> > -     list_for_each_entry(vml, &arena->vma_list, head)
> > -             zap_vma_range(vml->vma, uaddr, PAGE_SIZE * page_cnt);
> > +     /*
> > +      * Taking mmap_read_lock() under arena->lock would deadlock again=
st
> > +      * arena_vm_close(), which runs with mmap_write_lock held and the=
n
> > +      * acquires arena->lock. Drop arena->lock for mmap_read_lock().
> > +      *
> > +      * Use per-call my_gen, recorded in vml->zap_gen, to remember whi=
ch
> > +      * vmls this invocation has already processed across the lock dro=
p.
> > +      * Hold zap_mutex around the whole walk so concurrent zap_pages()
> > +      * callers cannot overwrite each other's marks on shared vmls --
> > +      * otherwise call B's mark would make call A skip a vml that A ha=
s
> > +      * not yet zapped for A's uaddr range.
> > +      */
> > +     mutex_lock(&arena->zap_mutex);
> > +     mutex_lock(&arena->lock);
> > +     my_gen =3D ++arena->zap_gen;
>
> I was confused by that as well, good that we can get rid of it.

get rid of it? As I explained to Emil, zap_gen is needed.

> > +     for (;;) {
> > +             mm =3D NULL;
> > +             list_for_each_entry(vml, &arena->vma_list, head) {
> > +                     if (vml->zap_gen >=3D my_gen)
> > +                             continue;
> > +                     vml->zap_gen =3D my_gen;
> > +                     if (!mmget_not_zero(vml->vma->vm_mm))
> > +                             continue;
>
> Given that we still have a VMA with a valid MM pointer, I'd assume an
> unconditional mmget() should just be alright here.
>
> Or am I missing something?

exit_mmap() -> vma_close() -> arena_vm_close() will remove vml
after dropping mm_users to zero.
But parallel zap_pages could have accessed valid vma and mm pointers
from vml list, but vma->vm_mm->mm_users could be zero.

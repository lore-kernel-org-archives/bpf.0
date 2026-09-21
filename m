Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA415488766
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008495; cv=pass; b=ZKYPLJb3qaQv1rnFRB8ul9071jKSgDSJt+mRw1hmKsVJQz297W0rkEAHVVS2dy7VM4OilvcCHNDPwbij3/Ei8FB2vVnae8fnXU67vGmwP8MGzmAhlX9kNkBU1+haK7o5UlXVT8qJzXrBOgscenORLRWZ1SvnjVFh6pGyWvQI7aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008495; c=relaxed/simple;
	bh=RZa0PZWpYO2RtYYJaAXJcHE9b3EbDTCKnRDPO8BRFf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDZ4w4FyUNQmxjJ/Muu99X1KUMaNPvbgg2XtUWwlq0ptoxbDk1+PE6zwfrnkj52rkrwWJVwYIIk85xID/3IOvrzeZyw2ZmmRf6/retbn4Wmy9j44oxfGvoPHvWX6etexbzXLRHWuNzg0z12+z4uPggFY4yINWPxAqp7oO7tdIU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWRege7a; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWRege7a"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-498012a61f6so75975e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790008492; cv=none;
        d=google.com; s=arc-20260327;
        b=Qsyhrr1o6YzgPIFFlDnblLs0Xe4wcXVjZmQtVuj37CIXeiaZkQr8TvKjFMXhwnu65b
         Fo3gBk6QN8biXTiNO0aHApH31rgmo9L7JcThynWCtVLcbckEt9wUW851QVhoY4msJiok
         YdiWYtpo82g+J4uWpml80r4BeNigpMvlDQfq7JbzdCvyrdtrMfUZBnuvN3DYgAdhDPbT
         zDMC9mhxT9IwmvAdmWplGbwHhh1vHPxTmngC6/NOgqyYfkKVpZDKgtOe1/8ELurdTDmK
         68QI3c4oJPIVnosUn4WoJBDyl9SYIQ4NyqIzbbdpCq4HvK96G3aZJTqNpqykmbIG8gas
         36/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HhiIkC3hMhRH+Ioe7AJ260IRJvy39gBSpZFPhpJ2MJI=;
        fh=lydnwQYA+IOxfFcwCbKOuO4gikKfgYan0zp3L6Zxuh8=;
        b=QFuS1pRyb4nOV6nOcSQZ8I42XwA1qqx1NcwiTjwipUGxY0cyDKpAhl8/0muUuhohUA
         6cIIQBoLAUWHl9Gs3pnzwNn7tB13fi4SPOkJxOM3JNRQmEfDkS9sIkUo7O9ymAI+Kzdf
         AV4BUAC8m2naWmZgKXh8io/Kw/kwvs9sdUBy72BeqP6ESHjflHMnrrpwvG0t5RBYNiVe
         wMhE+Clslx+o0l0yfzfJmACf+iP+ADTS1SgtD07TNfOCfOX5uUCUnFjQc/+xMjIuH5hF
         W+eo/pr3EmWHbk6gGU3JAZ6QH25yDc4vFis+Zo5kN1WYFHY8TG45VvY3iK0jXgH0AAuf
         6ssQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790008492; x=1790613292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HhiIkC3hMhRH+Ioe7AJ260IRJvy39gBSpZFPhpJ2MJI=;
        b=NWRege7asAENLoE94ERG0YQQhPCShO/rN7uh9tRWUC3KwIaaf0oV8OhKIvnhhEV+Oe
         fMCbn+hPCE5CYaztPlqUeWCcelsGYLE7JWMHLbUYmcS/SD3hI1cMP9Sm/Uw1x6992CmU
         r3TcDldBjG870jy96FRrfCm9cne2BD663Jv1SCHVuDrOzMD9ek0FZL6dwAy8aFEYWnQ0
         zqoM+D6r/1Gnk31zcq2elBuBAQ4pRVXJRwgOSp5jBXvj1R6mMrQ8VbyzNiUIsOHmzM9D
         uVPtdPYNaaixrAum8A/zzFhXKcgKmhYYSwaelMMPLR5IaLq5O1FSOsv6NXj2MoMH2ish
         HaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008492; x=1790613292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhiIkC3hMhRH+Ioe7AJ260IRJvy39gBSpZFPhpJ2MJI=;
        b=tOOo4XqWuB/m5qBmmAjEJ/8mVfDsmrJKtz/7Re2Tx+EmWX2LI/w5ENhAx4q5FrLfHk
         MY8tJCC40GAtKPnNtpvzCCYuyyqUHuBEsxQrwTGa0Wblh4Gooiql/NL/GukM75zWRWwH
         0u66q0kk4vdpugqZ2G0OhBYk3ObxTKFELMwb4aZ5YwfsejmoX/GxSywvuBhvhaKLKqaA
         GwQ/bQ2YUR6Xd9qgnW7lCZwzSYBCMQ39mKrvb7mggUe2w4GiIyG+lgUFpIUIUpAWkmsQ
         HLa7Km9788yFb78wZCHD57+LcJEIxBEZESePKtlyea7lP9WUfeg0s4PNc+nMmoqwT/dl
         tipQ==
X-Forwarded-Encrypted: i=1; AKwUvBziCMRTIx1kFp/jy7iGjwIu+DsFDeb1C6DvqlymVnVB+Oe3VY0ORyCXje34U332phHUMs4=@vger.kernel.org
X-Gm-Message-State: AFuF++keqcMq7Un8F0Q95t67gTMWTYS1L2QjPqU+rQ41NZqcG+wB3mSB
	jxIdv7xns+bQPkQRaEUOXTdcxkAQmnaDX6ndCGo9ci18lT8a5p6i+ALboGZmzT29r+u+Knur7CF
	HU1B4D5mf0C7v8QZBNkFHrtZ4DNmyEU9yMyAUW17Y
X-Gm-Gg: AYBFou2COFFpZj/bIJ/L15OHhx8/EF0O0CKUdCfeBamrao84IUrSo+bnOJ1Uee+/jrZ
	B572uKYE39XT7hPR2HMDhFcEstFGT5I70vcw9ec4XmUxr3pL4yb9It9AKu/EW6972nZ/624CFtT
	lntbGCsD1mIyXGlLk1aUC8cVNj6gsRtB9mgpEm38hji5RWBV/zdpgwTeRVB8dlT0RGK74qtc1Tx
	tsvmTfLGIbA0wFM1ufP9FZJbSc24/DM03D/mT4qcIUlu1CjueBNhH1g/y0+BnuxIfflef56JxvG
	ffK9evr3nN9FVRCMdBtRsH4J94QC7q90wcAuhlFC6gqzs4bdGxuQtdehi8MFAiBH3Cpd5JOkERb
	6JwLq5fEHZnA=
X-Received: by 2002:a05:600c:46c3:b0:49e:b733:7277 with SMTP id
 5b1f17b1804b1-49fcd2f1868mr2400495e9.2.1790008491472; Mon, 21 Sep 2026
 09:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921002206.184660-1-tjmercier@google.com> <20260921002206.184660-3-tjmercier@google.com>
 <DLKL4EZY63IU.V6E077SCBT1S@gmail.com>
In-Reply-To: <DLKL4EZY63IU.V6E077SCBT1S@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 21 Sep 2026 09:34:38 -0700
X-Gm-Features: AcwNN1X5FX0DDc5G3O8syuihKRyddOJi1pqh-uojY7fix868yCcIclMUa6RRp38
Message-ID: <CABdmKX1vF-FD4mFmmobNJeKjQLdZ9wztqGTcR4P9tSv_nEFsYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 5:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 20, 2026 at 05:22 PM T.J. Mercier <tjmercier@google.com> wrot=
e:
> > +     l =3D __lookup_elem_raw(htab, head, hash, key, key_size, &n);
> > +     if (l) {
> > +             /*
> > +              * Pairs with smp_wmb() in alloc_htab_elem() to ensure
> > +              * value/pptr reads happen after key/hash match on
> > +              * recycled elements.
> > +              */
> > +             smp_rmb();
> > +             return l;
> > +     }
>
> Is this AI suggestion to add barriers?

This is the issue that Sashiko found with lockless readers when I ran
it locally. Before this change a lookup with a pointer to a recycled
element had to match both hash and key before accessing the element.
The ordering of those assignments meant that they were mismatched
during initialization of the recycled element until the hash
assignment at the very bottom of alloc_htab_elem(), so
lookup_nulls_elem_raw() would reject any partially initialized
elements (unless there happened to be a hash collision with the old
and new keys).
Now without hash, only key can be checked. Keeping the key assignment
early in alloc_htab_elem() would mean that a lookup might match the
key and look at pptr or value which haven't been reassigned yet. So
for hashless elements I moved the key assignment to the bottom of
alloc_htab_elem() like hash.

That leaves the old key in the element while the new value is
assigned, so a lookup racing with deletion and immediate reallocation
can match the old key and observe the new value. But that is already
the situation today. lookup_nulls_elem_raw() can pass the key
comparison just before the element is deleted and recycled, and then
its caller can read the new value later after the htab_elem pointer is
returned from lookup_nulls_elem_raw().

So the relocation of the key assignment depends on it actually
happening last, but on arm64 we have to worry about weak ordering...
thus the smp_wmb() and this read barrier to ensure the element is
fully initialized before accessing value / ppr.

Today hash doesn't have the memory barrier protection so it's not a
new issue. I haven't observed issues in my testing but most of that
has been on x86 not arm64.

> I think it should be on the program side.
> If users really care then they will add such barriers.
> Doing it unconditionally will cost performance for everyone.
> Especially on arm64.

This is fair, a program doing concurrent, lockless updates and deletes
should know what it's doing and should be able to provide its own
barriers. So I'll drop these new barriers.

> If you disagree, please provide ./bench bpf-hashmap-lookup numbers on arm=
64
> to demonstrate that perf is the same.
>
> pw-bot: cr

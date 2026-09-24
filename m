Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350A3CF673
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267007; cv=pass; b=HWZwTwiXaw5cqTLySr/JjPABwMED85fAuVwql6DGh3swwbEnX0j2qjhaRyKW+PS2glyZ7ZUDtOKL1cs1GfOCr5VM8wjZfOWExbYw0isAPvSnDn6yZG7UMG03Bx5bPQk98JtisWWgxdF5jdsvA7VxywJr609Xo7my9vlRM7Aa2sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267007; c=relaxed/simple;
	bh=6LYnEnDjDCPLg9ek+kfbdZFOATFZrCp/gleIZE32Nis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYuRzNCAY9RaT8q29LhmTrYAImtHpBnEtwpZa+VAXoVhdhuPlAgbk10kLjvnacMz+kpt6+A1zK5ZUHV8JJdDcRsoS08Q6uAdVUtDPKfuFmmOHS9vwu/rBpq4Fd3snR8xg8M01NQ7iFlRj/tEgIBf6wF3Hh8hX/qGz46Lr39r8qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cTz5jQ8i; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cTz5jQ8i"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85a4329731cso56295b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790267006; cv=none;
        d=google.com; s=arc-20260327;
        b=C98Umuy1tLaAZSeXBqR+QYc73DmvhLm6H2swp1dwHrnD6rst3ulMdOliNFCZupJ7pL
         RzFnIIJWQkTQ2mbk/2ZknTHFaIBpZuTA7pbdvLOUBxm1wTI01rxsYibxm6S8vBSsOEXs
         YHkdEsMfy7qngOBUBXxRyMHHc7L0gwgXBsaCPOr32McN504T438sRn2Z6FQJhDoyV+tF
         8QRg4gmsAHgX0HQTLAF/8OfAsLf3nu+KNOkbuShln87lz/RPm3QTVwYjgmu/7NBu43xH
         bwltURaUvYWukUsxtYGElWB8U7rnUMeM/P8BaO3G0IgTI42BtACoYk92/4lEylLgS2dM
         IFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPib6yxoB1FRZrRWxa+lTjPODBOKUXazi7+OtJhcpow=;
        fh=l7GI+OjMBaTOPrq0FRKQMK04fyQoFFHNNv/yRyJSFLA=;
        b=ZGZifzWsNXMur2wJ3tl25WgestjcHUfoNp6u1YnCcewG1OIXrS1cIqhnpt1wNtclBT
         oiY75S4Sg1o+0kn4Yyjk3MnRkVknyH87Jkcs86x+FkX2tENOPk40NBCC29rZb7fv12xO
         nPKjDZoEa3GmO0ghO/3MpJYOFZNlgvR0oLRd7M9DEElOzCl5BM2IDtDcq5FYfKiGmJbA
         YERi6w2wZhPp/cwO77Io6dg5Ue6NbejM3WIK9BbM5CNSdPFaOJFRBUFrVO7nz+R2EInr
         vs2yGCnjWu2c3cUkMc+mfHsQLFP7VgN7e2czgPw3kSgyySdr+aFm6P3ZZTgRq9k9JTDq
         wltg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790267006; x=1790871806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPib6yxoB1FRZrRWxa+lTjPODBOKUXazi7+OtJhcpow=;
        b=cTz5jQ8iQ8Z9m+yXT+w/DVEkFGVLoFOwj/jk81451eLJn0jC7GwZZbvS5wmuVRufQj
         dHoFR63IaxWdYn5AJ0o5etk08HxBSFwhE1A7n2a/X+bB20HE5ewODe0OVYs0mFIFCllN
         L3D8NFr7b+B2YUUnS7uuMgwQZSpW8VeNdYFUAptQqMlZHDRPp+0RZKANON0ZQnMklqEV
         lkGGopNJFt9uhiNSDahESzw/5u53RzQQg5s+Je6/fRuf92h2aW+WYLLHBq5cb4wAGJV7
         C02xfMr45vFDqWJBAqwEI0GejAxWvAKuWYiRSYPHtv9Lk4TMCuO/sDeAIC/Ii17rS8Er
         tPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267006; x=1790871806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPib6yxoB1FRZrRWxa+lTjPODBOKUXazi7+OtJhcpow=;
        b=xO+BdclKprq+RVto+aYw+ZwFecRO7XPZ0jlSV+bbWs08J4ukKK5SpRUNAbA6QRBtS1
         PwQ+esGJOtbpNzAreJeKedbClxrWVgMoAtM2WQmj2vOpjY/F5nQgCeUwz2KDNkZ00C3+
         LKjsifCp3wGY/cQWev2I5E6AP4ANe5VQ/m3KthrPsIHHBXzHJbqf2DDdtS4ZB1D40bti
         PTD/KuC92Am+YPkzgmvcC+5HifwWhZoNfhX+nOzRzAp9cvCnN4cs8LJQMUSSyzW+ho9p
         txUD5bXhzXNv2bZ5eMSxjd9/1Bs4mBovEELqnyRV+7pFtOFmLE5dEOYhuoIEbXDKAg/A
         1TbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiWdpagU6xNSo8GWn8yxUZjCZS73eWFx6UCqIQRVv7FNLw34cYWa2r/gbE5RsEwsqZB40=@vger.kernel.org
X-Gm-Message-State: AFuF++lDBSYOZvRH/2cCuIHdwPCnLEmTaTh/2WxQEb6YGWDRHZKlB1z+
	cGsPD3IXwq+5qmBfu/NLAO+8TOIvUz2MkVN+hfxqW9gMqCEWGcTmUlCwxJAac8i5M6pBbbu3Rxz
	goAwiLumqgfD2i7PaAZAAchumvumWkLSH+nLBo5t/
X-Gm-Gg: AYBFou1i580ooBlBBSLa+L8+3DXfukiA5+h5R99kc1z5fxzdy7HPLtqrm03HzyJKYQB
	AWEccMuPxzveqaYUanwIrnfZ7OydshuPLZ0gsYsGVJ1tsNZIDkVSSvzRYY0rwNghhW5/v+lMmLK
	vIya+yXjukfpUcUIaFWQQYuuEJG9nkz8O9d5OHCadnEN1tSVqccYAuMJtW4WBYiSdV5vLLZg9dG
	r87HueH4iOx+1b5x49lV7RiN0cR2hB0oylm/w5MedaBoJ5+EBsZyxRxomicHZlzCn3B55Uj+SJr
	k3W/h2TCJ/zMkqZ2gS/ortfXrHmrvH7tV0pno73FBkmVkiPQvh1vMwEhXg5mmZfWJMfHCISlqcj
	4d05nl/0WbsDwDkn5fS688g==
X-Received: by 2002:a05:6a00:bb91:b0:878:3773:81fb with SMTP id
 d2e1a72fcca58-87e9cd0e721mr2840299b3a.55.1790267005739; Thu, 24 Sep 2026
 09:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com> <arVKSpezisxe3pkr@suesslenovo>
In-Reply-To: <arVKSpezisxe3pkr@suesslenovo>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 12:23:13 -0400
X-Gm-Features: AclHuK_6WIHuuAde2rO_dJRZdDgeEWTftPypXMJBnjHVfzkE8DO4K6tdHmMf_Bs
Message-ID: <CAHC9VhSwbHF8tZkZ00JM40VTBeXVgcVdoBt7NcX0XKaKSARWug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Justin Suess <utilityemal77@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:15=E2=80=AFPM Justin Suess <utilityemal77@gmail.=
com> wrote:
> On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> > On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > @David, simply for my own understanding, did you ask Daniel to do
> > > this, or was Daniel operating on his own with this patchset?
> > >
> >
> > Daniel and I work together and both have things written on top of this
> > kfunc. He reached out to collaborate, I agreed. We're also going to
> > send bpf_set_file_xattr shortly.
> >
> > This implementation was chosen due to its immediate mergeability (it
> > only touches security/bpf), but was actually suggested by Kumar in v1
> > or so of my original series.
> >
> > That said, sorry for any confusion about this appearing as a new
> > series rather than as v7 of my previous one.
>
> Howdy all,
>
> Hope you all are doing well and having a good Thursday.
>
> These patches are excellent and useful, and have been in the pipeline
> for a while.
>
> In the interest of moving forward:
>
> Would you both be able to live with the following: provide a security hoo=
k
> for lsm_get_xattr_slot or another proper interface with the necessary
> abstraction, and keep the kfunc where it is in fs/?

That still doesn't change the fundamentals around the kfunc: it is
really only a valid to call it from within the LSM inode_init_security
callback, it populates a LSM framework managed buffer, and that buffer
is then used to by the LSM framework code in
security_inode_init_security() to do the xattr initialization using
the values from the BPF LSM as well as all of the other configured
LSMs.  It's very hard to see this as anything other than an LSM kfunc.
I worked with David over several revisions of his patchset to review
the code and get it in a good place, I'm supportive of the basic
ideas, but this really needs to be located in
security/bpf_lsm_kfuncs.c as it is an LSM kfunc.  As we've seen there
is precedence for subsystem specific kfuncs located in the associated
subsystem's directory, things should be no different here.

--=20
paul-moore.com

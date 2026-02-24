Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F83A9629
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953216; cv=pass; b=ICS2mOA8frlMDMi/wVoQarF8SPzX8UYV+u2wbku5WabqnWxYPs2zuVhFYsMmg0mJiuxxuVjwp5muhJDqwenKKwtEXkyQrUJP27mg8EB3/rVZJP9+TWgV2aylMj+OF6MoOelmowzRAywZf8+JGjcELjRaDHrGQRkXmPV402kf46g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953216; c=relaxed/simple;
	bh=wcOJjAPE0JT0qLCFfyvYa/742HjZQ/jXz0Ob5iB0R+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0pkdBw5jcqjCAwlgeqsqp1WXuS2LPE6krcgnrRMjw04hGu+KFJjJA9fveOd70598fxRbv5lmuX+3Yv2qaO8Yd7lzQRRXcDckPGfFXWV5+9mPllqaRYzNA0ugNC6CfH1OdsGmpS0GEyR0n5VuPhaC7h6RRqGDhTiJ7zHjtTbwaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6KVlN4q; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6KVlN4q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48371119eacso68058515e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953213; cv=none;
        d=google.com; s=arc-20240605;
        b=DQ2wWk2Dbl92XZ6N3eCRs5lgyhLSegAUUVa8DZ9la2N/QzIlDuFFAYaCB1fBSUf3CU
         BVNzQp1z/jtQ3bGtxJk/IMWkd99ul4T7AjAw5xzq9jzdBSG59HQycePzYhbs729odbH0
         LAT1sKTbCUUnc1e0VosuQdCQeCc+N9Ha0Uy9owrbVE7hCqc4MMUo6iM8e98biy0UoMrA
         80omTWHU2LV91HXWgldoOk2DKdsexCAaly7q0MVu7TNsZleX/Z016Xa74lsfFGQXntBN
         xim3ezFIisVPY9344PiwXaJW+iRV1/ed2OLg+MozAn5eaxc4LwyHQGDaMSvFCjUCMHbo
         Ohpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tcnX9HllqX0Hw9TVrxhKywHJCcgvH6KhhpQUtvizeKc=;
        fh=qnrY2nADvY+iN8/LE8DX+bfND/knf5omIB6VIWDsEUU=;
        b=bn7ISo+R/ugyQfKaFhSB/XMG4ZXx97hun3WXnNpvsjc8grMZstKwRqBZjEMkRp7VFd
         yJAfKl4lJKBc/dSdSRZpEj2VtPGGNj9JpHRFmbH5JOHzEC6duRFrWVvgpPbQhs39Pj4k
         2wdF1z5C0S+KGwPXOAa1uJ4jK/Lp2FPkrvVoX0tiqOKUDgymkP/5PjM4K/xG+7Qvs6Uz
         7Lpg2vvPuJfVxKuyFBj7Rnds7RWE5LxCPCZVUwfUl9jvMJjVHzFQAd/2mAqlxq++UpJf
         y1AeljuoJytrtrQFmlySCbWCxruOwg4FVn9GsrRiw9GjNtT9PQaRKJf4XcA4mn9lLAmo
         oMMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771953213; x=1772558013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcnX9HllqX0Hw9TVrxhKywHJCcgvH6KhhpQUtvizeKc=;
        b=Q6KVlN4qgO22hojXrNegDDbOFfytnULs+EOGeknx1/Yq6QAj6UgeN4J6ICKoKMjQsG
         qKWJNsL0Bkp8xL7ykgLqEMdL/DygZXJGKox+u14fe5asNhPJetlz2TloXcpI5rJXP1m8
         ZTwh8QrOtcD6AosldwG03e/CJbgKFsE9cOycS0W9As8UWELv30ZnqAAV9uyOZu6E+BuR
         /yNmnHb0nBCX+JNLs1jdJ6n0a2HN6ZTHRyPsyP+zsoV+Llq4F5ZLeK8rcuUhIcURe3qe
         P27yZDBqmuSVzcQESe3mzdtx1I4fguSHhArnWCG6kjWpYs+AVFFoa90yj+gqO/k1mbg7
         pccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953213; x=1772558013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tcnX9HllqX0Hw9TVrxhKywHJCcgvH6KhhpQUtvizeKc=;
        b=WxQv9dpt+U3F99G2/u4XQp9guUuvxzmCEPXiaU4KXr7bbMTR81vCD43AoU/I9DCuPc
         OgL8lkJtJwEjEhwgCHhd5CIh4PkdsPw/TolbI8Cyfuofz5r2PTxaMSs2QkIE9ySGzcky
         +NJt+DfpGE7yVsA++FDhZBU3gn1d3Rzh4Me0/YhbC+D8c/f31Kr6Msu56HULhLTN7IWu
         2oxS1hTzrN65xoCg+TqI4RaNs4TuPCU8c6hZy/JjNtR/8N74zefTYiXj1UrEFX7jU3+y
         SEsNoDAg5AD617gbwdLVxM8WimFfKejCyXshfwQhHDUGfVP8IU/XfHPo6bOgrqDBj8Ah
         +AfA==
X-Forwarded-Encrypted: i=1; AJvYcCVUuFz07pmHc9xlYpS970nK3pvxMsMBputcsL7evV9cqm1eXetaY0zdTEvC2UmB4tfZEY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xbOpdu0K5FF65XBdgFYAw8P7m+1Frx0V9id4vlU8YSVGWhro
	WLXNlWSvuSNORCbfig67/1c9mTEmb64ezcztsrBI7nkvG6o360tjdDrTlxOaaoPdb2liaptlHq8
	CwtbnyvJzDhrRknNgA5UJAGL1gXO1T+I=
X-Gm-Gg: AZuq6aKYMT9PCb2xKCR6B3sIxiBpxioGBGZTtAzyKhQpJILL2qquMZ/lZzq/hOyuyAJ
	eDQqqE4/vnXD9puHKk80umCNmBdMmqGV6kHw7S213QN6HgA+Bvh0v/wbfl/gStO+KcE5wMYcGg2
	QJfzuzXDE1L/D/sBCvSPP22qjgTVwAcoavKp7jcdpeghscBmnvq4hU5Nhcvxmak9IQLlmvE3tcL
	zcV4e8eHFEhtqXj5jS7jPjBy+iaTkRkLN4MekilLv+tGDZSMJpRzmDPBrlnIt7DSobThM5Hh2Io
	1d4YB/bL3pyXH+vV24AGWGVt+N4nKk399Uj7e9tUWlsKYIa7FkSe6E7wMhKSdICbd4r23fIHnbD
	/rZPul9SM
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-483a96377b1mr210446775e9.24.1771953213405; Tue, 24 Feb 2026
 09:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220100649.628307-1-jolsa@kernel.org> <20260220100649.628307-3-jolsa@kernel.org>
 <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com>
 <aZsT6_3tkli3SPsI@krava> <CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com>
 <aZ2ZQnBHPz3UO1wr@krava>
In-Reply-To: <aZ2ZQnBHPz3UO1wr@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 09:13:22 -0800
X-Gm-Features: AaiRm53ORMryKT0X5sm_eSd4JXNBTgpQLyAE7ayxMqNU5N8GexDlTXWt0hUxTz0
Message-ID: <CAADnVQLxOhcULuV-T3KHo29rmGSdmoShA2UqyVwreKacJMtQFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 4:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> nope, the rfc had workaround for lockdep ;-)
>
> +#ifdef CONFIG_LOCKDEP
> +       mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
> +#else

The only user of lockdep_set_notrack_class() was removed from the tree.
We shouldn't introduce new special cases.

> but I overlooked lockdep config for this version
>
> > MAX_LOCK_DEPTH is indeed 48.
> >
> > See fs/configfs/inode.c and default_group_class.
> > It does:
> >                         lockdep_set_class(&inode->i_rwsem,
> >                                           &default_group_class[depth - =
1]);
> >
> > the idea here is that the number of lockdep keys doesn't have
> > to be equal to the actual number of mutexes.
>
> I see, thanks for the pointer
>
> >
> > I guess we can keep a total of 32 mutexes to avoid making it too fancy.
> > Please add a comment explaining 32 and why it needs lockdep_key.
>
> ok
>
> >
> > I thought declaring all mutexes as static will avoid the need for the k=
ey,
> > but DEFINE_MUTEX doesn't support an array.
> > So since we need a loop anyway to init mutex and the key,
> > let's keep kmalloc_array() above. Which is now renamed to kmalloc_objs(=
)
> > after 7.0-rc1.
>
> I don't mind either way, meanwhile I used this version:
>
> static struct {
>        struct mutex mutex;
>        struct lock_class_key key;
> } trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];
>
>        for (i =3D 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
>                __mutex_init(&trampoline_locks[i].mutex, "trampoline_lock"=
, &trampoline_locks[i].key);

works for me.

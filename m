Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A4379990
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221533; cv=none; b=OeOeznd7/FiTUAm3pG6Mw6e9kEtSns9EA2DDKR7LwlN67HOyq14wfMASLI3JJheZePVLAeY6ZA8F+Q01vdp5ScRxoPQ8MC2iv14kwJ/4ix8BWpM8PpBTOhhhc5Oi47xGg+wAn/ntcEqBdaLPZ3QAquU25BZRqWsKaJggXk5vKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221533; c=relaxed/simple;
	bh=+CdrG03D4SJ0nwlwWORZ1fbC1xsNTmVDpWCWb0DnktE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9dPVy1o6UugwW2MSb3+sqT8e2qB0PCc+dtKoAQhuuuHBk9UxFkhjh6ACFpJvdz17ZdDyktAORQ+HwKkjxP70lakZFiqqoSBwDnEPR5uNsc+tbIHnnIeVTRudOuFRnHRQ/PNYwGLfDy0zvPoEBGHBiy/zx+k0ADxAh1irGvYlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqKvUXpc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqKvUXpc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so14365945e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775221528; x=1775826328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CEgr7uqFDYs+VrUSGTgN6+vLN97DoqZAInajaFBrfQ=;
        b=DqKvUXpcZlj2KXmxd7qy4s72XyPob3qksmut3lliWwdZgJKj6+bs7YkV146Lh0xGjH
         hUijVwRmqxENxrGOxPEDEwQEBIyG0iHsMnLhiYjtL8f2H8AYXkFh5gG8QfejI+HMQSKh
         AlsUUkx53jJtaOup7qWtvTFFrOyeWnYI5dwmxX2YjC2GWeHfQByCviHHcKU1gMzhd2Lg
         Q+wG9Ay08y2KEuJSXfMXKULOD5yPGR9X0S1ydRvEGTvrDQFeRY6cqzlD2/O4Xb66lrpG
         2kmX7Pj3lXQL4L5uSHIzEYy7K0KAcFhXBJBUGPy8RkzwB8vPCxkGT0yt7Z2u9p/XNJVS
         CC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775221528; x=1775826328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CEgr7uqFDYs+VrUSGTgN6+vLN97DoqZAInajaFBrfQ=;
        b=SxGz/P6pYzsksjWxkrQz0flXhIipjVE8TuSoDcrp6xfNJn1w/qenDpR7gueIvx4zV8
         32CMDyA19Fm/OSfVR80OXjA5TmyvLoKxVXX2S8rxCjG4TK4UDD5hqv7bxsd4QDBOMjU9
         fAkX+4Iuch1df/poV6PtVPU8Mz0IiBOK1m6DGVtzzwEP0qmzEKSGLW5SSqvmy1KSxlQ8
         qXD/UrXwMR4bdG5C4ch47H6JcE/1WTYOwl4L7LK8maq9YUutuuG1Cu/3iyKAXLH6bE4J
         aV1LjTeUZnmAX1hhDvQ6E5p84U409LqJt92lSzNqtnbzLR+sxx7OsukTndM2Ec80TqVv
         +96Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWq0wBLUhljmeDYTK+YnXrTNliF2rcDLrIRM7JiWI3fMzlFY1S9dimlzTHbd3lvtR7DNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6t8/1rUtdsf6UkZDR6FIE3Ydv82+f3ZszknZ9+tARijSNu0h3
	ZdnQgMv2dO0kvxaOj0GxCYVzroFXDYSH0zLOabx3dhbxZpQXT5GYe81J
X-Gm-Gg: ATEYQzy3a57zptA3dtj6ZbK0aNqeW68OUD5MaBfeQMXQu+LIu1u1DH6L8obxaBxL3iT
	tNE4yx9daiz1H2fHmpNBn6tDTfK1gg/zURiCeyRFgHyf+7ATn7uOWVhZBcVGWPSavOfhZGYr4PA
	/uWxPlt7SyXYB0CdpKPKjLdy0ky7bjPn/43moj4+vne60mz1Yw678VhKLnr7J1xxRMWlqiEFpLq
	8J5KIAumVoMU+VVsv0TZolngseDQv9FZ54j1hTswNx8DeOTuj0kkchUerkY5LrDfyTbSAJWFkAM
	a4NZ1ygY/E4mHO6KYXZAQcESWmWJfTDENS06QZcTxF+CxRRo9Q6SY9sNkCkiXlcizrQtyxG+lXL
	PZEc2BCk4kQpSV7ydfPDKgyQoJ7mR2wpFfSLTR3BhyHls/0X8ZQ+cQ2X8RR14kWF9tp3/HEsJ8K
	eqjyWr4qv/YzU/A5VFmlN9aFHw5LvVk7W2GGCnhENyrQcbt8D1xDdT1z1gs1msal0TGTarYDztY
	+ybx2rYcrBpN1Ic8gDB8ExS1kbjWg4sOuZ58p8NN9ODMoRdfbQYlRqoDrP1nQ7EJ6JFHxP34Pa7
	ZTYErbU6Mm49rPMYNWpQUoZXNSCEGPzVAhLj2nSX6gE=
X-Received: by 2002:a05:600c:6291:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4889946a48fmr46151415e9.6.1775221528129;
        Fri, 03 Apr 2026 06:05:28 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e1e89335f46e29e8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e1e8:9335:f46e:29e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm137338305e9.5.2026.04.03.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:05:27 -0700 (PDT)
Date: Fri, 3 Apr 2026 15:05:25 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: sun jian <sun.jian.kdev@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf] bpf: fix end-of-list detection in
 cgroup_storage_get_next_key()
Message-ID: <ac-7FQM9UDm7tYxF@mail.gmail.com>
References: <20260401192615.3548627-2-bestswngs@gmail.com>
 <CABFUUZH2COQ297MoyL5A8=Fo6eqbr7wdp=euqxFt4mY1xoMawA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZH2COQ297MoyL5A8=Fo6eqbr7wdp=euqxFt4mY1xoMawA@mail.gmail.com>

On Thu, Apr 02, 2026 at 08:56:06AM +0800, sun jian wrote:
> On Thu, Apr 2, 2026 at 3:31 AM Weiming Shi <bestswngs@gmail.com> wrote:
> >
> > list_next_entry() never returns NULL -- when the current element is the
> > last entry it wraps to the list head via container_of(). The subsequent
> > NULL check is therefore dead code and get_next_key() never returns
> > -ENOENT for the last element, instead reading storage->key from a bogus
> > pointer that aliases internal map fields and copying the result to
> > userspace.
> >
> > Replace it with list_entry_is_head() so the function correctly returns
> > -ENOENT when there are no more entries.
> >
> > Fixes: de9cbbaadba5 ("bpf: introduce cgroup storage maps")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> > ---
> >  kernel/bpf/local_storage.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index 8fca0c64f7b1..23267213a17f 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -270,7 +270,7 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
> >                         goto enoent;
> >
> >                 storage = list_next_entry(storage, list_map);
> > -               if (!storage)
> > +               if (list_entry_is_head(storage, &map->list, list_map))
> >                         goto enoent;
> >         } else {
> >                 storage = list_first_entry(&map->list,
> > --
> > 2.43.0
> >
> >
> Looks correct to me. It might also be worth adding a selftest for this
> cornet case.

I agree, it would be good to cover this in selftests. You can use the
following diff for that:

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
index cf395715ced4..5451a43b3563 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
@@ -86,6 +86,11 @@ void test_cgroup_storage(void)
        err = SYS_NOFAIL(PING_CMD);
        ASSERT_OK(err, "sixth ping");

+       err = bpf_map__get_next_key(skel->maps.cgroup_storage, &key, &key,
+                                   sizeof(key));
+       ASSERT_ERR(err, "bpf_map__get_next_key should fail");
+       ASSERT_EQ(errno, ENOENT, "no second key");
+
 cleanup_progs:
        cgroup_storage__destroy(skel);
 cleanup_network:


> 
> Reviewed by Sun Jian <sun.jian.kdev@gmail.com>
> 

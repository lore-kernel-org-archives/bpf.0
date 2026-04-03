Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE98371064
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223596; cv=none; b=mXwH+8DiJX6Spx1wWXvcq2W+xFjfsyCpDiUcNtWnpK94AJ78W1lDBZri1cqx0cVZu4l4lwH7OIeTwitV98GibxYAMDMcsrIEkbWaa0Pxl+Zb1hlSgkgtDl7gqTvD6rUDm0l/APZml++qu67+U+AZqovsDbhsFbYCmw28VOYNM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223596; c=relaxed/simple;
	bh=aKi9QvD4NSMtHGws7bjv0WFfGrz+D6piWg71vQX7Xb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3i35UCaJ78hCYcEjQTv7Z0hMCYQXHBDv/KAtbAaA4YGGN5wZrqcQ9vLZ06MEpQBInJzl0t6QRyICbHhFOKurT/5Od++vZRVPTQG8JyWWCnVFZL7Qf+r/sdcTIXbalneKCsfT/UWZnsIUxHKYuZvEPnxkJzghOnkrAEHSAZmdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2cCLQsQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2cCLQsQ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35c1a131946so1783294a91.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775223594; x=1775828394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nNGfa8v0Q0l6gW/7EM6e1IO9RvIGhdDmwz5p+PYWdJE=;
        b=V2cCLQsQYTSAcHA6zUlwBZXvmwqRuuBR9l9tli1G+kkCxw6WAXA8c+2QC1fcGWu7Pd
         kASpHyA68oaMzK1tOlXPs5CZylR2t0SwLFCLFuUjB0+98HQAyaDIAnRP0WlSCLkOczdS
         tByoaAj25DJs4KqyjLY2t7Mzd3mSa3XBaFz+akvKrpAAv9VeTwZ5hqFwHPKR6MLyqg4M
         rAyfWRE9MscZKBgWgfnKyCW6JkjX6MTwvJpx9WorGt7yJ7Rhm4mCVjvEU8BFlc1brizJ
         C9ImWx2m5/4HWeI9aXm+KqwG0yKHYO6dqxENN1F+3W1hQj8Bq68O9Mf05z63RCa9/5DE
         +kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775223594; x=1775828394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNGfa8v0Q0l6gW/7EM6e1IO9RvIGhdDmwz5p+PYWdJE=;
        b=UDbpXvcssR+tApsOtVZkrsEBfraMPMgTe4HqlhLd8C6Bg6gJ/MX5qVdkQcE/fA3Rus
         KmiQtLFZMErEnvNhN9HBLoRn84s11Q51yXXwlnjaYXTJ/PbXxuKpCvPXkrIvYglUra86
         f/r6uw2UEPIrIAkNxvgLr3Wgis+IjVW53WOYNcHsRmNVKZt70dvhy+fAyIm96fkwjv5a
         VnQ4VI97FYVQVhRH/KujLpHxRD/zBpsx81oZVxJfYFu1aXGduWdTWU46UWDHMoLNPiIZ
         ALmcqFjO/BD0m6fb0fT72QMFOdMH8uKfYa5GdqdRsmfoGd7VjYnssMuMb67TTDVkI4Pp
         JfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLHPR1ZTR8/1K6/lksiPlo6s/4bd137vZ50UQspdFmVZzm5hJf90nL3r/pjUgA6OGyws0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+6E04vdg3k0l2b5i3WT3AGYVJsa0oqvejAvDvynR1I+Zc6He
	0ZO9GyB410NW48SjiagUw5mypUs6A67gHu7bhQpGE68K0A6eKeMB8M/d
X-Gm-Gg: AeBDieubVXWF777GVx0dNktOfd3Da62GRMPnD1Db0cRDKcfesYaQdIxWUJSczyx6XXN
	11mWxTy1dLb8c+VfYJ/TKFvkpzJ0M3QYxjll+JR188P3bknfA7uIMSQTijKzbKBx+bpR0lKg1Sc
	eDG3TZN+94Zzf37m/JSBJwZyrUwGYu2MaRX1+koh3+H15sTSIoittpxpdVINFPg4ia0jjk479z7
	7TAAjbJMsSzonuR2FVvNhFReMwIKTZj6xdLPqRoyY3XDyKqSxRkGHRGylNiNQbUXspdLVlITrt+
	tjGaIo1RyGecMiP38XCGY/475v6eGQL0ZHv7k3Na2TgL5SYupXnMGO9U1wKW4zCScej59fT8Nl2
	ZOjG88hC96SsTdguVUb52qC7Wa1Ug9W6DpnSxxHERpKVL6SZcahANBz5Mg7+niRna9E+9ok0B3G
	0faHO2vAiq/EpcXgkxBfFc3E9DR63UY7sl0fJpGXzWBT3iYUkt67nKM3cy+XgW
X-Received: by 2002:a17:90b:2f88:b0:35c:10e8:1a72 with SMTP id 98e67ed59e1d1-35dd67781a0mr5970803a91.7.1775223594387;
        Fri, 03 Apr 2026 06:39:54 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm14215883a91.10.2026.04.03.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:39:53 -0700 (PDT)
Date: Fri, 3 Apr 2026 21:39:47 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, sun.jian.kdev@gmail.com
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
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
Message-ID: <ac_DI5edNfHp8NOi@SLSGDTSWING002>
References: <20260401192615.3548627-2-bestswngs@gmail.com>
 <CABFUUZH2COQ297MoyL5A8=Fo6eqbr7wdp=euqxFt4mY1xoMawA@mail.gmail.com>
 <ac-7FQM9UDm7tYxF@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac-7FQM9UDm7tYxF@mail.gmail.com>

On 26-04-03 15:05, Paul Chaignon wrote:
> On Thu, Apr 02, 2026 at 08:56:06AM +0800, sun jian wrote:
> > On Thu, Apr 2, 2026 at 3:31 AM Weiming Shi <bestswngs@gmail.com> wrote:
> > >
> > > list_next_entry() never returns NULL -- when the current element is the
> > > last entry it wraps to the list head via container_of(). The subsequent
> > > NULL check is therefore dead code and get_next_key() never returns
> > > -ENOENT for the last element, instead reading storage->key from a bogus
> > > pointer that aliases internal map fields and copying the result to
> > > userspace.
> > >
> > > Replace it with list_entry_is_head() so the function correctly returns
> > > -ENOENT when there are no more entries.
> > >
> > > Fixes: de9cbbaadba5 ("bpf: introduce cgroup storage maps")
> > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
> 
> > > ---
> > >  kernel/bpf/local_storage.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > > index 8fca0c64f7b1..23267213a17f 100644
> > > --- a/kernel/bpf/local_storage.c
> > > +++ b/kernel/bpf/local_storage.c
> > > @@ -270,7 +270,7 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
> > >                         goto enoent;
> > >
> > >                 storage = list_next_entry(storage, list_map);
> > > -               if (!storage)
> > > +               if (list_entry_is_head(storage, &map->list, list_map))
> > >                         goto enoent;
> > >         } else {
> > >                 storage = list_first_entry(&map->list,
> > > --
> > > 2.43.0
> > >
> > >
> > Looks correct to me. It might also be worth adding a selftest for this
> > cornet case.
> 
> I agree, it would be good to cover this in selftests. You can use the
> following diff for that:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> index cf395715ced4..5451a43b3563 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> @@ -86,6 +86,11 @@ void test_cgroup_storage(void)
>         err = SYS_NOFAIL(PING_CMD);
>         ASSERT_OK(err, "sixth ping");
> 
> +       err = bpf_map__get_next_key(skel->maps.cgroup_storage, &key, &key,
> +                                   sizeof(key));
> +       ASSERT_ERR(err, "bpf_map__get_next_key should fail");
> +       ASSERT_EQ(errno, ENOENT, "no second key");
> +
>  cleanup_progs:
>         cgroup_storage__destroy(skel);
>  cleanup_network:
> 
> 
> > 
> > Reviewed by Sun Jian <sun.jian.kdev@gmail.com>
> > 

Thanks for the your review and the selftest suggestion! I've incorporated it in v2.

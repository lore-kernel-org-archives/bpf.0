Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4823B2FFE
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973829; cv=none; b=ZszoQsdyDHE8kcsqwXnO6l9DLGxEccpTZMcx66IgUGv86gmbKcoL0h6aNPUgSnbJ/8myXtNwZeXDjzblOG5HzkQ+1f4Txlajylb42wtfmvJdmd+xZv+R54vlxO9APSTa3u1/xxJrckmOo2KFkKAtrg9q81iKvllb2e5ONxZGWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973829; c=relaxed/simple;
	bh=qtFHO/BM+YE6Gkk6IEwx00UhCp28YpfdUTDilTYYljU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBXJq1gNY3VWwDXeFfssDYLTgBVlNZZ2G2DsIcFsa1XK0XOzhN6IOrnv2puwa+UMzqE/ZkMym2wobkreaC9UN8jHtcrnlq4uRhG46OTOyOqs8y6xq84PDqP82N/kwqFBY2ghoaFTPNiYO/gYeIjqCoPS3UHiKds9Wzl/Wt3BJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2fGXr8W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2fGXr8W"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d146705b4so135242925e9.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973826; x=1780578626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+SdT2L7hU9gJ+Dd0PzWymlFBpyy3grhRiyJOo4BI54=;
        b=H2fGXr8W+abfjaD8Njb90MdsiIum4hrjCtQvp0E+AthHbp0RfZN+C448G/KEr+pW/7
         O7e3fz3KqXNQj65wt9D0AW/6ufNBo7anj2ZXxJ4YXBVNtWoUqG/3ltOwXh4MZYqiDC1w
         gsipn79oQeWUvWO5sFv/8h8J/zaBXk7k10jrPA4MQcBij2h4Le1g8wSV7CXi6Lu6TEUK
         2h8znoufsmH9B4DriwXFDIkFwrPhPkv4zQNk5LKsEkGlC9i2CZiKG7mWyKzT6hjoNJCf
         FkOXmEw8ULXYHZ5CawyKUFoHJNLb88dvRs/FMI/WaIRD7xDhTPZICkYQo9wxKXMbisbJ
         IQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973826; x=1780578626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+SdT2L7hU9gJ+Dd0PzWymlFBpyy3grhRiyJOo4BI54=;
        b=kCf0VmEcG+q85i3Tc+2UsfxKBQtu/Ws9WahLjDLoLirgM+Jmymn47k7076OpwLwUkJ
         BTmfF4wF7yfY0Fvk9Orno5FVdFSIUc3EG2Ea2KAeOu1TLemNFIAZa8bg3UEaTniYH4Ut
         cON0tF2DHj3+M0drZTn0ADFWlzsom1uqTxecvhX+6NrhZUdzxVie1xKZ44XGLIZM9/aW
         ycxg1ah6/LiPMpVQMv/auX05b7pJUCmRElJ4KJADgOXSMqWejwphvWi74F63fxxBCjSQ
         km7NAzq5MNEZulKnJriK1p06pvGzbsNHw8ZALU2nMUof9aj5rUrfbAniQfOoL8yw6HRZ
         Kkyg==
X-Forwarded-Encrypted: i=1; AFNElJ+68c+2QFEXw1MJm6I1N4J+2FZ6j5iDHrq2zovgp4qHghABWNZ46oq/ZcR3qCHku6dtcQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzusdNw3kEsPMjx4mBEe892Iwt8+iLwfpi0a2ctlC6tVTx7NAGg
	3XO12Krtk8FylwifUvkP1CuTR2mvr5pQ6gpHbdLy4UOLgn41b5Vf8WHe
X-Gm-Gg: Acq92OFgsO5IUqs8tIi3ZkOyiwURaM1UhcCDVACf2wPlYCi+59kxhqDoPBm9A1ubIIP
	TUyd8AOuR0ydcHsD0rWGhqP9w5mzldeQYEfpXtJ+PnPl3seGxZZI3dEEFMsteo7kKO/ZqrZKPHq
	79kZnFEIiz2aBJEwPwR6zMkMXM6j2/eDAWMQgFkPMxQJR/nv795afiqnl9OBV1dzw07jct7Jc3M
	zbDjs6+/sf09rkddKjniF7J8Ox/mvYVbTFZKzL/04uOMkCpFOLXYJ+lV4c/GEByySWYlZO/ch5+
	yOaVTWHt9Kp1T6FtLmBK9kWlkOnInJTyXEyyoiXl9mCYczh9WJCX0+NYhKvPMEPOXxO3Va7oEb6
	NPDEf6Dvq2sMDpbWQgpTthF3xb5drZViVGw5qvmDO6lgcjDPMpVoBPhwLNCmwUKhd533iEz9p04
	sBHRaUE7Y2yrDhjkuBQQg6dJhnUA==
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr233211255e9.23.1779973825507;
        Thu, 28 May 2026 06:10:25 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092657a1esm36833465e9.7.2026.05.28.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:10:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:10:22 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv6 bpf-next 22/29] selftests/bpf: Add tracing multi
 skel/pattern/ids module attach tests
Message-ID: <ahg-vl6Bhh2hxFm3@krava>
References: <20260527113951.46265-23-jolsa@kernel.org>
 <20af6dea23834f831d06cf601a91bf8848d78091b46a913ed1b24302576983e1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20af6dea23834f831d06cf601a91bf8848d78091b46a913ed1b24302576983e1@mail.kernel.org>

On Wed, May 27, 2026 at 12:59:39PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > index e290513358d9..746a8398211a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> 
> [ ... ]
> 
> > @@ -241,6 +250,96 @@ static void test_link_api_ids(void)
> 
> [ ... ]
> 
> > +static void test_module_link_api_ids(void)
> > +{
> > +	size_t cnt = ARRAY_SIZE(bpf_testmod_fentry_test);
> > +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> > +	struct tracing_multi_module *skel = NULL;
> > +	__u32 *ids;
> > +
> > +	skel = tracing_multi_module__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_multi_module__open_and_load"))
> > +		return;
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	ids = get_ids(bpf_testmod_fentry_test, cnt, "bpf_testmod");
> > +	if (!ASSERT_OK_PTR(ids, "get_ids"))
> > +		goto cleanup;
> 
> This new test calls get_ids() but there's an unaddressed review comment
> from sashiko-bot about a memory leak in that function. Looking at get_ids()
> in the same file:
> 
>     for (i = 0; i < funcs_cnt; i++) {
>         if (!tsearch(&funcs[i], &root, compare)) {
>             ASSERT_FAIL("tsearch failed");
>             err = -1;
>             goto out;
>         }
>     }
> 
>     ...
> 
>     if (err) {
>         free(ids);
>         ids = NULL;
>     }
> 
> out:
>     tdestroy(root, tdestroy_free_nop);
>     btf__free(vmlinux_btf);
>     btf__free(btf);
>     return ids;
> 
> If tsearch() fails, the code sets err = -1 and jumps to the out label.
> However, the out label is positioned after the cleanup block that frees ids
> (the "if (err)" block), not before it. This means the cleanup code is
> bypassed when we goto out, causing two issues:
> 
> 1. The ids array is leaked
> 
> 2. The function returns a non-NULL pointer to allocated but potentially
>    invalid memory, which will incorrectly pass the ASSERT_OK_PTR check above
> 
> Should the out label be moved before the cleanup block so that the error
> path properly frees the ids array and sets it to NULL?

yes, will fix

jirka

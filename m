Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35F27603C
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124571; cv=none; b=J2zJ+zkSMPA7iMjwu3G6ZKW0uOPKlOjRHiFkrgcNncNLfbHdOhXIZYzjbF7kJze1MdUOac1/d+7ObG0CRBBpr/rh8tyYQ1yR0AVXKjrYCYxXBS32Tynyuiwsc2Vl5R9I4XMSQMinG7/IXC6xlGFO9LyltjLacFTCtzKZhPpBmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124571; c=relaxed/simple;
	bh=OvYPEeWWOCgcnGFDoNFhYb7bWcI6Jz/ZEJb8J/xjWEY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSaeI6y4QxD8yGC0o5PpRvbQqPYr+619uGEYnvWQqcqWpN05Bs1QrLrGoWOQq7PkFpFlx09wY5EVAhjLws47ts8HO1SwW8ISw4EIPqSPrKqitrQHcnghGWq45aZcSdtqtkyKkWYo08yGk547wjtxv6hGUtTQdyvaYA8bsIg8I+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMhNzA+d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMhNzA+d"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4631679f204so2542658f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124569; x=1782729369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxjEAfo9rVA/G6O87lJFQjPSDNrdm9bCVjEuvjNHF0Q=;
        b=eMhNzA+dItMzVtbtNxBhtc4GKAHa4WRIeJEAgDgS16f1HLeMF/JKw8EvyR0gK5A85F
         ejamALXxApNAwZlto6U0+RBnVYpWDKpD2zKtrjh2X7Jztbyxbf/mss50VG55lMR5bqHA
         PieRHcf7p2w7Ku74n7bioHHNA1MC1/z1QKaa/5vSPjSnwdlAZwUk8sguv46IW26MLTvq
         ds+dzr36Aoo6l5W1NlMlj9B2uA7cX+X3x0zV7vtRTblKaWD3b608h6QcR+t6gIwvSH91
         kz3YG4fHhVmoukBmT15aM8dykYK4EZ8asIM+/M++57NzaaJm7DIxrSssRCdALkYKxuPq
         IP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124569; x=1782729369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxjEAfo9rVA/G6O87lJFQjPSDNrdm9bCVjEuvjNHF0Q=;
        b=jrsazP7NopWbm27J14q+d6C6G8o6o4kyszFwzc0nvswu2WhnK0nFTt5Thw9TB0CVQi
         Dag1Ji++BlSH7HrG/oCZ3EqvpV7BZwITOcKVMNLmzQqfv6LG4+e6dILQh3Fe83TFuUhm
         xGE9TvBxXUX8w6uVEcxzfizBsmx6Yz8vUI3PMxawUdCQzNQT+deMQprJcQsdGAzie4lV
         BFdyUEe/X1Br0kq5E1iK2ICm939y9rmbrPb/OvuBgEpBYllbKHQv6DxXAshQZXMqXrlr
         Lfx0AjPnhtWLh3l6AQnj6dwVTxlUIwnGvEXy+iY+2mxkG6qvtx5DSEVw7lLh6vk1o8hL
         Whhw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9HapVKkt2tdiMiSzNBnqaF8j15aDnkoZNCRY1+tyQBw3zsQcJOcoFdkIkL54jLtGG6d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVR5lnpGFAmXYgOEuWHz9LSiRnz87XCy0gqv5wpOVEktX5ui3
	Bp+4dplYG/Lin9kC/SFEnSB/bhFaBBadfHBMbE1EeBAPJrCV+hSqfcK8
X-Gm-Gg: AfdE7cmEr1etvDvx/A5ct6Cmxt1pM56R+T5u+8oFc+EeG/lEXd8/ytCwLtqzNJC8pE6
	Z+p2rNFoQW1KA4hSytV/6py5UYi78JfXJJCs0RjF8AiuNPisIWLbGp7gKG4ou4eu4QWNPRg5e1P
	H8aCncJ6y5uIbSdLsWRUoTeO6M1JEygcU+HapOZCjqLhyaEX9ecSzVHk1N6PLlcb3uAmK8cCJSr
	XUWUnY4f0bAHBCA+kDG017BgQA9Q3bv8ersswwUXIvpmAnBspoC2P+yudflfKco00TIyCGfEq67
	li4fSEw2MUs4fYEj1XsSbH+TyhzGJkyBJXH/SJPnF2EAxdKdon8T10Axq32Wt8OS+IwTtfvzA5m
	kaAMltuHI63iIDheEb5wlvW95WBdnqqlnkOiVn/+SxxXB6atWO5Q0P4IFP1giPkBxcmUbJ7FTLY
	LppSi0
X-Received: by 2002:a5d:584b:0:b0:463:21c3:dc2a with SMTP id ffacd0b85a97d-4651bc7c252mr20784378f8f.1.1782124568542;
        Mon, 22 Jun 2026 03:36:08 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5ddbsm26412655f8f.12.2026.06.22.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:36:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Jun 2026 12:36:06 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, qmo@kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tracing_multi link info
 tests
Message-ID: <ajkQFjlb94newiT1@krava>
References: <20260621204524.61067-3-jolsa@kernel.org>
 <cb2607f92eea9b6470e906a22ad2148eda290f6f1389d6bebf155075566f5c33@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2607f92eea9b6470e906a22ad2148eda290f6f1389d6bebf155075566f5c33@mail.kernel.org>

On Sun, Jun 21, 2026 at 09:31:45PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > index f589eefbf9fb..969f04ee9ac6 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> 
> [ ... ]
> 
> > @@ -396,6 +413,224 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> >  	bpf_link__destroy(link);
> >  }
> >
> > +static void verify_tracing_multi_invalid_user_buffer(int fd, const struct tmulti_target *targets)
> > +{
> > +	__u32 ids[TRACING_MULTI_CNT] = {};
> > +	struct bpf_link_info info;
> > +	__u32 len = sizeof(info);
> > +	int err, i;
> > +
> > +	/* Wrong info setup (ids != NULL and cnt == 0) -> EINVAL */
> > +	memset(&info, 0, sizeof(info));
> > +	info.tracing_multi.ids = ptr_to_u64(ids);
> > +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> > +	ASSERT_EQ(err, -EINVAL, "tracing_multi.invalid_count");
> > +
> > +	/* Smaller than actuall count provided -> ENOSPC */
> 
> This isn't a bug, but "actuall" is misspelled here (should be "actual").
> 
> > +	memset(ids, 0, sizeof(ids));
> > +	memset(&info, 0, sizeof(info));
> > +	info.tracing_multi.ids = ptr_to_u64(ids);
> > +	info.tracing_multi.count = TRACING_MULTI_CNT - 1;
> > +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> > +	ASSERT_EQ(err, -ENOSPC, "tracing_multi.small_count");
> > +	for (i = 0; i < TRACING_MULTI_CNT - 1; i++)
> > +		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.partial_ids");
> > +	/* check that the last entry is not populated */
> > +	ASSERT_EQ(ids[i], 0, "tracing_multi.partial_ids");
> > +
> > +	/* Bigger than actuall count provided -> OK */
> 
> The same typo appears here.

yep, will fix both

jirka

> 
> > +	memset(ids, 0, sizeof(ids));
> > +	memset(&info, 0, sizeof(info));
> > +	info.tracing_multi.ids = ptr_to_u64(ids);
> > +	info.tracing_multi.count = TRACING_MULTI_CNT + 1;
> > +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> > +	ASSERT_OK(err, "tracing_multi.big_count");
> > +	for (i = 0; i < TRACING_MULTI_CNT; i++)
> > +		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.ids");
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27917285330


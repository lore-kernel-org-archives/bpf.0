Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DFD2BD022
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756675; cv=none; b=gThG3BkMoeUY4P9w/1c5HC4vqTJauielwE1wN8iH4FVnGt6cfguhQ7d4HATw0Pw8zPvhGyzi8LvOJTP8oXHAs61juddAO76fJAitAhpFwhYOKvBTzf1bESR8xVpICS0cEeHDkAm8NmQDPy5ED4K3J1i7AsDU//9DGoShbBPdKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756675; c=relaxed/simple;
	bh=RD230La4T5zS6bSsPVnmoRyZMssGn7Le2a10mCPDwHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjockdQ9O3CB31xkG1SRN5X4OeRHHoN+4+5k84mzAVmGHFFxniO9w0D+Jb423c52md2YEHSe3hYrAWJ0Be3l9w3osoaNokx7CmfriMu7fxlowSDMdSgTeYKIsuISaK13TcbBTanK6wkwLdwwAH/FRxoWQ6Ohfu/iw2VXQDgI9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anw96Wa7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anw96Wa7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so72443385e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772756673; x=1773361473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/eTNFi/xwiGKXwQVmEN2TrEIBTwrbYyspKBl+zGmAI=;
        b=anw96Wa7VUXYf73hHr4Rv1BnlX2TFrAL7opE2b2jx/MYz02pBKS5ArNMO6hFZL6KCa
         jmUr6fguDOutigh+T8vSlpBgxfJvzZgiMrrMForqzV+yALRTH8EP9y9hSlXIvFTJsxad
         5OthJ3i6KQa2Rqa5vuFljbG8034TnKYMAZbtg2i69x0KVJf1yMggr3zH/Ga7Swe4SC/R
         bD9sisFbZD7pavUGgi3rjJSGlGuk1k0NRxkx9O0PQuldR02EblNbufkqh4TBIJuhagm8
         FA0u+pQxJQYJVBqq9pOFzoghc9O7cxiCqp6hCdLfIrbAWL4YsZLuLF85ToJULMBb6TiU
         uHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772756673; x=1773361473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eTNFi/xwiGKXwQVmEN2TrEIBTwrbYyspKBl+zGmAI=;
        b=vko2wU7yV+xn6GcteC6ZawK0tyYvZH72LJFWveWjpUp0qiR+kl0p1/Yg2/twR7vHH0
         MAhO37xje8ybkAi2mzR1u962EPguTS2bQmGMD4GI13zlXVYR7pBCHNZ5JjU/9BtXDBoe
         q+piHCViWxqinkRgpQWUBRaTY09HbZW0GFHUSIppNxvSMHd0Y1xf7zrfool3bZ6zeVxj
         R06qlNo4jWqn/S9+jHD6qTUeGGySHCjRwhGkdE34G3V0G7Y/Y4kWHrJCFfgNMat1lN4c
         ndiB4O30yo0Aw7OcMYdnD5VQfQDT0M1dcnkfMuC2ZmVqRawk5DFNpIzJgFAkKaHU37qI
         +9IA==
X-Gm-Message-State: AOJu0Yww1SBNS4iTrh1cVVNy2IV/Tud7P1hfyucop30KRmj/Nfdzb/Zi
	i+hR0cVQ6zl/aeWGnHXD1zegpecQ6035eKbB2PR0U2eRXgdV2sGBE04l
X-Gm-Gg: ATEYQzy2tqn4D98/iyr3AqBrcGidATeHjUutrDO7IdE7/W0H58UdxEsSPK+ikYOuAL0
	a+ptrJ3p9YY2yJ7IuDSthIg5H7lWOP66g0JhPaszNa48Qg96+4N44XjiKACdiFvmEyjz2Kke+Df
	xKaz4WaYL9lx62dJxd0gzcAI6FDt9nFLlkelE0tJTJOihpahF84mMxWJ1v9dVG02LWTBUBTMAgg
	zdABOQyS2eDvvlbCt+0FL8ae/vG878liJI8LwK1sjQ/552hL8+cyNUPCX3gVhYrwjKdGOPbfkUd
	DKVk5dWmMQU88sI3bI9B3I5POOV+/n5d5NA+cnLDnHduBM+jAnTA+o5KJBYiYhXAD8DSSeYpLap
	B3jdd5z+dqWfreCTRNXQ9RqyGFHWMvFUkYpcFODcydAdHtHYtBB4SxBAS50FpX8/a4Z0HrmnhCh
	3ICViFnwoa204tX+hJxLKcJ7rfOyVVx6my8o/K4oedAS1NXmjeddNHBqUAzTf5r0d4+c6Oi8KxK
	1YlO17OVEdTc0z5G/hVLOaHHDUfG7JwV5Ix13G4e5khk3uL7ejMdKVmEYkOXB9Yph7GvH/rf3s=
X-Received: by 2002:a05:600c:6085:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-485269304f1mr1976005e9.11.1772756672639;
        Thu, 05 Mar 2026 16:24:32 -0800 (PST)
Received: from Tunnel (2a01cb089436c0001b77cc3ec8ba0ad1.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:1b77:cc3e:c8ba:ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470a1c7sm5589355e9.28.2026.03.05.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:24:31 -0800 (PST)
Date: Fri, 6 Mar 2026 01:24:28 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com,
	shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <aaoevIcblUpMyN3U@Tunnel>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
 <aaocJ3gJr7019urU@Tunnel>
 <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>

On Thu, Mar 05, 2026 at 04:18:42PM -0800, Eduard Zingerman wrote:
> On Fri, 2026-03-06 at 01:13 +0100, Paul Chaignon wrote:
> > On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:

[...]

> > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)

[...]

> > Don't we usually put changes to this file in a separate commit, as for
> > test changes in general?
> 
> W/o this change the reg_bounds.c tests would fail.
> So far we tried to keep selftests passing for every commit,
> to help with any potential bisecting.

Ah, I didn't know that. Definitely makes sense for bisecting.
I probably broke it at least once :(

[...]


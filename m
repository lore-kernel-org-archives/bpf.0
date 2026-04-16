Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8314E2F2
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311545; cv=none; b=eNTCbs2h1qkgQpzhhLnKStAWcvqbjGPwaxCx5nS8iik/h9UTny5P+YcXE+t994s4a2gwKGgT1s8my0Wr0jhGdE6ol4a3/dHzM7K6olQNDt6ab5IhZlumr7gBG5JUcVsgttYECirtMT+QTNtYeBVpLEb/Ay6XYw/iNya/m7vgKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311545; c=relaxed/simple;
	bh=7mGLNt8XZoSeXtXib/4qKFKZCeJvVb7e6J/RuDNeats=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5unzKZmDiN14LXImYPVsimzjv6F99OKrKtUhpF0K/sg+/hS1wcioL9rrbA22NulS9KQV65+OEc0n7Yoi3hyp0X4nTE3wborYwzO3Ahhcf2MjA+9TFa8dp9OaKbNUc4b+HDJmYIrAJdXxDCWoRbdSgFKuuYvEfRLGZr9RxYTGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P0cL358k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P0cL358k"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so51821165e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776311543; x=1776916343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxy4ISURN6SPrxzf1y9O7oo7RTv5hr80c2wq7jKTKV0=;
        b=P0cL358kvReQGCpi0GZxpUVMIaciFivj/0T/l6ItKuJuOVB0s1Q7u8nFVPPG+LR5aF
         6ir1BjviG9Vhnq2LKTSfQvKzPfic90OwVGgrEzMKuJyCTnKoZp/kuvwKqKvjHD2F93dM
         apVpn7xTPpwvGDIKGEgtrZXHfTGTur9eIBgggnweeOepvBRwoEGM1/IN/u3XoJQHdlcn
         adjG2JXMErtwHi8rgS+EZ/GfZsJ75/k4FN3TOr5/QwzTn+3MR7E8cR665o+sZpoQSIB1
         nyl9L2uEGuPcJgrcGo1HesZ2KIw99bq3oilg5/We2ao3RamzoSbNxBt0rzxidaSqDGpc
         3O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776311543; x=1776916343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxy4ISURN6SPrxzf1y9O7oo7RTv5hr80c2wq7jKTKV0=;
        b=HQMQDdVl/tG+XThHi97+SMTpue7GAvjPfPhq4E51da6HQGCFQWz13plAyv5vldef1X
         xAkxk9f5J+IZFKJtwb7N1w/UfwBw0J88PL62MwTPES/+PfjQdrv31xQzMLtw6VhT0nxk
         8daF9lf+2xX25X+no86v5tZiioMpbkBdEw594PVEkfdk1+L5/rF0QKF5Pfr1+LC4dqnz
         KeQATTBGLwIE3dTXzyHfupYh4bZ2iVJXGVW69mKVhyJdjEGDW8hfwspc0f3rsbIQLyps
         UojBuNK/0L3oMCDaEM1bqunL9iIsjG7kdBoNFqN0xC7tgtrbuMhVu0AGeokDpiouPf/k
         tfSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RQmGNs+9NImH/cT41sWbspV1G+BOdPy/dFQ33JcGDgTYEXUG8HJ/V44RHtkUl0UHgFIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprFVIKZJGvd0aGrgk8R5Nl6HxDnIgxlzNsU4pMPuCG7vCcsLJ
	LJYrH/R7MSQI3QUjJIxeA9Znj4SLGHmr0YyKpYNh7elv1ZSGVLaN/iQOMwkV+Y+zI48=
X-Gm-Gg: AeBDieuDAsvLKJ1ipnH5TtPziqUi6kbkDfr1p3gyRZjHRVGQtt04qbJ1WeeduQIdgi6
	fOsNu8M7V5tFpe67t1IjejufFcwRipB3gX4cYA0ySmJ0uPrFuhWxdlAGzA1Vz04eTQDWxTP80BZ
	HqUyTC/RLI7Vna6Uyrsl/u7Wzz4LktUVBJpF9ydpdkQB0ESsXmxuRWgzbDrncWEJuZ65tbIoI7p
	4TVVGX8oGp8QposnpDJgz/fQQ+lGivnLs0pZaumS6E3ItoPsj1djK+SVOQMXOk/0IPsF3F5OAuj
	2/s/FzENB9x63m791HWw9kidjrtxJCpZnq/UDwrZpHB9vm2BN5cgxWds6NkHvahQJPLpGFgKxNj
	ErElNCP/7jPomG5OMwcifZOqJ83x/GuSiMF0c5EpBocjJ1msiCgvlNDrgUetj8ee1UxQusLRrE5
	jXTuZ7ScJpfO6jGHqCKkkmFynYstODowE6knAxd6WhmmGYSHCrV0o=
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr308427135e9.24.1776311542621;
        Wed, 15 Apr 2026 20:52:22 -0700 (PDT)
Received: from u94a (27-51-42-31.adsl.fetnet.net. [27.51.42.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957eeacdcsm3094084a12.11.2026.04.15.20.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:52:21 -0700 (PDT)
Date: Thu, 16 Apr 2026 11:52:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Helen Koike <koike@igalia.com>, harishankar.vishwanathan@gmail.com, 
	paul.chaignon@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
Message-ID: <7tgaeg4mpuoage626jaxu6sl6yht2ace4saog7yyx33pope7xk@kixri3atcb5q>
References: <20260410124035.297632-1-koike@igalia.com>
 <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>

On Wed, Apr 15, 2026 at 12:12:45AM -0700, Eduard Zingerman wrote:
> On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> > Unify handling of signed and unsigned using circular range logic.
[...]
> Hi Helen, Harishankar, Shung-Hsi, Paul,
> 
> I think this algorithm is correct and covers all cases discussed earlier.
> I also prepared simple correctness check using cbmc in [1].

Given the "Fix invariant violations and improve branch detection" is
merged and the original Syzkaller reproducer no longer triggers an issue,
teaching the verfier how to do better bound deduction (i.e., precision
improvement) seems less appealing than before, unless:

1. LLVM produced program show similar pattern and was rejected by the
   verifier, which will be fixed by this patchset
2. We're proceeding with cnum RFC as a whole, and this marks the first
   step (I am assuming this is the case?)

My understanding is that we just need the verifier to be smart enough
to accept safe LLVM-generated program, where as Syzkaller-generated one
is not as much of a concern if it does not causes any issue. cnum
improvement make sense because it simplifies the code, and could
potentially be the last time we have to touch 32->64 deduction (famous
last word).

Shung-Hsi

[...]

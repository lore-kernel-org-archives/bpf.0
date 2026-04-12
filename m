Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090B31328E
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776036005; cv=pass; b=LUgksZmiA8NDpE+icfRdPQDxNKNpmcTvymWK+RZnpyIE5P9o61qiiObNI1R+j9Myzsb/gVC9oqPVjSyUZVbKs/KAPa54BHLi2Ea1Ij+KJMrNM/boVZwM6catNLsjTmtA0G7LVFf29YforX/kZWfpKKweUMhP+gqzL59tEiylauE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776036005; c=relaxed/simple;
	bh=TnvMcE8uRlbYvFGN0ys+09YmYV1a31fs1mN93JXacAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STDb59tTzo/lwAIxicLnKd4ArqP/6s+1r5L7eh3PfOombghWwAspuYzslgkt1tIjWqkcwcNAv9dR+Ii2AVfOYFZFyBez/+ZvyI46EKH3hzZb4WIS8mlJ/Z5v3rtZCl0XPL6bHBV2Op2VVCOkqtXmklnu08Sn44Aklz1OL+kkQUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FthaxW89; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FthaxW89"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so2527655f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776036002; cv=none;
        d=google.com; s=arc-20240605;
        b=W55/mXNtaX7O8Q0qgsQ4Jv6U58/OLUTh60KY0reDhs1+mSn8EQwJaFXVIS0EUWZSPn
         TaBrVSQbvLcRTmGYAY6NC8gqNQ/guJ443Gf17uPhKCiWS2dYkK6o+hbbiRAmNvL3uh1t
         ysW3uEPfyRkqtaZ49uPR9yoUbwes4opXW0nBYMGrZ5gwY95Hld3ZhUsz7sd5LRn9qWKw
         dUdeHFC2WHd/EBjGi1wBHjFJcde2Gy3XcvC3usD03brFjv0B5WR8LAowq6ee0ZM6v3D6
         V0D38vIwI/6wO2UYjvBNYqrjKqOTLBiHrF9E7IO7UcicrBEgr2l2v+Qv2Vfkvc2GdV64
         2V/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gSQoyTUn27kTSkgVKhBBcaDZwPUxzkAvNPts0Nk8xDo=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=W6azB0O9UuHvakWORe/9JbQSzeHyQnmtt+x9MuW6qYYqjhgV/QON9CA8w6/Omk1EIN
         kfV9g/yO+W7HTobouTHU8RK5mbvAJB0yUNqKV4l5oFFYYf1mn3mexY6ktis5sA/hjX2v
         AB7/5knfMb27ooMHKcNYdBFMvVXrTA89Wn+3UDLmBDsSc2i/iWEehNvxiXdLFAarfjk4
         z7anw2NSFjsd52+9Cfe68J3cZLX1JEi1dscfnY6atRPZBgnVQVu3R24lwIrtQJ251lfW
         BptIHN9KJYFZ9d3ykxby5huY7NL+XNANUheTA55xHxrJjsaPargY+HCXdqaDYoTOL+Mr
         Baqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776036002; x=1776640802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSQoyTUn27kTSkgVKhBBcaDZwPUxzkAvNPts0Nk8xDo=;
        b=FthaxW89Ds0UmJl3G7anvTIaqAhKqbV5gGe07cizfoYlkknwFEdPkkM6gC0p44x/t3
         mSRjHgoXR7woxbK8gJV1lQpSOK3UqaxmQPJLQjq41OhkugDqzySjxsFt1tEU31Ln1t1t
         t+2MmD0tA+L0lfSXaAPLFTCZHozaLROaSjODn+DlVkzpBy6/q7iCtvYM91JwHMwf0jTc
         IiBnnZKE5vvr/no2evb9MRzs1Zh5erGPBmiwDBOxZUr4pJnKRS4ooYatHzZlzlV3wqdZ
         hR8Lna6SozkyIOiFK6xbTkFU4ozD/8f3jeJK7zhm5YAeqWBePNnfcMJn4ZuF+0V2ZZiy
         iuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776036002; x=1776640802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSQoyTUn27kTSkgVKhBBcaDZwPUxzkAvNPts0Nk8xDo=;
        b=g6spLNnWiL7DBw4UJo5VpgrZxscl7BCK8GijCRI03AfU3F0yarnTflZzNIgfGtsRO5
         rVZe5IiOt0f88SnC84Jqfg7ow9Ou+HWFjiojQOBqwA5w3dlAt/ZY/axxS0DxII8ZH59C
         oRSZ9ugTK1p6SSFcr1Iya4ka74Dxgce6TFlkzRqSDn3NgrMurf/U75NGF0G2UCkq9Z7x
         rxFJY0/kqTnl/gEvQX1ualbXcVA0GT50RDhJNECXnxzo1aYqCDHXrqRthdBqzoqsoVsP
         AU7dOd0bGOElQsVrvmJ584m3tb+/K/2XtpHTSwtECGDJvSPvyCeL10gGl2CDI9zUW+tk
         eJQA==
X-Gm-Message-State: AOJu0YzzlPxEDfGhLxIq/iwYGmj9F8udyhxiTqXE1gbpuBWDMbdAKjAb
	7lIOcrzq/ajmdobAsbqVfUuHIVLAomrM+ZaK7q3Z6OXZHIp/x8AtGKn3WSkyNv0B58/STi7PzYu
	aQhLGMiogFaY2uoT/0BYJ4PR3MYy8500=
X-Gm-Gg: AeBDiesU0bq/92hl9ppJ7sh+qfCLQuBxHJ3YaeFHuCZn4qz9mTvFAUu3kTREHwk/hB2
	5bJlBEOYlXM7m/lzwlWOMgvGb3FCUHiuFyhdtAvsQFig2JPmyOHTB1Zk+eJmqwoFXLqHfLtfCMu
	VPAV3E2OAo573lzcWzh50w6XB41gyh1sWGilrnWQ5JMGiKo0nVYD5sut+V81N9n5ZbohQ3uzDLq
	GmGJPBhDxbS2Fo30nEygb8/ltpe9Z1tT3Ekiixz4NtPI2XwJ+UvBPy+s+WtuJaBnMWC3IkVrhgi
	1AeaNgQh/YCc0EP9F3ihS4V32K3duKfZ8z8oQl+yA912iWPjPNLbmuLdIE3pVNjyM7f8Mc6x64g
	BJ7sTi0mF9v5GN+tBgbqW0eVJlw==
X-Received: by 2002:a05:6000:2407:b0:43d:70de:1c68 with SMTP id
 ffacd0b85a97d-43d70de1ff2mr5572348f8f.30.1776036002238; Sun, 12 Apr 2026
 16:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-15-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-15-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:19:50 -0700
X-Gm-Features: AQROBzBIRmm0TVhDFdIX-UAiInJSHURLH6653fOXYX4L8BYb7LmXvR3ThRlqrS8
Message-ID: <CAADnVQJ-gAtijXVdu=zQ5kX5RLAW9mesgO3A=Xr1Bo7Z_N60Zw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 15/18] selftests/bpf: Add stress tests for
 resizable hash get_next_key
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:11=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Test get_next_key behavior under concurrent modification:
>  * Resize test: verify all elements visited after resize trigger
>  * Stress test: concurrent iterators and modifiers to detect races
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/rhash.c | 181 +++++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/rhash.c      |   8 ++
>  2 files changed, 189 insertions(+)

I don't like this either. It's a test of rhashtable internals.
If you really feel like testing it, it shouldn't be in selftests/bpf

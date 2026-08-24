Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307D3876C7
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602198; cv=none; b=WrI+mbXaxTOKi2KJqbZtjXDPDNfx7nkcp1QTkj8piezH/bduJMdkxOdHNaeM0OzWWi/JyrKqUFL4vZ0hE22IjeuucGM4YSIaLVd90U6JP6HwJLKRd4u4evHIk/YprVwOJTOVW7WN5YxGKgiUfN+u1rjD9vWWgAdDr9Bryud6vKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602198; c=relaxed/simple;
	bh=O7yhtO3d4iaN174q/gULeCh+5l267X5djaLXQqSRSh4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=p2L9webglUTduJFMV+/bZHJcgIq4lUq6T7+AUP/5souWZMJE3pylihAKmdDjRN9un/McjMGtbzf0vntdqh0Wx2tc4r0ayFP873Y5mjqwR9ImbsrNEqA7M1rWtypttWvyOR56bbjI7XdmcaEarINkwLSbnGkiOUrkXgyjHpppKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgVLMsEa; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgVLMsEa"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a403027d38so2034664a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602195; x=1788206995; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/X6rfEqJVCIYpv2Uz14icNHvczQMxyvZzqtmzqLXxEQ=;
        b=QgVLMsEazBKz00+GE/qOE/3G+0yJqxF+kTbvH1Zsna4xeM8ZOdnZG/M2keJnlCqxLE
         CrGrTn5lUvKUxaHrI7ei1jQ2Rog9AqCUIz4wOo/bqtDAwL84d+W8KvJYVHu6GKQoqsB+
         6AmQ/8NmnBkuYcSH08pSS9ITL6aVY06BSn2LQyFuDKOgZlpXEmZk+M1Rq9UPdh4Flf6Y
         l8uvJnrS9rJ+mfJnsiynNufnw9xXNQQs0yPSmh5u4FUbc2IHmR9SBM4PmY199O9BFQG8
         1+UTD6uK07Hh093b0GHfveK4z8bGkwAfXFVtPdDyD86L+xorh4KmOTftiz5XOPbHgcD1
         dDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602195; x=1788206995;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/X6rfEqJVCIYpv2Uz14icNHvczQMxyvZzqtmzqLXxEQ=;
        b=hcqdKuGrGubQT0WsE/y8PGiy+yiGBChcXyRbKRSPTBMZvWuO1nYLU2VxQ/kW4NAuvw
         l+cbQQoKhEVo6eAWD79HBPko1dh8arxCwx2VCD22WKyTcYqlPki9CHzxFGxzEsP+Gd9E
         yE1rPlAck2SvZZz2A3YGMEs4D43uoc96HgscvqIgTpH7Kf9NTkUdz2CJdlagCK4OgXOX
         lejuc8jfuKJL6tCDe6ONQ3vcIPv8Cml/zlWxkGOnZznsQE9J+/Wkf4l8nA+405kuqhQl
         4lhPDHAu5oN7nbc8JfycrNMegkXhw58VyLInJ6WxuG2irAx2WX2QvxtsUQPpLstP3JRm
         CAIw==
X-Forwarded-Encrypted: i=1; AHgh+RpTL9ChZQTOl0zZzaT2tAAehNM18DKbv691WPBn3JmclxT8z6axt8LqMCxVfzNPx5RJTcI=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ4waFXxWgB3gpDsyrRVKHqKmckB+vo25RrE2P9XKhYxx25YOS
	CefL+igAcFrxWGKfe2lSY6PberapkqrvmUi5UiN9gXXLJS6F366LA3f7
X-Gm-Gg: AR+sD101bh60iY2Db3IqlYM+92nrip0W8arhlcfXWhjHUhIZD4NVpvs1XyVX4xa7Aoo
	DTo4ASmIMWbmqjBU5DriC9t4azsh2et5WIP6JcDXcuDcwdO3B2fE5JaEVVI3NInrrhtjE4yPZpG
	XejpD9A0EydHiaowtMKZbNJDniSRr8XXtvWl67IJTA8bfHiKFBBsCMLtWCPRecywVjLqhYuwS+k
	SgJDuq/fNg8GH2c714DTgc6lgnZGB897P8K6ZtI2DMOmDwCEO7mY+ho2Dm163+Jc24yUK+SbIkk
	jpl3g4Js7rlZlE2uHxaPXbgMkOqiqM88IzX2B6jZdrwRrD3AtLBQyRS13EfXNu3Bj0V2uZ1IvuM
	JG6UyOpxF+KGAJ4Xs8imXqpJbsMVq0R/mdshZuefpb1nwp4cMbzTF1LV0ov+CMSCfghCE14BTd7
	HrjMhs1x6sa32IBnefXRSHnRTV/M7m4c22rKfdPAf/zYJB0b0KyFVOU4JYEopwXGlICT0RILap4
	Vdy5qCy6feveAhNJ3HG+pS5BfvDICPoQZHo30wId+n5BE4snuALxexA2baO9uVeNK3ftFPrj58w
	oG1M6mYZ2xbGbrNxVSFx/LKdCsI=
X-Received: by 2002:a05:6402:2549:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a582b8cd2emr18739293a12.15.1787602194789;
        Mon, 24 Aug 2026 13:09:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e001305sm10841718a12.4.2026.08.24.13.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 13:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 22:09:52 +0200
Message-Id: <DKXG3AFFUMEJ.1RDMQ7LNT1D0S@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <chia-yu.chang@nokia-bell-labs.com>
Cc: <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <horms@kernel.org>,
 <dsahern@kernel.org>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
 <stephen@networkplumber.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <donald.hunter@gmail.com>, <kuniyu@google.com>,
 <ij@kernel.org>, <ncardwell@google.com>,
 <koen.de_schepper@nokia-bell-labs.com>, <g.white@cablelabs.com>,
 <ingemar.s.johansson@ericsson.com>, <mirja.kuehlewind@ericsson.com>,
 <cheshire@apple.com>, <rs.ietf@gmx.at>, <Jason_Livingood@comcast.com>,
 <vidhi_goel@apple.com>, <Mike_Rudolph@comcast.com>,
 <Jeff_Howe@comcast.com>, <srichard@netapp.com>
Subject: Re: [PATCH v8 net-next 0/2] Explicit TSO segment count
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
 <20260824130511.2955f30d@kernel.org>
In-Reply-To: <20260824130511.2955f30d@kernel.org>

On Mon Aug 24, 2026 at 10:05 PM CEST, Jakub Kicinski wrote:
> On Mon, 24 Aug 2026 18:31:37 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> Hello,
>>
>> This series replaces the existing min_tso_segs() congestion control
>> callback with a new tso_segs() callback that allows congestion control
>> algorithms to provide an explicit TSO segment count for each data burst.
>> =C2=A0
>> To support BPF congestion controls, the series also exposes
>> tcp_tso_autosize() as a BPF kfunc, allowing BPF implementations to
>> reuse the kernel TSO autosizing logic while implementing custom
>> tso_segs() callbacks.
>
> AI CI says:
>
> The bpf-ci build jobs are failing for this patch on all tested
> architectures/toolchains (x86-64 gcc-15, x86-64 llvm-21, aarch64 gcc-15,
> s390x gcc-15), all with the same link-time error:
>
>   net/ipv4/tcp_bbr.o: in function `__BTF_ID__set8__tcp_bbr_check_kfunc_id=
s':
>   tcp_bbr.c:(.BTF_ids+0x...): undefined reference to `KF_DEPRECATED'
>
> This comes from the change to net/ipv4/tcp_bbr.c that marks the retained
> bbr_min_tso_segs() kfunc entry with the KF_DEPRECATED flag:
>
>   BTF_ID_FLAGS(func, bbr_min_tso_segs, KF_DEPRECATED)
>   BTF_ID_FLAGS(func, bbr_tso_segs)
>
> KF_DEPRECATED does not resolve to a usable symbol/flag in this tree, so
> the BTF id set for tcp_bbr fails to link into vmlinux on every
> architecture and toolchain -- it's a straight undefined-reference error,
> not a per-arch/per-config issue.
>
> Could you drop the KF_DEPRECATED flag (or use a flag that this kfunc
> infrastructure actually defines) on bbr_min_tso_segs, and re-verify that
> the kernel links cleanly? A local `make net/ipv4/tcp_bbr.o vmlinux`
> build (or the bpf-ci selftest build job) should reproduce this quickly.
>
> Full build log for reference:
>
>   ld.lld-21: error: undefined symbol: KF_DEPRECATED
>   >>> referenced by usercopy_64.c
>   >>>               vmlinux.o:(__BTF_ID__set8__tcp_bbr_check_kfunc_ids)

I think Chia-Yu's AI is hallucinating, it was a proposed flag but not added=
 yet...


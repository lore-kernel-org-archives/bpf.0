Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FC13F00C
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752542; cv=none; b=jbYRFDCj0UA8eHhZ448Q9FGAWDjTpR2MbOMAWz18gypz1pEKuC3LZfcXdsHGoPTP/o4zCnKpHJeqYE+/TcM4QjlnBJKYWjQvI3oi0qDXvuE2PZhC0rpkeQPx/JhXp2S0J/Ki8FZ01hDS24EEHtg8YMpMHFf4jPRjFGX1RrTmQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752542; c=relaxed/simple;
	bh=NFXyJbYacHBoD0F5xTOouV6fnC4b31g+akIOuMV65Qc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XDGN2sCsPolxGZFHImvAgD3KId9GKS5RlhUqKo+2On2mRaLvpefDgjw87RnfgHbuEg9u8BkBUjNmo34DP0sHdgaYAlPBfMphog4p9OSBE2xDHqMQ+UmBjrSzB2peo+S5S4lNCNUGHhMpKIuoVgoyRVSr+M/lAaCrqfGlCke4wXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDiNE7+0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDiNE7+0"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e617b39877so43447b3a.3
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752540; x=1710357340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5Jzb+Wmd3SvsCQisoBy52wpRKNxdYiCJNj6t9ERjys=;
        b=YDiNE7+0KAz8tVISD5QQuHqMqXpN1FERK8uheq82/gSux+knapeWNhoRhKSIUIjuVu
         8xq/x+OYsFyuiwHqh7nvRW4pyO8/ffel6IMNSeY1G+viDkFENk7t0MQbo8GBKyDboXe/
         R/NT+Z5HP7pcHHVZvU3KCY5OScpYK7AREsRcHIXYybUdr8WU9pPrpcsMDp3y09Uyybkm
         Rrr4bDrybjcMkjtIuWZmZmjId/6uz1DwKzYbHIYb2RfCMegzuLW9GqWmKI0yxnXmwdsK
         GM0h6YsHmozba/sfqLoQlUaMoHENWUAH9sUfQAwYuctVf7UnS0ASzAW5DXx/wzlYFGap
         b1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752540; x=1710357340;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5Jzb+Wmd3SvsCQisoBy52wpRKNxdYiCJNj6t9ERjys=;
        b=Tm51uAyIom9DdrAlY0pIjiOwB+o7+jPLBQhso/UtRsFL3dE3FJI1PClPCY1iOZJQFT
         XSeNd8LroDyke+uJdiQJlW6dXVwK5GtTkL5W7JWraOs4aLfzrR2sCmEdg+SUkKHLrZR+
         Egz8pCf+TQNxkWP8bdWof9web4esyczNDoqZxoyOJNSQFrb2pPCYThspUzi3q0H95Jl9
         NTKOfaJjHxfHb9yDXbThk960K2evze8a2rfGEv09nChMmGroXQYiGUj0zdtzs7GB2uv4
         k6YLrCmj3st1n2cAcpsF/6SfQX11H5aY2Iv1f1VWFXZZfG5e1uvP37+9JCt1q6Ia3eD0
         v9ew==
X-Gm-Message-State: AOJu0YxbdTyN4SkQcsdafOIXVgjOPquMjDJP7vrCg6DMAquk5eUtHL+2
	A80yI7oKsXSfwMrYHdu6fzgM/W1s79n9d5DQMdx/KK7lfVcj1i+T
X-Google-Smtp-Source: AGHT+IGtzfac148E0Zp6HX8t1uaubrccdGVjIzwohjETkCYdKTXMXB4DDkmolGrKZo+xj5pprudJMQ==
X-Received: by 2002:a05:6a20:2d0a:b0:1a1:1e94:dd40 with SMTP id g10-20020a056a202d0a00b001a11e94dd40mr7244574pzl.54.1709752540284;
        Wed, 06 Mar 2024 11:15:40 -0800 (PST)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902969100b001dc214f7353sm12917047plp.249.2024.03.06.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:15:39 -0800 (PST)
Date: Wed, 06 Mar 2024 11:15:38 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@kernel.org, 
 memxor@gmail.com, 
 eddyz87@gmail.com, 
 john.fastabend@gmail.com, 
 kernel-team@fb.com
Message-ID: <65e8c0da91115_34fc720827@john.notmuch>
In-Reply-To: <170975102930.9518.8336084287032577662.git-patchwork-notify@kernel.org>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
 <170975102930.9518.8336084287032577662.git-patchwork-notify@kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

patchwork-bot+netdevbpf@ wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
> 
> On Tue,  5 Mar 2024 19:19:25 -0800 you wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > v5 -> v6:
> > - Rename BPF_JMA to BPF_JCOND
> > - Addressed Andrii's review comments
> > 
> > v4 -> v5:
> > - rewrote patch 1 to avoid fake may_goto_reg and use 'u32 may_goto_cnt' instead.
> >   This way may_goto handling is similar to bpf_loop() processing.
> > - fixed bug in patch 2 that RANGE_WITHIN should not use
> >   rold->type == NOT_INIT as a safe signal.
> > - patch 3 fixed negative offset computation in cond_break macro
> > - using bpf_arena and cond_break recompiled lib/glob.c as bpf prog
> >   and it works! It will be added as a selftest to arena series.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v6,bpf-next,1/4] bpf: Introduce may_goto instruction
>     https://git.kernel.org/bpf/bpf-next/c/9c4cab4e6756
>   - [v6,bpf-next,2/4] bpf: Recognize that two registers are safe when their ranges match
>     https://git.kernel.org/bpf/bpf-next/c/cc570d85e66e
>   - [v6,bpf-next,3/4] bpf: Add cond_break macro
>     https://git.kernel.org/bpf/bpf-next/c/7825948e135b
>   - [v6,bpf-next,4/4] selftests/bpf: Test may_goto
>     https://git.kernel.org/bpf/bpf-next/c/8089b99d4649
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

Fwiw, I've been running this for a few days converting things to it.

Tested-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>

Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039B2D978C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085002; cv=pass; b=K7QYByJ2LeQmkFz3mJCnlvoZ9iFmJE2mUTTYD7qBfLYyiGrwPygaCzndBU2KlY0VkxS4iJkI+U97Ykl2blS1bJslby0LFChbD8JedqfltoKxbjdrCMPP3Rw/57w0dKLDHCWxfJqrzV4tHA1Amm2FbKfHyDDzR9Vc82Q+mYV4eJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085002; c=relaxed/simple;
	bh=u8DRnlKLZP0uvCkCDUTOPTd2CTmKjGEnE/vEaEAF7xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brwSGP0y5jSjcdxuRuaZ4UT+9FQZtIK9tVBPUZXC36fvIvT6S1ukQUQ+zu+jIWDfctNTV+ZnE00xbuvC2CEhjMzqIgneNlCM5jCqpb1JzhCUQAPCUjMfQ7SRxAd/iNRcYo2N1JsfSmFpCKmc7dgcVokWNeNGvjYwNKf0oftTe+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NI527SOx; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NI527SOx"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79881805788so128394417b3.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 12:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773085000; cv=none;
        d=google.com; s=arc-20240605;
        b=jhd9qc7IS3wetzpvM4ElG179aSvDIrNOt35Srq3Nbu8NTqMeaoHOpcdfVXownv5sXj
         wmaNT8LJK+XgNYsdiDUHGwlPU+gAjjHea1fB4qT1B38CiQDlgjES0JnV8+LKNvEEuDAY
         URRRT+dz42A9so7TYZQaYOPr18gMpGAOmYUGO3isownr5bKW0xFbNb8MHnw4A/dmulcE
         sumxz11p4j98pIUeddDz41J1jRe6cDvaoOFvpfSl4q1xnqsGWDB6rd6oy3kXuViQJTy0
         IBQdtkZfX+gQAjibPiDpQk/LIo1o9haZCWnDYk5LPRl4Z/+xfRUfzcK0bqiH5AoACpg6
         /vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XF1WqDbojxivp5uBt+4Kr/NIauhmgI6WZtsBhc8uWUk=;
        fh=8FoElxrrA2m0DptcTi0zK9vX6JSJZtJuKt3U+k6XsAw=;
        b=IIsGW8c/sH095Ut3+DXgwQZdtOy/CT/cXGu7dRZmrdGWXLt2M7QZfHETi9V+QhNHhK
         94/DPnuSyZU1y4znZVjopk2YqbBtuA7Ty1K0REpFA/M6c/alND6dlTO3CmJBA2BNIDe9
         wgy1+d3cVNDGR+MDQR7uM18qy0tNbpiGu/FoDFFk0/T14m5QOPyv1Ho312nJehmQ63Hj
         AtI75mivGUN/bAovCAQcmIBn2vAqWM/I5psOG6HNpUMtcUGOr+q9XfIssJvsJNy+wfJz
         b/Le2y8izlMPi55HtBA2SjJFPwOky7yvGNflfDP/ALULeECmd0Ivtk1mGDyLfM+WdytS
         U9UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773085000; x=1773689800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF1WqDbojxivp5uBt+4Kr/NIauhmgI6WZtsBhc8uWUk=;
        b=NI527SOx3l8MLi1AjPOVPjsirntHXZdzEmnLZhPb46bhLLReGBqrecQlKQJIRCGzDd
         kRBEsRo0pTavmWBwuUgD0ar2rtTbomsA2NXNqVErSTV20+AoveaEDSzuZWLaHGgOY9nX
         Q7D62+qm6TGR6dvVaIIXJvLNz0K8HsuhQ9H1CWceSeSKEU1RjJ3APG4+7hCL1Vji79WO
         IYM9zmkJRucb22fB5aI3xvzI4Qyy0O9uoRrR4OI8417C9kl7rOkVURPASuiR/rJm3XH1
         bwOLy9uPxy1X/jzM+91crGrKLIjPXMVM/32D/jl2R/usFVFR1OoiZv3hmjMedopKQo//
         Lc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085000; x=1773689800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XF1WqDbojxivp5uBt+4Kr/NIauhmgI6WZtsBhc8uWUk=;
        b=BSHcClv7oVANC0BkESC3Ks3c/R9rn2xEsb5Pcb1L02c272oP42GUsH6r32Y3g/daRS
         PNCZZYxrNzfRXH612wNrGr7pnIdsGfQh4wxBgTEqDzvQpDeD4Y+jlq8jdrpZ15ze0Tw7
         GP731nH4JbV+8KFdbt02GlvdUZniy6oJTuXCc7X+xiziQmtOSrnlDmEaKaO3B7oTAUWr
         ALjSWkiE3Va+lR9XT3xnJxjwGo8cWsVmHWd6mWReKLEBRpIFBvt/XD8t+Cesry/+HbC7
         DCIcE5Se3+GZsKx9gJ77FlMVTJXFwlm69mBbkoL+urs+BLUL6vQjmmIJ+h2B9twIELFU
         BkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV20ef4IjCE4I9/bNxv86FfTsp2oyg7cizQWMSHZHQJ/ADLl/7HUi/wHir2PuVjhrRIqM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WHO6AhvlfPgnmp8Th3rTPmgI2Xcf0xJXK082hl0yfp5dX+VM
	qUAibBIdOZsu2cGC63YDosIOkZU5cAlZXsqysxiP3eISj+scoYzmNzHlA0ZNs6tUn9KTW1q2ZYO
	DPl45x9sUE/c+/1pTAcvXA042gZNPVkno24L/Iqr7
X-Gm-Gg: ATEYQzxBW13G95CR37Unk8aAK1oG0adSe6VFwsZqUCq2/MAlTonUSq8shsJBdAzrRg8
	RrdlzwO/E+biZFTXG6a6jbMzQauc9l5M61FKanjhD5PqRz4LRevw5CDx6luDcLsxYbvBAz6nIZR
	B/QOfa7TJZ/wZFxYeFrAOCFyQcPH8QTIKacvKLP1XhkyoOfvdoxb5N5M3jaCO+lFmMDYOhNZ8vJ
	sbmFVr5frCl0sE4/QWftPqooBWxxxIDE4fc76N8MopvRWA9u6BR3nXyvHehlZDsh9VQU41lIvDD
	LKPgRpAniNDBWRZQc3Kqjw==
X-Received: by 2002:a05:690c:c22d:b0:798:6af6:a40f with SMTP id
 00721157ae682-798dd75b0ebmr107239417b3.55.1773085000546; Mon, 09 Mar 2026
 12:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307163430.470644-1-edumazet@google.com>
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 9 Mar 2026 16:36:29 -0300
X-Gm-Features: AaiRm51rGdTyJUpg4dm5fdIAw7f4LJ-68S1FklBzNYtYa7gWm6ZnTMLGOGw67yI
Message-ID: <CA+NMeC-c8azXXVa+GEmvjhWpPRhF6wkSeRAw6TsN_vB0M0wdCg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft operations
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 1:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Following typical script is extremely disruptive,
> because each graft operation calls dev_deactivate()
> which resets all the queues of the device.
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
> done
>
> One can add "ip link set dev $ETH down/up" to reduce the disruption time:
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  ip link set dev $ETH down
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
>  ip link set dev $ETH up
> done
>
> Or we can add a @reset_needed flag to dev_deactivate() and
> dev_deactivate_many().
>
> This flag is set to true at device dismantle or linkwatch_do_dev(),
> and to false for graft operations.
>
> In the future, we might only stop one queue instead of the whole
> device, ie call dev_deactivate_queue() instead of dev_deactivate().
>
> I think the problem (quadratic behavior) was added in commit
> 2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
> for lockless qdisc") but this does not look serious enough to deserve
> risky backports.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

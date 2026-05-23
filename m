Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B2281530
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779508067; cv=pass; b=AZQ9IP30b6WPSw7Lxg5xqe1CnJ+FxHGDCsWlESBhEr0bl3rgvfpDTvYlVSakpGGpvJ1k3gnrWHGLtl+dsiQJ/pRCbqRGKJKpl61bzcH5qsEdLBU9cXnnC91MTrOuW72TrygyxcJ3Bni/cG+Db3VJflTddaBGDvgzcowfjWpzQBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779508067; c=relaxed/simple;
	bh=ki8+VA+1WGYppVcrmqZEhoCQnpgoNkRJOK+8bQJYxWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPiA6V5CgQp1BcP8Ul7pibNHNgJ9Tfa2oWe1ZpwIQTGh6jBmblDZgFWRbHzjB2E5XDIGwNqLW8OWhfB1+FToo3uHbOsM/j3z9m5Khod+PmAigZp+nqntVRKeXbezMFMRI2IjdHIyKHODh0AEk34k3q2R2qWfwGXpPMQCL2cxVSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siKxcUfr; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siKxcUfr"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-132c338a537so5208351c88.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 20:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779508065; cv=none;
        d=google.com; s=arc-20240605;
        b=QS57R7yoKUU+JijP2X5blvhqJHdXBllQgU0KFqcK/NrBOd8+BryX1Em63EhbdvDxb7
         VydDq7xZgmeXm9rw0cTzezRzq9ev1rA1tN3sf95YRDH9tAkVcwokmm+6gRBBZhPa1LmG
         6EmfL8pnfkX1V/59sJMb9UfURj5CoDaie+x7y/uiN3CtAxkmRzrzjL2nZFp824lE7QYI
         Z3SMi7arBlwKyoMJv1QUZc9v1mWC9XPERH1ovonW3iEPIbKFS4F5kLITH5Bdunc18w7x
         8249b/wMIPkUgQgKQ4yzcPkzWrRYp6vXEuam0+hOdkimGwHydojoyWe0lwFQgI44eM8Y
         Th+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IPulaD313dwBv7H8/WqubG2lSDiF9avGjFmbR49K3Lc=;
        fh=g9oekyZCzIUxbINHeftQFOzluMpzx7ZwLiU2RxaH/uc=;
        b=O9OFj6JF3jFNl84fSjAWeZu/hmqD9Jt4PxyFmp1WWY8xOyNOk3qGlu4uuthKG/5ILi
         i3Af4/xCTonAL1l+PrF5rfWmqRYMVu3zq/i/IaXgwN6/rYn8z4RnLbGvQEDwKM+fWYTZ
         SlDAvrqpVsbwg1SK/DPeWDgQ8OEfzcAph8a43tVY7DD6F/u07okO0vqKnEHCH3yIh0X/
         H+2NnFgOmm/w97rqVQ8g0D64HJ8W8fs9UojIlPLO24PKz36ulUB1slNwuagA2nxsBIYy
         uSkFQ+Ulfzr73F2YAiCi+vm9Olhlp+n3DL2444P1LFDyY8AGYwGHpdZuItuBtnif1wHn
         8PyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779508065; x=1780112865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPulaD313dwBv7H8/WqubG2lSDiF9avGjFmbR49K3Lc=;
        b=siKxcUfr0FEOgUmamvFVtzeSYup9CZgHHw3ZidAkaOKxPHeKNqJVXpRAF4m/nS3gl2
         jy2wY8oBXDmsdbK9ZAa7sd50o61AP38bNeEFSQkP1HzzAF+mxTh7R61qbOyCgyeUNeC5
         ZKnO1EALg6m81LULrVdwGwllc091RhlvyM5IENeK0osHPIWVuRYaQ+pIp9Nb2we2Ygv1
         pVJiguDxXVEhGZWNV3bTAxifeZ+oHZgvJySRdvH7zaSylTnhd7eW6Vcmx+0Gt1bhaw8A
         ouOL/6QggJIM4wc7K/TXikyMnAE8WYnj8YNrZ2KlR0AES4HlSZWW4CcIux63iECp9XmY
         V4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779508065; x=1780112865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPulaD313dwBv7H8/WqubG2lSDiF9avGjFmbR49K3Lc=;
        b=Ap6LnRfP7tupNCP0Nuo+GGtyYggeHjbZCFSCHO1RdLE3aYw84f+wh7CxLhbaaxgJ4f
         jnQmfdBV6wt3S5e9qSk7nCjbGHOIBcofWUQeYT8l7SXIehJ3dX3I9FJSSdlolHwbTiii
         3/8zO56Yzg4cSIFnhDrFycjaGO1NIwK9HpvA/IBu7SygD0NfehRK/2q1OWlI3dVCGh84
         +4N/400pQwh6t4oQzM1e9rjInhfADV7zYz1ueW3puTUffAob1idqHp5lu7I/0MT/jUjy
         WqAwbGsL94l0ozaPr6hhW0WLpRMttu/s7McdSLVLMs1lPGIjrHtO3eIXJWLRZZD0/p4b
         PC6g==
X-Forwarded-Encrypted: i=1; AFNElJ9NVwX/FTQevdVS9itMKvVX5zxmzB7+Zy9GfxQsR+8w74sY0utE7OfLrPZT6/NEUpXqK/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd2mOjjUdl3a1/eXP0KjHXWg2c1k85ppzNxIbb/22YYvF3b0j
	XtlAgiwoAjYQAc+sm68wZpGSUJKq+8QJDrFQGvlnq09T6zVkLuS4AWi5h7MZLzuWuOA+4VbowcT
	by/4+Wm8lDCW2fvhfsw9oIMDXPAxQsBEfUErBUI0n
X-Gm-Gg: Acq92OERHfLZZxKRzFXOY0ODUCUczLK96E32DfAQI9ry7sy3LM4A54gv4vYQyIYeK/X
	aJFWaII+saFt/+3aLIlKTAN8XJ3XOy8nPYlb/WDJQZz0NYwWmoWl7h2sGv//u3EryYVAOT0JnA+
	8b8gQLEyrgoZO7lOlKoowZPccVQiFQ0GrpxOrdnCRBouTnN+x48+3jg20dfnIkUYoFS2SGDaTBx
	j0rE009FfIXkqiVq3JYPbB3Gm9/RMKcDJXu3Q9mT4uIRs1PnEJCVKnPQYsb57I8jpSuv3Rb9AOz
	YEBl0vUT8X3RtVeEMnXt6mQZ/80eoPALdKLDRM3Hy/FcZIz8goaXpoZjdjiacGQdKN5BXiTxFqv
	AEeW47dJQi17nFWfQmk3ZRV8VDtXRBBwUeB39IU1DgadoGdvOB0cMqjx9pQkjxJw85ugvZBM4BA
	==
X-Received: by 2002:a05:7022:2509:b0:130:5606:94d with SMTP id
 a92af1059eb24-136334df1d4mr3469572c88.0.1779508064508; Fri, 22 May 2026
 20:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 20:47:33 -0700
X-Gm-Features: AVHnY4Lk6EpaCtz0pvldpZ9MC_C1CNLCV2ey7ROr9zO-XDps0InrqN0Dk2Tqd6E
Message-ID: <CAAVpQUDu_UXZSqGNhKKyrtR6VF53vRcM+vLvE4OV-HnrJ4Wzdw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] bpf-timestamp: support rx side
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [PATCH net-next v2 0/6] bpf-timestamp: support rx side

nit: This should target to bpf-next.


On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Previously the series[1] has already supported tx side for BPF
> timestamping, now it's time to support rx side.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/=
commit/?id=3D68b92ac494eb
>
> ---
> v2
> Link: https://lore.kernel.org/all/20260518082344.96647-1-kerneljasonxing@=
gmail.com/
> 1. support tcp rx zc case (Stan)
> 2. add if-statements for ASSERT_TRUE (sashiko)
>
>
> Jason Xing (6):
>   bpf: Add bpf_ktime_get_real_ns() kfunc
>   net: export sock_disable_timestamp() declaration
>   bpf: support bpf_setsockopt for bpf timestamping rx feature
>   bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
>   bpf: enable bpf timestamping rx in TCP layer
>   selftests/bpf: Add RX latency tests for bpf timestamping
>
>  include/net/sock.h                            | 12 +++-
>  include/uapi/linux/bpf.h                      | 10 ++-
>  kernel/bpf/helpers.c                          |  6 ++
>  net/core/filter.c                             |  8 +++
>  net/core/sock.c                               | 20 +++++-
>  net/ipv4/tcp.c                                | 10 +++
>  tools/include/uapi/linux/bpf.h                |  5 ++
>  .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
>  .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
>  9 files changed, 172 insertions(+), 5 deletions(-)
>
> --
> 2.43.7
>

Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2678F59
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273405; cv=pass; b=G2UawwMfSME+wurFYgLLlLqu154bc6D6ZcdwcxBj0BTymbjUZciNn07eH65lDL29o5VJeVoR9Lth+JHnSjlfCxjdFS20ip8ejB0DI7LRAxbufmS8y5jYfuvOo5/VIQtE3sq6Xg+EKK2221VXOjBV+KMw3fb9PMVaBkSZBtC2SiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273405; c=relaxed/simple;
	bh=sYJGqCY2z1jRki5HVPZjaFUE77i6R5Gi79ziWhZkJBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er/3JYTWJxJz6agsTMPO518BoaqLvn31pylWzCZ8hIYN6VcJVPjcoQa199TBw9S+biJhe8B6DJZqrSR+07pF7AOHk4woFLVItlPb6blPGtD3zAz4QGVJzp5NX5hS1nq7DUnLLalSHf/u+Rs8agBVBvNDV71yJSYhvUIn8rxkAy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APyijzTl; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APyijzTl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49050bfe053so63275255e9.3
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 17:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780273402; cv=none;
        d=google.com; s=arc-20240605;
        b=JrEys0yKBq0jM6e0t666VHPoANRjDmDA5zoooz+rJs41jkFRgIXq/BlVANDVYDixrr
         mRliTXTgrI1KbIF7LGjiJvOgx7dYiE239Pn/aDf6A+t8rlJq9574BYpriLfOOKPZdFEk
         GkfS3oSTlJa6+pohvi++RbGpgE0xyScRO0lDsn3aESxYc2Fb31JjHBBtDaCG6v4C6eoA
         eeiUeZvYfe2XXeu7PYu8RKcmXQrib5ccy89JY1SHhKL2ceU1EFnmwQmQIfFnkgoOxU/h
         8SOlH3PObA+wYaBS02qk9MKl2eijqzejTXKJBhOAlUfGEs8yeC2iHGKDyTLyD/qHvIpO
         pMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ra7a2d/i+ASGSsCMx5Le91H48egY+9qIP5vS7Kj0AVE=;
        fh=b7yUaLNbnEOclIhrRxzy+r62xBiTGR1RRXvrGEM8HDo=;
        b=YhADu2bUMpDp3KexncM9ZPezxz9s7AiRIlsxIv3Eekual612zEZU9bLNhAoKbdNhMS
         mtGD01tbs9K3/7n9ijACNT0z0cUIZ6zDjDmM6mK3ve92KF+LoucBq8XKbV1ph0LB5hKh
         7t7h9jRHsCJG9eNH74ZC7Jij2Rd7i1hCohP66IqrRQRpXKciwugDJMK6X1lWIOXCHzik
         hQ+j40hjA14oLai1X/adpM/pX3fX9fhg27YiB6NzrMtD3TLnSWPCFPUf8JWiPTXGvqft
         zm2kx+jm+sK9nbfSu585A6RzmU8U354i93Z8b+ofcr4wqqCaw7d0NsnFjlxU9NxFyKSt
         LrCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780273402; x=1780878202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra7a2d/i+ASGSsCMx5Le91H48egY+9qIP5vS7Kj0AVE=;
        b=APyijzTlVNnwJfygRtElglo7BpSPfEQcJEpcDyKgbUF5b2QwUeBtPk119YyrDZwRU3
         pSzW5uMG+Ut5Yhn2Ki//Uoy6NpQbVqIv5+dDGkFS130HOMFqT23UAHHjPWu+fbXifnyb
         coSLbqKCHI8PWhknWgcyNQHK8kWjRE8NPBmJgdQUPpktv3ja02ypZ7qIIrNnxPhv1jNZ
         N2jZfHSFZdTCPNuw4sWyG5H/oxJK3e393wTMExpNnHVlZ/qQwYylaOXjwRVptjsUM5wW
         vVOrFdKEBT7M7Eq5FNXTfEKdA7ztw1bsxna741VlAE6Bf18hO1kn9Inr4KmBeg4zKXMM
         mu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780273402; x=1780878202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ra7a2d/i+ASGSsCMx5Le91H48egY+9qIP5vS7Kj0AVE=;
        b=PJFJcxtRtMCSdkxzsK9DO9Fwd8jkBjCzKK4X4a4In/RokapoM4Cn7ES2JKVG3usOFT
         WEk5CjLdpQhB9M7MnVu0VhP31tfZY17DNnSaqRdMGM1i7k9FVJQ3uQFos6XGDq4X1Ml2
         2DT80dSC7MKmuh9dhMTuwfr9zWlzXAYeFd/U1a/PZSt2wW39qmxJT9/p7KgFY5oZQOjr
         /bSxpXu2ZxO7UeddL1BihGGXzyNBwFmNTfpjBir14LsNNcpk58d3SzkPk/nyj18UGBOF
         lH6MmGxMuJ9ssREenGme+1m43cmNshzkuiU/kaxbYfenBu5Iuogko0VQ4lEOPW/TEcfS
         pIZw==
X-Forwarded-Encrypted: i=1; AFNElJ96hw4rFoe9vJcPCa8ThXN7NsvghWgLerkxkwszCVccVnBYdjDhaLGVjS2FeLBhgxMmn6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YziB32VhwJ8TRAt6M8qnYSHkNl3UQabSNS7TnCSWJqNr1krQlmq
	I1jg7ihC2VXDF8jsLIVnk0ALUO0zUxS+fvEr2aEHavhS0W1XisaxZJ/Una/icVztioa0lUNEi9Q
	Zxs2WOcMR97QAQvy2mZvJ+zDZmFwgbQU=
X-Gm-Gg: Acq92OH71nzV5yNj31S+EhcN8B74vGf9VUYI+yBY9xgVUv7Q98FNrswLjMWccBS8Fky
	rPeaE/bQR+KJLgtyFSK2AXVY3ZCEemK15KZTz/IsLEjhabolVD3IXA8QXJF7horJF9ZpNcCDY3v
	qFsz793eoJZGCzFwzhe0JgW/olle6HOiUoMOgpM5nBmWFb4AoUhvxqxkJyig1gYCrG/ZOlpRDRi
	5ojG2dgaWN0G+YPUYiYkP6DMHqdwReeKSYXHWpkd1eEp2qhpNF2wvLeVA8J0/kudVvw5XR4PONJ
	5pbubiN2XxOzvWTKqQpBVl36k6SYi9kMX2G5wnI9aSem5L/5iesbeQE0YHm2w/Zp4YEYuGYMWVA
	uNG8+
X-Received: by 2002:a05:600c:6286:b0:490:5cd8:d21c with SMTP id
 5b1f17b1804b1-490a3186815mr132223235e9.14.1780273401788; Sun, 31 May 2026
 17:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531135234.233421-1-random6.xyz@gmail.com>
In-Reply-To: <20260531135234.233421-1-random6.xyz@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 17:23:10 -0700
X-Gm-Features: AVHnY4Kyklf5qbLcFshD1W6G12xBUd3hYYa8SPL6RtYRoqeGVhCgM4waSIbWQM4
Message-ID: <CAADnVQ+1QNO3rGJi4LbbURXw1HfxXh-Z_d6bejvKFHauQa2COw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add arena invalid node id test
To: Woojin Ji <random6.xyz@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Puranjay Mohan <puranjay@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 6:52=E2=80=AFAM Woojin Ji <random6.xyz@gmail.com> w=
rote:
>
> Commit 2845989f2eba ("bpf: Validate node_id in arena_alloc_pages()")
> added validation for invalid or offline NUMA node ids in
> arena_alloc_pages(), but there is no selftest covering invalid node id
> allocation failure.
>
> Add a verifier_arena test that calls bpf_arena_alloc_pages() with an
> invalid node id and checks that allocation fails.
>
> Tested with:
>   ./test_progs -t verifier_arena/alloc_pages_invalid_node
>
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/verifier_arena.c  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index 62e282f4448a..91aa0941ded2 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -11,6 +11,7 @@
>  #include "bpf_arena_common.h"
>
>  #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned=
(8)))
> +#define INVALID_NODE_ID 0x7fffffff
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_ARENA);
> @@ -199,6 +200,20 @@ int basic_alloc3(void *ctx)
>         return 0;
>  }
>
> +SEC("syscall")
> +__success __retval(0)
> +int alloc_pages_invalid_node(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +       void __arena *page;
> +
> +       page =3D bpf_arena_alloc_pages(&arena, NULL, 1, INVALID_NODE_ID, =
0);
> +       if (page)
> +               return 1;
> +#endif
> +       return 0;

I don't think we need a selftest for every little fix.
This will take more CI time for things that are unlikely to break.

pw-bot: cr

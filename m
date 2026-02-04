Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554232D7F3
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223925; cv=pass; b=dAKAQMRyMPoOCe1yVdWcnbpgRYI8bx69JG8BljDN6EC2BFff7Olhi8F7ZsOH4sMxNYojA6hsb45xWMkYrP65yTuZN2uAQmn7pQM4y978lhD2tdQDbxnuf8QFebVb2FflEDYS36h1S8pzk7fWlIAhygijYl9wK4x3i76roYa7FeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223925; c=relaxed/simple;
	bh=0Qf1R3KvHa3gFTo1rPkRogh8csVkdVXRPUvg0EB7UJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK/rBSdMqbI27pcpCucBoaRrCDW77hct43DqEvb6aoqfbRFrYaUob//iDiUzxL3HzVyLYczyw13rK0JbTV6/8aCCqBEQI7aY3nLoZxOnUTTGq/m6Uu0l4Y5XDUmNYanOtGbc9QqiCWxIn2kyb6ymIYTbCPv1NKb+B1Uarm+wVoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK66GCe2; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK66GCe2"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-432d2c96215so63621f8f.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 08:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770223923; cv=none;
        d=google.com; s=arc-20240605;
        b=BfUb6qaPIyc4U7p0hjWpOSqR2JsBKm3wytvjgPHB+zHmO36qtFL34xParfWh/bKe2f
         +a1HywkWbBjYzswn7aSjrWjJcr9Nkv7V6OrC1ili4Zt3J+S01zKcSfZJwngNkkVxHbZw
         /D6Olsu2idaiceMSDG829TkgmgpItlJn7rWyTTS9YpiMbmwwRl6PxNqoLGWDiLuiTAHw
         MAHPyev3bnDS+YCuqeM2kr3jxECnhCER9KPqO8RuyUuJa44Ws509B6hAfAXeTEjQCGfs
         m8X2j4JjJt8zv3HKYLElxgfgWBuG5buTvFMcMaliPQaurOSN0/SvG+joKWtml4RlDePp
         dmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3i9OrjWGPBFP4QuhiDJNnc+/RJWOz6a333lxtx4rVUA=;
        fh=H9daJU3fIg4I5vYgOIwe6JMpoN04u6LiglvVzZfozMw=;
        b=XocdwPvCm8FFI4vftA/KqVoh0h5s5fw00Cznao3u/NNAP6gvECzrkImu2XsXHVPXGW
         cklicNiIrlZw/knG4/W/ZrKj2Queh5HzWc5o/ur8CETWhTr49pRE5D16xMUR4P7uiq7S
         Tj5x22tpx0gx+NFOgQ0TK1EdaoECYkZuwd74Odt7mFrXCUEmZsHKq/FadS8ixGrvtULy
         Nz9MaCN3k9moLcrX9lNA01D8GPEqgGZ9XRNbyC1ki5ir9Hthia+5BdVrqMSv/tZG15PL
         uJ/3lG8f8fdVdBwZGnsskfyYW1QNWWhTJUQt9nLmAXUiMCHGvDwfJHfVNzn09rdqIAKO
         624Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770223923; x=1770828723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3i9OrjWGPBFP4QuhiDJNnc+/RJWOz6a333lxtx4rVUA=;
        b=VK66GCe2q+vbBR6/pArHe/sYkf53j2K06BNKdDpqAcySW1UwqhCH7dWNUp0GuYrg6H
         m4ZFMLssxuha9l7huIjT7YMtZrUdUPfzbM22Bx2mMSH0ZnbJUD8IQDnAKEVuYZ0kl+1E
         KoDE8eqiky9iYFHpXP1SVZcRjNKFmLpB45xoiYw/bY0muiKhG9dGJObJdC5+fz+Yokwz
         2I3TJTC8VpNA1gGYdmCA+WAfh6HCqEckJ+DkSeTa9dDR3bA3nEcg+4NnVFOvU39RXk5D
         84gA4sHwbwACfayYfYaFTXRPCJBA0Hbrb91YdfybvOFGk3ZWeBYkhyUi+IWb4i1R6oj2
         IZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223923; x=1770828723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i9OrjWGPBFP4QuhiDJNnc+/RJWOz6a333lxtx4rVUA=;
        b=ZX4lgcYbVsyDOjic1TBwh+eG8QmPRt+rTY2c31kyW5sDaDTNK99gZgaN7HzIrphx37
         GP78yYv9l2rbcTHRNHEk+Y3KzIUgixkOIosKojzrZxViEpxbGpbEBbhdy2kwww/KZEmU
         u6Nq4Aax547/HdxiY0BwFCI2gTlh4nQAdsNLZhvs2Q0NM4JGSPqBaVS8DeSnDcakOoT1
         WNe7k4uwckA5kvVnTKsKhhaiPjt/IWxIbrD7olDSG1BcAgSxlPw+1YTa0Jg+PhkUX7kD
         B5uEirlMYZfTZiei6YP8cSNsIH8iU7G1l5pZzesgVKcd8rWo0GD2neWfFMkX19Vd7e8t
         rgZA==
X-Gm-Message-State: AOJu0Yy0p7egyJFTSjpGjkRtmAeGVWRXc8oYn/dUnugQgYV+HTaUIlPW
	ew7Tl1WxRYu8syMMNm+bzoM65aFEKZ5vkJbh4mRWHmTFlATd2X3QDiE3VyGQdVnqiuzvjWJ2DXH
	U49HbWhuCzeFoB8jzaITm3QLU1Oe2I83neeVS
X-Gm-Gg: AZuq6aL3jACoxpGbLDxx1ykGrToKB9NPrKh4PpQmK5joEwJgi5DLJc2qrmChHHupz4o
	nNiP3sXinhhSWM6ME2vFY22hD6Wdv8B2ZGmqaZRRiIAeOyMmnJBjVQOQJsjJcNU8B+WWQw8cB5w
	JQdmUGSmnOFfVrsm+9DsfZOBpeNUl7SE19qmt6NNo8V54ElHyms2cHcvZx9fDFUvPB3s6OwwhAP
	o27DIuTNm2H3c7Lf4htY5RI9i8PyAZvdLYs10t5V4DL4KAX1eNpvs2PxT51PrPcDKS+PRH9D0jd
	hnUvSnbw258XQQ4ilOI7ibwKuW40RQzfh5aXEer6Sb8Qv+q3i5X8MPg8xJYj
X-Received: by 2002:a05:6000:2304:b0:431:5ac:1fc with SMTP id
 ffacd0b85a97d-43617e3fa6amr5118951f8f.14.1770223923027; Wed, 04 Feb 2026
 08:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 4 Feb 2026 17:51:26 +0100
X-Gm-Features: AZwV_QioHYsB5DoyrYRVQR8XpZ1ei8wD-NMcuUs9AGQXpbjcC6Kzaoy3cWCE9rY
Message-ID: <CAP01T77uRx3-zeXbGaOoQpZLnQAWQ6Mi6m+p827SO8c19Gq--g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: Fix conditions when timer/wq can be called
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 08:36, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v2->v3:
> - Add missing refcount_put
> - Detect recursion of indiviual async_cb
> v2: https://lore.kernel.org/bpf/20260204040834.22263-4-alexei.starovoitov@gmail.com/
>
> v1->v2:
> - Add a recursion check
> v1: https://lore.kernel.org/bpf/20260204030927.171-1-alexei.starovoitov@gmail.com/
>

For the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> Alexei Starovoitov (4):
>   bpf: Tighten conditions when timer/wq can be called synchronously
>   selftests/bpf: Add a testcase for deadlock avoidance
>   bpf: Add a recursion check to prevent loops in bpf_timer
>   selftests/bpf: Strengthen timer_start_deadlock test
>
>  kernel/bpf/helpers.c                          | 31 ++++++--
>  .../bpf/prog_tests/timer_start_deadlock.c     | 33 +++++++++
>  .../bpf/progs/timer_start_deadlock.c          | 70 +++++++++++++++++++
>  3 files changed, 128 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
>  create mode 100644 tools/testing/selftests/bpf/progs/timer_start_deadlock.c
>
> --
> 2.47.3
>
>

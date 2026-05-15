Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28E3AEF55
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856493; cv=pass; b=jySXPQhojqBN5P3NpSMGDk1wVMCV85cl/UE+yULQJFsUDJLzXEgSFSWAm+ekd5DSW077en0PFyKpmrze7z5osz6/CDYpZ3cOuzPCtqUsbYPbXG1f5LfMUglJE5ZhsfQ3eDnadhQimkiJNVDFNy8p5JQ4M+HvgkNQaY2dLfzJ/q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856493; c=relaxed/simple;
	bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS0mg2PJqhsfNd8Wz5jeHAa6h2di8hCCyS/m80r/nSXRPhdtbpHeKhsOOXHmOOT8qSq0u/DymNY5Anbku69EglwfckEnutHsVS8X79Oo9kRcnAZH8iRS8OgQT1JgtR7h2L5qLAG7nFPQaE3fgXTXkCK+uMO6xeYlNyscFos+Fhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXAjZAGw; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXAjZAGw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso5447177f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 07:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778856488; cv=none;
        d=google.com; s=arc-20240605;
        b=gyOzUMcbxHqAWNnv5edqsy3mx008SgUfL+sAvr0ubQMbRQ+1mPuwecW7fou9SRRSsx
         JeqfpgmITpUYiRC5UTtrWKg1PJKCTMmxnLBeJmBOuQDmgEPa5WrVA9Y750cEtxWLpKcL
         JH4DUEioX9lHytuchFr0/k1O0LwnStTbejDIrExOp9x8rBqrSFfQkTAlS039WclCxdon
         Y805ohITfaOTed+6V1dxKoWjacKeFbfNHGM3sKTCMkGNNboEEdP05O9AdkRx1LpgD7wx
         GnWrAxb70OYzz33BBz1sRZO0/DhCpf5FAFpUiTU5+WJ6cgeCrnKTGpdLOfVIenR4eVEr
         xl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
        fh=G2IlyKHBjC3PrdXu0ctsaAnemRgOLbOBYmyC3SmCBI8=;
        b=gfdTAcs6rN/cs8SteYyu1b1aN/laCWsic8K5HwyYgJzcVU5YiLXBWYOGsiXbDHLy5G
         dyu5RSEeOdITI3XEUsuqrBLXus6VmoNLY64JfNEm8nKhMemg3B8zqP/xLZ4IYerJm4QE
         B7LWS5emicr1zSrvWMFk7beD59MnbtC1I/tFkdznfDpLjobIh2BIsgw+O/xkZFboFFLX
         N/5LZh8Wi3+wYyHTKH3/xjBIB6wy6T0oTiOt/8m0jOPwz1xObzHiEMOyNyxL9W9r7dmt
         qdZVsJDKb7lLQ54sRwseYS/rrbXnnRg7CQaHT7x52lkkxCuEsQefOeM+nlvUVSE0rnMN
         OFUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778856488; x=1779461288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
        b=DXAjZAGwc652jCVwEctT9TrSu/8trr5N1ViqFwAvim98iTZwngOEB+cyOwf8jEOjdW
         oE5ZteloVxoruA8g3Hm5oHupj6Y6EG6MevUOVBQ8OBP6XUiTq4rhrf2ceZgBoq1sQSsH
         PG0aknUDFS6P0R+Io7q0neeWbU2acMbRQP5L0Al3do2kBPQSHw8ZPY579qzXJN0Abepq
         PXJmhFWvdmWKja3n7y1LpXhLcq/UbMrX2H2GxmKlY/9/GMa4MgFIiLuilKrrQL4fEIw1
         mj/vdjOSicy65W1+Q1Hhv/dfMvX6EdxNBnG+EwJPRSGcyUk0ntdd7rS507xg3z9J+aQz
         CwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778856488; x=1779461288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
        b=BDctyg/1SyVwM267hi+F6ZMhWPMNCVB0SQoyaHgs4BNjnnQycJMDzoqeq8Q2eMV7te
         GXhLSTWoyQ06pip7ZH9sI5QftluMw60S729rN0sL/Gi5Ux/ME3riROUAsknG66uMRPym
         HVC4IyMWVIOe7WjSUeVhRLqJHDOd0gLqUIyESJIiM/Q5mjoX1HjFBrdwTtW2PuvLZVaf
         da6SseI/pmn+lC6orLHal9kuwr0XbWrixBtLziN+o2yDmDJKxaJpCHwTIsfHNJPWCLFk
         W4AfotJz01k6tcLY4RtQHNECCBsIHgzYrMWVmotAMhUFX0k2BxJ3nxIRsONdBrVvnRa3
         b8lw==
X-Forwarded-Encrypted: i=1; AFNElJ8LmTMRaMk2w4OgpU8YELU8KvYKpngYYPQZOUJ+Rpl+dI4I1Mfs8cZ5EbyE9Q9gWLlsj0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQE8jTsHOCtoS62GAdvnqv15o81R4cS0sAl1BznWDk/bKeOMn
	Z+c+8MjmH8LBj6I8uW569GppUxbb3qb/pPr9wJHMahU+CaFcFPjf+LL5FeccG8EgPAZ4hQbiDcp
	KIWiFvfAljb2TPguCsKby/Mb9BcV07M8=
X-Gm-Gg: Acq92OFJmVI/uIA5dag2xVdPUQn173lkCWM+OKYh/X1t5pJtKtkOIRaLS/TZCmCNImI
	oddvdZYrIdxiEwh0d0CsavjBSmRVN04s2LiL7HGCMdR8BuOvMkSvbcedXDdLfNkaYCbwiYgJmtm
	oXjrLQkJnudCP26O3P82kAEAqZZBb9/YjGZgV+zdN45Xu7jbUp35Koa8bR+qQcZ6ut9vkUPWnvi
	n8DSptwLHfP0KiXpKHSQuLyfkFZyMur69arEPtexxdDFfpy6yfjH8g909iEcGhKYH6XhFQoQLOM
	TmxvnmDfPuUKn8Z4aa/BjFly/hZqUMCts/nCKn6UjTt+4U8ZQnDTyroLbpZn94F0B1tiXK5hOhk
	o9br5b/c5HEmnS1SvK8jKDADrfhSNc4hMmEWv
X-Received: by 2002:a05:6000:288c:b0:43b:962b:5314 with SMTP id
 ffacd0b85a97d-45e5c372a9cmr6225346f8f.19.1778856488007; Fri, 15 May 2026
 07:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515113102.2389020-1-arnd@kernel.org>
In-Reply-To: <20260515113102.2389020-1-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2026 07:47:56 -0700
X-Gm-Features: AVHnY4IJhGzViGxkFydpy-ZBw9ON9MzDz_cZ5mrUv3ShjDNoKLYLS1-DYxXoS10
Message-ID: <CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The xdp_test_data structure is really too large to put on the stack
> and results in one of the largest stack frames in the kernel:
>
> net/bpf/test_run.c: In function 'bpf_test_run_xdp_live':
> net/bpf/test_run.c:387:1: error: the frame size of 1608 bytes is larger t=
han 1536 bytes [-Werror=3Dframe-larger-than=3D]
>
> Reduce this using dynamic allocation, which avoids around 1KB of
> stack usage.

1k?
pahole -C xdp_test_data
/* size: 192, cachelines: 3, members: 9 */
/* sum members: 120, holes: 1, sum holes: 56 */
/* padding: 16 */
/* paddings: 1, sum paddings: 36 */

what s390 doing to make it huge?

Probably better to rearrange the field and fix the root cause.

pw-bot: cr

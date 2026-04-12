Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D731328E
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776036061; cv=pass; b=hZDUyuBGRQKb0yjFfNJ1gjAYPjTveodwlXCe57nahQ4NU5Pe/dJiNqgJVqhdSvRqkFgAxmnvYF2R4ZNlBcTOIEwMyT6cndzQi/A//wNKop5sBCJVufGnygR0w4FIXwUgy7seONPZbqsjJVclvPiJgLsBr0obn/010y0Ko7fXJYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776036061; c=relaxed/simple;
	bh=OIZUuu8XaxhAYULax+7XLO82nX2cw3V+YS1pGknyAgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7HCgIQj6Q/UEIuhunIb51gEDM1zpP6nz+F70MlmOhMfs96NUCHz9Kwxdhtn7EkHwcUydG0PJBD0SB8EOUU0cwHblFYXOZO5vhW2P8dNH9Vn2GtEWXqGCLPZUMmaMbDfJjdKBWhy/Lc07H16d/CaosysnDBBrWOww1R2vPibTOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gax9U5Qe; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gax9U5Qe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so51018785e9.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776036058; cv=none;
        d=google.com; s=arc-20240605;
        b=GHwgFoUKg9ibbh634VaeagXCqPO7iSoM9mj8qG2M2UgUBm/n35HLSvgx0KTL/NbzlW
         tFwCaWl2XwfjgEMO5FT2dHw3iUxtR+JkMu3ASTqWnvK92P4efWhmN8TbiiTHPjAPXi1n
         Ci6ggDeKcCEs5eI9dn7VFwqzxQ2tzGEY5921KOJAodu7pAW16BVbTAGzXq+5mFi+Dlne
         gJY2Zaz+aBHy9TvxXA0w6Yh9duaqwSr7yfBYyu/dxqmvYMVjs5RqWX4Jz0QXVEhOomjF
         1YsoPE/YXRqGFXOmXNgL1EVWTaP48mmNYHP14oMMBh6XD1kQrSY1tg4E2OjGouNd+6hX
         tJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x+YZxNbuofKbM9IzF7CAEt/EcQAmm0YMMKLfcfL9RLk=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=gLrUF2wuvzC8KeFKF/QIbcYipAeJrAziDAhsRgQb3gxstKIklJ7nPU8vActhtJub99
         qFUnqaWT4xBKl7/cqDDRR9yFORxQLnpX4XiwId91GT4U6bMsxDvZXgcxdn6D1IILJIcS
         4IGl6vdK4YOiA90L4qyDPojSSiNHniGTVQngRhLJI7BSMOsNN+bF2LW9Pqccypv+hQzp
         yedSe0+Dd354JgK+v1D2QUTYv9kEYPmxked3m1qt4a1xlCDO03PbTff3SMPlaUJm9rJm
         5OeIV1EMN6yzhMbNkTSHXyJa4mVKdG9Fl+0Jo9JrtKK7aDwsPL1MUsl0lqpFGHsjJ4iX
         vmAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776036058; x=1776640858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+YZxNbuofKbM9IzF7CAEt/EcQAmm0YMMKLfcfL9RLk=;
        b=gax9U5QeIHQMzwrT1368APbNOzVDb3yXwHS965mCbTikJ61s3MCFR8w0iUAhR0VGIf
         qsB3ggQzg1UsGMCxlEAMEZrXOyPizmqBy9VEvwe1weOTiqVM1BE6RYStlIoqFZNSHYMm
         x5QYJHcbl/NYz4fFERZyipGjNOQqIQuINK8N4uERUjmYqD23basUwaslxNBf3STBi/Op
         fYyaoPjH5KafE4hRi6dgF2WoX8nuZ4L8nK1/b5rgBeLHMhf9IF/hmtlyPTAgz3zbeiAf
         X6W9GI4wrjGCSc4LXsWwUKxfao0JbcrN+1fQ81a3PQO4O+p35yZpebhR/6lOSk7O4wCG
         JuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776036058; x=1776640858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+YZxNbuofKbM9IzF7CAEt/EcQAmm0YMMKLfcfL9RLk=;
        b=jAJgmVdE60/Cv5glBhnjGMR6wsVJU21x5BAlXKB6MNvkvFCg1MMkA+dMFCXZryMFYQ
         0UkxJymRx6rUZ3Q2OPblrYAoeqDWw4m3rHjHNOwaq24yLxANc8Qrs6cmzec+Wiyk1DI9
         m69BPfSViXWqeyidKA60CeYI6YXzVQMSI8sy7U0VYhEhpCUGq3JTWr+BsuNzGPEm7Pa3
         jt8svPwkzTTMU8N9QXEfJsd9h9QlPlyVnCCmlT4Fuk+id6nmqXXTgg3zJrx4H325VZlt
         mFJ8z/7RDCjoDcc5fD26BM0K6srZWlsenBVoVhgtwMMXCHFYZyuOl1ZpnbJIIgq8OazW
         2icA==
X-Gm-Message-State: AOJu0YzFAOypdKB46hYLzhdBVOsUqwwFs98l3Z9j3mt7ksa++C7YAgXE
	ez+OFwEtdvL+bJsEe0oFsoSyNxEQ/C4aK1PWYGEQUNtWE3GHW+6AvRArMoqJgYeQ45uk35J9CsJ
	u2I2gEorLZy1x7WrnoZslC6IN8w62ECY=
X-Gm-Gg: AeBDieu4+hnPld46GQhJ/OC3WvTqL+LulC8wiKDc1dHc1177fnrrnN4VREnDpuH0a1/
	b6T7N6U77PeZWVpIrT5BO3HmIQpk+fQ+sTRGVlPvYXCTsc21DmSUFtxliTAAmMAu6UayuPc2qKQ
	wkcI6w4xrGSK4cK6oqWrNvSqsDK1TzwCNdUtRxr8Slx3Tyf6gt71etCYJfEFm5Rabtm0c+2KQii
	e/AIV+8KUtKEQLwJCnIaFAkzX42tNxwJuR+SrHucO49zz2Pd/FoI2tPIOY7sKZjG6+mWWnH1gX0
	qwgeLB1GoN3TUFQGXbGouM6AO4lWOWqEDZ0LDZWB0vBOeEI0ObgI/vKRE/PJlWXzOkFc+TuaOLd
	+VXjMa+MYA2A927nYADE4DDEKBg==
X-Received: by 2002:a05:600c:4a18:b0:488:e6cf:671a with SMTP id
 5b1f17b1804b1-488e6cf67d6mr11887195e9.25.1776036058401; Sun, 12 Apr 2026
 16:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-16-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-16-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:20:47 -0700
X-Gm-Features: AQROBzC6w8tBH8qDleWa7DjTRe_zcdiF-vJOY6As9LaLtcTtyFVXFIc1V_aVJc8
Message-ID: <CAADnVQK307F_T5md5pLOjMNRmNOJOj2qdWbJBNjMR1R4b-VmCA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 16/18] selftests/bpf: Add BPF iterator
 tests for resizable hash map
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
> Test BPF iterator functionality for BPF_MAP_TYPE_RHASH:
>  * Basic iteration verifying all elements are visited
>  * Overflow test triggering seq_file restart, validating correct
> resume behavior via skip_elems tracking
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/rhash.c     | 160 +++++++++++++++=
+++++-
>  .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  75 ++++++++++
>  2 files changed, 234 insertions(+), 1 deletion(-)

too much code for little test coverage.

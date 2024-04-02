Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC7159910
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078554; cv=none; b=GKlIwCipZmjpRmQ3cSudhhRBNZcD7HHwBIGx3iBI4Fya1HrIEE9fcfkbaCGczStAXN6lW1d/WG9VTC/O12xEL8n52PPldzH6PZBLBvYDxS/rX6uz9DT+SHGByWY/dvFpUmBgdcJsf83cqA59g4Cn3CAoa0IpATNsGTU3yieKzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078554; c=relaxed/simple;
	bh=SoajwR0DfrmN56AEjqNvoe8dLrC+clO2g3+8VFBVTmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKxSIMZCtZkv1rawP61kNvdG0zA/OlwwbfbrSORXHMB2ivMitMo9uEpDKqtQlurrcktFH2O9QsvS3tkyxAsVYVOrmn9WHP4T15wy651++R9Yicox24HnBynn5c2zrx5FG0tenqQPUNoi8BLvdgPAWCuspCQH+d53eqVaaSkwHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqfWjHbA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqfWjHbA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a074187a42so4069739a91.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712078552; x=1712683352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3cPJ+qvlUi7HnMAr2QVq81R+L9lvT7uXAYucATccgM=;
        b=JqfWjHbAlpD5C8WFvkS4nNNCegn8zsWgK6lo5oSOWn9KuvyRF0fVhfWyN6n7YDiIz7
         0FiFdKJbkgpIh1+AUKsbHfA0iRljmUBDE5sg3cLlrBLkEYY9/PI2GJeS9wK7AAEGXLij
         zsEaH3b5GfUuR4XeHKQPxPuKaU8yrF+2M7ocuiviyL/yL327xr8jNiL4EtwYBP4+ySVj
         NUPhsLTTmDzWD6KMJzz6X11e7CqPA8BAqv4UYZtixipWsMD4ycFsPtyZc54Zr5Wyyeje
         CVPTh4NPOR/v9z6AK48L6iPMwfFY1VfSUokL+AhXsp54WvOCEE00LzaRRzdrzO2fXdt3
         L7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078552; x=1712683352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3cPJ+qvlUi7HnMAr2QVq81R+L9lvT7uXAYucATccgM=;
        b=Fv5Uzwz7ful2Bzz1+zqd/DfCtgaE8Sl/wkizA7RFYykBRc59ZWte6HnBvtUgB2lvkg
         5vH/gNyuqf8kNEnTYGTNrA9RdVDMqeC0CvKH0NTbv4JOh29C4vre6MqDo8BWbQrLcGtI
         //hoYyzLKLepMfTdYrxBXqNw+KVNfnTDSHTsW+hjlw+tnwnLufHeieM3tS/M6MS1MIT4
         kywMs/tdEzc45YPh9OQ9cgNlkwtwmgtwIxziNmj7XAJP7oL0rCacVPSSBIPpv4BtiuHT
         ez+YNfRt0VZbHoNgftGIhkw+948hXQyQMDTSlOk9b5l8VuHe8/1p/BQXI2UHBvHjp6Kk
         Tr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+H8E46Cw8ZI/J17qARpcjV/E78v2wpZgvICTCUPsVvZbpw17ESfe7LK9YldIpz5CKOKW/oUGvx+85flunWwF/dCKy
X-Gm-Message-State: AOJu0YwTWczufLVOJ9Thevk0UJEGxgDlfYlgTTw7d7rIOuUhV6McWkqG
	+wqQ0K/Z4Ct0lFGw2bro1DdG2kLvm5oeHxlbUadLcMGT4JEUZlSvSFvFDiRT3P9UE07u7hk3Y8G
	zdxidKVb/86BkViZ36yLTKy4ctdc=
X-Google-Smtp-Source: AGHT+IG8YEhr6hk58IRdLQwoLnXSaCDbvJdoFnkB0NY2HYQG+B10QWQUDu/00xvSlTr1kdIfjVTloJjDh4NQABXuagM=
X-Received: by 2002:a17:90a:df15:b0:2a0:97f0:955e with SMTP id
 gp21-20020a17090adf1500b002a097f0955emr10675199pjb.37.1712078551753; Tue, 02
 Apr 2024 10:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331034154.16284-1-laoar.shao@gmail.com>
In-Reply-To: <20240331034154.16284-1-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 10:22:19 -0700
Message-ID: <CAEf4BzZnLNg9dKF1knkPohzP+4cw_4W9QhUuXQaNA88pGwiLLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Add a generic bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 8:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> added for the new bpf_iter_bits functionality. These kfuncs enable the
> iteration of the bits from a given address and a given number of bits.
>
> - bpf_iter_bits_new
>   Initialize a new bits iterator for a given memory area. Due to the
>   limitation of bpf memalloc, the max number of bits to be iterated
>   over is (4096 * 8).
> - bpf_iter_bits_next
>   Get the next bit in a bpf_iter_bits
> - bpf_iter_bits_destroy
>   Destroy a bpf_iter_bits
>
> The bits iterator can be used in any context and on any address.
>
> Changes:
> - v4->v5:
>   - Simplify test cases (Andrii)

hm... I think you oversimplified them :) Your negative tests are good,
but there is now no "positive" test that shows that iterator functions
properly. I'd suggest to add few positive tests (still within
RUN_TESTS framework) using __retval (grep for other use cases using
it) to check actual values.

I think you need to validate that iterator works for:

a) bit mask  smaller than 8 bytes (and also maybe number of bits that
are not multiple of 8, e.g., have 20 bit bitmask, but set entire
32-bit value to 1s, check that you get only 20 iterator next()
returns)

b) a typical case of having 8-byte bit mask (you can have some
irregular pattern of bits, like 0b1111000111001101, and calculate a
sum of bit positions, returned for __retval check. This will catch
endianness issues, if there are still any.

c) another typical case where bit mask is > 8 bytes (same idea with
position sum would work, but probably just counting number of bits
would be enough)

pw-bot: cr

> - v3->v4:
>   - Fix endianness error on s390x (Andrii)
>   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> - v2->v3:
>   - Optimization for u64/u32 mask (Andrii)
> - v1->v2:
>   - Simplify the CPU number verification code to avoid the failure on s39=
0x
>     (Eduard)
> - bpf: Add bpf_iter_cpumask
>   https://lwn.net/Articles/961104/
> - bpf: Add new bpf helper bpf_for_each_cpu
>   https://lwn.net/Articles/939939/
>
> Yafang Shao (2):
>   bpf: Add bits iterator
>   selftests/bpf: Add selftest for bits iter
>
>  kernel/bpf/helpers.c                          | 120 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_bits_iter.c  |  57 +++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.=
c
>
> --
> 2.39.1
>

Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C59283C93
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381245; cv=pass; b=A/ldAJa2jmFjd6ctiS4jhbMgPO6qDpoyCSr+Kmj9QX/pub4ZsHmbFqLCzQvygY3xbD5iL+V3KVE+FCegGzuCiR+LiTfDRoouIJ9NYkXGu5Sdqwf9cAVOCzPuKWEclU/ReWhXNIOoZwOsZ5+g66yAhYyG/desUeMgB4uifdd16X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381245; c=relaxed/simple;
	bh=U3JHSNhF+GWjJ08xRurIqQb7Wqr4Om/3K92fWZGIO94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLdNT1TrjyZRdRvRc9/VPvwa5VE/sAieHG3m63gMzRVFWhgYxqO4LqXw9yvxVy9qClfx30WFzT+ZiemFaGkli7sNTyKlZidzP8oIyd4ZfFOnoYhsY7y+EwZPhatKNTVC9dGNjHU/EW8+DreEMAoVd3oyBs4VybmmKy/J+EkbXYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8vtDh/S; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8vtDh/S"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3591cc98871so40007a91.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 16:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776381243; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0vliQLlk/BuaxDXPgQPxdD3a4768xw1WpAn2o1rWXUp0ja6cwc0Saan0dlHFKKm/e
         uJ9CBeRrRjmLtzw+NzWevtvSZlVysmjJSD+28kJtTuuu6rtX9+vjR+5KJELS4+7Spbdi
         M/af7B8RzxO04xeGDcnMX8+LJIJHK3F3ThP1c0X7u/Mz9tqWG8r0wafm1DZ7Prn5pQtE
         ywUwb3of8SBhOOpYZbhUQ9ZiLLtwwga4IoeWQzY0TS0JlOz7oxhdH5ll65R6qYVEKYjr
         3kx9mRvSMq08tqK/r/SfKFiWDPzZ0HvihBjiDwOWQ/eyLTNWOQuP9E/LooHC9pXTU5V0
         QJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U3JHSNhF+GWjJ08xRurIqQb7Wqr4Om/3K92fWZGIO94=;
        fh=ypw/5fet4CANHeQUz+kfgabEvSoH35hHHOlcI8B0sBI=;
        b=OTCh037/9vGOo0fL3FaLM8yHsLiI+Gieeylh3fxJZeh8m06rqIai4aSNiG5mBgoQar
         zErnqyHh4GjuKsjvHUyHLMmkfFtEoAMD++crteSnfxtA313O4yvycdCDRsx4Qqmd0gee
         J9CD7mTnwA8Qyvn5EYVHk1Jef5vvPqTsGxBv1W7rRtQ0Fx+4EPvEPLzFftEpBZLHG33y
         CqhY8YwSxnB6mYbATSbvriXIwhGtEVb4ZiOQ5n7BcdUQ2XZJ+xDe9iTNyLzCpZGEbPp+
         n12p2UnbAKtEcz4CZD3LQv4HaAOV1O3kLlv6msTGntqfnXdRhNRPZa1xjVUJlBvstlT6
         pSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776381243; x=1776986043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3JHSNhF+GWjJ08xRurIqQb7Wqr4Om/3K92fWZGIO94=;
        b=M8vtDh/S0PCAZWLMCtxAQOU0D4Cpvo2NLH/KgluATJCC6+bIK/DcQlQZjfFwdn686T
         9qj+yAlSH+bNZCfTzrud+Hk4yfSfZEoDh7XahgottKeYx8PMISpVuPrgvE8hLKymJeWG
         TPBYUkc39lUSa8uDSsEO5AR5DGAkkuIUqG6KY4oisDj6Vlok2f/d2WzAXrHKSJND7q0a
         7NQSCeGr/qkEOoLVx7ONstv0dz2jK2lK/yJrAVaEqBQSA2dOdFlTm8OmSNm8aOkxUQLC
         rMupS+ZHcGb6FRbVm9vpolxNajo6OWZhqd9kxyT3/rih8VgRH72xmDhdPSQb6NO7GZxx
         c0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381243; x=1776986043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3JHSNhF+GWjJ08xRurIqQb7Wqr4Om/3K92fWZGIO94=;
        b=Oeq+F365QnV6+O7KL87kORqDa23WpfFtHV2enQxmySsJ6nv/dQyS9N90Qbm2vbyvdo
         g2Mhc90S3/nnN2baADfxcAYA1tdd3+uxHK8rDiIaSgRfqEbp4k5++CB5XIHGhZsGuTsn
         E2DNTZkaKDFAqaHmUX+Mz1snW1SlZAc7uslM5kiujdzgyScKqbV1lm2K4kKqeYjfSDFD
         I0fyaUWYBCpRORlF6qsnfqULKpbRHD4Kigfjj5GuuOuPysfdQWlP6E6U95tNEm9lD3Ih
         n4A6NTj5r7JVvxPlhlzJ1q+8jzRUIZ6NJfHi6LRA4rza+hdMEqHNmwjkjnVACFK1RLsl
         XwDg==
X-Gm-Message-State: AOJu0Yz/jhGgtL4o4ZS7PAU0et7aQD1OJdhyitZZTsKjuHQeYfebQnkN
	qD8FZUCn8sSVlSjaph4XvYlS4juINZ43g4+N2Y7d56v332r/IJCwxlRa7A144aWrvFHnVixvLGc
	dH3l5ttq0BisgvoKFw42jouloQJbAzrY=
X-Gm-Gg: AeBDievdbhjdtZwqDvUh+u3i27qZXf6EUCpFzOzcjVjpIti5SNZftqKCKnO1Ks2OMgv
	LiIFp94XXqSkm/BA0sEdGs5Qdv4Lptkx2kM4OceyELndTrv+LfqGy5a5lEJo6IpKXJBsvuWFbEE
	czIA/RNGgxEhdZCp5sKDXslwZmPDTcYcKqt9uIiXmFmQO0k6wFFHc1lQqf15lYjowoXkeE/BOUP
	KuJm9ormWdUUAgj+ncrlHGksc8dKIkXV24m6f/bs9Vejdgad+FWsFFzywUq5Os4zXSOLFigjPvl
	DI1zGS9Gfwu+QrwkTaZDRpMjXUkCRuXGH6r1HjvW26qHUoERgqar
X-Received: by 2002:a17:90a:da8f:b0:35f:c1cc:feee with SMTP id
 98e67ed59e1d1-361403c3263mr350564a91.3.1776381243470; Thu, 16 Apr 2026
 16:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com> <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
In-Reply-To: <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 16 Apr 2026 19:13:45 -0400
X-Gm-Features: AQROBzCADLK4SeBSAvC9Bpvj6ZOynJRZDq9yJlDiSSF44qI1WmdbTwdt8tQQXmg
Message-ID: <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 9:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-04-15 at 12:07 -0400, Harishankar Vishwanathan wrote:
[...]
>
> For example, given the current implementations for
> is_scalar_branch_taken(), regs_refine_cond_op(),
> deduce_bounds_64_from_64() is it ever possible for u64 range not to
> intersect with s64 range?

> After spending some time with pen and paper for BPF_JLE operation I
> suspect that it is not possible. I also encoded this as a small cbmc
> test: https://github.com/eddyz87/intersection-check.
> I suspect that same reasoning applies for other operations.

Hi Eduard,

First to confirm if I am reading the CBMC code
correctly, the precondition for the verification is that the inputs to the
BPF_JLE code are
1) register states are valid initial states (at least one concrete
value satisfying both its u64 and s64 bounds)
2) the input register states have been passed through
deduce_bounds_64_from_64()

Without the 2), the verification fails.
I am assuming the rationale is that any inputs to the BPF_JLE code in
actual verifier will have passed through reg_bounds_sync()
in a previous instruction.

If the understanding is correct, then, I had the following questions:

1) Other reg_bounds_sync() functions.
What if the other reg_bounds_sync() functions update the
abstract register values in a way that makes the jump operators
produce no intersection between u64 and s64 (when reg_bound_offset
and update_reg_bounds are run at the end)? Is this not possible?

2) Other jump operators.
The CBMC code currently doesn't check for, i.e. JEQ, JNE, JSLE,
JSLT, JSGE, JSGT, JSET. Could they produce an u64-s64 empty
intersection?

> I'd suggest to drop the u32/s32 and u64/s64 checks, unless a counter
> example can be found. I'm not sure about 64/32-bit checks.
> Wdyt?

Given Paul's tests [1] on the Cilium suite revealed almost no performance
impact of these checks, should we keep them all to stay on the safe side?

[1] https://lore.kernel.org/bpf/ad_g2QwAfJh64Ba7@mail.gmail.com/

> [...]

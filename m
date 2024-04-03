Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CC1534F3
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166786; cv=none; b=JTEXEVxtWAf1PqjUAEWENHnk/DkHEDm4+K4z7u61Zu4i7Nm3iEzih2wWS9HV8J0lkOuSmPSggJCvD4TN0bhScrnnCRjPPocSiUp6HN7KeGKRAyXmua7cZfJ1Yd4eJ/fgic9Z0MtT/Gv+DnPBgctLNf5+1aDkY4F2vav5TTss+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166786; c=relaxed/simple;
	bh=v/IJJ6tZEIc75+htaAwSMLJTmPgncPpjch7colQ47Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSh7Err3zZMFKHp+GFv+3vRPfUjp23GjpKrNfe6z7DP301PZRJ9cjMXquzWyhzo4pKvo364CeXk/SFhonC73gmwty4OgAK6wBh/MXuSzaPKQjJ9mv69xhpym4sNsLSBgjPy+j9C5Wv6xhHl2bnN2JXd21Hukdgp/czGJP0rEu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg5Q3iaH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg5Q3iaH"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fa455cd94so132522a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712166784; x=1712771584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88UQBVIiLM0n5lapjWmYWQ0JM12kq12npB7UXuIYA8s=;
        b=lg5Q3iaH0nF4DY9/ECj+BuhF1EC1U80wNq+gIrj8KHjO3vtdoPRKboH8A5U1bSEI1i
         4E1yjloFiMCMbqv82oUplKnHAzAULcEkFzcJ6x+eUy3Ae5TkBYFUOHMGBYULUdTu46Px
         uDOUWiAPXZh5nBccGq2PLGsOrB+GuDkUVHFn4ZxcDWJPreZtlcykHu4oWHAv2/z1DM4j
         jvKOmYtNIfWMuKSrXGyz0SzlMx8a6YhWBF8ZrMQceMssrDoGyhRlhJYmMo9AFpxIV42I
         i1LrsIiH6+V8GYP0RzNuikCYfN0t/4foMa9uNiOvpm57L0gGg2zooVmWgnhyiaNi1s3P
         vpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166784; x=1712771584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88UQBVIiLM0n5lapjWmYWQ0JM12kq12npB7UXuIYA8s=;
        b=d7ullAtjQOqWnYEUqE9WRxcH9IHMut+kyTXqgXDo8TvhorkK2cM72+BV+/py1cIHFy
         MUnTLktkB2bdFyFnz3vnDOC3+CBBJZ0ydXJmNbOtJJ2Go7Z8bvBTanH6bF69kVYKd7Pq
         BfPLWfcneT8SQKlugOkD4VEBl2r2WfsSQK3IkUYw1Kh81TZVFdzPY1+Lb83R7LdCLcfb
         CW2bO8Kn6yGrwrHhzeq+t5eozek+k8kl8ydCSDfqR6GZZhQWGbVZSdrIVaI4OlTZL+t8
         dNuAQJa2ybAesBIrTEvbRdcuFooUuRv1/upv1mF7c31fVgsjiQLEWDGuSBsRiQDa9r5L
         5ycg==
X-Forwarded-Encrypted: i=1; AJvYcCXmFj+GsB2t4OcI7llposuMc+WfmIwdvvg8c31jXf92uZoo4wyHl1vTRPkXDU/o+N2vUKQ3B/avgsX20cLSl3U5JYSu
X-Gm-Message-State: AOJu0YzvIbgyjawtCTXYJ5R2OukbgajPKpUA21WxNB6eIPU8b9nU663V
	0eFp84pZJSu9UVBy3Thwu7LSTlYKU7IKyv4W0s5LbHRayxMiZmjYhD1xYy/RJI8jJ0bJU8JcYvR
	iTgyuRwoS081nxATROauscGBUzBc=
X-Google-Smtp-Source: AGHT+IEg5Z1v3OnWQkZQs7qBEptvSsKfIN+7ZduvrRtI5yAuZWearPVlaQoHTE1Esnq9Ubug+9RH1o0f0cRmGFf0YB4=
X-Received: by 2002:a17:90a:c092:b0:2a2:b3a1:abc3 with SMTP id
 o18-20020a17090ac09200b002a2b3a1abc3mr264065pjs.6.1712166784034; Wed, 03 Apr
 2024 10:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403123303.1452184-1-aspsk@isovalent.com> <db09243e-c313-f26c-a10d-ab1ef41d2ac5@iogearbox.net>
In-Reply-To: <db09243e-c313-f26c-a10d-ab1ef41d2ac5@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 10:52:52 -0700
Message-ID: <CAEf4BzZ=DXNKDFPzRv8JWmuKd+zmuHxDC+4qaJtHakh2SWensQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:14=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 4/3/24 2:33 PM, Anton Protopopov wrote:
> > The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
> > 59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
> > a static assertion to check this property so that future changes to the
> > structure will not accidentally break this assumption.
> >
> > As it immediately turned out, on some 32-bit arm systems, when AEABI=3D=
n,
> > the total size of the structure was equal to 68, see [1]. This happened
> > because the bpf_fib_lookup structure contains a union of two 16-bit
> > fields:
> >
> >      union {
> >              __u16 tot_len;
> >              __u16 mtu_result;
> >      };
> >
> > which was supposed to compile to a 16-bit-aligned 16-bit field. On the
> > aforementioned setups it was instead both aligned and padded to 32-bits=
.
> >
> > Declare this inner union as __attribute__((packed, aligned(2))) such
> > that it always is of size 2 and is aligned to 16 bits.
> >
> >    [1] https://lore.kernel.org/all/CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztN=
pwvE6+R1VtFiLrw@mail.gmail.com/#t
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Let's continue the tag fest :) Also fixes tag:

Fixes: e1850ea9bd9e ("bpf: bpf_fib_lookup return MTU value as output
when looked up")

Should this also go through the bpf tree instead of bpf-next?

Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D552571D7
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435839; cv=pass; b=JtrvixQWQfpNK6NYNxqg2bECDWCl8jjIDySGe4Kg3xOdL7bQpSHo3KSQdmdfdOlggdibPZo15tFyHFskLsAGuUOlEYDd9ymimJluTNbMXSz2Su6lDTogphouRwlcLcStq3QRPGEi89KadbR3djrQ14NHo+NiKDtJ12p9mHuBu/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435839; c=relaxed/simple;
	bh=1R0Lwql6nSOQ9kWNCc0PkQe60FSIwExCWTenK/CGDLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNsNLHnK7dbb1WnYkcDq1NQCTV+Id5L11vYBEG+39wJp1UkV/3Kf5lBw9aiHjCgnO5LWYN2nX5c9JXiYU/FPyKiJDzzG6Eoa/74dtTO7NHBZJGFO0rmKct7NURcLJmHyxXjoGi9e0WJpPsm4fu8MB+6JJYOsNnc2Np0sfJm1Kws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt+PPXzG; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt+PPXzG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-661568ce781so3926269a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773435836; cv=none;
        d=google.com; s=arc-20240605;
        b=eYSr1xVaAjg/sgBl7lnaJNF9VPct/7CHjQbAMEHmDEdJTAgDo9y24NvV079fNz+KTW
         2S9HEUlJtM475Hmw71bG2RaKVY2glAwDlcTujychnPcYY3W6bhKDgjMyYJlI4x7mOZ7K
         1qZt5BrTe2zQNIZddVGtY4jPmJ7PI4xCYcDm0CjNRnH59qJzA55K2o/EuUiuVQgZ11db
         iWOG5Lfa12CD0T2U5Q87W6AzUx/xgmR28xA0z3Ohnoep3KYYS004Nmz6mamdC6X1sfo+
         XkfMq51hofVlFQuVNn7pNq4VnRlYpsPZhx1jMa0eHBYP5LD/u6ujhUYp8HymEowmWdMV
         k7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/kZwgdWmNGCktNPe763uSTYgyKSmDilnHXCY6tJkRM=;
        fh=24TcYdoMgfjV8b7K2YQf9RFVnKqSAbSHlpFqL1rD9cw=;
        b=FdlP+6i9L3wQTqjfMV2Zt9Cew8KceJEKBTKkpO0ROIiPKOKRgzvia0HNTdQ14MWaSc
         1haKhKommaLun4jZUipx1XhHLM9S8gEXLseJM5tTjOSKVKrnkXcjdlyoffkUs8XCQ56w
         UxwTBPsXSPsSlraWFOGZjLzEp+PGFnjlsQMTqupC0q1AaXL4HBAZJjTTzkYIj8bsWOq/
         5H1dk/JCPxbjywmp7isjxYPWib7WK+cbBco9HZybtNzarzo1eV013YNN2tETcMuQqVO3
         /c3cLXfkMJbpv7XF6VayVNBPHZ/DmO/IFp1qgwxAbXPCqtlnfc76TsrDsNbwtttdu/pU
         Famw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435836; x=1774040636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/kZwgdWmNGCktNPe763uSTYgyKSmDilnHXCY6tJkRM=;
        b=Rt+PPXzGHR7RSUYpAnBr6bRN1SHpw6OIqwckkvAuccGhw+jMAkuNHVJFTjiXaIBVde
         PWpy6GjywIVpCOM4riZ+Uydcf/rnRapbngH7gu7R/T5H49y2hGXfe0ncLJq3r2VFOaG7
         df4bdsb1YdwNuNtLvTp7OvxCU0gL4dLTFyTiSDGocjyW+c7XUD+iL9jLnSk809oP9GZ5
         tnZahy3Ke6e0jb3ecqRqhM7mHh0m7TJuQR/1ofBv0m8rPuJVK+62LuWWQXZ7wD/jNQnY
         P3Z/mXm04cL16vB0uK+X1PPsR9S4XgyT6ZPHDD6XrKl0ix564D+vZe1jc404RZyZalqp
         rjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435836; x=1774040636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/kZwgdWmNGCktNPe763uSTYgyKSmDilnHXCY6tJkRM=;
        b=YagJ2msamrLi5LDAN09sb8Do9ntIWFk+JfTTtkJD9iQdwZBXFoPgjiuS7o8MToHyv9
         xX0ARMZC/itgnh6+gx3t7FIknqO/rdANrYfRPjf+HA1bIa+jLGkBY0KjliWyrIepcHWe
         D3kBkXNGxwcy9CwoYmnqB6rzETXEWKKka4JS0Nhm5S6BikM0GnLLrYJ4VqvoqI140oMP
         aTnTM5d0kXoimSFVBLaKm2MFPt4IUOTQlsf5AFa7A0LpMR6/mFAJEbGg8ppPWl/g2Kc2
         RqMudANipkOh1uQjwzOytrOlNswuIYm5NfG6WBg0gO/f4JyshoV5jQyJ/tr7M+H+QkNQ
         IIYg==
X-Gm-Message-State: AOJu0YwSrBf4J3typujSywJMFvvC5V2hu63qXpW5xVk1kDqgLqmpLoQk
	tWy3/qCQH/npwkYWow/TAIzaIz876avZaqWLcHSlI9L08QJdXKyRatC7N2+jYUMXO4xAo534hTu
	yBqUzwO/fWFYxPH2QaLIATwpve2zzqu0QJFjK5jl66w==
X-Gm-Gg: ATEYQzyRkRsV457bbwL2ypWRBFS476/ApwXXaaLoaCaSMcaHHYA4OQPtXg/hk50DxiV
	HaCwBDH+Z//mTlz636IxzTkBqMdF9N/Ts0yL4gBTObmbMRTYKnq0MnqInFR3Kv6bpctBjwgccdp
	PNWe1GtOD754q/SZN1pwcoyMKUUckuBdH8fWjTYuVbG/XmgWeBc/9FwT1u9C6uHaX6/7znQuFYo
	7dFOcTyaV495UKdBJdJB9hzVv29/VNxQz6W7RM993igJgErzZdkG8eoJI/f5g/+qr6LWWG3jfIo
	hezkW52AfpXXluAxm08FaFsLxtb54YAmz6z2AE8ERg==
X-Received: by 2002:a05:6402:1ecf:b0:662:a4d4:abe0 with SMTP id
 4fb4d7f45d1cf-663ba9c2abemr3063467a12.3.1773435835673; Fri, 13 Mar 2026
 14:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313180352.3800358-1-puranjay@kernel.org> <20260313180352.3800358-3-puranjay@kernel.org>
 <CANk7y0jjd6XC7nd2BxtsVhs8vWp_9cC-ckXPGRQK_CW5BSuogQ@mail.gmail.com>
In-Reply-To: <CANk7y0jjd6XC7nd2BxtsVhs8vWp_9cC-ckXPGRQK_CW5BSuogQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 13 Mar 2026 21:03:44 +0000
X-Gm-Features: AaiRm509-qHusHx4y7ZJiuiluPbpVvicudHEcA8o5FlqQsneTuZnsmCxW0jMUuM
Message-ID: <CANk7y0iGmXCLNPJ=W4ZV9tRwWXXK4KmTATfV081kLX51RxJmkQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/3] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:59=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Fri, Mar 13, 2026 at 6:04=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Implement the perf_snapshot_branch_stack static call for ARM's Branch
> > Record Buffer Extension (BRBE), enabling the bpf_get_branch_snapshot()
> > BPF helper on ARM64.
> >
> > This is a best-effort snapshot helper intended for tracing and debuggin=
g
> > use. It favors non-invasive snapshotting over strong serialization, and
> > returns 0 whenever a clean snapshot cannot be obtained. Nested
> > invocations are not serialized; callers may observe a 0-length result
> > when a clean snapshot cannot be preserved.
> >
> > BRBE is paused before the helper does any other work to avoid recording
> > its own branches. The sysreg writes used to pause are branchless.
> > local_daif_save() blocks local exception delivery while reading the
> > buffer. If a PMU overflow raced before that point and re-enabled BRBE,
> > the helper detects the cleared PAUSED state and returns 0.
> >
> > Branch records are read using perf_entry_from_brbe_regset() without
> > event-specific filtering. The BPF program is responsible for applying
> > its own filter criteria. The BRBE buffer is invalidated after reading
> > to maintain contiguity for other consumers.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  drivers/perf/arm_brbe.c  | 70 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/perf/arm_brbe.h  |  9 ++++++
> >  drivers/perf/arm_pmuv3.c |  5 ++-
> >  3 files changed, 81 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index ba554e0c846c..db5e000b2575 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/types.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/perf/arm_pmu.h>
> > +#include <asm/daifflags.h>
> >  #include "arm_brbe.h"
> >
> >  #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> > @@ -618,10 +619,10 @@ static bool perf_entry_from_brbe_regset(int index=
, struct perf_branch_entry *ent
> >
> >         brbe_set_perf_entry_type(entry, brbinf);
> >
> > -       if (!branch_sample_no_cycles(event))
> > +       if (!event || !branch_sample_no_cycles(event))
> >                 entry->cycles =3D brbinf_get_cycles(brbinf);
> >
> > -       if (!branch_sample_no_flags(event)) {
> > +       if (!event || !branch_sample_no_flags(event)) {
> >                 /* Mispredict info is available for source only and com=
plete branch records. */
> >                 if (!brbe_record_is_target_only(brbinf)) {
> >                         entry->mispred =3D brbinf_get_mispredict(brbinf=
);
> > @@ -803,3 +804,68 @@ void brbe_read_filtered_entries(struct perf_branch=
_stack *branch_stack,
> >  done:
> >         branch_stack->nr =3D nr_filtered;
> >  }
> > +
> > +/*
> > + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> > + * self-recording and return 0 if the snapshot state appears disturbed=
.
> > + */
> > +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
> > +{
> > +       unsigned long flags;
> > +       int nr_hw, nr_banks, nr_copied =3D 0;
> > +       u64 brbidr, brbfcr, brbcr;
> > +
> > +       if (!cnt)
> > +               return 0;
> > +
> > +       /* Pause BRBE first to avoid recording our own branches. */
> > +       brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > +       brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +       write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> > +       isb();
> > +
> > +       /* Block local exception delivery while reading the buffer. */
> > +       flags =3D local_daif_save();
> > +
> > +       /*
> > +        * A PMU overflow before local_daif_save() could have re-enable=
d
> > +        * BRBE, clearing the PAUSED bit. Bail out.
> > +        */
> > +       if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED))
> > +               goto out;
> > +
>
> The code below doesn't implement filtering, I am currently trying to
> figure out the best way to implement that by reusing
> read_branch_records() somehow.
>

So, I thought about this more and feel that we don't need to filter
for a specific event because the BPF program is not associated with a
specific event, rather it is associated with the CPU where it is
running, So bpf_get_branch_snapshot() should return the branch records
from the PMU of that CPU. Now, if there are two events on that cpu
with different branch filter types, let's say
PERF_SAMPLE_BRANCH_IND_CALL in one event and
PERF_SAMPLE_BRANCH_ANY_RETURN in another event, the perf subsystem
configures BRBE to record the union and then does per event filtering
in software (brbe_read_filtered_entries()), but the BPF program should
still return everything that was recorded on the CPU, which this patch
is doing.

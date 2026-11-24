Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795554021;
	b=1/jFBynqoaovnxPAhaUWpx1TifRD44iODIPIr0ZOZ3iXCPM2zpNd6KI4fOVSWD/seyyi
	 HVhZH/z/DznmB6fxrN/agpKs6dC5SiCcN9cTTxNupnrBMkcH5ThbxIlKCKHyyDVlszuQ0
	 xtTyNFl6E8IrxpndACT+l2j6niDm0s+A2wAs1wbw/PBtIbj0Li6NPUkzHDBqTA2ag99h1
	 mAfi4JvABxafJ/7X4LD9NmFEi7ca6xf0h/JLUu+r1J5Ui98HMj9FVljvnaPQIRXLVknq2
	 8+nCM171xCyS5sSwPTt8QyHf/XuyvXY8V7xQtkZCryFQrgvLKCNZXa64j9j2rcJmzlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
	b=mNglZhEtZoiV6wRWVXG/qZh1sas2R5RcEba4cpj2nfDreMDhImXzwbPaJVRKxRKAKi14
	 DN44PliJoXIVzsQTsWLeBWToSOFh2UzENV2r8evUt9bbln9c/6Ka1CJT70X/y/HBcYIYs
	 0fKwZUXRR3HzItBMzdK3nR2/bVQ8vxe3cqqbFj1pP6j8UA/IKR0sax4m/InpFRLIFBsLr
	 jZKf4v+39/X4Av0HAfNkUeagcyApijY0fRqYJIjFgkbLEeDFx4pDhoV8IiN3Sqtlj5Ssc
	 8FJW7CAlLOlEeeiW1mqcPVgG+GOBx88jkto17c3KQpyspNP9iRIsoFZVlaNNrg/+TwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GJtYiR3R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0E606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F0E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GJtYiR3R
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55be673e029so949201cf.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795554020; cv=none;
        d=google.com; s=arc-20260327;
        b=lC7Ph4NPoaFMiFC1XIvmwPYJtJmldcbiS/BQ63NXsaFbaYxHs8rmQAD6oJdbgWvisE
         yz0/BmcqpOkVwDu6jjuj0/xl6DZjLH6DXv4KsbBDOHyEPuCS/5skwvSkRGKU5YS1IN2q
         kojI+IpQGY1HzZ/QerEnHncZAwjRSgM3VmH4ws266ejcd92kkTwXA9i8hP/5kwR7CiSI
         naIVLcIUfwBWx2diyRHr++mADaSD90K5aoyf/YpOy0oxPkXkC1g7Wc6vW8SDx3RgPj2N
         OEfcDQide1NE2D7BYfzZNdthVmDjvWkzlAjan2HzQVR1hEeXYbJJ4bsq/GRi0qdQyroW
         eEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
        fh=Etay4Y7+wfG6OIUk66QZSaLE5z2+BlRHnynHGs6piME=;
        b=JSnVR3x+X0z9tj9txGt7nXRBdivXgxxBdFcBPCtj1lvuiKLQjfB1nhps/h/pouvaQ4
         JWnCNKtc1NGHdi7sRRospn0g++/ByDDu+v5P6LMvItBdZo69d0XM4CMvBhevRAXiHJtb
         jldUlnSysws/Wfa7yN8samN5gt9lbOiv0pg80ZZi9BE3BMKg0nstEcqEYNHogaRp4Gy+
         l2jVdHccRY6msPR7LVjX5fgpFRSrOXTmc+VN4rC2Hg2ooix5Sor4Rj1iGJ9NgnLlEWx3
         3IpKBg9ZSytpkYScPnLbPeeeSY5yvioDbzv9OhxsXnrSWxAB+AD9GSvsVNEMaWBkNwMh
         HQ9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795554020; x=1796158820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
        b=GJtYiR3Rp5d21pM1eit1vwUjg9DtAdTjyG73Eec1SXS8BjdFWzjBUE6l7LyjFkaogd
         ht9d4ym8UqcALr/3fAivC1esY0lcWUgDVVOyCf81+iRnF3d8eJ6msirInV+doCr1kC+1
         49h2xbv1EAB5ji716yA6/GUt55bq21BFn1OWaGUGU/u4022/6YXWZwy5FDsVK6DZ4MnP
         iBnlkQhXKrJJGwlc9KINKAuOT5bjkIShsmF5bj14/OKxy4gwENJl+4nwMXCkHd6cQ5nm
         cgrOEQeida4AdPc4A7aUHteS33n8Rn8rKspbnnZcj/V9xZErVGt7g4UsH+cKbb9RxUPU
         KLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554020; x=1796158820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
        b=ec0Y9XHh6jH+08CEW2HvGTHOaf/UTr5tOy6nbQmnSy61cqjNIZ5xejnsXNXge/jzQF
         xqZKC6jTK8YkSGeDsnD4kK7drGgn42ceCjwJ0DvLPsiuxfEcW+7z9SXXZaoIzySC6NG6
         rNpWH0ZVBceM34x5AHfLlB5BhPLTtbtof8apvQshoyVy7TaoIToB5Z8ss5QPBesnzqBZ
         8bdmiyDK6L/xd8g6UJ3vHBe8bDmd6VBhuJPAu+3uptRsCgmRKEDQIch//K6mFI8g78QK
         v299/q4IrGzUr2uNQYAF4Vapatd3smADkSDwLWccJ/LSDhO/lVZR5Z/IE+RhmOsuILvr
         Nt3w==
X-Forwarded-Encrypted: i=1; AL+hErGV4H4MQRe905XWnQX1381kuw6sb8tV7j/z2b26SphmJS83KSUJR+JUpIZvw847f+IliW8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HS55hJbF19ENPE8avd518fLdHFjPuAbdgB4ypp6xucPumT5eF
	SKdtRjHzTwlE8AlYML00gLFtKtkCyo7cXIHec9dAF7P/OV5eimC7hJnYorMQao+pepWaCpyc0uk
	84dhrnTWF7ssNWeh1KnzhLX1DlpmYvItItp7IJsMh
X-Gm-Gg: AZFdTZeArJcJUvH0mE7HwWjfcxK9axPWkIigJeMpxbpBTc0J3HnZKc0Yq7WiWYEjCYT
	3pC4PZm6TwM7loPpr+OPJ0oSFZ9XNRIvtpp27AcCzO9VmC25hy/lJyBejQJ5wKTT9rgkjkE4JyR
	zhXgp7g7F0Cr66Ap9DMulbH4x9y/ChRMuNm/k1Fd2CxdS9+0Ni8yfhNts6QBRbv0nHPmCaUD1mO
	X+1QJwmcvTp8j0tQSyonzC9GXCYjPmYvoV4hes2n4vBvX8/9mB+kh3ctbOLgsZjserL4EkCQxAN
	HQdp+rGRkvoWMXi5JvBUYYVn6/ArV/jh01MwF6AraYcVVzbQK3ZBWloxflgalh2++Tvv3kg4X4e
	SpzRhRY4jTX2KSRdDkIFfFgX7Xk2PTrb0grnhVcheh5y/focQgeOyWTzqcc5ioi6F0FY=
X-Received: by 2002:ac8:6f05:0:b0:55d:74e6:e03 with SMTP id
 d75a77b69052e-55d87eb573emr70187881cf.0.1795554018819; Tue, 24 Nov 2026
 13:00:18 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com> <20261116074414.3174737-4-irogers@google.com>
 <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
In-Reply-To: <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Nov 2026 13:00:06 -0800
X-Gm-Features: Aa3M54pdXM1oIOYL32K8_t7w7fCY8XhU-lLpLLFWOFQ3DDBOcdGlds-hyc2pHCM
Message-ID: <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to UAPI
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:36=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 16 Nov 2026, at 1:13=E2=80=AFPM, Ian Rogers <irogers@google.com> wro=
te:
> >
> > Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> > PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> >
> > For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> > PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> > set), encode a deduplicated table of variable-length build IDs
> > (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> > u8 data[size]; } entries padded to 8-byte alignment) and an array of
> > 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> > 0x00 for unresolved user addresses and 0xff for kernel/context entries)=
.
> > In common cases where multiple callchain frames belong to the same
> > binary, each unique build ID is encoded only once.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
> > 1 file changed, 54 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_=
event.h
> > index deb7c42d109b..775420ed9aee 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -165,8 +165,10 @@ enum perf_event_sample_format {
> > PERF_SAMPLE_DATA_PAGE_SIZE =3D 1U << 22,
> > PERF_SAMPLE_CODE_PAGE_SIZE =3D 1U << 23,
> > PERF_SAMPLE_WEIGHT_STRUCT =3D 1U << 24,
> > + PERF_SAMPLE_BUILD_ID_OFFSET =3D 1U << 25,
> > + PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET =3D 1U << 26,
> >
> > - PERF_SAMPLE_MAX =3D 1U << 25, /* non-ABI */
> > + PERF_SAMPLE_MAX =3D 1U << 27, /* non-ABI */
> > };
> >
> > #define PERF_SAMPLE_WEIGHT_TYPE (PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGH=
T_STRUCT)
> > @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
> >  *
> >  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precis=
e events
> >  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> > - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> > + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
> > + *                                         PERF_RECORD_CALLCHAIN_DEFER=
RED events
> >  *
> >  *
> >  * PERF_RECORD_MISC_EXACT_IP:
> > @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
> >  *   Indicates that thread was preempted in TASK_RUNNING state.
> >  *
> >  * PERF_RECORD_MISC_MMAP_BUILD_ID:
> > - *   Indicates that mmap2 event carries build ID data.
> > + *   Indicates that mmap2 or deferred callchain event carries build ID=
 data.
> >  */
> > #define PERF_RECORD_MISC_EXACT_IP (1 << 14)
> > #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT (1 << 14)
> > @@ -1095,6 +1098,38 @@ enum perf_event_type {
> > * { u64 code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
> > * { u64 size;
> > *  char data[size]; } && PERF_SAMPLE_AUX
> > + * { union {
> > + * struct {
> > + * struct perf_build_id bid;
> > + * u64 offset;
> > + * };
> > + * struct {
> > + * u64 zero;
> > + * u64 context;
> > + * u64 cookie;
> > + * u64 ip;
> > + * }; && attr.defer_callchain
> > + *  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
> > + * { u32 nr_build_ids;
> > + *  u32 nr_offsets;
> > + *  struct {
> > + * u8 size;
> > + * u8 data[size];
> > + *  }[nr_build_ids];
> > + *  u8 pad[];
> > + *  u64 offsets[nr_offsets];
> > + *  #
> > + *  # Entries in offsets[] include PERF_CONTEXT_* markers (which
> > + *  # have top 8 bits 0xff). Kernel/hypervisor entries (after
> > + *  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
> > + *  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
> > + *  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
> > + *  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
> > + *  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
> > + *  # encode a 1-based index (1..254) into the build_ids table and
> > + *  # the lower 56 bits for the DSO file offset, or 0x00 for an
> > + *  # unresolved user virtual address.
>
> Hi Ian,
>
> On PERF_SAMPLE_BUILD_ID_OFFSET, the layout comment doesn't say what is
> written in the non-resolved cases. For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFF=
SET
> it is clear: kernel entries are raw 64-bit values, unresolved user entrie=
s
> have 0x00 in the top byte, and resolved user entries carry the table inde=
x
> and the 56-bit file offset.
>
> For the PERF_SAMPLE_BUILD_ID_OFFSET form, could the comment state:
>
>  - What is written for a kernel IP? (e.g. bid.size =3D=3D 0 and offset =
=3D=3D raw IP?)
>  - What is written for an unresolved user IP? If bid.size =3D=3D 0, does
>    =E2=80=9Coffset=E2=80=9D hold the raw virtual address?

Yes, in both non-user (e.g. kernel/hypervisor) and unresolved user IP
cases, bid is zeroed (bid.size =3D=3D 0) and offset holds the raw
instruction pointer / virtual address. When attr.defer_callchain
defers a user IP, the union carries zero =3D=3D 0 (so bid.size =3D=3D 0),
context =3D=3D PERF_CONTEXT_USER_DEFERRED, the stitching cookie, and the
raw user IP.

I've expanded the PERF_SAMPLE_BUILD_ID_OFFSET comment in Patch 03 for
v4 to explicitly document all of these cases.

Thanks,
Ian

> Thanks,
> Athira
>
>
> > + * } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
> > * };
> > */
> > PERF_RECORD_SAMPLE =3D 9,
> > @@ -1306,8 +1341,22 @@ enum perf_event_type {
> > * struct {
> > * struct perf_event_header header;
> > * u64 cookie;
> > - * u64 nr;
> > - * u64 ips[nr];
> > + * union {
> > + * struct {
> > + * u64 nr;
> > + * u64 ips[nr];
> > + * };
> > + * struct {
> > + * u32 nr_build_ids;
> > + * u32 nr_offsets;
> > + * struct {
> > + * u8 size;
> > + * u8 data[size];
> > + * }[nr_build_ids];
> > + * u8 pad[];
> > + * u64 offsets[nr_offsets];
> > + * }; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
> > + * };
> > * struct sample_id sample_id;
> > * };
> > */
> > --
> > 2.56.1.703.gf848ed807c-goog
> >
> >
>

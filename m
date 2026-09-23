Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B598353A6D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182000; cv=pass; b=UX3ZQaUUgBGW9zDnd6HqIwzxq5o1mm3PwxXkkSIuvaodCjwj1V5XknL5uS3qyvd6bEsmVG/k42Qh9I3G7mWf4PVE8kq8f7et1DBOofWxj+rycUkiZ1HarNgzsPgRQxD/do9haZj+f/ztr41isQ062g/+EWIMqxUH2VU9z2NF7f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182000; c=relaxed/simple;
	bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMBMy13epzT1BL9jPVQn7AtRBEWltzS9LFdGje4c+jgI+XPaK/2yVDxZB5c9jbo45/zZk1SfNuUDkb+wfWXoPww4K7CNgKgRLRExhppe6jXZa0tmn8Z9EsQeZlVnNBHBWnve/h1LngLRoaJ3Vo3tT4zlcYDJn/4Fe0pRR8pNNwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG1Oxmrg; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG1Oxmrg"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so866532a91.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790181992; cv=none;
        d=google.com; s=arc-20260327;
        b=jzNaHbjk8GYfjqGcCHhf5/Y0uMUlQaHhWta8alT5RUF9VW03qF/oHlXvpKLsCy3rtH
         0CGF6qcibxXGuMzyZL+jLpJdi1pGYygQPyMoUeq2IvMK+MsA4z6999UBgbpTrkwrgpzZ
         hmW/dCao0+YihkDkdGgQ8mvMl+t548ViU0T6XHHRlkQS/rK4e+CN/mPJIszZ2V8XVEnz
         y4dWbF6dqYAI/Ub1jvJHWpCJk3AsIzxWhusppywUJKKdJ14yTa4chxAd9bWQviu3l5NK
         v1qdk5xDx2uv9wp79jkHLytDhPuMB+7A5iQj7aNpQad9lJwWQauNfjcOvfG68QGUvfNv
         ESqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
        fh=+21IwXNsYkxamTjqiiX92XpEnQNSmr7ELBdsufPNyDo=;
        b=PD7mFXjY9+jm5VUPqA43zq+fCd/xyL0cy79tcj5fbVLZM4EjorD/xcurBuqYSl4iC1
         lEwx8ehgpnPcZWd8Ng2wVd3ckEbk09Rt7pKsnJofHJTE5gb1TRWvE5KIcweV+WBgclB7
         LyijURAebSfeLIgieY4mIfxNPBxh+FlqWGo811eSrkCFuOutGcCoeXy1Di4Gd2IvIjEa
         EgAW1GYpIsZvIP5qzhYRDOMA4bQQgncgZwpbFKP2UM3FG+EsxT0HPb0sLf1gSErWQjr+
         /2nHUkcEZBPMxZnt+Nm+Nvw1RWkFkvDr2mr/BVkX6WpsS3a2EvNrTC1PwQfh3X09uOD1
         RoyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181992; x=1790786792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
        b=jG1Oxmrg8SoCun82jI7IJOzdWpUCh8nsLGresy3WjZzOmnNw9TFzaYm2lScTqqhEfi
         ycyDlLE1qFfJScNNEZWysX0vuY0XS4VU9d0ikXOM3OvzHA8NAmXz2E8oANLSsXgceiWP
         z6aO4M0J/Bo1wjrE7va8Z5/TnpRv5OH06LVMym6bbXtsIzuHV/+ywjENODEIrl80YUAE
         riOe4Y9fL2jUwC3bXBcyzzYl3Id+nWIW/zW5FoQk5mrhc6CrtVYVBV3p8/bBvj5NeiLO
         /H8krlh/Bfr+wVNeSf/mC16FraPg0fR+0EjbjZ7idzZPu3Iet3WnajfkCxYVDf1ZA2aB
         Ch3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181992; x=1790786792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
        b=h+fxaCeN7KSx9Wpg0+GK6mCaJEcOS/tycYAoCouP5Ax3fMtctYclGus+HR4Eg9my2T
         sNCxf00NLBpPkgvukZQbb9zVIu21cdRJA8iLRJ363beFBtcaWgDS2vJO+kNsJ7rVP0Jq
         oNKbCWLXuyebB0PiJ7O5yM2R0Noi9D5ovOWSLUVKzpcTxTFrJGMgraMTF0SqyJZTdWaj
         TbiidIXqyFFJubZljjiODgG8Cn++HslAMnH62JCEP/TyxoWzm+sHd2IOq4LwHrjj+GgU
         DE+pgiTu6QFlskeVCuB2J8+S+JEn09OM/UegfF5XJhXNgFps6is54dBXS4Okhzf+iO7I
         jFag==
X-Forwarded-Encrypted: i=1; AKwUvBxzhOmbGeOnMKMvV/Lph+D7tC8GRe5C7miXTYRPKwNHf5iXvTd8sPVrzdYI/evxb+GxOgY=@vger.kernel.org
X-Gm-Message-State: AFuF++nuQtjsrvLOow1vL+LVDzhxpkbo/iMNsojy83YIRgrCsi0hP+Dg
	ISWeIoXjp2v/MzsDbCG9hgCMgThh8XM0IXQWiTxh/POkJbv58pvtvG4ujJLUUAO7gFCUAyKfPll
	08oIvHnIINOC14YvyItNuv76Js9KEwnc=
X-Gm-Gg: AYBFou2Fm4O82jgyxR0LPU9UtwRDxVD4L0+h8K4Z/7cxXuaa88DbyCpzqDibZLQm4wT
	9JLK/QdX1fvGg4Rp3h4NkOEslRioFgSAQj+kAEIe0OoPLdmzJspjowR1wjKO6JxgmRGF8hcBUWW
	qjY5csX+u3fsZaXbc33KYmCO9txj4qnvMoffWC9/DSurFOvg/+gy/Cfi4Jc/3A96KvehvmP87tK
	7c0Ujj6HA+SeAIVRNTlNo0KOWVNp0qvsPhldXx170AQcr7fge58gNi64Fja12h+fZzzVgyzXAiO
	WOFj7BBm93pAGWzuYJWcgnRijIRxkrDYygD9MpndMB67AhUHbUP6I2ETgsSpnZYmDJhqwUkdyTB
	a63V/bEOVTMDikovbLsPenEKNGDkz44Nv6YtQ
X-Received: by 2002:a17:90b:2742:b0:39e:4c7e:f03f with SMTP id
 98e67ed59e1d1-3a07e5808demr2908153a91.28.1790181992225; Wed, 23 Sep 2026
 09:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810164622.1829843-1-puranjay@kernel.org> <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com> <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
In-Reply-To: <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 09:46:20 -0700
X-Gm-Features: AcwNN1UoxvmW1a-b3T0PDtkRMDhPQq20k4NzNgV-SyDiYVuDhWZJEV9Emssz7sE
Message-ID: <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:15=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 22/09/2026 21:40, Andrii Nakryiko wrote:
> > On Tue, Sep 1, 2026 at 6:45=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> >>
> >> Hi James,
> >>
> >> Can you review this version of the patchset? It is implementing what
> >> we discussed in the thread on the last version.
> >>
> >
> > James, do you mind reviewing the patches again, seems like Puranjay
> > went with the implementation you suggested, would be nice to review
> > and ack, if it looks good to you.
> >
> > Mark, Will, you guys seems to be designated as maintainers for
> > drivers/perf/arm_brbe.c, can you please take a look and give your
> > feedback as well? This is important and useful feature for newer arm64
> > CPUs, it would be great to get access to this functionality that we
> > had on x86-64 side for a long while now. Please help get this upstream
> > or, if it's not in the right shape, guide Puranjay towards a better
> > implementation. Thank you!
> >
>
> LGTM, and the Sashiko review is good too. It does conflict with the
> FEAT_NMI patches on the list, and you'd have to disable NMIs but as it
> stands right now it's ok.
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>

Thank you, James! Mark, Will, do you have any suggestions on correct
sequencing of things and how we should proceed? Thanks!
>
>

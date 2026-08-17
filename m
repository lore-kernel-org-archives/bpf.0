Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EC32E141
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986912; cv=fail; b=Ff4ttYhCcp2jfhGddDasfhR1ZQc/22YzsAgRqqsQTnkCmvwKPAQvfTlgrjWNFBGi/M3T5TwnbzO3LC8HjOC3deKYRWM+ofRdph9lCMF+ekzyyH55z2FXPlLuG0KRV6Xlrq35Gccd5XFV0Q8QpncXGB2ceoUVXTz5nJ5pQfxlKvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986912; c=relaxed/simple;
	bh=unEk75h4RazW61+CTbm2OkL2vcW2H4HQkbdjsMJg7J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRgLSDMAMqlgwkLcXf1j8b88QH73HQokWN5BkPrbfu3xCr0cEXoJC3C4iI1MZjkgdBhqHab6QQqMdcjBJl/kogMnBPrahdbJncr3ED5MPCutmoq5hPR2/1OZFdz6OBWuGBMOkQOCgr/dKMc/XDIcvG0HW1VwjFZX/R1t/uliLzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dYHCFhF9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dYHCFhF9"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYflf694500
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 10:15:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=njvrH7x9GyJo7i1wnbi3Q46/eHKvNpCFfvtLC
	nuO51Y=; b=dYHCFhF9ZhRPYIkTaIZmQc0ZglDsa4tQXTidjHGegc8Gw5Cpb3CC5
	jZ4EuhP48kQfwBiMyKsfxMUgn43+xOFIUAhe62uOGQQS3MuGbjQyN9z0ujdg16Kn
	b0QQWNAnd129mksesLlQ6reh6gJUneiPcWKWY6nhA92yfZohTJZVymfiZNk+FI49
	0xb1/Cci7Kca6EYtez1nlz/oJlFCUHx/7eaxoJCLZmm0Ox+4amX8PpFd2XAn7MWX
	IKu3bfuMqtfOxX+y1dWa8ae+IvocL++PENBgLG67Al4wzPJnPnRlLpzXKlxLm7gm
	r7s8fUI/gYuAX69o4wWb0DSA3/kYuZM1w==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g2nmca948-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 10:15:09 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b28dafb8e1so757458b6e.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 10:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786986909; cv=none;
        d=google.com; s=arc-20260327;
        b=rjQKXhaRZoaq8yXUXd5E3E4Td1i1wlRzMRVJ0rlymCS9MrDozXyMxGfpcBpo51AR6q
         oq9A9nEFYjmFaSlebXBi6Pi22R8XpEqt8thsLnPHVwo9XAXO1L9vDK2k9/hNpPRx91hN
         w5H8NWvZ4fcfelVdT+/C7GOj+Kj1PdYQWC3Qzrnq0FJhZfxxl6pBFtZPzqYs4JNRy5Bz
         gBZ/H65kLbYOdYaZcw12rNaHWL2hRuesTjKBnjwPNcrsMZLBRBoC0gJa+v1Vezjr/agY
         qC+TaKKYm32Tk6PFvdYTDX5kBmOvrQ132WAI90oxuCcE86OdgSbjFnl3g5WpIhCkzsS/
         aTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=KoTFa2IJT7Dn6m6sQQ51SO0r0kVa/rVmT5mp9uvRqLo=;
        fh=1P4xwmek5WDiAdcINV3f5xiJ53Zy2w32qtDjxVPFNR4=;
        b=UVoa+xLWzXrrs617DZLIwSeEGgUuTzqUAvT1OAs6xRK0HoCvi2dOZ/qj6a6dt+FmMt
         40lYabQSZTbrrG34zVdSCJRYqDDfo9CHs+KJaOa2AVhfsBxw94IMv+SgfnKAiHAGBQIg
         AMioSYuNWJP37HlLUt9Wa2HCYhkMs1cSRCxeEqR7rmZ1XvbaxYoL06R37DxanE9anqL4
         UfwuWPnubUwkUIropljcUqlNW7lN7o6cqmNrEgnnS71YuuxOEqwOIXyK1KIZVEYkNGtY
         3LWbBFe8bPYBfj/AKySf/YvRmxUzmuxzD+9CCBz8BuA/tKVpCZtglhMnjfTH0U/LJAZT
         7gVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986909; x=1787591709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoTFa2IJT7Dn6m6sQQ51SO0r0kVa/rVmT5mp9uvRqLo=;
        b=Mck/3pv0c5oCqgmmG+J0CaRbMNrZrE2c64BXazfhi4zy9mLIuhxV7Lo4CDMQcUyqYk
         8qC2BxewMfb1w7g7hn48haPYhuXk6GwdEKkBKhNmQSm0PS8ImUoJcOsAub/5uR7j2vvL
         bDutRzCUlvwk9TeYOU59DlgotMZ32Gf4PErLebtngII4Q1Tbcn5Pz7SmHB8RbdHRYQlI
         6SoIO0tbn5QJ2yrFKkOXKqhg5L+H8cDwSbIGlCrkRFkHmbVdE7eYA3Df9PmnjIlyv7xi
         dm6L/3GCWXKJ0cuTA20tkZIGXryPD1fZwYbp/FmFL+Gzn5BrJ2Mx8XNE1lrW8TIf9JXb
         +UxA==
X-Forwarded-Encrypted: i=1; AHgh+RpSCuzcgkzNXAxVWbHbLzgXUwxUL3414NSrU0TEE9XvXNSbqkzZ/vtKVWzW9e4EfBA8DdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkH/vsA8iFvFyg8tFFA+s9JrJAoQushpEgSfzK4FLFFtNGKpD
	y74q+/UPMjOVHMtDbsdrq1QioUqslP/FSl676Tx5z5T/mB/2VpRj8PEJ08ROYhvAf3OUwlOvcO0
	xdeo+gJgSCuAB+KvdNLy7Zda8PoDwGXrK78EnuR7KVBfrQAdfJk90+MYxX0j0nhEI4P7sihT7PV
	MW3wT9LQWkizLtjkzHzaXnVDUdlnw=
X-Gm-Gg: AR+sD13svTHfgim07lQx62cy31hHiTNrtN7X+XcMDZN6orff8Fm3eHAL0NJVj/r9Ir4
	anPAjUhOBE04J0w9aaJPqBCfRq2O187tDWlQbpIcIttKuSSPE7CcGUPpzOEiMdIC/AeM1/ms1hF
	VALFfbQNwBd3mmVq352NrI6pdTXjhSOi6a7DHyDBpiHqWr0wFkxrgNHLYJPOcTJYuXKDzx8kOnE
	bBwy7m343kIWTLf
X-Received: by 2002:a05:6808:3502:b0:489:a387:1e29 with SMTP id 5614622812f47-4b297a4b8a8mr2209409b6e.20.1786986908704;
        Mon, 17 Aug 2026 10:15:08 -0700 (PDT)
X-Received: by 2002:a05:6808:3502:b0:489:a387:1e29 with SMTP id
 5614622812f47-4b297a4b8a8mr2209358b6e.20.1786986908219; Mon, 17 Aug 2026
 10:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803001807.646357-1-changwoo@igalia.com> <c9f8616b-15df-4c5a-8184-bf4d63813afb@iogearbox.net>
 <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
In-Reply-To: <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
From: Emil Tsalapatis <etsal@meta.com>
Date: Mon, 17 Aug 2026 10:14:57 -0700
X-Gm-Features: AcwNN1WgYsoY-VjTAIHqOFfCfsXsbtxggdrhdfKy9FCfC4rkn4z_jRHt57GCGQ8
Message-ID: <CAMe2y=Gm9K3cwsM7Sff3ZaKani3z4tVUQv9u1KzbetJF8OrW=g@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
To: Changwoo Min <changwoo@igalia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, sched-ext@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: bt-U3efIO4r4tgbCCc4Ixtdcxvp3QhCg
X-Proofpoint-ORIG-GUID: bt-U3efIO4r4tgbCCc4Ixtdcxvp3QhCg
X-Authority-Analysis: v=2.4 cv=CJcamxrD c=1 sm=1 tr=0 ts=6a83419d cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=V2sgnzSHAAAA:8 a=CWErhr8FAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=Z31ocT7rh6aUJxSkT1EX:22 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzMiBTYWx0ZWRfXyUXAIi1n1Cqc
 e3s0xRqFHAJny0AGkxzrgAWrpYbibHURb+31H31tr6mHup9hmPuqu4lqxX4pCbSpSfU7k/IjJ04
 EZEGAc+n8HR6D2Y57vD0+vokAMIBSJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzMiBTYWx0ZWRfX8OEXPYY/Qw6s
 s+3WGAV9C9R68T2UBdznmiHeFy9xGcpmePpNbYFdfzfJuTSTqmn6IqquV97RtKBMtL1OIFGHtB+
 kp2GkJm+u4gOU6qNfA4bkTrOLZP2odiLQFK/YkRSdoy/YSX9fsq6t9n0fiFo0WGnG+cwXZrE7Sr
 AgYw7Du8ZHv7oTZN0/keBNwCGeAqA+QxFhNNFq4UPbHTSKL22Hgmn7izidRcWQKx36fVB7/n0mU
 283Y9iOfPTVEqtEx9QaDLBfJ8aCwinx4M6y437cyzB7Vk3Efg9LMSmjxc/flsP9pefAqnySIWWX
 EaEnYTutzzpud+UP511tNsszgIY2p+Uc8IPS0Bk2jfmrG9uaU/Ls0J/rt9hVe4hRBBfNcn4cY3l
 hcw701eUdYXwUSqoMkXq3tY9gwtFU7RDbBzE4v5A0TfBWJBfDSNjhOOq6XE/DSm2N1ANTLt/9Sl
 zcnR1DFI4ocHHoEeB1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01

On Mon, Aug 17, 2026 at 9:02=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> >
> Hi Daniel,
>
> On 8/17/26 6:05 PM, Daniel Borkmann wrote:
> > On 8/3/26 2:18 AM, Changwoo Min wrote:
> >> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
> >> every translation unit including it emits a copy. __weak makes them all
> >> resolve to one instance, but bpftool gen object merges only the symbols
> >> and concatenates each input's .addr_space.1 bytes, leaving the surplus
> >> copies unreferenced in the linked object.
> >>
> >> libarena links ten such units, so nine copies were dead weight (bytes):
> >>
> >>    object                             before       after
> >>    -----------------------------------------------------
> >>    .addr_space.1 in libarena.bpf.o    676200       86376
> >>    libarena.skel.h                   2100123      892371
> >>    libarena_asan.skel.h              2641124     1466477
> >>
> >> Declare qnodes in the header and let each program define it once:
> >> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
> >> lock it guards.
> >>
> >> Tested with test_progs -t arena_spin_lock and -t libarena.
> >>
> >> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Hi Changwoo,

Sorry for the late reply, for the next version feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> > This doesn't apply cleanly, could you respin against latest bpf-next?
>
> Sure. I will send the v2 rebased on the HEAD of the the bpf-next tree soo=
n.
>
> Regards.
> Changwoo Min
>
> >
> > Thanks,
> > Daniel
> >
>
>

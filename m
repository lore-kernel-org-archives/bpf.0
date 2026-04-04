Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC02E2840
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775326018; cv=none; b=ndiQlacf/fyjXIh0oM1nnlmf3xzZCMI4XSwljlYpsJ4GBPzvMb6D4VSLo1UJADZweYHXr5Nc+bqviE/ug0njiAJxEDE3yG/Gx4tRqXneQbpi9xNAwqlP8k1l0pD0g+szzAvMp2aMTTO22zMz1V+U8NjuucthSzzx6Ua3un/6mMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775326018; c=relaxed/simple;
	bh=YgYZbx2AGsW830c3dKD21cYqlNf7GwmcC821skOlqRg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RcFSSeg9q/se2K7j7LWcocFW5rtkb4iO6D4NMUx2nxEOOdwc+QTyDsxyULEvVCH2F52vTceYZ/CXWjTaqOLdgsXquDGGX0J8E8y14YS4FH2iG8aK1rIpi5iy7rThNa7qLtGsPMFYGAMHvcAzMjV/h6O6tmUsFCZ3dUKCGn6avi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cdkMKLaq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cdkMKLaq"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76af79f029so1073863a12.3
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 11:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775326016; x=1775930816; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZppCc2r8EbA8VC7Kv1tg3yl1XcFP2wgjfgwCldAJgzs=;
        b=cdkMKLaqsV82bV4WWLgFlX+oovG62wteQKQAfmbzwW+xWkruXIPhAFtMdppNP+Zcbg
         w33PFiCZe+2aazRZ7GetJp9c/kain8BtUFQ5Bi0htK7QgWGbI4/tqr0dNOgHbmZnNApU
         o5/2Zpdv6ZgpsWxrszg2rRmWqr8hv50zIf4ZqpxMrZSajRPkI8XIzidcwNbCY+Qmgii7
         0lMaPNmaV4YNAkP/zWU6j2RZz0WjCMkLCNA1sPAYmxM1geFzjYDPbJlGqYT3fYhHDAJH
         lGchX/MyDxod98fRpXGAaPgMB4NNamt6QsK7jHb4xO9rh1YQHU/nTYP4V5v5Pql86fQo
         nxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775326016; x=1775930816;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZppCc2r8EbA8VC7Kv1tg3yl1XcFP2wgjfgwCldAJgzs=;
        b=qr17Ge5ZYxWcikTq6NkN7U4RVS29Wkcm2Kg5+En+Z4UfqOaIyhI63gXMGvGoNLoiUO
         ME3dGNNouRUGOLnIjB9GloARnYuU3Tv91wwrCAiN2SLd8Wkd3Qe1xveQja18kv5qVGkx
         9h6Viy3ZS29J4nzAMuXT8LlcY2kvGa6x1ag/7omB//nxNzkV+9HURvmJCy+cRteuaAwH
         QMmeMzlDiAO73OlbrtzfgE5DyFsmGtv06s9QhVn5LJdYIulnze+tCRDrfYIg7qpg/MHP
         rpGkAhGYzdHLgG/9kmKTtmJPbD5CmUlDPTyLkBFW1BMMdluq+36o4Vi55jMFUL1dba9A
         NiOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeGCze30Wxhb+OfCJqBA7zbXgplHL4gegaY5zOpQAa6VniBsN3VuCtg1qkix+I1jqsXNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrnU9uR1zXnIsArA8jBEe6/8caZH2sCPI95Hw3XtKL7lPBl81
	mNJUVtdkz4FiLrZqM8GV+HJSYmNS1JodGo/UuTh+GnjHSPTaK72MfbsQwsSFEmb0jN8=
X-Gm-Gg: AeBDieu55avlY9jwRHX6Dc7dLQ8eZJC8OOJ09e3sRZYTC/jRA9/wQxR3sFUpXmkJEHS
	/uSpDsWJkPsUBlQ6fksExvDfrv45BGj8yBfUHV/Lpqz2R20Jqrc+6uWBoHGaqCQ8UPbi44Bchhx
	56j1Lw9EUzbsc/BfIqcFeD7jZkMh2QftIBpEar0XNLLouf/Z2TWK0VioWCnmHB434lCvekNJ0By
	h7IMZDJQEuVeFXzP2WCMWrYyghc/Qf2nGf3IAIjrREqW17X4eDyl3Khna9MY0vT12MjGwKwXR+x
	lbG3acXDO1QlBtN33QOnDVY6WNXl645Qp1Bj22tZBvACUJh7mlkllT0DPKPlHUPaaZ1abwLdl8l
	zLMOeRDxsr05Ggsc81nqmBHw7bX41l4g34pcHYpcKJNrfJo0qBX8fqFK7tR1sLg6ll8vyneo38z
	NJdm5yIIg=
X-Received: by 2002:a17:903:22d1:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2b2817b3e21mr72069085ad.36.1775326016374;
        Sat, 04 Apr 2026 11:06:56 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a348esm100190405ad.57.2026.04.04.11.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 11:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:06:55 -0400
Message-Id: <DHKKJS9TB2PD.1AEVJRSJD6ITY@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3 0/2] bpf: reject negative CO-RE accessor indices
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404161221.961828-1-bestswngs@gmail.com>
In-Reply-To: <20260404161221.961828-1-bestswngs@gmail.com>

On Sat Apr 4, 2026 at 12:12 PM EDT, Weiming Shi wrote:
> bpf_core_parse_spec() parses CO-RE accessor strings with sscanf("%d"),
> which accepts negative values.  The downstream bounds checks only test
> the upper bound, so a negative index like -1 slips through, gets cast
> to u32 0xffffffff in btf_member_bit_offset(), and crashes the kernel.
>
> To clarify the kernel-side concern from v2 review:
> tools/lib/bpf/relo_core.c is shared code -- the kernel compiles it
> directly via kernel/bpf/relo_core.c (#include).  So the fix does
> apply in the kernel's BPF_PROG_LOAD -> check_core_relo() ->
> bpf_core_apply() -> bpf_core_parse_spec() path.
>

Since this text ends up in the git log, I think you can remove this
paragraph - especially since there is no permalink in the version
history below.

> v3: added selftest (patch 2/2)
> v2: fix typo Signed-off-by tag (missing leading 'S')
>
> Weiming Shi (2):
>   bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
>   selftests/bpf: add test for negative CO-RE accessor index rejection
>
>  tools/lib/bpf/relo_core.c                     |  2 +
>  .../selftests/bpf/prog_tests/core_reloc_raw.c | 94 +++++++++++++++++++
>  2 files changed, 96 insertions(+)


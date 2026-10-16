Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B990342538
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114817; cv=pass; b=oC0GbSFHxuDIc+H4wQsDetxOMyBpeRC1OY9oEU/AaSxCr/flpMdtVpB2v3UEf0wzX8ysDPufY83S6vJaUC9j+LNIJIKXzxqd9s4m7eIR3VPc36H/+zrfB7iaAH5gsel6zWGESGxfQvRlvROpCdChi5LhVUISuAPT9Lbs18Wgxjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114817; c=relaxed/simple;
	bh=laVeRk9tSFtv3PRQDN+Uc1JFL1FAyZeVVdavjKgSO1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhQZcUAIXrf006JtkRiUxBrNIX3DNDXoYB0yrswCi30/mYjUaR6Km7dFfHBdf2oiYQ1P7/Qjh6AuakGIkUQdKIQ96XPozjhaEq0EhKvXX4entfkpX76m3yTFNRLsvAVUw6B6E/b2F+t/qJkGRMDCFrvaTxD+XXZYnQ5l6K5I/d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGHXuIHL; arc=pass smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGHXuIHL"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4a0f23b853dso19169465e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792114814; cv=none;
        d=google.com; s=arc-20260327;
        b=YwBQRN4SBPlNDMg7jN+s0vPJvMwC9zQauSgcvLt1G7sB/PqltohBxmZScZNIp5xplg
         a3ywb5RhhOmI2LYtf/1o8z1qXM3uLPRxEg55pSQ7UGwL9CLmMLdCaEcUmaBmycU09Aqe
         oIkXEpZjykjBFAPq0FE4r2/y9vrY72AbxmkxIM7dxFV6hAc/7MnSImUXFagZa/a35M+K
         1SQ2UvAu0ymMOkQFeSdJy8NbvnBFjOO3eGH/XMlVvZziRHzQQ5b3mU6HHBLBjTgPrD9o
         yW4WKZrf6hpr87ZzlhbiaTiRSq5tEmGyuDDZg0JpxWH0oU5hAMq6YIkZzlvaR0P0QGr3
         HqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=phAXkjKeIsIEzaGzjxqn5It2JbCpwUAYDo3yhVQdCls=;
        fh=6MmNJ7261zx6aUJ566Ib3yRASEsEr6k2BPd96ksxlJE=;
        b=VaZy0jkRd0Kh2ypnCDh69e9/dS93pesm+i8e5OwiuO4UBUXSnSiNgO9LVhZH1E9p2h
         lh20yfkRrjcxijAbMjiOaGjsbam/iJ6FtsHkT5oiWwfn3DGHdBhsLyPmJuSB7WDTyeHx
         Ff9rEMo3j91fOdIyYYF3Qk/6HlInPdK77g/o960ByZYN3jzMOALcWiboXzl30gTGDZ17
         8QB/3NafI2YZa2hOrrh78bD+vzgj8oCswHFZA23QSxzTov/o1hbin5EV7TW+QWC6lVJN
         cGEMfHgC8TgomDPKNNTx4fRPphOsIU3YsuRZlpo/SEY8TH49fDNOC2WCcSctCTjesynj
         DfQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792114814; x=1792719614; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phAXkjKeIsIEzaGzjxqn5It2JbCpwUAYDo3yhVQdCls=;
        b=VGHXuIHLWhQeI32kmNcPOOnDjMXe5rwm7Vh09r/k6DIUZDC27Rf9aPjZ+pdsU2i7sz
         1qJqohkhkFwHjymsp+fNs70QNZvp/tQSnGeZoxE2gYGVP7hiG42XKs3Rron/KxLnOGhc
         mfJYNF5xTCLg/xzm30gbIf1c1PDvdLo7ezgP0vQ4ItIF6+Z2Yf/RgvtlFg9X42tb9wlZ
         /er2gLx3Mz3yJjLXJMziiorAqLntNCQKgtXKgvz67rkt/zQg7UX4ionyAIvXkemqU3ZQ
         /P45VTH8lYRVldiMOln8SAJQEDnkHCtIDqA1u4P2Cneq3dVN1p20Hxtk2uISqAYDgEmJ
         FN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792114814; x=1792719614;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=phAXkjKeIsIEzaGzjxqn5It2JbCpwUAYDo3yhVQdCls=;
        b=dAMEPHjdTGUlH3ptzfxGk7O3w+2twDYtpB6C0C28zXZnrEVpCCpc1kMU9vlxmMvDxF
         7sSr1d5MVzsAfwGP0jJk6x4ega0PcOsjKOHy1vYhMMtPIxJNPMAsKldSKVwsjI3n74KS
         SZwWXSkl+oEeQFRACXhTQ2/Mm5FF8V2hpMqETyeRm2SLp9vj/MRMpS6Kl3mdQsb/JtEK
         VdQAUwNz1Zv4xCl+kbMLy0cBupJnj8K2RLY5QnNSmbk+Ztbk4LEMu9cyS3sV2ejBhU7j
         s4ePil7Od5QBjfWRIFUwb10j6g8GmKxD820cxomGRD4G5RgUmskaQJ5E9AWLBO2BzPsp
         Ap3Q==
X-Gm-Message-State: AFq9FYLLEeaYfoRzsZpoGcOS1vDXvSfgL1ByI3j647Mav8KjqtD1BUM+
	5j5lbsZ5xM4i8ALVumxvFQbpZuFvQI92k0vmaUDUTGGPIoLEoHugeoQ8mPcmrNLQmEZD1vL1wu6
	9WAha3/iklAmSkZcj6aPmIFrcDn5ymoo=
X-Gm-Gg: AYBFou1SGSPWTfZgvCU5B9iZFRws/dUKX44Jg5vh5bhwmuMiASCL0LxPcKltt2nKMV5
	fubYWC1VPZvmVURF/vRfylOiZUGQr5PYO2Q7nwRabxlHR9drLn3cufvh2Ahr9f0ApSvk0n+dpTP
	cWdRFsMibUe98JOHdgfFG5z9IbYOGTrkNazPv257WhuAt4is02dB0NKW+YaZR3GjhwRckrFKlWM
	13//ChCmW4fUVX6yLgnV4Y351MqwJ7Yg0jNR7W4+M5HN4MPLZ6r7Nx+/rXXUfVPwUShiDyu9Zwe
	QFIgCV44WgZL4sXJnjTEuN3DiiBy6J02hQ+xljiIiqKxTCdTVD+fPukHrQa4Cxdg8AgAxdvceUd
	63bay7DRR+cf0AdcQrAAMq2p9y5Mu0OntZXDbH8eCjZI9Os47ZX9cyECDWiypA0e6Z0uAWcmwBe
	qEmqR2FvY/D8NjdJdFBMMna9ghqFIxiSjCBdu4aAjLlw==
X-Received: by 2002:a05:600c:8b78:b0:4a0:25d5:e853 with SMTP id
 5b1f17b1804b1-4a18e4ddd99mr425774945e9.35.1792114813774; Thu, 15 Oct 2026
 18:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-10-memxor@gmail.com>
 <DM5V2MT14QRH.1HNZAXBA35LX6@gmail.com>
In-Reply-To: <DM5V2MT14QRH.1HNZAXBA35LX6@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Oct 2026 03:39:36 +0200
X-Gm-Features: AclHuK8QDL9dh6vQAxLd6C91anzecHKNMGlz0MlfF_poywTu7whQMsQUoQ_E76k
Message-ID: <CAP01T76OyUOKFC=HZYdczm+bCqNmSC-4_ZTC2=kz+D-hHPbFfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/15] selftests/bpf: Test __arena pointer members
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 03:11, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Oct 15, 2026 at 11:41 PM UTC, Kumar Kartikeya Dwivedi wrote:
> > +struct bpf_testmod_arena_member_args {
> > +     __u64 __attribute__((btf_type_tag("arena"))) *ptr;
> > +     __u64 __attribute__((btf_type_tag("arena"))) __attribute__((btf_type_tag("nullable"))) *null_ptr;
> > +     struct {
> > +             __u64 __attribute__((btf_type_tag("arena"))) *ptr;
> > +     } nested;
> > +} __attribute__((preserve_access_index));
>
> why __attribute__-s are open coded?
>

I will define the macros to hide the ugliness.

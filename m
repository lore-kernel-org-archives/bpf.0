Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C24364EB0
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602224; cv=pass; b=lj6vFugr8sY7PYa1RI4d53GgTd1RMOmQKKCKQSSDW4XGmG0H8wlJmeXnEHA0Ug6syA32pXbV9uPkst48jM/kXxYAxksm+7jJ6dfXHGSxyr85hHNtCdaoaWu/SQpkCTVoCf+FheZ1nTGbvyFHvVAgUPrk1dUuWv49BQEqcpyrY2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602224; c=relaxed/simple;
	bh=Nh2W+2KjkIZezYDnX6rM/9HtlU37yBwv5+yVF52FLHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gswjzd0EYyT62CbdiiAUXoYz6p59cvgyjlhSxlFNzR6WjGKtvjJDujyuJVWYD2VdET5yjUmEyUOBn4efMAh4LUMyAUpI1n1kpn5uLjeLiSxnS5aKAsDzXQEEkA0m49Qx0OSDq5QLTAh5D6KbVZERVCWPXFfZLyOxg4ZtMj8zq4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g38WZvUW; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g38WZvUW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2886906b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787602223; cv=none;
        d=google.com; s=arc-20260327;
        b=JHyq82hcJTlysG3QhavNnW9ZAjWWBH88iX1285z0XWqcXxiSgg3zYKb+4sb1MZbfXc
         s8Nklop0TH68bG9REXTMii1eMvXfPgRFRTxEoX8qW1U83FC4oNBBGvoqAK4Q3hg6Rlq/
         Btkjz9iPvBiK1nxQLo9tH/X+CDhaLgXmJRxLD6jrWZa7x/RPgOsnSLjJtMTcCK7mLlYG
         6s7nWd2ICHHOvndmNU4nLLDojh9avWySvQNWogmL2fQHG/NlrpDH5nTr+DrqpT396umz
         unFBQM+V0znO1bbjUdcBe8GvoyciL8sbNPJoU3dWS+Cqp40akl1Oc5fLfqWWiKKsWbYI
         0DDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nh2W+2KjkIZezYDnX6rM/9HtlU37yBwv5+yVF52FLHc=;
        fh=m3oDtSgaAl9UYjaqrwO4w5R8c8FhTBBUVo559Bs/fdc=;
        b=bFnU2SiLG5LCRORHxRyUs1kTAAmNTSTfZXTdlpODuwFvUmFivlw1dsnai9u+mCbAfP
         GnZbFUS+52EiWHtJex8Pv6PgV0nbp6r1oARiC8eYKJBD8P8lgPMHx9837eJrr/Wssbb3
         jTyzly9q7+nsit2AqnMBoiIkTBv+LLsHcA3eFhTp2yRPffkA86x67WFXgHh3joKHFfe2
         AuGH4LqJM62fUtbv87PURhEGpkY2D65sYCgVMR74w7hFyW3NmwwVumAswt0iK4Q7frXE
         MEr4XR1lVotihOiawGXDGA8Qz2HWUFZnOlWLvxLTrbLUJGh/2fu1FNUez2siznuV13Kx
         ugLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602223; x=1788207023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nh2W+2KjkIZezYDnX6rM/9HtlU37yBwv5+yVF52FLHc=;
        b=g38WZvUWG+oWfihRJWHI2Wbwbf7uIdP16hUxUGc9bqV8+TTzgrezOzAqbO4Die0l/D
         HxAJ5uY06bZEtfowCkL+Y7NkWEDma2IO6fWNG7sY53bhNm1G/bh07aRjQjlOfeHELhMH
         hCEfYtScysAdJnoJvxPgxYRRYkf8NAlNhB5Aw0QiwWbjTcFYJlvRAC+FJn0QPqqOz72c
         CW2IGXszcNiAJBZvSBCeJd2yg4jl4Pr9qPNI8b4GBAnWkHMOmdEw1fO3OwBpmc2r973X
         tczI/+qY86XeH1UtGIv2OkLCmsvR25iIM6yd3FA7PylY20v198eRN6O4GNavOn8Tu91a
         bVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602223; x=1788207023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nh2W+2KjkIZezYDnX6rM/9HtlU37yBwv5+yVF52FLHc=;
        b=BK+wlu/Jc8HtuY+1ibxxOjyf9sOHk9+5es07iYoL12U86CcKkNJm2Xw8sJ2vJYgUcQ
         s6rgoEON+uBlIV1e74jpe3F8jNsJksiTWSgCq2MEBw5lJALIM25e33UghmjWkhNACWm4
         bedRrMx98mTgrckR+fzegrKrpAqzRNtHyHHAE9frTQTm3UsS77KjAFJIzGNil0ZtVLgT
         oon8HQ6mmJFKkLBb8hneykUKE9OPqweVNPBVV/z2ereUJoVTK2189+AqHKQ2TKhZRAXc
         X4tPBZto4r+Hc3AW977Dlh1Vo/OdlgOTNPhKr803S3qUyrex9GYFyJ/x6rp5RWqOZ2tZ
         nuew==
X-Forwarded-Encrypted: i=1; AHgh+RqZwlbb4KZ2ZU0eNaWpmv/lW0G3LfDlx5FzK36pBdw1MF1/hixihs5XXFdAgHd3CWhZ6Yw=@vger.kernel.org
X-Gm-Message-State: AFuF++lpAFHqBWf+0Q5Ds0ZjREcJXZ4r5KtW7OhFJ4zdeTaigGPf7ySW
	WdC+zZHYRKOzSSWeGcbv5sG3nHbaCtQJ0/N23eOcIinFPBGD7QytibJnps0VH6jB1R1Q+Xxk8ba
	e4Vh40iPzy82zZSXNfMtKNBEL57hSt2Q=
X-Gm-Gg: AR+sD11MUECKtMkqMy9tolxr7jT8rL1eTN1RSRCrjeuk3QQX66aADXHwpuQrJ/DpuYg
	S4ImJC3cLIlFMdi7JBXz7s3uE8XPo09Xk2s0eh7v5q7WcOEctziMJ0KKW2t9hRRPlgr5IKQBYHr
	JEtof8QwVUoGgEoHAUWPHogkSmCDxFPfSrWejNxT7QQ1sbJzgk8ktDsbDHc+rc403yBcLHGSQl/
	d0EGW5xU9K8D26Vsbn6ZTB40f4tb9fq28JD+b9kObUuUBhgtbpGPezrwNPKpWQZgBddh/Q/34D+
	KnYwWBI9U7xx1qmWoB5twJDHtukPZDS1O1U/b+c4RhAIezaqtpBa+1W1sK7XDfzH26QSW4A0G8o
	xnf8BFgJCk2gmHrxT0jvx3a8uScYgko/ZDV2y+M/8YA==
X-Received: by 2002:a05:6a21:a41:b0:3c3:68b0:e273 with SMTP id
 adf61e73a8af0-3cd4bbf659dmr43462906637.15.1787602222753; Mon, 24 Aug 2026
 13:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
 <b380f7e7-2e0e-4c8c-9a70-e6a577d268cf@linux.dev> <CAEf4BzYM+b4E5S6ZCDcpEaw2uvdNPDVUdTgxUxkvCdM86DkubQ@mail.gmail.com>
 <68358803-57c9-4a89-9da3-fb5e12547e0f@linux.dev>
In-Reply-To: <68358803-57c9-4a89-9da3-fb5e12547e0f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 13:10:08 -0700
X-Gm-Features: AcwNN1UAux-27eVZW2UEkzLhPVB-7lVOFEI2nI5VIkBvH_HvpQM8AhH4b_Vgl80
Message-ID: <CAEf4BzaBxRuU_W=UDoy9EB53PvPWdsEAo0=mV4E-N-bmZ1gs5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup
 link update
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:04=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 22/8/26 03:35, Andrii Nakryiko wrote:
> > On Fri, Aug 21, 2026 at 3:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> [...]
> >>
> >> Any issue of checking CAP_NET_ADMIN for BPF_LINK_UPDATE?
> >>
> >> If no, checking CAP_NET_ADMIN for BPF_LINK_UPDATE looks okay.
> >>
> >
> > Why do we need extra capability checks during LINK_UPDATE if we
> > already performed the check during LINK_CREATE? If you pass link fd to
> > some process that doesn't have CAP_NET_ADMIN, but has link fd and
> > another validated prog fd, they should be able to update the
> > underlying program without extra checks, IMO.
> >
> What if a pinned link is updated by non-CAP_NET_ADMIN users? I (LLM)
> verified the case by the selftest [1]. Is this case allowed intentionally=
?

I (human) think that yes, it's allowed by checking CAP_NET_ADMIN on
initial LINK_CREATE for a given target and program (which fixes
program type), and after that FD ownership can be transferred and BPF
program can atomically be updated by whoever has that link FD (and new
program's FD).

But Leon, show a bit more respect to humans next time, please.

>
> [1] https://github.com/Asphaltt/bpf/commits/bpf/link-update-issue/v1/
>
> Thanks,
> Leon
>

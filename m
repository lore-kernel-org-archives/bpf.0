Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA5374A1B
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284206; cv=pass; b=IxEfmYXd62hZE63na0WKFd3kpLc7PfOfbIx/VOF3rrTr6hqIqJJo6I6Q3fjDWn/thCFM/7ai4I1xDBHc0TZGG0NxW1XwO/hZh5uQD/ui3YyMRshVHIg1U3kCZ7B+fsUDBfX8O1QWzzMv5qEip6hE0Z0+Cbta6PJU9qG6tRG5VC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284206; c=relaxed/simple;
	bh=YKWWA8HN/7LM+Kslx5n3GFPqlJF8ctu6GvvxJUabjrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mK/7f8yYBy88509i1vyA/kXBzqsTbFf8FlOSKRkIvdhPa0Py3GJkxhXeS11H/N7Ubaq6XRt2493V3jQQfwB5QVWzPYyJ01Qu1E9Ts4G8xVKC4u4g7PLBLKbpXdJbDFgR+t0MDpWICM5hukl/OscAQQUnnLZlm3GWAgZX72rAdnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1+Zi4XZ; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1+Zi4XZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso905301a91.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 10:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781284205; cv=none;
        d=google.com; s=arc-20240605;
        b=dXM5dV/6drpATeBRQTPMcBo9uRZNDNxh6bsHQStns9lvpmDgsDY9oKq46rgMPRo8oM
         D8NC1TUG1pgYB294KceiEDTGl4plDe6rccufhgRMI2ByCoMToqGgJfN9u7b+QrZWMdm9
         sA9gih8rMoWqYULG4DQ9vtryWeIJFx73lBXaeEVB2EqWngIEBneWB8iHjG63G1bbG2Yl
         OGfbaTvoSd+7lm2jWlkPzHGPqjnGaZw3+W+Q0EnYq5K2ntU8Ud9scY4pjJfkRykgj2mY
         q3O7r/F3QYUsJ+jyHk33cWFZ1G2rBUZO2DWa6mQ/AxOry/9EKMsU9/fdsowp+lq+YyvS
         F3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDX6t2X+QHHxQFviKq3UoU1UcseXTprmkcNTRxD96mA=;
        fh=aJKsifnmJVYxrENXiuFCKNqbPRSNyCakkVCrcNXD7Z0=;
        b=TYVAQPwG/7eZvns1DvCSWNglR18VUAF1yLiq3rGZDD3YsmM2hRidagaQ9HWhQ3LL6D
         4owZfKaubFLOXYM3jO1ccDrs5mk1ncSnCtHwzjFJRklhVsn/9x9fWfWYOzypYVdzzKnL
         l9NxNI1tV9TkPIGt8MMRlPFl+v9WguCtk729jBHFp1jZgW7wEHkYDpUJN+qz3J7kW4od
         XcCWXdIvBAB/VKiD8vR+1brp0IrMMfMIfJznU1wxwwQIX7A+2we7GvTgjnYFn2reOI2B
         uZdA6sZnn8ZGvhAvvKIjY1wj/GAbIlWkNmASGbk9C8qQFJA6bCMkQHTJm3ikrb1+lfFW
         FpQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781284205; x=1781889005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDX6t2X+QHHxQFviKq3UoU1UcseXTprmkcNTRxD96mA=;
        b=I1+Zi4XZYPbd6/vuqeQM+ytqnwbHnJcXmu0iwaFPvzApf1sjqqaX17FdXTxlIp4mPx
         rM27daPEW5rLeTavd+I7qLqBnxqtnwG6fCrRWENZ8rr8knjlT1smCIGstXOx5CoOyAlH
         iYCeMVIO4PQDE3KReq2cHXOM+T18MYObDsnGPVVBAUYpq+uaARLaZa8JSClUUSRVNi6R
         WCVrZJhTsDcPuN8pzWYSlsDqwcMpdyOHYtouoX89YiY2cp0Qs8AinToJtXGb3nJJah26
         oSsJEC9TdJtOu3H55m8iAw8FFupKF67QUgd3q/0wBKjgww3AmB+zvizMkukj4f6I/8ch
         jojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284205; x=1781889005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDX6t2X+QHHxQFviKq3UoU1UcseXTprmkcNTRxD96mA=;
        b=ARJPrxILhL/YEPdSHPckrtm7mBtwwjWkoLQMZwMTyGjd9EIYm8rdUD5/FK3t6b+EZD
         KspFwYgXbF4YwzbtDy+fRBswuUCUt98x9knQxlJJmZSRCjQtp2zVQySKd77M3ZROgVQN
         mpoYRyKvQLrCDpFtPbZ+z/EOP1oyctgjI7dBq7C4yKD+kKdYdslv/Xh3QqDurXGkdqmy
         EVrbMjgfac83sZNXZjWS0gjcc7AGnBOdelRvZMLoqhu7pzcRTR2/mD24P+w+4C2a+yWk
         EfsmaJGlpsaZ/KTOJN3svwubdzjljd6XvDfrzTSpMPx77vJj9Sj4PPh1RXRjfJdSC3Jl
         lOiw==
X-Gm-Message-State: AOJu0Yzybwztu3M1wyWImXEqoIHFUEWwbifjUIQQI0BjODzTztfRntf1
	ZNRfgyHFO3w+gRf5N/fpBOCTnF0VgU3077VHjKHhcCMcO3ZRT7WfyUN1/p1e4ya4i8+LDMn5VMG
	GHHLOZ/bkHbz1dss4EQhtPvtkwodyZ6Q=
X-Gm-Gg: Acq92OG7te1ovuOWRCg93xB/+NylkZd0UEUfodOjvd4V8HHSGZpkB3PNc3P2gZNwn76
	Q/SSORo8wuG+Vqt7EqJKGGv+5caPrZSek4WHUb16EidDtaUUSGJOmwVnf1szNNwA/gKav8oYT+8
	0hlM1ps6TSiuJAVoqwownsFlExyhlEGi7R0EDEnwOJsf9RoCmdOm0wBqn9lvgXLCDqtawbD0rjN
	1j6Q6cjvLtu6okN+Ihh3oVs5+T2M2wwdZ/Rmzp0hd8zmp9fKHY1vjaji7B7z5yfHTagGOLlyOjq
	dMNLssRGliObFo/0P0U5WGXKy09NaybjitIyp6XBItGN4UmEH8T33jYrQy+6xFx98SE+FLbN4/m
	WTwdis+z9j9nDlj2nZnA7yKaT
X-Received: by 2002:a17:90b:2dca:b0:366:10f1:3d86 with SMTP id
 98e67ed59e1d1-37c2bd75872mr189256a91.22.1781284204833; Fri, 12 Jun 2026
 10:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612130919.299124-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260612130919.299124-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 10:09:52 -0700
X-Gm-Features: AVVi8Cdt5YY96GuciSaCwsRw-A8ob7HHQLryVxTyFCQcmv_QVvBEG-eceoLw8Qs
Message-ID: <CAADnVQKL26zPepqOf_FtuA6ALQEtFJmiKU12iahdvfeAyJ7XhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/7] bpf, skmsg: some fixes for skmsg
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Shuah Khan <shuah@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:09=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
> Kuniyuki and Sechang Lim, which have already been reviewed by me and John=
 and Jakub.
>
> https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.com/
> https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.co=
m/
> https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
>
> The automated reviewer (sashiko) may still flag a few other potential
> issues on top of this series. After looking into them, they are either
> already covered by the patches here, or only reachable under very narrow
> conditions that require a specially crafted BPF program and an unusual
> sk_msg ring state, so they are not practical to trigger and are left out
> of this series. I'm collecting these fixes together because the same
> problems have been re-sent many times in slightly different forms, and I
> hope this series can be prioritized for merging so the duplicates can
> finally settle. With so many AI-generated patches floating around for
> these spots, leaving them unmerged just keeps wasting maintainer review
> cycles on the same issues.
>
>
> v2->v3: Target to bpf-next and carry Emil's reviewed-by tag.
>         Reverse xmas tree style is used suggested by Cong.
>         (not all code match reverse xmas tree due to variable dependency)
> v1->v2: fix problem when fix the conflict.
>

Kuniyuki,

one patch is yours. thanks.
Please help review the rest.

Thanks!

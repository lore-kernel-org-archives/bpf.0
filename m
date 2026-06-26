Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98103AEB5F
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497054; cv=none; b=NuLOQU/R+bsruOrTLVyFIBxL2WjiXNaI4xEv0MfVJ0h/BHZtryO2em3SvlPxJ1mB9oXODIKrcdLrVu4n2C7yz/Nqb5cOuPgVNTosuUNeDMgr98F0SyE2SCvdIvAGQd8fxxlF0BM6RAMESV5MrOMegdDrbcNTx4YGEiAZ6jvwYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497054; c=relaxed/simple;
	bh=mSXpnpbCzVl6XZJaduBfowqNhfr64cCjJ28/dcbXAyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0ZchtbwOioqi+pAgwVp9YNRq6okriiqWFwm9Vw03SBEVAibq8ZE2TKRbQKhRlQF5or3+yqqAlXbaSxniuJsQoaZZePhpUkjY1G+vlv3AYZ6MZn7i7rahm0pUakOCQ9u4H11xLNTEzOBigNV5UEolOPxDyIC7c8iVvtxvRedYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt+kwU4b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt+kwU4b"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c80810247dso8964985ad.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782497052; x=1783101852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSXpnpbCzVl6XZJaduBfowqNhfr64cCjJ28/dcbXAyo=;
        b=Jt+kwU4bhcNI2CnUpqvwE/EX7y0m9FCoUfSne/9WObZRLH2zzRhZCG2teYAaBTVGb6
         QRrAl2gGTC3vLgkoyJ1vQTZc10xj774T1h0r1R2Mkd26OLB7VMmugkd+WzIR1F9eNesR
         uu7Um003W4y2UwvG8goZZItI3jnfXfqSKRddP/BiHZN1vdkoGYggpae/K3gowgonLY8T
         Q9JaZLJr9yp4rwj6u/Q4y2BfUmO44urvMJaZR3LhBb5a6tITVlhBNaEUwj+UZ1woQjhY
         1/dN0pmlxcp/ixVi2sw7jC6o9XKtQxjI7wdN8u7eVFI10BqZ3xbXAxnn/B2OqvswpyDZ
         J0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782497052; x=1783101852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSXpnpbCzVl6XZJaduBfowqNhfr64cCjJ28/dcbXAyo=;
        b=KDm8IvMNNaKvtZjN433psy20UftK0VI5m/5oNmt5yo/NTI/ql01BsBYAeEw+ut0vho
         eDCukiS/pwLnPy3Ss6d4fsqyDk2bPzV/xxmGEC7mZiH0p/x+dRJ7xAAeEigNJ1L/GioL
         Q0Okf/x8NSVruD6A/scAffL+vFVHeC41GJzgxa1oiHziW1Incs9bl7Q/H/Wb55jgFoPa
         nlfYicLwtZDBo5RDgFt06uuLAy9xNgmBjLNtuIy2CYQp8OYoO0no4KGNW4YVrLYjjE+g
         qAZtfmd+FE2shNW6DBnWrxP1Oy4wnMSI55uYP7JLI2YuWgdvQe+aP7msnctrVcOWVhby
         /+dw==
X-Forwarded-Encrypted: i=1; AHgh+RoekuWFuXmx89PBjRlOieXPnWNH48bMmOm8PsjubsgSEeALOqjsN/j+2rrLuFS4Z4BoLP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfzSZp4x/jg/KX0qAZu90ta2rHeqiB0m/kPq4IGPmDWTU/4Si
	TBKRnyvOtsuty2QHKzOHGEc3J796h/SgTJRc/VstDVy3fzmg63xvDZvs
X-Gm-Gg: AfdE7cmtD6IgkYudiTQSC7YFqTpknWQo4W1rWn43Y9CALdtXfXEuD8nD2lC2/Ulb00r
	4L5y4h7rVZUzy/FRL3RSqHUt6x0juUBDQigSNOa4s0QNxdwmMgb15PYKA/RbTog8MzUhKcpIcqr
	9pKFxFlAB7mcS3ufLJLZXOIe4Fv/5d521C9nmxEgLmMDEmt+UHDKXTtg0MCIZOsZTPnv4CaZFth
	0KUq4r/khBWMZ8E6/W5vuec1Y14f64ouqq9FUYtAcqIPDFW/9f5KkiZB+YQID3jrm+mRqPzJ3ts
	5qFooFCKRGecpiO6+EJK8hZc++eQTNiGSVGm7UB3fKiXYp+BLlaL5gEp97JhLrj9rsGqCVJi1rE
	ddb+7UBKnUobJ43PgoFYukEjnYCcwrczRzLL56JcFHjZxUNZKCpaX4FTaG2j/w+FD9nVFe3TOpl
	6DFLvf4yW1Hb0=
X-Received: by 2002:a17:902:f612:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2c98549d2a7mr11230015ad.4.1782497051981;
        Fri, 26 Jun 2026 11:04:11 -0700 (PDT)
Received: from john-p8 ([98.97.43.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afcb18sm44277795ad.31.2026.06.26.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:04:11 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:04:09 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
Message-ID: <aj6-Ga_sIrMixgKN@john-p8>
References: <87v7b9ysep.fsf@cloudflare.com>
 <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com>
 <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
 <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
 <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
 <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com>
 <87cxxey09d.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cxxey09d.fsf@cloudflare.com>

On Thu, Jun 25, 2026 at 07:53:50PM +0200, Jakub Sitnicki wrote:
>On Wed, Jun 24, 2026 at 01:57 PM -07, Alexei Starovoitov wrote:
>> On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>>>
>>> Hi Alexei and Jakub,
>>>
>>> skmsg is actually still pretty useful for gateways.
>>> I started with bpf by integrating skmsg into nginx as a module and envoy
>>> has something similar.
>>> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for
>>> L7, redirecting
>>> between local apps by looking at the payload. So there are real users.

Interesting.

>>
>> ...
>>
>>> Agree, just like we remove skmsg from KTLS which is rarely used.
>>
>> ...
>>
>>> Hope not have skmsg disabled by default.
>>
>> I wasn't suggesting to delete the whole skmsg,
>> but to disable combinations that are causing issues.
>> Like what was done for skmsg and ktls.
>> I'd allow plain tcp and udp sockets only.
>> Allowing unix sockets was fishy. I think we should reject it too.
>
>For unix & vsock we know Bytedance built a proxy using it.
>We've been showcasing it as one of sockmap use cases [1].
>That said, I don't know if it's still being used or not.
>
>If we don't want to go through the config-knob-then-deprecate process,
>then I guess the only option is to kill it and see if anyone complains.
>
>[1] Slide 117, https://github.com/sockmap-project/sockmap-project/blob/810d259af6e7a5793922af3991c9dc7ff502fe19/talks/2024-09%20-%20NDC%20TechTown%20-%20Splicing%20Sockets%20with%20SOCKMAP.pdf

Most the bugs I'm seeing are combinations of push/pop/pull/tail/head
calls over sk_msg scatter gather list no one ever considered. Or at
least I never considered. Add in additional socket combinations that
came later and we get bugs.

Do the nginx/envoy offloads manipulate the scatter gather list as
well?

Do we need all these helpers? At some point I thought I was going to
build a real kernel proxy with this, but never did it. Another option
would be better test framework.

.John

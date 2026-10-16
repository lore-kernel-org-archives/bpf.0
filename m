Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548823C516
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117260; cv=none; b=dV0eEeEUzvx2j3cN+GBnaIusve/ORDM13rJ3mevYZ+0HZdSGritO71C3sWWrlpt+6fxUm81U0n2EVvY3Th0cOzuAf7EsFDd//gmW6/ZCAVYTF3CMyi56IQmFwm4gh/bsR9LL7A7hu1bLL4D0gSpp9YckB/uEHN7FPXaV/AQAnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117260; c=relaxed/simple;
	bh=k8k7fEVMaRQfiJmFCjItK9BTtwp+V01r8ClmrGwkuMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gnp7iPwiuYgqKlF1MG/EWduImLVb/II5uZx2lx3UyPcfiByuK54DwH+C2k1tzkZHlgLIvDkl3DzYNdgfg3RJGWo2qW2HFYNKcjiJObj5yTJT4i6SToAyh/53sEiJgo3kExnBmpzNOHXQXrU/nTDLa5d0IpjdNjizAsU/02Mp69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+BwhNEV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+BwhNEV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so2783054a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117259; x=1792722059; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kQaNovuCNF0esxYbF8oB6qcNwGRbXcsAmfIzJZTS/fg=;
        b=h+BwhNEVTfFwP9DROhHA2WLmD2VYeS60fqt9F66O+H86VaIHP2bIMh9sqgJFK70d83
         yDqvdFEfc4P33yNJNY1N9ZRzZcwyJSBNTv+l5DhW54BmeuUiLYoWOF055jaUJSco1I6V
         yZol9Q1/BMHYdHuRWkbnqGA5663u/pNg9/QCm1rlqwCW2yeOUvQED7CTJ7Jzz9HRfC4P
         SOYiA4q5e/Ki9jW5i5QAla3YIvMmMBF5brij80TaLFhf6iapYBdN4ZtTayUShNBeaNND
         6B4yge87TWQNkzKFOZ9B1U55bTnWLy4awVERySasP8nSq6jnuNTHL8PYXq94g4Alq00J
         S0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117259; x=1792722059;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQaNovuCNF0esxYbF8oB6qcNwGRbXcsAmfIzJZTS/fg=;
        b=HfNfaACrSoPEkS+TADGyFyd2Zo5VbUF/BmK+uTyU3YXRAAfkaKkmKgj/WeHRUlQTt1
         qNwLBUe5hFOent6L74aVRei2Q1FQ+m3KvJFml4xrch4nQzg52MkKc0fhPcv6YoxH8MsC
         yorrn0EQz2zFIMlKKZmWNE8wHyYDSzCkDkmIXDgr68Gz8X6VFyEBKcd921wg79DU5fBl
         i/2k6jK4CJ+Cirsmlc9l+rtaU35b6gLIgt8PE5oP7CXhcJCe6pWoJ6qT/6v7Fl5X0+os
         XnESLmv61Z/DmfJdSxxCtlbX5o8ETUI6G8CffSpnEYYXCAOA1gC3XenAV0OncBeoXO7u
         aDgw==
X-Gm-Message-State: AFq9FYJoXPaUHzblQu9I8GjOwp1CatcwfWdhQqKqCk94pXo10MtvtupJ
	rSmhjtoBvQX3eUg27pRq8lxUAGdPseZd1VBo5Cf142/7gd/oo+DNtGQ0
X-Gm-Gg: AYBFou0sE3nyk/+LhGkzBDav7/N1mh+WAj1QNzCiiGhEfv2aEFy4vyqK09U594JF9Xl
	9GpRONtducw9xvR7nqxwwO52VZr0dqDhrDkR22e0rFEkrbyXwlTbwdEf+WHXdp+wtpnr8GrMSRj
	jbHYLlS4A4FZ7NLWHP4UCOtbhrqaDOLEbahijFiEC+r3J7Hg3AEpN74j5V89IXoq+KGOlXG4til
	Pjwi64nRpxy1shllcE9kqgYTviNNWoXqMYsnlUAqsLeElDmc1cmu5UFW0axZs6YlXpchjztIK94
	UQ8SGo/4s7hg9TzlTxxQXrpSXaxDc8LNCWN9T9XxTRMBVDCGnZ0YF6+Ur2M7giNYN0SzIZ6k+A8
	2j0KZLZzXww3kwoHcv9axn/x96/l1UvDBLaRitLHHOYsoirV1Eodnn1OTOOlcpivHEnTtNM5FLl
	uGcC17ygKvBfD/TgHmcEJXWYoCo2pjvSonxGHSakGLhLRDxBanWNM6Jw4y/uXSIsAinsufIw/Nn
	YS0N50IlF9UO1BxFvFluklbr6hwn1PxGBEdWJBPpMcFazTu4eeyu0s6PG3CtYRd4Am8sVwF+50w
	QNe3
X-Received: by 2002:a17:90b:52d0:b0:3ac:9f00:3bc8 with SMTP id 98e67ed59e1d1-3ac9f003c6cmr3526067a91.36.1792117258912;
        Thu, 15 Oct 2026 19:20:58 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ee274sm1706772a91.4.2026.10.15.19.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:20:57 +0000
Message-Id: <DM5WJQGLNLXD.37LO6XYDR7G44@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-7-memxor@gmail.com>
 <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com>
 <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com>
 <DM5VHTPNK75L.25IC5ASG1QDJ9@gmail.com>
 <CAP01T77q9Q-kj1gjsm1U2Nd7QaqjjSrNhF232-dt7cehrWw+uw@mail.gmail.com>
 <DM5VYE2LA9E2.28YJ11VXX558P@gmail.com>
 <CAP01T77Rt=2feJ_HgAW2eq5GntJ6-UNwAh-1cWUCsP6zJ1PQMw@mail.gmail.com>
In-Reply-To: <CAP01T77Rt=2feJ_HgAW2eq5GntJ6-UNwAh-1cWUCsP6zJ1PQMw@mail.gmail.com>

On Fri Oct 16, 2026 at 2:04 AM UTC, Kumar Kartikeya Dwivedi wrote:
> On Fri, 16 Oct 2026 at 03:53, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Oct 16, 2026 at 03:39 AM Kumar Kartikeya Dwivedi <memxor@gmail.c=
om> wrote:
>> >> > Well, BTF_TYPE_SAFE_*_OR_NULL also enforces a NULL check, so not cl=
ear
>> >> > to me how using the annotation over that will break a program (see
>> >> > type_is_trusted_or_null() usage). The only difference is that this
>> >> > annotation works with type tags applied directly on the struct.
>> >>
>> >> Got it.
>> >> Can we start moving into this direction?
>> >> At least for clang compiled kernels we can drop BTF_TYPE_SAFE_*_OR_NU=
LL ?
>> >
>> > Yeah, makes sense, I will send a set doing the conversion.
>>
>> There is one more difference to sort out first.
>> type_is_trusted_or_null() and type_is_rcu_or_null() are called only
>> when the parent is trusted or rcu.
>> fentry/fexit args are plain PTR_TO_BTF_ID, so with __nullable on
>> socket->sk
>>
>>   SEC("fentry/smc_release")
>>   int BPF_PROG(bpf_smc_release, struct socket *sock)
>>   {
>>         if (sock->sk->__sk_common.skc_state =3D=3D BPF_SMC_LISTEN)
>>
>> in progs/bpf_smc.c will be rejected with
>> invalid mem access 'ptr_or_null_'.
>> what should we do?
>>
>
> The right thing might be to just strip or_null_ when walking pointers
> where bpf_may_fault_on_deref() is true (plain PTR_TO_BTF_ID and those
> with PTR_UNTRUSTED flag). That should prevent regressions for this
> case, and match behavior of the macros. It is also okay since the
> fault is handled.
>
> The plain PTR_TO_BTF_ID can also be passed into helpers, and may be
> NULL, but that's an older problem. I have plans to revisit it at some
> point and close the issue, but it requires figuring out how we can
> annotate and prevent breaking correct cases, and provide some low
> effort path for incorrect ones. This conversion can be first step in
> that process.

All makes sense to me. Thx

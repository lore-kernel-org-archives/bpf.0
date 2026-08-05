Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F32388E59
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941788; cv=none; b=ri6iNfA5+X7E3M1t0fsRC5TzBWogMenuVW+RQjtDhhzeS0iPi/xQvJyaSwR8HTV68aWAb4t/5qD6ZdSGqV4ZNdwBEIctBRrzUu118JBXn0fjzhP7yjaMUJsdn+I0vQb/OPLNBgQTwM3FwBPQuYsWA4Pq5s+LCAysGUCgXZWdN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941788; c=relaxed/simple;
	bh=cQni9s3yOzuEp9q6GhuwuSOtDUtduzqUlTtBJG+VcAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJWpOUvnlMasqQro9CE7SJLu43I1F7Je0h7QRnKJ6P4d8JY5Jfuwd/d2OXgvJFw6FVYD5Rm3yY+dKWo30IIhgSPnuhx43R1cS7EU+LFV79WrBaLEtI6kXnUAmnpbiiVDb60d9K8ovuusLiP3GdGvHGx845yHsc1RzSaFCIkga7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JsHX+92i; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JsHX+92i"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so1140128a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785941785; x=1786546585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cQni9s3yOzuEp9q6GhuwuSOtDUtduzqUlTtBJG+VcAM=;
        b=JsHX+92i4CS+xexC2+BhYyEHSgfdUt60YSzPT7QZCAxWYzH3I6uLQ9I/kaHOZj5OR0
         REbSGq7gNmsLaekCdTZeGZ25JKPrEXd+QMi2/uLVfyxs/DotCWlCm8zyTnkNyuKb1s6C
         jrU2K9SCdQPLS5GTXpI+WzecSgbCiWqUbGJU8u+gfgnZUB2fJhzj57BoIsF7bFMxty8G
         iDHVKzQejYzMDvCiEUD4doN5E56Fins9btm433NgEj6CZ336Z/aJn3+WgSGkVA6zgeSW
         tMTwqE+qXZixpo6qPTn2sZMBIZAFKvcJuxpplcsjFNaBo9tc02ufkiOYtcelJdsEmbIz
         Q+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941785; x=1786546585;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQni9s3yOzuEp9q6GhuwuSOtDUtduzqUlTtBJG+VcAM=;
        b=d3Uar6GCtIPhj5bLv3ZSINVtVmoem7zBzs8+93T3y2UfhwfUHByk8dcstohPCDAgLR
         f38HOQHr62/x4ovG7zBvdGpqB/8sA4taHiDRGfKCA3K2mXqThCVL0FMvzXmAaZFQQ4nT
         2b0HrESOKKSKTHLjyFVqChQeCc36af/TN7WN78qffRwjDRRW/OrDd6qMArSSyhuAzinD
         WZxdHo3+Z1rzrlonrvRclcRSq+1rfxeHZBnJvIpyK9ZiHzisgQST447PWp0ERX5pkgO+
         u89Bheiv2+hUPhOIvo9f6DJAAFUBqpqBa/Na+zFeG4GYpry3pCvNYCkePjo33BeJmxDD
         jATQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0t/LrWAD5ktaPa3wVkBeLx83rXM3vVGDm85AHOwJLTZaaxsQudAgDcP9YN8fuADHhYgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6p6tlDlxdoZPkUZvKh8U/9R4UWAPfsQqelB5J/76JmuSmMI5C
	iQyArqzi9YvoxO9cqHZX7r2W3A/xdiA27LgZrwBVpqcGLhC38TA0u7MorOluohU2pWQ=
X-Gm-Gg: AR+sD120UCO2jKBqk/lg4E0jhqv0dnpV4Zpm6ldyXXjIE8itZv79TJnjOJ1qgsCIgpM
	2AGyLo1O2c3e4fBM3PtsqW54Tdw+tfprUXeqJ9NjL747JYBfocbUQKFO4t6dbeCA+sQ86h6hLHc
	4ESEfz1828i+JA/lT/hIA5VuxoXFd8xMZNyvR6N727z/7IltwrGeJopfgFkKjjfsVJ3iB4jDmFi
	Bd7kt8yC1RZO1L/uVk4C5g+5N5E9YytDgUkaFZo0WbbzWcWGPaQWqK9XJPwk2x7skh6iW8LC27n
	7UnzFtPRzHXE8PfULTaxhuiOrxnp/s05Sl5Rdmmb53TsmLX79qAp4RHvevn047HUFg7NTyFYEeV
	QilWnHXrnnsMLwJA8ZdH/1RKfDblIyToUJAgt7R+jo9Af2c6NjVY1oOuJr9xIWn1z+JEy7sSube
	4Ax/vYrOFAng8IsFWvFQ+RN69DNQzviFWBFClZrSiWUmgTukS+5OI9t2Wt1qUTsaw=
X-Received: by 2002:a05:6938:a087:10b0:c20:53c7:48a8 with SMTP id a640c23a62f3a-c2053c74c67mr98894466b.17.1785941785127;
        Wed, 05 Aug 2026 07:56:25 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c205047ceefsm52082866b.35.2026.08.05.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:56:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: Michal Luczaj <mhal@rbox.co>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Kumar
 Kartikeya Dwivedi <memxor@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  John Fastabend <john.fastabend@gmail.com>,
  Stanislav Fomichev <sdf@fomichev.me>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Willem de Bruijn
 <willemb@google.com>,  Jiayuan Chen <jiayuan.chen@linux.dev>,  Joe
 Stringer <joe@wand.net.nz>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references
 in lookup helpers
In-Reply-To: <CAAVpQUBcDGX42Dyzo24U3iMKVyNajgOa5ZD7uX=DhSWf4Nb-qw@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Tue, 4 Aug 2026 21:01:43 -0700")
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
	<20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
	<875x1qyyyx.fsf@cloudflare.com>
	<CAAVpQUBcDGX42Dyzo24U3iMKVyNajgOa5ZD7uX=DhSWf4Nb-qw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 05 Aug 2026 16:56:23 +0200
Message-ID: <87tsp88vl4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026 at 09:01 PM -07, Kuniyuki Iwashima wrote:
> On Tue, Aug 4, 2026 at 3:14=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>>
>> On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
>> > Lookup helpers gate whether to acquire a socket reference on
>> > sk_is_refcounted(), a check re-evaluated at release. An established so=
cket
>> > refcounted at acquire time can gain SOCK_RCU_FREE via
>> > connect(AF_UNSPEC)+listen() before release runs; the release-side re-c=
heck
>> > then reads sk_is_refcounted() =3D=3D false and skips the put. The refe=
rence
>> > leaks.
>> >
>> > Make acquire and release unconditional and symmetric: always take a
>> > reference, always put it. Adapt sk_select_reuseport().
>> >
>> > Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>> > Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and S=
OCKHASH")
>> > Reported-by: Sashiko <sashiko-bot@kernel.org>
>> > Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.k=
ernel.org/
>> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> > ---
>> > TC bpf_sk_assign() has the same issue; it takes a reference only when
>> > sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>> > destructor it installs) re-checks sk_is_refcounted() independently at
>> > release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>> > socket here too. I'd welcome suggestions on the right way to handle th=
is.
>>
>> Can we make this scenario unsupported?
>>
>> listen() could return EBUSY if called on a socket that is refcounted.
>>
>> WDYT?
>
> I discussed this kind of buggy rehash with Eric today.
>
> We can't make it unsupported although it's super unlikely
> that this is used by a real application.

I'm just wondering why not?

First I thought is was due to POSIX compatibility but POSIX seems to
define connect(AF_UNSPEC) only for connection-less sockets [1]:

"""
If he initiating socket is not connection-mode, then connect() shall set
the socket's peer address [...] If the sa_family member of address is
AF_UNSPEC, the socket's peer address shall be reset.
"""

So if this is Linux-specific behavior (?) and we don't exect any users
to rely on it, why not change it and see if anyone complains?

Seems like wasted effort to try to make it work properly.

[1] https://man.archlinux.org/man/connect.3p

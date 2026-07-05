Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73F26CE39
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236372; cv=none; b=mlDRkOpAIzpZBtCW2CuUibPP0Vemq3f3olvenxsw3O47uIPGPNK+LvqH3yxPoy61qouH3HG6KErC52buWCso4I1ZMPuNxKxvimjFXrdEzx6Sow7ysNQDIPVjcoNSeI9X6Li3M5fqE1TfhDm7ITbp1kvgXsKXMWp0uSNLAW5Lxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236372; c=relaxed/simple;
	bh=j91LwwYa2oG0qyR23QjVJfczkQIvZ2o4Q805tY1RF6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skGx5MzYB9OlFc8QOCKcQtvsTeGk0MwBkfMrZXD1h73SXwrLYdpA6h3hUe7KcrQVVXmF7D8k1c4H20k8p9dRGsCbHL6GeX5CNz8nB3r15ENUwbCSLAMwAqd3DzgaPb7wGqSAW0pB2dmLpfD9iFxfKLR1CHVVZ32Rr2WtmBQLNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dieeuLl5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU28vimj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dieeuLl5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU28vimj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783236370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xyvE7SpL2UEBqv++HhUO/APoRvzWHvcbsO0VDOVgq0=;
	b=dieeuLl5c4MW1Xg1qWmS2b/hAKs87Mgk6CjT1iVBqG1jf+LK/b94RbCC2UGtlBldgLaiAs
	BuZg22DRBzYptAv3uTScKRx0WZqwNLd/1Zi3AuGvnXkkNWliXryohrsPMtObOxcbxEW8FH
	k13JyR1wxd+HGftxR4jWkyaoQP4Weoc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-8Xq1uNHfNYiYKNsCqB3qxQ-1; Sun, 05 Jul 2026 03:26:06 -0400
X-MC-Unique: 8Xq1uNHfNYiYKNsCqB3qxQ-1
X-Mimecast-MFC-AGG-ID: 8Xq1uNHfNYiYKNsCqB3qxQ_1783236365
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493d88406cdso635015e9.1
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2026 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783236365; x=1783841165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xyvE7SpL2UEBqv++HhUO/APoRvzWHvcbsO0VDOVgq0=;
        b=fU28vimj1gHOfQOiJkkhCUGOV4zMcCOT3rFe0JyX4EOMNn+RnFkVuXLOraSNmDnuYj
         6jXDMJrrpyxLg39lyadDqPF+yP/5IaFZSOK4ck8HpLUG5WyH/SaLtKd6yAqFH0QLwfc8
         XUawqiNzg9VLPIkszEbMMgxZ9vG/U7724XudOz0+RqEdM95K2zsP6NcuVcFIbbc1XYpw
         hSnTDc1S+GEkp150BUYy5gIPhOzhY0lWbql24nn+RxdKj6miW9GTHgKRIy9X26q85Bu/
         rZJe47Jf63B6uRaJ6lJSImEbPuINc3AK++UIaq44FAr8CaCrurkweYy0bmLscvtY3QLt
         0oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783236365; x=1783841165;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xyvE7SpL2UEBqv++HhUO/APoRvzWHvcbsO0VDOVgq0=;
        b=I3XxbBH1EAaJBhcMu8tNb9xQ8eTfS1y0mEChhYVrOrJtavYLKUyqJAyNwg8+bBgQjt
         TxhRrJxlJrtBFLnwho38qgcN80+nSnQ+hlYFrqOCJa5PCRI8IKKCT9/y2FI+cCjr1auo
         7KmwU0CrQpnwUvsCmwIEwKE6DvQybltwFkmM+x27/p1xR+ZnnkXhyTh5U3+0Zda7tTLx
         mPf9cTH5+Gvy0d3WnkFVDYYGc4Q+TC73vZR3b2s1zhZZHeXtEbP4AHD2c5vkSWElpACV
         nbff2eTzM9Q6TB2ZQABJhkcfAGQtLUkjR/RwjBag8oeOWmsxPHAP4Xnh0agKD+LQefgi
         9O4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Ortlv+c5pe1nwpyjAnx+FhjDkYsX6swl6B5ULfpth3+PmisEu6fwvynUqslFZXyt/kOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJhSZHr2JaUKLymE1B19gs8TELyOi0LHbF8gYGzJoi6YX3Dtu
	v6FoWQkrzkAQ8z6YZ7FTNcgxS5a1LpItxcE23S5lit3QIUtJgLg3y8zfm+YPYO7F+iMdan3j0wW
	Zie3RMgo1HiUI+T43tY7UQs4LqAAdnpnXeYjs8cuoinML1g30Cpai/A==
X-Gm-Gg: AfdE7cncQ8FYPiGyEjicWeOXWxcDSLnxew/6KxhhyyD+vMcpTZZRCLxuAvjyIpwjmdU
	1pdHVfzwhDRkDhhn/z6LAyvt4EwuWscIca9lV1PWmc04H3ELXUUxTfi8q7Mu7ZmWAd0gzPJ7f6j
	HBRY++xNYoZW6e6JehsqVhMR2B5ly+hXSbsXHDskSkMQqmg5H7SVJzKHu15TRs2oBZ1REiDu6GZ
	wjyUbUQDc+C29PI4bx4RurscrRfeD4p5BFbIBfV124Rm5AZlXFuXwjkpZqJ+olVYDwMm2+CkycQ
	aa7LRgdiYOhqRFFXGzDzj5NcHFhhtE1Q1twPDokXEzMC8fOp7oubwvVT3SVga7diIVGwTB0z/rW
	CIR5AmYBgTkXvyIH14HKIW28S72Gk6eXR/0h1/wq0FE0AQMYIDSbY0YtMi44qe5oNVQDV687xBJ
	OI6U/G
X-Received: by 2002:a05:600c:5306:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493d11f37e9mr66351725e9.19.1783236365421;
        Sun, 05 Jul 2026 00:26:05 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493d11f37e9mr66351475e9.19.1783236365011;
        Sun, 05 Jul 2026 00:26:05 -0700 (PDT)
Received: from [192.168.0.115] (ip90-44-231-195.pool-bba.aruba.it. [195.231.44.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdabda3sm186697685e9.5.2026.07.05.00.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 00:26:04 -0700 (PDT)
Message-ID: <c526d9d9-db4c-45e8-96c5-52b2a9dca7e8@redhat.com>
Date: Sun, 5 Jul 2026 09:26:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Victor Nogueira <victor@mojatatu.com>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
 <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
 <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/1/26 5:35 PM, Jamal Hadi Salim wrote:
> On Tue, Jun 30, 2026 at 11:23 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
>>> On Tue, Jun 30, 2026 at 8:33 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> From: Jamal Hadi Salim <jhs@mojatatu.com>
>>>>
>>>> When a TC filter attached to a qdisc filter chain returns
>>>> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
>>>> act_bpf action), the redirect was silently lost i.e no qdisc classify
>>>> function handled TC_ACT_REDIRECT, so the packet fell through the
>>>> switch and was enqueued normally instead of being redirected.
>>>>
>>>> This has been broken since bpf_redirect() was introduced for TC in
>>>> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
>>>> for a long time because bpf_net_context was a per-CPU variable that
>>>> was always available.
>>>>
>>>> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
>>>> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
>>>> is only set up by explicit callers. Without a caller setting it up,
>>>> bpf_redirect() itself crashes with a NULL pointer dereference in
>>>> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
>>>> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
>>>> adding skb_do_redirect() calls to every qdisc classify function, which
>>>> would require changes across net/sched/. Isolate it to ebpf core where
>>>> it belongs.
>>>>
>>>> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
>>>> wrapper around tcf_classify() for use by qdisc classify functions and
>>>> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
>>>> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
>>>> than letting it continue silently. Dropping is preferred over
>>>> letting the packet through because the user immediately sees packet
>>>> loss. Silently passing the packet through would hide the problem and
>>>> leave the user wondering why their redirect is not working.
>>>>
>>>> The clsact fast path, tc_run() continues to call tcf_classify() directly
>>>> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
>>>> sch_handle_egress/ingress() calling skb_do_redirect() as before.
>>>>
>>>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
>>>> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
>>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>> ---
>>>>   include/net/pkt_cls.h    | 14 +++++++++++++-
>>>>   net/sched/cls_api.c      |  4 +---
>>>>   net/sched/sch_cake.c     |  2 +-
>>>>   net/sched/sch_drr.c      |  2 +-
>>>>   net/sched/sch_dualpi2.c  |  2 +-
>>>>   net/sched/sch_ets.c      |  2 +-
>>>>   net/sched/sch_fq_codel.c |  2 +-
>>>>   net/sched/sch_fq_pie.c   |  2 +-
>>>>   net/sched/sch_hfsc.c     |  2 +-
>>>>   net/sched/sch_htb.c      |  2 +-
>>>>   net/sched/sch_multiq.c   |  2 +-
>>>>   net/sched/sch_prio.c     |  2 +-
>>>>   net/sched/sch_qfq.c      |  2 +-
>>>>   net/sched/sch_sfb.c      |  2 +-
>>>>   net/sched/sch_sfq.c      |  2 +-
>>>>   15 files changed, 27 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>>>> index 3bd08d7f39c1..5f5cb36439fe 100644
>>>> --- a/include/net/pkt_cls.h
>>>> +++ b/include/net/pkt_cls.h
>>>> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *skb,
>>>>   {
>>>>          return TC_ACT_UNSPEC;
>>>>   }
>>>> -
>>>>   #endif
>>>> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
>>>> +                                    const struct tcf_proto *tp,
>>>> +                                    struct tcf_result *res, bool compat_mode)
>>>> +{
>>>> +       int ret = tcf_classify(skb, NULL, tp, res, compat_mode);
>>>> +
>>>> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported.
>>>> +        * Use BPF via tcx or mirred redirect instead.
>>>> +        */
>>>> +       if (unlikely(ret == TC_ACT_REDIRECT))
>>>> +               ret = TC_ACT_SHOT;
>>>> +       return ret;
>>>> +}
>>>
>>> Why did you remove the warning?
>>> A lesser issue is that you introduced a space above #endif
>>
>> I don't think we need to put out an extra warn to spam the log, this
>> can be easily traced either via bpftrace or qdisc stats etc; plus the
>> guidance to eBPF with clsact is also obsolete. Given noone has run
>> into this the last 10y, I don't think it really matters tbh.
> 
> It's a bit entitled for you to change someone else's patch to fit your
> philosophy without a mention.
> It's only one message per qdisc. But fine, let's keep it that way.
> Sashiko is hallucinating on TC_ACT_CONSUMED for patch 1. Let's ignore it.

@Jamal: I read the above as if you are ok with the series in the current
form as a whole. Please LMK.

FTR, I have a slight preference towards the extra warn message in case
of misconfiguration, but big deal either way.

/P


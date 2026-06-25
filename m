Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290530566D
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410037; cv=none; b=iQV53AyTTMbFYeJ8t99tckqUhz3mzf2uTBqmgHImXRAo44MVlF942/a1nPKLavJ30mFcS+UPRhCcqsitnlDMWT1CPHfXMg0hVwSWVLL3AzeOdtqm7zAhuBWlpvTjKTRE6LCtjPcmwr7wcwVP9rftKGNWUhv3J9lY+WUFMdEzM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410037; c=relaxed/simple;
	bh=B11ZQTvdIL93NkafABLbpIaW0vHdrH1GQy1hrBB6/9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T4aHLgAi+xwiO2BVN/aiNkKgeTl7erxYcPZnDwyfDYkcQJxFUscOQKOkVJYGSrwHjNuRPQGoJdFDlLAWnGUt5Ad8yBKtci49qyqGU5qy5CNDyf14MDcKqAnJq8d7kUIxlpOitsBir4L7P4gzQkMwjxIJ7jYWWexCgsbu16CTI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rntj4F7p; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rntj4F7p"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso105114a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782410033; x=1783014833; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baUOcdej9K28SalpnnlZ0AOjTR4JaafvonBsqfAXZxY=;
        b=Rntj4F7pdeV+U4fmLXnLyKjW56JswuH9yGVaFGcbgVViAEapY2fU6BpN9zay8WkKuT
         f0KYFcyqE3DDxoWc1a0Zrhm8zTuH28yMBD0dI619d9qLiz9Q6c4RUXtzavJ17rDUvo7Y
         sukQrKkyKUsFdvxjA1gfVstmWZUnBI7LbbnvMknIDjRql2Btl4vtYvCKgEhQ/d5Wvo/F
         RHfDwpnWZsY8ckBVVA/SjbunGz66G/cnENioBC9xR+tmOyWBo6z49/em2LUYvIiGamhp
         nm8z9x7MJ+sIw8OcW0ThwVGlM8D0RkTd2hK3DOv1jzkfADBP95OJqK14RUrLv0GO2rNP
         T4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410033; x=1783014833;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=baUOcdej9K28SalpnnlZ0AOjTR4JaafvonBsqfAXZxY=;
        b=a15ppJvO8mht2IPHMec+6g7iQ/D141ls1xTOji0+ss2gAqumuDl5b887A5r/+lLNAl
         6lY1kCjzHBmzXhKU/zRwItvOf7N0Wlug29NZFfR1I52p1aaiCYuSFeWsuM0lWqQLZ+Vi
         hlrnMo5DDJTQsFl9X787jMhg8jOKV3a0jFDsrkNXww/Px0wslOJBCqphsvhDvolvp2Ke
         pCwe1lNN2Mkc8R6imjZL5bHsZb0bW8ZGarCSSN4j60hAo+lrssvehgu2d+Eg/U9Wr7To
         XAQiR8EwxGbYfo6ZDDEODJAJJN2eCkP0PCbhJY+XdEh2O0GekUZG17NDFZ/k3wW+GAJ1
         yNew==
X-Forwarded-Encrypted: i=1; AHgh+RrPUvplmrZ5HZwjesv3K7YfxpQeXb3rPoR949wi357rHvJrQczte9SlxwhxzueTrA0mCIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJ5qR/ujqL/bjOvG9d8wMpjRd5jkwq6J89ya8zFWwhaxlyml+
	Zn9HTgFB9OETUyqGmda+5VE5I6O1zTTN4aAwX5M9YuXzAitJZqfA95i7C7N1jxNp7O7EHTBq6SJ
	rTZzAasg=
X-Gm-Gg: AfdE7cnxyKyWDMOarObfPhqZqCyZtFUbK5lkDBsxbAnOiSk5c1rpUT56+0fCyxyOgsv
	T8U75Le7SGmw2LofncGz9u16ZLksAM2UDZ+h+MINVpT3L133Cqhgq99hGweqYXbrY9sm5IYvNRj
	FJW4AD/6sLX7hd1PROantOSMLq2tDH9MmrLux0NRtgx8UOLV1lvPVyxo71IMon7T/I321Lgp4XB
	pX4N59INLar3NfglGxim87bryyTTqub2ZyGrtSe+G12cdYTbt+DiQpKl1xwdPSizj+7yarpsOje
	cz+nPEV3RkZvtv1bj5AU2YeGGvD+Wu5UNDNezCxe+O1P3//GOmO1hjPrvYAJwXo3kwvICNnmCBr
	O5VtQOg7rkFUNWvnwx6cvlwKcR1aIgtx0wGBY9AqBqZu267oFUYTS6hc5kNXWtOApPNMeQjlXFf
	kS7j0GfcvYgV4Kqm4=
X-Received: by 2002:a05:6402:278d:b0:697:b778:c2d1 with SMTP id 4fb4d7f45d1cf-69810afd14emr226075a12.17.1782410033016;
        Thu, 25 Jun 2026 10:53:53 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bcd8f7sm1838393a12.26.2026.06.25.10.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:53:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>,  "Amery Hung"
 <ameryhung@gmail.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "bpf"
 <bpf@vger.kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,  "Daniel
 Borkmann" <daniel@iogearbox.net>,  "Jakub Kicinski" <kuba@kernel.org>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Network Development"
 <netdev@vger.kernel.org>,  "kernel-team" <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com> (Alexei Starovoitov's
	message of "Wed, 24 Jun 2026 13:57:07 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	<87mrwlyqg4.fsf@cloudflare.com>
	<CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
	<878q85yoy5.fsf@cloudflare.com>
	<CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
	<a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
	<DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 25 Jun 2026 19:53:50 +0200
Message-ID: <87cxxey09d.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 24, 2026 at 01:57 PM -07, Alexei Starovoitov wrote:
> On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>>
>> Hi Alexei and Jakub,
>>
>> skmsg is actually still pretty useful for gateways.
>> I started with bpf by integrating skmsg into nginx as a module and envoy 
>> has something similar.
>> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for 
>> L7, redirecting
>> between local apps by looking at the payload. So there are real users.
>
> ...
>
>> Agree, just like we remove skmsg from KTLS which is rarely used.
>
> ...
>
>> Hope not have skmsg disabled by default.
>
> I wasn't suggesting to delete the whole skmsg,
> but to disable combinations that are causing issues.
> Like what was done for skmsg and ktls.
> I'd allow plain tcp and udp sockets only.
> Allowing unix sockets was fishy. I think we should reject it too.

For unix & vsock we know Bytedance built a proxy using it.
We've been showcasing it as one of sockmap use cases [1].
That said, I don't know if it's still being used or not.

If we don't want to go through the config-knob-then-deprecate process,
then I guess the only option is to kill it and see if anyone complains.

[1] Slide 117, https://github.com/sockmap-project/sockmap-project/blob/810d259af6e7a5793922af3991c9dc7ff502fe19/talks/2024-09%20-%20NDC%20TechTown%20-%20Splicing%20Sockets%20with%20SOCKMAP.pdf

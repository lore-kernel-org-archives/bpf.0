Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713183;
	b=QrFNVOJDhUSqdswnLIxO/jMrJMJDmSKvE5pT5ZLrxsWtg4hqUOLAHPOG/XsTTVa19PCn
	 9MVWhHeoopkpWfiEzNYjZyhbKX4zd4ICXIeVM15epyfXEJ8SOm06Tz7exNpiWMMKc25Ey
	 fz+CTL5IhaTsLxETOdU9+OKRcehAcVPpZCyUW76AFt67I1V9PA4+XkFk0h2SV8tXThAId
	 bqw/mCX42ZyZke9i9me+p2s0/1i8ue9dM4PD3yubkDQoGoRaFLqOKze1yPXmeE/t4kjQl
	 tLiFm/EqE1g+1GTqeMHapQf7nraIuLPOHH5WSAPIepuxxmrA3YE++FQPJvPRtfn2mKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=cLoL6zU3igpVzOu8bmZxwYe007VSMU7qo5AAn5+uJMo=;
	b=youlO+X105DoR6PhI/M/kZqUS/MPZMEC5hId0kPKe4Uv6krxl/+u+B2chT7BG5G1+v7t
	 9kpC0Dev4F9cGtO7zjv7AIRtzjTJoh866erOu7kO0+Z8aRSe6zZ9PpjXz1RwPiMLZ0eKd
	 ZZW7Di35GAez7GYjD3LXcbXGEyuzGfPfbu2nGNFL5oWMeuxYyPrYEImHWe8DrdRJtbW23
	 hZA1jdRvTMUUxcI8Pez/H1moT9ZTIEGVUtBF9w5ZUaUxCbkzjDYqyB+GYN4YkLyqsO3PX
	 ymmsQjhsBeR0sSfEHiQU47wsc7i596SxRqI1RqaebxR3zGdMYKo6jgrRF/J+oqCJ8pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QG1oGlTi;
	arc=none smtp.remote-ip=74.125.224.135
Received: from mail-yx2-f7.google.com (mail-yx2-f7.google.com [74.125.224.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1679606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 23:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1679606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QG1oGlTi
Received: by mail-yx2-f7.google.com with SMTP id 956f58d0204a3-67a1a96329cso121681d50.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792713181; x=1793317981; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLoL6zU3igpVzOu8bmZxwYe007VSMU7qo5AAn5+uJMo=;
        b=QG1oGlTitcSwMiyTbDrd0egTYfDg8fR5V9DECLp2MMjDjfrMKxGQXuBmvuePu9hPPO
         +aF7Ryv1mcmhI5C1Dr7FLjPFoM1CRuia6jtL79ap/Wzkqfrgxf/3tVzEtDGFUvFChghw
         DB3StUdoVNEkaJohaqZQp81qjbSbP9CC8rT/08/MS2I3G8bHZFI+ReKD5QzuoWWMg1T4
         uMNK49UyvIFE70yBZsWai+4ANSj/8SvR10E5XHSFmWwgm9f3gVbPU+KUyaRxOMaid3YG
         /eHZEbSBSshgSg4ZE3B/T3yZPQuaW9ilMaj33vRS3cx6qNKd5liW8NQn2qp3E37yhVxh
         o0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792713181; x=1793317981;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLoL6zU3igpVzOu8bmZxwYe007VSMU7qo5AAn5+uJMo=;
        b=0eQ98oDLNRFDmaU5+1o7hVfT5zgCj3H1MvpKZMjATyehSS4tqGx59vmoQn4DTJMDfU
         2Q/J4nk0NZbKjBDkLo8iLkfhzTD33Nn8sBd9W3S6MbPBbughhJdp8OVYxi8G03LYeW5y
         tESPpKXeY/iSp1k1zU8ya/4sAq/pU+aFZ0f1aKInPxWJvVB7nC3G76eZOYb9EJVzPtiT
         PKQuWjDqkWP7ihunkoyCm5Ap0WKjIECxFAMxzFb1/pkwHW+Q1R+gYKOoYa+z8SrRiHmx
         vqhAuuNCZg5I91QfkPGO8TdpzMX1+9okqb2ASrfOJ98ebK8o2tFXIPP45NT1Q3adqaVD
         8Epg==
X-Gm-Message-State: AFq9FYLp4JBUITcLSRWjW/BbX60VUtOErTHu09MNqJihijwOAJzQNY4E
	BIe9LKDF/wBtPKaNQz6lnzG4dfqFPlvjHHaEFwARmTdiaZQ9WD+dc9Pj
X-Gm-Gg: AYBFou3ssUHGQ0j/9GwLfwG1p3bcMMrJQJfkhT/ht2KLOex2P0WMKhUp70v0gnfstkf
	fry07y799mKqf3OYr6If3udOTK43iOMR0/RxJohz6NitVqMWkJu7njJ77oSHA+NKovdcm6ZYBMo
	mgTHXcV5+I0lSkiWAW8PIs4xx0FFcoC7MGkJPh0mRuwGMRt4Cna0IowwR1uiam7mjkC77dvSWOc
	LqPSzyB/KRiVAsSJEFeSTaWI/X0CtSKfvFiM5FlXtU3NUsrkQPA1yOZ4Y09aGgUj2nzL8PLyZM2
	Qb+isV4qCAOZOFGmOzwLJlPNXd+2ZM3cg+3GBx3EsKyyblX1E0ygoaVXNWCNzhuIiDPxZlHcPpa
	ffaJu6uodpbEtVML6okTNf1zqXtcjzZzD76YdrIxDrOmfHMUCFOr27MfR2nEk2s3TpY+KsVOOXp
	elwRhRbchnqN2Oz+WYFn9B64pcUetvjX13UNS6DC3mwaqgTmAQtC6Ymalzc6vKMqjhJewEVqFXf
	8+qZUei67AMDQBeSde0CG3Vrr/7QZ184qcClXLaPYpNwwW6IUXtwWwR7TsAgB2zQe1xebQo8kek
	n0HUcGlwImy3Rr9CR0phfPlkPBUWPJbN64jG41VjP9p9tAvVs/TMx0jxcjBLyqs=
X-Received: by 2002:a05:690c:7108:b0:8b1:10ee:cc51 with SMTP id 00721157ae682-8b157d02874mr4396637b3.31.1792713181573;
        Thu, 22 Oct 2026 16:53:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156115330sm5831177b3.18.2026.10.22.16.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 16:53:00 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 01:52:59 +0200
Message-Id: <DMBRS988UZQ5.OJ7ZMBFZHJDN@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 3/7] selftests/bpf: libarena: Add buddy
 per-CPU caches
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Harry Yoo" <harry@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261021232641.10063-1-emil@etsalapatis.com>
 <20261021232641.10063-4-emil@etsalapatis.com>
 <atoAxMKmTpuUiqMf@thinkstation>
 <DMBRIUEJD3IW.3AXK142IA7TBH@etsalapatis.com>
In-Reply-To: <DMBRIUEJD3IW.3AXK142IA7TBH@etsalapatis.com>

On Fri Oct 23, 2026 at 1:40 AM CEST, Emil Tsalapatis wrote:
> On Thu Oct 22, 2026 at 12:53 PM UTC, Harry Yoo wrote:
>> On Wed, Oct 21, 2026 at 11:26:37PM +0000, Emil Tsalapatis wrote:
>>> Every small allocation currently reaches the central buddy allocator an=
d
>>> takes its lock. This serializes otherwise independent callers and touch=
es
>>> the buddy metadata on every allocation and free.
>>>
>>> Add a fixed-size LIFO array for each cached order and CPU. Keep the
>>> per-CPU cache pointers in struct buddy and allocate each CPU's packed
>>> cache from the buddy during initialization. Cache the eight smallest
>>> allocation orders, up to 2 KiB. Each array holds 16 objects, bounding e=
ach
>>> CPU's cache to about 1.5 KiB.
>>
>> TIL the min alloc size is not PAGE_SIZE in BPF buddy allocator :)
>>
>>> Allocations pop from the local array and frees push onto it without tak=
ing
>>> the buddy lock. Empty and full arrays fall through to the central buddy
>>> allocator. Packed arrays keep the fast path to a bounds check and a sin=
gle
>>> slot access.
>>>
>>> BPF programs only disable migration, so another task can preempt a cach=
e
>>> operation and run on the same CPU, and an IRQ or NMI program can interr=
upt
>>> one. Claim the CPU with a cmpxchg on a per-CPU flag before touching its
>>> arrays, following the model used by the main BPF memory allocator. An
>>> operation that finds the CPU already claimed falls through to the centr=
al
>>> buddy allocator.
>>>
>>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>>> ---
> [...]
>
> We don't really have cmpxchg_local() available in BPF. I hacked up a prot=
otype
> and the benefits were actually not that significant, about 2ns for hot al=
loc
> free loops.
>
>>
>> On x86, cmpxchg instruction should be cheaper without LOCK prefix.
>>
>>> +
>>> +	return cache;
>>> +}
>>> +
>>> +static __always_inline void buddy_cache_exit(struct buddy_cache __aren=
a *cache)
>>> +{
>>> +	smp_store_release(&cache->active, 0);
>>> +}
>>
>> We don't need this barrier because this is percpu?
>
>
> ... this, however did matter significantly for hot loop frees. I will add=
 it
> to v3 and respin.

What architecture are you measuring it on? Because on x86 smp_store_release=
() is
equivalent to a WRITE_ONCE(), so unless this was suppressing compiler
optimizations and the code changed by doing a simple store, I don't follow =
how
it would help.

Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65309334688
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180384; cv=none; b=iF5wPo8fmNCjfY1ePqT+HqeYpyx3tgFpI5CCecjVO9gdJy+0ZUcdKUgi1MqbiCG35dEUA8uCaC7PSoQ4Rey0zzXWrc3Bcgq4hIYLgxW12IpyS8ScLX6cjQKoBQ+w9BYrYv2VPEB7efWfpUmm6uxWik4mQgVT4KfrZsFL9JdwXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180384; c=relaxed/simple;
	bh=OiiQ6NpHryNtjGVVPD22cyeUNTIH8+XUUWiFi1FnLh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GSI3V2v4GrHBKOezi7FGoedNaski0uDi2WzmkW1BmEholcsWwsbwGwFbM3kuJUIGncMXi50W/Mr+v8XG3QhZM2ZD9ZfuEKfrYoDVE3TfzsNLiCcwFpRuLhdRsTuFBAAzvqbCvVAePL9JolYDE8Uxe294+maI+H25BuwvLIZ+LEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VupZkdig; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VupZkdig"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so280026266b.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769180375; x=1769785175; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkIl7dS+mkiKgOTH9bgq3/o2+8pPlzP+BKaLvYWO3Zs=;
        b=VupZkdigAVADoCnmxfFHhdPVfxedK8utn3d5xY71hhKpK4cDXVOoM4C5+X/EWd17lD
         YCa+8J/fT2asK14qObzGjC/pEURnemMM8DlghYwX7xKeueJo3XW3nM4CdygS46ftt9lo
         KEBL2+ydeppjIMTWQrlzgLDaAH4elXF//0PYB7nh1hXaeoHjY68BVFqMmpSP2tNoyQH9
         cpvMn2297CMaWurdqFOwk1vaYg7w1DUVtZqmZaMTCjc4N+NLZCLrF14lg676BMsIqrIf
         YC+3ZouZBtTa6bT0dqAosXGb/NjlI7FN/EOdsx46u0utCcrq9VaOwAD0YfR0Is3YLxpv
         uVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180375; x=1769785175;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkIl7dS+mkiKgOTH9bgq3/o2+8pPlzP+BKaLvYWO3Zs=;
        b=mZMAucpfM+cddlQ6yxWKJ/aEZcVzKRo3Dk8e1TWUCIpV3Rp9MgTEK0tNi3ETAwF9B7
         ToxsBPNuNFt4dXSDZmxHhkBxplmBLtZiHznZR1Qiojd2waf30DSJPKZlkXTcleEfekTe
         kHee5ffZRsUZczdlGMxwG9UtBPhHYVZ00rGuX0sTgBTK+tJzdm6Pm2NzEELBX5E7GmC9
         P5GcLH2JQBfRanpynYgDeDnJJi5gFXddeH5b66m+lXN8GmIv+e55sypry/75gFdppzqK
         ZtwthyER4gnPbMFD5W/5zZQQLiX37OrXNSkANJGHp9chiutBOjdiYzFhJmyDLJAftTrl
         89mA==
X-Gm-Message-State: AOJu0YyyvEwa4Rb/QqutOH5c6LWiinSSF9vMURiuOw5B8NkX3i2lAIVW
	fegHvAekipC8PVsGKBs4VCkZhhPnRj+zCNr9Yl+yPWOGji+18Wk+48KqgAYZb8vReTY=
X-Gm-Gg: AZuq6aLGjUUeyuHTp5OPEZoDW9Q/paKhInWXwwelVnYsFoY5WZXYKVkLYBFqDmhxH/J
	liklE/6ay7SRjOQFRYBOJ7Rv75su/LnprPWRa+HEvpZaA0f5Rxxhq1bUhNzzkjM1eKqpCXw0GNg
	0nyCttLE4R0ViM8IcDn4YpR4FKI9kwDmNHgnAOdRhMtaiixkR7HLQ4AhagrRpkEGQgJ6Nku+m/d
	PIBN3i+iqdj0wHBol2wdG8GMCd7Uc6rJKJnAEOvhPTQ4NAPGGpU3Ho8JidyryiD4r8S5FYBctyj
	1Wt5zbMP5pN2czX6AwGWTp5YO7GCsquwLTxP4SrQy+sEBwYyGWt2b4nin4UXtFyJv14UG7CCRRM
	Q4OOhbG4phNCLVDtQtug+XbkOQbIP2K9HTrNZkin0S7ps1bnOPGltIPtjUslc32tsIFj9h7niPH
	i6Bb0=
X-Received: by 2002:a17:907:9616:b0:b87:d92a:f71 with SMTP id a640c23a62f3a-b885aea1336mr201953666b.62.1769180374748;
        Fri, 23 Jan 2026 06:59:34 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6ff176sm115832466b.32.2026.01.23.06.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:59:34 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  "John Fastabend" <john.fastabend@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Simon Horman" <horms@kernel.org>,  "Neal Cardwell"
 <ncardwell@google.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "David
 Ahern" <dsahern@kernel.org>,  "Andrii Nakryiko" <andrii@kernel.org>,
  "Eduard Zingerman" <eddyz87@gmail.com>,  "Alexei Starovoitov"
 <ast@kernel.org>,  "Daniel Borkmann" <daniel@iogearbox.net>,  "Martin
 KaFai Lau" <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,
  "Yonghong Song" <yonghong.song@linux.dev>,  "KP Singh"
 <kpsingh@kernel.org>,  "Stanislav Fomichev" <sdf@fomichev.me>,  "Hao Luo"
 <haoluo@google.com>,  "Jiri Olsa" <jolsa@kernel.org>,  "Shuah Khan"
 <shuah@kernel.org>,  "Michal Luczaj" <mhal@rbox.co>,  "Cong Wang"
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <d8c440c1255979b5120eed985f7d156f68cd7a3f@linux.dev> (Jiayuan
	Chen's message of "Thu, 22 Jan 2026 03:56:50 +0000")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-3-jiayuan.chen@linux.dev>
	<87a4y8uy67.fsf@cloudflare.com> <871pjjux2u.fsf@cloudflare.com>
	<60a0c463ef6dbe38d836c773c5256706c163311c@linux.dev>
	<d8c440c1255979b5120eed985f7d156f68cd7a3f@linux.dev>
Date: Fri, 23 Jan 2026 15:59:33 +0100
Message-ID: <87cy30tlwq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 22, 2026 at 03:56 AM GMT, Jiayuan Chen wrote:
> January 21, 2026 at 20:55, "Jiayuan Chen" <jiayuan.chen@linux.dev
> mailto:jiayuan.chen@linux.dev?to=%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.dev%3E
>> wrote:
>> January 21, 2026 at 17:36, "Jakub Sitnicki" <jakub@cloudflare.com
>> mailto:jakub@cloudflare.com?to=%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.com%3E
>> >  I've been thinking about this some more and came to the conclusion that
>> >  this udp_bpf_ioctl implementation is actually what we want, while
>> >  tcp_bpf_ioctl *should not* be checking if the sk_receive_queue is
>> >  non-empty.
>> >  
>> >  Why? Because the verdict prog might redirect or drop the skbs from
>> >  sk_receive_queue once it actually runs. The messages might never appear
>> >  on the msg_ingress queue.
>> >  
>> >  What I think we should be doing, in the end, is kicking the
>> >  sk_receive_queue processing on bpf_map_update_elem, if there's data
>> >  ready.
>> >  
>> >  The API semantics I'm proposing is:
>> >  
>> >  1. ioctl(FIONREAD) -> reports N bytes
>> >  2. bpf_map_update_elem(sk) -> socket inserted into sockmap
>> >  3. poll() for POLLIN -> wait for socket to be ready to read
>> >  5. ioctl(FIONREAD) -> report N bytes if verdict prog didn't
>> >  redirect or drop it
>> >  
>> >  We don't have to add the the queue kick on map update in this series.
>> >  
>> >  If you decide to leave it for later, can I ask that you open an issue at
>> >  our GH project [1]?
>> >  
>> >  I don't want it to fall through the cracks. And I sometimes have people
>> >  asking what they could help with in sockmap.
>> >  
>> >  Thanks,
>> >  -jkbs
>> >  
>> >  [1] https://github.com/sockmap-project/sockmap-project/issues
>> > 
>> Hi Jakub,
>> 
>> Thanks for taking the time to think through this carefully. I agree with your
>> analysis - reporting sk_receive_queue length is misleading since the verdict
>> prog might redirect or drop those skbs.
>> 
>> There's no rush to merge this patch.
>> 
>> Since the kick queue on bpf_map_update_elem addresses a closely related issue,
>> I think it makes sense to include it in this patchset for easier tracking rather
>> than splitting it out.
>> 
>> I'll spend more time looking into this and come back with an updated version.
>> 
>> Thanks,
>> Jiayuan
>>
>
>
> Hi Jakub,
>
>   I've been thinking about this more, and I realize the problem is not as simple as it seems.
>
>   Regarding kicking the sk_receive_queue on bpf_map_update_elem: the BPF
>   program may not be fully initialized at that point. For example, with a
>   redirect program, the destination fd might not yet be inserted into the
>   map. If we kick the data through the BPF program immediately, the
>   redirect lookup would fail, leading to unexpected behavior (data being
>   dropped or passed to the wrong socket).

I reckon there is not much we can do about it because we have no control
over when inserts/removes sockets from sockmap. It can happen at any
time.

Also, a newly received segment can trigger sk_data_ready callback,
and that would also cause the skbs to get processed. We don't have
control of that either.

Does this change break any of our existing tests/benchmarks or some
other setup of yours?

>   I also considered triggering the kick in poll/select via
>   sk_msg_is_readable(). However, this approach doesn't work for TCP
>   because tcp_poll() -> tcp_stream_is_readable() -> tcp_epollin_ready()
>   will return early when sk_receive_queue has data, before ever calling
>   sk_is_readable().
>
>   In the next version, I'll address your other nits and remove the
>   sk_receive_queue check from tcp_bpf_ioctl. I'll also open an issue on
>   the GH project to track this problem so we can continue exploring
>   better solutions.

Sounds like a plan. Thanks!

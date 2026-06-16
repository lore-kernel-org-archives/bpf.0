Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF47CC64
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635223; cv=none; b=JLRqdklzNkGM1aKmu0PAhZGhcnAwPeITApEryT5evLyv2UQMpkph06rQxWuLv3Qs43UoD5OlpjV/YmQKO2lA7AI0g1fHU67aZFQ/CnY7b0/nEvCrrCUqh2w+KM3w2BVCCpox+EXXrr1zkBgokil4FWTvuARXTQvGFbEKwpvnWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635223; c=relaxed/simple;
	bh=gvUO7RCQqgqX488rYJC0Dl5rmAiiSJamx6e3T6ZMGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy60r9anBJro8EmAtAZIZLOfN7VkDYceEfqmiz5/UNNGDol7LlEGJKNhg+SY5V606qceC3Dsu7vaf2ZbucBJdziOILuyWRtplt/Yc3s8x8VYeWtstoQU9NwC1lzqDnSeWhZXzun2wrUkeJtO9DJSSpT8ZyTu1hSxAqBOGS1p7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1jtgSB9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1jtgSB9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c68190ade4so1289995ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635221; x=1782240021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hu5lbQqts//sz1A7GSfyJ8y1LToroYIqrwlHCW84PFk=;
        b=d1jtgSB9SilmHnKrwxzwKW1GvEKRan/tHGWDCI3ej3idAesVszb06ez7fPb43Wp953
         w6mPI/RxtxsZ19qZc84/IFGy8B3F4Tgf0fq4mB4noui0KFXxzDgN9VxLqD96SAubTjf0
         UWrmLbsqeEmdc3CcVcwGXgUtsv+WU79FPqBjgk8UT2AHnOXd5wrh+yuy7axnIM076bwA
         oqg1V00/l9pR5H2UCgRr7Wi84HP9i/z6NnSqzErcJnuMOP2t2TePZ1dvKXFBS2BgNCFG
         scXahtgZDNbo/Yr43mpNzjuy0LyEoxr7+RH3N2sT+e01Xn9iAFEwRA0MU7lCojb8ReIF
         9sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635221; x=1782240021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu5lbQqts//sz1A7GSfyJ8y1LToroYIqrwlHCW84PFk=;
        b=GITaxqCIvhXE3EKp9QTNRtB4bzjjjiWQZEVSXxmezrdSF1XiYxcu0nVQxQkY2kiNcc
         f8ODnkJ6zQugSy5+WyGcnsXDrgzKevkq9lIm81xvSNNFOtpcqbTuojC/tmSexNuecZqt
         vxCE322Jv4za93QNJjQZgdHKWyvEoKKbaft683oWnpTLfQPQSl+RtR2cSmAfCkfiJw1+
         6vkLNqLd4qRfEBCMax8CXSegiICEpc/DXkVTwErlMVpnumWtBW3kFj8NmwiVHbfKPrMd
         Li1+rV54eRkPEwN7X4CDOOHurDmnX7Yukx3265Inq6jQiFO8UQTzuYm1Ua/YO1mYttba
         b9yA==
X-Forwarded-Encrypted: i=1; AFNElJ87rB0M8WZXntaxjTSgqCWe9UbGo6en4cRArgZ8jl/JuIvLXlgHzFf8qnZEMm4CS8/+9ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHqLuooUD3cPH6DJXXfNOOE1YUS9Eg60AoPxtWsTVcx3n+BG4
	iS/nMlRERcIvGxxN1z9lFw/YsqkMHwGvmvh85EECRrYzu7QHPzd+v2M8
X-Gm-Gg: Acq92OFxzNzFVdw5EtOThvNbKtimWuo7l2Jvxlw2AYG/YrZX2QAFNdjn0cHoSe7PhBA
	1uiYQBS4+lyXwQ+5nsIVDlbVgoJnsbXnZvAxVlsPBffZRZJyCcL0tnV7uMeM8WAKUm388qb/yrH
	Zl47GZUSo7k6A9uT9dHQoaaNV5xJXQqhmUf/XbP3XzzRuL/f6cOKaoahlJTa51liDizOcmP1eqR
	56UqPA0tnq7h4VC9rGa1tG6x5exX7ddkAWLNzTb1PEGUamZb8tGlmIJ6J3ptNbT7v4sSQb18csh
	0LQfl20IE3KjRNQC+/R0iv2kbFdbjxBi/SgPhqZ3RyMDEKXsRZ7fJ+ORBJddJxCn081gjg0NTaF
	S34i/i0x9mpUUx5CgSjMC2dJTaoywyYMzjp4/MZ58iL4/LwO1UF0eN/vg/vIPSwNdgc4N1z/YA2
	FMfgx46RoJVfT/HlwBi8MgBLEs17cXR2zkaxEczDr/20XCxHLaVOmZVogYOT8=
X-Received: by 2002:a17:903:38c4:b0:2bf:367b:f46f with SMTP id d9443c01a7336-2c699bc3108mr42450625ad.30.1781635221384;
        Tue, 16 Jun 2026 11:40:21 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ca31sm138912205ad.55.2026.06.16.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:40:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:40:09 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
Message-ID: <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
 <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>

On Tue, Jun 16, 2026 at 06:17:48PM +0800, Jiayuan Chen wrote:
>
>On 6/16/26 5:11 PM, Sechang Lim wrote:
>>sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>>sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
>>sk_callback_lock for write to stop the strparser and verdict, giving the
>>lock order stab->lock -> sk_callback_lock.
>>
>>The opposite order comes from an SK_SKB stream parser. On RX,
>>sk_psock_strp_data_ready() holds sk_callback_lock for read while running
>>the parser. The verdict redirects the skb to egress, where a sched_cls
>
>
>The commit message is wrong. A verdict does not redirect to egress
>synchronously — sk_psock_skb_redirect() only queues the skb and
>schedule_delayed_work()s sk_psock_backlog, so egress runs in workqueue
>context, not under sk_callback_lock.
>

Thanks, you're right. it's the inline ACK, not the redirect. Sorry for
the misleading changelog, I'll fix it in v2.

>
>>program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:
>>
>>   WARNING: possible circular locking dependency detected
>>   7.1.0-rc6 Not tainted
>>   ------------------------------------------------------
>>   syz.9.8824 is trying to acquire lock:
>>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>>   but task is already holding lock:
>>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>>
>>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>>          _raw_write_lock_bh
>>          sock_map_del_link net/core/sock_map.c:167
>>          sock_map_unref net/core/sock_map.c:184
>>          sock_map_update_common net/core/sock_map.c:509
>>          sock_map_update_elem_sys net/core/sock_map.c:588
>>          map_update_elem kernel/bpf/syscall.c:1805
>>
>>   -> #0 (&stab->lock){+.-.}-{3:3}:
>>          _raw_spin_lock_bh
>>          __sock_map_delete net/core/sock_map.c:421
>>          sock_map_delete_elem net/core/sock_map.c:452
>>          bpf_prog_06044d24140080b6
>>          tcx_run net/core/dev.c:4451
>>          sch_handle_egress net/core/dev.c:4541
>>          __dev_queue_xmit net/core/dev.c:4808
>>          ...
>>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>
>
>I guess it is an ACK. What is the actual purpose of a sched_cls 
>program calling
>
>sockmap delete on the TX path of an ACK? If there is no real use case 
>for it, this is
>
>just broken BPF usage, not a kernel bug worth this change.
>
>

I don't have a real use case for that exact program. But the verifier
allows sockmap delete from tc, and it deadlocks when the strparser's
socket is concurrently removed from the same map. The fix only moves
sock_map_unref() out from under stab->lock.

Best,
Sechang

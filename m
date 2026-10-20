Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504808;
	b=uXLafLzxxTgWlx1cQhDh4DSkrNCtv9FFL3EgUPujINBI1y6Nj6KpxxKx6OHLIqkIKW/6
	 Jql8fkbX1AgTeuwO/QUSIo5BQLnD66clQQPO3aorf5uebFZzyPZd2SNjV9wP6Rdha/Lb7
	 LXDcl+REdzd/0FMQiV5nEu9YzCNkSKmluLSfr2ThNxu7srWMs40YGbvYz3orgaMjzmIhg
	 0IHqnD5tSdubkdBwgdnu4ZUz+Rud0DGhHuh3Rh+YVPq1C+2ZTpyA4pxcreymuGXsrnYaG
	 Rf8s2ii8Az9V+s8eKLtxvbhe5Sj8KApkjCblFtks40SUxtYfR61R2mCxggk9lgSb/BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504808;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=rC3IAXIo+vkfT0pJXTdpRX3kewUnN9o9Zd+i3/KaBVekit3amxD9BbQHgyTJg+I3uKMx
	 IhacgLiu62ozfL/7LY6H6pBA/OpMy+RRSfuZe6Jd1FeomCSnwiJT6lCv5+JCxZbODgTJ9
	 jrHGpf+z/FP0GGyK6RZR4wXoZbb2zZurUsQN/4FKR/65frgq/2KIIttg3amTRuj3udY8l
	 M9Ay1QmvS1wQzndaMF/hJbTLtE4TyBCUIY1mxP+ahyZMAxk/jNrFgxEUpunSy4zyFh/dv
	 grASNiUQestXjfNEQ2ioW0Xl2W6lkwkFnW47W09sz0r0CIb+QJrMVmN+HHpPvgv2nhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L0bl1cST;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mR8JAM6D;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E07606A325
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E07606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L0bl1cST;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mR8JAM6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792504806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=L0bl1cSTJ496pTbXuacsGMd8nvS9KpGFgxVVSCODXi00cApC58o1imFGv25uStSK0AnLcr
	necMXKGRWatmGQkngi51Pj2n7nPSM+63zhRbfxK3CptkE+v+lAWZH11gVH5HCANgF6CX/L
	BupaNpIWDJPsEyFLGeWAUrKkmiZVUCI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-cGs3hiIZOoaCsM9QmpJTlA-1; Tue, 20 Oct 2026 13:59:59 +0000
X-MC-Unique: cGs3hiIZOoaCsM9QmpJTlA-1
X-Mimecast-MFC-AGG-ID: cGs3hiIZOoaCsM9QmpJTlA_1792504798
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so23997245e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792504798; x=1793109598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=mR8JAM6Dx+SPWbfkeZnOuGFetgjlmDjbH+LFq7jAyJiAKciZVgzTSeI6Ngc+/YyH0P
         mCirkApaIVqwGqDQdP2i06rvMK5Lzpo/0kN8K5u1fw/RGJHTSQa9GjEofK8nUNDMiR+8
         R2Gb3eriJjl0yEV0gN6e3mnMU+2KU+03pZhqTDSW0iKY45Tof4QGCbXBCBmRfrOJGxN3
         SDa1e9D2dcwGvBSzSTbmKB6Y7A/s8AxccXVSNLU6bh6lQ/ZgeRH3t3pU4xR5+F4KqSna
         74f949/TZbz4xCOso7OpWx31lR91CKkQO8Scbt1MpT8t8+oiHGy/upa3vJ7adtQbFopZ
         7D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504798; x=1793109598;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=0jIKKdhGc1PJMSKhTEflcONUcv9RxckSCcFib408XoRhayaRU+F78YRULeqIbgJB4n
         8SL9aSaJtIfAfR8PEpGTR4GE2AgmKVAQ9g/+/pI6b3mQJBL/7n8mEhlo4gFMQkOFy+oI
         XsO/UWFFvdwucv47mGSHfnk9yg6HO/6S19uk5NpRQ4o6oU42BvzuSwvq1kVHrv8yQA91
         Rlg4KcDnC7G3b85luDL5KeNjWeFJqLmPhhBxflifFaIw/x0CDj7b9wMSyeZhG6v/Ue4C
         EPki7qftFkv0DXLUGGn8i6KtpJI/Lq/8DXY4bgl7C0IAQ8MpioGQEFzshOcrNgeI79sk
         +hHg==
X-Forwarded-Encrypted: i=1; AKwUvBwowRKENCsnAG30V/EHB/UHQz+WQ4y7wyyRYx2RGWLzD8/m9wczUxaKwWds0FBZD2ao2VY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNJJKxhCiDcgZJCRJZJITyj7iuXZvzbIMmS1ZiZ+q5Sh5fHKVC
	EdyBGcNCcPRNKhJ5umjTUCCbnW6RK3M+2wpt/+GbeuMnry2Ryr8WouUlgcbj30Un3UyKT+n6PG3
	7b0S23BOM3J4uRe+ua9H8gvzCOUMP0/RG28KeIsHCe2yHktav9cPm7JojWH6LZQ==
X-Gm-Gg: AYBFou0mlOvaF5aa/+NNaI9b0mwN+o1KhOIGuuW4fn8XSWdrpcVZIZlGqx6+D4bMB92
	o9kNEAw6SKIREWt9Lsye6EgNt/0lAxpUzpJWjEA4J4YbdQ9q85GfLFw1RXATxLZlU4Puwx8Ku36
	xmrljBYHy3Q8bNu/RC2DnserhVWCx5M4s/qyIvaPw4S9mb+35F/68s3pbV+7lgjk2aVfhYE9Ph1
	nQvBBPG7Yx1PRncIVqFh66zIxwW4qiO+ngriMSrMjFnpfUemESi9M48wRHUYHwiPE21Sad+cTaT
	S1YHCs7O7/SF7tKWDgrcdC+Dcuq3QHQq9mL0fIeKQiIOLVhaKrWbAsOz5rOHmGUP3tsopeXYewx
	6Ubi5ucc3iWNJABgy9VQ5GVVQQ0qAKzfeb/CnpGPbJ5INuS8p1iQTT3MFfFSL2FGRbJYmoLevzA
	==
X-Received: by 2002:a05:600c:4e14:b0:4a1:d307:b526 with SMTP id 5b1f17b1804b1-4a1d7464034mr234316655e9.0.1792504798211;
        Tue, 20 Oct 2026 06:59:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:4a1:d307:b526 with SMTP id 5b1f17b1804b1-4a1d7464034mr234316075e9.0.1792504797756;
        Tue, 20 Oct 2026 06:59:57 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d85a9bsm82778815e9.15.2026.10.20.06.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:59:57 -0700 (PDT)
Message-ID: <106b3ab1-77e2-4656-a124-7f78ad890ee7@redhat.com>
Date: Tue, 20 Oct 2026 15:59:55 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
To: Ido Schimmel <idosch@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
 kernel-team@meta.com
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
 <20261019081907.GA2725184@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261019081907.GA2725184@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 10:19, Ido Schimmel wrote:
> On Thu, Oct 15, 2026 at 03:05:29AM -0700, Breno Leitao wrote:
>> This series continues the migration to sockopt_t, as described in [1].
>> do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
>> and everything they forward to now takes a sockopt_t, so convert them
>> both.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> 
> Given the user visible changes, the fact that the merge window is now
> open and that this isn't the last part of the conversion, my preference
> would be for this to be re-posted after the merge window.

I agree on the above, also clashiko noted that patch 7 lacks an additional

CONFIG_IP_MULTICAST=y

/P


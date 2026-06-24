Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD3803D7
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334271; cv=none; b=ZH3cr8wIewOjMbm7NjjOjwjbgf7H/1f7kemTgWnhK57RRa5NC5n/LdkDQYj3OpFMguCFGVba+GAsfVInY33dKUgxl8bjBAP+8IQvkPxtfOxTGnhK3sf3qws6L6qlY/3MG4ZVGLVf32tLIBtn4ZFn3HIDfUn2g1kv+p8M+z1zR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334271; c=relaxed/simple;
	bh=SBzi9dkcN5hU5Wcld3vu8eCHzWFSgshh/sAigoFH608=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dop0cwRAIxXHtDvhN3c11y4qQcXS3FFlZQgZegoHG8zyFb+CYJEKMPrmCjspyxZXX50ZFkCVgjH82qWJQGYXRhMPMwa5pLx41KYZ3cOsd6Jl+HNwcZ2qekqM/uP+wrDFgqAI5p+xjXJQpLKAECdfypchyFXhNEklVe5oEVVWWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIOfWYpT; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIOfWYpT"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43f5e285111so1026574fac.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334268; x=1782939068; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WByAAKL6oeilqFf4vAWcc6Tjabs5lo6s/RQ2JISCII=;
        b=qIOfWYpTI0fxXxgWHDk0XgaQEBktAuuZVW5XPeTmOQEWtt0H46pYoNlDZP06Y+nsX7
         pDTUzw7ZLRYesBR8npTMK9T080NHI/xgmZ95G1bEQyfFWDXRejLCXuf8tGRsIvo34xqw
         4SBIvSdTrZ8EKcVcCtTkx8myV0FvyDl+KuBIUGdNFLPaiMri3WLL+qec0cW5WDLu71G/
         uzclEpKLsMGdOKpxODPUq7bzDq81DFZf3ROdkS9vXt8OwLTkOKAM08N7b4XzWd8Fs4th
         Rs0WlPqcSUQjeZE2CEuJNKA1mWFt6V207iHEKn5PXQqKOkctFdglkQvBx/xGC+rIpBd/
         xSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334268; x=1782939068;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WByAAKL6oeilqFf4vAWcc6Tjabs5lo6s/RQ2JISCII=;
        b=nYGymCjFpHCxlIPMkak8G2504VxkSBWq2xP7QBOEbyZzTaNQU3SFk8fIzM5SWWk+YT
         Zvlh/cJMKEtCcVdmmGBG2rLBFshWeoFtMMUD8haiIE1hLk5ZZXOxBZXtYCzvHfg6NdyJ
         9ktBCdQQJ+MgyVCt5mwESFk2HMk5GFTHO2iWhKv/px4ZJtukszqhl8tcJVEUVUPVhXem
         gbdTCzR0PcCJ4d6CxZJGckEXMhU9j7iU7lorTKd+KKmO9j2RuOebmIMxOn73MFlGA1Zg
         WkPvo6GjpiBhl3EWisnm+JSZcI2k0P+uKQ7OoC4CksWj03NYdehfsmTnR94/mg+cz0xm
         bJxA==
X-Gm-Message-State: AOJu0YxHE3kioDdGUY9fjxILwa9LUe/iSJERHFrD3ZyFuPUwU1srWtYO
	Sna3XpeVQGz6K/0Y6Ee3JYZ4+hzI4IR0W77sfssASsuvLpmBX/MWQwZV6yKuLg==
X-Gm-Gg: AfdE7clLO6HULJhQDsK1o/hBjfDFoW0yX11kHM6PR/Dipp7E+eC6NYi83e96cee107q
	ZoTWbMJRNXmEHsWOpIij0eUukla9ppmMISY8bpCkkPPGMs5ZNpwVrozbt6LrQDUlaNBJls/qwqg
	h8fFaQKUJMhioVkxZSnfa/6/yFvA8Z7yQma6P1uKqJtoI+pcJw14Md6PY37PK7iq2pGNNDZ/hSW
	DjxPCenpSotMAh2capIdzeyYSwfItRf0g3P16PTzKgkerFlywgrUvNH81/YbbfZnUpMTmvItBN9
	jywiFap2TRSfFuXzlSr6c7F63DsYpgxlXeewvpOtP5vOm5eCdP2r9nsgcMkcZLwVUjbHelMpcA5
	g2etoMZ7y9b5juELIoBhIyc37K/Duo/0iLbJiC6kIIUpSgVBk0AoRc2vqz/AnUZhchkf6Cuwjs8
	a8ixlgJ7knGY+xE4f3MCKgJXN+G+R+yTFbpyUplrXHJEZ0X6dCBsKbd8lNRUAFD4PPswDOLl2TO
	jLVbQ==
X-Received: by 2002:a05:6871:553:b0:423:c79:6a2a with SMTP id 586e51a60fabf-447324e1b09mr15338356fac.26.1782334267579;
        Wed, 24 Jun 2026 13:51:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0eb8adsm10937459fac.18.2026.06.24.13.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 13:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 13:51:05 -0700
Message-Id: <DJHKRM5FGZUU.1UF7CLMVRGYJF@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: add bpf_icmp_send kfunc
X-Mailer: aerc
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-2-mahe.tardy@gmail.com>
 <20260624191927.BE72B1F000E9@smtp.kernel.org>
In-Reply-To: <20260624191927.BE72B1F000E9@smtp.kernel.org>

On Wed Jun 24, 2026 at 12:19 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Missing `skb_valid_dst()` check for IPv6 allows type confusion w=
ith metadata dst entries, leading to an out-of-bounds read and kernel crash=
.
> --
>
> commit a59a53956c9b8f69a9dfa47bc54cc9fbcd9759ec
> Author: Mahe Tardy <mahe.tardy@gmail.com>
>
> bpf: add bpf_icmp_send kfunc
>
> This commit introduces a new bpf_icmp_send kfunc to allow BPF programs to
> generate ICMP error messages. It clones the original skb and invokes the
> underlying IPv4 or IPv6 ICMP send routines.
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 2e96b4b847ce1..f3aa494ed1053 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>
> [ ... ]
>
>> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int =
code)
>> +{
>> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
>> +	struct sk_buff *nskb;
>> +	struct sock *sk;
>
> [ ... ]
>
>> +	switch (skb->protocol) {
>> +#if IS_ENABLED(CONFIG_INET)
>> +	case htons(ETH_P_IP): {
>> +		if (type !=3D ICMP_DEST_UNREACH)
>> +			return -EOPNOTSUPP;
>> +		if (code < 0 || code > NR_ICMP_UNREACH ||
>> +		    code =3D=3D ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
>> +			return -EINVAL;
>> +
>> +		/* icmp_send requires a rtable; test-run synthetic skbs lack one. */
>> +		if (!skb_valid_dst(skb))
>> +			return -ENETUNREACH;
>> +
>> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
>
> [ ... ]
>
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	case htons(ETH_P_IPV6):
>> +		if (type !=3D ICMPV6_DEST_UNREACH)
>> +			return -EOPNOTSUPP;
>> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
>> +			return -EINVAL;
>> +
>
> [Severity: High]
> Should there be a check for skb_valid_dst(skb) here before cloning and
> sending the IPv6 ICMP message?
>
> It looks like the IPv4 branch validates the dst to prevent routing table
> lookups on synthetic or metadata-dst packets, but the IPv6 branch does no=
t.
>
> If an IPv6 packet with a metadata_dst (e.g., from LWT or a tunnel) is
> passed to bpf_icmp_send(), could icmpv6_send() process the invalid dst an=
d
> cast it to a struct rt6_info in icmp6_dev()? Dereferencing rt6->rt6i_idev
> might then read out of bounds from the metadata_dst struct and cause a
> kernel crash.

Sounds like a real issue.

Mahe,
when you respin please cc netdev.
We need an ack from networking maintainers.

pw-bot: cr

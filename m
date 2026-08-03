Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BD2E7374
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721589; cv=none; b=f/Oea9cBYM2cM0sLzgT11mnT/Za4bO0JhrttBJIMw+pVuP3XxPpT2F7j5SnKVVBkGLfD6q64tL6QvP+LgsCB6p65zewTDxQL9rofLkGSsTuho5lkGMT2aAFr4DcAX2vmt3LJUjp14h7vDuTCwm+Z+jiYcNAFY/XI41wtAuyk3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721589; c=relaxed/simple;
	bh=1jlWWIcmbOWWWFCr9ip0Pg4XNwbRnANeY4QcpjelTGM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PET7pn5Q4ZdzNuMDssnIu+UPxYadu6Ax8/OPB0GOGF5POFqDLMIGJH2PpTu06oQcVIpjbo48zNTVKWL+9rKUyKXIS/GDCqBmb2TgXpxLqcbJKHLnIWg6c0h+gzd1G9v9qj04Qw3fGRJSXYuGBHO53UIBPKZqy+KKwTvIwGwdPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HalhXgtg; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HalhXgtg"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so1277435f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 18:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785721585; x=1786326385; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vZFaJC56wzmLRHoaME7uR/uEBiTO3ECIXTOB5Z9VqnY=;
        b=HalhXgtggmcKEQvwhUFp9zXo6I36M42d5qwH2EL+S99VVAgipicIQs31xdewEGYt03
         +8OCN3T6BgDDaxF74D9gZqmbHT83YEj0RZdxTyvB/CUKKMrDOqzqKIvA5UNOger4PCth
         IyHrNNqB7tEoFM2O9eMbURQCowBFxc/GeaRBkznpBHoQoE3aOdRTMrWcq9bvZ+mn+Glz
         MfAMWYIzMMy4DWg6lknu3adFvaowZupwh1Z1NjWMx6tuoIGZIY0/fcb2VD9EkY/X57gG
         Rzj7tHIfag3MRRWihwwZde0mDPjqgy62Ad165WjcsEjs9TVbPaOMaHMP69GiHeM6nvqK
         BQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785721585; x=1786326385;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZFaJC56wzmLRHoaME7uR/uEBiTO3ECIXTOB5Z9VqnY=;
        b=hssGeAhotA0OpcU0PUgNc+HnO+Rkdg91hvwHZJhqkuivncyiXBcr/2d51yESqSnYY6
         mAGuzFMTdZg8uXU1pIo4FiqF2yEfPz8208DusQu+I1oSitFNT/m7km+TDXgwNLavvnpo
         qgc2clW3WVdIMl6yrFfo0sxLjGl5PxCm5VYhXIyq7vA05iFgCe1yzrfyiO1GqiVtsQcN
         IK7IuXet5Yaml0xcvtQip7J0xNLHIBVlay6Oz1f2mSAMC0z0BaAAk/RVWwjmKVctPW2K
         eK8epIeP5aLeatwCgv+1YlDJSeL5txMofnvXmjGEMf+HAM4D3jXz8b84FtXgFn1C0d24
         ce0w==
X-Gm-Message-State: AOJu0Ywwhg28GmNFhcQVH01dSfa3BRUEKJ38OcoF/Is0LrLR5KGs0Te9
	/xh6OwlbuNa9nthdi0tBnIIhX+QDVMjn1yecrnS4kFA7etb8SgH4K9Mm
X-Gm-Gg: AR+sD115Yvkwh2HEG5HAV0egvKnR07OOsqdoqfZvoIyWMr78TnULCIN0lfBAdV8tpXP
	ed9EpMFPkjnDwxVUJmqqc16VUPD2rzJsOODfAktpgPmLUD8JHNADXkW16F9eByJ9aqof3oWgwoN
	WteKSl04f+fY+rTWgKRnSANbkN5iFDYOuGp9EEwY9uzLzbk14yjs4facdFxuhXi0Xv7RaAODi13
	s26e7n+vmiuiU40HZaWq8Jby8Hn8cRFpe9pVyI+xg85a+pCty6/M3GayehSZCmXit2LirQ120fZ
	vZUeIqm0O7TsEdKNV49LB5OK4BlUJiqQiCDNWvDuXe+5LhpYGz1knH0hVinDSeIr2MhK7gZrabO
	sZkTU/+yHH+gD0yHfOOQdq7WZx8ICj+CM16GNHo/mm2fGxNpLNNkp5DYj5InRuD1sYzAcCGPsbX
	yh54dhgLr5nToVbjkc5jMxiJgafJ0Yolo1lA32Wj26oZk73T01z8dgIZa4HaK2pNDYjjqvArHFz
	l2qQfviEvaMQpW5/EMBH9E2rnWvU9CkxYea2LqI9XvUZF1R7hVqxIHoacAaZRTjGE6looJDNeva
	6/kKhNOuPh90oL2l+O3eNEAoi+M=
X-Received: by 2002:adf:eac3:0:b0:47d:dfc6:b28b with SMTP id ffacd0b85a97d-47fd72e1887mr16054070f8f.30.1785721585395;
        Sun, 02 Aug 2026 18:46:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1abfsm27302753f8f.37.2026.08.02.18.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 03:46:22 +0200
Message-Id: <DKEXGY371CL4.1ALKCI5DILNFR@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Shivaji Kant"
 <shivajikant@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow IP_TRANSPARENT and
 IPV6_TRANSPARENT in bpf_{set,get}sockopt()
X-Mailer: aerc 0.21.0
References: <20260801051307.478469-1-shivajikant@google.com>
 <20260801053607.71C201F00AC4@smtp.kernel.org>
In-Reply-To: <20260801053607.71C201F00AC4@smtp.kernel.org>

On Sat Aug 1, 2026 at 7:36 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] bpf_setsockopt() bypasses MPTCP subflow synchronization for IP=
_TRANSPARENT and IPV6_TRANSPARENT.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/2] bpf: Allow IP_TRANSPARENT and IPV6=
_TRANSPARENT in bpf_{set,get}sockopt() ---
> commit c5ad31eb12f337883443730bb1839d63112c725e
> Author: Shivaji Kant <shivajikant@google.com>
>
> bpf: Allow IP_TRANSPARENT and IPV6_TRANSPARENT in bpf_{set,get}sockopt()
>
> This commit allows IP_TRANSPARENT and IPV6_TRANSPARENT socket options to =
be
> used with bpf_setsockopt() and bpf_getsockopt().
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index c21c1daecf9d1..04a9f9d8d07b4 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5645,6 +5645,7 @@ static int sol_ip_sockopt(struct sock *sk, int opt=
name,
>>
>>  	switch (optname) {
>>  	case IP_TOS:
>> +	case IP_TRANSPARENT:
>>  		if (*optlen !=3D sizeof(int))
>>  			return -EINVAL;
>>  		break;
>
> [Severity: Medium]
> Does bypassing the protocol-specific sk->sk_prot->setsockopt() handler he=
re
> break MPTCP subflow synchronization?
>
> Since sol_ip_sockopt() calls do_ip_setsockopt(sk) directly, it appears th=
at
> IP_TRANSPARENT settings applied via bpf_setsockopt() will not be synchron=
ized
> to existing MPTCP subflows. Could this cause the underlying subflows to l=
ack
> the transparent attribute after they are instantiated?
>
> [ ... ]
>
>> @@ -5671,6 +5672,7 @@ static int sol_ipv6_sockopt(struct sock *sk, int o=
ptname,
>>  	switch (optname) {
>>  	case IPV6_TCLASS:
>>  	case IPV6_AUTOFLOWLABEL:
>> +	case IPV6_TRANSPARENT:
>>  		if (*optlen !=3D sizeof(int))
>>  			return -EINVAL;
>>  		break;
>
> [Severity: Medium]
> Will this introduce the same synchronization issue for IPV6_TRANSPARENT o=
n IPv6
> MPTCP sockets?

For now I applied the current set. This does seem to be a real concern, but=
 it
seems other options have similar problem, so likely requires more thought.

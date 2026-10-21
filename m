Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620247;
	b=METeyvttjlMOE27x3+ObeLSWOCtdahs4lN3Jf8hmSL+lKjTrjuohOJn/VEToGooHen1W
	 UhVwBFc9omCQSsFxb79plFqgrIiRFs2BkfcxMu6SQ24MPgnopmO1ajDgDNZs0vld0k1Sr
	 oY5fc9LxOfdfXQLeMvAGl+hCQW9pj41QET1ORR508xlglAT4fL5Aq4R1X5rqTNfElmAQg
	 A61scSmju2ZAa7oe/31Nipba0uFYIKInD7l0EMarEeFYR6oDWPdZwiPMHPdDaaZqIOHky
	 OF/RRypxlIxjnbWQkVNaVPqI5gvxV4ve3cYcEAjz18Ht1xmQaPWzn8C61cafU4Kbjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=lG5s4Mw3QlF02WaVqxKlut5zcHWhED5dwlHSwNS05WM=;
	b=fz1kyYOAb/xFx+R/lyeJMCd+jisjwHmKiTcqBD0fV9907i8B96hcOKDApbI2Qk2nTpxF
	 U/8kP4XT/tA+nJQ8rYOPfzA6V7+Ksjbr9MR1B2hixrt42mPgoQQBqhMoHmxqMJHm/u+mD
	 /MmZ4EpZA/oQpCvwE1OS1Zgx55A4oFgl7SaAkidwy2RHDT1bcb4GeW51x28Dziyx67FML
	 Bgja4mKHz0LvFgVrsotsNSa2xMAB0VhVpeNpOmVI7D9Tduw9QSBEjTMOn7nvEuw2P9Bmb
	 F7OE4dSWw2yrI4WBceyoPNGGuKmuUDAzcs5hQ/b2Sl1INdfS4C+aPgooORR6jh1bAaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="U/VM8qeJ";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB3606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3AB3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U/VM8qeJ
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd76b1361dso8410535ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620246; x=1793225046; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lG5s4Mw3QlF02WaVqxKlut5zcHWhED5dwlHSwNS05WM=;
        b=U/VM8qeJFsFQB/Tf2sRDCj2FteWlYuHoaLGK8sGh6CW6BWzt3KQ/AaBqLnq45XOEMx
         CmSWWqriULFtitXY+tKjJ+9sv7eEQweX7ii5zW330nAQ5LdZNCVqg9U/rPus85ctameS
         1b9mBBsE+JzixQ0F49aC2uBAljszdmIKmZQrDTjsNReyBleoEOzHLk2ucmn6c27uZYCz
         6ZMgDkE+pFH+dckVBVV6uXHPVaRFWVvT2wKHOWOILH8Fu9GvLa+4s+uulbqy5mIeAC7E
         OnndhkOfw0IXUmxnQr2ZZIpe1TrblQMMd2+QLsVa2sA1Z1D0Xs4oscpv6Psf7IUBGJHY
         9iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620246; x=1793225046;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5s4Mw3QlF02WaVqxKlut5zcHWhED5dwlHSwNS05WM=;
        b=mDaAekTD7XTICnqldheojrai+h1MzQ42TQR9w6mtGkY14/jNXX4LmXTL+LdOAOadun
         pY9D7rfndEgJvaSYcBb1cEpeHewN4GyNBID0mLHsQOdix0oBULcXUvd9btSmMoEAo5UM
         2rlxuH+LlU4t04DRcimUFE9GLB4gbPKKnMqOItxyNCP+uIH/hMbMehXMyivnpGQoTEse
         S1bouUUlOSnUHgWO+/56fKvCMeS/MAirzNbQLLIvin7kDpW0AVF7qwQaTi9m8Z01bipn
         8427AR/n7mJcBbWYQbjnGFLwZepFa+AICw3D1TTO3YdjkdSLjfQ0Hdgogj0sayULAsv2
         aqwA==
X-Forwarded-Encrypted: i=1; AKwUvBy17BLV6BDUJUBAD4BWPDHa0qZ2fS7Kyw5lBB18nB49BjfW61Exs753v6lfzsZp9lfbbBI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAo3MS7ZprGtULN8soV/seiiXSPn3qk8rf2oQgkNNTHUu8VQZS
	/k3DSlpk/c6DURLWoaXMxdeuOpF0qPmY+Fl6EdL4urrV9bpfKQzP8okO
X-Gm-Gg: AYBFou1v760k3VwEiiXJ2aPufv2Zaew7GDwAI3MA0tXxSz1GHnxuZ7QVzAF8pqCLvdv
	qKWiFX9JL2ECW0MDZgxudB8vH33PDB4HVhv/YqE3HTRDhUV4QDu87xcsqw3mm9AFlQ82rzmHT6b
	N/9BqYun/5LaKTitSl75jpUS2sMt7sN3yvZGYz5sicyW0DeNOccFTZV/WyZfhLHXLpbjifRhOft
	FbXg41n+966Ddzc4yAG3e3wtnNUQshn+e+/h96Ur/W913EtphQXFd0wQfN41ZLWEhv9UGb/H13w
	fpHmXRnHR1U4JnJXRFB94Z2+gQVD9bBVmjeY4rUBnNtBQxUDPx7fyH+FXvcmWsRP/2PIoIPjeo5
	FOO+DFW8tN8JzGsH/uuaBrv6+H0YHyLJTcRBR4qO4dj61PkwskJWUJbbt7XhbzvkkrjmRqg+l3A
	BwAjl4QgV9e8GkjzYiVrG8IDG9szzl47BjzEGDsobw1Nq6qEQY6bvRvOt4MtamZBxBf6XLiYQPl
	w6x0FcRr/K58KFZbxVPxgU0wTeOIcxesJ8Unsq4kjPYiOGfUn1mG+b529BZgj/6IoyiESIkd+hC
	Us7T/fLjwi0jVNEWZ37J+BlFOLJdHdbgIz1tx8TJs+gT+wnWUdhoWfDZ3uCoAu7qfRX437Um83b
	jR0KjfQ==
X-Received: by 2002:a17:903:37ce:b0:2ea:19bc:2fd3 with SMTP id d9443c01a7336-2ea43e24abemr27977835ad.24.1792620245977;
        Wed, 21 Oct 2026 15:04:05 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4557c8sm15852745ad.46.2026.10.21.15.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:04:05 -0700 (PDT)
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
Date: Wed, 21 Oct 2026 22:04:04 +0000
Message-Id: <DMAUUBNDJCOQ.12UWI6DR7LNYU@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use memmove() to load bytes from an skb
 and an xdp_buff
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <ayushmanrout27@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <memxor@gmail.com>, <hawk@kernel.org>, <drosen@google.com>,
 <netdev@vger.kernel.org>, <martin.lau@kernel.org>, <eddyz87@gmail.com>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261021103957.17532-1-ayushmanrout27@gmail.com>
 <5a586e05ad8d24d79759c1d99d6d58eb661dc6f4a4c8d258e05a4962cfe7e59e@mail.kernel.org>
In-Reply-To: <5a586e05ad8d24d79759c1d99d6d58eb661dc6f4a4c8d258e05a4962cfe7e59e@mail.kernel.org>

On Wed Oct 21, 2026 at 11:04 AM UTC, bot+bpf-ci wrote:
>> bpf: Use memmove() to load bytes from an skb and an xdp_buff
>
> TL;DR: bpf_skb_load_bytes_relative() still uses memcpy() and may corrupt =
data
> when its destination is an overlapping dynptr slice; should it get the sa=
me
> memmove() change, or should the commit message explain why not?
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -1789,7 +1789,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buf=
f *, skb, u32, offset,
>>  	if (unlikely(!ptr))
>>  		goto err_clear;
>>  	if (ptr !=3D to)
>> -		memcpy(to, ptr, len);
>> +		memmove(to, ptr, len);
>>
>>  	return 0;
>>  err_clear:
>
> Should bpf_skb_load_bytes_relative() get the same change?

+1

pw-bot: cr

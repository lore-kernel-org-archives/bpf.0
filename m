Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022803;
	b=hrsyo0M8jOI4XLrX/m/UsOoDRVJcKM92pwdcP9WRtKAQf2JyFXOZeYfrZctF4Pu9O9pO
	 k6cdASQu/6WsLtpCLohUQh4xz1cspuKHScHBOM05P1me4449nByOxT8ax031WOrABQRrX
	 2tE7s6buxVh8kENAfzm3giTMgWVm3SHS2zIhMgVH4/VGYVXaF4Lm9nCzNuEkV5WtrTrLq
	 L28dWgVQnYn1ZLlxLBk6+joaqLODPkcJhAfzBrc5U60SzFvIDZ0CN0UrSHI9+qqtA5Ov0
	 8gJKnotV8hXzRAp4mahmgpMofSjR6yTk3D3eUXvNeAHXbcUbh1EvLhQtEEell7H8tWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=VPnUZ7qlBEFpSnw3H5bmV/UOx3qvhdehIphPx+gyBp8=;
	b=IRBsXeaeI+7oAV49bw4nb52PxhmXCo9BKlbT0QhD4wNcy5vftVXB7bdYl8cO5XUDqO3O
	 Pzu6po4tdH0ybrzleg/YHa4AarQpbCqHEKzgrETOw4BYOCArFVct5sKShPdWbII1717On
	 draPkgu67ppDTYwoj3nqqwiMhL9OMd5o4buZNZWZx1lfz9K6bJ2QTc/nqMmMPaSpTeRhn
	 UluJnytDYhB3Geh0prY5uVxIrGJjF4Czm+t0MFSn7+MiKDLl4tCPKR2mFrm9yAb/ldTXb
	 k6iOv7ifMdV9rf0j8vxqC9syHG9AfB8eodqOBmQc4qjVLTOoP2N0v1vALvk95tM6xnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgLLY2Gw;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F1606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgLLY2Gw
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1086176a91.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022802; x=1794627602; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VPnUZ7qlBEFpSnw3H5bmV/UOx3qvhdehIphPx+gyBp8=;
        b=QgLLY2GwgKWxxhwk2j8gz0t9XiYYolwI818sydy++4d+qwyu83Z0oGlHtgJ6UOR0zS
         tz2I/ty917pQhiGxEayni/M97SLRTlITEniWOTSjvv+vv8STDgAE3T4kbQBMfOWrRt3l
         brlgrKdW73wa+amm4U745l2zhlWlB+k6bKxaENBMcljOigSWYupJif2K1YCxbUd3/xx/
         RAJMRqEcighJmiPu4XcaigKAGWFbZ8j+ovYC7WlrdSze3YPVv/Yet5jF32ATfouCUNxD
         FXl0BT9cXyudm+ZMCXBcGsqVRkCa/sM9Umj6s4hP7Yo/G5rxRaH/VIqDg9KZzRtdzxRb
         QFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022802; x=1794627602;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPnUZ7qlBEFpSnw3H5bmV/UOx3qvhdehIphPx+gyBp8=;
        b=BAsdBw2/CbRpjflGmmYe/WLzFRK1gkMl/VDPb+ZapdrUPTq+zdTyayrxVR0jdZBGLB
         GFI2RT/ag/DtS9oI/uVH/nttwKpdN0YDk4+TxWyTjYLWCRPygRnOWlXUNnZpUxTwk04p
         CvLiVByzznTzsPh+lCbYB2dPo1D+bjaOH/DoavgDhU2vc1I/qkf+38/Zn2XohQ0+Amac
         6guFcnSvoJm6wEsszDJcFW5Dn9EgE/2cMJt2jsPMGzIJtvM/Qh9SILRVY+6GnaN4l3gJ
         tNxjrPsgzaBHbods76XKKcn7WRNZH7bLtWxsflIz0ryKJ5YQ66dsiR3EXrz2NxGBvu74
         9/bw==
X-Forwarded-Encrypted: i=1; AL+hErGzog/fcDw3j24OI9YpocpqmEDSBg1BDoLAHeZJTRvbNEQ/BN0HgE3lbG5B7r/9qVjWz1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UWoQEeQatyizkPHnivUkz96WKyzz7jvYptCEG1pHD2ZunUu6C
	F6g5OC/HfBW5sP1PbbvNonyWzggdY9TAJe0W7ewudbOwfdggZZvW4k4r
X-Gm-Gg: AYBFou0c3+8dxyte5+d0w/R5B2Wi0MAW3qR/tYzY2rqLNlXWQzE6xjtJ4ejIWp1Uf12
	PvtTWpcAIb6PEyDvuVYx5X4G36iv94OvpnXb9opFJuOUu/j5lRY0d6kArQv65tNZNzo76DcOtRB
	wpTgzz5+63pU6QkeMZabU9xM7HmeKLlqwDa51r6O3FEH/U8WFnzzQUAJUXGSCM/rwWR8JeWjS2k
	krCiUfbBIl7L8ulDyDK5LQ3gGi0XaGpZ9iLUkiFJxWYomjAh8n5V5VrVnxgSshtF9cvkzeaDIVM
	HW8CR4IrXSh50DpRqWOmHADW1nIC/CnGQWa7Ss4QtAfHEOv4Y+fHkHLLY8R1fKyknDA3KEl54gq
	YUEyxT6X5jIsAIRaGj75RUcagr/huG27JSQD/Ztdtwn9vzZi4ryrf1x+Q5nCG4AcBmAKYfMgKNj
	mqZBklJbC7Dw8ZUggXlArVdXsmB+JLZrXxc02fJVEW/txg2QnIYAVlyxalM8bxjn7KKROeIgPPR
	oiTFyA2kdEkYBgicdcKxHxUyEjSWQNQD7Y7Asdzp3gEizBETXMNRzI+OhNDB/qU32CMD0E3iK41
	61XOIXw/awRPcKZ+LZ18Dofz4Vw0Zu70kOZsFXw4X+rWGErp3Cb1I1fSi55QchjdQblMShdPwXT
	1Q2848mi/0Anzza5GOs2Jt5tCfrhsq60L0Ake
X-Received: by 2002:a17:90b:2801:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3b0db6e4fd4mr4134730a91.46.1794022802260;
        Fri, 06 Nov 2026 19:40:02 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10583f3f2sm1368968a91.13.2026.11.06.19.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 19:40:01 -0800 (PST)
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
Date: Sat, 07 Nov 2026 03:40:01 +0000
Message-Id: <DMOO099NDMIT.3A6PF31D90IZ2@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf v1 0/4] bpf: Scope callback arguments to their frame
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
 <2785198b-ca41-4cee-9dba-bc0c1e6e8f25@linux.dev>
In-Reply-To: <2785198b-ca41-4cee-9dba-bc0c1e6e8f25@linux.dev>

On Fri Nov 6, 2026 at 11:32 PM UTC, Ihor Solodrai wrote:
> On 11/6/26 4:11 PM, Ihor Solodrai wrote:
>> [...]
>>=20
>> Ihor Solodrai (4):
>>   bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
>>   selftests/bpf: Cover the user ringbuf callback dynptr lifetime
>>   bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
>>   selftests/bpf: Cover callback-frame map key lifetime
>
> Alexei, if this lands first, your pending verifier rewrite will need a
> hunk like the one pasted below. Or the other way around.

Thanks for headsup! I'm struggling to decide whether this is bpf or bpf-nex=
t.
The fixes look good.

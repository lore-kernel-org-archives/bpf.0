Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F235F610
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253518; cv=none; b=PxfRFUs3GUMSL9jIMcg9mC8L3mBD6nY8bN0a9r11b/vEIudPDHbBERUT9auQr2hJAmjQwze/32O800hMCam1hjBUd5DQ2BY/kuAFcj+P3u25pju8fECVC1xrhri5LNuE/Qo5We/WQHdo31By66sCSgD+Xh25mdbp6ftUbqvc24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253518; c=relaxed/simple;
	bh=XRHNaWWABlnH8iQWN/EYIKOiW9FL7OxAiz7167VHFN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=f7hz0ZHrBthZainnJ6kvoNgfWsyLTJWm80WoU8Pk0nT12RKWAxp5cmFLTGhQgeFUDkRUSkCZHzH3BDnS1atTWxqpGeHT/rmZipDzKTbNK8n0a/6CpcOHPv7vO96bQicKKPHprOJDhbQq6DqYQQk5OGklc9PyLX3is5xVqL9ugGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=RL/1P2Ca; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="RL/1P2Ca"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827270d50d4so2069739b3a.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775253515; x=1775858315; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMukvJ2/B5HuRQ8wOl4+M/eHd9Dbd/Ma8y2SHf3n2BM=;
        b=RL/1P2CaMqeiJTC5J6CB1NwZag2Mwf0Hu1x+6ENr17rHKBSeGdzakVATnonuxy7Hjn
         6q7o7XnLerbbLpOU25aCyWSemqMehwIgP7529Z15N42xuw69XI1hih2w8jDEXzCaGU9O
         fAdOif25o9iWJgAdq9jZ9U7vBro89DsyT97l8Zm1f2z4sRy6rqxHeXWpl87+kF45zIyF
         LRBRR3s1f1/+15aENAq5cgofZBzX7CHIqOTkgkaSV2B2k2FOn0MqEmOrMzbjc6j99lq9
         cnhLru/OfMPCAhiRzwaAhJFcWLW0Pmmu+K8cv9t75Orgk5RBtHmOEDBSW99s/I2qdMwK
         xiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253515; x=1775858315;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMukvJ2/B5HuRQ8wOl4+M/eHd9Dbd/Ma8y2SHf3n2BM=;
        b=oJ5/b9dWpdnyn5sm/bhvoGa/LomLEQJ0sKZ4olm1XKnISIRh4zsvs1RR5GPn4sN2DF
         AiN1jisKnLYAVl483oOt+/XW9wZ4QoXypahMGp2zk0veKxgSk7akl4mj9aceldBpkgps
         Y/v0wE6bvC0I9aOcrNG/a07neDTZslPp+P1dlUohNfkZqQnUyQ2RNFsvPGoJ8aw42WCA
         ZYFcxmX1WWbWKMo+Wm+4JDaRR84l/6PxeITGNkAJKRmPhp7Sc1GDqjPtZryxgEczzF4Q
         1CZ/MfBIEp0yePuSy6oYKYdIDx0vhW7mAitOFHb3kucn8kgPcfffoDBSDZXy55d/e77G
         BbQw==
X-Forwarded-Encrypted: i=1; AJvYcCWMEnNAt5aMRyY8vyMBYaqeSDaxbkH+luk1kLrmb2Mzns34mwe1KxaipGLoVqMX1QqP/kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxIbW4USUu43q1u+I1ZqWHlH9ohglLJzP84c+RtNRIiLNz/K4
	vADCBrGl2MqOxzbS52ckKXZ9cexCVtkBbLQS6jk0MJwqDgwobOOJ6KoSoTJrQcV+qcg=
X-Gm-Gg: ATEYQzyV+sG9Jsx5N0vW09MGUCGVx7jMhuUaydvc/qPRmPQfs3N9XKEuL3DtuexKtKt
	rcBQgtzrQY+I/ksVRDaFDO2SD+lkUdfODX81grODNln+WA0wdzF2db0xqqgWCJfxWrX3SwuZhWP
	wg2Pfxr2xCdMv0Ba1KPalLhAbxniGg53jUaDSXTcw35/IX3CySMnAyUpiJLqY5Mc3oODKgoOIMR
	CXAfIynd3MIualPmB4ld6IdzqC1whJX7ENyZPd0Z/onWfje2hUcgemL03rdUxMJoSgQo/+oFUSC
	9dmuDYZWfNJYuwF+IL1XEy656VYmrV4vHeAIy6grd0lmZT64UU6NJXVbkEnhan+JVqcTYJikksP
	hazJsk0S0aKp2h2mwKSMWvpnBxxBgsRm68F7F+X7Ih85XpnjQXpP4pzhAiJRGjFn1TBFk9Ij0uK
	uW6pvabunQyX0qSIpC0w==
X-Received: by 2002:a05:6a00:3011:b0:82c:6f07:2dc4 with SMTP id d2e1a72fcca58-82d0daa006bmr4285277b3a.21.1775253515123;
        Fri, 03 Apr 2026 14:58:35 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b76c0fsm6342771b3a.15.2026.04.03.14.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 14:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 17:58:33 -0400
Message-Id: <DHJUULDO4HLP.23SBEUOEAGN0M@etsalapatis.com>
To: "Barret Rhoden" <brho@google.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>
Cc: "Levi Zim" <i@kxxt.dev>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, "Matt Bobrowski"
 <mattbobrowski@google.com>, "Josh Don" <joshdon@google.com>
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
 <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
 <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>
In-Reply-To: <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>

On Fri Mar 27, 2026 at 4:10 PM EDT, Barret Rhoden wrote:
> On 3/27/26 3:41 PM, Barret Rhoden wrote:
>> are there any tricks with this new SCC stuff to help with verification?
>
> i was able to work around it, at least for now, by taking the guts of=20
> whatever i was calling from within bpf_loop() and making it a global=20
> function, thereby making the loop function easy to verify.
>
> hope i don't run out of stack space or depth...  =3D)
>

Late reply, but while in bpf-next there are still stack space
limitations, the maximum call depth of 8 is now gone as of commit
6c8e1a9eee0.

> please let me know if you have any other tips for bpf_loop().
>
> thanks,
>
> barret


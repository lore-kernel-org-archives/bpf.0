Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060083;
	b=OEt414uCPgoKvNdCwFr8fFXxKP/3HzELjWJE72GKbzJdgV3oc0DnrxnRrR/fUUGj9Hc7
	 Ro8ldFO/9pDAyXu/14LKejgH879uC+wAczz70oz9w+dFiubUVFSYGwLi0emMNpAyZdwkj
	 dKpyDxWqzWkzo2oi6JlsCS6kYP5hMK5sBl+yzLkukKuiDSL5TwbFhIJgwSyBs0xKc3wXX
	 UxejsrqM5eiWil300DyW6CTEU6qmxdAuhFMjGZir65RMk6FNJx1WExUOc1LjdtIIp9BVK
	 c0tWt7zZxoJnPwVKO5LdSk+fw5VIL/mVUsBn5FzdJK+L4cExtV1KYWZVgIGMAd8d/Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=WRalrNmGTT3R9D+tUodjp+JSTViqCVd5CH9naNYdHK8=;
	b=EVcPX8veZ+Egxqmd3bDEcUnm2nZ83l7OZyZhQ62OdWGrp6gHnFsc6uwnYxYyrKQgZYpf
	 qZ7rmS6lkq5MhVJHbygJW3sRADGgpTGOZAVBB+EvFle4jMKLPfWqeqtrUr+CZOwVpYIPu
	 zDo9ZP2FUu9aT0Zhf/QZf84+PyxqfZ/YRaTWdCW6ADRmXWhlvJ5oc+Xdxi8f0EQj37Auu
	 25iW/wW2VQQXM4dexTNK8mVWbQWKQeEjJxZcncefnJMj1c5rmc/tZNetjVnspD6Ddw8E9
	 deaCDprjBzsDHrrK8EAVokvoVBRmMUnp2VMm/wl0bOBcFz5lNrBEIeKO1ASvlQGuBew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2Cby+Yo;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0B606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD0B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2Cby+Yo
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3552547a91.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060083; x=1793664883; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WRalrNmGTT3R9D+tUodjp+JSTViqCVd5CH9naNYdHK8=;
        b=X2Cby+Yo/UW/qkL1ont4YD+E9/oYAlzQPMl62yaI5pfvO6llCIHapKhTv0kn46GVhZ
         OI2dLS55UQhNC3ny1Xg5cu4z2G73172ej1UZZbOkMsfwR7860DkBLllXUWCcaYCqr8A6
         0/pTynG90iGEpSZuLsnnbqdJQRBOw9RkkBcl4Y7dBvfpmuI0LdKfg0Gm2DsjN2CDl2UB
         7S9+Y2FKQqPZ1eIlh+cW1BiFtRbMgHa211497fIdpAyGFU1knwVsbngyv+QanZy0S61N
         ujcS7ScaXn2Q/7OM87gPHENzQvy1em2xQHoe/5kg3M6WpETA+zi1MfBvXOVVNQGnZ+76
         lNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060083; x=1793664883;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRalrNmGTT3R9D+tUodjp+JSTViqCVd5CH9naNYdHK8=;
        b=h1bic1EA6B7T0rU5cWr1fSbtvlMJyPmaGNkMED2Ad3HwcBwgHHpuS9GC9zBSWAGUuS
         y1Itpo78Z770dLcvjAFbAXO3rEi1RSo+uZHF9obJ4XsEmH1b9lbf7wKFL8XuDeax5F4s
         jPo8ZfpggzcMj7sLwWbi45Kxy2lZO4bQxSuo2o1tPNYsDeHfCAseazlm0BctDmaaHSSk
         dqCLhRXs+2YWvDSH+PVXVcUICX352XLQMRvndupFGbM+xWe8KnfOAhM7FDFRnNre1LkD
         riJuToDyV0viAB1t47dlM2cjWfQB0wd02zJjcUAyIkgVySUUq/OWywoAtExnTduClOQC
         UKVw==
X-Forwarded-Encrypted: i=1; AKwUvBxn2CvTCkU7JuA4sUkY/7OfjV57XgpqeQfo3Wr/IoM5MmRJhMYpdybeRX2fV1Ng+19G8BE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpQ+wWh/m+9h2jXQ7nmUt5xq0HGI7Wo9ZRB17Tdi2j71XGRYmE
	b8Zun5vS42WEdo8pUj3nzcUxo6enXepaxOux//tV9mF9dzaoq1UgtxKQ
X-Gm-Gg: AYBFou1DFha0sGDQEgK5gK25rCn3PAnvzJxovDRHWlhWu1IEAop2QPO+gkzoWRdD1tg
	Jc4LhOW1iONLyXMFfDTu5l/9znz1kzet85jGd6dito7UZigXuUAsMnwlSFqMjDoQl45hL4e+C6b
	GC4IFdYOj7h5+5KNAWNd2ffI14TugHCN1DJPtR2DzXAIrrYrt6WDm/Y/w6K088zx6eQBGx7okI2
	eJvWwZfgjUOvFIKd+fN+9IXs6GQzqJm01IBffGgFuPBCuGCaWfvG0rYhuV33fN8Mq0SFpTJ6gQd
	vaDbnMFPnccarygR9TvGoR/dMNfKtBUvn0ANkz2lKmFi5VGZUNEww9X3QgV6WvgeqvL02m8gkaK
	2FcgtHBoLqqhKUGm8coyMXSCPSsqEnI/ZSV7lCDeIMzyTUuclWsgS6vb7vAAr1rCk1wC9ltJ5Zn
	kipBxLE33avosjZjSBnTpLtM9bbvfA3vOmx+aX0021+ecyZ3ABL1dY8mRPA5u3Fm273kvu6k+5B
	MYGQA0QCoqAavODP+FwFrclOZ0A3Qb5JvTKHArIhOB0TWM1w1MQOfgJ8G5qdW356TD55+OHzIk/
	Vw0nFA+IvgylLZRM4nF0DG/aEK7CKk8mgMMeHAzAvAdIgsJt6fiQls/Fan7Z
X-Received: by 2002:a17:90b:3d8a:b0:3ab:9c73:12a with SMTP id 98e67ed59e1d1-3ade9b2f678mr6725365a91.2.1793060082601;
        Mon, 26 Oct 2026 17:14:42 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40635db8sm1177220a91.10.2026.10.26.17.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 17:14:41 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 00:14:41 +0000
Message-Id: <DMF6R1UZUOG2.GSKI6FS2KJ1D@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <fba239f1-febc-4af5-8033-a893f8265191@linux.dev>
 <DMF6AVOBX25C.28Z0NJS6CEB3J@gmail.com>
 <f9aee9b2-0010-44b2-afb4-0be3958b332c@linux.dev>
In-Reply-To: <f9aee9b2-0010-44b2-afb4-0be3958b332c@linux.dev>

On Tue Oct 27, 2026 at 12:04 AM UTC, Ihor Solodrai wrote:
> On 2026-10-26 4:53 p.m., Alexei Starovoitov wrote:
>> On Mon Oct 26, 2026 at 4:57 PM UTC, Ihor Solodrai wrote:
>>> On 2026-10-25 7:58 p.m., Alexei Starovoitov wrote:
>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>
>>>> The goal of this series is to load Rust programs as rustc and LLVM com=
pile
>>>> them. These programs keep data, heap and address-taken locals in arena=
.
>>>> They use trait objects, recursion, unwinding, and loops that have no k=
nown
>>>> bound. The test programs are in https://github.com/4ast/rust-bpf
>>>>
>>>> The series has three parts:
>>>>
>>>>     patches  1-15   Fixes and a revert. They do not depend on the othe=
r
>>>>                     parts.
>>>>     patches 16-31   A stack in arena.
>>>>     patches 32-81   A verifier that joins states.
>>>
>>> Hi Alexei,
>>>
>>> Just FYI bpf-ci-bot AI review workflow is limited to 50 patches per ser=
ies.
>>>
>>> The limit was set as a guardrail for commit selection logic (to not
>>> accidentally run review for 10k commits). I chose 50 because usually
>>> we ask people to break up long series into smaller reviewable pieces,
>>> and pre-singulariy >10 patches series would already raise questions.
>>>
>>> Since the approach to patch review on bpf list has obviously changed
>>> recently, what would you suggest as a new limit?
>>=20
>> I didn't know that there is such limit. I'm not sure there is a good lim=
it.
>> Maybe whitelist it by known developers with commits?
>
> The purpose of the limit is to guard against unintentional blow up of
> compute and token cost. It's not infinite.
> Are there plans for 10k-patch series?

yes. they already exist.

> I'm sure we can come up with a reasonable limit for a "reviewable"
> series.

There are not reviewable by current infra.


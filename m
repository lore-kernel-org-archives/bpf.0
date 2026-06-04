Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD226ED40
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615259; cv=pass; b=g7I7yT21yV9QG5IY6LX1DWx5vyB8lKHbI8RtENZhiZOx1ZN6acYAEx7lIzGu1dm3DP/ICdBLjVVUk/ypHzqebeIzMJQY4fpa8NOhIZxw67AZzfkmsQs2451njZoQfxdWsuDGUh3L2BnIAq1AW/I8R0vM1Ynw6wlyjs/T0/mof7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615259; c=relaxed/simple;
	bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfSW5j2GRcUkHsJ1Jr4dPPWWCvQKFmqn4Ex81aXvDVRcdnK1hAUKTAoBKXSSKoF+c9VtJE433K24ff5YHJEu1lQXV4mkb9XCf0xYHf2iVM5WmzDs1TdfPx9n2PqwuJW4bpuTUH9HQFx3UbTSZBBilldGBJyGGN/JsouJcKpyM0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SBh7qegl; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SBh7qegl"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654DuTGV1033470
	for <bpf@vger.kernel.org>; Thu, 4 Jun 2026 16:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=; b=SBh7qeglgGEf
	r3ONU/1vr/H0gJZDF+E8Zn3Jn0GdhYuVoZDSXDfbAGx8p7FXSmVrWDpg+XZA6lgI
	f+Vu8eerayshDWcHy4T5n3/9zv0i49DqV6HrltqvRziWlwltKKuQlAZR4KnUN7Jr
	FoFrtra60G0de593WbU4bT3tOlEj1w2qObiIb14Ww//p6HH4w0P6/N1NYLK92jox
	k1gO4GxHJ0kWUOhDXQMP7PSQXijBpiCmwKcUfFcdlmyRtGs6xO8r/K+ed5irjEk9
	5/GnorUn/zal7AoS2zbKhTG8MbmAA3cQs7FMmjK7csKBvlnEQkjtMi8aAyMSORTd
	ANWQvS6DTQ==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej6qcftej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:20:57 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-68d232dc704so1542194a12.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780615256; cv=none;
        d=google.com; s=arc-20240605;
        b=HXO+GXhH4J79gfyrhCI3acuaSZqLEJTDuUUaUepdLZLqUyLhvtFvOqonOoYcivaNKG
         r+Mr8tr8WAwZ8TGq9hEg02L+rOC8/4hj1MqPwrnDPuc5j6Dnpt/EJpx3kVY9tNxAxInt
         V3MdEsJht8w8oKizhmHqSMJzervbghyy7w6ROnqT9onphOHVXI0vDryTnDATdHicr9EC
         18evpIxfk1/jyV4fbklj1i9l3zAavJrfUaHYewcdP94yAaMSTM7tTQZprHGeiaBm1Ssa
         xLRg16vdhdoMaN9jzZuCk4vzycJ71uCqCJpHum7/mhjznJSQYzALRbeo1gMKADPK2Csp
         yMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=;
        fh=s4+2UqtlVCmvN9J+BfQQdIuMOB576QNA/uLSdFKyb2o=;
        b=F48/TUDja2cXeQCt4I82zkbv61UV7hiBdA37oto3nGApMwRUKUUizblpxiuggPFWG+
         mHWcw3mjEs0QmrOrgN+xbk9LuGHbvMw/crWqGlGSZUCk4+I9ZEsuro3AfR9Swrz28ZZx
         qVvYaob6lrsKWRCyySV4iFL7XbCDt3PQ+6sxv2P7NsF0jsoyFmnwpMnHYPeiVW0DirqK
         idbkjsbV3G6zT6FdT03HhZ2s/Eh4U7W/IdlCtnzHo0qn9y3a9L0hx7rkt9hm2vKUMcmK
         ToVPtsc3b0VyludBuKpJ7PAkifvyFtXXYhX82DAVCH1cIbYSdZmL4yt8fc3lwvDaA9/Y
         zE4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615256; x=1781220056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=;
        b=iJacs+C4eP4oFrJmtibU3//55NvMyW8L5Bqd1mhqOFeHzdKSQqIjG4CUcqv/sx9dGJ
         rf9IzieB1+Vz0k6qsm030pfBVoFGQBANqsREZ6pJZG5Y/WRJxupzhuzOSozaYmA1wCvf
         hWtRfOR0ZOCEc1fD4kHZKFk1Lg027s5C2wwlKGwahrIyw9OW4YorIRJhjpVAqfEoGAeQ
         f/Oq5i+G/No00b7GPkXYhYCZZwLFL9zzvtGw+coR4et+4ww4Z2TD+ByQgRcIrllQ7w6e
         bHr4D5v7mE84rVjcjWFe7p15roNN2LivJLSEMSsDwPEnJ6eWR9oR4lqj90ADhgJ+ZjWz
         X8hg==
X-Forwarded-Encrypted: i=1; AFNElJ/Bfv5pBFOKltPfUuDWLFAMyEYbkxK9Sld2pelCd9aQo+hbe0VwOF4B/oHxVkzrZJcBgzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7GZT8+/0OTBpzq2p8FVzFziEE0ayskxfdrlNi7ZAoCJvr+JI
	KZxNvqVFRCM8sVWypwLjBUQ+RcvKFCNYrBoLspKgEWuifT9ZHCENsjNReY85j10aDs1Xx7raups
	qPY5HEzPUNg97PogXgwmUZy1MeF0AkiN3uypgkxugVJwmqJAK9lK3kKHnQ0xGhuQ2s0cyVBcIZ/
	fZI3XNaenqWFtLg/CtQQUhm5kn3Xk=
X-Gm-Gg: Acq92OEvaZ6IAt0oc0T5feEWR0mJQn/jv95ZBBcR66aHf+f/0JN71X/OweuoyVyQraV
	Cix+j9UPCsFyDibhG6iavu0399lOx8BcQzl28yXrG/bdf0OnjAJP+OvxBuNcn2YSi8yadkPrWjP
	iX4WAoEqblguWpoeWXCP8BJm48yDLi258EtsNvmLQovemqsipopZNv3RlLV1XzbXzRcWAC2/9YD
	tAVFf8C8MViVfiY
X-Received: by 2002:a05:6402:26d4:b0:689:9d82:bb60 with SMTP id 4fb4d7f45d1cf-68fa4c0f174mr512681a12.6.1780615255939;
        Thu, 04 Jun 2026 16:20:55 -0700 (PDT)
X-Received: by 2002:a05:6402:26d4:b0:689:9d82:bb60 with SMTP id
 4fb4d7f45d1cf-68fa4c0f174mr512671a12.6.1780615255671; Thu, 04 Jun 2026
 16:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-1-ameryhung@gmail.com> <CAP01T75pWAgXi4CRR4Ca75grBFwXBKHERdH94KVxW8hDQ3uqog@mail.gmail.com>
In-Reply-To: <CAP01T75pWAgXi4CRR4Ca75grBFwXBKHERdH94KVxW8hDQ3uqog@mail.gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Thu, 4 Jun 2026 16:20:43 -0700
X-Gm-Features: AVVi8Ce0WFW9gMUWNHasTlWWw6IfUPQ4uso6eoFelhGkfIql_5gHa5D0A8xF8uc
Message-ID: <CAP17u3OUn6-tvV6jLEjknCJN4MNjD4JJxxNeXu57FOpPuuaKvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Object relationship refactor followup
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@kernel.org, mykyta.yatsenko5@gmail.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: F0RLC1lySJ1D0Q0C48n2D6SZWgDeUUHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIyOSBTYWx0ZWRfXwbArbcMinghj
 YBSGvrEnUcqsiykrx4EoQTANEWA0Wkk+gl9VB9eVrB1im/ujZhEY5wnezyLG1GLUAYqqYwHh9uS
 bwcsi5vMlZnY7Ds2hfuZLeODdYZrq2s0ipsfKb4RvFXzg67gNH8d6W6Pz8ePQW/OsYHjD9rUsvx
 1ihJiqcwnaxe3SIwrdTmHs8K07Z5OprbNRPa5a9wuTdkOy9Sq6qHXbL32j2LWgREXv2QPLeBBxL
 l2nF59wXppXhkhBNtMzqBHfMArJaeiezw3drJG6Qt9hPF90e7rh1ndLrnU9+OXQStbpc89gcZNP
 YmIYw0i3+hLwSoNzNUz8hFDyBlySWluwlw88IjwCMlLW86JgNoJFtvmIg6oJwQ6HJEFvSI1vZJ3
 G6HcbSystIc3/zpZoFacxoayR3tI1hsUx1q35t+fqVXVCzgk7jn2kmbfGZb0NtF1OGeBngPau1W
 gTE9sGilB5hhqvQnxtQ==
X-Authority-Analysis: v=2.4 cv=IbC3n2qa c=1 sm=1 tr=0 ts=6a220859 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=BgfoZ7BIgC5YM88rzDIA:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22
X-Proofpoint-ORIG-GUID: F0RLC1lySJ1D0Q0C48n2D6SZWgDeUUHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01

On Thu, Jun 4, 2026 at 3:15=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Fri, 5 Jun 2026 at 00:09, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > Hi,
> >
> > The main patchset refactoring object relationship tracking in the
> > verifier has landed and this is a followup that addresses the remaining
> > feedback in v6 [0].
> >
> > [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmai=
l.com/
> >
> >
>
> bpf-next makes sense, but Fixes: tag looks missing?

I will add fix tags to both patch 1 and 2 and respin.

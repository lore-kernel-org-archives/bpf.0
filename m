Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087399;
	b=4t4a0Yb7UbgzS/UAgLi6NGJGeU1icD9uheeejujjyd0nWoOSi0MGrG1lVAtzXi81PQWN
	 YftYlL/doBBdq4+Qu7eqh38TL4o/9hk8rGnps8TDC96Mr87uHfJnAstTal/HxQw4tJlSA
	 kQcRlQTzcNEw0EgP7ZR4Tf6vUP2B3iQE/jZ6rlGfKyzITsofk9doy3B9EIC0MaHZMygN0
	 ZgjaoJjHEgw1BIg3JS8eg2wBv7ExExwxv3avtJkkFVQqQwRbg+5pzmVdJHGKHChIAJ3Zr
	 zgpfGaqYfgV0FgGqcVg3Yki71t86haQnXGYvRhd833pzWEKgfYgun9tmBErhoGyQdrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
	b=BO289QIlBK2R7VKJ33Fl0s2cG0h/mopnfvoW0l2LFFsWOOQsEp5e0Fs9q45BHVw96DuT
	 wNFKlsVjemZLLYiroSYehVCZe8B6l7s21S7oewq2oeBQ2XtWDKWUoRbvO5uVtbK3jBPnk
	 Xbgv9qqwSrbEJTte3lSlKDDY3Iw5zY+x8IK7aJUr6J9CrJQUKIifkWxg9321zvO1sxGiW
	 hGUJd6rSUmw2gF32MZaEuc1RvvWm2zG6cyIduIGnCZnomVgmLAngDujTAQVxPd2h1gqKu
	 TLOraMPp30EROSHsziSQgZw2LdzhOGYxEV1vxUDIidS81iyFIOuMcTfWiAZIC2X7yaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=l37DDBeX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82F606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B82F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=l37DDBeX
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac847f9d78so170559a91.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795087399; cv=none;
        d=google.com; s=arc-20260327;
        b=PB9R1MpYzPvgXZ5sgETT92MWfg9devy3SwK5O5r7W6vrSkbVLwQeaf097BtcYQ2/ZO
         eaKES27gAkTSPd98bXUatjmDIAVp29n/KZhdZ6PlCktDzZudmdNWc901It+ZfNg+tSlW
         JdqKWS7i8sUIQcBqsJ9Cp3pxOpvFBd4xbpEglD1UlzxtVztE6s20sV7oaoyNObeI/IWh
         mtu5zhpZopbHFV68HfWE8G2B/WpqzcmsT2idvhNiGcicLMaljWKj+EoS6odpje/WPiKP
         QfUrDgruwnbeLAKaclcYP4VchWXThvkOuxtVGdackYU78yU0lCdHVE1AiuqbpojF8ctj
         qfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
        fh=SP9MQuLGLKwYAkAMPXZZy/g7jD0jDxqmFswXJ38n1oQ=;
        b=RcXgeoUk5mqgEWFpgp/ET9Lp/yteEGNA7HKyHe2u57pP6zGzpIw4W61qhbh3M6nG5k
         n/rnHcPD2iG2Jtl8alvV9nntagAUZ27uqpJcoV+Enpv1Lst2BnwEJvBbf/FrqD3qSoBA
         dAn49fu9MUjPSFcvz7pRLTqMABAAnITLmH4jmAaVNDvRtAuRlEIMLKb7YiDB0E+pR35E
         D6lPxisJFt+5x4l1OISmodKv8qFXDit5kRSsuJ/BeM84Xf1CurQzESbeKOHpUCAD27g+
         v9+10XRRAXbeWtD3dEnPFbOIagxV5cCU+1157H/UJZL0WHCZqv1vI1n4sSrou+o8aFm8
         KcPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795087399; x=1795692199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
        b=l37DDBeX6BLHDrkTWQMXuxzojs056iL2RxA5zvzDgwUEMIqnfYNY0TRkfHchtXJmeO
         VKpH3cgTQ58pMyY6pvZ5HqOZi9xa696QKQviWaPGo2N9/9aY2AHUwchwBP8gQwsGsuC9
         CYdg8iPsIs3G2A0YH5TjC480+PYSZbTcwf/VJVB+mGylkKGmvjy8QMbHRzfMexzoeP5i
         D1LYI3p/14q06ICAkRJQsOltmONqwAiyQ9QiRhHvwxzwC4nx9qmrDRGr/WB0F+ge3OMt
         fOeQuFmNfsPprwWcClxJfLxoOwq17T/luu4kb/19RkleCSw2F6AA6zuYj3QEZsgBdUy5
         VIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087399; x=1795692199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
        b=GXI0X7FWLDJ/+rdBehsl47nijDSWzz9RmFHyP08yIL8W9TDbZjt0wgNIAc03BwHUgq
         EkTKjaatW5ZPvfwN7g/E0XX5yI9YaS7hzt0kH7BjGkQ5Wshg5SVgBDqQB0YQL5Hsepsc
         JWRJBYUXC/rrpGe/pMB4QC4QR53aNZZyxaTgWo3Z/D1yn5CwFSdmaDjEHdsqcFuv5eA2
         bQbCFi6spV5VC4EcRuMa0jWRl0Q+q/36dBJZh16jHEvrku7kQkFWVMaruo99oGARRwyr
         JlUMxAOWlaSu+B57HMhp8rw9fBfpGqoM7GhL/XHaZior6PUZiqU6uWoHlGcuI7oynr5I
         6p5w==
X-Gm-Message-State: APuU4Z/rAZN+unPg5QkEwNaKj9D2Y+v4cVxCG8toE/nlJlA8A2TM4mus
	gwSZ1y5Sdt6/GNUD1MPBJNsfdhyscxOaOKnQQCICBvhfOKOOOFcSMQnvKb3d+L/FgBZvOeqmr6y
	G+vOJTPsbIJfrpll7KVsRF4TS8oV7lYUUkE4PDsTt0Q==
X-Gm-Gg: AZFdTZcgBsES7OspTvQt8KTfIpfRLOaDiI6ubYblqDcRdqQTHYahdQnpnkE0KD0K025
	qotuvcdufIaIA6WFkMwaynda9FvDUb1zU8FthWIxjAbg+mm1XE/lzeQKIVNqIwxsZv3suyvuLxJ
	WwD/ETZGQIsBRnZg1XU8u6jBBgjLdiShgtzYaw1jHP0qjEfJNbelqsyNVGHvIsm0l5HjpYhg9bu
	KZBB8W4Gf8Cc4DYzyJqnQ+mZIIWadVGyeH2kUCJph5tEP/3MnKCLGjsfkvpHF5X5yvOetqIPZQP
	MbgjEVdHubfCxIqGcGrzL6zbjI5bXeWpsw92YqlGwwvc//Ig+KbdRWzc4zIZsS8fXPxVXTJa5hN
	YF//3ysBKebeK+lWuC/3zTvFunTrf0/nMpoOZpy2JpoKDudGyCRgP8Yc=
X-Received: by 2002:a17:90b:4c11:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b3d06bcc48mr9846006a91.2.1795087398721; Thu, 19 Nov 2026
 03:23:18 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-2-586376ec3672@sentinelone.com> <a51c74ab-35c4-4b7f-b269-cd650700a632@linux.dev>
In-Reply-To: <a51c74ab-35c4-4b7f-b269-cd650700a632@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 13:23:20 +0200
X-Gm-Features: AclHuK-d4tp1E6L1c3S28pHL6JMWNb87DDYIA46WIXFDMbqGTV_so9pDSZPVRWI
Message-ID: <CAPnbwjrDV4nSyvL5cXEkdFZw+cq9RjWJN+mrs-vJu_M63x6EOA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 2/4] bpf: Mark programs whose
 runs must not overlap on a CPU
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

> Would explicitly opting in avoid unexpected regressions?

Yes: a new kind of per-CPU state needs a new mark, and an opt-in flag
avoids that. But existing programs keep losing runs until they are
rebuilt with it. That is the question at the end of the cover letter,
and I'll do what the maintainers prefer.

> would it make sense to make it visible via bpftool?

i think so. I'd add it once the marking is agreed.

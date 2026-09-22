Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90772427FBF
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113464; cv=none; b=F/jOozbsbSNTL3ywjh7oBYJKjdzN/RUC7sYnm3Z7801KeVfkYkSWs+Alp8JWzi9cqjovsT8KFjLo9hWvOzNXB9VisHFqICSQXPaaTziAa8b29CDMMizWoulr3EjPASkoxpFSJ1ASdDKkj8b6JLjwsYXUSZ9OVp0KE7xQhr9mZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113464; c=relaxed/simple;
	bh=5vQGliACkxODymv8IJgl+SrK3Mv/BD8AXqzGHXcgnKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=iZxuqSq5sONn1NBumuQYDyI90W2EqcDq0/QP5OHj02rx8n8nZIUMaTHGG2xwY9jTqePbARO3JAZcFEifKZsQG1Nar3OzkuTS77GA+pFaknEWIrYIq7sQfyCPBbMp/epLsj2WDjW3jJ+KQ53CRbjiMnFeMUXL2z6ckvwTVygRXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2AtD1xj; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2AtD1xj"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e211a0so284222b3a.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790113443; x=1790718243; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5vQGliACkxODymv8IJgl+SrK3Mv/BD8AXqzGHXcgnKw=;
        b=i2AtD1xjSB2BEFKkfR60jytuNQGRCqpRWi4Zt97Kncxpvd/CnCgBTvWR4+OjvFXDMd
         FwcUngnT8DVckNg7zXg3O4NG4Xdo2+USksatA2XcwgD0i4ts55ezBTKPoJPPdeZG2J35
         /VD0bEci6pSxKYnnxob3EvVf0Cl8AbTpg4l8o2XkKPW4AEL3eZWFXMkt5r9BMnDio1gx
         DMs8r4qHCJlAs0TTGZyiM3bqoCgDHuOxxHr6ej7TNBR0GyTnl5zPDLc7wfYxmwc6cP/F
         zum2pvJ3UMFDAWfPp0hUa014jTUoL99AWe8EG9X6nJlbACHRIfAsmyj0ZDPo5zFHxufH
         fyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790113443; x=1790718243;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vQGliACkxODymv8IJgl+SrK3Mv/BD8AXqzGHXcgnKw=;
        b=gD6NuCeQhH4Vg5mYwHIauJPR8awSIWgbY8qpxUTQR0joHwFjGzymb0JI/vGwN2dxou
         wLj5jCNdY1QvKx7GByEHPWoLdyzPZtQfwf8S/hxlzscGTcufDCJbHlOBKpF9i0y7Vd2A
         kDvXQZ2kwlKXRVa07nHucNOA23i+apFfTomwzRboUevtm0UOC/48b08UgUpfKcQpRpNs
         Yy/QmbHZpxknY9uT1O2lNgwadWhonOVANgzq+M8s0SJntzMynjg99wWZzovMcwT9ALg9
         /94WCK+M/GKoNGdzjcG0yhP30ajNFzK0xVqICivE6d8Xm9HqwtIYRRcmLiiOl/Ed66dX
         uL3w==
X-Forwarded-Encrypted: i=1; AKwUvBxekaE3W6p+/5Ho5OQaKo1UtLczxP359i4zfl2wbP7vANQ9W4vYNt/cBreNvvJ96/NexiM=@vger.kernel.org
X-Gm-Message-State: AFuF++mhNgEtyVMICRLirKdmT7S70HG8WFjlfyrgKSTGr8zvM4L4L00N
	tfwgenTK79GeBBTES0+S1XU81dnSHT9TYjZj0yq9uAcve2AeVWhnlUUL
X-Gm-Gg: AYBFou2Fvypgfkx78/E7nQjZFChRex+tgfylUl3PW0Aw1rGz7OG0C1lDinCzdDaCXNP
	LulOj3mxT8F4v0lLNudBMIH3mBwXXj/puyrH8amUDWSUytIpI+bcgbaE+86YUcTSTghz9ShITqs
	uX7dJVEi1Ab6GYD4G6DNtt59LQA+hNRl6IbkSdVeII8yw4hbcczUTjWG7jcOOSRIPAKrXvrVQJA
	nrUrOVJYfpGQYQo2jNoKVYB/BYHoIBfTaUWitwCfXj6bQr0Xe2cvHnLqsd9EpgPB8wWHr1heQUN
	+XoJCim42SvwLWJf7+KlIxXvfvzENrKqVXEuzXgbTgrVi4iEePxmWK10Tr2A3fREvTKtxsWPVqU
	aj3OHp7oAQnMd2Ue4UWFyoPYrxzkfyXA86214TC/Deld32XecPOs5VG7i0OSXtyTfdN6VHMyCAB
	RfydiR6AzScmL0JmRz/nJYlDusk80Wcty0eV2upWRHXg4tzyD7c8V0xwyMev7vVFpVFk4vdYVzR
	W4vVtz+6yyAtJ8rFw09VBkenRhxp3perA5rbewbfbnUJGL5S01uuXrKfpEFgMParFH9wAzXHEPQ
	8frS
X-Received: by 2002:a05:6a00:aa04:b0:878:3538:8f82 with SMTP id d2e1a72fcca58-87d1bea8dedmr849329b3a.48.1790113442956;
        Tue, 22 Sep 2026 14:44:02 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dadae4fsm317337b3a.40.2026.09.22.14.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 14:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 21:44:02 +0000
Message-Id: <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>
In-Reply-To: <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>

On Tue Sep 22, 2026 at 2:31 AM UTC, Kumar Kartikeya Dwivedi wrote:
>
> I think you misunderstood his question.
>
> What Eduard meant or is asking, was that (per his understanding), the ver=
ifier,
> in the future, would attempt to defer to runtime checks where it cannot p=
rove
> certain patterns in the program safe, regardless of how they came to be (=
in C,
> or Rust). Instead of rejecting the program from loading, in such a case, =
we
> would emit some form of a runtime assertion that, for the remainder of th=
e
> program, guarantees a given value to be in the range the verifier accepts=
, as a
> very simple example.
>
> In such a case, the assertion and associated panic is being injected afte=
r
> compilation, hence it is likely there is no associated landing pad to fal=
l back
> to and clean up program resources. Yet to safety inject such a runtime as=
sertion
> clean up would be necessary.

In this case presence of landing pads from rust is especially important.
The verifier would need to rely on them to insert additional run-time check=
s:
if something bad between [ip_start, ip_end] goto landing_pad.
It's not possible to insert control flow edge at random points,
since the verifier cannot see original rust code and its meaning.


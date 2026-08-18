Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2412DECA3
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787014704; cv=none; b=LjMtgeTXLI7UmJb+EJlqXSLR9igPdIpA0ZJc11AwSEext/GDw22nQjdMhTYrk3FDld+MbadduplOOzti7DAHOMiRw0ui910bYwIBGzLevEJfVfXcPZm9jVFvdry+aKbD1z7QwHGzfIkwfgvgnLvJEu0x0Xglr7s2mQuBFc56Ufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787014704; c=relaxed/simple;
	bh=kpGVOt69pSZrpRQBlGmQbtM6msB42NhDfhe+huUKc2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwZ+NaGIZfVfLYI21ndfJ0NcQqUXUFB8EyUFo9oGP6hDfUHF9Jm2J7wzUq1Ew/Prod+6bxazPj4DL4J8SXkBiuf58x1I4wU5lqTW011QuOE+b/T7/7PSyJQRvkJF1jA91xL3AfaetjEAcoCDLLHHYvfc9VkacaFOno8kDa2RwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQBbv01f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQBbv01f"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4771094a91.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787014702; x=1787619502; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kpGVOt69pSZrpRQBlGmQbtM6msB42NhDfhe+huUKc2Q=;
        b=dQBbv01fCV6gWZm0k9toklGHZugR0vfHb5FkukISz0ktDHebFrJsN3dkP7JuA1niVO
         UW71OYyMrixP0UWzJWAulMmtVtDdX/JZCZg3fDg9gjYmlPeK/8R5BPH0ZlB63uw2zdd7
         BWTr9LUSCDWXUKKLc5VKcprssohnfzBeMn4+IKCVE7rb8Rd3Dwc5L/5dDyW+84HE6ctS
         BiRJ4AW3qe9uXenWRyo5Op6IbM9lKzbxYI7OLG/Hkz8ZdWYR/jQf5wlAyuj6FKKRpnvm
         aS8mdeg31PqW65GXhQnBVvwGNjuNfWUvrEpkSn1K2ri/YWaT5NT6G2p0zmYaEeBq+cor
         wXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787014702; x=1787619502;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpGVOt69pSZrpRQBlGmQbtM6msB42NhDfhe+huUKc2Q=;
        b=EhJIUwu5Gkge5mx48YtpDDwNwP/+vtdybaPh/OKxgY1sLmDiseRpxwr98UJwJRXoDo
         7gN3ZP8+sJLDJv2M6YVY7UFVqb2TPFHPPj++jumy8D5Vf5YgAcYHO7AQtD0zs+uNVuOO
         hWpmu5tmPbm6m/3W1u8gqRN9rJqnKbUS42JMFhrqhl0RhFuLvURbbhgBp2d1Lb3PrRpo
         4SV/ROjYcvuYHQI0BtMHlbwZ93NTkiQX53OBt8XwN78Wb3qdd4keXCR4GDnplxoUzWRJ
         fI8Pd68707MW5ZeEEJthdoHVWepMDYgXvYKslK1vfmB0Ywuae2hkcDGHvYjaqe6VtagM
         2UCw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5hErU4jP5Bc+WXftB1wgLnUy1DaV7gOdH1ua6lXUM4Nyv0047n4aKWS/FGEjYF/kOEvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgej0SqMgCz4+e+13UzckzIli2xvsMU8Mh0BJv1/hChPFIJkXP
	nGiNFfJ9DzpDoBaS2DpLfclrVrJoceTPFb+X/JfgI/fOsETZu6omgfU1
X-Gm-Gg: AR+sD12DXguZUphyET3VJXM6gerO01WgTLG1+FvJ0Xwo0C9u7u1Z0sAyoDZ9xtmlUAn
	/Wcrefnx7kQG5kuocO4J7bpE89O2ufmjy+4fJeVSCro/s7Qi2FWrD1ugh6K1sD8J1jyy/SP0enZ
	HW5m1/pc8V/n138S/XLvhgY2r7p79/4fEY8JwKsjvCuDAnyXafg+EhhqyJVIp8SZIOGe4+ephmE
	ROFjbZnSb9mzAI5QQ3F4DdleRKcUbw8CRpQtxj8j5r1RKWY5x9PulJ9q9e6vEoBMaOZ8S7TY4Co
	q1fVwreyk80RFgRhyTnuNohxn7NBW+dw7tOCCYrF1CgC41LPZayG45nSWc5ZXAI4J+LHgAXMamI
	fLGM5Le1dncqDtGo2Bah8FCyapMZU1xo4Yy76BpcnQURwcRtSTmsPFplokH+OHbUxsrG+53CJjm
	6p9lMyj294Hc3fxeEX1N9kR4K57zlDiu054b46rvaCfIxugnjIFqBRocFHeZDdHJS8zMG1GpW65
	jrCllEA3oKXdssPdstfPorms2e5NXI3mVnPZ1ceuCZG6A==
X-Received: by 2002:a17:90a:6089:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-3954de49a5fmr5590900a91.3.1787014702100;
        Mon, 17 Aug 2026 17:58:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7d69:d05a:7811:f294? ([2620:10d:c090:500::7:13d7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1415315a206sm9774250c88.10.2026.08.17.17.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 17:58:21 -0700 (PDT)
Message-ID: <8d1d7b810342b3d351615729dcc7b942252a3f28.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] Simplify min()/max(), contains() and
 normalize() cnum implementation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vinicius Sampaio <vldsampaio@pm.me>, bpf@vger.kernel.org, 
	shung-hsi.yu@suse.com
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Mon, 17 Aug 2026 17:58:19 -0700
In-Reply-To: <20260730102129.15209-1-vldsampaio@pm.me>
References: <20260730102129.15209-1-vldsampaio@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-30 at 10:21 +0000, Vinicius Sampaio wrote:
> This patches simplifies some functions of the cnum implementation:
>=20
> - smin()/smax()
> - contains()
> - normalize()
>=20
> ---

Hi Vinicius,

Thank you for the patch-set and apologies for the delayed review.
The changes make sense to me. I'll apply the patch-set once BPF
pull request is dealt with.

Shung-Hsi, thank you for the review.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

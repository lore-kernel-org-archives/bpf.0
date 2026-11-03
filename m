Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703524;
	b=v7Hf2DjebN6e7D/LQZ7HDJ8pPKdsnye9AI0+t2ZgJBAnTqW3AemMqzayJrO8u6p9fFZL
	 4/blGPf3g8FUPUMg+C0WfVsiL1dAj/avv3CGL2RLFKJaRE4PK9HblkvLa0Vi7Z44ydOsX
	 kFOgApjkvQuIWg+Tq8NYZMd0m8NdWsYqnIsEoDMNJHUR2bVg74UaiO1GHyB2FuFzNTHVY
	 c6YYAkX1Aau8toUOFQxTx+DizXEbbdN2zQAhdWWrS5Vz8vHvCAtOcLHXavwqIKP1Xbcbw
	 kUQEORYYAeHz/7Bn8ih1zkukFZ+q6YrCq2JtUCPXua4XVnPgCt3zVi3IS9h2U9+uF+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
	b=la+zlrSuR7iZ9FFRedzQm0xcT1BJkUyprv+2gfV1vohZkXQGnh+bjtn30RfjmzZXd35p
	 enr3jgGSJAgK5lwWKhPA8VsS5TpE9lUoZbPr/Q+VAIgnSCPMKj+b5xEK15OelvmBpJ5uS
	 Np/qpC8VzuHFBnk50pHRoiPTQ9sbzKyqAvVxVxtK2gFn26WsvT6EwDX9VKJykgIdYEvQA
	 SK6QQxevqEb2Hm6h4cOOoL5ZV+7i5KHSwJ25/ChlKNvPP3+swlSbO+gpQzGvaX6xYc3Fp
	 /ZoAdbugAK7GKTBffzykyucDFCT3ydE5CgwcfAY6b+4DFvpN3PfWjZ4emOYUYF2JbNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rw9S2U+A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163B607009A
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 10:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6163B607009A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rw9S2U+A
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso2262023b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 02:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703519; cv=none;
        d=google.com; s=arc-20260327;
        b=elNEOxJEzpbh17LBnwJ7vUpbl89KFYYkrYXQJyb1Y0m4VwmIQ3E+1r7JLyZoXrgTOG
         clJCRNv6J0/EFPpY16z35wzEqtnCSKbSxt72OuBj7bXUMmdBIgFyRF0QYMMfPcJDfJ8q
         BKTMamRTzdw/seZDV84IdSic4CRsdToCTsEYYBkpemMKAbSO+lVTNzLydpFM+5OloYjs
         kswsT37KhLhj601BRZJDyhlWMmF6mfATry7mUIKjY+ZX+h2jP4yOSJ4Pi5Au+A6Fz9X3
         AgWVQkdEDj+Vgt/ykYf///g0l0cfno/gxavJFHVSmJrt+PlbJK1wJwaCY+xz7/dRbh6/
         Gthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        fh=9k5x8z4alEq3pSo9k9hFn18jrTgfU+GiOD9G1o1c/+s=;
        b=CvVj1d1g/Hd3Mc7tUt1YB129jH4NkEXdIoNqcNWAwUDh9ZPr/AoKKFN53YZQH9UgpG
         qQaGucC8zdYAHX3FKk9t3Ul53dTnKOoLYXjhJnPKFM0RN2fyn2J0UV8FxNOsjXOihwA3
         Bf11q3sQL6RLTVtZS4rsJXG3KiHG9MLxMXDpB6tQz8oepmSWwln7rkufiBhLArnlTToy
         nkJt+uWPsW4w+ZjfDIqNxw3V/dr3rXWxvwM1JwXIOLWa2m14jVirEm1HhG8smNBYopHp
         5/gwwSKRIT/UItd+yl2wpkwVHZw2Ka6JP6hrD+o0JuE+WrqL+ztAeVJPCY8D2SmN3kKE
         rIFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793703519; x=1794308319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        b=rw9S2U+AlSHzlzFau1E4CEO32us7ZWTI19zuQfIKoKUYkPQTPNp2mBVeYyNI1Peol3
         r4HPJvCt05Ad8bt0OdqRhZJU/2MGPm1UImx2c1pNBFQeVKjHRt2p0DJtO6VAI8QtPIgR
         JCd8J6qNyy2qXCpM/YHu8eZfiDculaeAAq1rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703519; x=1794308319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        b=DD9RFDqao27ITVDTXJ9wDI6KoOiXTsfzGPJ0c5RwiJqxIiyBVQTx+wbpatz5T1m0C7
         Lk/ooVgdoqaVjfFgxDoZheP7rjWZnIHQVdAgJQ8GGvy4wcm+UFyZsPlqwIea+Gy2JFZS
         2O0xswTmOnINZmhWFtg1m98ioZ7WBGQ/xAnpLZgTNr1vcmEt1XxMoNgijrY3I9rwpWFn
         7f0aLKc9+sb3Gr07b0OtZOz7ExqGSAHRhfEKvg8vZg6KL4BE9R4x/T0f1bCpr2+zWeOB
         h4tyJ8C3iJNasFMiFiWGqsuGtkqaWbkD/Bo3coq5bo8BHgQtG7f3GjgkHoH2ED8q+8vS
         ZYwA==
X-Forwarded-Encrypted: i=1; AKwUvBz/VMOKNyUJEWL6xE8PNmMGB7fM55JJnOOUPvHaLvecN5iqhcnhNQhjUHrdah3R31VoIH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Obqa0yuXvEz4gG6//t0zeh6F/R0gl7Y5iRR9wtim9SRh/ZGmm
	gmxq+FtfBO9dweKus4T4kTZWvNW2MLc8mf4vvjYWmCXggh9GP9G3/zVr+zEQIynskw0Cpl8Jn7i
	vY1+tE8KJx2IwTQYE76vdbIbh5+k+hlRwQp+hb5CH
X-Gm-Gg: AYBFou2YVDHEnzOeo0nNN1CJhChhCDNyUopgvc/CDbGTeu+5psRK6mhP0WlNnB4NByJ
	WekDFGoryVK+FrJHyCfwqc2p8lrQGRjtRN43+hxrOEQ8KsVyaYd4fia1CBEC2LFN+dob6GlH83F
	tWVtfOqYDJGM2MaHkq3IOGCXXv2mNuJp0bjt8H7AP+S301HP3jv4JHQjK5BpVsBvddplL+/8011
	gP2xBdaks1KasD8qKHj+6Q7XFQ888YEc3xNeTDYUIGu8/8vHqX3Mvt68WoMqTk84YXkl5UmrXvV
	j0vxva5bqLnBTdlku15IUaLTfztUPeYJQ893wCDY269OVm1nrO4ZWmO8sD1dVLHXgsDpqYd+efj
	OHxtEygeNlQnKUD4e9+WqCF/PyE3+YR920yDo86zqryS1YI2O3gY2a+N0DtWWG6Xx3OdU5Niqob
	NmzUyGmzSSJ9n8UvI=
X-Received: by 2002:a05:6a00:600d:b0:892:e080:4ed8 with SMTP id
 d2e1a72fcca58-8a9bd7dc8bfmr10230820b3a.47.1793703518719; Tue, 03 Nov 2026
 02:58:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com> <20261103105015.GE865646@horms.kernel.org>
In-Reply-To: <20261103105015.GE865646@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 05:58:27 -0500
X-Gm-Features: AclHuK_L3JcYv2zsBzLTiCwrbJ18-SV_6t1OLvaKXCNLVHQqk_NRsSESvoMnaDM
Message-ID: <CAM0EoM=-bcqRyCoFxNy1W5e0xNierigGe6qbPQ-MCiwqrgj6UQ@mail.gmail.com>
Subject: Re: [PATCH net v6] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:50=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> Hi Jamal,
>
> I think this one looks good to be merged.
>
> NIPA-Sashiko did of course have something to say [1].
> I don't think it should block progress.
> But maybe it is follow-up material.
>

It is pointing to documentation that is certainly followup material.
Let me review the other sashiko reviews (pun intended).

cheers,
jamal
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v6.r0.=
20261029162633-1%40mojatatu.com
>
> ...

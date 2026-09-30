Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239F391E77
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758828; cv=none; b=hlzCUvADmPzbumMeBItyO/Iesn9HuwKQen06jk0YuD5KNsKbENCGbaGCK+Bx9YvV5OFRdscESZk8O712HHJ8WcFqC0hj9yYL43FJ1Vy6Mo/BXgcot9yY0uBZC/swv1vyjGOLxnTlORThTi6twOT0+yuVaG6sjSWnXhmJuZpSaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758828; c=relaxed/simple;
	bh=sSFfq8V5j1UFF+Q6OTJv1JVOc53BRRub9YqpWkEgZVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pVGh90OI+UomCF4JoBehOF+/sxRtpWyJvyIqZ/hGIiV51Qjpois8jNnsOzONXaGJt9R8Nsj5yx8rkULmU5PwOk9iUCafiCzZL55L5WvY6Hgq2N6fmaBWgOP+MOi5IsoVXFAX6aPAlt3KnCdubBmydPMDOrVYHrJfA36ci7xiedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sR1IdwwV; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR1IdwwV"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso1958932a12.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790758825; x=1791363625; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sSFfq8V5j1UFF+Q6OTJv1JVOc53BRRub9YqpWkEgZVc=;
        b=sR1IdwwVgduFIv7qpHpwmu1NFvO0x7IDDr0QfkZ8/xYXZI1+crJiGrRgwqxCiFUx1e
         +40IlZ2oTgXuFWqusG4Azk233/zi0rIRjJT72udcQakiVKeCH9DHz3wmQNaEkB67OcRd
         y/yxcbmxKKBPS5TFmEv3TlygkG1HYCZmnXwP7fcSWPXZLOvLzuT6iS+eVS4j0CWmxAQB
         OybMfKIrQiaUhHz1LMuxnOVItnveRYWKfcyE7tHdRzpkYIpDy7rcMWJJDsv9b14u9S6P
         vNJQ6jl536g1u8eA3ub8NTOwrIwj7wOReV+3TtV/lxpyRKt35MdpkLU4kcNrDnG2WCvl
         RtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758825; x=1791363625;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSFfq8V5j1UFF+Q6OTJv1JVOc53BRRub9YqpWkEgZVc=;
        b=nFlH7SdRMjgpd4hku2RAUq3FLimDa/WlPIEqj7bgUS/Le5gDomV27XbzPv4loK7N+/
         z1/19D3lRMoQYFgiBXrIvI/r1w96bw0mL8UKfffY1NzOjaDpYgbqDplMXCL0kiAq/EHD
         ntzMEwyhT6pLdIf7FMTkdPYyy7ur1lDVYtRj48TlyVoUijcNuL7wQsCrJUTfhVpA283k
         Byz8NAiqKgYn87Yfjj2qbH1wmKSEr+7UkDpxNFI2vtSExS+6ePz4C+bCltXlGBS0MJch
         z7tuXo2mqJ75/1tPg51tGD7s4CoP7FI0wNZ17Z+DjgcMTei+yitIc0U25JvRVKkpKLoY
         gUyA==
X-Forwarded-Encrypted: i=1; AKwUvBydUYQcMnQgfoPqygZUn3pwOmT6+/unt/RhtUspWNsneKNJoBDSO/K2aAX7WduVaz2tsww=@vger.kernel.org
X-Gm-Message-State: AFuF++n0Q9O8wHDsdxJKk+uSUckzjmSsPikeT1cPUOOAqQFnTkUu/qdo
	EnSLIXqpjM1bSoTsrvx7WQP3g0xYQLIS/C/5nws0L59CDmidmRyqIrnG
X-Gm-Gg: AYBFou1xhAe1VTuvk+y4fdgK7hfIC4K8sC+0XWl8oZIg9prj9vIuQAsPxc/0tujKB1s
	/QjUpAgkNG9sTirqtSNccAcI7Ssij/7TrSP4r2UcqVxTnr40OPWkCugFRCdG9HSSVjqlvD0bUrK
	DTXXlvgqEVd7QTj+gPc01BvTv7UE2HRQIMWklRISKKRbmQRh/WGvoDYa/7Ne8R98bPDYdPkLzxK
	wsqROis/ZHYg7+71zC4T3aWurhRIDkFhcrgtunlQGcwThjBMpqtpW4a1ObD2a7lAAswQyDP8vNJ
	JRDQk8sSp3+KdF6a9OTmZ/uFKNtrgOUYYWTY74LK53X62RffCKnxELq4DZyVoNraZfhcw3XJyXW
	Gghzb46RC5OEJEEujTunEdzDkZv9mhwlcLrMXW6U9oU3U7wIDNf5Bjr8O7qQqUm2AyyL3mVLAu4
	vANf36tmVJ7Ov1F+fTIs+wPH8M4j1wfM3+LCwdvOsRhLbdE5pX7zBzAuufSQBXXX18eU9MKI3NB
	jpmIfOYm2FooIid6/GPEokGVXG5euNrxdsuFWgrKqpT8AIC4UAiqXerCgY5i2JXi41v7I5bcNzV
	VIihY6XB3eZ3V6I=
X-Received: by 2002:a05:6a20:e290:b0:3dd:85a8:4c5a with SMTP id adf61e73a8af0-3de9e6ef037mr777228637.33.1790758824705;
        Wed, 30 Sep 2026 02:00:24 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7dab424e8sm492238a12.32.2026.09.30.02.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 02:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 09:00:23 +0000
Message-Id: <DLSJ0UIY3DSY.3JWS6CS3TX0IP@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org> <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com> <20260925132004.171b751e@kernel.org> <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com> <DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com> <87ecebbxy5.fsf@cloudflare.com>
In-Reply-To: <87ecebbxy5.fsf@cloudflare.com>

On Tue Sep 29, 2026 at 8:32 PM UTC, Jakub Sitnicki wrote:
> Everything pushed to:
>
> https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile

looks like you had lockdep on, so all the data and conclusions
likely do not correlate to production.
Pls fix and remeasure everything.


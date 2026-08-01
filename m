Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6E3932C4
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601778; cv=none; b=cSzSMQPxhsMv031ECmCwnym6ptKB/+JVA4kTTKGQM+C33cAa8Ye6lYMrZQTgbD9etpzVir96aa6UUUINTReKpkbPgRKk7WYI53tEE1I7uj8/gyiauJcKwkyOvcp1IkOGev0uH9rUgOv6DGx03Z6YFv5qnWX1XylfL0YrbxCuY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601778; c=relaxed/simple;
	bh=GsaH64zwrQdKJ5gPv+eZ5EA1gUTGduKA+kjlJCpWnLM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X2LJVRY/ReZL0izuEM6U5pgWO53RF9RlTWRj8NpQBIn/Ytrs0bqobR5O7oyL1v8d2SSTZBu0A0QM0WKw2dPyvAmuT4w7KJdA8zQaVmJw4onk2y6P+XIvMaHhoQYTStNn8xcixgXe8tjpPcIk79fzLNQ93nzCPrr84blS3uUqy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUFxAt5C; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUFxAt5C"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so542343f8f.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785601775; x=1786206575; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GsaH64zwrQdKJ5gPv+eZ5EA1gUTGduKA+kjlJCpWnLM=;
        b=NUFxAt5C9fg0ZRuuR72ZO+PNH242D3Mzy/OAUSqS4xo3p0I94udWuFccSt0FFLnxMg
         +eurv7zCpBsEaz+kdRfNwygvFmLzZkTujFs5bClwCov9cdfgLTxTp5RGzm8p1MJg+6w4
         q6zbduE2Ht79x4yHM+47pJeTac6ICkmT07FBjj4Mq4A+Qjzx0GkF6SWT7rwItug2PRCp
         HOVTpsvh1H71kI57POLaYxu9cMWsg0z5vyRUwzTEUCGX0Ovjc8FH4kLyTeD9j2gsiwmF
         3v6xZzLvOHB3pSirgMg0AcFe7MRswMsBovInsTqHYkeFV/xHYWf/oVwXUngwjgTmO3cB
         l4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785601775; x=1786206575;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsaH64zwrQdKJ5gPv+eZ5EA1gUTGduKA+kjlJCpWnLM=;
        b=kmVuw0M5k6msHsRJzYLc9Op2giWXuAanZ3CPUrQV7hu7v/fxh6VOU6yJb2BBspnXma
         9tuXUiLKr8roilYDlc/8XsKG+fALTN7uRf5bsyeB0OdwY/xUttBdXf+mjOd7yFx4Z1Jd
         cq3Bke9u2ck65rhxyt3QA5bjTYX5FxENR6MIIC0G01dtbhlx1p56O2/3TdYlGORhnSFA
         R8lq6z3Nhh22YUC2jogZiC07mZ+j/ywnhVvo+TTnbyj2KcupmFR4U7yIACC/SuaQbV1h
         Y9j1UQCm5rK7najNne/lKBcFN+L1f0uOJeTBC+Fz6S4B07/IxQ8jhKo9Hc4l1xeZ0uHo
         ZiUA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+i4h7EzSE0UE3fil8BDjBeRD5ovjnE2/NHsh9SEdoiHFWU+vvh0Z1dJ0K49izYhuHL+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZrAbPV4druqNnPHLcUZk/J6CZBnPSzst1MVTKrEXmeS+T+Ib
	osUt4d0nxWtU1Ui4uBeHD7zLuy/i+/z6jLdlDrpRcaZ20SZPiu1okwxg
X-Gm-Gg: AR+sD13i48M8mJWLpzFCDA0JHtv86RaT6FaebBwNgMhXNMKeL532xwYi2x93Y8HFDw9
	mjj3TXVAqHKhqxNfltcz/E7c+XqIP6q/+BKEP9dxljn6p6Ww0euHX3veu93bOoHztSCebNAuzRe
	vdHcaJklTut8jS/Mq1h3tuiaB3p+bz9B5ueZwju660tZHtOpQ4oUf/7rz/PSCFJPB5T5w5IUNJm
	EzVabmVqNQLPDf2mzDAfsVG4lonaC7Y1CDKfMdgwxrJmYlevUHEcUsLQKMlVKJhM+DKn1N2ieh8
	+MNsLEVgX/4B3Yiv0f9/JfSF7+SvYTB/DcQNOBrEoqwj2fl95Cu8qAXITOgXVz0ZAz33IHZFPO5
	SDRL34H6KPOJEgrPT0kGLjCp3WpHVfhFzp/jxKoCo9s1g2c1wIFWCTvKzrF207ofJ/T7yU6gr5H
	qoTQEDxYWVOkILuoUtfT/QOkSG8yNmNo9NbSKLnI7AES+VPZ0JIebamhUjmM9f9Fr3O3SLbG+mj
	+gG2ieHsGRpVEYKTAQKdC8l16Rzu5kDikRl/lSE8JM7SagUz+TFudu4CD/qN9jyL3JKv6uloPQu
	u2OWwMbPbiUpNvfzJXRunxp8/X0UP7nX3ZRPuA==
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-47fd72ba981mr7747375f8f.8.1785601775189;
        Sat, 01 Aug 2026 09:29:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm15589245f8f.12.2026.08.01.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 09:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 18:29:34 +0200
Message-Id: <DKDR02T36EVT.ODA2A3LW6MC2@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Eric Dumazet" <edumazet@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem
 de Bruijn" <willemb@google.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman"
 <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Joe Stringer" <joe@wand.net.nz>
X-Mailer: aerc 0.21.0
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
 <DKBCACHGQHYB.194JPC04N9WT0@etsalapatis.com>
 <591fd57e-d006-4e51-af5c-fea65a071819@rbox.co>
In-Reply-To: <591fd57e-d006-4e51-af5c-fea65a071819@rbox.co>

On Thu Jul 30, 2026 at 1:55 PM CEST, Michal Luczaj wrote:
> On 7/29/26 22:32, Emil Tsalapatis wrote:
>> On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
>>> Lookup helpers gate whether to acquire a socket reference on
>>> sk_is_refcounted(), a check re-evaluated at release. An established soc=
ket
>>> refcounted at acquire time can gain SOCK_RCU_FREE via
>>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-ch=
eck
>>> then reads sk_is_refcounted() =3D=3D false and skips the put. The refer=
ence
>>> leaks.
>>>
>>> Make acquire and release unconditional and symmetric: always take a
>>> reference, always put it. Adapt sk_select_reuseport().
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Thanks!
>
>> The bot's concern about the comment style is obviously invalid here.
>
> Are the prompts incorrect?
> https://github.com/masoncl/review-prompts/blob/59469708305eca305cbd9eb94e=
5aa0ee3627529c/kernel/subsystem/bpf.md#bpf-comment-style
>

The prompt is correct, but we don't bother for existing comments, if you ad=
d a
new one, you can use the new style.

Overall, looks like the set is pretty close. You can respin targeting bpf-n=
ext
as John suggested (and we can wait for his ack before landing) so it can go
through CI again.

pw-bot: cr

> Michal


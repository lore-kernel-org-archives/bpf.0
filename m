Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495332;
	b=xQ12h9C4rBe3CnT1EC8PYy7SvvoULFl4tQtHqeGcSp2ndnukgSnxXYAvu7u5vezFhX4r
	 BVzLxFO17DPmVJMDMjrTBNg+YJV1+RS3YwtqYJ/oHiyGYwPLOD4W8D3igxZGSJsIKyEFP
	 cTAKdDW+/69GMYtAMkWtgpaxLRr4/cecHauRQ6cKydZMZxrovmUn3aq8W26fbKfUAo0dK
	 n5Ptvb7nmuNbaB/MXVU2aXAftKGi+leBpz+4sU7viutKBS0b0czn7/kzxXmmiKDeDztuI
	 YWewMGcXmiOjssHaKvlHmkQaL8hE81eKpPS/pHD7xTebfa3ZhHUaE8PbRDYELqLesbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uv9lU22wY5Li5XWaCJ5Mf/m4BXD9e1KZu/Goj17mV78=;
	b=fx/5Ii5KZwmPl15m8RZkqssTh6xhXpoZyl2vX+zXWe0AilNjGP3q0im+HX1uP/DvGu2d
	 vLKBnuvVbZ9LZp3NPWHb6PrdLNgHepv4STJOYa4/U+R7K+U+PpoqGNPRh4hpu43W2Cmk6
	 T8ckB0TgZbk4d2xaKz+KD/0bm/TksDyF5jvA1FH6Mo/aJqsNEeT0wJ4Tn56hcLKE0IUfr
	 +ViIcJLD/fh7iP2/cz0B29S5PPi1c0DkvoBTQiG5dHi4gl5SXHTVMgD1yrkItnGmejheg
	 QnpHq7BW1dlhSKlYvhdC/g1b2h1iJnIy0t7oKENJquDTajIHQ1uy1bgxy5HoNA7bFUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSy124s6;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80014606A31C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 01:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80014606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSy124s6
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so723162a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793495332; x=1794100132; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uv9lU22wY5Li5XWaCJ5Mf/m4BXD9e1KZu/Goj17mV78=;
        b=aSy124s6ewkwhPx5n4VnBBEYmGR2oVcg+ff/bSdlZVi3O4jIuNhZTE1+OUK3mUs/Mm
         tKYmabGfoY+kOkSUsLhGPTWiHGaB+YNtInEZzMQXFkdvynVe+E/C/SvLq/RkajE3ciun
         OUIDrIZVpj5eHH3swWbEI5+3ZxatucCevLvFsfC0j08/JzveIZmWJMWvMHdiC9mq/gdQ
         3KTC21ZcgX4gJwHQPrSergjyipfMzc9R5ZcwbAzbk5b0Z/KK7EcUaGGRuVpGNHxEjwGI
         xEYZw0y/Fuc4zj45ZOp8rpGFhwrSTz5GI8bQIT5bOD86b9mCzPz8M9xoKzXjnTmOw+Sl
         j1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793495332; x=1794100132;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uv9lU22wY5Li5XWaCJ5Mf/m4BXD9e1KZu/Goj17mV78=;
        b=jBJxlMdRDJ+5wIl3kcAobTBNy0IjUuazVGKVt7/oJ/E50518ncVcje4zUvfSLH+3QU
         6nNH16fG3vV0rlM6ZjGiyHjMmj0UXm49xaoh2Sm52M3i+xnmuGLKmOuw5NGfdDkTzSvP
         d1DYvhi0VRsRZloLfI4l9Uh1U8Yt4SlfReIKd4onSt2D07kgIJoIyGTKEezOV6ujQF0w
         U1ELVR8H2mCbvpInS8M3m9TmFfT+ewxYyxDaKCjrnmTCRBWuxFmi7vgwFpUd3+b8yQyO
         a7xLJi66p35IM921FhgqIMT5Asj95IWzyUk0oFVSJq1mEYAosD6SrMhOMbxQjswmJXrW
         cAlg==
X-Gm-Message-State: APuU4Z/xkQMa0sieNm9JWYixpfTji4LdkiGTRxHms0NtWlANyVRvImzn
	hW2kEQzQxuLrdFy5WFbLI88u4txOCbgFx5jKHGCb4UX+AOSQjl12g297
X-Gm-Gg: AYBFou0hBzcZ/ZH+um5c5o9u0zkxnh5aub65m1yTUnPpPyrGIXimnicVQbsoBTuapBv
	xwrUE/1m9HzrIyID1ZqdhR/zhxMara3VhlQi5dPcY3fifBawlVbP45CW1YuaZmVMBeYr+ufFDzl
	sqYDthDRXxKXsbmQHCPeO2qUy6Dx8RnxMcNuqHTqO8AsibmEaaRvCRliRXk5Q6n7AWYiUySHENC
	mk6ET0JV79cCYCGYR5DwjtD/8uwL1J6x2HYyUL5dTJ7KmSy2L+JxGNpc6DA748H4MT8gwezDF2F
	avOs509PmsF5xFWpeLwnlsW2SlwxUVz3EaYMnfm9Aa4ZRNKz7QSSWQra0bGtMmU5o0/FBXUsAQt
	JcDtBg2+A/MLTXpVhf08Z0N8wbWNE1pxqozGrp6j87nmTU97kFTBOj8g9gUMlviuAoZ5zG0SlX2
	/0KiQHH0d5iBnmFbRmMu9ReKRwiVP7ITO+J2uZ7oPhUfrnyYHiLDc0cI5Dxjg3BgdyRX2Ds/s8Z
	f/bG8RVwOu163EXlWopsVaEd7/4LmSoTQ7t/hzE2w5stLuyNVK3wqUu+bJMcmPh7DZ13Pk2KI5l
	k59sWdhgB0WBSzM3URK/+cNxcBLB1GqWPxL8f624bc8UWy5h8drbJTYjvMBrXjvaAF9UOpcWDiR
	NnkJeoK+Ho56TcPSMfZo5KnR/m19PCWzUCg==
X-Received: by 2002:a17:90b:3b51:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-3ae897c7d22mr5481949a91.19.1793495331839;
        Sat, 31 Oct 2026 18:08:51 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fba61sm13130591a91.6.2026.10.31.18.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:08:51 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:08:50 +0000
Message-Id: <DMJH18O0LW66.2X5ZLK1R332QH@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Henry Martin" <bsdhenrymartin@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bpf: fix out-of-bounds frame access for async
 callback stack args
In-Reply-To: <20261027154553.1043567-1-bsdhenrymartin@gmail.com>
References: <20261027154553.1043567-1-bsdhenrymartin@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 08:45 AM Henry Martin <bsdhenrymartin@gmail.com> wrote:
> Kernel helpers pass at most five callback arguments, all in
> registers, so an incoming stack argument load can never be valid in
> a callback frame.  Reject such loads when the current frame has no
> caller (curframe == 0) or is a callback frame (state->in_callback_fn).

It's fixed already.
commit 90aedf8854c0 ("bpf: Validate stack arg reads against caller state")

pw-bot: cr

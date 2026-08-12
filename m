Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A8390212
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551939; cv=none; b=B/YTXHawY9F+R0YO6WrdDMt22y5rfGlh/LBruOAkDS5576wjTdSrdSuzwLFyTH8/u5a/ccx4e3jUmGjZShTKfYsm2DaZ49t9h6uIrsKp91381vhcGZmB1tGz6zxkYHcYtvCnRNwSErhjXiozNmltMvSKb19t4WPb4cekyMbj/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551939; c=relaxed/simple;
	bh=TY3KWn1JzXr2UezWchebIm1iBX/Q2dvo2T3wp6pS4PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0Qf8+6/Cjg9uP5NZ3Lpo9Qy3HCYyRp9G+C451p/HhUSyN5DExu8N2VLE0XSyyZ8s2DAneLYJQJueN2a/R5xasEs42EDltZjw1/pHgOMRQYaHYE7MWZ+iifB/S4LqLlTC11fWJzVlb1inJhTvhvY2bDT8MKatIijYdSLZUa974Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA0PaPbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA0PaPbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFCA1F0155B
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551937;
	bh=TY3KWn1JzXr2UezWchebIm1iBX/Q2dvo2T3wp6pS4PM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RA0PaPbplRmtojxvtDg3MrTbo/04BE2IZxekE+soIypnTT9ZOkqaT6flTXl5bF3u8
	 Zmsulpzv1u5a2QYDjkvX3IHaCi5fMSCH/er14AFh5gg68veWORd68w2+do2FMfSdQY
	 hrFVlNMs5qPGaLv0hQ5GsRQSGq17B3txtNvLpbnUaqEpimkHGEBS+xnfInPY3mlohQ
	 rKo0cgbZ5JKxERiNVhfEuJAhOrC/RgucF8KVy5lCxKh0jBdI/b/T6hK41tTXvvq2HR
	 vK2Wngr+eQgRWGaKO98ah2DlH7lQo7/lQqzMl6etv5kvi24+Qegcc2MTTWBYQDGNtQ
	 SO5UANTlZsA8A==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so73274685a.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:25:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+rNUBloxdhKOLM48cpRbKXhP2oIetSK+kPQSwfBz063j3yF/N
	DifCtJM8VCHBs9ofke+ObGci/fSnUNUirYB8ih5QWGZMr9hrjBJKd1trWj+tZ6uMPOIOCgXVNpY
	MLnJEefN56lOZfzMtI1zyn9SdtXyp0yo=
X-Received: by 2002:a05:620a:43a6:b0:92e:9d63:a700 with SMTP id
 af79cd13be357-936b3a20e63mr565881085a.9.1786551937034; Wed, 12 Aug 2026
 09:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812154328.72834-1-mahe.tardy@gmail.com> <20260812154328.72834-6-mahe.tardy@gmail.com>
In-Reply-To: <20260812154328.72834-6-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Aug 2026 09:25:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4A++FepX9LAR5scLh62fG0NH9oMQ0xwCEVS4=76PVA=Q@mail.gmail.com>
X-Gm-Features: AUfX_mzWX7aTt3SMUKwJ9r74fq8ciEI7bBsIz1h7rTwgDeyK3eDA8B5ljxnBIlA
Message-ID: <CAPhsuW4A++FepX9LAR5scLh62fG0NH9oMQ0xwCEVS4=76PVA=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add ksock test for async
 callback guard
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:43=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> Because the kfuncs are going through LSM hooks, allowing their use via
> workqueue callbacks would expose the wrong credentials. This test
> ensures the kfunc are preventing any use from these contexts.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Song Liu <song@kernel.org>

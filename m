Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17744A404
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046987; cv=none; b=DJdtR1ACpkswrYH3bZoBRHX7g6FyYB6+Umbiet42Btx6hlGwu2CZSU2mvIdX9unxxZOYZTSNjxd7wGYX8bUPmIYFNAYBDXeHfDTwVfQSRw7eJBBi0+3g24mTJNSkEVZhmUfCdP79RLkzffkcoctPbFom+lyJv88QwYSPAQ/BFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046987; c=relaxed/simple;
	bh=fX04Qk4mczN0NAo4PWx1t+SWUSsxPl6jPtW9IM7b3Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn5TdnVxeTUMvfdyIfs9o0v7WJDTQvRnKkirQ9u/ZYmD+nGYq8nX+Lwk1/uk/YGajOel5EWY8y5tGPpumOIcN2PKymQg9hnTSNHY4bMrN/L0uQEIEVwlCUg39ArDumPkqLiY1Ucd/oWzCLbFfC+VcPF1H4fWLOLSJV+3mztyKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TATlyjuJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TATlyjuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9172A1F00A3F
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046985;
	bh=fX04Qk4mczN0NAo4PWx1t+SWUSsxPl6jPtW9IM7b3Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TATlyjuJnOd2qC+FB2P6DESpckSOJmO5T0iy1QYoPrd3FGq794/KD9c+1cE0ZBv6d
	 JIo+s97v2wlVd7t01R8/BGaU58CvQ9zDT0LTa31udX/LzfGBEn0UYCxRpnBktQlCME
	 zFm+5yEO8g+W8mgyQ1Z7EVIv2DmcE5r8cuZPBjBsUV2/PxhsYcvgoJHbRxjKUngXDV
	 cLYKXmAvNQQAhBpE1TYccQrMRmxPi15IdrcGLXosrGSxVJL2yeNIMNdMeh2z8IZSy5
	 a9C0+qvDqZQzD4UyWnTz255vwSK8lGp9wFsL+iT4UlndhmNZHdVmZVgFoHm4+gR3z6
	 VnHBOzBhw8p+Q==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6391b114so207168485a.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 13:09:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjmYn8FQly1nnnRYLzCj7sWxLHQwxJJl3YTIyuZuni3nl5Tmrb
	hO4tvX1gdA5JCoBVpIrGGLgfQABL1VHwVusyf5Q5S9MxCRtJvGci3anW9GZu4lRAHD4S3NllQHP
	vsdV1giblVo2SzqT9MeV1nmI8UABXA+8=
X-Received: by 2002:a05:620a:2888:b0:932:d9c4:3bec with SMTP id
 af79cd13be357-936665d4fe9mr488591485a.38.1786046984866; Thu, 06 Aug 2026
 13:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806182234.380833-1-mahe.tardy@gmail.com> <20260806182234.380833-2-mahe.tardy@gmail.com>
In-Reply-To: <20260806182234.380833-2-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 6 Aug 2026 13:09:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7-srT-U+WQJN_b_SY=2wbkNQhs+JF=5aCPXGmLg1-1Xw@mail.gmail.com>
X-Gm-Features: AUfX_mzwR8FtIRMHRwWg9kVoVVb_Qr1PyfqtKFvHPk_meoj5_xh05VsCRPk5AGo
Message-ID: <CAPhsuW7-srT-U+WQJN_b_SY=2wbkNQhs+JF=5aCPXGmLg1-1Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] net: Add connect_socket() helper
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:22=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Song Liu <song@kernel.org>

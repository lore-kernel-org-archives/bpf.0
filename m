Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828D3D811C
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366156; cv=none; b=oUMYqNF8rR2Cm8g+GHG54lH4R05n/qJkAben15jdc1o6fedngl3991quezEzRGlcztgpurxpwrvr6754h8dkguq6L2z7FoaL/en9/IVGWelG+TgKCRm+w6ujzoZ597yxiZjtoDDqc1Tw96UkMqfhqDVw3WabCdAEuLtQT+U0XL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366156; c=relaxed/simple;
	bh=SdqvWMCnckb6C/qwPHK1OCp1P59kDYcpUso5dVOBat8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSBO+l3O452AoNbtrXebZuComuOrF74ADFUjowYSFchkcuK3mUOHCmiZrZVToUdGGa5gbVQ07Rkwc0Mlgv+ehltLYbbNTRylEaiMuW+Luz6M2LR53TCZlh7GX6vYnnQw97z7ISd3z8k7oU+NiukJGssX7nI3StWamlqsmsBUlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdRQHA7f; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdRQHA7f"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847a52edeb2so2542740b3a.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783366155; x=1783970955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SdqvWMCnckb6C/qwPHK1OCp1P59kDYcpUso5dVOBat8=;
        b=DdRQHA7f9fs+xJ6aMHwX5AHrxHjHv9YBhrQi/6IUQ8IpDdmpu/ji+5PUbsWBxYlsYI
         f70o1zywlNx5Ix59/vV+Nzxmwr7IF1yuxhmtTTfl2z8S7TxCupKJ4WezWcHTmnmmRTGO
         lQNJaEfppd3NXPg20XSDB6kf0DjiTup4iKndScYl/BYZCNq1npmrQjtNI+BY7/q6/CqW
         abzQLkGIiRXTRSUDyMTtV3wBi/+pNQ38ZlJuq9hujXZJw8o0pLZenvRHwSQFbu+PgvTv
         jkfepNKesd6XtVQAYhoFCcGlJgx6L4ou0lDdKw09fhnfXJ0Km+/DAKad7cgJUxX1UoGM
         YMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783366155; x=1783970955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdqvWMCnckb6C/qwPHK1OCp1P59kDYcpUso5dVOBat8=;
        b=pjfIRd+ZqknxBZP6wav9URc40q2QAITwCwYY+4ykjYlDG5d8c1MCn/5qT/Wdx+AkXL
         lN6femWe4ms5p51FYEJTLelGWJQZqQELw+Qa/FZEt447xgo0CKYiMDwH+ZWcnUWC8X/f
         v0oWH70Bf3zziS/Mf6DSx7McCx5vOzN4Ig6WKFttDIfqEwb3QDRi9p9+VVGA6Bp0MrP3
         OAcJ0h+X4DQR34u2YOxgEfiVrtKgoFPTOpXrhAYCP3/uN/eehsbNo9t9+UJUqhCpyB5G
         Yu9h0yz+nsVHvRAUx47q3IBqMR8ODgy1K7XGl3H9wg1BXUpNTsyw+IPa4592/9UDoHSH
         vTZA==
X-Gm-Message-State: AOJu0YxNfElOTuf+OjcVO6sQjTYQsgXV01OjsaRt/nCAPf0Yo/wo5dfg
	mr20CWQGzA/1b+Cd7hWY3HaxotHVw6UWcUTwlZWtGv21v4d3h6O2l7hr
X-Gm-Gg: AfdE7cm0eomQqnPouksRAE4X67n17p5oSR9PPcjSRVJ0v0KS5cxr8xvowhlJNhfrYIG
	KXy+DT92Xp6f5/5G8CVfq674jvh9WCS9kXUfpEhu5fvvcg1wiC3SPiY4iiYmu7MlLQUTiNxrnHA
	S5CzcbEp3oF2bP10W9k69puTI8LJoe6OxsZ5xJ8ouSHYOpMbv79A/FgOTsETqQ9iFsP/7RpA9f6
	BF7B0UsDWW/xUTEy/kAGsbzOp0TSMCjgE14lNzW47sfp/+DxY3ufSKC1axwVtIz+WcvasTzaiVN
	g3Uk2Q3neMwm6aGKAv0a9NuOOINaS/nv44xwA7pPTnQ/squqMEzSlYXsUKPa7xRpOVskecP5DCr
	nPsZ0o3F5401Uk9i96nyFJJDhuSEsJkCVIox4QTnXDRQeFzub/Ba2n5KqCRFmJuJ/+sVO07QBZi
	MA5W3msy50xwjSq+M1sliN9x6RecSIVISWwUHl9RUHSrp0L/Lkkl/msW/qOMB4zn+88kkbbw==
X-Received: by 2002:a05:6a21:2c11:b0:3bf:49c8:f69 with SMTP id adf61e73a8af0-3c08ee6c976mr2081583637.39.1783366154882;
        Mon, 06 Jul 2026 12:29:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:612f:7084:be32:532a? ([2620:10d:c090:500::1:55b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb7fe46sm63762700eec.14.2026.07.06.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:29:14 -0700 (PDT)
Message-ID: <d6647f5eb213d2ece82753285a79f28f600420d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] Mixing bpf2bpf and tailcalls for RV64
From: Eduard Zingerman <eddyz87@gmail.com>
To: =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Pu Lehui
	 <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Puranjay Mohan	 <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt	 <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Pu Lehui	 <pulehui@huawei.com>
Date: Mon, 06 Jul 2026 12:29:11 -0700
In-Reply-To: <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
	 <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-29 at 16:21 +0200, Bj=C3=B6rn T=C3=B6pel wrote:

Hi Bj=C3=B6rn,

I'm working through bpf patches queue and have a question regarding
this series. What's your stance, does it need changes or can I apply
it to bpf-next?

Thanks,
Eduard

[...]

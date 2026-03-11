Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797E2D595D
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246681; cv=none; b=tZZylqV2mDltw+7FK7f39mIyQQztYEo/gIiaeMOuFGH0BDqKNJfAnU6ky17cc/XdMTv4ctbQWcMbfzboepQMQij5buVgjj+2CwrXZMPAtHm0l/n4uHmr/kQGV0g7pJqH6gwlgq9LT7rYF+7vVNI/ZDcyIk8G6AdnakXq8f5ISTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246681; c=relaxed/simple;
	bh=Kd2o1aBEobvspvm60zCAF7juO/ZjobOchZgqbSx1vIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r24Xu92iO6oNpmxEVfIVhT5X76NBcikavKraElaRA5ozv/qPaOSAYq9zBCOezKN9C74c+JnyMUgXt3vl6OhzKnu+ZLGpHS9HCsTGAr5kmL26jiq5vE1s3laZ17bYkY+4ig4JOp3JRxJkn+CdsKThoh0ejxOCp+FcmMt3we/zy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb3qgogW; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb3qgogW"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so103143eec.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773246680; x=1773851480; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kd2o1aBEobvspvm60zCAF7juO/ZjobOchZgqbSx1vIM=;
        b=Cb3qgogWrAS2nG2no+ttZFOwVLlRLl8W+29UIzO6at+gdjh7XQ9MJvzOLuGzTsP5LU
         7WtjhlUX7qlb1HWtHpaF/m+YzBja5iWY2jpdeQcy3cawQ4hQYFmVqhzFjpu4E9px0Rf0
         VLDOakntGF4qjy8U6H699pFTnMKTI/C+T4RvJE8JFtbUPjlKgZIK6a+1+8aZKaawK+Ek
         EPh5LMX+vPgMjqbB6hstBggMwE5F9BrM8S/7UgUiDYAGKfYoPtMXtXR51HxGhDMB+Yle
         kzxNyfFlDh1TDXAZ1Q+LlUlXIRdW59GOWhuPDXi3WQuNPQXuAf6z21Ay+CJeoeWFNwVx
         7IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246680; x=1773851480;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd2o1aBEobvspvm60zCAF7juO/ZjobOchZgqbSx1vIM=;
        b=jbuXlYa5cCzqQts/t8vko3E2WTemGEzOK9Ff1jWhD2jXdrV1wB7VZESEezUZjtUdCo
         WRXHDt861r10Az7GUkPwvG0gU21zZjf0fGxq4Bd1DTJ9fFmZKF0W/1vXGBDeXIHJtmM0
         S7mwKhra3kkmXrqsRIVOHrH+ytlw03et+5KdRxiVQclADxgyJd2INxVgLMkHMbWZj/Q6
         Y56+YSnRUTYFiLGPw7mr2S8FLfiZTvWs/b/aKXxJoZUR856V5JSiZqx3l/JlG1m8FMh2
         Ozw/ffo0TgH0ovWOfI7uH13xZ7A7pMqIfC6ZT+yUx/sz7NKVzMgXsGdhvfLcvQJ9HwDE
         249Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwIUXM+Bv69gkWiCPqxX+BsqWzOJtf2zSScdisMwvGDbbJTjVer+g7qCHbfDfBkaBSkEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUU9RozmwfAgnwDsUcTRFuKX7d/QhNGk/A38vk5W2NgtTa5j6
	389Q/lVLl45b20Z0Kz+I8okUQ/ueoUY359bKvS21ja/Ur8j+GU15Mv7K
X-Gm-Gg: ATEYQzx40+EQ5MMFQjdwUYe4L7UBIHD/43W98jPFBychYqaQa5MDyHiWqIZjuZqJBEC
	qdV8/nn0Bg0/S9zaAHCQWWxuOtycaCxF2KmHBpX46nxWMYZFNLqmO+NNK8ZOkGdzuP+zwTA4WCr
	Ml8CA8+IBTX7szfEz03ImAePM1quVd2AAOHc+sM+PPhgyVZ6O8xu093MlRBa80TT4+J9VwCWgdN
	UGBBxlSr3aNRVlCg5tgUxHvU1Qh0EhOSyartDAVFVKlLAtGuhoDeJ1YQ+1QnHhssQ2FDDYaMgG7
	Au1okYRaVtEZ9SE3f+W/uNOnCdQ7MvKLHXywf4LGLPa6DHBEy4XvSwlhKodlpVhMdSkDSVBu2V4
	IEgmCEO9jFPH2st+oXh3LVNe+hvava6VUT68QZ6Mz1MOXmUZ6AXzPrAncKxXjDX/NgJ384MDlbv
	CsToezwA0klKkrUHkDwQJCFL6G5nLNhgouVnt17r+QL2JBf0vWAI6kdMiEwTKrcDg7uGS7pw6Bv
	RGM9cI=
X-Received: by 2002:a05:7022:218:b0:128:d7a7:526e with SMTP id a92af1059eb24-128e77ae81bmr1331880c88.13.1773246679819;
        Wed, 11 Mar 2026 09:31:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7458:e476:e695:15f3? ([2620:10d:c090:500::3:a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7c1780bsm3445083c88.7.2026.03.11.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:31:19 -0700 (PDT)
Message-ID: <55f48be8727546631aebacc847bede5ce2de85c4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, horms@kernel.org, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, 	pabeni@redhat.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, 	yonghong.song@linux.dev
Date: Wed, 11 Mar 2026 09:31:17 -0700
In-Reply-To: <20260311130711.33966-1-slava.imameev@crowdstrike.com>
References: <979c7539ac475b3c428f609066e947844b6dd8b0.camel@gmail.com>
	 <20260311130711.33966-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-12 at 00:07 +1100, Slava Imameev wrote:

[...]

> Adopting the view that vmlinux BTF is consistent, we can replace
> btf_ctx_access's condition for inferring scalar() for pointers
> from "if (is_void_or_int_ptr(btf, t))" to
> "if (!btf_type_is_struct_ptr(btf, t))".

I think it should be fine to adopt this view.

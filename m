Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C53C9899
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652890; cv=none; b=Hid5MF9k3A6P+oz0psrR0ffCzcwFGIkcQ6Lwf0CWvjNy3juE0RWhGLoWrAeGJvAs3uTE1ajecPVkWpclxwSSJKssOMiTx8jhWwt3Z3zPT+f6350gc7UYhhDyk6s3V3bpV6K/FhTt2nYmB1RfnwyImWDQ4/zhHXQRU9Y61Z9P+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652890; c=relaxed/simple;
	bh=e7VbAl9oFSSHi9RGRYlzPyWnGK5liGS+StI66tcfe/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPxH3DT5DxywWsk06vwef/0uBW5uzM6mFFwMYM24oOvVn6fdb9ezlknxOMdNbvba5yUyA8RR4mMPitPthc/HEz1fkG6htOFXeCS5Km8p3Mr/6sF+F8OjY9Wz6ba5hR3/pQfWntMQ7MlI9eEftZ6aZALGdsTTShydIsihJ850jXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLcM5joj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLcM5joj"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85893bce34so680476a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780652888; x=1781257688; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7VbAl9oFSSHi9RGRYlzPyWnGK5liGS+StI66tcfe/4=;
        b=dLcM5jojfJaEbZXANpiCxBrvbBOgq+JMhDYQaGvSbc1U7B3E/LqLGd6qbE/UPLyQc7
         u+XfRCQeh/NbCVGJDkrD5eNpo7WXhOzd0QKUrl3aY+aH4tRvTnEKLqShgTec9k6kghV9
         jNnYk3DqNsHHI60i990u67CIKBujemDouY9NmTD0erY55pLMJhmE2h7ShLJ19SvaAy6N
         fXYTz8Fs3YQVM5u8G9MDiSkhwtFWQSBOyp4CvLRWOMtfBlaw3/98oQTgn7Mvu8lcRNdf
         3UZbFCNaxHETnIOo+1qhixXpBVIrbtowdZaAQ72iTaNDNg7/0mZzBLhIYMOu0TjUKqh2
         Agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780652888; x=1781257688;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7VbAl9oFSSHi9RGRYlzPyWnGK5liGS+StI66tcfe/4=;
        b=sRoDieR4ggLY7NpyHP2XuFAMSKd6pU9mE/ZquvGLnS9oiOxbtD8UtwhLNVX+m64AaN
         9MO6B0TKOxNjOYtJJuUn9z79W08/bhXS1rDnsvCCdOMpumQUXdBI9kzcwoUnTl/vJ6Xt
         2Cw08eHG+FZGYdwZoTs0yLwNGKtZPsNbLNCrdTOFl6Jnb5h5NFeG27jlJxLcITxJi0i4
         BL/qsOPlMlkg7+lYYKk4aVkJV8fgAookPs3a6G8ytNE0uq2KUQuL44ebcie6ydPkcPqt
         nLOViYaRxplCbl5dRwIqRdvHQ0dzkpma/0kLd+wT9wyFmaOq8kQQ//g8nSjOshhA/J5n
         LAWA==
X-Forwarded-Encrypted: i=1; AFNElJ+fw2B7vq71o51ivYhFjODqrDqUMnOqsSAcJQBlif1sdeQB9g7fFqQzzTjs0P1xYSvETFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3tf/ZmBz+N4qj/oojPCMvpYupRnGb7dvrUsQOCtE2qmWmMwI
	Yd/ENYeo4RJxZNI26B+jKCrPZwStro95aZq+3mtimwpD77qO3yqNcY3X
X-Gm-Gg: Acq92OFtW+QPkvfFUMPg67rGe6GEA4mK5XrpP/63eA7YEsji+lfo1UE6sDhROuzxVel
	YgoDy1Piau2h/aiZiuo5479e5kQcPJ55fkHprZSD0K6gx86aDegiNA9vNe/hbfgswIX0Gx1AyHB
	gFK/0Q1A2mLSPWv+kNndkb6+kRYqsLBibovwUt/86uQAounZ54N3omTWCKgrmyvncIRDmkuBCn/
	ZK7+F+qQPaiWMVmYCkfruVA67/VNK4MOuCVN0bE5+c4lEcyayNYEe5Otkg760V5Pb3p3IaMLbZy
	LvRWyg2mZfOgPMClC95W5ZKHLREkPYUwPvyhDvDtzsg6pplygtOIX2/dKjNeqZ0aSQs5uQWpWHJ
	nIrBV1aUmJNNb8Z0ZC/kWpFncH1ctEWlZbIZt8GdCqX1E54ES+cPtiC1NJBLarwaGmsAZjqA3rg
	OIGozPizh2azl7IBFbkWeUx1L4Su/DhcIyV2GIbu/tUX+v1U1LrWMe4XrSPo1lQQ==
X-Received: by 2002:a05:6a00:b807:b0:842:74e3:48a9 with SMTP id d2e1a72fcca58-842b0e449c2mr2778426b3a.12.1780652888452;
        Fri, 05 Jun 2026 02:48:08 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221a7e9sm11214741b3a.11.2026.06.05.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:48:07 -0700 (PDT)
Message-ID: <70d13621ffcc36e3254ab78f8f1cf14c4c9b4f03.camel@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover dynamic inner array lookup
 nullability
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: dxu@dxuuu.xyz, Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 02:48:05 -0700
In-Reply-To: <20260604151153.2488051-3-gnq25@mails.tsinghua.edu.cn>
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
	 <20260604151153.2488051-3-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 23:11 +0800, Nuiqi Gui wrote:
> Add a verifier regression test that looks up a constant key through a
> dynamic inner array template and dereferences the result without a NULL
> check.
>=20
> The verifier must reject the program because BPF_F_INNER_MAP allows the
> concrete runtime array to have fewer entries than the template.
>=20
> Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

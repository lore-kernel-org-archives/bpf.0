Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDD3DA5C5
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070945; cv=pass; b=EQQwx8Id4UQt4K8kiXfjZ0eQxCqKNiglj0vrlM9GaZDwyC/mYXJFEbXhpxDPO6jaIQf85vDuvlMJIkL8Fp/x/HdB1VOtTJCpoeXjfTqKR0EJwCMeWbx6Q5/+zA14t8OpB4tekrMLLidf5YquCI43RE0GW7vkzNue8MZi+KC7a28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070945; c=relaxed/simple;
	bh=kGw5voA1KmJwKFY6CkPWjSKKQ3x715P8GBp4QFY51nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkvKa1C8khubdkCdQ1ZdZZEz2tKAEmECRMsoWRjgiicH/NytIpEAQpLpbCqzD9oB2j70Km8ADT7HaSbJ/zvFVcqF/8dGjhvkAXG/tqHxbLHBJ4hYAr1OhEi4i0o0MVntNiePyzaL/VUkgDo9QDI+KEgtq/0m2JZRPI2cbsog+HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2Csianl; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Csianl"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c5cce2c6so5467633f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 08:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070942; cv=none;
        d=google.com; s=arc-20240605;
        b=kbNyjxuxJ1uZ+XrQcfge0IB44CdpCAn+bzrgGsWiY6q7sECbC1hQif+hQo/GXttutM
         6UbgOirpTYLE9Y1GBIRmhhrCvmSZXD7R2+ZGiPZ5hQnSWjwPvVVmcVYu8Fq7yJswQd0l
         C66LLn//SpGMAXpMXlUJ8QhGVqW0Guk2RPD+LiGE9GOvbF/1l2/qWIMgekThxx0SRSjb
         Ns8zdd14QiMCc6wXNYhb/PN73dAaqSLITiCVJk5pAkR3RtvDHt0wKmkPkoR8xo6GdFuH
         nHqA1yWms57t4pNjxzl+wlAju5Yo9+G8DEL714JRTexe+1Df7c/bagKAvsa4+oRwUNb1
         bQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kGw5voA1KmJwKFY6CkPWjSKKQ3x715P8GBp4QFY51nw=;
        fh=etmk/P+JfCblMqiM77QweMEI98TwBivYBxBlzrHD518=;
        b=jCsQ5BRqbDbigbMZQWqcKFfmmbFLj4+Ml1b85Lzez+HVR0t5KK7ul84V7yAw6/o5wj
         rWlAg5M9euKv3D8M3kyGKAbh0ynqPwMEcP8IzniddK2T19qfBDnXBxGuget46/p4S+Tl
         ibNZNjzhwMbOVNSQLTy6/uT7q+yyleZIQoaXPDXbc8WL+x9NVidcZqzsSm8dEVG1FSpi
         DMITTTXN80oDdqwDBtE7KfF9q80j/tAsiL0oKAnWJhyM88Vnck1gYPd6ujE3D7ReGGlZ
         UHI9H/pz99ViIyXPsIducM/6vbAa+FKNt65jh3hRp1bwNkpUBADuf0BZmQh509Mag0Ra
         L5UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070942; x=1773675742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGw5voA1KmJwKFY6CkPWjSKKQ3x715P8GBp4QFY51nw=;
        b=m2CsianlYhiJf7cBMwPK8ILm29kV01cmwxqJiGfM72MbrMQL4XFiNi+JHu4qMny3m2
         tvdPX6vpHlShHx1vim+yL16kEbfJx5FfkHwHq4/QRkShf35ASVj/qMmwgA9em+Tw2YjA
         91lGRMnrJLCTlDgA8qcn1CQMNp04E+HsTyGDDevAuHcBabyvLqPcMh0LzAacn0jN/ats
         wuu1pZKS3ZXluLYG+11mZzJmjs25dg4AOfPSps9ZehokQGOCJNqNl8RbbgihgsmGJweU
         cy04bEstzCbyiIjdGx6G1a5yGiSBitzjndz9PU7TC/BKg+155GQNdKYKqq/LOD/MqcCC
         SUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070942; x=1773675742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGw5voA1KmJwKFY6CkPWjSKKQ3x715P8GBp4QFY51nw=;
        b=per/p3gtQoG0TCRXRUAKSq0+IBSF/ptfQQ5vw7BRaTB2iesh3gQNyk3lVc/+YbhFpL
         76Bii5EzGDz0XoZNfn5ETaQg8ISAi721m/ndA3141gR6TB4ZL2OXowNtZPQ9frenGezN
         9gQx7pS19xaElEFMGJBtga7Y/egJ4pZDD4TUYQcSVTOxLSCvIIde3kS5o5XOOHwokk0G
         kJCwDuNNyooNK/VwsL6GF51yt0KWW673oyEc7UeiWTU8Z2RERCRZxv7opbq0oXknHG/+
         aO/2/Cfyg96+beN5yp/t0XsbreKc1cMKaSw9JeSAIDVtIa6ME75tDCjJOJ84bP942mw/
         Tkjw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGjBkIZ9K9JRclt2F9dWxIM63sS3DvijMpRk9rSrxznwLMiQoK0UqpqmbTexdVZevZJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO855Irk0oQcAfvH7GQIY/f/17kgFVDqc5Z/RIidP9vTMaizTC
	Ke/XVhIAzKG5I1bjY1VJfKxsswZWFmQfyfDNOeTkaeHAPqF9YN2YJoPuuMM3KEKIWXrUSAQoeK2
	QBAnzcQ6pm+QbSjzSRG9L9cuvlRTQc7Q=
X-Gm-Gg: ATEYQzy7aQiLqVEbk3xDdC+VHc82g4JvBq3aHcOk66S8NWmgkECV7owbwwuBsGgR+B6
	cuySvVJf7viJMkQQoXhuYbVYDA+DvgiLNOdqwolv0ndDsuZpm+ieUCjsbQ7FnmxZDgUmz+DSalI
	ZQyqIqTabEzYs6CYHlDm8+WaVA7ppO/Cfi46xKYXWmgVH8VcRPONHL4sUghcO2Lt5GS3gQBX7Ur
	+Px82PTtPIHOIYLurfU83Nl+z8xHUMfuwiUeT5ZfQEhk5xB3GOnI51UGvoE70mW40tAMxGTj7W1
	6lhXSaxAQmYkwlW6Uw2x0ShI7GX9tfTxibkr/HHz5LckCMvZ+kOxKLHPZqK3TBSQlxWGVeXMZfG
	73CQIXD5uj5akbt3Su4xLB0pCXjLN9ZClu/bT
X-Received: by 2002:a05:6000:288b:b0:439:b2ec:1710 with SMTP id
 ffacd0b85a97d-439da654313mr18931718f8f.3.1773070942410; Mon, 09 Mar 2026
 08:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309134630.2638181-1-bqe@google.com> <87ldg1xdo9.fsf@trenco.lwn.net>
In-Reply-To: <87ldg1xdo9.fsf@trenco.lwn.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 08:42:11 -0700
X-Gm-Features: AaiRm5118CIPDNbRTQ7etk8QlzD8w22P_KVYQ1O3uzq1vYrQVgyo0KfbrfC-gtA
Message-ID: <CAADnVQKqzM0FXv-UgeBismj8o281Lcg+dPOf9OMnLb9sy45HYw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] bpf, docs: structured overview of verifier
To: Jonathan Corbet <corbet@lwn.net>
Cc: Burak Emir <bqe@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 7:47=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> Burak Emir <bqe@google.com> writes:
>
> > This is an RFC for adding overview documentation for the BPF verifier.
> >
> > The existing verifier.rst has detail but IMHO it lacks structure and
> > background. Here is my humble proposal to make the verifier docs
> > more helpful for newcomers.
> >
> > Finding a balance between overview and detail in documentation is
> > never easy. The idea here is to describe abstract interpretation and ha=
ve
> > enough information that anyone interested can learn what is going on.
> >
> > Please let me know what you think. I used Gemini 3 to get a first draft=
,
> > which I then checked word-for-word and reworked.
>
> I only got the cover letter for the second version, so these overall
> comments are based on the first.

Jon,
don't bother.
This is a no go.

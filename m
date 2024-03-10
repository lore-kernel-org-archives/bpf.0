Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AA39FF4
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710100402; cv=none; b=GDfEn+CaE6EcZ3I+/3tEavPoEepUJuaYkmf0nm8SjGpA3/Couo/pmadQR3cAFW781djbFdobYyPJnMDlfTmdzwnXRP3Ofli74B2PTwLCeTycxK5BOzr7dDt/fSTgVGf9qIFyiX/Ho2J8di8SwQLSApkQ8lxvmqO6Siftq6rHavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710100402; c=relaxed/simple;
	bh=ydY44tXz6JT/edO1fbhIknmNYJGXk+DXVn1dwKjt0h4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IVXiYicchjLH5nCcVt2e6uxDz1Pm9YIf5bdovqTmqqr3INb5pdaKsVJE4Daz0ACGapc8Xxa2n9Hr42jnifn7g0eU77G1Tgi7PFEoPeTnvA7VQIBNW6dv8PkqFDeVeKUm6TRpOQy/Kvy5FvLWAprIYt11bl6M42QrGYCwwktCzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ANlKm86v; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ANlKm86v"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso3904708a12.2
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710100398; x=1710705198; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ydY44tXz6JT/edO1fbhIknmNYJGXk+DXVn1dwKjt0h4=;
        b=ANlKm86vXtBK0QGVVgrgcExV6cxDhGGK1my/mJn/qVDuXmWRPk7PF+/apHTp7LKpn9
         AeT7K9bPXwxXxzgUUJ1xwc6WZYznnfEXPcQPjd50g0Kg2aYoML4pJyRZgDuz5m626KTo
         p4ugdCHxiZS3aAHhWv7g+q/ByRHf+SR29ny1InIdmdFi/YcSKakvm/DvyEU2oZXeZMM2
         wfgHAtjeucKqE18Zkq/8hHSv2UOSua6wd5f386NEN++nxEf6hkNAKQ9DWdy1JPGFcOLQ
         MzqMBbNM6cdN0aL2iGNRsrciU8KV+JUV5HcDROzRR6OFVyCJMtN+Rr38LXUT3xtCKHML
         +CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710100398; x=1710705198;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydY44tXz6JT/edO1fbhIknmNYJGXk+DXVn1dwKjt0h4=;
        b=U22fcu+vPXrAmpuTwjpX6DkFrNGjtq2aWF1MKFsRXHJTR1MuR9V7wOSBJ+DUHI9gWw
         2Rr/qVnVZCw5xacm6gqr9nRVVAjt6rlTm1xa047RE5etFYTajlaXkI1Ww5LdbjXN7PDx
         MLe6zXJNVrXi+XJuOIh+KNYnbUA1UtDio2osPjkLc8Hr0v+82dDjjvgj3E+dpuIkUR7Y
         npRJ5NZaFfJXfpAupQzGbve+Z+JmnZPqNQWFjtfKaio3b8zSbIMA5WzlhQ2qeNQzg7/t
         KrEnV+T6ZFl4Dgu80Rj6f7iHdmyq3q8H8cu83YyMlUT7MSsgj8n5oHkYQWTGoGKiwgRP
         L9JQ==
X-Gm-Message-State: AOJu0Yx6kH6qkCOYgGBVE6zNQTZgqzo+QDcZDXQtWD7QpHG4iYpWDf2Z
	VZQzJDtnyk+vYAserf8Yjo127M2/PN4CjsZeD2J/ICRSkulMq/Cly+Ra+KLz69s=
X-Google-Smtp-Source: AGHT+IFMchdb4pLXwZDKIkIiUCZhEv316e8+ElevunFlO6V+p3wsJ/5rYnTOfLrLHdeM5Pp/MhyzfA==
X-Received: by 2002:a17:906:aece:b0:a45:b273:17c2 with SMTP id me14-20020a170906aece00b00a45b27317c2mr2805859ejb.2.1710100398707;
        Sun, 10 Mar 2024 12:53:18 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:8f])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00a4432543b21sm2157466ejb.198.2024.03.10.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:53:18 -0700 (PDT)
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/5] Add bpf_link support for sk_msg prog
Date: Sun, 10 Mar 2024 20:52:29 +0100
In-reply-to: <20240305202155.3890667-1-yonghong.song@linux.dev>
Message-ID: <874jddsw2b.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05, 2024 at 12:21 PM -08, Yonghong Song wrote:

[...]

> I marked the patch as RFC as not all functionality are covered
> by tests yet, e.g. update_prog(). Maybe somebody can suggest
> an existing test which I can look into.
> Or maybe some other tests need to be added as well.

Looks like we don't have prog update covered today.
That would be something to add to sockmap_basic suite.

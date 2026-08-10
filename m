Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804043990E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386957; cv=none; b=Ska3S0erqerxDelqae3S/at2cFAzDbku82FasMuqhqjaI+r6057TV+1qFJCWlr1tgqeOu7VgC4TGexXDMrSou9pwDXdQcA3piYLAleMzPMFMsupa1jb8I0xn/p3RYT32TFkK8RwoV8RHTR2Yu+kU0apENksLQUgeOnLysk5XRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386957; c=relaxed/simple;
	bh=DO3s9BCniAoxyDO1HNnd1VAYEwXmmI5rYbE75SfLv24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2hbvD8qrMrEePAuhjsao4pYo28lMkcLUELgXzpHaHzFRw0Ktp5eY6DEzx2Bczrk2378yWhfzdZAte7OngMVEzs41H8jRKb4DlRMieKyQVrv8Y1UfoXDWZwqFUEPsUhhebkIuzzHsv4nkOFMSFi9OwKzE1qIOnK1zMcLmCWQeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5T4dWwD; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5T4dWwD"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccb0e85312so14106495ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386956; x=1786991756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+o4vST46CiWorWhpB33vRXmQWSzdNOY7/3XtHUVi9yg=;
        b=b5T4dWwD5LaygCgf4bAFvOY/L/RBPVMdiR5ngNS6FejfJo1cKu4lnDzjiUp2knR+8p
         vDGPP57zZ2Y0nUbJiDc3eVzW39ValQZugD7JkIgQd/nkyOFRajTf26fUGD3P6+/dAfsT
         FnBw6RHKlFa/vlDxaP8eQRzRRxnQZemGqPLTShpFjuLnXwcYFaRNaVxQyzoxZRAajKVV
         NJxUe0Ywq7iem8A2evgChAaysds/brgnheBlqEYzecZk5SXN7qf9G2dh44cWKrfS2cpC
         sk6TudS7iPk8azU2nQp7ZqQ0/ociQfYCMkl9wNTlo3Gf4/ZZ8saw+j9qJRDhSwZT4ky8
         ys2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386956; x=1786991756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+o4vST46CiWorWhpB33vRXmQWSzdNOY7/3XtHUVi9yg=;
        b=sr/0jnp2UH8HY+YjnM0dauLuR+D7bi9iiX3+3zo1SC3HLbadQgrIO1IlblXv44cQOZ
         sLxnXCao4SW+AR7pibwk+Gukm5UoJXT2VrEf41/FmLQbApEO6Y4YTvYWHoJu6XuqqKkK
         vIDOmbW8A2DVa9MguKDLvhO8BlaAMW6A9aOwLuqwLNx2+aqXdk45vyZfs+scIvV0KjPr
         OOQpjloMfN3VTYdY0AespA86ig5t158ZM7AYhagtTlmmlO+qmvOCQSKu5uMzbNHmebCc
         tUDnLlHZtYC06GhDu2eJX65tdkaSh6rbHU0WOf1lzUCZDe5gZhbBBanNA4x7fG8189nG
         heWQ==
X-Gm-Message-State: AOJu0YxNBNF/kgpQXBxzEVbVL+JE08TtRSOGrSUXoFwAHXdmlmCoXWvA
	Ms1fAi9HtGdJQ58IxZgRMO/gPPY0mZce7A7ba8kV6LG6M+Ovq0ybVJSH
X-Gm-Gg: AR+sD13VdYgsQ4bhS/olaUQ9Xft3OWJCjB12z2cPntN3/LezuUe6CU+cWmq3V0lkumZ
	xekvRwbOq9dVVaYH+USMLALFRHDQ3Mwpi8VIU9QMbpb8Bg6jEr9Hf0fcYlX3U0+INtAEKONSpHZ
	Orivnkf50IovSC2lCOoiB6S036w7ZLzRWzaUurAc1Qe+G/N4WLQSRWdQZWO60ftNcEMCeRZFURA
	TYgDcG5ywt+rfdxk+6HqA6C0I1FN4vYKH+JwMShEk6T4Zpsapu816hw9Vs++qsJ5671uihlL3e5
	XdqbDkA6nv232YvqOgPAb7gV0wG+Z6UN0lkEtuasO8d2Eg1VwGkZ0uXZGtJdT07zQrib+hzXD1g
	xiqs5XK//rC8DFgjIiyTpFbL+a0lVB0mf3e1owimgYDhXm011lLrDz85RpPpyUbGNc9xT03Fe2/
	wgI4CDwKG7ExMbUEOc7nyf4KKp1KVWzsIsHhu96Kdh8N2BexqbgSedE0iKI42pY+Ip
X-Received: by 2002:a17:902:f70f:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2d2a8fb8adcmr279979815ad.21.1786386955834;
        Mon, 10 Aug 2026 11:35:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbea7e0sm39841335ad.53.2026.08.10.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:55 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:33 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 4/5] selftests/bpf: Test forbidden
 bpf_ksock_send() LSM attach
Message-ID: <anoZ7E4EpB6iObEy@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-5-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> The bpf_ksock_send() kfunc eventually calls security_socket_sendmsg(),
> thus creating a possible recursion if a program calling the kfunc is
> attached on that specific hook. A filter is added on the kfunc
> registration to prevent that at load time from the verifier. This test
> exercises that the verifier will reject such program on that attach
> point.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

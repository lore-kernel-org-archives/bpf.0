Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80803321DC
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976088; cv=pass; b=Pwn1fMkmqSY/WMUwwm/Zsjikuz81Ez5je33niDwUpRd67e5GuhKxXDiFDVWkn8xILqRPQIeEngMpo25ceQlNGZV4Qg6OBQLXCb40h5Q/1HSUOnuUFt512R9gHTuRGgNffYHad9b8H0VOqJtBiGmhO54LKMpExj6Td/+dpspKiAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976088; c=relaxed/simple;
	bh=peMNXhClts2EKxAQJ04j/ikn1F693v+4KYYxgb5FSI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouOUgNnIwGgtO5Dq8ztrJJfshDrQyQ+crHw3wuUwllpw6rJh888/SnS7lOMz/XE4/5Bjwub6LkvecCtzJbGj2r6uea+B6HwjlE+O1TdmuYipNoJg7lEBcbS1IyGzcEOJxqhXtIeDD07xNGc0fDGN91tRStB/g85G+AUe/YO/DrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR1JQhhN; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR1JQhhN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so44417765e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 20:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780976083; cv=none;
        d=google.com; s=arc-20240605;
        b=hCvcv2x/2KAmtHJrcbgOgp3Qnkx58TVeejtJkAeVXIobCqnOjLnvwuqNQdT98By1x7
         X7GtXlmOAF/UIlNGDnQj1QCc1e3o/awyC+OlY/YB6dNYC5xHxTmGKo5FFMROFBkkx4vL
         8R1oyRiPYnqjAKf8qvGVZ5TcIyaalRV+fiD5YxrMkFjRdKu4Q1jDyMem9fhm8GH6Aa/0
         M7zwSvoNg5XPKuec+l29/CfKkFt+rq0mHDrYLxPEGw1Bnq5RzGauZ/6tAfw9Dsw3qkSb
         2KhabjwkqCGJSjuohpvEsacHKQKiye6zf/3b/+i3Txdt6QBii+WCgaJhKh47ZLpvklxj
         FdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P0riniHcejo5tBh+3VdzpQeOVZJACbdzghRmk+ALqtY=;
        fh=dWVmEuk++z1xtGyToSo6DRO6G1qRXhboF5vE80FQ4XM=;
        b=BUWTZdzvIYPCdlKif9B2StZVoTavmAZaNHKA9MCEqDPudNx2Uuxxru7B+MhaSgqKVn
         NMzifNEN3ddipLftBU/2q0VCqSuXAp/4K3dSJnlyM56b2js+vy3QVPrroXbE7TbqV3Fo
         aMgfeUBIpdK/KQjUvEgRVIzdVi4Qp0x61zt/XLPwn5CvfYrreIV76FhZjTDjymOTnB16
         FvXVUqdYcuvD25TI2cNCLdR1ovhiQQqtvIlTFtq7ZSt6wY5iFBLKo2/Yy9JuYW0bBI2F
         vyLdrNYcyQ5J283f3MQjomflhzV4HnVxfzllw2XoPz1Hz/Qujb84+hEr1a9VGel7DUZT
         1WTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780976083; x=1781580883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0riniHcejo5tBh+3VdzpQeOVZJACbdzghRmk+ALqtY=;
        b=YR1JQhhNHxm9qsR+RYsubMRUB5wRzCI+uXr7VDnocgTvrCThyHcGf/gsTg6LhBTen0
         XTqgl9BXmlCjYdw1PHA+ppG/3AhKArUWEIEfBCoAz6M+p9X7JjzpK8qHtsOCAYWkgDuS
         d/hNy6abk7wNrZOhNo+Qo1/ARHJfDU//YNwho1wuhZkRw38XoFw9RlhNN5I3jbUKZ7er
         JWqWoTg4TP3jX9dxNhZ6eD/kloxh4PHq2wzbIEQrnJJQGMXkvuNK1VewtH8+/DH2KCN2
         Sfe0COwHIEJE8DSYCyb503wpTPWMine1Q0ynGW1V/1kvR87Wmj6TOjfdbpwQ1cBkNYtT
         o0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780976083; x=1781580883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0riniHcejo5tBh+3VdzpQeOVZJACbdzghRmk+ALqtY=;
        b=hbqj+/xPH4e3LBsIGQl1FzTzWFU7+1riApsHMGo72VBChe2whIZNOHBrWCO+xKCs0F
         ADQr9otIPzLSucPgOKu2hT4moZnqU9wV74LKVv2op1pcCHyFqXcJplaxkoF7AzjnQr8u
         e53xiNreIWV+o7foPLkXk7u+JdZ1YQ/hdJBM+gQmDLsX1OC6JH3Z3tfLyrXAZQWDtZWO
         d7SGMd7z+YcKF7BmOeOrsXAIO+MVmSNsl9Wes7ddR51/A6dFggAXYikfA3Qn0KCjSHSX
         DprtcJiou07QVuQPZvT3Mjw6kbq4zuD/e3qB/P1m13KvRFWcMKZekKOfB3/t1aMa6Jvr
         UuwQ==
X-Gm-Message-State: AOJu0YxPPJPYdpFsTUqh3JGetvhQJiIcN2SsLAqH/rhGyiGsbqziNhmk
	yX6XeRwEQZ9IBJYPPlO8I3gWucKnMAg9tl3uOoOZUQJenC6na0kcG8MRsj3Imu81qwIHnEhLozp
	HYjZfgFzcSs2vSL9+nVxt5oSFOJSztVM=
X-Gm-Gg: Acq92OEB4aYOb+GC1l92G69PJ+DYmSkHPLBi27pS3KtpGCVREFA9GHw5FMG9avxSLLL
	VCHNI7ptGkdrQmOySNWZlJRXDNTbfu7OALM5Gxxv725fLNWQE8cJI+FAw5/QuohBOiYS++KDIbO
	0FUj2rRWMP/LU7K/RL6qMkkSy+godJPJQpqDlJ8d42gcUUIxC84Rkw25gCVccjs4t68xOfPuP1B
	GlWK5+o/R0/Q9KTI0c12yoHVR/mjY2QTPLexixoD5PwzLEpJkhTG+MCUCXnYW/f/4NBkM96nFmO
	oIvf7rAHwceA/5QF4bVekHAOEldS4qRRZYNOohgogCDePWsQ+Ds/WP23iObtf9xm9TxXrkldnEv
	HTNEn+RasjCYkVYWU74RfmJqz0OtJ8ue8psCjSnpOEgwocQ==
X-Received: by 2002:a05:6000:4b01:b0:45e:739b:2750 with SMTP id
 ffacd0b85a97d-46032b82296mr24443681f8f.9.1780976082781; Mon, 08 Jun 2026
 20:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608224732.4482-1-emil@etsalapatis.com>
In-Reply-To: <20260608224732.4482-1-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jun 2026 20:34:31 -0700
X-Gm-Features: AVVi8CeEtpna6uHrGD72R5mnra3UeJgv2RLO3QCG17ynoFPymJ-LBaXlV21ZgyI
Message-ID: <CAADnVQK8iD86UoZ9fe8sRDAUBOg5oNLLaWYqkWb=iG=4eCXguw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: libarena: Avoid spurious spmc
 parallel selftest errors
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:47=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> The libarena parallel spmc selftest is nondeterministic by design.
> As a result it depends up to a point on the relative timing between the
> producer and consumer threads. This introduces the possibility for two
> kinds of spurious failures that this patch addresses.
>
> 1) Spurious timeouts. The test proceeds in phases, and threads use a
>    common counter as a barrier to avoid proceeding to the next phase
>    until all threads are ready to do so. If a thread takes too long to
>    reach the barrier, the already waiting threads may time out.
>
>    Increase the current timeout. The timeout's value is a balance
>    between the maximum amount of time spent on the test and the
>    possibility of spurious failures. Right now the timeout is too short.
>    Err on the side of caution and significantly increase it to avoid
>    spurious failures.
>
> 2) Spurious resize failures. Some selftests require the spmc queue to
>    resize itself. This in turn requires for the producer side to be
>    materially faster than the consumer side so that the queue gets full
>    enough for a resize. However, in the benchmark the spmc queue's produc=
er
>    is outnumbered 3:1. To offset it we add busy waits for consume
>    queues. However, we still see occasional failures due to the queue
>    never resizing.
>
>    Minimize the possibility for this in two ways: First, remove one of
>    the consumers. The 2 consumers still exercise the "race between
>    consumers" scenario. Second, increase the busy wait duration to
>    decrease the rate by which the consumers act on the queue.
>
>    While at it, also replace a stray invalid error value "153" with EINVA=
L.

It all makes sense, but CI doesn't think so... failing with EINVAL
on x86 and arm64.

pw-bot: cr

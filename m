Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD4287268
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527437; cv=none; b=Ik7DEms7VsZhp7kOmuHs+Fb3PU5vt7zaL354pM7g4Nx5OZ4q1LOp7tzpodckunore77seL8e/dIYYX9l0d0bftfYES88iID4/GnWTSvnuydM51X7SWJ6+Z9nBZ8tGD699NY+01rXhqq5QZiXv3sn689Z3HfRIjHqt2+RwZaJvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527437; c=relaxed/simple;
	bh=TvD9B+ifvchvpbad263Jrw3KjsKJSdEViWfDLp1Wq1E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tx40wjTEBE2JDLVfZg4f0qxk0ylROH5Snw08pXN5qWEa8rNvYoTpV9lew82CnWiVJDwtAn7pc6s9Ew+7kDHWH/4tTKa8h4XyXYi3HvgUwH1E0LmzlO9MpZWyQ4rjo+rT47S0DCAVHs1Z0goo/Ong4Su6iesBjxPdBWUATIqj6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=BDFa3Cj6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="BDFa3Cj6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so12913255ad.0
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783527435; x=1784132235; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HDc4sp0ktVL664dgCwtVdABuvl0X8XvCgcuR+gBWW5Q=;
        b=BDFa3Cj6FetIOCrTC7DndNMCUNkuRj+DluEkEgdW5ieqtS4G7D2CxkdopxFLjt8Vqp
         YpYxj49PpmAYhXuKnI2x2q3KFX6G9olKnbTMIu7ZGqMB2M8fKobUZrga7POOQ4PADhhv
         LAt2d17M+Eb6uAve0idl4zac8jyDQClShJRk5bUGIl2FGGVKBLZO8FehcNapTFVzflbb
         IuySZViikw6qUc1UX6Wge6XvXzqlet4DNSuYWEuj0cOvDILWXhIRdyRIgqT8jiZ9pxkC
         dMSR8rw7cdL0QviG7Ur/jwgPX6v5LSdo4PPvVL++Ndxu7WuQe/n5KlzaJ5iF1SNUbEuQ
         0kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527435; x=1784132235;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDc4sp0ktVL664dgCwtVdABuvl0X8XvCgcuR+gBWW5Q=;
        b=tYmDBvKQEhb7okmVoyBDe9aC9+9XFMMsJGuD1m71aJw/W9ytOBJmA+qJiPHfTSiW7d
         6UO2ZiEoe+XYEVelTn16Sb0s3ouvCROUoNp+oAadj8IBc65YCaRrjOl4ZtjBjS2+R0tB
         YLt/xQHQTxQ0Ipf5LS26FksvAfKcddxNcZ7iSKgbhOz7j0KjSGLXUJGqY+jwQhkN/Wj4
         dR9r7K7tZphSxANlGB0FaFRWpIlv9y4f1eTPDKLfR5uMSrQ9B3f3czdG5ey3yYmat7mq
         RaCFbAGD5qK+fVBs1r54nTJtq3+erb+7uyg+BmAg5YbpcDXJgDvSZ2XwILtBZYva2s0S
         poMg==
X-Gm-Message-State: AOJu0YwIJNxbzaDmZ9UbzTrxGuUrL/csfZ5shs8R7LgOiwQ/ibwr5MeO
	6b4wMRvK3NqurUKXkdvn7TYK3p6P5vNWIF8reqd2BwUrG8tpy9yCkvoQsXZ5rfpRzHZqOq8TDAh
	i9epYw60=
X-Gm-Gg: AfdE7cmDTBsLeDFJkU5FAYNF0S+jnX81kSP/laBM79g5DM8cqeXwe+ynrn+hKTTFXXv
	Y1lb/Q85d1NhkoORhpeMIMWCsuAlN2fKBrh4OH31FPb/U+UHAlbQoaeik90FLynAccY0nhS/tyi
	L6uRUOs2iDrdpNpx26iZh494j80/ulqztBRXCKXI83aqYqaA4fPdY4Fmwm2zpHFTYVVgb8Ul80I
	3BIWWKaE2W/7D7ULk6U4PYJavAkA/gXw3GQSeDCBiO0Xi3j2rHIETl7LMySHp3g6KsWVM4D5T1w
	O7qXIJm9CO98Wpf29QEMp6LvDD87rRCxwN6mZawDaK/5dRmEHKWCteJEDn25ma9hUnCr0aBhj78
	5YGDjGRLxouk4GJJPyxpQGs/eQ1SyjWppOxPjc3SlrByKciViV6w3IvpdvblnATm0tiIJiLnsWh
	BUjcFqygjaJee3Ca5ZJAm9/nPEZxgrxNftCvJAAi4rBg==
X-Received: by 2002:a17:903:19cf:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2ccea35b0edmr36153145ad.7.1783527434829;
        Wed, 08 Jul 2026 09:17:14 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm30310595ad.71.2026.07.08.09.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 09:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 12:17:13 -0400
Message-Id: <DJTBPJU8BMID.2CWWRIAJM58OY@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Mattia Meleleo"
 <mattia.meleleo@coralogix.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
 <20260708-fionread-no-verdict-v2-1-29dd293621c7@coralogix.com>
 <20260708135629.9F84F1F000E9@smtp.kernel.org>
In-Reply-To: <20260708135629.9F84F1F000E9@smtp.kernel.org>

On Wed Jul 8, 2026 at 9:56 AM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The function sk_psock_msg_inq() is now dead code and should be re=
moved.
> --
>
> --- Patch [1]: [PATCH bpf v2 1/2] bpf, sockmap: Account for receive queue=
 in FIONREAD without a verdict program ---
> commit c5a219566b06af42fd341fd941447a9a448fa4f0
> Author: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> bpf, sockmap: Account for receive queue in FIONREAD without a verdict pro=
gram
>
> This commit fixes SIOCINQ reporting for tcp_bpf_ioctl() when no verdict
> program is attached. It accounts for bytes remaining in the sk_receive_qu=
eue
> by adding tcp_inq() to the reported value.
>
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index cc0bd73f36b6d..8e905b50deadb 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, =
int *karg)
>>  		return -EINVAL;
>> =20
>>  	slow =3D lock_sock_fast(sk);
>> -	*karg =3D sk_psock_msg_inq(sk);
>
> [Severity: Low]
> Does replacing this call to sk_psock_msg_inq() leave the function as
> dead code?
>
> Looking at include/linux/skmsg.h, it appears this patch removes the only
> caller of sk_psock_msg_inq() in the tree. Should the function definition=
=20
> be removed alongside this change to clean up the unused code?

This is a nice suggestion, if we can remove the function let's do so.

>
>> +	psock =3D sk_psock_get(sk);
>> +	if (unlikely(!psock)) {
> [ ... ]


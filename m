Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DE2DC344
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464330; cv=none; b=X75kTYwFlTYzd2cSHOYoBWCbicuBirAzLbhFCB2m+d/iuwZVYiqZH0E1eZ19UFttcqcN0Fyihv/Zw0bQ1n6MBBVo5s0donyj1X73/2bzB4bdk5Y3iJcLDVcfQy/QeoT8yMBzjqTeu82jgX/SaaYa41BQS+a+KqvBkJfgnr9qjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464330; c=relaxed/simple;
	bh=w8H8VF4ay2nFrbeburyYYNENKSJcO+w6YhkDtVoSxMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCLmuV/smxeSq9zJ7hylGZ0WxHlj0duyolTWBFmXbfY3Fm6i6MTjy5uvSfU2EpCx2Ys06830nquc4QrMlAvgcTrVhzNWiO+z0OShdXG5EH4+3xB+y/sD009XQufrq0XUWR7bGT7XflLhGrhXM8Kf1zz+SPeA/pBBiwMhajNp4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ydp5yoLK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ydp5yoLK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c0115a3794bso108556066b.0
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781464328; x=1782069128; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQbr/DVUC2MJPasVAk/HJTfXKnamDXGW7esLMB8WW/M=;
        b=Ydp5yoLKUAgfhAqvsp7GVRJh0ShPQ2nKG5dhnWDBIULD5G13YZygIlKYn26RNhhPn5
         ire0ed8isgPdiq7omhcHXhkMSlNtxj7ghvPCWijfj9I1ts3MzMsDVSl1NHkuR9BbHxzD
         NYQA8enkDO/HLx+ebvsk41gO0pyJjhEbcbCvizN3miaeFZy+SxadFn9kEvuZIf1Ofj9v
         sQVd7hH1Xb+Z8CBH00XnZzEVFEeN75P2uqP9M8maEsWmzMmyd13RYC5f0XxOML1G9cWp
         F3mXcwQ8rbNzFgnExqHHZhxgEDq/JzTPQ3sYsaURv8qwcfPq9VXJumMH37Cpzj/fDLS0
         S3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464328; x=1782069128;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lQbr/DVUC2MJPasVAk/HJTfXKnamDXGW7esLMB8WW/M=;
        b=PY9BQXv3HRp860aM1+N4sUpQ5AqD7R4RZKD84EclgTC+siQNvHcijNgXlufpDNL3me
         9MdGNBhlQ1Ztb3CrlWVPDISFju9y6uG76SrK0/qKgpfs5QjxCSDOC5Jl0Z6rfbvx21fw
         E1ljVDiN5jAiOn4t9+NHTGrQpQC4oCKActIEV4IFccC+vyxJo20cgBbEGLIS6GiIDyz7
         t2J9eo0WYiZ1+Lrdr9eFNovjL+TRLeE2bBxEtJuME/8v1xRe5r6OlFUaUHYQ4zjyDb1w
         OeVG4xudArvlSTxfNifqBf2nvO557utui4BszzaqmJdCersV2D33ImOMskUA75NjYPXp
         dpNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9U9bc600cM6tCMmXR1YDp8EHH5HVsqQ6eeNW5IcbzOVOqFX7PcztaC0mYfxCP37ttqjw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cEjW0IlegdO1p06RsmoiPCqxVC+B/d4HZvtRMCDslzMEG81l
	sIFS/+ByfXeoPpvmGzHwEcaB9BKex95viuphaYpFywUu955pazm1qGuEE+sq6+WFABTuNgpRk4A
	bZP8q
X-Gm-Gg: Acq92OGfWUjLqHT3lgSBRYblJbSXgqQ0xlLMoWizoecXcULEAqvPBflBkXSBfqfzY+A
	5QbUGG8NPjoJom4ZuuYvpOIjiOJER4IeGft0U9keJ9/DxrFYuDoNZ7cmHKeJrv6L6fTjh19xGxN
	/4NAORdo7yddrD1P18i10ICdF9TVLA4aXr/7ZgQI/72TlSVr/FbaijLcZXmdYVxqFo6yeOEab6R
	pLJi49Mbgc0t/wvk5bU/gNt0dHP77qhKH5LDmFImaohezTfoX0C6yQ3c64HmoOmsmXZYYoIL2dE
	dKDAuqCyucQvyVWCAQEoehCc1K1LOcfRJc1Ae1uJ9sS7jSFS8jwF6Ye2jvJ7VwySPRAXlOO+uBf
	TZ0WbSDlSwm3+vGsDb+whwTmf3pbmMosN9Hf3cjXsKPDRSD1SkJ8izYA//8Vu+66nGrcyCrhpfG
	0qJ98M7ObRgA+NlvEygO9dntN4MA==
X-Received: by 2002:a17:906:cc58:b0:bcc:e8f:c3a8 with SMTP id a640c23a62f3a-bff4bbffc88mr220569866b.29.1781464327163;
        Sun, 14 Jun 2026 12:12:07 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01d667f63asm68108466b.19.2026.06.14.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:12:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  andrew+netdev@lunn.ch,  horms@kernel.org,  bpf@vger.kernel.org,
  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
In-Reply-To: <cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com> (Paolo Abeni's
	message of "Sun, 14 Jun 2026 10:09:15 +0200")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-2-kuba@kernel.org>
	<cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Sun, 14 Jun 2026 21:12:05 +0200
Message-ID: <87bjddc4xm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 14, 2026 at 10:09 AM +02, Paolo Abeni wrote:
> On 6/14/26 3:40 AM, Jakub Kicinski wrote:
>> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
>> Bugs which may be more or less relevant for real users but they
>> are definitely exploitable.
>> 
>> We could not find anyone actively using this integration so let's
>> reject this config. Adding a TLS socket to a sockmap was already
>> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
>> We need to reject the attempts to configure the TLS keys (rather
>> than adding the ULP itself) because checking prior to the ULP
>> installation is tricky without risking a race with sockmap getting
>> added in parallel (sockmap does not hold the socket lock).
>
> Aren't both tls_ctx_create() and sk_psock_init() under (write) the
> callback lock? Isn't that enough to avoid races?

+1, but we would have to tweak inet_csk_has_ulp() to check for
icsk_ulp_data in addition to icsk_ulp_ops. Only icsk_ulp_data is set
under sk_callback_lock.

espintcp faces the same race...



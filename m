Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B343B6C1E
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757499; cv=none; b=hesUmJ+Vk5p6HL2D7Q+WlEIqTQsPe78K6MzcDruH0+7z5PWNsoPzb0eriwcgtdOmAgl2oQmeFUaF/8k3o32BGj69HIwQybcvpG9IBDT9TE4vItLVeMg+j3ZotAquYw/Yy0+GssVlY4n1mTkHV3bu0/lpJmHQydd+tT4J4WCSPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757499; c=relaxed/simple;
	bh=QY6s7AfEenXtWFuj8Lf7D6nSgMrs3WQlj/inWWmt53o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXgPfRB3inMw51yFsSBzFXL7vJqlUomM1ADJjEG/WxODaq3eB0cuxLyhesaWUWKQT2HZn24J4mGqwyVwvmu9uVcLEHsWsu9rD6xrbyIHwEQgbZMa2Wx6lWf2mNBXRW3ykEBRlbTNO3Whr7gjYBClh8iO9oGCotdkOSXV5LOHIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KU+ZFo6w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbYMl5hk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KU+ZFo6w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbYMl5hk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778757496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COO41hKBYdHBD+YBwmNP96xVT9h6SMU1rdVHr5HzbAU=;
	b=KU+ZFo6wGluBTov5Tc8Je/owY4NQeL1YAo25AonnSYjgyqDjnLJfm6VOEgUaqrejZRTQt+
	T32EcdELbEj0K5XPqOaHtCMUpjIxagk0D3emFQPe8QyEQHIzrAc/9ScuUzGrqOl1BPhmTK
	+TpZNxdIEiH+JEWw3SviPoewpksO+UE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-ytfuqX6VPP-otL_ADv3DfA-1; Thu, 14 May 2026 07:18:15 -0400
X-MC-Unique: ytfuqX6VPP-otL_ADv3DfA-1
X-Mimecast-MFC-AGG-ID: ytfuqX6VPP-otL_ADv3DfA_1778757494
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fe3e73da6so43175e9.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778757494; x=1779362294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COO41hKBYdHBD+YBwmNP96xVT9h6SMU1rdVHr5HzbAU=;
        b=SbYMl5hkfLdNudDn2lvbSgbKw/BIXNh6GPXz04mPmgMXmCFU34E9HIVC+USF6gg0+c
         xNkGFS3ZLtkCuhmYarMNcwp1vAs/BZVzm6pqr4ERu4BQ69RzFzN3aQ/tiO04DT/OgU23
         Q1KB2VpdMKIPxyk3KNjYOt6Ben7bOOxUqzYb37TFpcTSuY+Rp6tInG6D+19wDZ+j69/c
         QsVR29gJuR5NleO5cpb4jn9hVHfElkW+08JOa7BNGZJtY3Lep0vE3gHCOlBVyfAqnjx0
         paEqHzX1KU8EK9eZmBUt19OnhmD32bxzMUL1k8hZZiW/gUN1IDTt3PHC5GCc7jbm4+O8
         NXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778757494; x=1779362294;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COO41hKBYdHBD+YBwmNP96xVT9h6SMU1rdVHr5HzbAU=;
        b=l3mThINqSbxVjHoR4xjmKkrw2JHsonaRz+Tkt7nCZ2xSQQpgxO1BRtWI2Bo9Q6i9Jr
         C0w1Ysk9lvLYKFflCtW9v0uiZ0ISL35UwqVWzUsAXyBCDR9vMsWwdQJ/jeTav25d+qKA
         m6iEZp7rCf/nm8kZbdZzAnwHrdFvoiV0Tak4hl9EdseRmC8ipzMOyKUBLsCluflaKDnJ
         0WIRkKni4326LjgQ5nWCtc8Q2MUHVW7wJuG2TyE+S1Sy4k8IHXudH+eKcCROzqBQWlfh
         7PRubUawzIORRE4gNBQsvmTI/g5mhh8+k+geJjhXyTdtqBvHW0ACMJpE7ZRUwkSxaaMm
         3frw==
X-Forwarded-Encrypted: i=1; AFNElJ+W8NlLz2Mf2csfWRT7OqmSBaHZGyPiZxzoWBCXaWgYPhyu/Ghjl5gYZcqDzzdn40KetL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO11deU5AysvwJFbNHtpcY5H0OuTHugCruIRys3aXCmPGafUWs
	flpfX6rZ1L+0hOUbc4Nh007aoW8wubQZVueDmbQ+oO1GSAovWfVg0vIUDJYw5jHG1G5fdlyyJIm
	Q91uX786eeubnlwtePjY0rV3OzQVMyWy9vxGZ5hwTaC8sf7iNKvDBCg==
X-Gm-Gg: Acq92OGfD5PvwJxdL8CPLaerwaKqeTTpG6hZQx0VVNlnLgjFb40QASvSyd+3YLkDqLe
	U2Cctsc6/bbiKL0UZb5VREXDB807JCjPI9VWTR/ErCenZZYd5j6fVq7nHo8uAnuCFH0M6LDe80H
	EkLXGXkCPg9lp7898Gl7NfHunBFVk3cSr/NAc71kvdGLYXhyWsl95DGM9aJgIlyRdI0oe/B1CD0
	5p6wKeEjN6aAlYkOcYdFdCXUXkJz/WyArIp60vb5X+Vod8AiQ7CV0BX3G1hOCCFPL6XTyaRJs/u
	hyGbvgRxFjh1JRqnV2bjNS7+Grm1ZinKJpr0MH3E09bJb3gqtgOfZ9ij4eSd1mP+XmSsmfh4bhe
	2zglobONvJ9XzPFTQIQ+BBJTwScczSPfuQQ+cdGHmDhg42PADngctmH8=
X-Received: by 2002:a05:600c:468f:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fc9a028bemr103922765e9.3.1778757494245;
        Thu, 14 May 2026 04:18:14 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fc9a028bemr103922145e9.3.1778757493719;
        Thu, 14 May 2026 04:18:13 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498cdesm71780365e9.5.2026.05.14.04.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 04:18:13 -0700 (PDT)
Message-ID: <a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
Date: Thu, 14 May 2026 13:18:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sd@queasysnail.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-5-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511174920.433155-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/26 7:49 PM, Jakub Kicinski wrote:
> As explained in commit 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
> once we call BPF there's no way for us to rollback the iter
> and copy data, since BPF may have modified the message.
> This is regardless of whether BPF set up cork or not.
> 
> Remove the attempt to roll back iter completely. This removes a UAF
> since BPF may have modified msg_pl and rec, so these pointers were
> stale.
> 
> Note that I'm entirely unsure what the expected behavior is here
> for BPF. Feels like this path must not be exercised by normal
> applications / existing deployments in the first place.
> 
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/tls/tls_sw.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 360f71fd7884..22b77840e35a 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1164,11 +1164,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  				else if (ret == -ENOMEM)
>  					goto wait_for_memory;
>  				else if (ctx->open_rec && ret == -ENOSPC) {
> -					if (msg_pl->cork_bytes) {
> -						ret = 0;
> -						goto send_end;
> -					}
> -					goto rollback_iter;
> +					ret = 0;
> +					goto send_end;

The sashiko report here looks like a pre-existing issue that could be
handled separately.

Still let me play safe and merge just the 2 first patch in the series.

In case of a repost, please fix the typo (repetition) in the cover
letter subj.

/P


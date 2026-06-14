Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B00390C8C
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424562; cv=none; b=mI+BKdsD3HkkvtGBsfNvF9z6IVRpafa+zeXBSP/E7yIrcATWb1r0g4R54r+XlTVop2oIw/yq6/SHO2j3zTcDhHIT6kGRYCKyKK1SAi5oZgguvhPALkGfGq+M78mlGNjZA6enFUFogrrTY9xPw3ddWEYIRf7OMFwZfCTuyvjHR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424562; c=relaxed/simple;
	bh=O7QCnYsmC9T7DqPOfcZPmAFSh4iJuMkXDFQ2B/VoU+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgad7FAYNc7xlCvJ69+G3PCGXiUmVklpUUrXawwxmSRzJSktgHXbyUWYJ4PbCSmWllO1fCTUfJHo5ScmJd2OHZYmgrdgSoyNLtQgVX15WJBhd9gZczPYqQlAsVkTfX1J8WT5LStQEVC2576/zj9PIlGG63mD8IUUIfjVaD3sY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6HwtYwH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SP9T8oCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6HwtYwH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SP9T8oCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781424560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gpPUZzZ8NEOkby5BaEtAw32WWn5h8dDgNhgJeg12mI=;
	b=C6HwtYwHMSarbCtPGv1svCZIaiv1W9/vd8bj/ZtCgrAGiP7FwPMeJ543qLsOEaq3nesY8L
	sKmhWRjxxJhYy5T+a9XR2crlQ19IFesVy9D453rTDfe9tyLkS1yXVh4mgVFkp2123B1GuI
	qTI2HqA4zpL2lY15ipE05++33vDMw34=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-CX8TRrDkM8CytO2ZSXaF_w-1; Sun, 14 Jun 2026 04:09:19 -0400
X-MC-Unique: CX8TRrDkM8CytO2ZSXaF_w-1
X-Mimecast-MFC-AGG-ID: CX8TRrDkM8CytO2ZSXaF_w_1781424558
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso1355339f8f.0
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781424558; x=1782029358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gpPUZzZ8NEOkby5BaEtAw32WWn5h8dDgNhgJeg12mI=;
        b=SP9T8oCWqVVVcrkAQFVsxVYjNEf89yz2Ocr5X/iqBxCvvsuBu/GoCf5ta0bgt/9mq5
         Ws7bRFUV2P1amYgjoZ3bx1Fkq8Vs4Dlx+50tnovSJN8Hn1UMQtJgyd9xy/BegRcPGD2A
         cv69napl/DsyTAzKGZad79ghBZ2drHepUQ1QqbTNV/10RSRdBgCzqjSACioRA5a/Bbz9
         KbWTDie4yNvRK/uYjOIowBRlaHfpGNEctni+PJvZITAV08Xip6IWFMB6gWWvOIH1pxMP
         uKCsnFSqIVJxS/w48BNelVog+jHiVxpEdFbft//jnfk3RYaFEpz21MilvSQa4qHNxnNZ
         y6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424558; x=1782029358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gpPUZzZ8NEOkby5BaEtAw32WWn5h8dDgNhgJeg12mI=;
        b=Nwuz29VmANePR+tDjCHnunnEXaJiJ3ksvjVQCF5aV1TGXq9FQSBSy3AMKMEZlXqq/6
         +SkgE2yraH12bdrDqvUfOaKM778mDlQmYBGti3d1sSu0Qx5KGI1y8GopM5Rtkkz+FhMt
         +j0ZMlgleYphXJq9EDRE5s1WLg/e4vOzZliyavE9rL5mqIpZoLbvSglt/jRLHyc/yPgK
         F5+uIYF950pT067w8hD6vNtLC+DYGZd4kb6Zm8Owf/5GERKNNyt+f182F4sNRnFc4xE8
         5quEGQeI2gr9OYpZfzOI3o+R+JSqbM8diJEXT/8KVYr1+a3NlzVQ6+RPFHFsFHClnb5r
         /stQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ss3xyK4G52JuRJOBNxk4f/GO6N1U7ZC3oriwBf3kGcF82HS9gGhOOEXe2ZC7rNCn+Q+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHHA2SCpJT8Vs748yCRmc515fp6YwAz7Yv0a9UZ8ezSTYv9mm
	rNum1HkSN3XqiIstx1yNtqISV0ivY6tHgtglioG3hRS/U1QSUHXVKYP94NUO+LlZ/o1+egZ0phT
	9ev6ajapwfrLhBfZnbSpCrGgOIhPYMJqoWHCiAc4J5WL3ZedRe0Np0w==
X-Gm-Gg: Acq92OEpEMSjXCqlMCFtbkok9DvF2WnCLF6Z4XCxSB52ebTYO/sjeNJ7bi1GDHb1U/y
	NGDjUl753a7S8RWGcmGl4U27iiox4GJJdVJwQPWwqEwEIi8OVfb3zxTyc+vfJLQKGcNKwVKeXQl
	y/SUAhmUoDEyk8yp0bx1ipel5Rv2TdHY9uijePpYN1h7xlyL4BRkZnr9qmRJqUpzejJk8fwnq/T
	k5mUcaJ3cJbCQnzQY51fixr9p6NbDpUDJGkIFGQsq8Uhc6FDcG+e4lvI5gpVGLk0Z+AvQadrSeL
	Aw7299fatr8zu/vQeVNpTXFNvm+eym3HE+6SfGMrZSf9OgrL8K2O4xrLGhVbCasRCwHFCfYZTWf
	prMz2+umk9uP+5yzsaBfEaC3AODff8T5O5XdrtwYNEfTZyEE9daBGBzk=
X-Received: by 2002:a05:6000:25fa:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-46074b84e56mr6664953f8f.31.1781424558007;
        Sun, 14 Jun 2026 01:09:18 -0700 (PDT)
X-Received: by 2002:a05:6000:25fa:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-46074b84e56mr6664920f8f.31.1781424557589;
        Sun, 14 Jun 2026 01:09:17 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm24168006f8f.35.2026.06.14.01.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 01:09:16 -0700 (PDT)
Message-ID: <cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com>
Date: Sun, 14 Jun 2026 10:09:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, sd@queasysnail.net
References: <20260614014102.461064-1-kuba@kernel.org>
 <20260614014102.461064-2-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260614014102.461064-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/26 3:40 AM, Jakub Kicinski wrote:
> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
> Bugs which may be more or less relevant for real users but they
> are definitely exploitable.
> 
> We could not find anyone actively using this integration so let's
> reject this config. Adding a TLS socket to a sockmap was already
> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
> We need to reject the attempts to configure the TLS keys (rather
> than adding the ULP itself) because checking prior to the ULP
> installation is tricky without risking a race with sockmap getting
> added in parallel (sockmap does not hold the socket lock).

Aren't both tls_ctx_create() and sk_psock_init() under (write) the
callback lock? Isn't that enough to avoid races?

/P


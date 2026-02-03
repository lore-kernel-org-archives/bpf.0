Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF523128D2
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123048; cv=none; b=qa/otW9NbiG8TRyII/j+UOEc7AATwHFdjbWEzZe8yCYvAuyBwPPMBjdWesPEcMSCZMg2caCozKjuJJbxu+yl6lMJP5IXRDCi947U8s6NUsCjvdeGQMvyP0pyjakrB7j5akt3bzm4i5c9YUFV+JWvU1JMrT1KNQgkR8KEk9JScYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123048; c=relaxed/simple;
	bh=8KynJT2ddnzGhgGZ8pfYEVkha/4ppnwD3PQCKPf3fF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rvwmlTtp0ZKKn4Skkd3hXA+LOHawsRflkmBIN2YxS2B+yJT7bo/vpOVghIFVStfXt6kvjMPzvjLNsaUXIj1w8jy7WwwvNhUm15TJU/UIa50YKZA+OSGWhbuWiZ0jd3raZ4vwGJpLuVoXtfLCmj+Cw7sbfRJOHJ4sLiTyCL1qR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWD9ZV64; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMxrHQHs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWD9ZV64";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMxrHQHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770123045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEWONWPgIK5PTen/Dr95JAV9SFIx8z/zmIXZPCQZI9g=;
	b=jWD9ZV64DRzRVBZ4USdiznBuxkZqhjTM/Uv5vVlmStdBCjyfci5fgckc3u42e5TIZwEOYs
	MOoFk6vvPKeFYzG+ndA5BZVCWKeZEzY7Xpq/+ZE1582RhAFvbOvQlct4qszbdYlDNpeZ0M
	KWFrBbLa0sZ9aR4QRCiFzWWk21z//Qk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-Q4mOsgkXOke1WbB8-0cF4Q-1; Tue, 03 Feb 2026 07:50:43 -0500
X-MC-Unique: Q4mOsgkXOke1WbB8-0cF4Q-1
X-Mimecast-MFC-AGG-ID: Q4mOsgkXOke1WbB8-0cF4Q_1770123042
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59e2e2f1c91so1309342e87.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 04:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770123042; x=1770727842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEWONWPgIK5PTen/Dr95JAV9SFIx8z/zmIXZPCQZI9g=;
        b=IMxrHQHsA0ZqTfNWdggKaeqWMpR6zYgedPADfwgtQDIjOM0wxzGkzaVAz1kUC6Nv7h
         2tV4fD+KxeAQY6J4zO0gp0sZ2E3KIyBY9OSi0dA9eIDDfo8qnSCa+65o/HWWXybArrPS
         jRvMPOGzV336ckA2rOarL1IYXai9ZDrQVpM/5M5KZUQQP0MKGSlQ/paIOEG4ZjVEzeAf
         qyq7Vef42Cr5QDjDfvIAAHmGzdLLoEBgQ/+S93rbJWWp6yGrHn1ZGLbl2P5bm1cgJAWz
         zi9MWKXlAv/8SKk05DVRyNDbEoMDfdjURs/LM9jZfaRSBAF5M3aib+Sz/4jVOYQt72NU
         TiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123042; x=1770727842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEWONWPgIK5PTen/Dr95JAV9SFIx8z/zmIXZPCQZI9g=;
        b=XlTfXep6v6ULJkgoQwEwbNCVOolvoqRZyUir/4M3w0RCjJgv6/7vcyfL38xK3PQEef
         U5q6lHKplQTXhnPS9GygxJB6AVs3f2u7RpJn/NO/FxQmYpqQNoIk7UxI13McR6kbvW5r
         vJfgbCGLvHc0FEE5/0H/0ssKnx9mSwRyTV3kK1Rqtw4hXeQZ6gdm46V2Ez3PsI47sAC5
         m75+SMcGh4hzK+N2YPaU5DZhJ+oX2bDskkmW1vq5dsRrFkEqrZ2lB96kXVO7Yt+tKXc1
         ifen+s+w8U7+aZHiy1qk24tnQBaFEZIndLrNEDHgdLPqWUYbGWXu5EOpIFiEfN40KRmS
         HfBg==
X-Forwarded-Encrypted: i=1; AJvYcCVj6CKNBE9WPZVSSuaexImF2P4cOuOJLagVn0omZIQ+hy4FTesFiHLWPBIO5V1Jvrw4cxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6U3c0GS3zHdYRuZ2EZT96rxY281tkZFExH8GEWkVmKF+kCZq
	PfR3QnzUnoz0+R88mX+1fYJyve2LCcp0l24ZraxYnmpUc9g1J8hJiPr/+6SMBIYTb4DvNHTBdEC
	ngjHE2yEa08VgHm2uS/+2iIgNrAF8pDabhx5vLnFMC9i1N4BhKCW2sA==
X-Gm-Gg: AZuq6aLzR4Kpcds9Mjmw+u8FaToRgNkkF0x/7OZCzPiyNpFkTVERvQL5Cw/jYqJZyjH
	Qm+rOZux21aGM9QmhSvJ1yBE4D3U3PKHTd9olHbpdSN7I1K1OEK4U4VAS1sf2DWrwFczj4UT6KW
	DactvDCsc0XjVMOKrR5yYSk/54PeT6Al2tid4gqWQ7f3tdbwlCotWx9xzkxx7slclx3P5hlFMsn
	2in859n5+D0Jj7FRmBfwAERz0gFrrwrwzSmm9yi+PQoFhqvMBa09zm0ds3O3LfoCcy3xSnjP8SI
	4qnFvT3BsxlW6LNIBFuHrqPSBZ4FFnpd+VU0uuoj8xwCclEA0LWEqQ2yMxOWKNXma7oipDH3AbV
	+bKlgu4ajul4=
X-Received: by 2002:a05:6512:3f21:b0:59e:429:932a with SMTP id 2adb3069b0e04-59e163f573fmr4674343e87.1.1770123041879;
        Tue, 03 Feb 2026 04:50:41 -0800 (PST)
X-Received: by 2002:a05:6512:3f21:b0:59e:429:932a with SMTP id 2adb3069b0e04-59e163f573fmr4674323e87.1.1770123041407;
        Tue, 03 Feb 2026 04:50:41 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e0751bb68sm4024086e87.8.2026.02.03.04.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:50:40 -0800 (PST)
Message-ID: <7df9baf9-040f-41ae-b292-f3155842b5f4@redhat.com>
Date: Tue, 3 Feb 2026 13:50:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 net-next 00/15] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 11:25 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v13 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Beside the just shared feedback, the AI reported a bunch of other stuff
that are not relevant:
- fixes tags, IMHO not needed since the touched features were just
partially implemented before
- uapi breakage, already ruled out as irrelevant since the iproute bits
are not there yet
- pktdrill syntax, which is a little inconsistent but AFAICS correct.

I'm not sure about the BIT() macro usage in uAPI, which is already a
thing in many uAPI exposed headers, but does not look correct. I guess
it could be handled with a follow-up, if needed.

So the only feedback the could really require a new revision is WRT ECN
flags handling on retransmission - and I'm not 110% it needs a new
revision: please double check it.

Thanks,

Paolo


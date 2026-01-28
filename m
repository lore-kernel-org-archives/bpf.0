Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D430BB81
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586258; cv=none; b=DM9NpORlzyQZM0eXjNdLzFIH1ptKIWtUsc8Q1G/mBCT7zwJe/8nyB0OCSF6/Y9SH2tS2yZdhAwqXasOyu0dyky1/4RM74X5Y4IelMtcEuGl9Vobf0wRmV32eGVVsSIfLkvRmoW+TyQUnmtbPG22NWDojUQhbfLJCBI0pRrahDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586258; c=relaxed/simple;
	bh=1sqaxyg9uUfww2vS/d6/pDwRt5NvTGwpHUEkBH22Jkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psljwDfs7D5pu6kPJDYvCJiRpq73+Fk/jm//VT7b/FJjZpgXxEVNnAg3ZWiU4HkuXWli7/hDk2TefUKOxdtEZntCo0rJAigCLpB1KDf1gTUbPN7o/AIh/bwfECozBuhnIzuDlESI9xIbda7CK95m1cmqNXPcriK0IGCXAuMHBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=El/IZcUt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gt+bxbDh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El/IZcUt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt+bxbDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769586256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2r8/rRraCmZGhd+qX9Y3lCkPKausqhtTQk0k54UGaw=;
	b=El/IZcUtD91Bl1jAyhnfs1beUMx2BFkZSdEqGlfrJd/1tPzbprbzI021VMrNAcjQg2UX37
	64Qx1vYIceGOyYqaJJI1hYBEYw8APwFo3x853wwATJm/0nF1dNpZCf9KTlYqpjHt+7MwwX
	orl91IOhSMk1ZBH/p4EgdL3r7zlGdWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-_Nu19FM-N-m2UvORolWUWg-1; Wed, 28 Jan 2026 02:44:14 -0500
X-MC-Unique: _Nu19FM-N-m2UvORolWUWg-1
X-Mimecast-MFC-AGG-ID: _Nu19FM-N-m2UvORolWUWg_1769586254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806cb47edaso4452825e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769586253; x=1770191053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2r8/rRraCmZGhd+qX9Y3lCkPKausqhtTQk0k54UGaw=;
        b=gt+bxbDh5U2i8qh8qd5iT8lTAuLyg1777UtIw/jUElitPWiQV7XztvS7FqeBz8tc1H
         B26eYiAYsC753cKcSNkTD3fPVbeVyto2evz5ubqqnaxkl0/MHlL85QJU3jqMsgDEUZCc
         q0BbCqHDW/p6b8d0EhxKRJdW7xP6RSIeevn5B1oZcqyNj4VK6aI+/DkMnS41NRPnnEN/
         oOjO5aQIkJmMNFDseo6TfMoH2c+Wlp/qyRrgl7ZgoGU4B7IAZAvoCra+Z2APo4f7Xk70
         QkwcgSLOr+NSIOK5oVBtG05OJAFAQLJVm2h51sNt1IjLaPrYYBROCq/ajQMCObLPVCdz
         JFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769586253; x=1770191053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2r8/rRraCmZGhd+qX9Y3lCkPKausqhtTQk0k54UGaw=;
        b=VD7OXny7gY2U32s4jr6Cb97lANJFN4n1joS5/APSrayla33W/305SUBXXRacEcXhos
         dZu+f9tGY0Gm639V9JtsXLumQ2ZAzK0mhHHgRQqmmWaRaYYXVJVn/YG2jKmhaG/t/Xat
         s8v1BE6O+AS8ZgwOUGPYKx12RqZ131FiFTOHmDWjBuCtaZg015RvugBFkGPegYXJDp/f
         LLOSPu4FQq4Nn09tTVyuukU3EAH37hi9JHCyXu8RXqHED9roeBpx4IcpXUmFjTKncNvm
         1t+sRR7H15trU43AZ5hn0H/YEBxW4LfFcA0F/BsykA9c2r6+g7Lmeyc58E0gqK9E/F2G
         qi1w==
X-Forwarded-Encrypted: i=1; AJvYcCXrVeuJ2E7TVImop7p2mcpyqJvDIho7qN2Nl/YwJMUjri0U1pQUXT8turXxOj1vBd9ejv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AxURDF7SYC/3+xQ8qSZ9mAbtKDTqYSNyw2BzGE8fwUimGOPF
	VAyRE4NR13b71Xd6Ouhe9UOwee8oiHx3mur/Kj19x/4cfYuIZYpvDC5wHqKKIUPyBWSdUb9CIc0
	HJ3YaCuDcy3l598Z7/mQlarwoBHxN3I7l7OgMKV21eqOmZS+ysi40Aw==
X-Gm-Gg: AZuq6aJjouCW02EGbFNlE3Z3iA2DMxfCThoqSHfHDfKSzEd0P/nuOMl8CHIgA16wfv0
	Vaz11B062gQZ80zlUlcetBOstlEV8TpZS5pzVIwtmDmUiJrjpyqa6bAaoJK1BoSY6KHWqGgSTia
	VlAMHjxDu7393P5I4f4KmE+wtlbg8mMTDtRf0AFutTJAbbk/nGD97dyVSgTQ57TjQ3vTkeFr8T+
	klkluMmqhtgr1LMrcXNh3qoUJ2eRFxfVQyMYVhFGeBtESp4uKeGCDE5lJ8RkwHnjXPhK8EncAS3
	u6AO6/w3ooZShjIFevypyGb+zZGzcL+Xo8Cg49QIGfV/FeWU6WxUUq90fb20WyK4JD7FtVfBBt9
	gTAoTXpNPK2Jk
X-Received: by 2002:a05:600c:5742:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-48069e24623mr37363635e9.5.1769586253606;
        Tue, 27 Jan 2026 23:44:13 -0800 (PST)
X-Received: by 2002:a05:600c:5742:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-48069e24623mr37363235e9.5.1769586253131;
        Tue, 27 Jan 2026 23:44:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c428basm116931625e9.12.2026.01.27.23.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 23:44:12 -0800 (PST)
Message-ID: <13f7664e-af7e-4c78-ba0c-b58b3ab59075@redhat.com>
Date: Wed, 28 Jan 2026 08:44:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: Jakub Kicinski <kuba@kernel.org>, chia-yu.chang@nokia-bell-labs.com
Cc: edumazet@google.com, parav@nvidia.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
 <20260123100721.42451-11-chia-yu.chang@nokia-bell-labs.com>
 <20260127120957.76e52cc5@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260127120957.76e52cc5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/26 9:09 PM, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 11:07:16 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
>> Based on specification:
>>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>>
>> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
>> AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
>> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
>> with (AE,CWR,ECE) = (0,0,0) during the handshake.
>>
>> In addition, a host in AccECN mode that is feeding back the IP-ECN
>> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
>> latest valid SYN or acceptable SYN/ACK to arrive.
> 
> FWIW this series is marked as Changes Requested in patchwork. 
> I don't think I did that, IDK why it's in that state :S

I was me. I went over the AI feedback and it looked legit and relevant
to me: AFAICS the listener socket status is wrongly updated instead of
the request socket and likely corrupted.

I was sure I sent the feedback email before updating the series status,
but I see it did not land anywhere - PEBKAC here, I'm sorry.

/P


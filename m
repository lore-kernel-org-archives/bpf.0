Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738473F4105
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652200; cv=none; b=APDn1qL8a1aJ19QoG3c65d7ne31IreUYZCPQBHcNeMSXumD7RR+ZOtpG0HffjFNMOcsNiLe5jdKuDoT1k79If/gwOk/HjkAtR5b8nw/BpN8aWn/R7bTi5nzNJbproylPrR7HaWcJ+m2L8XtOvhJwb4/xxnpYgmZ05MBDm+U1jJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652200; c=relaxed/simple;
	bh=uhN4fxJ15enqo3k8CkDLZlRghvRaPv3HpnOP6VDNWkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teEEnmMNuAjOkWQQhH7cl6E4cM+Bv7SSMVSrvSHSa46LM+LmLjeo/7ZTJ4oMJ3YZOPIdd6iI26Fslz6xWgwvg8teYus8D9QjlXjx6MZF1JvVcNPJcjngIcHSdnWKaDK398rFgYxddgVUppPIQsw/IftuizkHNb81N5iSFWMlmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPkb/I3Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL0L4TEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPkb/I3Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL0L4TEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787652198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
	b=JPkb/I3Z3elXoDr9ZQRAplXoQfbV3dRgq6vZ+ZY/bIaZJbXer8Fb5JWyaY+0DjLofahUbW
	iBh3+fTsecz9QinrIOtrvlgQtdEnhhMZYOQ2Uch+d9U2iftO/IlF8OSOwBOS3LBOiIyOPt
	QM6h1XEMbGF2JvhsiRoIaPIGqnI2s50=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-RHAMlbLMOhuHSKkyK-mkNQ-1; Tue, 25 Aug 2026 06:03:17 -0400
X-MC-Unique: RHAMlbLMOhuHSKkyK-mkNQ-1
X-Mimecast-MFC-AGG-ID: RHAMlbLMOhuHSKkyK-mkNQ_1787652196
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c217f249fa1so488605066b.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787652196; x=1788256996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
        b=FL0L4TEwZPqy4XIQGN+cT+RT6R1kvMehXCRUH+tSyz0+a+iJHy6HGK7Bl+0aemusqQ
         U+HXqyuQ961m79bJu4KxkODXKz3Qu6FVQWU3H7zeuMyjBW5vYoCBjgXkazHiL2eP/ZNB
         zhVn7+PA0q4aqrQ6wskhgzGRsFXUA1Ds2jPR8MU+AJ4q+b+iTHw7Tz0Ly7Wq2Zixhf/s
         2yrsztm/IBKuGydIMie/mWwta0YhyLMh+l+qrd7PRKuUKDuoPe7+LIlzvXnVLyD+VGaF
         SUb7OjfyTBInEgYChYh4a0ORvBFFniX5K0p48+fj9JDyY/08TOKSpngw7ir7pWRM4RBC
         xMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652196; x=1788256996;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
        b=LAi8+2Odpgz7BBeho4zf8gSNL9Mzmu3+cUkdqiCE1iU2nfbyZncQ2JeSFKuqNUHBGk
         oNZ+a49gD5+PL9J+APKPoSlRszWiPKE8OfR2aJDshwY5F4fKyqjDbBDu3MUXG/Ilan+k
         T4iQ5dmh3JLcQipH/dWPCn6jdw4h+eghAbEKHwOdmE1GOBBRdMjkMmimltrw/m9oufXL
         zMcbZBHG3XZO0SFlxdhb7pi8pgANjaS4ISNcqWb+aMrzQ8paTLHkkxvLT3Rsj8bU9ZNR
         jlMnz6aEesDkt2WJ0IFPbALS3rpfyNbMsSUXEmQBAsJY1uBXQHDM1L3fhi6qKC/Reu8L
         SFQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4I5RcTqdAsqBW7qqG9b9VTWF0/RR5pEmR+ttiQOnqnocD+l5OceWCStCLXVJ6wiabcYw=@vger.kernel.org
X-Gm-Message-State: AFuF++kdakv1h5jbl+z3IJ63LPFPk84/0xnz5uzwPBZoeJrKsNiWXXmo
	UVVH/5w12s7l7L3g/E8zn4WzPezvXqL8abe0DG005+1SRWZLGeRzMbym2BsK0unG+2d4qvpda+b
	E+XztUUJgkR6bv3NBYlR1s6yOHTNeGbSSJM1cxYHXOrjcHFy9fEUDsw==
X-Gm-Gg: AR+sD13Ydqd0VIBsybb+0Ojyrp72V98p8YbOzpQd0SV6lUNuwY247V/CdPGpmKgLh5H
	JwUxos/nq1zyrkKu1SQwfs5qXDeKEkgT6xudvAFvbr/raA146qXAMaB6Pqr7adPNGqTpqkxfzma
	AiJC0HT9hc0i4jdTJ9wlyy92Z+4r0vEdQlmcuBTUEjqNLRyn+fvHAZWOtEB0hTDzyhqp9aB8WVH
	UEDkQ8eYwXzNwn8F0NU2xXtLqT9tQdKF9Mgt5Qm1i0CyM3JZdVnGc4FDz0z/97W4GhWz3ZnTEM/
	09E5OHiZl6grby5Q9SMGNkbKeKFwPBMz+tU6dthbbgMjpQAfj5dJcay5l/xAcHVYeVrAIwzJljP
	pJ0Up8mDnhmx5c0b9p3Ogq79RRhV3r1UtUCjdwK5H6xpT8E2aokXviuE/VK0e5JiosgNiGFB+
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2757839166b.6.1787652195917;
        Tue, 25 Aug 2026 03:03:15 -0700 (PDT)
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2757831066b.6.1787652195293;
        Tue, 25 Aug 2026 03:03:15 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1843812966b.5.2026.08.25.03.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:03:13 -0700 (PDT)
Message-ID: <478bf88c-cb76-416d-831a-5fa7856d65ce@redhat.com>
Date: Tue, 25 Aug 2026 12:03:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
 <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 4:21 PM, Hamza Mahfooz wrote:
> On Mon, Aug 24, 2026 at 12:39:06PM +0530, Muhammad Falak R Wani wrote:
>> mana_bpf() declares an uninitialized 'ret' and falls through to a
>> trailing 'return ret;' after a switch statement whose every case
>> (XDP_SETUP_PROG and default) already returns unconditionally. This
>> statement is therefore unreachable dead code left over from an
>> earlier refactor, and it would return an uninitialized value if it
>> were ever reached.
>>
>> Drop the unused variable and the unreachable return.
>>
>> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> 
> Fixes: ed5356b53f07 ("net: mana: Add XDP support")
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Please note that the current guidance is no fixes tag for net-next changes.

Also this specific change does not address any real issue, it's just
code cleanup.

/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C03F44CD
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652056; cv=none; b=T5rN1gFs0W1tQKjGfLmqXDhAGp/d9tCG5IbcKPRu7aCpGwcHLJ0jOsnQ0KJ2IWClaZdR28sJH2zMq5PqNpAr5EeZLusW8kmL7/QF35kbYgq5aMGh9+ftpb14+8sX9MkcNflAFoh3ZhhnoTK65Z0gwnsnSMcBiV06gGC646CSauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652056; c=relaxed/simple;
	bh=MTeY5Wj2A537PcAl8w2zs34Vdv6IeLJI4cMm7fLYNhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PURgAAM+AoDipkJ672nC09qC1488oV1tFPqiEpPiMQknFU42pz5WsQV6a+NA3gd8OkCSasqv392YsllszEqNt8q8pH87fs58oEhxd+a/u6n/zcNjM9/wtjYw/5BL+enH1BpybU9jF6rnERoxiRWJLFXNlJAQMbeHNtW0GkunQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baN1nOr4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jpDbvSZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baN1nOr4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jpDbvSZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787652054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
	b=baN1nOr4qZ3HusoYOnvtLBvQd1S3H0ksqozBXNRHQArpl9FvPhwU/bhtL8dzDb/5S44U/U
	cti7Vt58HGG9wYlisR+aQXx1To/WcHDB7aIqEWMxdHfXpSnUjevDj6TooFbCbSO2SYqGEQ
	vtdLUNaQdwsTMgzm+SufqENAAOJB7n8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-y_sBrkM6Pvmufxvt4_XvKA-1; Tue, 25 Aug 2026 06:00:51 -0400
X-MC-Unique: y_sBrkM6Pvmufxvt4_XvKA-1
X-Mimecast-MFC-AGG-ID: y_sBrkM6Pvmufxvt4_XvKA_1787652051
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15e6109f9aso404251766b.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787652050; x=1788256850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
        b=jpDbvSZJafXI0K7ZW6wh2uqWZM2JcXYZHv2oS7p1MqIoZW2rAfHkzBHNvEwh6wFiL4
         VEMouzJ+Oc2xnH4qMtAnpJ4ce5ml2HdB1PBIT3rh7tuzN10vzmPgDaaHTXD7pYK9uXke
         +AUOx88WEka+8bJSfRJQJSR0ig5aMjpipCJ8A211mnnsUWSNAoazB+1rmDaJzVsKcgMg
         JwvnXG/2boI2u/AvipoPgVfVtAH22qMNNEQw7p1Bh5C2cyPtBx3csKiptkXegVeRWCzv
         m44r38JLbwb7VlZbqrUqr3RQNE3O1Y1VRvmagpb0euenzOsEnrojHwFJUTM99Qm8e7E6
         8ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652050; x=1788256850;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
        b=Wc+X/VwlhWInseYGA9wt15e6+Wqgv8BrEpkCoc1/BVkdxlf8lxE/vSgK/CdXW0QYj0
         wXWHeTlyNUREdVOwL6gqf2jfHw0jhUvTkQPmvuH2WaiRgcVa4wFBwxakeo8/+EI6W5rj
         NzZQIHeEMwO7Rz0KnuTHQduW/W40mrMM/NTGBUe1MudpmP1efhdp+ZKi9tW313zswn0t
         CJmTQRtPnSnsvl7inLZz0RjIIAeOG/C8c93Omf242XDMbHdYAe19l4kztWVaRWha+epY
         /DyYTmkVtKMphLoqquduYJbrBwuKe6trZHedg1SOYZLE8eM93b/Xkv296f+NtgqSfYCu
         zx4w==
X-Forwarded-Encrypted: i=1; AHgh+Rrk8M/TG760bJhonQxmT1pMgagmryrdxYq/2BDhn/LmbgnbiXG8oyKW8wddDNJAICxrzJA=@vger.kernel.org
X-Gm-Message-State: AFuF++nGC1htQ5KO3GLHMRW1qH7I6T9baPPJDx0yomN8xiCzqBCB1a4f
	gfcSBE1C1irmOfPGiOIuxWCA1P5ztbmQvvilhDZYIKOsYeJcergaabq1auZTykPVZiWJp1bKa3F
	sM6EgwSh472Fa4pPYFfYBwIevEcN2anKpSenDpI6w9S4PqrSUlge4SQ==
X-Gm-Gg: AR+sD10tVL7f7If2AljmDOIQuZ3xegT/aqUpUvZvnhvLlHzFdkyN6wupkzGWDZRVfTc
	fsI6feVDtWbtWY1XNXNHQHNrsP3l2ZkEvZRM3he/pNVB+XzMgwpPtyLgVMrFiHOlN1TaIQiy631
	VeDmuUVTUAnT42OtwQ2dM4YnnZQ/uskImEUU23TADQwwH7Y/3loajehPV00Fk0AJL9uRWPUxulU
	14RJ4bY+ZlK4Y/9D2cgsFudkoLdhodCbBk6W0HE97XcWdj9uepIJ50ZxDt9sswHi0VFrzg7H4Ov
	AR/+1hOYF1K4uOxQiCTEIF4YKTGTYjVRO/+wGXbBbSDmeAufOS7kOAVep9WuqYsCgeTm36fN2Hh
	VZ2ksfrJL7z9q884DmUDKT9KB+V2wgGdmbnwCMn5cSFwNffrWEnY6qxqc5rQ0uyUEPl886ukD
X-Received: by 2002:a17:907:72c3:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c249238c382mr2862368466b.2.1787652049085;
        Tue, 25 Aug 2026 03:00:49 -0700 (PDT)
X-Received: by 2002:a17:907:72c3:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c249238c382mr2862359166b.2.1787652048499;
        Tue, 25 Aug 2026 03:00:48 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1842658666b.5.2026.08.25.03.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:00:46 -0700 (PDT)
Message-ID: <d595961e-0d7f-4fe8-a483-f2fb7ca7111a@redhat.com>
Date: Tue, 25 Aug 2026 12:00:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
To: Muhammad Falak R Wani <falakreyaz@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 9:09 AM, Muhammad Falak R Wani wrote:
> mana_bpf() declares an uninitialized 'ret' and falls through to a
> trailing 'return ret;' after a switch statement whose every case
> (XDP_SETUP_PROG and default) already returns unconditionally. This
> statement is therefore unreachable dead code left over from an
> earlier refactor, and it would return an uninitialized value if it
> were ever reached.
> 
> Drop the unused variable and the unreachable return.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed




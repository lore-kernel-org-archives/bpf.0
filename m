Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD5A20
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571343; cv=none; b=OE1hEHo0TMXmiB0RxkC3m4WU40Aedg/pDgmisLNqTDMAt82W59yGQsvlxgfinTd3Uu/c0XLrGbgcGsvIW5McKAyP0LUVRyBJKIhpOGOdvgP/9/cP4BDNqlhe5TCG7ufQTvbdnVHpOZNVgdxzzBLduw2gonot3PiVG2C6W1bg+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571343; c=relaxed/simple;
	bh=ZPvT18oaK8tanM3JbEc7UpyGANibhSBhzrriVjRSkJA=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=ZfbyjYjVkhXQoH3WPVwx9wsfkK0bi/2JKQl2PrIRSlgDc3NRRSCiA2xAjOrFO//d5KYVqC2IpwGifmoJ8wOss70WZdOr5g/Z4vQ2N/NpVLCsIb6PfQYnjp6nAx5JL/6adgZqhWA30kLMyf3PvH5diavqadCbTBLHlPQnykXWHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Q8YppzlT; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=k9hwiVjS reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hMVIlyL5 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Q8YppzlT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="k9hwiVjS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hMVIlyL5"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 32FECC180B57
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709570748; bh=ZPvT18oaK8tanM3JbEc7UpyGANibhSBhzrriVjRSkJA=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q8YppzlTkKNQNornSAg2Q01Br6BvtMi8n41TpNcWSx+gbt83oMMBRewQCBoNIpSQE
	 wpBs+3J7TUm70cJT5bWciXg9mVZ80cqkgH9+KWjZKRXxTdrjF2sNQwh/wAN1IlP2Wp
	 Y4q56jAgSTtu/mSQoGCYkoLrmJtT00AN+QFRcl1Q=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0D8A1C13AE23;
 Mon,  4 Mar 2024 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1709570748; bh=ZPvT18oaK8tanM3JbEc7UpyGANibhSBhzrriVjRSkJA=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=k9hwiVjSUOoIfMveax1/jDlTFE6OAwBB5nLIy21eezp1z42ERlijI+c5Bv0ahbMeM
 2oifgncNaShWrjWOU3aLzIN4Cp2P/KXKj0DrZzZxAumlwCL4+ip6IlA4c+gtIDYVtI
 ibACXwOXNfCYzcyQ/a2AuZMoT2B9CuVE2WRIBIsw=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 38D24C13AE23
 for <bpf@ietfa.amsl.com>; Mon,  4 Mar 2024 08:45:46 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oiq1s730FIbE for <bpf@ietfa.amsl.com>;
 Mon,  4 Mar 2024 08:45:42 -0800 (PST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6AFC3C151070
 for <bpf@ietf.org>; Mon,  4 Mar 2024 08:45:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso42084655ad.1
 for <bpf@ietf.org>; Mon, 04 Mar 2024 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1709570741; x=1710175541; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AY/5+NRl0HgmzZtWxTsevOYhftjaeTdyYmJie74+MAI=;
 b=hMVIlyL568feA6pL3v+C+4dlw4QqLCENdW2FGcDgtS5QhPEDoplNMIjwB49+jPwgin
 dFqtY9l/+heElen7DHV1D9WVyulYWNEc7SmzvwPtAVDQwlIJj+SV3kKfEc9CtZaJNPjA
 4sU9v7gbFi6VJ2XmWPmYUgKnc4MW30uvHIDwlKoqKcjMqCf5cvGDGMrke/3mu8PRrNle
 noo+zBQmZ88NPAHDVWRpLjvvMMm3EYZAMXpw5GuTlGuUH/vRfIo/e/YskSApEU1GQJ7S
 OfOXS+excCaSE0LW0IhHUN/5U7iPQC8Pqa5aQ9aW2T2P3vgamc1FUD0W6fm98HOFxpCw
 aI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709570741; x=1710175541;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AY/5+NRl0HgmzZtWxTsevOYhftjaeTdyYmJie74+MAI=;
 b=vAlf9Hkn5eJ+Owuf7xjFCsWN3UMmdVR8NkY5bFZxPHkuseMBx6HgJ0cUj7BFhPrEOG
 U6NfAIjb1nU95D6qcEGPBOjR4ltaXPask2gyTwNScodNmXtWy3QON45djKp8kZYQ0XSu
 60ynth7P0SNXvj279AUaO3CLfu1wFkirgsVOAKuPmbkRMa23iR7jB6th5zhtTB7V0Nwx
 en0x1VPgwsHz2CLDQdO9ESoSwJrJxGYlCVvXKG6HhMzwiLknR2p1owr2S6mHC1ilfz/1
 BnkO9c/mZy/dj/Z9au8pFp4X2WbjvGybovjmWpXepw0lx3+hVM57hTOzOS0N24hV3KMv
 XRaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5mSpYcPsEGIvn4fU/jmAjv3XMbcVnSyX86sqySXwUt55c8khglXg6bKlc9a6e7dmFFX+SE2cVVHt/SaQ=
X-Gm-Message-State: AOJu0YzxJcqOMEXZr5d9l4j8g0NS5e7r6n/jTf/7DSBbbHjz+rbCR4Gn
 90Sn++HCQwdxk0NAPyjnTDzYFTEZlnzdhcH4Vk9DxUcw1Z8Wd7KG
X-Google-Smtp-Source: AGHT+IFwawskSsv6Jh5u8pbNybwWMPTyi+5u1PnxadDvQasybSWmSwyhOTU/vbjAZzY4sNJxTo1wZA==
X-Received: by 2002:a17:902:ec90:b0:1dd:911:19b1 with SMTP id
 x16-20020a170902ec9000b001dd091119b1mr6811682plg.19.1709570741457; 
 Mon, 04 Mar 2024 08:45:41 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 y6-20020a17090322c600b001dcb063349csm8742837plg.150.2024.03.04.08.45.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Mar 2024 08:45:41 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@kernel.org>,
 <memxor@gmail.com>, <eddyz87@gmail.com>, <john.fastabend@gmail.com>,
 <kernel-team@fb.com>, <bpf@ietf.org>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 08:45:38 -0800
Message-ID: <270f01da6e53$63e93620$2bbba260$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrhzy5buaETn6lYveEMKT6QgkFX7CFl/Dg
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/_GbRagNk6oMjdobSwSCPZy_If3o>
Subject: Re: [Bpf] [PATCH v4 bpf-next 0/4] bpf: Introduce may_goto and
 cond_break
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org
Message-ID: <20240304164538.GGqddTnXdkAF0LC9vt4zfOS_O4-vWNWmVSqaU_KQ-8s@z>

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
[...]
> Alexei Starovoitov (4):
>   bpf: Introduce may_goto instruction
>   bpf: Recognize that two registers are safe when their ranges match
>   bpf: Add cond_break macro
>   selftests/bpf: Test may_goto
> 
>  include/linux/bpf_verifier.h                  |   2 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/core.c                             |   1 +
>  kernel/bpf/disasm.c                           |   3 +
>  kernel/bpf/verifier.c                         | 280 +++++++++++++-----
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../testing/selftests/bpf/bpf_experimental.h  |  12 +
> .../bpf/progs/verifier_iterating_callbacks.c  | 103 ++++++-
>  9 files changed, 330 insertions(+), 74 deletions(-)

Don't we also need to add may_goto to instruction-set.rst?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

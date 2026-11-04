Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777712;
	b=Q73PnV1rsEmG5wSLNTp34Iy5Fu5N9LSUXfLQSoLVeUfeNHBKzU9ZXEm+5/am3vjII78m
	 HAYOD2oRujsYX9M1q0xe52/knZiVStr5CqvIHCo3+Q+wLv4XFQSDFbstgALtGf26vAgL2
	 Sjb1cYfjt1wD8nwzzi81D4pgj1L5/FLkcdxFvGAjZwk2IUmzQSMMWLmxHvzHf0GaqT8EO
	 IIFIWHyABiEDB0PGWYV2Y9UJb3z964XEJHyRLKjV/cpZWjDQ8NT+UBhsrURotFYnD9shF
	 P8WJx26EEXA4C/jO/VJP1xuI1/JriefKj3IWeKsHzO2kTs/87kCs2vmkiRgoM9QHpBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=YLt+7gtm6HFRNk7/IXQFeog/UBBpp1X5A8X1cIYizqI=;
	b=VEXXVZqyx9frJz3Mkd9N9J0NdeEed/xD1/GcSF6WU7rkoMYkvVLjEv0QdtSnAFzUv2l1
	 dia9Qr/1YG15lweV0ydGU7IFSF+2xxwzrbz1wyLdMNdpa639r1czZWqAnkeEM8O8DRbGj
	 yM/rScsb5aE4xh0GppPbtrNgznJ2jSSzgy1q9J1tbNUVFC59MhNMzfoWKRdTBAg+TV1vO
	 lEAy4qnSwrljPOtfUUtrYj9ex4OhKV63scUwSZHTycPwV32Sb50mm8prQxYcdu4yt+qpH
	 VFOImEMal5GmNdCwqFTk/TQPXoB4F26LgebJysT7/aUZye9L3FrHwSnkldTF/M4kMXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkFAXWTS;
	arc=none smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAA606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 07:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BAA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkFAXWTS
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70d59eb7so67416d50.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 23:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777711; x=1794382511; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YLt+7gtm6HFRNk7/IXQFeog/UBBpp1X5A8X1cIYizqI=;
        b=hkFAXWTSAEe+hIRn1E48zuZFWYN5az3gE+OI46y3wtvDwZmt6UpW0rmYuObaZrohPd
         fggNX08gbO8F6od75ZK8uvZ6Watz/urRwbVuy3VqQNzsuKyAINCduiHRaVCDrzlmLAo3
         I4deaqKbHHXtd0b3uZBz/VGr2vlWpurOtW25AEXI0eY6ww8dJLPgd+BD73pcz9tacw8K
         Uq5ZFe3KBdmH/hJ77t55CXnGWDZUdOF4hfj2bQHKASCdCQxkDNEbsWiC7QM0+xlJ7GWl
         C/CDygBNo8VOHcmLZK1QMx0MV3NcsAGj/Aho+blC2sD7W1C0QV3fQnZPdxdH4RcHkge7
         iDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777711; x=1794382511;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLt+7gtm6HFRNk7/IXQFeog/UBBpp1X5A8X1cIYizqI=;
        b=PsGoLk8AilmlFbdEj7UTP7ofCMROLDCZpFSrhYtSsWxw5iOyDaEcq7rT2lfmjdxhQS
         70T3FP7mmIsPLDujfTggmsoksX1xUVBsqvJZRrPZ+5KZEnVb3p0T3JV9W4dyHlQ/yh93
         kM2DV+hTUfgcFWALtIa5rPYjoRsAzhyKd/4KPRb8MDTUVIDgQK0ekNB9CrwyZhexQ+bt
         m3PgVIVuIgs8mceUG2Xl6THzTJa4rfZf/TajMJHh3Na+/4kIvQ7e6uAJDoZaWCL1ETDv
         pp4v/XLNRI5L6680E7Vr46VJKam9Q8SqhSGyHWpwIz4BNHTdfV6Poth0FV8Q9Th1VI6f
         Cpbw==
X-Forwarded-Encrypted: i=1; AKwUvByJy10lFM8D9jhkqPfiDsKX1w5AB9lbVFlJ2x0e/Q6r+efpiolHnrSLNIXqdU7D6LDKQIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BiA29B929ad5dQTivogUmSGHshZGRG0lBPFrGcM93o42aYYSd
	346g6NF2WWN/uD1iS6sCWpw+3qCD9BLJs7/g8tRNkoR6+pwAsqO0x5uFBzZScyi8UqU=
X-Gm-Gg: AYBFou3ZcJIgHFWpfMP/B2fDLhs/c7O9cDO70CJwOGkDuC1oe6aYBDIX4566kDqJUO0
	sonTA+aU7h2dOjqky4ypEGQ2JzslbU3Sg5kc4+t83hptjTvSuydjOrLEpYu+sisLACo3oxQMxsI
	BHx1BRbsu+bHZSYHTXdwYlvZjNifZaPuw+G4M+SZ6lHKIaFOThBb6CoCIbpiPfybQDqj09VB+yK
	3E+byDb6qUQHSXwVtjzCjMPB1GfMVBE5NoewpW3kGPb4BqQ9zenXnf/RuNp+QFq/qooVE6tIZn/
	CeQZ1WSoVymCuilvCaVjUrdTygMbzF6IUkfa9VhekZfgwbBRlT0TbaPwXtvHc1wJi9xLbAvqSEJ
	4qH0/E1PHB95niWjNojAnhoKt72D5Nef5YbnpN/1DhsNuxvFyfAQ0H2Z8WxlAdlm6Go7+E7fszj
	8q8g8IIPSBJvoglDD9gOg1k9q1GX2odA9ZQOcTJyh0VSosTRwRgt5lRM1PivBYeKk/QupF8zKib
	TMSqlPyRW/x76Y4DK/RXxKXqhb/M22pnOr+lw98nKgCimzfsbXK/eAqGE8MVICjKZQV15NCbke5
	7eIp9vA4DK4czYfzN0oFNG6m46TDcGgkHnd29lD1Yc479z7s1/Ueya79UWrt7FUGv7bherf+wTh
	sOpohO3lw/L3te5FxZR1rrkgR35akrAI/QQw7
X-Received: by 2002:a05:690e:43c3:b0:679:a1f6:2ea0 with SMTP id 956f58d0204a3-67ba50126d8mr8364019d50.33.1793777711101;
        Tue, 03 Nov 2026 23:35:11 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee202bc4sm977299d50.4.2026.11.03.23.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:35:10 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 08:35:09 +0100
Message-Id: <DMM94NDU83WN.337PKDJT31SOE@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/14] bpf: A stack in arena
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
 <DMM3XWQJWG41.38YIBYIE2576N@gmail.com>
In-Reply-To: <DMM3XWQJWG41.38YIBYIE2576N@gmail.com>

On Wed Nov 4, 2026 at 4:31 AM CET, Alexei Starovoitov wrote:
> On Tue, Nov 03, 2026 at 05:24 PM Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>> No released compiler emits this code. The change to the BPF backend of L=
LVM
>> is in review: https://github.com/llvm/llvm-project/pull/235577
>
> The flags are made for Rust. I tried them on C.
> C without __arena works. The kernel side of this series is enough for it.
> The LLVM side needs more work.
>
> -- libarena without __arena --
>
> '#define __arena' is empty. The compiler moves the globals, the heap and
> the locals to arena.
>
> 63 libarena progs out of 63 pass the verifier.
>
> The price against libarena with __arena: two times more casts, JITed code
> +18%, arena_malloc() +7%.
>
> So probably not a recommended approach, but works for "lazy" C developers=
.

Could you elaborate on this? Are the extra casts due to the fact that globa=
ls,
heaps, and locals on the stack are moving to arena memory? My understanding=
 is
that 1-1, the compiler approach is still more efficient in terms of the cas=
ts
emitted (and 32-bit narrowing) vs BPF_F_ARENA_SCALAR.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060177;
	b=tUECktTjAFM+8YQFM/mpaP7WnLDiYgeFIjwo6ZRfaTXvDnB/E3vFRQMNfukVIXMrI0kP
	 Cznsur9KaZxhfvRbaxdi92GaF7toEYc0zxxbeidBqEgqqcZRL5dGQvTxxIhPfMG1EYEDt
	 xk9gxnJ6BANpIYuQvTMU6RjFS2ltIzvF46zQJogcxznbT2GkNMX/pOBNchtvN7O7iL1d6
	 7rzMX234WhZ/LX3j4yhamjJsNyRRXUoAO6H3epp1Nu3G2DrFiHKRI8zP9fW5ZAcmmT9Uq
	 ZiorzKzHohzeZ4f3QAoPVOW+FP4VphWoj6tXrEz9v107kRR99whFxhcwxLzR/MSGGrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=oni2tZocTqmk6MJ9MEIczZjZQGZkv76mwj8XQfOUZt0=;
	b=BiiQ8cXAJteEXKbQSF+yOxzwGINEa443tDIcb34fi8UTZ5kIE6vCBaRubUodGXsa9oRh
	 8uvoHB/62FaUHaG1Fqp0rub2PR50Wiyp4+B4crgfFV6sNlGl02t4yXecdiStW/TGU7fcC
	 pUsm/M58meuoVmnKptGAyWMa4MJ8pzZedVlu/BjF3UMgEN/liBUyZ0NxFR1EbpKM1s3to
	 y8qosRxIZwIVkTtT/yCdgzxZSKudgvh9z5jq2/MxOaIv8N6IB8AfBKdoS0UOKqhYo05Dh
	 DYkGXVL24XeQHunMF985/6+zSadjRnU2P29zAbZZr3od2c8r75w+4tbnEEGuo5FDPYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="et2xRo1/";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377E606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8377E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=et2xRo1/
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e7e742a2c7so3100445ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060177; x=1793664977; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oni2tZocTqmk6MJ9MEIczZjZQGZkv76mwj8XQfOUZt0=;
        b=et2xRo1//C2WzYpLCbFYfJcLOkGDBTO7bfUSHoINOElVkhy2jHhXBpzBJ1mdFy78jd
         5MXwYWTBrdGnPzWviLEmMMOxySFvFfrsHWDhnbjZ3FG0HpyQET1heBmqaJ72TGT3iCGZ
         PQZVnB6bGyfI2h+2VT5gIvHGYD2a4DF5zhYJOCJhnKWnpBj8Cx/l1/zhidkwqN2DwL6u
         Y6fFJBwGmTEpxCpTmwHg7qdE7tVzn4ydrf3jlA3zf30xlzuUrWII3A6KxsnV2UMRGIc+
         50WcMOh+Uis9waQs/EFLKD/xOHUqttBHaHf1F/QkluXHgnRmiHuOYd56gugYuR0hgGEX
         8UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060177; x=1793664977;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oni2tZocTqmk6MJ9MEIczZjZQGZkv76mwj8XQfOUZt0=;
        b=PfL41hETUxIli5wR/9o9pnBKSdSGG77F4ZE89D+HhM7c5m4VKife4Z+amhIvrYDY7Q
         9VWZUFaopyn7MpYYm7fYFSg6X/HEQl4psWTaWZcirFWvkRwwwd7m4YTFb3e8AEw168h+
         SqbtH+FTTfCs0sdcEF9LS86zOX1FYcSOgDIwIZM8TgS1NTkBtvWBUb8bOr71lgK2KSR1
         Hv9t8NLnXMwHzlTqrFduS70MCrlPm+fyk5LblIJXOLvi+fG2Tew1dLDu9mIO3Q9P8xJi
         g6iJYdCb1gOy4ubi2fKSXpfp20JEK+pFgCgx13jPzd2m+BllhXM0+LtB2uvNda0EYRE6
         mLbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRCChy+2AcIwbkOJz+/4OnVGMrHBe4FkX8s1UcSIFeT0ts4khIT2fabbFP0YKjia2/kJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLslqt29zPohmk4SWu3jFWSLamEytzvR5aehpbBLR6KpnLzW5Vk
	NfZ7F4BnFCZDqOJBmg3MUCmqyt74ombMpwt1ZBrE66hrGhXp1lQRWbT2
X-Gm-Gg: AYBFou3q6sl4cpw5hgU90WBhC6oQlze9jOvPtyXhIKk1Rsz/fNNT0BfQKz5BiIszB6Q
	ZYMNJeioQSaJZbeNMP1VZa/3+aTSIZJAhZ8hyw0T4WQIk39I6NMFW66SXbkqPmktpcVho3qqt2B
	KWSF5REwroe2inBllIMxvuzN4jnJuICpQPVm7ntVq7IMdhDd/E03672Pto7Sy4a472SeArtkB0s
	AJUd1CnP+RPD/h7Tjy0I7wRRdW9G3Bsui1iHQ+iceGixs3megRnMpsLnL93s2OM4aqIr1YEn2Ft
	P7aI2ZiCquYcYtO+Aus2zK2kYgJkgBtq72s1DrKXedPGJ/suxez1dWSMlckDhrNdEpW2zPsmqII
	IQJDzP3e5U1REWyJd2GiT/Xi6NaCXRG9SoO2FzeUYs93mHU1x9tnWsbDlfd4lJTDpaKtrWNNyJ6
	e/AFC6vZZnR8fp/2+Utywd/Tj6t64E9YIlTABKoI4YMef8jrm31S7TEKyUiyGBJzkZzcgeAASaX
	YNKsMp5+3pz8dckrxnm4AZxyfqsT+10D2FM9wPK0JOB4t49E9M9m5t0LzUR01xSRBXcbFNXP+ye
	uhMb7MhI45Hae+LgFsoGUd4621R/V9Qs/KiAVy/oqszjg6wFWDJl5qBfRvvdAs6MXeGjhq00Gye
	usd0ceg==
X-Received: by 2002:a17:903:468e:b0:2e9:5d1f:dfee with SMTP id d9443c01a7336-2eae3a9ca29mr6509465ad.25.1793060176825;
        Mon, 26 Oct 2026 17:16:16 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6be5105sm1615785ad.37.2026.10.26.17.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 17:16:16 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 00:16:15 +0000
Message-Id: <DMF6S994J4RU.NK2MX1X2UNF6@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <fbb26ce0-00a0-42ba-abc6-82c3c6201d8a@linux.dev>
 <DMF64ZG294VY.LCU9YQI054U2@gmail.com>
 <5c042467-6aca-48fd-b5d5-e7705e65a158@linux.dev>
In-Reply-To: <5c042467-6aca-48fd-b5d5-e7705e65a158@linux.dev>

On Tue Oct 27, 2026 at 12:01 AM UTC, Ihor Solodrai wrote:
> On 2026-10-26 4:45 p.m., Alexei Starovoitov wrote:
>> On Mon, Oct 26, 2026 at 03:28 PM Ihor Solodrai <ihor.solodrai@linux.dev>=
 wrote:
>>> This series shouldn't land as is. It's not ready.
>>=20
>> your bot didn't read the cover letter :(
>> that said that parts 2 and 3 were posted for review only
>> Only Part 1 is for landing, but parts 2 and 3 depend on it.
>
> Why not post part 1, land it and then post parts 2-3 as RFC?
> The review was done for the full series, that's the whole point of
> posting the series, no?

To see the whole thing through CI and sashiko lenses.

>>=20
>>>     * ask your development bots to ensure that verification of prod BPF
>>>       programs (bots can pull those tested by BPF CI from github
>>>       artifacts, just ask) has not regressed, and that there is a path
>>>       for updating existing programs to work both with old and new
>>>       verifier
>>=20
>> your bot is wrong again. meta progs are not public.
>
> That was my mistake, I thought we publish the objects as artifacts.
> I'll see if can do that.
>
> But even if they don't become public, we run veristat on them as part of
> upstream BPF CI, and those signals shouldn't be ignored.

No one said they're ignored.

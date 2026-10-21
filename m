Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618309;
	b=zusf9zsiRgMdQ8OsRroXaq5faJQXMIXzwjGLE1XG8Z+w8wvN+yoOVCjZM7JM0tYfQn/w
	 KZ7PwD/zHKD1nTaq/7YPqxT0yev/1ye5afd1HF2L3lCUwqpJgXIL/LiFJeR/++Y4yqCrG
	 5mdfgh8i2qZp8VlG+KMOWeXvfmdkIsLLb0N/rvZjANmK9JjSr4hrswy3wD8F/1IVbUKNK
	 FBZwUEIyKHnYH7Y6W9O87dgJmCDlvSo7SvIShc6Pq8842qKXNJ7VY7QX+JDdsBjZG5Z+y
	 BzfihdbTHZ85lHJatDyFK+o6dFTWq9T0FNjlvLxmf3vRbHITH/stb2EZhjHcK8Fd0rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pC8tiM/M9A6S1P2Cu9B78hzKZDqyUaaLB0lWSLli4Bg=;
	b=GZ24RO05KUDmML/dFfgEtBmiVKqzByjOVIluKztM2WqCXjEmLrpGGpKYJBOV4aCbOZPz
	 VBHBWLmv/IZ/0rFz7o32dlQVOO2rE3u7/bChYUD938u0/cefWDJAcmpc1Ev8QyMRAsHzc
	 gJ82KgB4Ff8aW6zjbmD8thxL9ygfOND1OaC5gYXVp/WhutSbgimno5MxmqQDHe4q5pBrE
	 kICv+yWqEE3Df1xjebO9FyVj5oJNeArQttRKMox0RnwjhZPsgzPrk1tOUtvDfw39dtulA
	 XgTpvPkZ8Sn6liVPU0sOgviaFRdjitrgdNxHShNRqcZycIkBCqKqQm+RT5JOHxWPNXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrdiL0xO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99F606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C99F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrdiL0xO
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4c5d8c7f326so483059b6e.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618308; cv=none;
        d=google.com; s=arc-20260327;
        b=bnf01+DiqJmPkVoeUQb8CGBp18QAtqRQyf8cb4vRDoKxA4Jr8huggc4VTUksoEWadJ
         vDdtSGVClImU4gm27VhZPTg2zq2/5urEbw6dxRJcBAPy0U3BBB7WYpsx/mnpsGytttxQ
         URg3ytihCGA0e1xaq3D252HVnmGmmMhb3SUQkkcKdxTGskFIXSXFIh0zH924V2BWWWW4
         GmqMq7AOLMB+toP2Pvc7S0ajmVKQ4lyo/jG9DXlRD6UMUzI7OtfuP3I0Zkkklf8fDwEb
         WTjZgeVJG0xH8METysWsoxUiBEdVqyd/S77iwdoHebYXKGhxSBSSYofFFtjzTGGCbDRG
         vPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pC8tiM/M9A6S1P2Cu9B78hzKZDqyUaaLB0lWSLli4Bg=;
        fh=7ZoPpuPsL0UGaj1+jjLGtmGqShAZjvFUDHyP0EBItSw=;
        b=oCNXHye6taL12t7OhuqPiO+pfjPvJAgG1yU4Hd1pfcAUusymNw8TTu7H0BvxvQmqqB
         RV4hDnmvgzO9Mo+FYhiKr6ba8tXfJx+ojfhj8+ilPMP5vMx6zm+Pl4OIQkludA6PVEbP
         oZpKDu+/rrneXNyJo6wAYfPHzczqImsP8t6Rjkxop40N4hR5B90y8zlO9OnKkuA7bg/g
         WWtU5cYGn9h7cDJ/a0CC3cltLLRNNoGw09yRiNZab6rmm74EM0aXjHzluYoR8NF5UIga
         cyu1OGrWritk+Pe81MnwCxUPFlxgHqUl43n1Z/wnDvmF7FiTuGzJOXxC+AOL9J0by3UD
         s04Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618308; x=1793223108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pC8tiM/M9A6S1P2Cu9B78hzKZDqyUaaLB0lWSLli4Bg=;
        b=ZrdiL0xOnMIVLI34bUuSiLMnJVj01ji4TxNPJFoTM/aHvJXdMs+EmUtUaTjpok4INn
         t950vBzFoRwgt7BesLNP+ytYotOiGurJ29lBAOP+KkPtNmZbAIOFJaYXGVCqBrDID4Ke
         J+KED5xh9gJHRMSLh+8wq65CFjD+uUaC4Yi8CrKL28gG2CRv7g7b5kW0Qr8rIHzYAI3j
         VXgwr4zjjSr4CQmg5gqVVrgHFpVzsX1C0LQf7BQ4zNYI979oX6g32m35NTdZTwuvWCGd
         vk6XALWZ26dHZWqRhJ1XE1j6KgdJLAjPy1lvBHvTooU9wa1q4TuW4VPJOrkyQQb3UhhY
         nsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618308; x=1793223108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pC8tiM/M9A6S1P2Cu9B78hzKZDqyUaaLB0lWSLli4Bg=;
        b=HGxkA3iAUzP34txngHtUMnQ2V6iaEU41Ut4OOlSN4UCr39sFJl71Dqa9YQtBrL8uZw
         UUWz20XLd4/XL0yK4JHznP2o658rLpe9jA9hVkPB0H8CeMKGOpARy/mG/ybNa0BZxsqs
         E9GvZvy+sKScEQ7vzPGdfPz0NpF2YVJG4H2uE4PDeMVrHRwsYOgtTWVLcl0iTm7T8QRr
         XQ6wgVAzt7+8om4MWvXtM1fiG6XK+zFQj29fX3wqEvFfXTOtlfO31CqrG5E3hK6cYp+p
         8wDa3q7MayaBoyNyf/XE3tQbWLEXMeVeN5T/02NhhzI7hZ2+M343ejA2PV1wyGRcYJLu
         /cQQ==
X-Gm-Message-State: AFq9FYLqJvJcERy3p3YOWpd52/nbdioeX6dDfqQ5SSEx72qOOcY+3Mn3
	UC7RTu9O6k8I+owvdulZhz+u/l6dNKJruwjHSd8J97k2aPe3UUQLIb2mBhAhOijUzgUd3qMiCM+
	v+WmV2iL95p9Qisg12PW92xoQxndz3gcwCcjB
X-Gm-Gg: AYBFou2ZVAbaznCAjbsm8I6ByYH4/8RhtwO2iKYdSf3krOWZp0sTHlRtZJFypkfndi6
	75WiqsbpRqk1UaZwF+2EC47yaodNkVU5knOTxScETJhsn1vDBgRyNxBBHiXpk0vXVetwN949Y+0
	gH/5Fj/sg8ULSjjPWy10qfp0KZHT4mMaGOuPX7ir1MRxxn8VAOUk56IOiznqDN1k8WHYnqhrMVE
	DMi4rgXo2gvgiDO6mXAgi9RYSL17XJ5GZGwOCT4HXZPabeiL/SzeCpoSVBnE+VOICSyH79C5Xnv
	4yNlvKmT0L53En9zTFiX3iwbuGOJsDJ4291m2qbickPRvs3nUf9Cyg6vN9YyKO36f0CjGND2Gky
	Fa8PwriXO64hXxTN/P/m7XXOiUTC6ygiFTrPP
X-Received: by 2002:a05:6808:d48:b0:4b2:8e1c:5920 with SMTP id
 5614622812f47-5534e1c59famr2327157b6e.9.1792618308322; Wed, 21 Oct 2026
 14:31:48 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn> <20261021210754.3270023-3-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20261021210754.3270023-3-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 21 Oct 2026 14:31:36 -0700
X-Gm-Features: AclHuK-JRzTqCJlrsvptFnnm8dHHzVF5EXNFyNsvV7dtV90jxoppmAa-1IIypUA
Message-ID: <CAMB2axO6pdGYGAwUtXM_Wpp-TEU84oOsQ_N+qud1J2q1dUKu_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: Test borrowed iterator
 result lifetimes
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:08=E2=80=AFPM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> Exercise borrowed VMA results before and after iterator advancement
> and destruction, including NULL next, trusted fields, and a FILE
> dynptr that must be discarded before advancing. Keep positive controls
> for using the current element and discarding the dynptr first.
>
> Use a test-module iterator returning current to verify the explicit
> independent-lifetime exception. Retain controls for RCU-protected
> results. Also check the generic trusted-field rule outside iterators:
> reading file->f_inode while holding an acquired file reference succeeds,
> but using the saved inode pointer after bpf_put_file() is rejected.
>
> The annotated programs check verifier loading and diagnostics; they do
> not request runtime execution of the added programs.
>
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

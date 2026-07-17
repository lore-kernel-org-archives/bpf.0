Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9C1E98E3
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260862; cv=none; b=idNF3lN5kYowvFg4k8oYM0oJ9bwiob1dLml4s+7+nYLBQI1052aQSgPl4nCIpnv14TamuyjbpVX8jh4aDp2Ig2u1b7ZWSu6dj1qXPi+g9AQURYab2h99zqC2nsdzwxupm5DGBW1gxPsKgacYP0AES7KbjhryVvaJJi6JzVi6caI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260862; c=relaxed/simple;
	bh=vZfpz8uLTiddyiy2758yPAkaK8sMzr6eGQmJvvhq2/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=O0zMSFGg6E9iGG4UcRSQIpHkSIVclk8U1Pqny8ix4mcu3v68+YZ6YkSMoMON+YUH+7OT41MT8tN1aWW4QQ45BiUXCe5TL/PfT04KyKNLFU5Ncz0IRKRaJ23U5Kda7grlGowVANJNbwfdw9P3RxdQBu4OK87NS5LNQU8B7HkPGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=EScVKou4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="EScVKou4"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso4867508a12.2
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784260860; x=1784865660; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECn3aQ1MYJJkJ62EqF+UNDdIzKP6oCJyMvtDCwa3GgY=;
        b=EScVKou4Sc7MgkGv5nQFqG1/IWz+0KKZPCRzL0rhRMlZRnmTO60O0LNr7E7EgO74Gq
         lBYVO8a/y9my7S/iyoyHgAm1ZAaGSnfdfaIYGorOdO5ZCJMEzgio9c/ezXhz+WlgwpF5
         MdEKxQrGFgtLqRKgEHfUAQw/VU6TZuimZ8v+40S3UPGpzBfojCMwTyjHTPjg/Cec8EdU
         9hwM6+QrUP0lhKWPM93EkPw2sW2BsRzKYIFRu6lg8/t+YeXCR0ppvaDCRNPTtbqUvbb1
         wc8uxqAsXiH5mLxg+opitFYeMDUunjtMNAiww0hlLGThv0zyHUya/FQGMFn50kGfPtRF
         fLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784260860; x=1784865660;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECn3aQ1MYJJkJ62EqF+UNDdIzKP6oCJyMvtDCwa3GgY=;
        b=k5HEVMlJ1BJ3rpykv5t3csisaMREuRkMS+JYh2oQouWx6fBSZjvi5RNJJThVmGCfDD
         ON/sZSZ25+25FyLgQcfTNa8iCSY2HEikqQ1x4Nnn/8xTotltVSBIYdtZAGvLZElUR9E1
         huT0Qxaew3+nFwOo89hqfLOO28m0/jk8Qkt1a0GezG8pX96tWNm1PvlpgXR9YJSjxrd7
         7jjmhLloc6280KDTmB/+aN1vuzIWjC8bF9ytrTzIK4kBaTo0tpKlwp2NpNeq4vRAAJ53
         gy7iD7vxr+a2TkZVET+s6bl/wO1lfH67PhR/9HeK2k5Ltp+YQQMOVyq2jfrGFYyrSkVT
         YLGQ==
X-Forwarded-Encrypted: i=1; AHgh+Ron8pBB8js4L9jNK523eLOKJMViEZ9VhSEl2fPbstAliqvnlmD+qZvlUSAHCZhrqJsXcKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PIQpvl+B0NBH8e5g5kLN3wy2M/o8vJRBIDHZCc6lBgm1yDxF
	nKhjHeq9Hfkgvp8d3wEKVsBwQM32qil+loCkXEPHf7ATE2xk61I5/7lHcxAIHaFeg48=
X-Gm-Gg: AfdE7cneJ90ExbuH0ylKBO3Rw68qsgxxuiers80B9ubK94CtKikACvTsBrh5plWxBdt
	LPu/uLLZ9ODI14L1ODeRP72UqcLqCbFiOUIbGWbteQBcLoIPGuTnFiU932iAmX4MQ+/Ya8UXQl7
	cnZ0CXlC2imgXZjRgOmHuSxSlbD3sePODO2MEpstfO1Gps8xSRfxlpg2V0njhErMc1stO6x70j+
	7u6ixkj2nT8Pr2Y8DOJ5a4pUYmpbE0Y60NhdjkZVH6Ou099+2iYFU8DAnBzjqJs/oeb9NdwHmJu
	Lk5t8vncLOgGcNT1pdHrKvwob/Q9a5wlxWe4eACiH1yy1dZLm9iHXSxn9/k3YC4SnFyiAela38k
	kltth0eP5Lx6RW6QGyolNOIvo8aOd0LMRXSt2EWjOX+mqFh8QT3pz96lAcGZ4APnThtSuvcMWqr
	y4Fli8qCPr4vD44chFVY981o5j1jAvWaQ=
X-Received: by 2002:a05:6a00:430a:b0:848:7ea6:4b03 with SMTP id d2e1a72fcca58-84c295839dcmr728495b3a.75.1784260859953;
        Thu, 16 Jul 2026 21:00:59 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af317c8sm162996b3a.30.2026.07.16.21.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 21:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 00:00:58 -0400
Message-Id: <DK0JOQQU3K98.3P9DW8576WMEI@etsalapatis.com>
Subject: Re: [PATCH] libarena/selftests: use ARRAY_SIZE macro in
 st_asan_buddy.bpf.c
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "longlong yan" <yanlonglong@kylinos.cn>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>
X-Mailer: aerc 0.20.1
References: <20260716071110.560-1-yanlonglong@kylinos.cn>
In-Reply-To: <20260716071110.560-1-yanlonglong@kylinos.cn>

On Thu Jul 16, 2026 at 3:11 AM EDT, longlong yan wrote:
> The ARRAY_SIZE macro is more compact and more formal in linux source.
>
> Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy all=
ocator")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>  .../selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_bud=
dy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.b=
pf.c
> index 3266a28f53d7..9c94a5167a50 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.=
c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.=
c
> @@ -163,7 +163,7 @@ __weak int asan_test_buddy_oob(void)
>  		return ret;
>  	}
> =20
> -	for (i =3D zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++)=
 {
> +	for (i =3D zero; i < ARRAY_SIZE(sizes) && can_loop; i++) {
>  		barrier_var(i);
>  		ret =3D asan_test_buddy_oob_single(sizes[i]);
>  		if (ret) {
> @@ -201,7 +201,7 @@ __weak int asan_test_buddy_uaf(void)
>  		return ret;
>  	}
> =20
> -	for (i =3D zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++)=
 {
> +	for (i =3D zero; i < ARRAY_SIZE(sizes) && can_loop; i++) {
>  		barrier_var(i);
>  		ret =3D asan_test_buddy_uaf_single(sizes[i]);
>  		if (ret) {

As the bot says, this doesn't compile. The sizeof(array) /
sizeof(array[0]) is only present in libarena for selftests, so I
it's not worth bringing in the macro or adding extra headers even if
it makes the code nicer.

pw-bot: cr

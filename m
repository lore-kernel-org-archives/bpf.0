Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E643DA27
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754093; cv=none; b=QvooIPvL2iSJiAX8AOIUF9Ka7DzeG89OtdtmvrbNRBeZbTqCqEBp91VBr6b2Z44T3Kc5a11jZkPoC4qbpgX7nCYFABykXU1v8qSwpyCei85ncLPkRU4uRgunVzSTzxjylZyM1A5fA+Wep3ucXecrJAeuaFuzzEKkDFunOgssJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754093; c=relaxed/simple;
	bh=q89a1LIYC/+za1L0sqYn4ObuSzIDGeRBUiOXTZATgrM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=r11JqY6sYVR9D4s58rpHFjppVWjeGLH6IL+q4bYFXmONruZcfH5KitoMWhKrsuC7rL5ZMIaowz/PecY6Dxgc5/m/MZ8bjqYwqzeBvrwj/3aoM4f2+4Qd8dNE6WMcTHHkq9hRb9kvxT7ues7bshFIjhfHo3JghTAqmpnSpczGasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJoZZHZV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJoZZHZV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecd7216cso45249a34.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754091; x=1783358891; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFEMIzG3ZwYx+F9DQvZAp4h+AG8K3cwEV9kiHVx3YVQ=;
        b=kJoZZHZVGdY4snS0wXg4PA//kdeiIWfC6+PalJ7s1PLXKfL4FSuLCzI842b9ytW2u1
         kOs0GVSiD1927cshK2LhAY/S+EjN0K4QGNY2zR/pi+8YrI7u+hqfiv002IgWhmJaw31k
         8Uit8jU8BCgHoN9s4lfnx8ZR2OwouZkBizSfzCpxAkpkm56I/ugZLd2mbc7Xh0hVCZo8
         7p4KSFx8I8j3z3aJUeXqt4TOuDjkk/o5ZQ6B0qNK4t59zkun7z1bFOdvdfqX1S9MKypr
         f84Kz2Zp0rZGbFd9HYYzyRGMlPFyt796q9CrZq5paeDUTt2REHYiOVnSWzsTOcSi9rqJ
         EcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754091; x=1783358891;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFEMIzG3ZwYx+F9DQvZAp4h+AG8K3cwEV9kiHVx3YVQ=;
        b=nk1aKsGfZELDCNxcRor5BrRa8XoIlm2oFs6wJp/KxKqHw5DDRCBLDlhYvUTK31XJix
         W6u/2ECt0yuq37jkSrZv1NULARXu8Yq46t2eUi9IEy/Gu5son241jM2Yt8pg5jyIQfhr
         aVGtcXloJ5ZzD0VxThN8x48v5bPy/10D97XqjZZPhgQ8Md1CuRD0T4FvF9jDFbS2wDB9
         CFvBRAHEX6Ay29iozCqNP+gCPHtmKlGg1vFIU+eMKiTGOhQ7pU6zV30SkXS3YwNLt/Yd
         APCHs9ZjpgeW1zADxFWFlmDyabXgSrqqap99xqdcayeepBdwWEoF562WVJ5qs6/oFY5+
         EzpQ==
X-Gm-Message-State: AOJu0Yzmqc2focBmYK3iShRcTG8U1yBLXWtEt1nfbayT9+x5U9nh68Zu
	Udal5DrVGkNjlfHGSu8qTSZl4eQAf3yUc0htizK8JetjEplsKfNWDrmm
X-Gm-Gg: AfdE7cl/E2+DUNhXyNlwhFV2BUuydCBdMxBTU3xwLOIr8uZXy2/JO4dZawJnoFQBX/i
	m/oJdT7Olh+Mq6LAo6NQX36dc1yen3jxi+ct7DWJEmq/Wnl82jmR6b+7JAMhzyRfdQ9hOj1Wbgs
	42zokkWDvOw9bvHGwu3w4g4Iwvz/oV32gd9E72wS+GhS7KquOU3CF2sDlEt/6HmWky464ti7ZkF
	6sgXalmqxlpEr6CY7TPKRofTvxUIij2CyA9gbrUgk2e6vI6PsgksvYCQzrFFSiDNxuXxTZIoi6y
	wxR2OyYCviXrVAGdsKSA1fxiEC9fM1CCa0tyV01ETJPx/thmBx4kq0b6c2m1ei2aEKjY06HCR2d
	isr8gFMDECgGxdqEz15wafvsCqJcqw+cVBeyOVBLHlzAibW269pLaMC64p2rSzJdS7RZbnpT71X
	Vy88GYxgVC+byHTmv5d+snEsrAZdfTvR2RTvIHB3hDYXTxguCJ1+BGkQcBpzeiggsscXDuYuGah
	LDaty0=
X-Received: by 2002:a05:6820:5714:10b0:6a1:588f:d142 with SMTP id 006d021491bc7-6a18914fa3emr288615eaf.16.1782754090701;
        Mon, 29 Jun 2026 10:28:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a1891cf544sm270781eaf.5.2026.06.29.10.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 10:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 10:28:08 -0700
Message-Id: <DJLPKY6WJTBD.319506WRJ7EUI@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>, "Quentin Monnet" <qmo@kernel.org>
Subject: Re: [PATCHv3 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260629143844.862369-1-jolsa@kernel.org>
 <20260629143844.862369-4-jolsa@kernel.org>
In-Reply-To: <20260629143844.862369-4-jolsa@kernel.org>

On Mon Jun 29, 2026 at 7:38 AM PDT, Jiri Olsa wrote:
> +	if (info.type =3D=3D BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi=
.ids) {
> +		count =3D info.tracing_multi.count;
> +		if (count) {
> +			ids =3D calloc(count, sizeof(__u32));
> +			addrs =3D calloc(count, sizeof(__u64));
> +			cookies =3D calloc(count, sizeof(__u64));
> +			if (!ids) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				free(cookies);
> +				free(addrs);
> +				free(ids);
> +				return -ENOMEM;
> +			}
> +			info.tracing_multi.ids =3D ptr_to_u64(ids);
> +			info.tracing_multi.addrs =3D ptr_to_u64(addrs);
> +			info.tracing_multi.cookies =3D ptr_to_u64(cookies);
> +			goto again;
> +		}

The above doesn't look correct.
Please de-llm your code before posting.

pw-bot: cr

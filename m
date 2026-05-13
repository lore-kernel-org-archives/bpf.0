Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DC4DD6C6
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694700; cv=none; b=YNsJrI2Bu2xyybl/kzrlliyA2VauhqP5fn+CS6/6FzXC7EjNCBovYRi0++7bHoXJEj4c8YQn4pL8+YmgJ19NvooBmQlMBtmkfGdYyTBn800Q2L7kudnaqYAshSc/o6vol0UCabwUYJAKEFUm4Bk5RK+bAKwKYXRctg4+UrOQBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694700; c=relaxed/simple;
	bh=iCpTWsKwcp9LQMJWdeb+4v160qwwj8oZ78exX6cbwOU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XkuXSQITDG/xiv+8Efx15P35q/zB08PoCWveXFEwwM/vCSNjHW6afkJau38CLv+VJdWv1OjwXG3InMLKHw54+TeILs7xjo8WPvmj9ezkkOOxqQPgDF84p9FemyFBWJHOAqOGKJVx/OEuIqJbuWenMwpmVaENrTWP7ZF7MkE2kbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdG45EQ0; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdG45EQ0"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47c35be031dso4462172b6e.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778694698; x=1779299498; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCpTWsKwcp9LQMJWdeb+4v160qwwj8oZ78exX6cbwOU=;
        b=cdG45EQ0tv5tmWGWIB6Y8UhysWC3cipmC6ZDclPOq83LlwvOdPApmElUcInqZGxEEy
         deQWYOi4brfE5vqwK6ewFbtnyFRFlTH3OwQSx6BBFM4acqm+rNpykntgxS+7XiWSWfk7
         HRviLUwT4va0FzYpFHwaULt0GOk9Ip4ILJcB/6aFg36D2836Fc1mZeE7aqJc5PPA4OC/
         ke3Y7R9EDr2kWUii/NPcwOOoZ56SbvOYFFz3jhWsJV+nC8fvDMPaECE819WQzNGZOX2A
         h7RwDJnbudVtOeYjNLi85VB5DWAIGvDxBs9a8EGDyTC+zmSWssFbmLAuFuwwmal7MSdW
         ecIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694698; x=1779299498;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCpTWsKwcp9LQMJWdeb+4v160qwwj8oZ78exX6cbwOU=;
        b=BARrhwp7h7oqqEYwsIRAtFN4+LbFMgnYKRVM9MIn2EwazEWmWDRRBAHc3B63hpZ+XX
         IY/jULu2FN9m6VyG8xQG/zH94fp5Njv+UrGDWdkFd3kPSSQQ/QTItX5KSNNH0/OqznP3
         PzLl+PXiuWsfS70HVmz8OZaLUQvjfbSwRh6/Vni/XMvYPbLF7rTyRC+HIHPMiFEm1CVb
         082FNEEsgbdXbEJHzS7ZGdfH4wkmGsI8kSsIzjKbzEN5dz5/hFHxfvl3jWv5llhV/yJy
         pIz3yMTzRUUEtfTFwgbCdMEDYeNOk57bT0vczbND4ixKzEUiWUFjBGWOzM1CzeoSY6d5
         n3sw==
X-Gm-Message-State: AOJu0Ywxjz7DND9/Bd59nU/Q+4T9rAofiDqPsOSx+XiRYN8GkyWPcFRd
	xifoxvK2pL2E9eWNbS7qYp86i7z4RybofynrDLwcINx0YK4doSvfdtF7
X-Gm-Gg: Acq92OGDDuncz8VNr+uDmy2lEYaoa1ZV1n8xYp/Mz6PkUxJtnJ0u5Se2evHdaXq1hbH
	qp+8tgp9ZBTw07/7Lf+loF6PEJVXm2os4j6of9ud5g88heS1BFGivx1qSCLZX7/vZkC9cA5Jfkh
	A60DdNpqtfjMMCvewlWEQPUGD8tZlGCwv0yvF+x4Ud+xOScpKqOXKr2ISg3hRpQvO1LLpMKxCEQ
	fLu1Mkv38cX4+9Z+LzCqm241p2gvVdObXUynQuiKmXGxj99IQBJ2WxK6fusIFaRzeyxfKxW+mdB
	4EMrbFWYjHrdcui7CmoWmkVsd1T8gZ1X8TIJrUKrG8OiPkLvGYO2xG0AF28DEA7gJm4YXT2dpPy
	zs3kHfj0u3W7vVK4nYVyekd0HEz33quT7YSw5Va0SFGkRX3iMhpnnhVnz3IRmxD1xW1BYgJP3oE
	fHW1Calpyh0Swpha6O4AvG5S9Hpv6dYcT00fX1nqdX9P+Se9FxRhik91THqJIGGY3x1SeOb8x0P
	ktFOMRiltFQeyFLbA==
X-Received: by 2002:a05:6808:c191:b0:479:da60:7dcc with SMTP id 5614622812f47-482b2d0454amr3011515b6e.35.1778694698315;
        Wed, 13 May 2026 10:51:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b2c87sm25388336b6e.4.2026.05.13.10.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 May 2026 10:51:36 -0700
Message-Id: <DIHQNAWQDSUB.8I0DTXB0NDK6@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 "Kernel Team" <kernel-team@fb.com>, "Martin KaFai Lau"
 <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 00/25] bpf: Support stack arguments for BPF
 functions and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
 <CAADnVQKjVKG8cfMBpWpmbtPToGPSyD13aXLNOzb2PTQm_bS_2w@mail.gmail.com>
 <0b02e692-1ee1-42e3-a437-97a3a9ca2481@linux.dev>
In-Reply-To: <0b02e692-1ee1-42e3-a437-97a3a9ca2481@linux.dev>

On Wed May 13, 2026 at 10:41 AM PDT, Yonghong Song wrote:
>
> To really fix this issue, we should encode btf with true signatures, i.e.=
,
> btf should match the actual function parameters. This should be done
> in llvm.

Yeah. That's a real issue and llvm fix is must-have.
I recall there were many other cases where funcs with 6 args collapsed
into 5. Like katran and others. We have them in selftests.
I suspect they're passing only because they're static functions instead of =
global.

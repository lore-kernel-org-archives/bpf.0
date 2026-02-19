Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124232AAC5
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545519; cv=none; b=s+/g0yXV1cIzFqMHMS29pErNFgUNpAaOts2+z+1QiebIPxHDbCh1/Y7moYoEbdkqJuZjiyXSpsgVGfGG2A6dROi8D6OD3FJ5IoaU025XiaqquPQ7Oydku58d+uSg0eSUaXMaTBx//tB3qfZL4teh35hjv869qgoFVvDhpMg9qgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545519; c=relaxed/simple;
	bh=vRdnW7tjDzy33A0ooReCpXuBd+lajSwc2FO/ZvCsIMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRf0Tx8zSNm1M0zyAXbRm+yCA0IaxzaYXhe2Zu1nQQ+O93kTZIxM/8KH5oQECJ96yPpGdoAVTitvuXbfir7/iJLzNslKDNkt61OjOirLQUfcqsevtHF7rXEU8zhnZDLn4Ln8zR6lCKV7lvNyrn7stWyui/my4XqCHknj3GNYLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgxE2Ej0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgxE2Ej0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a929245b6aso14573855ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 15:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771545516; x=1772150316; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRdnW7tjDzy33A0ooReCpXuBd+lajSwc2FO/ZvCsIMY=;
        b=LgxE2Ej0hmKGho3+Z2s9XTA8c9DPSvqw5huypRD1Dxo/BqcgPlX99HHf69lGTy4tEM
         TlTdlttykAn88JZB8xFBAk0XYBdf8lCTwQ3VeE4LkHHQ9RbQr++EkTEssVBOophkrBf2
         sA9VL9eEGnKHf5bTfAQiHlSmed362hq1kbWYU9U0j5QO89VKk1BVlbsTL89xGXGyFboA
         Qwg3FB8gUmNInwJYLII3brsob2RovOzF1Gs9EZ2xAP3MM3C3Iy8l8Pv53sWT4nkXzWUX
         pKx+XgjOANsppV9q9QLl2+uvgcPex9kWdID6yoA47Q6SwWUkCyjIp4zop6VyGtEcZ9wg
         ciUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771545516; x=1772150316;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRdnW7tjDzy33A0ooReCpXuBd+lajSwc2FO/ZvCsIMY=;
        b=Nr1nG6vS9L/enlVwT8WP4SybM41SV/2YyJFK6iS1C7Wu4fvkCS+Bj3lGri5HuuoW2Z
         EkfenELMsxn20MveTCsyQl08GDyiazScLGD9/WeGHTAEBRiMsmZI4kjUZYj/ml0bjO0K
         E4n8k8ZbBkW+rbfXmWLudTDAhbosC8qDSvkNZ5C4Uz8BOgEUeOCaUS+BHWwUdfaFOVRW
         Dj7NyzJ+xbIK0a0wu7IUrPQi83IJoZ5cgHWclKNoaqmLkpHfzmvtcKLcgWN6bFjD1D8f
         /lyc3zW7yK4tEWQiulau6UUwVvoZnV1dYjObch7NEeM1mcM3MVsbTaB1P5TxIHKcBF4n
         qy5A==
X-Forwarded-Encrypted: i=1; AJvYcCU7HE7M3BR3C2wm+1APGhOJMjcSrkw+ff7/bRHJRG1p9ypartwbYnh84FQguuVs5YYYuGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkMuhujcbb3xEcOHyYETz/YE4i/c3e05RQh9/zeNmzCnJFMk7
	pi2ADSifh/Tivb0E+qz8YPWKGP6iCAFJbZoNDJfBZgQ8FOHe2/Yk7GeN
X-Gm-Gg: AZuq6aKkReQwk8QfI+dwjGfuLeJryLWmkg7mQ+GQ1Wy80HksSj/jkOhFhZFfeD0W536
	VPNxgC8XXlutCjLsykd0JHS18+anGl8P/zPRk5mSiMBg4gEzY/wXZU6tVohpDJkZg7eK5xDiBT4
	aKnyCbX/Wi3GukRUnlJZsSuIgoLbvrWnusdhm5L9A5MpH3t8q10t8gT1A8Z4BEoS5vOKKZIuPpQ
	oGJMJt0cZpnPUMjrJyZ96IXkmCAZhDKcYGQHPg+Kbk7BTD9vkb1gYqkxaqHj/nIsIBMoHR236Ax
	3EMEr2ofcMfp4NepQsyrBvVhjHJdtJdhQnk6rk+acCTUdm69DbWyhcYlmrfgV2CGJKQ1xRoHitI
	Y9UzkoVZ0iYgd0Tb0AR53deQTXf+wdbKtOUpFYj/lue/L4cVwM/FxMrehzsR84RCwj2XFYKZerl
	EZmByBmhEOlZt9lQhUbT2YE1DtxHMSVENRlVu/AeXKyx4L+CSjgAQ=
X-Received: by 2002:a17:903:1447:b0:2aa:dbf7:7449 with SMTP id d9443c01a7336-2ad17501fbemr236536735ad.37.1771545516504;
        Thu, 19 Feb 2026 15:58:36 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a7145cbsm240834805ad.30.2026.02.19.15.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:58:36 -0800 (PST)
Message-ID: <d2f4204bb2207b85856d93b8a6cc6f0285a1dfe7.camel@gmail.com>
Subject: Re: [PATCH bpf v2 05/15] selftests/bpf: Fix memory leaks in tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Thu, 19 Feb 2026 15:58:33 -0800
In-Reply-To: <20260218003041.1156774-6-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
	 <20260218003041.1156774-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 16:30 -0800, Ihor Solodrai wrote:
> Fix trivial memory leaks detected by userspace ASAN:
> =C2=A0 - htab_update: free value buffer in test_reenter_update cleanup
> =C2=A0 - test_xsk: inline pkt_stream_replace() in testapp_stats_rx_full()
> =C2=A0=C2=A0=C2=A0 and testapp_stats_fill_empty()
> =C2=A0 - testing_helpers: free buffer allocated by getline() in
> =C2=A0=C2=A0=C2=A0 parse_test_list_file
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

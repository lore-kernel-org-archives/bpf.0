Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD23EB7E3
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760165; cv=pass; b=d9aSO5pR0uIG3tpxnOQrAEufWlizLmusx7c6PlXIoWA2hl5W9rD4UK8y9sERnf+nnMBS5PY46jEulQjfYYp6yS7pSfRgdRbFws2WBpqq31jTBXAr0yjYVpC2AQ+2ccv6T/cniR/Iom/H/5ziLr9Oatl2WEG6Uy3bdJ0+vG5yIrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760165; c=relaxed/simple;
	bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmkBlrvzXfNC3IRLzgwv0Dm/jeP8Bk9SzmOVJ4H4s4ReRet7qLzfuX2uZu9eaipD8Nd8+GgYxKs+XYPiz6BsmJ8RVdn4AP5HVKA44mJC+Eh+cMG53XyB1oxg6t45VrkycBvEjYsO/dZOJ9+yyAP/hXh9dLNt/f/LhSmN9zwv4p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkCMC06X; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkCMC06X"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b40003d13so2074110f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 08:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773760160; cv=none;
        d=google.com; s=arc-20240605;
        b=YR/WlPQBGkYdmEeumeiDmsFp6oLjMfCHtcFN7P5hERo+/E+Tly2lW6G2mlk1A3iesv
         pVwcwBU0BGCZxj8WeF+4HboUHx3wUsSwZgPdAVO4INcjMSNa+/1Wd3lNPn4uirqFR/vn
         f6zxLHBRQ+o2coWXGG/D1zWkhiQJ8Uw5CJKo/CCQkgROOslucWPLXs4YGGAuXe3MVR32
         adjREWhP66qRAOqMmEoMgGxvaAzGBGOdXnxmtN5EswbRQjGe4z4a/6MkL7bSA46QbyIx
         wLKY0rOuwhK5hk1tXh7f55rOAVafFoIOl3m5mIZDAdpHe7FzzEY5OKOmMWkN8oy6l9lH
         3EsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
        fh=CHCxOWxblOA3LzVXZGdLT2i/YfX88FMfGbpb+9z81mc=;
        b=cx6ki2ew4AFPel9PQJJE3KisyNh9eCnsBHulWJ9sT9WGSVMieo8HIeXYNKGS3MfpN+
         41u9XmqSp/VfuO70FiN3K1V58wc4UP9cCKKfiSJeaDGSu8x2J/Mqc60ahYtXbypW1OLp
         LYofVG7CRsPeMnM+wbwVQyvCUYMJzXx7sjGwzK2fGzuYmqozyroOAUMskSdB0rVTXLkm
         hzgY46PkrOTHANK1Dn6unTRM/csnva9xXuCxf6OSwiUNXGd1jM6GPVzwPPwhAthUOs6q
         qD+4q79nYMCOehrChteszE4Hk1D9RlMnY4xAxQwhzolN42lxxi/icmLOZDRbv9BNHPx/
         EzFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760160; x=1774364960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
        b=IkCMC06XggcU8j5IpH2JWi3OmI4cfDKeNxU56vHeqxA2HIC0Z3L7WWIWnq3NF9iqby
         i2Y66QgF45XLP8rFFBECYfbrvb3S11mCH0rigo49pEQ9U8fL+WsVu5Jwd6kfHzWc0vnP
         Ezott5KYBuYFLDujmrcdiwsNPkNRv9q0A33UO5eQZXbVVP1zQSL2QDefKjZaQVn1lcVY
         esNqP5ewRdxllm1mVYfETqOrfe0Si9uMtlne9Ev58ZqPdO9Y55Ap6VxreklonP/6EXJD
         duQ0C1kjsAPeXYwLKt4uMJx1UiXGTsH/0kt0dm3Fz2O26S2kpIL20whmHZNqXiL+AYoj
         xe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760160; x=1774364960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
        b=T5GTKHQLQPjKV4QwBhaQw5RWrKguNxo8vmhhMBDelCbKf6/yf78YvyEfOM7lm+hc/a
         sRagfnPnGfwdY+YKV8YFxkAoCE2spv87A3cYfN0jJj0ORRie3eyDfZet/PW1WZWHPJd9
         ztcoo2v0K51ZSdzVWa6nbzT6b/GVoqrGtTYjk7Cpz9/49xY5DudzZ7r8916L6nIyz1tb
         PFVUDsltTdpkumwIWkbwvy3my3WryIV4xss2WMTwFbJIEWYHK/7uoexdPjsOs3LeZOhh
         tjHpYdKlXpvbTAhFxVfBGQldNCOuypf7Pqf/1MF2Ehk7Btc6ZWSaty2peAJgqGOhZI4P
         Jcag==
X-Forwarded-Encrypted: i=1; AJvYcCUW49nQQE+YDbgWEeGNQW/SWejgWUspCRXumGo828g32gYXAJ96DIq7TEYN6MzMDk31Fqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsxFINFl1qepymiYTu0s7ToIOgpINrieymvPQRKb5bHS/zrIu
	2h4VLzcgBr8K5fCQZ6JO7XfhIjbWtRVFxnAz1oVXe2nfI1x2CAEyzLc7JYVPm2Fpo7g+CslDumz
	woO0n8g3joLyiRv4CvlBKInRFBygAOKc=
X-Gm-Gg: ATEYQzyyp8FUKe3VKZSAwYm6HQXKXhkpQD8Ct4L2asUZCOwNw1b9CJYy2WQgLnb+xrP
	A8Xw9PO4Q9EJnVHgQN/tKKhhSunjd4CK2krOyweFlO9SROXehUHtjvGYuEyJkVgYfVQH9Das4+E
	isDxuyGvI3zDZon3tpfOPt8pQeVfYscOGaHUr07K/tj5VwLmiKa7GduoRrM7ttCw5q9RXBaBc+q
	mFy9S74fyuvax9tsc8/aTvFHr47Pkqi9DRoSI823qd2hiI5pVBR4dSYKz737JiLdCb5OeTf9ZW4
	FKymlpYAqJCT9oopAUJpCcB1UIVIHoGuN9V6RyMx/LBV1gPLFUk3mAauimfEjoblTXk=
X-Received: by 2002:a05:6000:4013:b0:43b:3de5:611a with SMTP id
 ffacd0b85a97d-43b3de562ccmr17523497f8f.12.1773760160136; Tue, 17 Mar 2026
 08:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com> <20260316171200.4b8a96a0@kernel.org>
In-Reply-To: <20260316171200.4b8a96a0@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 08:09:08 -0700
X-Gm-Features: AaiRm51ZeW7_QL0pHZ4m-XU4Rn2lnA0V7NNVacbUTn3HGON1-B9xtWziG8dAs8s
Message-ID: <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote:
> > Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> > full") addressed a case in copy mode, when working with multi-buffer
> > xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> > there is a space to produce descriptors.
> >
> > Adjust ZC path to follow the same principle.
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Do you guys need it in net-next in this merge window ?

We have nothing in bpf-next/net so far, so should be fine
to take this patch into net-next directly?

Martin, thoughts?

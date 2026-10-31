Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480284;
	b=DPAqvIHKqh7qxYkCWLp69lZhvS+Gj+xWCtmLcI1s1oiXjcWuJZldejHxTnnvn4AwFFo/
	 Zyuy8KZYoop+R4IHoPZvKeyvppbQvecsW2aVLI5rlxstbFg/Cf1joc3E91ebJiDqvGlrF
	 uM23hdRAfmqUo/fjXIWYTvzLXP4aMMPAW2MncwkQBpCZi+EipZKtHDd1Xt2OgfDSMys11
	 tiG2gUk38PdFrePzcH++r5an+TfCybWToHdmeHF7SrYUCj8C+7qyAeZSjeDtMLck8qNQx
	 HvFK+Ndf4ZwZSi8/QDjAhUo+QJPn4II0eWswLY0DIpTw9klLaMCz6gLjKCBiIrFr0bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=Y/LYbbBt7trzTMNEroyzygNAvIrDGCzErGprATR8hIs=;
	b=X1Bdor+WVvnIbR3Mg11+redoZxNQm//hL1TTvGD6OsGDjn+nyj5UTRDhnSGaFPSFlTf7
	 mDBupe6DfL+4Sp7oLBAez0qCR+IxEJAZDv2OoznKrleSdSzLf69Bj05ffRcjLDzJSlDEF
	 YlSZ93HHsdj0qc9SG+3wkEcX5H0ke07aY8ZHrp2+LpD19t0hxBMC42blrdCd4d/2y198d
	 /0/ASBKfYtNZ9reN8pUK9zEpJk5EYMlFjlTwbwvxJX6W/GMVYVZg9i/rXJW1/0jURwzvk
	 xGdpJPl9Zcu/81uVaRXR0c0JnQ4YC/1T+9MnFKw8vJporrCQlV6r+6JDbcJmKFoNLVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIz5pZpn;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA1606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIz5pZpn
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e812e2b31bso10544045ad.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793480283; x=1794085083; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y/LYbbBt7trzTMNEroyzygNAvIrDGCzErGprATR8hIs=;
        b=vIz5pZpn/CV/yT3JZ9+1Z8dTi8d7iNdhPVwu7OHZVUJIqYzO+tijbQDNdD4DTk6NDL
         Gje9LUAQUA2bhu3AtYBzjfgA+ADNZMmCw75yfHKfhu69QGj8bU74LyR4Rc6mDTEaZ5YE
         b77vZZqkQqCWM60tqV1LmKF7ixexHIaZDLyG9T6tKaxPpy8oHSZKQMCmPEqOP51FLPgG
         MT1VRA1zNe9Ww3FN8aLr7AgQ/ivfkQ/d7jYTqRuvitlh05Ebui+s6dpbGoEa8h/sT4G7
         o3LLNgX4g1GuuFV11VC3Rm8Dxd8h11rh1Pc/HKAxRcc+psyMI20jAACnaB06y8W9RyIJ
         7rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793480283; x=1794085083;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/LYbbBt7trzTMNEroyzygNAvIrDGCzErGprATR8hIs=;
        b=x7fM75rwEsrwOYXW9U7P4QWPpwEFUucnzTg52+kqcxb5uqwcc+6g3DbIL+WNAlGaOf
         qYqo4i7bNuDjWVN5FWx4QI8DdsDQ/MCvurOTl0KETu/kpyM4vW1pXNy4jR0dsNlAuySn
         DieBlr+oDfNnd8BpVZ/bolnAnD0P6V7v/aceZy6Al6EVqXf6P3q+ihFQdjXqURK39wYA
         wdauivpHmpJvgZGoDVW41BBArGN35ZoKWFc7a39U3UqLzNonUPIcS/SORx0iCvQLtKUP
         Gx3m3EwFeYEuyp+ijrE5k7IjseK3who1/H4cpRAooWVYBBsYtENa4ksRMElaF/aGN81T
         CKfg==
X-Forwarded-Encrypted: i=1; AKwUvBzSYrQOs3xyJtzdSHZS/P9FngAU8mV36Q1ag++/c7zLrYW1APMF56QF9hc/SD1zGdmryEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvFbiUlm5XEyrcnlplx3KLuT+UURYS6tKB3NRerknj3HdDxFoo
	uwQ90LABARuYbsBkniz2UAl4Xsv6e2pLkWgqB93UHolHGN4LbDaLiWNu
X-Gm-Gg: AYBFou119elUBXw5ciQOMxc768+EajnEknZpUr/Cp9wtCXBCEdoygD5HMWHu9LRembn
	bebYctJV0JoLrEtsg/uEynnkke2ZATYlF0w3+85RnVsFTBlbfMbeIjzJPSWpCrf8WOBbxpouaVU
	TqSDBJhSAvf4hsKfob8mYtFS9VHdJD1lxWf0PTjZPkIR9fXUED99gIScnRC54nD7Vp6qneTWhyd
	kAzJI9Ivwt86EYQ8wnN2u6UsIN8T27GYtrfRGEYu/LEdpc5EEekJ8pitAQe1GdWvad0oz1DnLnP
	c/vqC3hz3mXLdqEAEHBSn08e3JntjqZcEIgb42BGhJ7L7edccj8QThFvWZbhttgwqevDk/X85Qr
	bN3bBz1VQ5zClj2g9NP/UWHvbJ+Mvt3J6vTrggsjgSw1GIQbzejofjh6l2F80bwyeJmALsMqdUS
	uDx274hfdpwX5Zbrx2RBgYGcgn0NFLNutrv5mdUPOgMOfQop/a2baP4zkdOAw8rbiUdkAzdsrMw
	cGFTNy4OWqRtuh7qDsqsEWUAWGaT53csUHxDLFPOxYTbqrE6ssb1ptRR2d3RHluN7Iy3mhRvONK
	yA4xRE0VB4/vrySMqjUQ7wTTP/d4MPcXOH8D7Nvs0MgL6zK8OXEUK/A400hPA1/lBsXXINCfwoy
	+UQ70v96xETKg3zlIOH2C386mW1KsVvTQ9ZHpUjn5TliQXnXGYLcD/pw=
X-Received: by 2002:a17:90b:4a85:b0:3ab:c674:cad1 with SMTP id 98e67ed59e1d1-3ae897994c4mr4981300a91.50.1793480283148;
        Sat, 31 Oct 2026 13:58:03 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm13250949a91.7.2026.10.31.13.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 13:58:02 -0700 (PDT)
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
Date: Sat, 31 Oct 2026 20:58:02 +0000
Message-Id: <DMJBP7BG3GE8.1ZXVVR0YIM9OO@gmail.com>
To: "Chris Down" <chris@chrisdown.name>
Cc: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Mykyta Yatsenko" <yatsenko@meta.com>, "Shuah Khan"
 <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 0/2] bpf: Gate dynptr probe-read kfuncs like helpers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn> <DJ9QOWVIXFHR.1S8UL5H0USVCB@gmail.com> <auN_R9gCBqNwEkKV@chrisdown.name>
In-Reply-To: <auN_R9gCBqNwEkKV@chrisdown.name>

On Thu Oct 29, 2026 at 5:15 PM UTC, Chris Down wrote:
> Hey Alexei,
>
> Alexei Starovoitov writes:
>> It's fine as-is. Won't fix.
>
> Could you expand a bit on the lockdown side of this? I ran into the same=
=20
> discrepancy independently and was preparing fixes until I found this thre=
ad=20
> while looking for prior discussion.
>
> The CAP_PERFMON side is now covered by 81c975aae375 ("bpf: Require CAP_PE=
RFMON=20
> for kfuncs reading memory"), but the probe_read_kernel helpers still chec=
k=20
> LOCKDOWN_BPF_READ_KERNEL while the matching dynptr kfuncs don't. Is that=
=20
> intentional?

lockdown is a security circus. It was broken from day one. It never worked.
So all these 'ohh let's fix it' missing the point.

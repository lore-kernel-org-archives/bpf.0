Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B4331EB9
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697446; cv=pass; b=Cz9ONpyTJ6vDVwMZTh/AxqDcpsWWZ7U0tTS1HCx2f7mkSnZlLBz45GoovXDZlG2YRBnBBLa7Kfn8+CZYJW3oyrYVcahAb2dy6VAblJgcZDGc4AzKOz9CVbILORSdb3n38TMuPCvmi5RPzdUVogZDcfTP/ThC1Ve/5CRS0PneblI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697446; c=relaxed/simple;
	bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5TzYbtC3W7DyQxOJHVm7kH1SAK0WflnVINo7/B8EzagKdzlRTPp5TIZE9OnT5eOzcWK7IjgTc9neQ5jtbX5JB54T17YljCl/izKJKgXQ+V2VGkYdVL/y+wVNO0k5N/u8NEG8RV/sugj+draoQk6raWY0PpIulMhutOZSZhmQro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHl6crkm; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHl6crkm"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd77300825so2346695ad.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 19:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789697438; cv=none;
        d=google.com; s=arc-20260327;
        b=k95duW3AZBwtCF3JySqFVdfx65y+3f0U73unxQMXuQnFI9GFYJ0KvzMbIonjRwC4T9
         SodLwe7907qnqrWw6rRFZ0tBu/Zyv2E1y7FJoEpf3aeRe0xSOVZAkG4d3D51f4SFqnlc
         IiXHnixgf63gIzozeXyJF9XRwNO0wkpCS4QivoyZtr9F7kWpJHhcoKBo72ydYGf38SBc
         VgAkVeadtanqBQN9dOMDtlx7awG+y6SWl8UkH06TWiqF9MqqJo9Hn13U4Z/y6RLOjPV+
         enTgu/OSnGkwNmFVh3Xx6EKj5T+7Yos2RFJhGfGGlZbcVT6zJkk0oxQR44k8cRUHk9/V
         Krug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
        fh=/n9aBF1bfgZaLqoy0tX1JDlf+tkijlzr9bWf+QLxZ14=;
        b=FLgUgL0YWhP10FSTLDgzuylw8/uMnRiKS+utvaCgoKl+p8Ru/rbh4ptcKg1WCAWIQW
         zfTflodHdfgBM3cLSGdQh41mUWpPawEX5yAGVKhWSk4T0D87oBW17c5A79bp/0uQ5BJv
         751EAl3fs3FGnt0dFyX32Gzn+nhQSN2mHA6KymWRxkgpAn+XSCydtIRmzGWK9Sznics8
         ShhFGtFTxXfSZ1C6owzlwH+W9Fvw5P6q3ty9O8EwDmov7dKQpdSKkUeFsl/MqYxvcUuY
         6WL2Becn2MnRiGKBmSX0XMExCnhx/mFvlIL7Ad8k8fz13Fh2plw6ccTmL9DP1S5Wr/lP
         jXPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789697438; x=1790302238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
        b=PHl6crkm73fjSPV3qwbNtdvvgUWfbFJUu75vjkG0WS8aNCEeA9ORcN7EEAakPNDLZ5
         YB0c1l6muddfY2jMfAQbqpw4I4dWROiCXZF1IOOVHmkEtTxJa7U1UFn9/7Rjzgsq4gqj
         mGosE/A6baJb9wFmCGHdBM8339JPjthQurWwpUx8s1xPYo7g5HZRuOKQzWDUcuPv67RV
         gcwXPG5GYg9XVP9gBkTahTWAq7ffG0ho0Oe4OAspYvF/cVgFb4gtmCith421CtJ5jkNj
         D+sOxmb3qQRRU1EFopCNaNUCXF6nV8AU0QoV5yzEmMUQo5QRJMI6Bav76IMMwcKU4C8x
         vbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789697438; x=1790302238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
        b=qWnSkNaHJiKJZGhMpJim+yoQoB88xQFm14s9IFiju/qiPckZlOta+lSvvF+QhA1h9G
         Im4dxZEWdEQ/YWs35GpJyNwq2qMkPjmikXOrFpLyKnkRsBf9ZTbJ2MFTHqnodIH7r9eY
         lC9zQupFhITc1cbKelzQ5jr2Llq1L/puSlNhGGYFtjd9951A0DTNzhLcNSNykxpg9RZ6
         uDxvRpLdHA1iAxhrVsQsQ2A/nx1tRja3+iUEav6m3G9WQBBPRokaxZE8YQKmFN2cbHpP
         ClKt4fiHOOCfLRoX7PdXcbWVNnrw8EqynX58aZlGHGDS8EV+gGHCWds0pHLI8zxzcmcp
         xecw==
X-Forwarded-Encrypted: i=1; AKwUvBydFneR+qrHBUM8HYuAlqyK6kv4YIreP9wHYBc7m61hfJUAJNS2tuJ21uXLKAUp5VnRfog=@vger.kernel.org
X-Gm-Message-State: AFuF++lGV5atx8N/JRQwBfEnkQd8Sfv17IpBCJUUiJswJu0um9mKKRnq
	MgdCpPAVtc3YX/B443ZgbgXs/9p2sEyOEZOpoKe372tJvnbqJ9NVRmt2ABuULts++JFSAvC6Xzq
	yiY8dJIXangJgFJmyt5lhGgPHWGI1Spg=
X-Gm-Gg: AYBFou0VEAYxTkaDFG1PTxFnVgMxbWn1fqKrTjJP7tAJUVfNUi0eIFlvKUHJPmrfjTR
	zGD+oEgZ7IlwPxzECQIXKuOmrkLHZUmPJsvMoZkaL1yY9zAUSmUie/vuKhEZIBHD/f5JFytC0xV
	14CFweKO8U6Bv1QN8ADlnQ5hdsufpwboz9ZrdZb+FTOU+7i0e76bTGzPwUb9yrZIr0pqWK+hv1W
	UJCbiPL6HiBKz1tNmZRfyMMDvBGkFaw1C46CGpldICcjtwQzTPBwyYY+IknddlLO9e3IBtoN1LE
	5cGYVwWiYmey2/jQKweVpqn96JxIGsZx+kdsy8HEOUyhRL62pM47IBaFf2bG4TXqXKneuTxN0X9
	3VL9jMkUA7TCKI+MhSIKnz7XXcNKgAoDtdt/3M9vdb3bVR+vQ+wL9SED/HZ8FMoI4624wvUkarA
	==
X-Received: by 2002:a17:902:f68b:b0:2d6:fee6:65ae with SMTP id
 d9443c01a7336-2ddb1ab3983mr24249855ad.4.1789697438293; Thu, 17 Sep 2026
 19:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911135711.109338-1-jiayuan.chen@linux.dev> <20260917185926.1bb7c430@kernel.org>
In-Reply-To: <20260917185926.1bb7c430@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Sep 2026 19:10:27 -0700
X-Gm-Features: AcwNN1X9hXr2f0Sb6Klu9W7uMPQkOFPox7maFcjw4UGshBodQT-bZgDlH6jEEwg
Message-ID: <CAADnVQKaXUj2uxgqerh7N_CDxneg2AgF9VJ2SddG=rgn1de1sQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] net: xdp: fix bpf_xdp_shrink_data() page
 handling on generic XDP and veth
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Eelco Chaudron <echaudro@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 6:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 11 Sep 2026 21:56:50 +0800 Jiayuan Chen wrote:
> > I'm always confused which tree(net or bpf) should XDP target.
>
> Selfishly Id prefer net so that all our CI would just run without any
> manual effort on my part :) But perhaps BPF folks will disagree using
> basically the same argument.. :S If not perhaps please switch to net?

yes please :)
all of xsk, xdp, veth can (should?) go through net tree.
We can deal with sockmap poster child until it's cured of bugs.

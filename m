Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54C2F6931
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185430; cv=none; b=q6fLK0VzinVWDFSjnoEQI+/q+qCmd6ykurNFDvx43EbXxzb6HHxqC9wmO0c77CV46UoIiNhvrfvuL30lxaBV06NqsJdfaYZxGBfvAB+d0bEo6HDS8ojq0u5iWeX0kiUPWvDqg14lzNJ+X85GFPSzzJJRCfZagu7kH6q/kHk5T3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185430; c=relaxed/simple;
	bh=rhCg/f1btHEhgY6jaJxTDBRKbVMyPzNywCnyXnU9k/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Ry/RozcgkyM/fXsR5Q6NIlVZmIZy+cb089/LD37eHc9b71jz0dl/fdqJb7Z/ka8V5MAPXPHKABJUXp8Aw/zORfVLRSkCklMHSsT2KHwLWiQtrt0/MkgRH60gZQgmpxnwqd69F6JuCuXTcez+AmyOqyjkmdIh+WEY+hbjGCdzc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvz6Lo6u; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvz6Lo6u"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f1354074so90244a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789185428; x=1789790228; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=koxO9eqWuwWfNZ2ZsfWk2w0ONjfrf6P4wItJwq6Zrog=;
        b=Jvz6Lo6u+J1PYLV29VSMIXZgTibsEvbIt0Rpbbh1DiY8lWKHTZ2aokRMYrSP9WINVt
         NzHNao4emzi5du5G5DcZnvKrecjb1ZzhrOYYUyVAwXC5JgIW//KZQrh9dU4wLx99uIFJ
         810wXxxjV9T4FtAZAM0WF9xVBLmuECv43l3vGDyqUI3EiCGnmbHUJghqDMWJkYk3+3cL
         yo8MqKMm/hpzJeDp2Ir03WrZ8QCnNZ+Bb+rM8o2Teq6xRbNfXpom0fbOj0e8ZVdKUWEQ
         9Lj7n1QO6TD0nJ763e6WyliWwQ2ilUmHAyYeFgNswILhqZbcPVuRLcKT+flA6JvI3E+j
         lvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789185428; x=1789790228;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koxO9eqWuwWfNZ2ZsfWk2w0ONjfrf6P4wItJwq6Zrog=;
        b=KRUus+8RAAC10tTR9PxWaYCjWyqW9W8SZbvHfBC0vDISxi/sI7qTb6hK1heasLukj4
         YVOjRWd54E2PHaVkOp8bD2llM9VBaE5CtK1jFUO8z1LeTI+8WcEniQBPzm2NcixZTzmU
         wK0AQxeTYDzJUBFmjXuHIHNSBGmzwLDyA9zmDGjuf1p9lu2lDFgycjPHZRsgjbHj30qR
         UlkpV0twI6lC+SmtpN/1GqAiSutZrsIPJMGAQGwL9gt5u+Woxz+ctr1B28nSXgtYf9yu
         DA6/yOFJrm0fK2miqO3FBDX0dOg1whxzXT8Y4//lQLrHlIp+pKiR8sdebT1RFiQMQPya
         q/Pw==
X-Forwarded-Encrypted: i=1; AKwUvByG1WmcXlxgC2CT9EOl+4fsbHdb0H/MgyAJyzPWW9wihPneIzAX/0q5gU1Cfounv7Yi8XE=@vger.kernel.org
X-Gm-Message-State: AFuF++mGRZsU44hXeBlhMKQtEELBCPZ2Qyxvp2Qy8uDJCXya5nKWFVh2
	cUE/k93uX20G36jr5S16pRImmIXAkos7BbAZTaaJHYmt6Jpus88TS8LQ
X-Gm-Gg: AYBFou1A35OcdlNeda0i6s4NhvUgWe5otP8zr65TewGUEHXD0vnRGHFazYXuH5G9yfb
	Kj1oCFlrWhK4nYpe4ytCyw0bTp2GNU8GiH6fP/9mqdl/r0Cmqpr8FxkkUTJKcvHPrhWZWzqLVXg
	0HFHVFS/DUI3SXU86KsWLDEKbD5qBkx+cca58nf8kLL5cerEKcHUCoUb65mf4XG4+ng/Ei9xbSX
	rEJIpupuXjXp+D9JqWwzNuLieQKgUIPpVQVwi220UiyV7vQi+vWnRjWAR++A5EZcs0E5LTrKyv3
	QpW+JYuL2OQUvkME3sfdanJNW2+LSC8gs2zONK4ir1m4cM6V5AIJ7L3RyZQ9Q8wSzKbOT11jcdv
	A/vLAK2sGGD+O6KP7dl0BankmjVRTiGG0vjtj6fmCiDz0189IgzF/q13edlI+UISudcCs4auqjL
	hliUWdZ/71KLjLfIJwQ+xhcxXR7PFkBNCByKF+CD68WLP1O1Qow4N+Zpus4/TiNK2xVBflGq3fV
	lOeP30D+ygmMTiBOYuyAk9NZKCHgrPRU6UFrC9LjuQxVQU2pBzC/4ILjAABBIZu
X-Received: by 2002:a05:6820:6ae8:b0:6a1:64df:7324 with SMTP id 006d021491bc7-6c0a5abdaacmr3938966eaf.7.1789185428014;
        Fri, 11 Sep 2026 20:57:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:c::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0996e0f19sm5245040eaf.7.2026.09.11.20.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:57:04 -0700
Message-Id: <DLD1ASZFWOJ1.WRUC6EDWQ9CM@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 15/15] selftests/bpf: Temporary hack to
 disable register mismatch in arm64
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
 <20260911155030.2012652-1-yonghong.song@linux.dev>
In-Reply-To: <20260911155030.2012652-1-yonghong.song@linux.dev>

On Fri Sep 11, 2026 at 8:50 AM PDT, Yonghong Song wrote:
> There are 3 kfuncs like below:
>    __u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) _=
_ksym;
>    __u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b,=
 __u64 c,
>                                             __u64 d) __ksym;
>    __u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, _=
_u64 c,
>                                           __u64 d, __u64 e, __u64 f) __ks=
ym;
> which requires that '__int128 v' must be 16-byte align on arm64.
>
> Current pahole will reject BTF generation since pahole expects
> '__int128 v' has start register 'x1' while arm64 abi requires 'x2'.
> Hence, btf generation will fail.
>
> This patch is a hack to disable a few related tests to satisfy CI.
> The following is the fix in pahole:
>   https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux=
.dev/
> Once pahole patch is merged, this patch can be discarded.

You're adding them in patch 14 only to disable them in patch 15?
sure, pahole needs to be fixed, but let's carry such selftests for pahole
out of tree of the time being.
Once it is fixed and we have a mechanism to detect that it is fixed
then we will add these tests.
I'm not sure what would be such pahole detection mechanism.
We don't want to bump the version just for that.
So imo just drop such tests.

Also rebase to bpf-next is needed.

pw-bot: cr

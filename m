Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42061E9B37
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111962; cv=pass; b=UcFbLaT1YaaOGM+cR4LhQW4gLJLV3H/Y8YPJUVDDNd8M+B2SDuprqP3chEiWMPt66CSd4cnEPdpzSNX4AQoUsUCeBcrwvpHuq5KCC/Ohuqocf5yMMWhxZWxvSsImEqBs9WDRLwMfeFXpArRCpa4HiSX5dFsg1wOTGK2cU7CiSLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111962; c=relaxed/simple;
	bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwZu95jyKwcPoEbINEYcyZD3ACHNjzZ/WPkZOomJJ/dikuGdDt3fcmM9z/hOBO5GANqhR7LV/qY9Kkft9KNha/6Qf4zT8n3cij43ENKX9s2bUg4yBaRWGVNgsRRb0dvpexc/GI8xzNTNZR7gjgzcklvvoBLAI1CR5OYg8AjPtY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtlKGQZT; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtlKGQZT"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa619653e4so398649e87.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 20:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780111959; cv=none;
        d=google.com; s=arc-20240605;
        b=HRpFnp7yflnyKo1g6YPJBI6n5ljmIMzdW/5erxDqLlwQKV3Wvggib2icTYH0IIyS1s
         KNYYQyUYllNni5DHMmNh1KVFq83dnKoLHSFy2v4RVj5zb2S3Tsb2Pdzw9qb6Zap1weCn
         i//Np0UnwzMd/Auzjei1E4AQYK1M9ZR6pN8eRN29M4ZMYzRrfwYSCxfThBHPmPt5cnYS
         7KnjdQaaaE00dkn4iZgCXZlY02GCH8w9w1YyXMQ78UhJFY5/I2Dn/3mOcxixF6seeWKQ
         yyrnfCmtGBleiRchyKxUBxuX/xSFhZweauseI4xxX7FdJaDlce/HtfFgt35p21B49d49
         rADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
        fh=mKOlZEyBGy8+Om4/24VNImLM6/a487uqG/9PsIQ1PPY=;
        b=XivK8TQixBu49isu9aALsQXdP/m0c6GVBSgjS+YTfA9W1Xjj7hPVGm7uU6N4uEQ7Sq
         VhlFtMIFYuIWr4U1oxEu/nENGOLmQAd2YShWo3KfMvn9OoII7R6rIJjR39Wlfm8iixKX
         ZmxqDXvkSqUO6fP3p1Pcd+yt8KNPXLdbfMeUice8oMDgB8CmQpuJzN/kRp7pp00LdS4V
         /Ld+dVFQWOij2KSmkcOr24xfJtl+InF/52bNw1WxtO5f1NvvS+FOrp606ZTCJ7aKBAA+
         CGeo0DuuLM9L1ZXP1Mdq5JUTpnjqSKrHjKfqMFTL5/5xPHTtklo5EEOm7RR1NyJEFg5k
         4JwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111959; x=1780716759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
        b=EtlKGQZTeq7aqArxCKv9IPWik5xDmB1gJvBHHunjXW93AbnqW4wsJnLWYvEfKMz/oB
         WBCbGvPLFEvGw7VmtkO3u7RRU/GqkVsDmlmZAaPkkUj5krVyocf5y65jijFDQx/3K38m
         Xf+mODMYyuIM29F44B6uJYb2J3NIPfmw3TZY1xpVT85BEsw+5ReVjplloKvu684YKHKk
         17NkU9TWnNN/ptiWZ11pIFhDsGj9M7jQDvaVvXShNKNULL1uInwcWV4pMMSjzvprdsPo
         ysd5mCJU71BwnveN7cSxkocjgTApbpwkG1kI/OZldDaaYkR1Ol17NgnsRZbiQ5lMdDLG
         wIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111959; x=1780716759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
        b=bp2OUKb8OKYWclxwWcgD00T6ApBFF9ZLpv01xHAU5rUBMkXHU4mM3z8efnpqJrRcsq
         oTYKQNj78cpRcrfMLq26Knav9b/okoQOwZtO2airfXnu0dhJZbsj5JDkjchRwzvaePgP
         2kZCX4fTmll0Ets0FD+1SV/+qB2kMIbg5OE1jHIoT9LsABoud9X+fltVWcAssbcmMWex
         FiMk9lAqScDsnErZc8DCgdQpe6ywVE6pf3U2/GXEbMrcnvvTQzy0wNk/PZoDJH4Tzj5L
         PEJgpd8ehcztFfbCnZvVdfUIknKRMLUmY8QJXlAWKRr0d/uHFlK2CjcE1tNMyR+DHyp9
         0sTw==
X-Gm-Message-State: AOJu0YzqynvmcnBOhfEvjFjgc9eFfpHDGIgcshe3pqUynAljcCysrMRJ
	KPtybnob1MH37tYwri+z6QjM7EsGfE7PYmcV+zjDagi99Za3bE0KSzNeCNLb0li/2GPFItTmdNz
	FWoTgh2WSNdxXJAdB9LeITnK6+xXxhFc=
X-Gm-Gg: Acq92OGd8bOzXcHkh+MkxC5WtyHK6eIy9PJ+WM9yp8srkRtUSNVKksy/R23CLcOx7Ys
	ntWi3k1BfCc1VQWSjETEjB4LdorRHUGy1kLAZV5LuEtHbtg/brjQI0/vHXrzY529JNDRIW54sJ8
	mrZ9EhagQvIYoDAteMdlR2zgbXHpLmjHASwRiYEV9R14N+xXpK2Iim0lKYsTy0Dnl/qtzTPZ10p
	enJvM/YJk9WNec9ndEKWqw3V5kdza98l6QtOAM437FeM1IRAE5Garnr/TYIzBGAhBw2K7FYwjLT
	pNBqzY5kV/+EXcUlO/4HwW6xaI49AsSRbYc86D90P8NeHluFJQ==
X-Received: by 2002:a05:6512:3e17:b0:5a8:8818:819c with SMTP id
 2adb3069b0e04-5aa6144d682mr435863e87.16.1780111958749; Fri, 29 May 2026
 20:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529203909.1222164-1-martin.lau@linux.dev>
 <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com> <202653023041.2jVo.martin.lau@linux.dev>
In-Reply-To: <202653023041.2jVo.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 30 May 2026 11:32:01 +0800
X-Gm-Features: AVHnY4I3EKSj9TML9XJ-lUKmnSrKBnNIYvvEILz1RBOfIuKh_OScbPnlbV0gJ-g
Message-ID: <CAL+tcoAXEkscyQc01rVYjp+OX0AwSZZgpBmtsQF4PmEepXqtyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org, 
	Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 10:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On Sat, May 30, 2026 at 09:35:47AM +0800, Jason Xing wrote:
> > Maybe it's not an appropriate timing to ask this, but considering the
> > further development I really want to know if you'll continue with the
> > latest series around struct_ops? Or you will delegate someone to take
> > over your work?
>
> It had already been discussed in another thread [1] that you were involve=
d
> and cc'd. In short, Amery will respin it.
>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20260523083001.2=
911931-4-kuniyu@google.com/#26971716

Ah, I didn't realize that at that point... Thanks.

Thanks,
Jason

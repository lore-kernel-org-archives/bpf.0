Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E053328F7
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476168; cv=pass; b=qhJeEkF8gRjL2TnMnBAeYm1TBdLsUKCXAJq736t8huPgHACoIq+5HoUu7NJNsRcj0Ftw8OoEkN0Y15T/Xm0s32neLlhhMWVXdAjRIHVCv4/VXSwkIp4dQPnI2TInEh7dBdMDZZIXXcksYO3hmhcZZ7VuukuDEiQ0KUVoaxMt4+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476168; c=relaxed/simple;
	bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noxQ5iWCQbSMaN3oSTmMdXl4ru69nCA0Rd2YcMOpE5Uf8DpFbuGIA8JLX98kuaobqFf9qYRH4bcxDbg18fU+35uqPSQp3/eIAhcEsQlcyTb+4XPu9owuWRBq5T5KYLjLYWZeYBiJrFlEsc/HS6YEzrd6c/0XXBmZNWtJs48oKdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcOglI5j; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcOglI5j"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so4647440e87.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 04:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775476165; cv=none;
        d=google.com; s=arc-20240605;
        b=NzlIYcW9AJU/21nTgqBgFGYxdW70zDmbQ4p/qWtVEdlVHi6/X0Mb019jOnEsgBCisg
         +YDIWUqRiaDdQp9QYY1YwdNBds5Rbjcts7qixEQ2fYWi+X+YIrWpJ3DXr0it7vOxlLor
         aabqibPsl78MRR/bgqTySQbjvA+pVYsAd0KWCaTOh+35nXmqGvmOyZB8CQowuXQvN0kn
         jxmC7csohL7hRRITIrldGBqHh71q4645yLst1o1HkmR3vKbrKL88vIB2OZuioq06dVbK
         3vjnHNOnde75dYYRd3iKvXsK3S+MIfIblIlXN88m4z0SnpwbmCiXHV6dssUcLzZxbSe9
         eZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
        fh=iKz+6usSBb1YoG5ifiMXzjThrU0pcAb4/HP9Cn5PoFY=;
        b=MALXpqPYMSHSvY5O1PTYPfRRLEWp1m4Wayck2Skb2NWDvinl2Dm2UR9Rz1RARurORi
         xffYdG/wAJnbpVnC3hzNmJG2dzlvLGz4i+waXPpnKJtyalI2ALqpTnrkkkK+KRnxerkx
         MZqeBBliHzQm4KZ955d93TjgWyOqxDUjWCdbl4jrRIjf63/7oPVm/AzMEiHu4GTYS3BT
         labPfVgg6tZimO+kaOo/tIUFCJvdFS+US4bbU5tQFAsl6yQASLkvKh52pmbR3dLDJek+
         IHkdPpTUrQJHOgqSADKko9SEFspdGII0wbl6SvanR91nHpsBGTtAGLZBcKuVR17vktzc
         r0RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775476165; x=1776080965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
        b=fcOglI5jsehh0OLUav3l6WtazkrOY07ZdrKYZhaSfYnDDce09kMYQOECHjgzyCUOqz
         F5giq+P/FamImBrc8JJtm7s0Kd5zIAlQ8X2qks6FXtx+npP/dfz+wjhQZL//mnntiX63
         WQfmalsWt5uHT7DL6yAlDvTILL/f1n9zINg/SJ+tPcRRqp90nCDCPkWFGWFSfuG7DlLS
         Wz8FoYEMkmvxcMQvMW/2GXBkFDGFDBS3IojoZWF9Yl6QuBSfB9c5ZH6BCSA0k3YT4ek4
         P3XH+e3IDk7svYTBG25Kjk+i76D9fUNT1Ko5Lz1xoqUOi2egnNiZ7i+cO9/yrb014uGp
         XXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775476165; x=1776080965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
        b=beSWbUJ3MB8RTn1XIOUGPwlv5l4Gj3a0IXZvyttuZOnglmmU8J15Eq5U3z+Fmf7mtH
         WTvntyefyiK0sVI2ITA38UgEVL8uLXnrzUDs2PO6kWV/WTwO7she5a6GDWl/HzsBhIAd
         xxGZQEm5b2ry5PheeTn7uH0dVb+zI5rR5+ASFkWe4a7b3wKs9LxCgQTG4sUZ+vrl+owN
         i2VBAOpp8mfX2klPrmW6urcneeUdsReJJzgl4clAiuDzHkSH3tYEHJ9Gm2vBms5Z2wmr
         o0cEcb2fgKb/Syz0CuOaya2//EpVt463WMeB18qOFoQjyGB0s7JKLCcV+BVkxyB9EoyI
         4HTA==
X-Forwarded-Encrypted: i=1; AJvYcCXmINHKXj9dTIStO6Zu+IaFCZcnSpbkHlMTGqbAF17y/0FhbpwIBH/PfRiuGmFbltMRaj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1GYYeOvUsA6JvOstcTM6CXs/socvVcXtsa+JQhOHDwNyrm0t
	CnqGESwGaSDwKewXfp/MYXFgVKMwnx3MkDtl2gTV8AfXKyVUztp4kop8PzlwZywTKpUp61CZAWq
	6hcPWHRE5j2nhQzeVTmoBVDkaCzZQUKDrjA/Uelc=
X-Gm-Gg: AeBDiev1cHIrP13KjnSru+P1W/MK39HR2J+ByCiEaOBo/Xf7gwe6kCy+n641/+U3S0q
	W8vNtoP/Qv+iVIXp1AJ7v/Qsfn40XthH2tfu5YWp1jTRhFcc2+lk7D7x7WPdXaYaYpWJzxL/dcJ
	Rr2iUeJvfq4OtlsgytiF3kI8X3f1taZLHMzZkQq/fFqFN3mvEh39a+YEzXxZI3l+jamY0L8WZCT
	pbiLxjGTuVBrulwG9XSRuq6gsyDNipmG6jNUDV4f/2xrrCTS5XfqVS1SA1JW/8heGnF9fNu23be
	JOw5UzQ=
X-Received: by 2002:a05:6512:3044:b0:59e:57d2:75f0 with SMTP id
 2adb3069b0e04-5a33758ad0fmr4630910e87.32.1775476164770; Mon, 06 Apr 2026
 04:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-3-kerneljasonxing@gmail.com> <willemdebruijn.kernel.c2ef8ef43869@gmail.com>
In-Reply-To: <willemdebruijn.kernel.c2ef8ef43869@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Apr 2026 19:48:45 +0800
X-Gm-Features: AQROBzBLd1qJZJR7_3XJ4RB9kCGoLhjqb3qGP5BJWelUsV1v58MJj_BN8Rtdwv4
Message-ID: <CAL+tcoAdsBBVa36ocMqiuUT4goratVdnNNcHfKcwcwm2h7cujQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] tcp: advance the tsflags check to save cycles
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:23=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Check the tsflags first to see if the socket timestamping is enabled.
> > If so, then try to fetch the last skb from either write queue or
> > retransmission queue.
>
> This message does not explain why this change is made.

Oh, right, I should've added more direct benefits.

Thanks,
Jason

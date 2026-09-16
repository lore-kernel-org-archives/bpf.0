Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462744AA032
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551713; cv=pass; b=J427Oy3bHyEZ0hottd4xlhIYdxOXbiQUQ/68xbXaf7Vx3y8t72/Z88L6HnkMcTS+AlBd2xX6K++x1c92XeVL1c29p9AqWy8UW/y24AyPKcdkNYBDwcLgTkOS8QzSHNej1tupTtIwYym2tDq4MfPzNRc0fiJkpRDxVE5ke5nrNTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551713; c=relaxed/simple;
	bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKge9RLGbD0ZkVBPC6n9IV4thSSZQUBxDcwMJJmuuWkvimXitXJrNDKUfncSByEoLLbzup3rLzWB6S3jdBTLD8y+p82dmgIZ4doXaRQX0OI4BkdpG9I7yroo8uMnFv2P9sEu1Q+aDX2wYtTG8zxBgsRhjGzunwEhYyZHuSW0mEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQck2Eax; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQck2Eax"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067eso70167685a.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 02:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789551701; cv=none;
        d=google.com; s=arc-20260327;
        b=SOdj4KUgpjU2FH6WnDZbyYp/yyUCUeC48cmaRbYH5+an1mlBLNSwMlV5g1WoTvEEGl
         g3F8aOGeGsCyllM4TgLgRC3K4mtEcs0ond1z8o4XFNFoiZo1IHC/6PqPwIZEzXGHkpB/
         cSzO+G5Ri6v6Ji+wjYV+dY98AO1qWm0LvP8k900FW72BcGY3563txtY1vTFXfCR8d6C3
         bnw1+B8NPnHNPRlxezXRSVvmSCMN7SJudP7gJuh2s9hB6Y9+1vvx33+u9togM7QvVH5q
         IEV3z6/LIgE0lXfowXj+6D4/HzFMrr+ViYKQSzCcdJlFsKRS8j2jMImFACsHLXQV+4fY
         evxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        fh=pFtxxFq8uVT/J0A7CMzyZNiMYHiG3NqmwxqwUytZ6RI=;
        b=KXio4Ha6DkNky6ybU904dtgym+JvDzOFl9aeEu81NO5I/nGDzNk8+Oc5CqKZZau258
         NxQtx3sd2bu30onvs/mGmOl4vtd1oCy2RGm/AeejuKZRpOnJuGMN8uQz9wghLCP3J6qW
         7+61DqBGE+WErHRzTO+ldJ1dLfur9OYBAND4lPgUiQ++HtwpVHscOXwSb/Q6lQmg5fcV
         Fr/Hfd52bD5JQT+BUk0yMVMrqNoVuw0q6iW+ROTRdhnUBepdZLma09oqqMOFIQjVpsLg
         X3nzigj7JTvbi8rBxqvCIxt2thkcmUiO5VUlFmvIeiZGWWQfope3aUGSpJ4qbo5XJGYc
         2TKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789551701; x=1790156501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        b=qQck2EaxCKi4Uv0sJjK3manqk1cVY7UTs+3b6Rg7JosOC0NAhCZTy3X2x9wUG0VV7Q
         WcNv/i/HyuUlGMTnc2y4LJEMccBKJsEiITHqf1vysluHNcpxRYbmligHei4FYY4IJIV/
         QAr5Af0qjKwl1UtvyZaLvQCUEcZ6CpiU0WxdoAXkDzkP9lS3eQXamwqkwX88tacqgAID
         7XoO/Fb5o4U/p7+Xna7qIIL9Pn3KoSnMxvsv5/ekXojPfgns+1kJxR6QNqKQX3PD8Kft
         9O9F5sxZF3abTKexlCbyDCQy0usdH+BmLkdq2dp+QZv8pbE6/+wIulSeb4BaD05Dwh6d
         oBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551701; x=1790156501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        b=OoUkxB2y3bwwLBwiKdn1cYXpwVa5QXRlVlxogm58kq+jofe+7cUtkLfSkjDeYb7PnU
         1UkG0DDrFBIExQWjxSxwwjXy9D9xh9Lb2f6WDPRu1s8MUq8MhrP1zZg/dv1VbhMtKs2a
         c/ld27+WYHPmqhD419qMKLolI74BXp65T3b4/VFBDpakmsVj13mam8UqenQE/P6CmaxF
         A7bezyAprJDwd7hFuwWDq6yqCcW87BuUWFybgFDoU29zE0uNJD+G2VAZ9AyBEAD/hqyC
         fcd4ytpY6iRpi81MBehNno3z9ZA2c7/UbosIdh+SBHn+k+21/UOdErSv5I2NscOF6avE
         UlTw==
X-Forwarded-Encrypted: i=1; AKwUvBw/SQy50lxdfiYgvj5UmiM7MxW40eBrQUvIwki1outSXFU0swQ6d+Ijfek9R8JNJHpr65g=@vger.kernel.org
X-Gm-Message-State: AFuF++novBncyxcHpYWS5yFpadoA2Cy9kZWK1S29VKj6x0bYCyCaXe3E
	/49A538NzhS60ytCozRmRI3YOk/Jqipenl/DZ2VabmD99Ji+GQ/7K2N2nYoPivsFO/X5f8dKjyU
	wWYqwwQ/fBOLepW1Mu7qDrC5rGGjlwq4fUjWHZyBmTHiBSmKmtUFa5gnnwOw=
X-Gm-Gg: AYBFou0Cu4VZ3TkMZLRke5ZSyMt3OOBdEjGjc2nh7RBZYF6cg82SZuCKJUSwSWPvHYp
	b9MZTwrA2+Yv7E+VvWthVmF2YimAk5iO8WM6AlJ3UAC1halAK6fFnHtTahNULzsU8kT843JXhmV
	zC30UDCqz6/9SQXsDcQ3fR+qgAK47gs7BmzcHPnzJrzePQ5Q15HocySzVJIrJV3v+ruzxj0wVdG
	bbj/sG/TjrkcvsF0gdmpElZ47JK+ZqEHQZA4v42WHTDp3ECrLgr2rb9NYj5vrFmlc1glhgkfGEb
	AxC06ME24yEyRk5ZOV6UYDi4or+I13huGaDFzpqCblq98SW7JW5RHsRAdrsXg/z6RYaJEqMjJKk
	Y8UbPU4VM4wW73t1K6RuvKX4vXr3d7qKpkafxCF3nS5TdxniLa4ShD3Vv3c5uMnP0MUg=
X-Received: by 2002:a05:620a:72d2:20b0:93b:c22a:e98a with SMTP id
 af79cd13be357-93bc22af796mr17857385a.2.1789551700440; Wed, 16 Sep 2026
 02:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916041102.1914333-1-xmei5@asu.edu> <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
In-Reply-To: <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 02:41:29 -0700
X-Gm-Features: AcwNN1UxUZyShrWWdOdzZP5TvGhMt62DuqGu9sAhw7uSD_TZmpKiYAfpJ3xalwE
Message-ID: <CANn89iJtyY_ooHfbqPw4=GVwXQeEc0k6RxS9dJGnA8TZgu8rSw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after pushing
 an encap header
To: Xiang Mei <xmei5@asu.edu>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+ff13a35f73bb7891@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:32=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:

>
> I just found Weiming post a patch solving same problem:
>
> https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/
>
> and that patch covers the cases I didn't consider so please ignore this p=
atch.

pw-bot: cr

Thanks.

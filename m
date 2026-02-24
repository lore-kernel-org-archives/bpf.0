Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB633AD9C
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958339; cv=pass; b=rJ0fJSj5B2GRoyiMxtGVchKKEtzu50cHx10Tv5R008H1AFoygi5iJmlWXEZr25VFuaBVMBE7DkVTKgHoKFdDfvLIrLsRxxMTbZd2lgArZxzHTNYD4NDPEWtuwlDw343n6qOo9PxCCiMX4PnFkeBic7PJtzNxho9djVeCq/142aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958339; c=relaxed/simple;
	bh=K7kvTHOArQYAWzy2rSddhiwqMf51UupHjCLxEpMKLsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4Pd28jzIZ/N87XFqQIg6WP8zxZPmaiNzvucuRMlRIQYq7gGFcG4L76gB/6iGJXbh7QmIYGyTNC+9heM98bgn78t922kaHIPbGvuSjZNMYCh3nwtxTt6MXuYYGwI1jG7rLlwVbqH7aBwcfZ3MHUwZrD5fO+0stRdSTRwm6tAKEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHXo6DV6; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHXo6DV6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435a11957f6so4931376f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:38:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771958336; cv=none;
        d=google.com; s=arc-20240605;
        b=W+0myijG0WuoQ0lE/RSRspLbgN9ce/nc3+wS+2fnd4jW03dMJPmaHp8o4GC412upq0
         rfqdqBdN0sDBpZu4z4P8XCaL8jyBRfXBQS2GyOQk4keC32A3stxSj+/UPWfEkQ+FyAT+
         fFY7ZIfHY9PJNTs3J+6Fe1AJg7r4LoEhwglHRPNw1dYrkFfrn4o8vS3yCGi4QDhTwTuQ
         0QUcR6m+XTUp+/I5LOzNgTjTVv95oHA/8v3VBG8VJ+rpDB0mIb9SkRoHxodk7VJqWrkr
         SwL/HL39vp2moBED2rdMQt5UnmTgU2kYwrOjG94/TqR9DFjtIs88y+oD2wk18XNbl32S
         FhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7kvTHOArQYAWzy2rSddhiwqMf51UupHjCLxEpMKLsg=;
        fh=0d6IbbKd/6ZlTlVOg8O65RaowrgzHYwjmqnI9LzuxBs=;
        b=E9umDcHHOXwv80zYsASKNRMF0aW9o8EXUcQQCDxTLUkTz9PYCiZwUIOgX04T9lCUM9
         l/r+Msig0ik/7mnJ4A0ZX73xiRDnhOuIqBFH/I3WcJ9wxKK3CQ6wWY0XYezJccBJSoog
         vUSQqwvOsuJPK0GiHyuoKER6KM96fAlVffvQfJirM0Zzx29A+f/EpbKuf2WmqhW/N/q2
         G5JVtWT0+1lE2d2oItmEEg/A+b99yUcxisFxmJI6caEiJwhYl5twx7WqG7QICm7md1N2
         rr0xbUG4ALRoEHc/5+ZmejUfX0EqskR58anFVo5XhAtb5TDKU+5vpmKjWpTOvI5iWsXu
         h+4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771958336; x=1772563136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7kvTHOArQYAWzy2rSddhiwqMf51UupHjCLxEpMKLsg=;
        b=RHXo6DV6uswNvziZKHEm0C7Hx8Sp/2uswAPVA7SYrRLQlZvlE3+oxKaNBVxIMRqmuR
         igB79+aRAQolXY3KENVF2IPccUEITtUyBys0QDED9wdDNGKQKEOfHt7zHT38UqfxOmRn
         cnWby9hQlYBIsqYKQBqAjzWMego5A/e2/mquMXLmGl5IuSgBvN86aoYc2I83ZyznmzF7
         wTYHTJuRs4JP3LmRL9WGXJu/nc5XrC3baTJijrO3Pv0ICu7XUKE8Pbxyj6+rY+SLCoWs
         JQDBVdAX2BjQwShLUZghNP6J/uQAJir5Qkbc+kuBBV9h1qJZGV2Pz3MCoJaeDmbytzRU
         q58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958336; x=1772563136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7kvTHOArQYAWzy2rSddhiwqMf51UupHjCLxEpMKLsg=;
        b=vLBobzaOFaregt+ZuhXHvj031p3qPjhDvKfqmDUqoKAtYnEBsM1xZhRyExQcXQXS49
         o46nU++HGdFteGhjFpsNyGQlDxVZq89Z0xSojNRiTUcSesO66DNgB4+U6ePMQiX3ZaCL
         FMWHKBp3cekoEfy9HtSDy8TmjHOI+r8favfyM4AH1/TMAiHdWMuh2tD32fmATY98EGDA
         HBsc6kiA4Pj9xORcAjuPtmyVzGFs9KbiCq/Cd0ifKb1EWi2bfx64jVcZkkSZq/iiDN7S
         ZonwDS+Y95dy6mq6lKW4fwMvQoY8r20ditiMjGgnW4Zqey/dY0gkamH0JSnTEpuhZ/Fr
         rCew==
X-Gm-Message-State: AOJu0Yz0oW1afYiUxEjyqjCI6DBG1e/VHCwleS6drXGmI+YAzQ5adddU
	0c991V/9HsLxCjOlbwn86n24NFwHis4CS/qMt+XUwindRnxuvsgCH8Durv4iMS4xjSvF26GLVAE
	JxYGpF82hUmKpAFissneAGN6F91rDv1w=
X-Gm-Gg: ATEYQzxgGD7fAGRzYL6KQMVdcIny5KsSxDap/5NN0y6QNcMSvAfC+Z5TyK6dWx83d1A
	VjWiq06WuuAwrhBO8afDwP/AdRXSF12l42BraoDFX1xBJNCP9ETdKbuHqKvpXFPKAcsjAoXXYsj
	E+eiDX7Bn3EZckueMmDI9GbuacPhNZ3F6aaJPiQcAU3T2KdtXaLXXwplLemy3aVd2ATOuEhsYXL
	T4/1k8zN0lI6PyXOYYCkcYqJ/PGehsF7kvc0FvL6Pjs96hR63x1nTUrZGB9R68KpEB57sW40tcx
	t2GEiWfGBWphSzLxSZ94GOsFtw8LR2uxUF0Xx9VE/6wpAz4ef6Myj5D9GqXXAiaQupFJAwedzhl
	BtNqPMAaQ
X-Received: by 2002:a05:6000:2401:b0:439:8da3:d786 with SMTP id
 ffacd0b85a97d-4398da3d876mr1582482f8f.11.1771958336168; Tue, 24 Feb 2026
 10:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220062959.195101-1-hbathini@linux.ibm.com>
In-Reply-To: <20260220062959.195101-1-hbathini@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 10:38:45 -0800
X-Gm-Features: AaiRm50wWy1gpchaOq6eMShZiZdx5u8uVS1KygEOJyb0__MgI9eonh1rzTjLs5M
Message-ID: <CAADnVQLVO5zt3d_5R9a1fbL1Neg1jh_pgNicLSGYSzEk1aB09w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: do not increment tailcall count when prog is NULL
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Abhishek Dubey <adubey@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:30=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> Currently, tailcall count is incremented in the interpreter even when
> tailcall fails due to non-existent prog. Fix this by holding off on
> the tailcall count increment until after NULL check on the prog.
>
> Fixes: 04fd61ab36ec ("bpf: allow bpf programs to tail-call other bpf prog=
rams")

fixes tag isn't necessary here. This is not a bug.
Applied to bpf-next to make it consistent with JITs.

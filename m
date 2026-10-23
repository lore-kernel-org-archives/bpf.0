Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717454;
	b=DDu13yPuDUbWVvq+IhavfevG638m+Qu/V0zX2DhvLS3xAiUHjQfqpHZntZG8aPieascj
	 hI9RnDfORA/yVy9n93ef3cfDbZfNQKQ/CzW5zE4r6wRB20BMq/CP38QzfQSQ56/2u/8we
	 7F/GuRB0jFBskKj2rGzkbmjCHgcJctDassocxlV56Qje0PqHMsY9wFADzEJa5iNcM0HCd
	 S2QGRE9p1zkB4OvGFVGlwt2uy7+BiS7A2YScA5BA4vKY5/JY+uqu7hugxYdvy8AI17qPk
	 Bt2dIBt3u7hD7r5lLtI6p+qMvo5409G/RL2rB3BoSd6o7QS5KZ8LLDXdR176Y0NgisA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=bdGaF6C6K0NkhVjXmOTPr6zMoMo2uM6TutA0fZAEkWY=;
	b=QYdG1+arElx/Af9qRlCVLYJRS1+HO4RUxDbPsu8VvCRfJpmWu9MqfpNleUggW9mdpHw9
	 eyH0O54JCt1SchSrdt7HXa/kI3eOJ7Js0lTWtfOcNLhEMUj61XrnEHr/BqzjfCwEMXuUk
	 FUh/hjOgxSgI0ItuQJnNb9WeLF+x0PGhmeO2F2fQUk7KqVMR2KQZ2iy7XQogOQafEXl5v
	 xdqjRdJClmJk5FBhgJZPEFZWGtpAqZ8N9mIiDdD6hqQPITuZHIdbmuz1FexyAoSwcwN9B
	 WBDDqydGwP0PSHrKkOvj+0/53KdeBZQ3pWu/KQ/UBttwK/XILIxB1XNw0K6c2VQRBtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=czX4NKZs;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B5606A319
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145B5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=czX4NKZs
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-16079d54c17so796054c88.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792717453; x=1793322253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bdGaF6C6K0NkhVjXmOTPr6zMoMo2uM6TutA0fZAEkWY=;
        b=czX4NKZs0dUQNwHwJWza9sSNlV6Q2VPBojwg21XgOhgfUq8AzesOBNMokxRKne1+NX
         vSojqkSWA2h33ovyalbWkPox2WTbwzgCka3QuZFBp+EL/R5R14+EXJttQgP2jW27BX3V
         5wNiCO+FOEv1Zzmml14YXKprPBwcqCCgFYqQd90F7r5/F4qzbWFb+nNsuz7mGWB7ULf4
         8/EcJ3BlHqub05qYQNR1sLBU+Rmg2lLu2vZQndi+gtHjcKEVRwfwOI8UuJhclLDfepvJ
         6yg2DXjjMfYzPTeczJfMNoCT3e0T9+1ayBpGkpRBq6N8lO7PipzhgSZBqI/YnZr5iDJ2
         ew7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792717453; x=1793322253;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdGaF6C6K0NkhVjXmOTPr6zMoMo2uM6TutA0fZAEkWY=;
        b=Ybu1pnAQJRlE3+XOFCTZVBoPrPKE9R0+iycmD8ZiRFiIFmXQFhyYcUxJEolKpuYnJV
         WdViIsyQtouTfWtfaREuxMttOu8lLUdY77+wBKFk11bmyKqj/4z+1y+P8vp4GAM7f3jo
         E2BQOzUte1ILwkRjhYk4nOB91X46OGj0e/aV17euQxfd29UDKG7aZtZ16+n8t7nfohfI
         ZAu//vtXB68B64imybrKm3R2VTsZTG1v+Goykzlznk6Ba7CTNEfPl9M26Sldlbenjgzv
         PYGGW7C0CG0uIXhvJlkzABEtFIJYhmZPcqpUEoK23gE9BG8M1IvieOMf+rCfm8CTu3NW
         p9Bw==
X-Forwarded-Encrypted: i=1; AKwUvBx5h/AKf6TIkyKITTRZltycYd0HogcfmPHnR+j0zwu887tj4qTayYBdOJTVgDTuvdNsQBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMMEK+b8/WHq7/JTDo5LuSUFh8yu8Vs694XGJYv7P8TX0xpyr5
	F79LKtlfCrzv+aXbt8MEQtz2k6Br05o2Y1E0F4VzA6wCOkDKYBvTP4CS
X-Gm-Gg: AYBFou20MhYe/0XPMQw7yjrBeERxeMKgWhZpr9lqK7VibIorwevb02OdtcxsZLMIAdQ
	L2M5AA5GoooUDj3So8DmCHWyfJJGwHcnFAzpIX6fHFdwwaaD/PW6KBuXQlf2ptq09jHq0ywe3Rh
	imUjI2k61h7b5RWV8GHg6BV37t6RKImKWc7iXexjU/8PXUcR0XJ3+QVFxm2UzcUWTHDqcaV8KXM
	MUt3KgvQg8/dT/RqmZj+sbPrtTzXJrL7SfzJBqNf3lqPp48p3RTp+3V+/o23KN3Q1hPrZwv1UBr
	3m3kuIIlOtplmkWL9PECh+k63LPhC4s11d3DLqU+WYxNLBZ8UCi338gakvLRVst94Myrm6hXBcD
	uh8fYf8O7qGnpiuF9XA/gqGROOTRqPVdKgtV6P/2fc+kr++OHlvN80Rzphwv58Qn7K8h13f4HN7
	XXbFlcCd7nUqtMqfg1u7FC80BXL3OPwLmye6GuU835/K7kqQUAJcwTgiO8fGY1PaMXdy/JYGi06
	4+zxLkJOMpVP/V0xdc5O0T4HPaenaTVhnM4/GYz6qW8DFUAEw10/b6Q9RBa2eJsuWz9LltjaIkL
	dJyy8m7makReFQ0EI8Fyh31T4jQE+nwgK3XIsME2KBxLZr4Dbwks8TNItQ==
X-Received: by 2002:a05:701b:4349:b0:143:3617:c5ae with SMTP id a92af1059eb24-195bc01df6fmr1172037c88.2.1792717452933;
        Thu, 22 Oct 2026 18:04:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:73e9:911d:b3e8:57f? ([2620:10d:c090:500::6:1122])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195e9e9cbdcsm1654823c88.5.2026.10.22.18.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:04:12 -0700 (PDT)
Message-ID: <a7b9422e00b9a3f5438e996f01e97bef476040e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject pointer operands for 32-bit
 recurrences/latches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org
Cc: daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev, 
	memxor@gmail.com
Date: Thu, 22 Oct 2026 18:04:11 -0700
In-Reply-To: <fefe4448c7a9f9938c78f1597dd20fa96f180002.camel@gmail.com>
References: <20261021185609.607075-1-eddyz87@gmail.com>
		 <DMAV87WUFF7M.1PU3M3CCZJDQJ@gmail.com>
	 <fefe4448c7a9f9938c78f1597dd20fa96f180002.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 15:50 -0700, Eduard Zingerman wrote:
> On Wed, 2026-10-21 at 22:22 +0000, Alexei Starovoitov wrote:
> > On Wed, Oct 21, 2026 at 11:56 AM Eduard Zingerman <eddyz87@gmail.com> w=
rote:

...

> > le64 does the same without zext32.
> >=20
> >      r7 =3D map_value, r1 =3D 0
> >   l: r7 =3D le64 r7
> >      if r7 < 100 goto out
> >      if r7 > 1000 goto out
> >      r7 +=3D 8
> >      r1 +=3D 1
> >      if r1 !=3D 4 goto l
> >=20
> > On little endian transfer() treats le64 as a nop, so r7 at the header
> > is (linear r7 8), while check_alu_op() makes it an unknown scalar.
> > At the backedge r7 is a scalar 108..1008 and bpf_clamp_scev_regs()
> > intersects it with 0..24, the offsets of map_value at the loop entry:
> >   verifier bug: scev clamp produced empty range for r7

Actually, I don't think there is anything to fix:
- check_alu_op() errors out if le64 is applied to a pointer.
- (linear r7 8) means that every path over the loop body
  is guaranteed to construct the linear equation.

Meaning that le64 would remain visible to the main verification pass
and would be rejected.

I'll re-spin these two patches as a part of bigger series with a
correct fixes tag but otherwise unchanged.

Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842D27466A
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680143; cv=pass; b=FC6n+kIhPZ1Ptu0wlvW3oOm2huB9Rayr0cH3aCLqX6PxfJSzK0YvmwFx6xlP9jl+xgwN9PNi62uCTi6yKl8oRO6YcLKMCsXjIa5k5ieDI3ZoJE4AiRgv3/OOxpp6axLP37KiAcN9GXGsMKyiaveW+lMqKiJFhOsfQyZVPeiVDRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680143; c=relaxed/simple;
	bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY7IKg2aSzVp7rU+3Kp3tyFq8mpPdwmifd9wwHV+wAzi7lOZ8LoGpMNYGaFixe+gh+3+fxqJA2xupInnr9+wkniZJM2KVtPRhDji09UVGxTbpiZspvSuEFx8g3C7C54LXjRgTPbCSINCsOEG0UNc7fWmLer/mlKXy/G00oMN6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik3+Tzdu; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik3+Tzdu"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986e538decso75907177b3.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772680141; cv=none;
        d=google.com; s=arc-20240605;
        b=GNJR8LqUKzvwX0Ogv2tdB68fPcTTg0CGTs75jsYykFVikeeEpiOtkLeN2wsnbhhwZ6
         pVXj/j7AQLa5kEs/uke0o42RJz+w/bF715y+iRESNdi46ywLxBg/ztvPCnP9cev5oWW8
         wVg7pJNn7TQBfA5rSX6oLmv7GBPjYfRT2/aFRSm1pdtH3uxp5GRJp34+A1p9eCBPF/qr
         neX9djINPOyvNZMjiG0vmSJqbu3wdq0HXLRoNtRe/ehaac4T654eBYw0qu8ZG4BWWSuD
         RGZLRzddpEa2szzYwKLvlJ02m/FOh6IqF9JZSnIiyjwwrRbGvVfihGXszKhPi9YeZYO8
         2jZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
        fh=xPWTMXPPUEtLO8keFwDZBadl5svx+wbmg7Bi8OlLCeU=;
        b=H9wtzEfTyAHr7I0FYUlfwgiWtYtBO9DUujC8KwneCiYOwWzlb5S5SmPtz0o6kg/ZZ8
         A5lUrf+hDlhwS1g2v/lXHL46MQAZgNby83JujJ8VuEW1xwWb76W4pasjsq/JI5g4H2Vw
         0VheBerg7SiYmy5gf7bv3OpQjVJ//FcOuT73r/zIXPOy1DmnxclLpbXJZxCZ/kZZj3Ef
         DgzENPt/lpAXJWvPXN0K29qMydvSKaactr1ARAhIMGbTobJWF8uB1heC0F3LNOAOzSVd
         KVrpsETZChipVeXNfa4TPeLIS5cHaJta17o4MZbN1pARi5tcjEjA1WqHOLkoNnrqnCn5
         du0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772680141; x=1773284941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
        b=ik3+TzduFk6YCuLj3lduxyk7Jwvn4/087pdwqxMnPYTK5V326VKy2enLZLZWGroLom
         wuDUEi6XF0Kb4g4R1RLTONyzgSnlRzTtVb5v5TVANM9XKtZv1+MK9tuSz+0IoaX3MH/e
         +QTbAApGUtkerfYpjXLcLGf+CZuf5oJi5Jo5I4Hdn8Je8CtyLK9LwOf3wRFK1j3Zz6XO
         QiWXxdJN/brD5dOouKdQNPZrp1kuQrTVomNq2/Eq+0Rd6JaMTr6SQygQ0EKO1Rfc9oRJ
         G4umNOa7zc+ajbuqEwIB0/BhkOBYnPem4Jo/2Gc7+DcVQcX5EZoA31Ml/B95GY/MD4x+
         3cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772680141; x=1773284941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
        b=Ih3q9daMU3TDE5MIslQB6OKDNNdl+NJq1bGiWfxseC4vnC5NTubmRa6S8DtbPat5oU
         9frOZkPu61M7b12UgT8it11WQJMkBKZfS3/VQ2p2j5Xk/7UZ/TvQHqJ7wRz0o/I3kgYy
         tIW5cNAv5GUDdYY2aMDNgbKams0dSOoMb5dDSh9BALV/AZyHLi64PT76aT+5l/HaF6e3
         OB30+lGZyaKvLKVavdeF5nr6tiFxwJJGz0Q38mERhwBh0MgEHEl+tk3Gh819wJDyiir+
         Qj0lIZoYxSzNIMpqP1jpRsZ0qXXdws+N5UK0V+9QA7I+upD1iaJwLqNhhnakPyOg+5Dq
         qBhg==
X-Forwarded-Encrypted: i=1; AJvYcCXxc9SJd2N97X6OXARKD3PVQhwyN+BdB5+kAA6L9LxHTM5+E1voegQTLFwxjzSLk0l91SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SbU6DIxVXdygpeTNvANRlPjxl9Tf990lkjg8J+O9995+hjpE
	k3hi5fKnetHIEmi+QQAT5SIeHvUotnncGpSIm3ssZnO6tF7yUVTiJTK3gocPJ4kyqjG2ArQB8Hb
	gjXeHXORmZQeSaLqiLJW2Ln8mZ1gY/o4=
X-Gm-Gg: ATEYQzyYbcty3Tc801b3u66eT/nhSPCs1GepvDOnYUYb/1uy3QG+0yQ7f6yHVIBrx8s
	Iis8svGzN6vEqohLnJ/VDkvRcxc9yka1vrmlyL04yzfVTZSmO8VxqqW71KXcOvkVTJ/qw2hDkIc
	iVq0v3jsVvWvY0Y9gZYeyIG2xaNz/5klF3lK0tPTK905vQOb+QRSKAMMTbJz5jqntGkzoHT6bff
	usfFAKgU2MaamtNPpwlJWIXlTTXSvWagCi7S2RMsACJxngkIOYpHzI3XdhTCqATI9tuUuTCtAzp
	5+dwEoFt
X-Received: by 2002:a05:690c:60c7:b0:798:3f7:83bb with SMTP id
 00721157ae682-798c6cf97c2mr33006287b3.61.1772680141182; Wed, 04 Mar 2026
 19:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin>
In-Reply-To: <20260304220019.3efa12ab@robin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 11:08:25 +0800
X-Gm-Features: AaiRm50PtdO48r9cLOL_WD4Ghivi25JYvibiyA2rswTS6fmebhZiuR-YD71P3ks
Message-ID: <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 5 Mar 2026 10:33:00 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Other tools may also read available_filter_functions, requiring each
> > one to be patched individually to avoid this flaw=E2=80=94a clearly
> > impractical solution.
>
> What exactly is the issue?

It makes no sense to spin unnecessarily when it can be avoided. We
continuously improve the kernel to do the right thing=E2=80=94and unnecessa=
ry
spinning is certainly not the right thing.

> If a task does a while 1 in user space, it
> wouldn't be much different.

The while loop in user space performs actual work, whereas useless
spinning does nothing but burn CPU cycles. My point is simple: if this
unnecessary spinning isn't already considered an issue, it should
be=E2=80=94it's something that clearly needs improvement.

> With PREEMPT_LAZY the most a task will spin
> in the kernel is one extra tick over a user space task spinning in user
> space.
>
> available_filter_functions is definitely not a hot path, so I
> personally don't care if it were to use "nospin". My worry is about
> adding this "special" mutex for a single corner case, and I want to know
> that its a real bug before we add something special into the kernel.
>
> -- Steve



--=20
Regards
Yafang

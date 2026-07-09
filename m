Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C631690E
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614052; cv=pass; b=k/DyTxTUTffnE8xqnI9FWpRiKaHK0Eh1tuA5cCS9lbvuXbt/vSpOJ+GAS02TuLZsXTRrI5hW7vy/nq059cF/iQmqeFx2xMHjdHJNbonBItGWBctTSxX+uasz4yQOr/SEsaV1n/ACVQm/A+MmjgBypQOp15+YzRYKfgxRk/HFJUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614052; c=relaxed/simple;
	bh=b1s0BnAvMgNE5OxGjbfRh91f/c2d1UF+Cy3Ci/YTlRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQiS+0TXlZD2L/t+/GC9IoILEKKhlxWZdIUAQIrv+yHtp+I7K/cZLRdaP267f7/Ywjz24RbANbln+OyQmuHdWFMaV0hzKjMua2o1xQUGOb2PPDMjCqPOwzfBkIMTKFrqF37dGXTKOvqHxEOM6wFIJZysLw3JdxThR2TQMa45fAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRjJTf43; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRjJTf43"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so8713a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 09:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783614051; cv=none;
        d=google.com; s=arc-20260327;
        b=YDufNaDFx3J2WcF29X/HmYNHmwalESbW7GQ4JJ4/E1EO0QIymfNnTxQpsL304RkMzR
         +xUTDKto/JXTN++hkBUYozysMt+ZUdRJQKOWgz4g+eWfuQxaDubEHEAtr+Zjj+7jP1f/
         p5O1b+z20M0U9WgO5WrBsmFdHyl750VIch1AWzouWgXdfS12vJl8BXGB1xT6voaCDn/Q
         LHH0WPuK0sLNwZH7JXUYRLKYd8NeFHDLKXHkkI4biteMy74xbgQ4W5VuadZRxFLbKYLR
         WuPBYkDFTSHAago/y1Rl1U9SEYWnM0W4T9nGelsSIh1NKrM6qZqtKVj+gW9KSF3qQPoY
         kNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1s0BnAvMgNE5OxGjbfRh91f/c2d1UF+Cy3Ci/YTlRA=;
        fh=1hWzhAJt5PtfhUb9Znye7sQNio5MbJViU3OYdbbk5Xk=;
        b=f9aHTq8/B+RqLrizaUcP8QEPjGzq7Z2+xyF3XX1upunw5CdtpAM218Y5TVmTRGu/+e
         1JiA3MPRzjhlNTNgjnHwTmGLH7sUtJZ2i87IJFFFja9nnDAdiWWv8CE6sER/zkGMH6cd
         sMbv52odFuVHUEH8dvVFZHerH5oU88o/oM9giBdAY9eam+8H1e01CoKhIY/BpNh1IRZn
         gZJfK9oLs1HpRK83Gy4QI8Z6UiRg3Zg6VAhwVnsYcnaTu/kYdVAYzhvrawmhmRJroYJ0
         vL3cu9+RnonoeoycdEO4EfG3HoYeKi0sNCefxXzNdOBrwmJl3DZ5LIPCzwUatb7bJpUH
         1SnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783614051; x=1784218851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b1s0BnAvMgNE5OxGjbfRh91f/c2d1UF+Cy3Ci/YTlRA=;
        b=cRjJTf434WF3/M2V5PX5OqGjxtAOmlXNzxfqF4f5pahTBH6dKQemoa4E8/gBDJjNWr
         iNS7kT0+jlC/NnaQFlli1SUy752FXlgrCYUeLowqApjsyZFyKDCLdAOyHc26bQ6R04Dx
         lGENDcflxYOetDPlCycnSsHzbjpQ8OWyibSpy3Xtjxeg8OTNqg63ENSJ5JyX6J52WVWW
         NcUbr819mq2tqk58bMKtYUbCUHtpbLoYBaqyH3R2Eg45pEXD9FnygHK9Y88E8/mRDfK7
         y2Y8a21ZJj8GA6fm3pfWM2KwFkxLfMi7qrs2EI9IsQD+z2NbOXgWYrIbbYetYBVTg86z
         Hrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614051; x=1784218851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1s0BnAvMgNE5OxGjbfRh91f/c2d1UF+Cy3Ci/YTlRA=;
        b=jy5drN1QbOq9LLMQLUc9PKHaF3bL7ixsa9TiCQ3QHbn+xHvpaibGD5pMKKXvKTeHN4
         ktnBdmvCGzNscTN6zcBUR2/ViHn4tvIQMcwpHc8/y8qOAqeXbWKQbhXjvTVA27UzkCSW
         NWdNqImJPyHK54tKwMH8T9WPpm56leJi3Gk51PpSID8rjNe3ji2y00wTjtIKopTPZfP2
         AgHTZmnHSnyrCA6nnIBB3lijAt1UQ0s5szD0dIZ7ABt4bLUPvQkdvI5dkOl5FstntyDA
         6T426XfoBBKfGoyGPChSzEVSIS8zZDA69b0A2KF3EbiWwJb6PnCH1rxTQDtqoEWTC/uX
         p3/g==
X-Forwarded-Encrypted: i=1; AHgh+RpN008Tld51xh1vCBVFbgiFaCw7KkF7dpU2sSN5alxLeSiNax6qnTZrEl15OCUoQJULtCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8qhkbTIjy6xVbSKY/9tKDU1Re/e3NW3RFlrRZvRfU/7Vq/2X
	3Yf5DOE+iFwIvL0mB/mQTjwclDo5l1UiwdimRXTHHfgqVtm9TdECVT+ujXHnCWgA9QNzi5CcstY
	xm2sMPdSHXWEtsTh1VMtFBblaZQqsBwwu4AQDOzGU
X-Gm-Gg: AfdE7ck3Xbo0o81MM8RSrXwBq2q1Cb8oVORujfQZMucIN3ZOGnQKPCaNj7dCqAIzGNH
	9QWuT7OKOsOnXPR8uTBpJUipBU26Dfxk583pNC3b4cMIqlGVUEINSgHI1Mw5hKIYu7YKggz2b0c
	Emc+8DGb5Yyk2NxtRCj0lwyURj3lrBMZLoi9czsJy/Y6vjJkDVs5anvrRaYH2fs6wf1ETRSQvYA
	eoYRYZXlOyrRxTDUZwrIR5yptbxie/F3/E6DIduaQZtEwUg2FdDJ94+uoEqiqyexSlhV+SLv3ss
	baZi++jadWz432zukeoV3SgLHJc9b+54kYLn5KdOpMtzcLlcv2DAceO1nVCP5rnN0ZAytcqDXQv
	bvPJ+wklof5DJ6YUDt5R1sO8l11t3RmELs/yYP7LBhg==
X-Received: by 2002:a05:6a21:6916:b0:3bf:6c08:2849 with SMTP id
 adf61e73a8af0-3c0bd276a7bmr8870105637.56.1783614050510; Thu, 09 Jul 2026
 09:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709025316.999913-1-mattbobrowski@google.com>
 <20260709032007.9E4D61F000E9@smtp.kernel.org> <b0ebaa8e-108d-451f-a7b2-26810f3d9b03@iogearbox.net>
In-Reply-To: <b0ebaa8e-108d-451f-a7b2-26810f3d9b03@iogearbox.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Jul 2026 09:20:38 -0700
X-Gm-Features: AVVi8CeDvo4YagrqbzvIVByMGYcnC9eAju-89onJQfNFauJDOGmdtCz5ukRH8dQ
Message-ID: <CAAVpQUAOQJEVeQwKZ35o=0jXVomyUEPNyu9MdK1cbeA-Sdx3jg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: sashiko-reviews@lists.linux.dev, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:55=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Hi Matt, hi Kuniyuki,
>
> On 7/9/26 5:20 AM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] BPF map corruption via shallow-copied sk_user_data and sk_reus=
eport_cb during sk_clone early bailouts.
> > - [High] Unbalanced decrement of global network timestamp static key du=
ring sk_clone early bailouts.
>
> Do either one of you also have a chance to look into these?

I'll post a fix.

Thank you, Daniel !

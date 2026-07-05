Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FA1EB19B
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783217499; cv=pass; b=ZqcvqO0CBDCpKPmKGSSDT7EfGF7QYRnSbZZ4fIonnOql3grbgfw3vhdZUe7NP1wtAnpZXd+7cr2FS0va8rmUVv2JYkmP7CYwgK5pJ0zHGi/OqNfcsOErK1dBeX+FqNQcoDw29/3KB3vTAOwn5vHPOqyUvFi4TGV3DGAUly4A+pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783217499; c=relaxed/simple;
	bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqVK70xLLb2wWO6DHVMFqw1TqrchNtwdzB0l2Vxx0vn5xept34/MvXVr0XUQoNcmg8eVuOwJLeQaC3zhLQfVdcQPfcQ59TPlg955BOG4TMg2iBjV9vf56zfa/7k5Ur/x95cpnlyhMe4VRbpZKOYXuVt9yn7NNjJ4GJ1Es374moc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmKdtRte; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmKdtRte"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1532042f8f.3
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 19:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783217496; cv=none;
        d=google.com; s=arc-20260327;
        b=OEu6ZNm4AC2TDAp8zYWyktZMv0gTnmGYm1pAA0kqjlfJDn2CNnRtuduZud/J2d6Hys
         yE3HXNbOx6WgJMVZcoisoHx6lT5giz9I5re97Rz1i2Vtll/9jeYrLIE9Syee7dd8jb0X
         fqwWgaDGDnf7LAq7efgR5l5fdnI26Zzj3NbYUbmq69tzNnL6vhuJK39OcvT6m6uCDMVD
         WWdS63jELei4bJoRkKgIxGFdMn/wZRcdbbBZHUtOkzoivypX+66XAFz3WHNXB8BamQjn
         Tk9ljrsG8COaQrFxhKSft1wHGffoOmrrsfesMlidua6NS2wLNkcyENGHIZzGUDuW3Elt
         o1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        fh=k5bsg4N0LH19thZDTwpFmVqlUSiv7s+eUe/p6nM7Bfk=;
        b=VRuOBFsbid0kV5mx3DZcPEL6j+HJPPaE+dCFnCH1KHODJ2dHoEzHx/5tvpeRHpq3zL
         1+LK8FXE/uOm4cvh5QMq4Z1TYwExocXy5f5IZamE2NtQyhv3bx5ck4bGLcfU465nrvrV
         wSvxLDAg1I98pSaXjbbyhUcxWjm5zTracxvUesDpz5tiFGsbuROJ8jfhodgMxKlioMRE
         AKLjdKzcAHAD28owAk9gUuXYpYt2yHKORwUbDOc+5jUZsGHGyCtrqVZc6yCrR1zT1Dc9
         ZXhwmMJpcUNNEr0q4nlztHK2UplG9czWOovGmzJWIxGS2Xem3SD+w39xJMG08SKyUMJ2
         DQAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783217496; x=1783822296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        b=HmKdtRtetM2NDeuyflLPyvdy/grl0W+ptN772MGAij7+nrHbbXhc2qymfD0Kb5PqMP
         ryLcrY6xh6NQjLQ2MJ9Fv5gSwpke/rB44sixz803C+m96rP8/YKQ/itznIpy8MUvMJil
         UUSjNEETrVFsP0dbmZGF0Tn3b4qcSpoYCEUkoZ8qq9Jn2sZHkelYODCB7QV6sqrdr/jC
         zrh3QMZ5ZSv+ytznAc9ha3cqn89lWqrCNun/9GbiRjj3OU2SMuSKLpEaytOpa/pF6YW7
         m8fTrMmEk4j/DFLdZuB5BdphHJLIgP/XoFSBOmiYaqx3yiClyxJBcS/hLRavFPyCBeaM
         ONHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783217496; x=1783822296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        b=F/qDmec5gf7C7Q1HYrbLukZNh7OvA+RUoMmm/7Xd7iDEXXa6iTCLLzdPrxTQlWJLmQ
         kJQpMPChsCTXglKJXhgjjHUsDTDsuc5kFD/dYdOxeMWveHkSr8w9ol7nmZHOthg1tWx9
         Ctsg/oc9G013AEvIXkwxYJH6TQt2j54wa9N4WVi9uyr8IEo7Udzs1iPQ5PewrFW23AAe
         2T3ZSY9/mHjONOLcZ3TLnPXmJjo4CeLMpQsliJ/057d+umcGcJQVP/bmgva4lhOF4Vt4
         aAbTQYEf9S+dpV8cInknrck9SNARnzlhDhHgLPuCsVaqrI5FZCYx79qRaV3QExUPNeHM
         YR+w==
X-Forwarded-Encrypted: i=1; AHgh+RpnsJYUiLBbshvxHC/sJHDjToZyqCOaEXMrCmc+TRV/u89++BUMfjHEA+GvClNK3Dew9gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9uSk5rf+/bv3nz2bH/dF1SzWyWzm2KXZGlMFzuNXz4BgvemF
	OPJGaVVUfqWQDh9TGzFmRxtQrW099zHfFi8zEvmQ6yy1GzZknp3/MNSma3wOJdRXMIM34Cdsnhb
	zkfyw+Z7x7VJATdDrcvu1RUJQR5zI3VY=
X-Gm-Gg: AfdE7ck6/kynnmCMx1rMWzGzvD37drjjLnJROc+A2WcruuteJBpKobrQlQpTKj01Yfj
	ojhQQ6eI7ILGgOSHo32E2o2sFGRTL437zaSnaKbE68TwXeMhEWhaNy4vVxtwiffR9FXrtmL2gmg
	NiqNtc14rxD7KhijM47eEpR+lN1KaG2BNEGEg4MpulCQj0BwWAT2JN0hYPwQ01JPNrMWwteJ9Dn
	mW46aqnF5o4k3NGdvv6P0Ro6RFL3U/fxN+v30sMMgx0rVQ53AvP0U8hNKGAUGJEGD2xrg==
X-Received: by 2002:a05:6000:310a:b0:474:fd7a:93f2 with SMTP id
 ffacd0b85a97d-47aab961efbmr5621255f8f.15.1783217496219; Sat, 04 Jul 2026
 19:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev> <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
 <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
In-Reply-To: <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 5 Jul 2026 11:11:25 +0900
X-Gm-Features: AVVi8Cex59Et_09q6rUsvepTcxo82qiJkYVp8jk9ZmjruPc9k_ncvXD6H4LmGwo
Message-ID: <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B47=E6=9C=884=E6=97=A5(=E5=9C=9F) 22:28 Leon Hwang <leon.hwang@l=
inux.dev>:
> Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
> kprobe+kretprobe or kprobe.session, if the extack is not NULL.

Thanks, that's a nice pointer -- dev_xdp_attach() has both the net_device
(so the ifindex, which lets us correlate a failure to a specific attach)
and the extack, and it avoids depending on the tracepoint you want to
retire.

The tradeoff is that dev_xdp_attach() is a static internal function, so a
probe on it can break across kernels (inlining/signature changes). For a
best-effort error message that's tolerable with a graceful fallback, but
it's a maintenance cost on our side.

Since this is ultimately just an error-message improvement, and your
in-band BPF_LINK_CREATE work would solve it cleanly for all link types, I
think we'd lean toward waiting for that rather than adding an internal
kprobe to Cilium. Do you have a rough timeline for the BPF_LINK_CREATE
series? That would help us decide whether a stopgap is worth it.

Regards,
Masashi Honma.

Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D809126C02
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790410885; cv=none; b=IdrgXUAsj3hYDqLvFIDPoRz4wk9AZEQFpWWqbiHQ7g6zZh8h8bIy7QzzFBdD8cYnZxOLShBZpMuV1ylJzKXfuFjDt2yko419jNp7XEGVlEHAzQL+7CT+sI7EL6Vx6x7Zb/iPzmgO1kWY6zA/OyTh2MxpNUy6VeppkssktIDQoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790410885; c=relaxed/simple;
	bh=qP8vtPntjjcfMQBg2lXZDIYewaoQ72Fmh0mP130JmD8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dxa7jxcThX5yv9nr3Aik69692AQ8X+FdGVL9x3fwxrfYskS+QuMNwmSqObvUpn+Vgg/b/3Zo5j1CjO6w/HfmsAFq5RyQLuACHsuoxHoZ/XiQtnHjagmKc6bvoOO06lQyHLd2l3BkGEuAUWrOPes+Gvcizx5M4xdkteTiB3WErvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA35IOrB; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA35IOrB"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1dedso360324a12.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790410882; x=1791015682; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qP8vtPntjjcfMQBg2lXZDIYewaoQ72Fmh0mP130JmD8=;
        b=UA35IOrBlbpJzBbBgOH7AguE1DsjHBUg5Ri5roRXmRQW8AwiwmgNiB7lgcXghq87u+
         5jy5nI3EhxgpjbaaV7hioRj/h7hGOpBRYXp3z61dri5PPkTrNnsCE/7bI9EiSKScR4O+
         nucQXLIr0F/29ygTCh+E9S0dr3EnwtHJGmw1HrgEbZyoa8sxc6bYIQ/1O9EvznlAzCMy
         E6RrCU72yYN0QdHkDONnkNBkM74qW11kWcw9lYdDH+GO7HQaVSoa/ZwqLDLIShqzhSPH
         8hpAmtHxHhNFoKA4HM5fFRZiskxuSVgYTewf2VtrTmrNao9NQL0bs9lbTaQVb625um8D
         iFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790410882; x=1791015682;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qP8vtPntjjcfMQBg2lXZDIYewaoQ72Fmh0mP130JmD8=;
        b=qImQkkkIicvc0Wm59VhBlrpc3XhNKIgVC4kSC7UL0vyDcmgMfKG1GdIghBINva2dGn
         x52fukcXDO7/VssnCU+e4Rfb/73mRW6z0nmoQ05XB8RD12zxdFLvcaqRjpMIVHuQJvPZ
         9s+8Ro9yVyTdBj1XS7SeYcySgSh5T4RNEPbBUVfHzU96sEJoOuTcOaMzMncwb2BcHwkx
         XsynfC/uxyAhcnaN+J3mUyMOfH+VMTMaKrQPT2qqaHbW2kKmE/NsBBmg6c84R9eJbh8Y
         FPcXuUr+pH7zpa46CMThzG7csCX7xbevCXwZUQ+26O1f7a3KJR+tn6seowgnB7jmOsST
         f9Cw==
X-Gm-Message-State: AFq9FYLuIvgykWyTZDjwuo2XjZtm8m6nsYV6FbXXnhJqX8lU1kofwiXv
	dYl/ArcDUNz0zlEmXamibeGW9VT+lPle+5NwEOj4DMydAYarbGfaOAFE5IWeGNQ3CsQ=
X-Gm-Gg: AYBFou2xFDrdecLMTHzRycSe5jmHG3O/Ds4hgtiRquCS7XGw7zCuq+MuAuPZASjzH6z
	gKUSzdLVhl+qfQFmmmbscI6Kd4yK0zwHWLXm7hriNL5jvr7VBeZkoo69dwXHFMZ3qcJuEI8U+l2
	T01gWEvNwDAhX00j3jAtXuU0uRpNhpzp59u3pqJaPHFirri2O8HxVmvpEqo5dYP1lTtkeYwntNi
	IaJsI1eY6oR029mfyNhDwI9emtoZJW71+Q51zNjqpD/coEn/7xuOdLwS+iJvaFEwOiTovI2xSFr
	lvNkRsUfJTnNreo+c3t3btIZgxmhS0+O0W9tpZhFJOMUB6XyN6reCYZBdn15C43MNC5et4fKhuK
	78YPgS+dAoSmQHod+U/J3cogkrrcQGq6C7e1Bm5X8ZQJXTRXLCE8cQeHEQRwNqtnFBEOYrMXZOf
	oXhY5Z5glfiQjcjUTvOk/1IyTaR81LakxdGSKVpwpufRP8CeFuEG+Js7qZmVsf4WwN+b/fNK/ra
	B2LtY2WjrrMF/RI+/uVR15EHAKRVB9wtw8ksVzpL7xlpCate795fJn6X28OZOc4hpMMyki6xq79
	tio=
X-Received: by 2002:a17:90b:4e86:b0:39e:4c7f:7306 with SMTP id 98e67ed59e1d1-3a098b8addcmr6306044a91.29.1790410881813;
        Sat, 26 Sep 2026 01:21:21 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5d0sm16374836a91.4.2026.09.26.01.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 01:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 08:21:19 +0000
Message-Id: <DLP3OR7UHWTG.12NVK9OML0YZX@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 07/21] bpf: Resume a covered call at its
 landing pad
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Yonghong Song"
 <yonghong.song@linux.dev>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050042.2216692-1-yonghong.song@linux.dev>
 <20260926051542.D2B111F00893@smtp.kernel.org>
In-Reply-To: <20260926051542.D2B111F00893@smtp.kernel.org>

On Sat Sep 26, 2026 at 5:15 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] bpf: verifier bypass of resource leaks on unwinding without pad
> - [High] bpf: double free via bpf_unwind_resume returning to normal path =
in verifier
> - [Medium] bpf: precision tracking corruption when backtracking through b=
pf_unwind_resume
> - [Medium] bpf: CFG and liveness graph mismatch for bpf_unwind_resume

These and other bot findings look real.
Please tell your clanker to look for bugs harder.
sashiko shouldn't be finding such severe bugs.

pw-bot: cr

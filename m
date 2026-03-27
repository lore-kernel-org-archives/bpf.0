Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3630E82B
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624897; cv=pass; b=M/uoadENLfZzspvo8cyIPvA3+u44YanJazQAOXI7hgytTOmuwWMFvjBSuaj/JiO1PI42ru3dc3BZY+yWgBnn7aZ50oPO5hOFzli36OyCgx8XqP+oxNubkr+2qlUgNqyqvsmUpU4nDJoUS7ZLTo4X/qbG0kdTTrR8uyTdXzbCZOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624897; c=relaxed/simple;
	bh=i5yswZsGz0lDODJAAupC7LNuhHMMKdCTbGNRLBYDSls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRNnmKkAGFb0kApw1ir98f5tICkA5BYwhYXWt3z0vypUs3Mzun0OzKjckxx2GZZeMhgXv9vbFP0rtZIURv+eeIKJao2w/v6WXRQW8JJJS6DSWmteRKl/mYoYMWsBc5vfYQJq6uzAdKc2Xpqr4E/2jD/QjkZ319YAlArjeii1MHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsaTZr72; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsaTZr72"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1270929f8f.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 08:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774624894; cv=none;
        d=google.com; s=arc-20240605;
        b=O9sbqv+D3tO8KjafK/FNO/oIEglHa7dWgNaVbIl97ewK/N7OZixCLOVCuEJAG6b8GQ
         hcIpgmsPxU7U9Vyyg97zoBVcpkGSkCSiQ9ENoqq6LrVIqZKY1+4ljvJplmJrGH5mTPJh
         BZ0ww9kDmhp+k3YanOKXNFBu9ZjySz4k2otJXaZ2ktJDQ1/gdlwaelXK/33fygcZN3ld
         aArgGAZWIJgvS9OrDOagOEEJMmv78TWbsEaKOb6bt5dwMxDFQS0lcRYO+v079bFvFwpJ
         Y/GSVaFkIMjKjI1TwsFXnQrlNupGMtScyjH0J3J6vX/xeonaTCikcIiZR5UIP+04g4BZ
         TPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i5yswZsGz0lDODJAAupC7LNuhHMMKdCTbGNRLBYDSls=;
        fh=7CJxWC0hFqqKS7by9wJ/HwIe88hE0Jsh5YO2a6mArvI=;
        b=bb/hPMfknQUJ3PkK9fy3tMnOMj4Vp1gxlNx/igyg13VLbl1nDXgC+zEQ2+WzWJ8HNH
         dxueXq/jKFrxGyrxL0C2lAG6eSw1HneDdSDKy2oZjpbAWj+GniU7JSmrN2AIT6uKv01+
         LSqNjSAXViDtHojRKGAN+TB3NEbr4sSDLsLGXjE+D76NgPizUvMoLyx2xBsaCgYUImti
         pIHaNIH037hHq7aVWfOq6bJHsGsgWjI//L1SAj4GCjF0wlEEMPw8DAI/r+W0EmJF71Ug
         hWssBEeFIDB+g5uxR1ZT/lP4VMEx7sJz0OyKP3qwTTdy4Lztw1bKc9JfAMRX2nwVafIA
         K+Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774624894; x=1775229694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5yswZsGz0lDODJAAupC7LNuhHMMKdCTbGNRLBYDSls=;
        b=PsaTZr72jqfnIg8r1p3r6lBVMqlSgDOW9yo6E9KM0XWSeaTZUUkVmcFVCAmNFf6+h4
         VuVslTew26UbMWj4oK/CLizA7qzwg2s3vnieR7IHbQtg9E1nGLw1xkMli2GXfuIuKcF6
         erdSZ6WyHv9I6icQ2bJC/w28+u8leACsp7gF+sOSczEdga7+/lD9lAvZudShX/y4kH3x
         EFBh6wzAApA5jIgUMA3o3/IkfMILTVuggKyd+hgO99yhUNF85DEQpLfnp2cKCpUi3kq/
         SxCPpszcKIM+5Et2j2aARI6SkJfWyMR0i8/892j/0yAJE91MU4PV8TNFRqLHGjUUd+xD
         409Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774624894; x=1775229694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i5yswZsGz0lDODJAAupC7LNuhHMMKdCTbGNRLBYDSls=;
        b=Aioc8S6lV+sDIx9AUaJz/tc7tdpGwcuaFx/PduwxlqkRc1wUGIyFiKfPkS6ySdUP2k
         O+ToaofAmdTCKTF5yG28KvluA+MCMS5vU9g3IkgDcWqO0z6KaDHZ5JRDrWY19mKEWcOE
         gHhLeJMojGpzFQI9CRFzEg8VfsKr8EEV+2E2xyqjkclFj+fd+btFhJaQBlKcfrgMLGNU
         SIsCCp+ZuBF7eeRC2ugLgxHH/16W0VP1SUxNqqRZ2WuqbKHmlH2GSzaD+U4xuOFj5YXK
         gGh5CYeACqM/poGc29slPrf78amfPq8z8DY6cY+TQeoMint2InJNbOU55W1215bdFapC
         +UHw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZBuSS5Sly5TnycRy7lV9xcZ+mfNgdpvgtWE5mb0UoN3l9KgO0Dmbt/pGeXDc9MYj5QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPrx1dPFxBHD2Mu6TmE2eaLtrogpPeFPmFPZGm8xhkgAiPu2W
	aRTSHJDgFNTkBVDtoUhu1CcBQuuVgWnLNsda4Cw8swWQWiJpiWXg5BHE6hIFIWpRrhTGl6Y1Nj1
	O7o2ulAoSKkWAOQjBhB7kqM/RfkSO4N4=
X-Gm-Gg: ATEYQzxoQAP/gKwWSiZwYpQRMOEE7SXUtEr/2fSRASveZ9OmCMlHqq0z5vron7DR4/q
	LcuDhXZ+ld0nIvvOJmThJGpHQPctNS7g2+oiYfbUWzeWxtc9B+xupaHfW8IMMng2orHAj5Cnp8M
	LmOiIsLgkWjXYvxKkaD2WQ9CqowRCxg5Jzw0qVWBYdSAymTDvrD/mwHMbcWScPe3TgZxqwJL9b4
	m16lnLCU5yuB9kBjnTh9r8zNNOzHkS6OkMz9ItaI932uRXUxaaWREdpiUiOslPWTD/nRPHxLtPd
	PzD2wFlHuyynNbtGQGC+HoynCxVgKXv676ZCRrtjjHOsvYLjYLPGCp0rGFKMjzoHdDISPxYhsqb
	esHDyn1XFuUIi/63ja0ioxp4+eQ==
X-Received: by 2002:a05:6000:2c0e:b0:43b:4921:8744 with SMTP id
 ffacd0b85a97d-43b9e9fad7dmr4962672f8f.22.1774624893834; Fri, 27 Mar 2026
 08:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
In-Reply-To: <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 08:21:22 -0700
X-Gm-Features: AQROBzCwdG0uvO4VdHD9uBtUZNt_FA3sFuEBsC99hUhNBVt5CqpuCorhWeJ6Ptg
Message-ID: <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 8:12=E2=80=AFAM Takeru Hayasaka <hayatake396@gmail.=
com> wrote:
>
> Hi Alexei
>
> Thanks, and Sorry, I sent an older changelog from while I was still
> iterating on this, and it described the issue incorrectly.
>
> My changelog made this sound like an IBT/non-IBT-specific issue, but
> that was wrong. On current kernels, fentry on tail-called programs is
> not supported in either case. Only the regular fentry patch site is
> patched; there is no tail-call landing patching in either case, so
> disabling IBT does not make it work.
>
> What this series was trying to do was add support for fentry on
> tail-called x86 programs. The non-IBT part was only about a bug in my
> initial implementation of that support, not the underlying motivation.
>
> The motivation is observability of existing tailcall-heavy BPF/XDP
> programs, where tail-called leaf programs are currently a blind spot for
> fentry-based debugging.

I get that, but I'd rather not open this can of worms.
We had enough headaches when tailcalls, fentry, subprogs are combined.
Like this set:
https://lore.kernel.org/all/20230912150442.2009-1-hffilwlqm@gmail.com/
and the followups.

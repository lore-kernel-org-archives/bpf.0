Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC8334C34
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759795; cv=pass; b=LchDx5R7S5UlThJFcwMp6wwpOJDpMiQURrV8rbg3eGYWGcvZWMRJV+hvwDh/QPhLEOGqpLGghnpIHTr+USWr1kznWd+RfypP5kcpLbSk8PcxjzTgIQ86rm9oD+k3j7d1AwQGRdxuJnmrj3wkv65YyrTQisYSY+oh2CE6dAjnfJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759795; c=relaxed/simple;
	bh=bwooaEQkgcFw3AjWqiq8kLvmMNO2k3DlBJ8FZTgZ9lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkxitVrOtT+Vur/LWlGlFxTM9FDG2g3tTnXolbSILwKCG67nI1NASYUIwmd/cno4jRxByrTZDRJX81m5QG4yZgbwqV89fl1WjerE5JcAnZk+DzIpgy3Nuy6qdPpN1Q67ffbbbH7aGmL5pHElwdYQ61q7iQjtsY/Xpoi+W53Seqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeuRUx0x; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeuRUx0x"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so47138205e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770759792; cv=none;
        d=google.com; s=arc-20240605;
        b=P+S7CShxPe9Y9rGz2IsJKGw+EtfQdPfVtr8e1cumua7YRK+2SqKp4ypT/S4j+4L9wt
         6KJ7z40/585dy4Jn57BK3diyHMBAAqzMVpxiIXcC5sk9ji3woM/rlq7+HPMWzazwa+xz
         +PL+TKZjMjIzDvha2mOkE+CuToEtWPS8CRViLTNLaXHIGOJLRX7huBTFNVFbXH4LGb++
         sIRtQRgZkgdrM9EMr5LzQQUvAOnzfyneY1vvijSydS7xRtDMFdSo5t4E7zgw9cutu1Se
         ZiU93Ouk8VsZySnzRqgfoF57j4oWyQn1x89zjekp458KLWmWz+EJ8YxQpjyVHzZiehk9
         2iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3/hdLQk6hJI2S4uSStm+WlaI96yQgzNHntXZZQ7p+R0=;
        fh=daLfeIiCICAD4C8At3fbsQS4NFuQ3TbypFSrirDFhnI=;
        b=Urkm9164TGCAvr82iTcZlj46LKs6LIm1y/32pHpqskPkQS6RG1klYvXb7/csikc00L
         lj5r5cTTX4uB5BxDR4qn+dYv/lNfDrsoATfn5Eb7GdkSwXnOXkOTBzcCXLowL0GZ9Pcn
         j6Mk/a0BYLceQAIO0gi+YJtCAUhRLKCCruHnwua6D/6O2bt/7URzrbCc1xFwnH5CRQfw
         Kze8NoS2IzJcyn4wa5/xXRt9e3qEGx3O9mfZXY2ig72Dix3wn+S1d/+YfvUdMOBPy5+r
         tJn2WsupcpxO1v6rVQthvRMbWkrPRY5vfaEPmbf5IFvyDMRqdahTLuQWGRrPOZAn9GfD
         um6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770759792; x=1771364592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/hdLQk6hJI2S4uSStm+WlaI96yQgzNHntXZZQ7p+R0=;
        b=aeuRUx0xo7WkbyKPYOn6d61HnyfubU56nei3Nq01HG3M8A6lb09NrV5iIuZaq4WMfH
         gr4HH/W5R66EPzPNHQIoV5Ku6tpg4Po8NKvOz1241tekN97pz49aUpbLvyFY3g2KyUsS
         i5sxtBEFdwoE5aH+L0YMBLF2ZlmLiOHV92aikYCREj+SK0/MdKtD4oXcyD/SvfmNRR9V
         jZf7eDAIoaQ3WPFku7NzyPHRgjmoOOHM3dBhVkzP8OCcHZiY6HaOhqtHuILHX4vPISIs
         cwlUjnJDRZb9BZV2j4GfGNyCIQf8ll69U7M3Q7weI+VithRPEKhDhkZ6ljx9RL5i3jbc
         wuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759792; x=1771364592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/hdLQk6hJI2S4uSStm+WlaI96yQgzNHntXZZQ7p+R0=;
        b=j1t58eItMQgWYPjYjzkU1mp9dYHQlQPJYTNTQDdOai6M0QeDPduqgK974A6eXQ2AGQ
         0jQsLdZi6KJIwCfYlZlDsfmDNZx7wMwzvjKqtVCJzQz2j3PwBRYOgwSPlB0YEERQQHl1
         10ghROIHeUiOjTktl9sg1BXybYTuHTtAznGVw1BcQBvIa/AgNMcE9kq/omfhLbe7HOfz
         Bo5JhUZRRHAeRKfcbEEQ34gcPN/u5IFQEYBKp2/st/EJl2MXS+xriPBeAglSR+YlfDAz
         jAcSooZ3RFMCLyu471Zad9fMlbT+mFhMqHKEPHJ+wGxG0pc0fN5gvjLxV0Nxdkl+rQ9F
         ybEw==
X-Gm-Message-State: AOJu0YyMN3w5oYAgr1huQcIxL2pxv9MPcHKB7OECdVZnvO6KwtAFY8tE
	aR6gUluiiP145/4GsF898JWijadGIUPhOVDXgs/zbjblOODzFImeLI3nzx7EMwFSULrmpPiFU36
	DK/OwNvHv9yyzqIDw+ppRr22GTVQZI6WpTA==
X-Gm-Gg: AZuq6aLI+WjzjLZlLAXSXlJH+sKsRqEDVGsZA02Wi61BLc7J5L/BymS/wrPRjE+qZ8G
	UvUfWPpXSNu5RWFgjv05GzcwHG/UHbK/Koe3o6fBW3pAaqWeRqkET1q/7vIzJssYuGW8RCvD3WO
	PU8KZpK0XB/LKiJvl+5rsU3UX3fHbde6ov7mO363FnRYPkyP54dXmsBcOeC/WtdkAtrFgMdELHd
	y4jlI6hUKaZUA+558DpbGKgGB7D22EvV4nkE9DvVvRj6JQqFNhlLzlAcyn9WIrxe6lQQAmSM5fT
	1FHtCqO9mfDwnuKpY/HYnQO/HtBILnkZ7FNxc0Bk77uII7wRh+WRTeSzzKCZP9jNONfkFmGF00x
	vaqZIgvLQ+V7xTHMadvA=
X-Received: by 2002:a05:600c:4f88:b0:480:53ce:45d3 with SMTP id
 5b1f17b1804b1-4835081e3c0mr45782565e9.18.1770759791748; Tue, 10 Feb 2026
 13:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com> <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
 <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>
In-Reply-To: <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 13:43:00 -0800
X-Gm-Features: AZwV_Qh8lmi31AZTOSE0xfm1Yr7tkylgXoB_46GQumDZ3o6qjhq4a_pJM6vwU0s
Message-ID: <CAADnVQKrXL2QNMoxTQ+nN1-dAEk0oHYBLy+h8J=mDSYXtVomPw@mail.gmail.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:03=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> >> - bpf stack: when a program allocate some memory on its own stack, it =
is
> >>   not tracked by KASAN. To be able to track stack memory misusage, JIT
> >>   compiler must insert some red zones around the variables on the stac=
k.
> >>   This point looks more complex than the previous ones, as we need to:
> >>   - identify variables that live on bpf program stack instead of
> >>     registers
> >>   - insert asan left/right red zones, and possibly inter-variables red=
 zones
> >>   - and so account for this "stack overhead", eg in the verifier
> >>   I then propose to put this "stack monitoring" as a next step, to be
> >>   implemented once we have a basic kasan monitoring integrated in x86
> >>   JIT compiler.
> >
> > I'm not sure it can be deferred. Pretty much all bpf programs
> > access stack with load/stores.
> > So all of such instructions should not be instrumented.
>
> I am not sure to get your point here. If the matter can not be deferred
> (because pretty much all bpf programs access stack with load/stores),
> then all of such instructions _should_ be instrumented (so that we
> detect invalid stack accesses), right ? Or am I getting it wrong ?

As far as I understand compilers don't sanitize stack access
because there is no shadow memory behind it.
There is no "allocation of stack" or "deallocation", so no UAF
or things like that.
The kernel already has guard pages for stack overflow and that's
about it.

> I am not familiar yet with the verifier code, but I then expect this
> work to potentially bring some changes into it as well (aside from the
> info to pass to JIT comp. mentioned above). Eg, if adding red zones
> around stack variables is indeed required, it will increase stack usage,
> and so the verifier may have to account for those (eg when validating
> max stack depth ?). I'll have to clarify this kind of point.

Redzones? Around what? There is no way to tell where variables
are and that one access aliases into another.
imo existing stack guard pages are enough here.
So no instrumentation of stack ldx/stx.

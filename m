Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFB38A29F
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812330; cv=pass; b=lJLTsUX2Nz29StmG9Wqp2EB/kT8y3oi5XxjIsipR0lyUdZt0dYZ/dBksEALxyxc9b5JsgOJnuObTNorGfZu13wGc+2jJsqGnH6A+gdiSC8Jjnu9fYVRjg8h7mUTEzSUnbFZFXYVe2zBIcZQUtyMr3eynZcQdrwM5WUnoACv9dNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812330; c=relaxed/simple;
	bh=1L9Z4WjLTMd/nETiB4o0uKotvQN4Rh7dUtNkmBInouo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TC5lYGwERIc4Z4U+oxKDFKWxc5k7ah3jPfSU8dj/0clB1aNbPaDoNXkdArN8wtDmEKPiSt6gt1ybnDMiFuibpXEbLMT+R1xOV5sdPHd9C7o0jS6aWFzzpdSrOLcUFOVWB+UOjHP7XSfjMoY8YdgrmmZ+x72nSHeYNXcW8WN5tSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSsduIhT; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSsduIhT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885e8c6700so425047666b.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 14:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769812326; cv=none;
        d=google.com; s=arc-20240605;
        b=JEaPbcMUlE7tCh4Ep9wchiOq4fDZzYUw3YwKsvgPq4QtAt/A/+TqHdbc040h4ezx9k
         WgB4IpzwtgAYpDOw5nRlpkXLc70dj3TjOOxb2NnIC+ZmyuMRZJui2DyZUbnK1WgTzMtc
         X/B9HkpTOaim7lRUT5N+jOqny3mlBTGp1mfhGrXZYoaG02UbN8PajQnWZ+/gWEaKNZTu
         jm4MsKH/eJqA1bRNDdUziw+w5SU/zq26IEiNKNpxlzCKPJMLutXsi+VcVBuYSV9t6cQW
         fnPD+fl0KspePeoo8JmmnCMhNe3VyaapEm56UZC51qvIhK1NumN9XLatYuDTd84TS3wd
         oKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        fh=GfCnEf+HY825SHkHzVHKzbb2AFIaeH9SHzDhC2vRWL8=;
        b=Lja9zJNM63meaBZK8B4hAZ2Knvso7ooX6f0RhjZON2cKxodOju17eY7J5Ibdp5uzmQ
         w2Uwyb3bNwqdbfGkiuUIzn09oXFnfBJULYmXKtNmsNt5k49hrHnAhRiOr9bZXISH5NnL
         6aX5e7miIaSWOLoXqIgePULcAU1SiUeOmy2I9aR++6OEIr9yoU5stI6xiz2g/lQEm7hZ
         xLqceGfEk99L44k0/2x8nUMfxczybOT6INh+zq+pnRbkISo2E4r/3VLEPIAkb8fq7nJH
         YJWRJM84Tlc8ZVSUr9u3Z3zYZI1YQqUxQuSbLRazKQX07JA+VusS25ABkDlPmBh5KsBt
         Wiig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769812326; x=1770417126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=xSsduIhTCrRwZ3JLNdbKh8tE+MdhFL5H9uFQ+5tllsHBric51bEYgyU7uP/nPJVuVm
         PXBuoZbGBGhd9jC11zRL1GU483f7Fvm6uslzLapeb6QBFVPq0QqUEi22Yh4za+kn63ZO
         VYPzScWvoAqGFSaLLyA8MHrbxgl4Go5rekjKE33pKIWosCL170UwdnhFMbcWW6Jy1nHl
         BTUoIyOiMwtb7w1k7xMz4I30jgy1NoIFY4KeyxuPTUlWRVzku48qag4B+Mw5y3wg9X4J
         7qYXltKRhjuTRa93Kg/i5KMrUJXJP9GaY7mIYlek1UyxtuCoSVeghV/7vYzm2MaotHdL
         Ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812326; x=1770417126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=LIHMgSVllveY2sNebMh+WsYAZ9dfa32gmwYocqUTbcb5KXCXTiNlcctpLv4UgFeZjm
         1Ftx8e4xJ4fhR60/IzrKqqmGT+WhLzDaUiURp2ctI7iwTO6sXbKiGUsXsKZwHLXgQyjA
         H1pmAmMUQGfvNoAqmeTaF3UYWT9TtplmCzm7HW/Ioe0QuN2Slv5o6gGsRAGBpnRrxI3b
         F/7UbNrSc3352w4atGYjMqv52XX14D0Oxug24WygMmXTsl09wwvaBosrcVwExvkiV1/L
         H5gbrYSJ6bBsJgBxcre04Hj0sAWv+KiOLv4mgwr8V72id9/OfI2ee7olVZ70YWAjUKrC
         fMag==
X-Forwarded-Encrypted: i=1; AJvYcCW8gsls+jTZ4+wICPNH1Usq7WHmbd1JvO6mJyB05doNrCj+QXvQU3Uy/LqaYRrCzDT5ygw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5tt+2ScwtIMxrLfs5war9dw2d6vNBETrfMv+yr7VLT4Nutmn
	A5BUVUBm8fYOq3OcQmD3vV0USw0A4Wkyns9DjgxRrxM62sPCbqwBNF8vEeiPyUBsVks/isSplzr
	Eoskj0tEUUGth92HzTBv4ItG8VFY9aCjibvXTyd+X
X-Gm-Gg: AZuq6aLUd+xhAyutiJzDAHIn5eRg4JY/iOv66wL4kN3GjiOk0S9USYcSJga9IWwO2GE
	+rXML7ZUENrZVq8p05NNDalE8+MgCOp9qVycP3jLCSDVEDi7I0eEPQlqAUsWTqTQub69RRknYrl
	HVFHLpCzHWIQs8rALGsWQ7EP3U5aR26fqBWwGAXTcFdgBR5xpNbkbgD4K7CDwYzVe+VvHPED47u
	UKTtNop4X2SD4KPq3ecw9j3GI/ydsZzf542FygmHovC1EKWyojX4yKjSl8iDOh8aO9I
X-Received: by 2002:a17:907:e0d8:b0:b8e:14cc:9197 with SMTP id
 a640c23a62f3a-b8e14cca990mr91520566b.15.1769812325869; Fri, 30 Jan 2026
 14:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com> <20260130070424.GV3183987@ZenIV>
In-Reply-To: <20260130070424.GV3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 14:31:54 -0800
X-Gm-Features: AZwV_QjYrhpLENkXIfDxcZ9u-zvP7f57lE4mcVebqUxFVKgl6ULvCT7XG0RHQoc
Message-ID: <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> OK.  Could you take a clone of mainline repository and in there run
> ; git fetch git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git f=
or-wsamuel:for-wsamuel
> then
> ; git diff for-wsamuel e5bf5ee26663
> to verify that for-wsamuel is identical to tree you've seen breakage on
> ; git diff for-wsamuel-base 1544775687f0
> to verify that for-wsamuel-base is the tree where the breakage did not re=
produce
> Then bisect from for-wsamuel-base to for-wsamuel.
>
> Basically, that's the offending commit split into steps; let's try to fig=
ure
> out what causes the breakage with better resolution...

Confirming that bisect points to this patch: 09e88dc22ea2 (serialize
ffs_ep0_open() on ffs->mutex)

Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCD42E016
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307104; cv=pass; b=TYJK0jNyZO0PW0BxDFmFk+x7RqIwtPTjE6eAxAeHOU6LFgsf+1WkwXM1LpnQp45bdhnkh/gGlBUceEY0oKWVumD3262LHc9OmrHBxFoOT1JFqZBHHina+rlRoYZ0HkmEBgRKtynEyQPkWRUyBd7Z2JWI8AdooE9v6W65JgUFWO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307104; c=relaxed/simple;
	bh=mhRjsY9XdiyEWld+ROW1wj+EoQxOZCQ1eVAjPZCgUxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKIBcBjdKC/kNm+Hymf1xbgi4LiI4MzKMLOx5eHOCvBhm8ot1UREBNFXF0qUAM5Qfngr6+3xiXJ1fRuTzVdWdS46qfIaG5Us/zoAO1xtD6XDA3x5fCb0pcAMWuMZ6YIo0atTOLCCWBbHKldLARtiEhI31xE68Y7U3ktfYoybVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJIchiKl; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJIchiKl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so12501995e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 07:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770307103; cv=none;
        d=google.com; s=arc-20240605;
        b=DD70a096geEjbkUdWWZQi91mlZ2NOtaoCjUqnGy15Py5Ib76kp/rlLx2HwE9nEpc0v
         ydHxjP/myZCBv4avoTthG8kGrTkqtbxQeXlD6kjlJnE/4nZT3GZb0cPINwPfVPAMrwpG
         mMUA21amX36zO1cU2T4n/ptuApTwARDly3v0l6O+gQpfNXJk3Nl3s1KymzcetTw9qWB9
         9hOLE/27mxxfrlStZKXfYvCzeQY+9gw4opBvZheImFSi5XGXZU/ZMx7Ul6tYqWPrjMGU
         y+GFBIrOapGveIHNHY4JVf6gzdCHCpLmaiM7vV3ytinzSAXA76IDWT3PCShIk+O9dN18
         169Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lEOIUdssHjNAbAyKETqU9sXnwcXc0uZE8jvop6D9OmU=;
        fh=y0X5OnHIw5ksfKLwaIoVWiCZAIseCir3g011mHwt8tE=;
        b=HpMhku1XxieAO56JZf9CLWYMDvFTqRkFYlo8dqZ0+WuMHliaoO1c/J147wCX4Lws6z
         6O/ZBOyTI/yIbO3PaiaHP5xqToW90vTRnWWjyvjdzOUV/5RAaO5RjUl5sPHNPnS/qezT
         mVn33nKT2xbmwmFO7TIjKPMFXfI+hV8eZRT/hvjh4lfY3u4q09OCvtczQFPpwBSUEb8V
         yjXUykqKR/7LBeCIUU2MSOJkgrGE21+A6ZhSSkqqWMWrol56vka/xDteEZwxNpguWqsd
         G56h4Jd0hXvab26StAHC/TrLzMP+CWTl3QbJKncX00M7lI/o/lBFMVde/FbHOnpF+wE1
         ky5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307103; x=1770911903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEOIUdssHjNAbAyKETqU9sXnwcXc0uZE8jvop6D9OmU=;
        b=PJIchiKl1VF0HBY71zykBGIw5xRoNXsmZbmffVCnrpESe8KUr3zNHBzax7S3DeGwj8
         4IFbH/1QFdqEKpncdiGoaO4gETSCnu0LMEWSSxa3VFkBnPyB4lxu+SP2jCpuDx41IDfY
         pakpOWde47KJeiEZhL7RrrSl8nCOuWM9qhW13bjw4MypX/QwcK3kkitCzgU058RQ3GHW
         06frYQzP5ozHRW4acrS3QmhuYn/DG3T/Go/0oEdJLbzr2UuHUQyf1iQAVkUhZXGgkYLs
         gCHit5g+lzshmxP/XPZ7VuvBqP5X8CaGpuRVHOu4RnA0354JzCgDI3wHAoI11IMJWWIP
         SUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307103; x=1770911903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEOIUdssHjNAbAyKETqU9sXnwcXc0uZE8jvop6D9OmU=;
        b=Z1Mff9o6/ldJuHD7WWTv7ufbVxPTe95FS7cc6cbJBJqNrE9xu4fvADvFgkcAHTJxac
         K49vTfKpT4hdeiSFkLCgrIeMqNivyu+vrqFuMcWKBgMys4aC/cVM04bDypxq3EFyTXNV
         SLqku9g8VJDWUWWrTyV45oNqvfA/k5E+LpY9GLL5T8TFah0EIQgv4z8+vdGH96gFoewn
         2OITnNgllMvlDmmeDih9sycfzQrbTEACJe9OZe57iG8YNcfN83HLTjoW6yf/OJ11ikvL
         qQ/Sb3hMYXu6cnOGfg+q4dCZ2MbqPLl8AAKuIjaRiYJqnYkBMPsIw+W8bE7wf4SbF0gg
         cDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWazhARB2pNeRXieoXv+HgllUu1YfJibjsVVQHx5L6bGeYzQR+HnH3TSXbdg4lCwsczAcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFf9Hyu82sqbYM5oCsjMs7tT854Aelv9EFne2+PAVibz3Y0fEU
	xnA9x8fNitJ8LdA5BRomvY/PsfjE8ojJMu+SP8FV2FCh/r22jqMox37RBjhKfC5lChqlWQjphyD
	cgpnITvO7v4LTroWavEjp4EjlznQISgg=
X-Gm-Gg: AZuq6aIjliajk5Mmjw7ud5hphXLPK1DD8GuE6xTqvzEWfWOV7ySnESsqzv8URo6cciJ
	J/o4YefEfy2PO19Mu6brQNXHDhJ6NWveo0bbXySALGYpOozZpRAB1xksBXuRET61SNYGE5mNyf/
	mPbZ2WXmo+ZIbwKF7xauwj24qrBL+WhWwcb40Q9AhRxgWyhpjVWoyopxShDrt6+MIV6046uMGBl
	Vq4q0EjpyvwRnDXtd8MpUSCHPD9AsTwshHN6wXg8WHOp8K973ppszNltYd7+Rj+sMsQPmI7Z1SO
	M4m5K6f+tHFsyeBLltqkDHF26Ir+MB6nIZNcZMjeRunb0xAMjY+XHgSnbBVzxr7q1X75XyaM
X-Received: by 2002:a05:600c:19cd:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4830e9402f8mr99700685e9.10.1770307102712; Thu, 05 Feb 2026
 07:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204132643.1302967-1-arnd@kernel.org> <aYRapf5K8wFGEO8v@pathway.suse.cz>
 <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
In-Reply-To: <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 07:58:10 -0800
X-Gm-Features: AZwV_Qip0-Uod4KA17qrGjY15Db9LSEX5ZZwEFt60DeX3MwvopCq8Ga6SLOClDI
Message-ID: <CAADnVQJ5uHCVm3d_hO35cgrrcoLYBgk9x5iee0rNXBqKkHjj4Q@mail.gmail.com>
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing functions
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kernel test robot <lkp@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 5, 2026, at 09:53, Petr Mladek wrote:
> > On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
> >> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __=
printf() attribute")
> >> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with _=
_printf() attribute")
> >
> > From the commit message, it is not obvious why reverting these commits
> > won't bring back the warnings in the modified functions.
> >
> > My understanding is that the warnings won't get back thanks to
> > the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
> > GCC warning for va_format()") as explained by the original cover
> > letter, see
> > https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@l=
inux.intel.com/#t
> >
> > It would be worth to mentionin this in the commit message.
>
> Unfortunately, I have not been able to reproduce the original
> warnings at all. The va_format() warning and the patch to
> silence that look entirely unrelated here, that was just the
> compiler incorrectly identifying a function that does not even
> take a format argument.
>
> I'm sure some other intermediate change managed to shut up
> the warnings, but I don't know which one. My best guess would
> be that 938df695e98d ("vsprintf: associate the format state with
> the format pointer") made gcc no longer warn about bstr_printf(),
> but that predates Andy's patch and I can't easily revert it for
> testing. Checking out a kernel before those patches does have
> the warning on va_format() but not on the other ones.
>
> >> Link: https://lore.kernel.org/all/CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4V=
ReqAJ=3D68PaaKYmg@mail.gmail.com/
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lk=
p@intel.com/
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> For reference, three additional patches are required before we can dro=
p
> >> the Makefile.warn line that currently hides these warnings:
> >>
> >> https://lore.kernel.org/lkml/20260203162546.2254900-1-arnd@kernel.org/
> >> https://lore.kernel.org/lkml/20260203163440.2674340-1-arnd@kernel.org/
> >> https://lore.kernel.org/lkml/20260203164545.3174910-1-arnd@kernel.org/
> >>
> >> Tested using randconfig builds on arm/arm64/x86
> >> ---
> >>  include/linux/seq_file.h | 1 -
> >>  include/linux/string.h   | 4 ++--
> >>  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > Otherwise, the change looks good to me. Feel free to use,
> > ideally with the updated commit message:
> >
> > Acked-by: Petr Mladek <pmladek@suse.com>
> >
> > I wonder who should take this patch. Should it go via
> > printk/bpf/tracing or another tree?
> > Does anyone has any preference, please?
>
> I think your tree makes most sense here, but I have no strong
> preference.

As long as it makes into the upcoming merge window any tree is fine.
Let's go via printk.

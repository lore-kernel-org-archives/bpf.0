Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6843D3331
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370970; cv=pass; b=X1YdAIO921KRlxIJpqtJ1929v1gbfgqeCI7aQimAOoaaxIkCqZx/ePPW53ykD+UB0t4RKg0tPNDTnqyLgKUiLvuILZErLhmWP9bYr7I2uC/fKdAyj7TgElU9wFCDpVeKwMtyLO26PWricPSEaPbiRasatcpKD40qUHLHQKUS0Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370970; c=relaxed/simple;
	bh=sTQqW7MB7tkWpsSAWmPEqS9yUjxACRtD5O5ZonpvFhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HxMtVMvArJHg0b/tnY5TvXh+OdO8vT3/u0pSlH6tiiKITdBKPlw/JgAz4kzm1nq2YmOMw9Xy6wQwPKdWPjawtRpXZTjPE/hVO2E5fOHaY31PD9tmHuQxHd5lydHO/q/R6bYDQkfWbw9uU/1uf/YlNrcDS0s1K40XrpXr6jc0zZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlx1xwb5; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlx1xwb5"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so206086466b.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370968; cv=none;
        d=google.com; s=arc-20240605;
        b=AGQdJt4qhczYLR13KdL18QStP6xmcL5A4b1s8BKBD1FQ4gVta29+W2TL+oOCsqMWtm
         R4UlxjisN/yBXlEAVUxfaTWKSOtPTY3+IdoRNSJMjomH4tvbhxgsJCQEal8+3IqXKtoL
         Y2vpol/a8dhK20Qk7Y+h+qaRj5fjo3F+CbgqJHxCAli+jGq5YH2RldTrqxvCMixXlZPT
         S+a/M48cFioF/CzGsW+aTnK07JiRuutq25OYzMJqdYE6NtgJHItvc1YQtPNsCbEeYE3y
         x6yxBzZnCaKyBwWSJcz180LfnAQ20h2bKMR4TN8qEfFi5sol+D4W0EHCGExlqOLRzZCu
         dMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=LUyPHYFnDMu8hAARucm+50EyHryzQIeZaT9fhosOQIc=;
        fh=oDaasWieX2g0TqczPJhjU8nhLEl2mcVZOwaXld8eNO8=;
        b=ZW129OsYIRL+NYwxinhnEEJlsw68LvI23zu2DT/cnlU5RMjaO3KI2SEblEui3o9mnl
         A3nRk+hp0S4r/tCciBggfTR+JYqd/UwFsdbwRhdFvq84tmJ5eME9Lce3qd9Wqz1o+TfT
         v8vEekWMVlYe10yHcijlm4ddbwBFNup6u6+1HJr0HbtWnYpLxxG5ND7ioA0l6GWXeb0P
         jUCZ3cuayee3w4qKK+meiq/YEt2WjChbwiEeSfHNBoV9A4bnf+9L2eJlkl32qlcQSncM
         2AGfgP0St1p+TxHp1T6abzeXY3t26G2SE1piWe7voTy8vIFGDR1c4ovO5i5iOYmouh27
         YfhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774370968; x=1774975768; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUyPHYFnDMu8hAARucm+50EyHryzQIeZaT9fhosOQIc=;
        b=Hlx1xwb5jW9MbnR2HiOrVd41zDtrvMi+iqfqLsnK2Gk2tNpQWKsz4sVNUCygN9LMJM
         hn1e3mGdsTVWvY8fsSZF6pSAqwnJE2qjBfLNOJt53R3jdjtAA66jW+UCm7rzajE4yR2A
         S2MgKFeF2JALhVazO3q448nytvs0Okl3GSrPKTd613or/nUkpNzQ5YXM6Fdl7+O47fKg
         S+ZRlNveULoxLuN3e0xoB8Zi+jPBmMAQB+fVXaZqhfw8iQpdB+JtHrSfTMbZLDf/xw0t
         +Cp+0HNjBlzT9l626R+xT3zQ9FEjOSQRrjiEYSx2Gg3gRG0kPEVuL9oWncl3qN8qeWNG
         vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370968; x=1774975768;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUyPHYFnDMu8hAARucm+50EyHryzQIeZaT9fhosOQIc=;
        b=GNbyrbxB3XYYBK586MW2MVygyaZJ3jqQtadq9manGfTzrEDRTDLRjtSlOCPOj5gZiS
         NaIqzyfxqFqEr8iG6UOyIU0nAufP4fMhYFYzSSIJVlP5zAY/0gWWCf9I/Is9Hk4/dILH
         r+3aTg484P8LueYaCZO6+G+G4Ro4DaHN7KQwl5NWwYfviAHlZxFj5G3fEa7KyNQc3LMT
         taWcXXfgBPpbWfV8r9z+u4LSD5sazGNEWleQnelpmN0eLxn9vz3/xl1Q+XthlVSBUXFz
         guDkdEbZpx800lQXKef8L31WI8Um6eV2/5XzHbDj58efK6Vfog5d6CQPpCEG5KNCaH3N
         oGkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwKJ1vBX8+144ucXL5SJ30EQmqQ7FkIKfA1cSy6ycJCCg8lw/2wL+N/Q67+R3dgCbAKA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhl3xsypvNfrHFAa6lyFAE9GTvvSEqns3mvWxTdOZBDT/hI28C
	MOl76sca0dxcAw32Ibw61Vnc2wbgMBYLgFo194HzddFIijau8iQXU1qYj3iCSgi4QG2ctfGuec/
	tnY8J1hqAi//n2MNDIVekQekTK3cSs2U=
X-Gm-Gg: ATEYQzzOnjTv5s+sKB9XuQH2URwm2hn/4+YCStrNzp7bIT1XutAYN91ouEtuJ5FkiOC
	u3NDbJVQh26HGbhGetgAka4ruRoLZQDhPvSHvUHRwgYQ0v9IEB651VJ/0rdZYLWKqhxrkOf+2lR
	qNXDDsf07IBiVZ0AqqJi+rtkcnBH1yN3C8r9ph9pzwn9dHB8qxFXmxtrcLGKGjnlcfD1PQSeRVW
	QEuCgzeEacbcKH8uMPIf/AdHI6Zy3mxxcDebLuL9OliOnwS67n6dFkkND+PpicEI2AfNckqaVT4
	ZC0=
X-Received: by 2002:a17:907:8694:b0:b98:11cb:5fa9 with SMTP id
 a640c23a62f3a-b9a3f1ac473mr9080366b.22.1774370967348; Tue, 24 Mar 2026
 09:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320132356.63194-1-teknoraver@meta.com> <20260320132356.63194-2-teknoraver@meta.com>
 <1d708196-7b89-431f-bb17-177564196894@gmail.com> <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
 <acK+z8Udlg1qyDeu@devvm20253.cco0.facebook.com>
In-Reply-To: <acK+z8Udlg1qyDeu@devvm20253.cco0.facebook.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 24 Mar 2026 17:48:51 +0100
X-Gm-Features: AQROBzA2_iW4WgzLGFh7V8V5wrdvQTwU5-3V6Nc152QQriQY_B9N3jAu42FUgtE
Message-ID: <CAFnufp0_xfO7XquPpWjHs3rJnPw=ygQgriGJXkss2nrrXq-UQw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
To: Joe Damato <joe@dama.to>, Matteo Croce <technoboy85@gmail.com>, 
	Mohsin Bashir <mohsin.bashr@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 24 mar 2026 alle ore 17:41 Joe Damato <joe@dama.to> ha scritto:
>
> On Sun, Mar 22, 2026 at 03:11:56AM +0100, Matteo Croce wrote:
> > Il giorno ven 20 mar 2026 alle ore 22:23 Mohsin Bashir
> > <mohsin.bashr@gmail.com> ha scritto:
>
> [...]
>
> > I addressed all the comments and I'll send a v4 soon, thanks!
>
> I was paging through the code last night and I was wondering: have you
> considered splitting this patch into multiple smaller patches?
>
> It would probably make it easier for reviewers to read and comment on.
>
> Just my 2 cents since you are sending a v4.

I thought that all features included in NETDEV_XDP_ACT_BASIC must be
submitted in a single commit.

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD63F5BE3
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785970331; cv=pass; b=bZyryJ3FmboKNSbTmLkp1MNl/3LMKtWvrSn1eP0+RBqu0ZXOxWUoTNobn/0djYYiC+7tvLqKf/fmu49UTbW2g3ED2WrUpbU317MRhtMfOdx6xGReUfFQta9GzE8+fvmKPFk4Z+U+nPWlGpyFECSxfzjfZna4WrWaCOAMRReA85s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785970331; c=relaxed/simple;
	bh=zW3RxM/rNbqJdWn4Mi6JYrmSdA5p5pUuWesdsgwjB4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5tqL0E2bK+k2ujtao4bpEKF7QjOeeMSdZ5UZqjLC4qELFSbURcCyaKRIZkbIcyugyMSFSmHMlt1CT61ImE4fnTUMKmfwGkhNG36Za7ifZEyt7Vh1E/t2/LyRw6cwSoj5KjDlv1KWvwfc8q+KLvL1HhqicguddFujJSk1oBwwrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UCx7JuPr; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UCx7JuPr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceab75934dso20248005ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785970329; cv=none;
        d=google.com; s=arc-20260327;
        b=dbJSxtjTAKa2NPU0BWefLM9tZ+QlKLDYxqOcveMW18WnjCy7ARIZGAGIwvNPUIIi0K
         THqrCNL0CLfERIYir514Zn0v63UeLDBcrTh31xgwnM5LdXjFoPawu4Kr1zIbqAdVNr1r
         GuBjizvKMbTovFVvrVvou/YTIyF17Tg9aAXbxobt+A/IMUZUHApkeyL668hc/A454uxH
         7moQrLSsw8KZUDr1ZuK4A2VLd5U0RB3kvtYB8Sr++VFSROV4ei4kjy88ag/ydhgKoK+w
         Q7UQCkoTl955/XxVyhkewN/7iUpbU/p9GT9jn48x9fRCzWoZBpjrETWG4Fu/n5vidFe2
         K3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEUgxUIihU95kBMJ6tsYeTw6BnIB/l3iVQ0BO03aWqw=;
        fh=SWSjvXlW3DLN1LBpLL/uiA+3W/WJtX5OQ1LlyXv4dU8=;
        b=j57By7wQwCp6co9DYyQGWtoS1XQWNLFfw8tWQu2PZgrHaPYOWnd2wZk1kLGV4w5lsc
         IYUJchF2snsXLmRMiBrNOu+ZRik8+lRkRQr3pGVdXr9vcWXOsLX7YsBlYW2HARZy54NX
         TFUY99jDLNSIieKFUBnARssXa7mujoqwEAULqvIF+/kgra5RoFWdHEMwawzgSHjcZ8/W
         IXdYOtgd+YTzz4AmlMSim1xtCbsqDHjZXw9EUqediSsowQc5MdKtUG7oh26Mqx+83Bj4
         Gwz2Bzzl9CeBqI76wivfYh6GMqXJk2Aijoj43dk4PNsduB7Q8mrZS26dRrNbonah5aC4
         OjZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785970329; x=1786575129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UEUgxUIihU95kBMJ6tsYeTw6BnIB/l3iVQ0BO03aWqw=;
        b=UCx7JuPrEv0HNJwY+yOsUlz3SZtclI/yOGAryYxTj02QCprTHA75pXff2hHW0SHl//
         cpGQ46LvCwbuCuBm/219MLR/CvMH1/BVJ7NddmWfiyNAuT5ZwaWhD4CORzdxOe/8puzk
         VEOPAk6Bv8IajkFG0hQxTxiVb7VS6yim6cyy4jSZlA3qkZPCLOBMyrm1DxH2+eobp7bd
         JgRPC126xCYYhM8i+UDiIqPcFLBgnOM+lzZI9SAyHBiNmU9B+OtQhsFxtmuSLo4+OTDF
         RyrEkUSr3dnG2iGVXOWyCHpdgQWwhvAwuhq3NIZFcKA3uIWQ34YWLNVhnG0tnbflZNYt
         SeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785970329; x=1786575129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEUgxUIihU95kBMJ6tsYeTw6BnIB/l3iVQ0BO03aWqw=;
        b=CFm6C4Z3qagPvQuYMeOjQ7IQ0zeZoB0up9lzmWC3VsZoLJmmeVxAYi6GgUSArD/TFZ
         Jj0CPSnkciRpRMWsD64ZXJZRFPslbflk1mAcWR2121d8qpw/kgcHIjeI1d6tm2U0mFVN
         YV9/pyAMqA2F72zhlqeSusCqzuR19P7ndsFCxuch8tQCRgLsGv4+dDDvBC+jTcB1t+8r
         9Qf6TWP0eWb784x47+WKku/aiH+WkO9j6l202XYtQGCs5Cfpp8TV3ygxnpF4pvBmrip1
         jHXim/GiZXjr3/iN9qlqvj8Ltjj0qmxjmQ0DX2bKcOpewGXTpiBxnh0KYfuHdeio7MHj
         b63g==
X-Forwarded-Encrypted: i=1; AHgh+Rp87n7SjZaOfeTLDL+s2lpsufJYpZGg8CCYK4tWrrssbdXEt9LDdNvI5CPZpnZ/F98+nXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3etZjl+D5WAogZN/Q1SOUAyGOnb4EyY2VcbRZbmZrdaYWzy9l
	UK4VLMFnjkDzC8z2+WALBCQLnlJXsAPe4bb6ku1LOUorw1x5DDdnIU/RIw5Cib8scbl1EtN8SP5
	YDUR0hsw16aqR/MO0bPBRxw7+goRY0iahdkKr3GvS
X-Gm-Gg: AR+sD12ut4p6PCVbAICLWFkC3TcUO5TFjZXdVOxF+xMpakgO1Htmk5valdJx9Fp+fSQ
	l4VCBrl3vuRz8NLRv6HAouwpZ7lmwhsTZPpYeTIYbkRabgra9koIlm8I1aHNvCINeJo/0TPQ53w
	/EyIj9z5FgyjsRFQjYHQuBA+tVsDYEGoVKQWU4GiMMTa2ow2KUcsaU3buQtWHhCkGn2WQsSTMOa
	D5QyvoHOiH7BEjXePVIuW5v45JzjpvMHIRI+UARhwAn1maIZOG3lT9t6eAXOIVG5LeDFeOUbPkx
	/ZznAYbdsrTskjXmh39pScLvY4ttXol/ykmYSuoBKB6F
X-Received: by 2002:a17:903:2450:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2d0ca70e87bmr103149425ad.1.1785970329277; Wed, 05 Aug 2026
 15:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com> <anOnaGmBTlBW9xwj@zenbox>
In-Reply-To: <anOnaGmBTlBW9xwj@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Aug 2026 18:51:56 -0400
X-Gm-Features: AUfX_mzPunhiwVEajozDtlbD27VL1S40fcPizXOWOu5cVq-CtR6P_R27IEYpqmY
Message-ID: <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:37=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilityemal77@gm=
ail.com> wrote:
> > [...]
> > As you may, or may not have seen, there is currently an ongoing debate
> > regarding the location of LSM kfuncs that will impact this patchset.
> > Sadly, we don't appear to be approaching an agreement on this issue
> > which introduces some additional risk to this patchset.  We'll have to
> > see how that ends up, but I just wanted you to be aware of the
> > situation.
>
> Quick aside question: Would security/bpf/ be a better place for these
> type of kfuncs?
>
> security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> for kfuncs dealing with lsm-specific types.

This gets back to the other issue in the patchset that we've
discussed: general LSM interfaces vs Landlock specific interfaces.
There are plenty of reasons why we don't support the kernel calling
directly into individual LSMs, and from my perspective this is another
instance of that.  Here it just happens to be that the kernel caller
was written in BPF and not C (or Rust for that matter).

--=20
paul-moore.com

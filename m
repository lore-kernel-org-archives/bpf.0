Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7F3438BA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431214; cv=pass; b=Lzn63qQl2KwGAhvk6PgBfQYgGAIc64u6k+hBureSNGBc8wf+jvg3+JFms2Cl9Arx8/sYvnFSlgwci6rdMWHEWCLoLlfKu293Ak198JSRYUFkc9ryROJF8U4Asz7AaENWR6LyntBZkrxcUDEqK379ErFD/SjiipqcjdeQdpFytjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431214; c=relaxed/simple;
	bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOxXYqhH5ReF6daFZbbNSmCz/LiWBOMN7MiQ4P/qRiUyefd32MG0NS53F4/CXL8FgOMXvF8MIycXRa5Xg69wzkNBXYSthuSNvlct9ToRj6zB5Wn+Nct2c8vVSBaG4GsFOsIgrDKbW9ns9sLPkW8N7kLclsScz3wZw+RxGKM04B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fl3ZVujb; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fl3ZVujb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0b944f6edso31146085ad.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780431212; cv=none;
        d=google.com; s=arc-20240605;
        b=EoRu3UbrbbXqe2LkVk3ZlMZ5rJzzn/Ai9cPvw/n22PsUcOQsEDkC8oXPI4hp+aznsz
         UcxZG1H+Ob+schhhkrZ4eflqXO7LmKy1emko+iE50DcVPm9N61ZTzKhOEZv8jM0GsqCY
         twRVCx2xc4PuCfPjsPDAnqxErtq6RHlmK5ufirX5tU2MUmdSgBLLSvhbrbDbyui9B5+E
         jA3C59+Mu3BDeEeJYvovyVx7GiQu7AEXfdt84oi4PJg4UIMaYMYXnZYS0eqgaH1GMo0Z
         NhsVo+QrbMPO35tuXwBE1zES1xMpMU8RrbWH6ZlgaCjMhTz25JiPWbnO0ziw7TD+APiB
         iXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
        fh=cMRToTrjbcR7IQuSTftvy5FZ3OJr2Igkvk5BsogpTQc=;
        b=J/bdSgHx1CALCYz2EKp/rmqJIwCO/nlFeJsENVSZDKnDFUFiyUyFUsW6peU0Yp4rx5
         P6FKJ1OFP0eXFMo/uliWhav16d/RXBtMNmnHgC+Iqr3+x7SYtkS8JIU8M6zMTGd94t60
         8AdaK4K14vnNwWvAmJ8WgEhO9NzzuXfVTHtHfBHvAWdfR6pKlLmpTGqx6Y7SJ93DIgfr
         lVs+01dTzcabIbcxGhWa7NHliA8JjWaJGBJCPoRr1UtN7eGZzQ8tzeXYVOrXTvNTuKSm
         dujSnIeOrBE78b3mD2HIVFnvEFuzAxb4h2MKXhqD6Y7AQskuIqYE+oFWwKfqJIjbDPV6
         KwXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780431212; x=1781036012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
        b=fl3ZVujb9HyNyZlscbOzAqgPIDbe03L42xZxJRK4g828hjkxr6tG40favXwn3F95yH
         NroOjT4q8bioNJtcxiOP4kBFdwhRy87YJmLQVpRCdGVpgd7LTOnXhkmhSBg4u823+ybQ
         erw/ABULTQ5kHSyjlCk+sT0GZw7iz67BFYr7h8N2/+NZiTa0k5yossWAMdPwLnl42HA2
         dj2SK9IxQRsOmjadDicnPx7uGyqz/F3i91dLmvguWULWXxkatm8B7kxrmL2C3DbLPG8Z
         7j0HY56CFEfD3Wq+ITZvnWFrmzQOtUo9PSHbiboAcM89pdcG6XSOLbYSZzm05/DW07VY
         BNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431212; x=1781036012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
        b=q6tEdGVfuBke53isL8wRLcLP+9N30uFIJTxwhtB+f06s4e1pttn+REtqQtpYnj0oN2
         BLT924RSX6Fa1Dv4KT/TpjCCMvFQM82hcyLxxmWvJ9SifepqJamA1xBuNq0zqHj64KbQ
         Ba7NJHU9gbvtX8py5kt/1p/hA1KCP+DkH7VH8+8GUku02j4eUQBaI6cMWXLcCHECsWd/
         d27fezdW/tjMiVr4WskX6Lkb/we1tUWu56Ri2/CMec4H6ArT1bcG7KEmS8DYO7wooPbK
         1sbh7aiFwE9KE014nxIgnR5dW8xy3folVFEVaMPdgvUr6TQXgpVK8inUDXI3JT8WoQsK
         OZAA==
X-Forwarded-Encrypted: i=1; AFNElJ/HIW0T+XTz8RHETcxejuI2R4BvjZpn0U2Wthwz97j3g0FKB4DMeHPFxBQprb69HEwxDkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlkp2qQ9+9FDF6i3Ye2pNGD501d3QhuL7j+eFORkpXo3xwtyNx
	mZ3n6h1bZ5VyZ/BL4uyAPBtnGd1BPLdYSJr2+R7ei2BNPvfEfIyogGouj7Dfufp9w9rRorBlCod
	5I6Tyy31aHfB12axzbnU3BlWpj08YIpFkxJiJdNM0
X-Gm-Gg: Acq92OF3hRy+kTnl/pmlRSFeAHORPdoLpoUOyxW9RvzH/t8Z1a0tuB8/oPvFjsOPUIn
	7T/kk2DD+CraZlxSLaydh46m5V4VbN5D1VQfD3qsyM8ZPkHAxN5xJNzIyBWHI71L+hv9rpV3mN7
	eVoUbj+9RghxHvdVj7sUWw+5hcgyvW9pU3OVNSVqvRbk7yMQgcV3NUeZ71uuXs8qWJxvxnz8TOz
	MpzReD16SpL07hJCft87siOWVAGPLTrWCmtxZcHMVMeZnb3onD1Lu5iaX0clvk6eYVlyZ6XL8U7
	/5azbY/lOV16FYgWTg==
X-Received: by 2002:a17:902:f60b:b0:2bf:160f:7043 with SMTP id
 d9443c01a7336-2c1644b2994mr2445575ad.34.1780431212343; Tue, 02 Jun 2026
 13:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com> <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
In-Reply-To: <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 16:13:16 -0400
X-Gm-Features: AVHnY4KpKpO9DYaOTu4rfr4g8D4KZLclWt7FiawOozC45PMKWNUodtnlnRl25IU
Message-ID: <CAHC9VhRxeTVxCW+=1DR5qzopGyHBMOJuWmtBqT_T4r1LC1jfBA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Tue, Jun 02, 2026 at 02:40:12PM -0400, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
>
> > > Thanks Mark, we're taking a look at it now and should have a
> > > fix/answer later today.
>
> > Proposed update to Hornet, assuming this looks okay to Blaise I'll
> > merge it into the LSM tree (and either pull in Daniel's patch or base
> > off bpf-next so everything builds correctly).
>
> > https://lore.kernel.org/linux-security-module/20260602183658.161744-2-p=
aul@paul-moore.com/
>
> Can you ping me when that goes in (or things are otherwise resolved)
> please so I know to drop the revert from -next?

Of course, no problem.

--=20
paul-moore.com

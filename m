Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8F192B90
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089638; cv=pass; b=RbiV+8apgSVkU9+lLrfYqFlwF1GUyDBRas1oxWrdz2IEPld0MBNdad+Gx094x5m9Hen4VoVgp/xC4hdU30lu+Mgenwlr5GMTOtryRr6tgqG3NJ9Vr4wO+yuSCWjkUxDJOi63MfMpXui5+6JM/nIpe6oyXX5bKOIeyTNtJvdVHpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089638; c=relaxed/simple;
	bh=oi3M05qvfiVdUcoIOlKMoPBzKLPQz2DwP9MrxhCG5Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8h5wZfumJSxpD6v8EatznwB/TtNpIydNb5FtTy8VPcu+7Ju3IuUYhol5JbG7LKqMF7W4yi0kLcR63hBOxj0bcioTy/ocsBgJFongfgrBmJ45SQn6yVo47a4tDej0xr7NitUCLBsti4cy2Udgp04o23YS7ST044h+pjgQEUNnjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nt0sjEc+; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt0sjEc+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso9452285e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 17:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775089636; cv=none;
        d=google.com; s=arc-20240605;
        b=gMKHbGc4M5ODrKOOQLUiiXi1UH3W/NFek9PzGgOYc3ID/c5GbyA82EqplA90AuHUGw
         2d5jCiNe/Bh5kTvEssOtQjY8Gug2aGKR2qgEnLe5hxho2JTrG/jL4LSUu8BgJm7XJk2d
         A3WZ1Kj+9SvBgBIyekD4m8K95y4R7c/xteTaMBq0KDYnsnFRwXoZw5c1+IBoY8/0mvd/
         EXEC6LvEPzqhxWIXHjBnrvn9dDNEDnrFZVOXqlkEV8ElTTYkSWsct2E+35HfutHFO6Vk
         WhLOyEZwuvA7CJ1Ad8nqd77pDmmR61SuwcsZw+0wFruUa0b6iBiFFT3GlqaBc1ZoefCJ
         bMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oi3M05qvfiVdUcoIOlKMoPBzKLPQz2DwP9MrxhCG5Gs=;
        fh=6wQh1Q89SGNTgROuhgSuSNeLKDUsBTdzppeio21WPD4=;
        b=Gq/OCULeEL2l0GEpyZl0PBeA6Wh3l7nhbvltjVbPtFt2kvx0+Jd4DhRH459J57UtFs
         tekbqRWWbINL3zrFHPg2AH10LFme9HOuxiD2jLpvJ0aSiabcp/tZXJNVv+bzSnSMhxYa
         k1Zer7jXzAzRQ/fUpJXN5HMXNp8ZLmzo7tOnexP8K1hh7DJCkAtOPkEna2/gZFzfPZ1H
         Zy/m27c268+mfuIZqIpI3nb6JdrNoR6iueq3Ab7vvIx784b2rmEpH56rgcgOd0dqDUUL
         J+qHa/ThRufb+izdGuRAss/wfT8fWmhEq8U0r7PI7siay2B0I3rUrdrit2bHVy+MQsOr
         F3gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089636; x=1775694436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi3M05qvfiVdUcoIOlKMoPBzKLPQz2DwP9MrxhCG5Gs=;
        b=nt0sjEc+jOvC6Bsf/W+JgkYWnWqOo3OEvO6wRqM4p05C57ARpMpxV76vtmMYUqLpX+
         TmV/0IAWGaRGV3IhcZAbTR0+ojpE1Sj+0lftXnho8kE+tyneVkETcKwWNDRmXUwHBvoq
         Ir1Ft54TJvf000AUBOcp9kACrzIQIzbyIcJ/3BpBkPOD79pWmwZR2btwricE86Cbp5Lc
         ggdaGaMKYshTl7dU8bLycWysmz8XUPTIv27WUTre/Jga81Hx23NQqb7MK53yVjltpKWn
         WmyhXo64rNPlPDnXNGlAbGjyFa6AFu5185XNoWOT2/+qXByJPriwfAOmT6Stf3Gjegs1
         Q6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089636; x=1775694436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oi3M05qvfiVdUcoIOlKMoPBzKLPQz2DwP9MrxhCG5Gs=;
        b=QiZuVnLNlYI68WutJSbdsMxuk3a89Yuh4cMCjPcQGUR+upJO6KJNpP1Iv+JABWDu4a
         Fc55o9eUl/hjYvylxfxvWkymdxCMYzvUMTGZV7iVpPYuCpx6EkMv5jlXrYCbiDDWCDgL
         f7myT1oRiageoCDAKrSxoc1GxakLPqHlZ6WiOd2nEzO/Wh0YM5cpbRDOKFrjKqYBCzSK
         nOlU4yBo4SZdm2kujiRyoKcxhlk9Htot8hOnin3c1ifYDcJ7y7v1wW2dYxpUkoSnoLk9
         oPJ5HjAV7eTnF/83KJ9Oj/qbdZYMGNWTFY+JhRS/cw7mOx2dcoCNjsT7/68/eBMlbLqb
         lxRA==
X-Forwarded-Encrypted: i=1; AJvYcCWkJ7UTpjsPbJZnlW7rKe83pTRhXkk9xzMdHUsk3p1eOUHmqyhFJjolA2dsaBu98nnnzyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZpZCsTlnCXGv+6Ckh8Kgff65fclmYPL2oAh+kZKQo/y5H83e
	lwHpBePsy9a8YuE4/BK0TjQZ+4RAqaIs4xAzr3DK+1CwjxjvYdSscj8JBvQ0lXwHXt+KqQeXJyY
	8puEBAKWiyRqHQ9xRHcrlqm0SnKHzENE=
X-Gm-Gg: ATEYQzxstVMnfUJYKAefKZ1O4nQlsVZWJ3abCrvF6f5LXzPr4NjTpoueQccSwT8HUNz
	Lwy5CLM5Dxytqzx31PLR54bLdRjDohnUUV3FF5vq7FOwLy8BqdIBrmtd8enfmhonLnrw8H8H9eR
	k53/kltPGVSAZwe3aQmsVDK72Ug4X148aipx75YIHKcZj9o0PQQST3oTe0tYuqYEZrvCLB7z8PL
	f46ZwzBmWPKoC9259VaIlWSgzoOOvvgKiM2BC66Xye7oPEGnM8997AmGbDKv4j05WWn4awnpzAn
	s+bMmJnWomn7X5Bz++V7q09nG3tlOEcdCNypGNN/b9eltY0ivRMhRL0+ZJm5s+/GNyKBA2GkIJq
	zyju6xyWAy/Fn+QCEODqLnUovbjT6zu+IDKjD
X-Received: by 2002:a05:6000:26c9:b0:439:adc3:f0e7 with SMTP id
 ffacd0b85a97d-43d2116cdefmr716101f8f.9.1775089635775; Wed, 01 Apr 2026
 17:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-2-a.s.protopopov@gmail.com> <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>
 <CAGzPb2Ed+Z513yWDUE91H_OP2eF_fHucy_xV3-cpYOkmw73xmg@mail.gmail.com>
In-Reply-To: <CAGzPb2Ed+Z513yWDUE91H_OP2eF_fHucy_xV3-cpYOkmw73xmg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 17:27:03 -0700
X-Gm-Features: AQROBzDM1VhDFl4UVM_sO4QrTbwr2fhDSKHkMaC-uo0PhXJSVrNHWQ0s4LFCOgw
Message-ID: <CAADnVQ+K1iEuOSRVHXbEwkeFQbtGxWzEiPJc60jVv_wT=zOXuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
To: =?UTF-8?B?7KeA7Jqp?= <ksur673@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:18=E2=80=AFPM =EC=A7=80=EC=9A=A9 <ksur673@gmail.co=
m> wrote:
>
> Hello.
> Thank you for merging the fix with the credit.
>
> It seems a bit early, but Since this issue effectively bypasses the verif=
ier's safety checks and affects multiple stable branches, I'd like to confi=
rm if the Kernel CNA will be assigning a CVE ID for this once it hits the m=
ainline?

Absolutely not. It's not a security issue.

Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BD3BD64D
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217054; cv=pass; b=mPczUmoZJJgSlQ5hUcHZb8M76v5djRUtRnSPaIQHDt6rT5l95nstEGlRsINpXB9kLg7s/j3H3o2G4udg5sJAxDTH9oxzXscxa2GTwkeFO9vWeWZL1D0ujAoNWhALrlF4EaixshnBRETvHYmmoTFQKOacEBZmzamBkmh1xPzZHI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217054; c=relaxed/simple;
	bh=S4h1Woe8qq1XwMb4pkCeaJdMxtTyGeVDzxpnT/rD2oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eL9lezs9jSl2ObzWktgKtp810nLaM8HGLhQobvTblTJGstWuxZdV5R7rpMVkak9LNSUVCLe3IZsyglR9yXWekgVjAC+cnnJeDHY10vulpAt1kUheV7mSy9aYx9Una1wYm2djuOUWfFogwWS55WBfRysszUEG5a1/p3GgaICLH/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W67gzxZ3; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W67gzxZ3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-861145fc841so25766257b3.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788217052; cv=none;
        d=google.com; s=arc-20260327;
        b=mqTcMz+uvwbRt9J4Gxlfy1/KHz+XFL0TXXC94dkhgr9asMPUpp/Xv7GjrOS3PasyfY
         BR6lX0FIo3FDhjNkrhIOVGJhHdykG7rFQpGZ2vhsUaIsdi8X48UoN4BRnxiOlDAzUxQs
         /ZqOUMrxmyuu5UDBfXogYwSBFtoSlzFtPxOiyMT2oGeEGjwrZmUvOJrnvoKtiYeLAf8S
         AgUPwKBEX11fpvYfXAyy5VnjfvWPckvBhjt8A8XbOtwOwUQ2DURD/CmkI+PAe30KQW07
         Dj9Tw5R77qFNtd6nGMaHb+nzOF6aH0wJYE+phCP2LTQr3hS5EVO9sENb1Iy0b4Xc0JVm
         oJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S4h1Woe8qq1XwMb4pkCeaJdMxtTyGeVDzxpnT/rD2oY=;
        fh=d6t/NrOVBdy0tboO7M2p0bBbfhIo5Gw4kLOSqA/NYl8=;
        b=CFOX4xE+riZkNFsmMoVCc5tlI9FIAOUoWwfx2T2xsjTpMpFE2shnv22eCUQXJNnpYt
         NaBWLzR1hticpjWZf9W5Jeh+EIa5sLBFd+BlZl5TeYsjkQ8izJBgzCKSG5ydLGUhdr50
         ld/AKTZK/1hR04O8LnALlTBr24wyAYd04EzACyLD79Pj4qYEGgmcC5k+BJgV8BWWExkC
         YZtnQQUXlmabhm5oJ9Qr5DPtOiHFiCWqTLBGwdXff1ZJlqB5ostL8GtcekjWqSH3BILu
         E6fbWxLJLkkOjhoM7QD3LbTdTo5NMlN90yBPX/ItoPH21b00VuCc0lCPcS23GEhydUAU
         TzHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788217052; x=1788821852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S4h1Woe8qq1XwMb4pkCeaJdMxtTyGeVDzxpnT/rD2oY=;
        b=W67gzxZ3DNwjQW6VAAoaJjRADle3yEM1gyoxVq1QLotxiwQ/CGQCJ0L/EfeZTQusuo
         06dmHwhZs30ar3K6WGQms+xQd/8dcX7DVleLsW/7QeyThSJsInxEeRByEBLpxxJllBrS
         Mwg7uPJ/Bxrjw4ixwAU0YuLmxQbYdgH4Subvu8PlrNu31v1iE7qBY1mjRTwY5ghoRW9p
         oKlht6oESB1P9ZDuLTNs6JIgqli3S3L00eFHT7FR9bbtDyCr6qLOMA+fptDwkHXST86G
         Hre3jq2beWKPMgdAdMjvWClyAD8oQRcOMHWt9RkkZtSaati5DIfyHfPWQS+7VeJ8Xj13
         IGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788217052; x=1788821852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4h1Woe8qq1XwMb4pkCeaJdMxtTyGeVDzxpnT/rD2oY=;
        b=VsTJds/c5Gs4B1KI1T+FgsY7jOGZTkXzCFXi+854SMSlOt9CKlpV3dtpJA0FUWpSTV
         EgwZNAjcRRwrrdlR86j2ebTKlrDQcxR7sLnk3rUVPVBrNIIAUSAEUkSJKM+QvwvPJfja
         dFhlqRIh4IxBuwC+IXSMqd5qcNIEsAtzv3M1kgRW0qjrYHWb9v4LQF06btWbc8oB+ynR
         eMMRqnyjWjP1FeDI7WhhZNmJTFxBxtI3wqJp9b2CX9+sFlJs4zP2w3AVWwgrPgvHZlz1
         ayRtTfvXB/+TTvSwGBBFoEUDexYEVGwcVdXpWtGNPLDR7y1pNEuzUpVVsZ9mXjnjCj4r
         36cA==
X-Forwarded-Encrypted: i=1; AKwUvBwtklA3LD9dLyE7THOrFnlhl1HL8rlTqNeD/eiEfOp1X0xzq/hQxmCDfEQsI+AYX3R4p4k=@vger.kernel.org
X-Gm-Message-State: AFuF++kaK145V3wHeYM0pYCa7e8704w5DQcWG+dxmOEVa8Lhk+6UlGjj
	ZjN16bYZSmzGFywlu1U9AseK7lAbnUMUzwoHDOfRimZepMGfnmIMVzQKgjSXvaVFrBbCOcDjSAs
	pbOQFsG0Whaid6rSuiiJb7wVkOUGiL9A=
X-Gm-Gg: AYBFou1fU4m7tcdHEYVrWi0JmYpdnOtsXYToMSn6p4+uXtVWoSVd4V+KPkAnbI4y3jz
	Upvg8mnoZdCSMwhIGytu2c12HfjI6B0sKhCAjogW+/L3mAeqnz+8ANBsEPZDv3Ar4BAWbjtnC4o
	4Y4vIDeeCvMvDRe6ICC0rqcXnRwGYURcWkmEMkaBXEFLbYDNt46OkrR6ufddqAwRDIkVLX0PfhF
	9iiA/iiIiI/KwHCJXC6CP5P5EfixFghJ9hZBEqfonV7/gaUsD9CRJI82gXAK/WaLxuQ1N2JL+wM
	yAUg3KN9ShcHRTkuXE/aWN6jcMMnSb9DK5+XRBQDC3Fk8h4in6juoqXaKI9CGlejV9XU/Rsls3T
	+0TiqhcO5L8DzZePRExISZEsrIQYlIAEqvKJ/Epzt6dKSmewKxCgEtl/FCJv3kA/gJKNEb0CtSn
	6DvOsdJcFVlak=
X-Received: by 2002:a05:690c:c677:b0:80b:9114:3b7b with SMTP id
 00721157ae682-86874be42admr18262427b3.17.1788217052411; Mon, 31 Aug 2026
 15:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr> <DKYH3KM93BDY.1MR4WLZSWGEU8@gmail.com>
In-Reply-To: <DKYH3KM93BDY.1MR4WLZSWGEU8@gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 31 Aug 2026 15:57:20 -0700
X-Gm-Features: AcwNN1WFnLcmDvQvW4HotcJihJIRGqp5kPEzBTluFqMPQvhKqiOM-NnXr9wLqv8
Message-ID: <CAE5sdEiGA+chRkkNGOWL89AFDNXor1RKHMEmouCNoCXVd4fc-g@mail.gmail.com>
Subject: Re: [BUG] bpf: x86 timed may_goto corrupts private-stack JIT state
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org, rlmenge@gmail.com, 
	hargar@microsoft.com, apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 at 18:10, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Aug 24, 2026 at 2:31 PM PDT, J=C3=A9r=C3=A9my Jean wrote:
> > Hello,
> >
> > With the help of AI models, I found a bug in the x86 timed may_goto pat=
h that
> > leads to a verifier/JIT state mismatch on private-stack programs.
> >
> > The root cause is that timed may_goto fixups pass a stack offset in BPF=
_REG_AX
> > and the x86 trampoline reconstructs the counter pointer from native %rb=
p. That
> > is incorrect once private-stack JIT mode is enabled: ordinary BPF frame=
 pointer
> > accesses are remapped from %rbp to %r9, but arch_bpf_timed_may_goto() s=
till
> > uses %rbp and ends up reading and writing the native JIT frame instead =
of the
> > private BPF stack.
> >
> > The bug was introduced by 2fb761823ead ("bpf, x86: Add x86 JIT support =
for timed
> > may_goto"). I reproduced it on a KASAN-enabled x86_64 kernel based on v=
7.2,
> > however KASAN does not trigger because the bad write stays inside the n=
ative
> > JIT frame. Yet, the saved-register corruption is observable.
> >
> > I have not included a patch here because the fix seems subtle to me and=
 would
> > likely touch many files for different arch.
> >
> > I can share the minimal reproducer and other details privately with mai=
ntainers
> > if useful.
>
> Just send a fix and a selftest to the list.
>

Jeremy,

I just wanted to check whether you're working on a patch for this. if
not, I'd be happy to take a look.

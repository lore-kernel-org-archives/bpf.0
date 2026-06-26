Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547892E7384
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438296; cv=pass; b=lU0Cwj5yDNWX1ssIZ8gPtSoRjahNSQuL0C4z2kf7JJ6okjAUP7H6pPYspdPqQ6wk8cyd/msHi4KjWY+pYLbaZVemejk1sSxhb0iIr8kDqLf1c281+xZVPbYTfz2SHUejGUAgYALpW48MrUYA8rJXrdywjGwz7iS3wd31m/dMTew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438296; c=relaxed/simple;
	bh=KT/h4RvNkwV6td0Y1CASCpzX7ZKOJHSgx1w9JAbNaj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBo9c7NM9RgMJEL3tAzLKPCa5wiGJjZin/sV68xOhl8NXGjCPtfF8l9Kw7YLN/VnZ0F+qj3z1Tv8nyQaLwumutuK+OWh2nCm4l/NeimTneG9xgrItDLdb/DNhRK7A03gRSS/n4+yJBWYJuieCoi8rklXhM5dy4PhwVD4VJaiXFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdWLPp0V; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdWLPp0V"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c897468a244so113748a12.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 18:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782438294; cv=none;
        d=google.com; s=arc-20260327;
        b=R9SUi+UTH7InP+nppMU8FGv88972GmD84MUUAQbmwTBgjXPpcHjAE5An/zQyHftKX/
         s93MKtsRVkZrcknfCKZi3ZKdSsrjPW58qh5w6xCuAm+WWQj7YkJ/87m82On4aAviP+hy
         EycLWxDLM/DR92z9HzimljDjfU65tZvoeJFsnvOSonThdpExi/GA+i6AoiZ1GV+MSle1
         H95G2NwitNGxisX3eK8nawEMYysKqL5M8ZZVRfM+5DrGyeTscPFAaFS1/9EYLf9ibaAO
         d8dNkTdXc/qMA3cZsfhTl5m7luc+5EDKEpuu6Z1rrBj6h1bThMRxPdGcnnpo6+6ifUyq
         9GzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hk4S99SuHcZuOujtVnQ3HhN1Y/S42sKaVPyUJbXd+kk=;
        fh=eHlOu6DjRyBrps/+PXO+pc0eoONnwaBH7LEXvORAufQ=;
        b=JCqTvSrnivHR4m/q7RfLjCd+9z7SOAp8fdPV/LrgP7HkwVyyO1DFEUqjiVpXVkyVXA
         uK/7NHlazdEF8ZW9dCzD1EVruTJqHG9cNoTseibfSHckgi8gsVkeXQa/ItOeb0PUXo8r
         Yn+4jrc/E6kzXlVVkd7l2FjnknnEWjjKYwB0NvPaAUDlm9JRmuere+pnhA1Mzr2VB1me
         xRyExwE5Bo6NUMeus1dtltJrKHfvYRy1rXT2JQU1qpCO1UjEKLjW0jHguMzAYBo3APPN
         gTA24FaBzJ7KxTxvFtVlRfabXg21n9Gfgn21nOwh99TgAHLsPa6FjYu6UlC6xjuMLG/t
         iQRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782438294; x=1783043094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk4S99SuHcZuOujtVnQ3HhN1Y/S42sKaVPyUJbXd+kk=;
        b=OdWLPp0V8fubsDWOqDba1aKd2xqBkO3gqPUBD1gUqVFyMMPwq5qQETEZMVMzNUWM8J
         ka+Ofuv0kEEnzKh/ypgxywb+WrtVRL0t5h073/xk3IN45PUpDzgnYpLXtE38VZOBamY6
         S7vOFZOa6R9IkqFIkwrDlzlR18ladzFyknM1rBpXUG7jLJlsS872h7C1hQT2OwkyTijZ
         tJNI2gZLPBoWqzkiSMTH/6eR3k2ctX6d1B7n96jU5GIJrenLs1LJCJQLKj2xd+1mrP9i
         RQKINWBkdmb+/BwY/fe8BEqdKOqq5hZooz8W1KCJAVTnPmXVZNSK1r1abRLhHyMqFDiG
         JfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782438294; x=1783043094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hk4S99SuHcZuOujtVnQ3HhN1Y/S42sKaVPyUJbXd+kk=;
        b=F8O3oD88dx1EWIS9Cxus+FjovxRcgAEtyX1Agyc+gAjJjTuxKhpCu4GroZ3OLhSVVb
         szOf5rPkWizG26Qwe6CVJZtT5uAqegNR9yT64GqdUJNMuFGNx0vTO6p97lqG2TsjudMJ
         8Odg2SSPBkbXwEIVdhPbjYBUmQzzxYSjoFl0G0BVmlRrTZ4kPtQMz/ELL4fUhXuSeTTX
         YnijG5RHJphlQExiOBi/aS/y1G5MAVyMxzS1FwGuRy3/vrfqS8Wnc5y3NZ0BOagRzJ8/
         n9TbwQSfO0wC+7wbckXU7s4MkARL36o7Ng/WPmvNDLAR+glnWfkcLmCVCnsvcIkRRdPp
         7j2w==
X-Forwarded-Encrypted: i=1; AFNElJ+vbS1w1ryzBrRO3jttr9LgnlriIZVDhlO+b/V0/y2Sxv8mXqtJuT70iIsbRZurBbsbZaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvXGFd0yHNdf1nk+Z6DOXo0xvhfNuUq7RFK98AwDM70KRyCOT+
	reKH3lffWufmdhlLEsyw8W8qbJy0lklj/r5OgW+/Wf4AQoJDMTEIMC4iB7hgHT2u8OZvFYA4MH4
	omNNfZzXkQDpP7Ve9GygnqOCxbqYxs4yGlg==
X-Gm-Gg: AfdE7ckJ7DNuv87CCOo3m02cw3fZjYJftIudzuU72yARfwXodZT4dCPtJUPQLGTKbic
	1VMM+HAvd8pVwR4bw3N9Wmuwsx5GRn69wzq6Mr9Li9K6ZXk0tGLFGZGMBX2b5jyOoMvK+Xrp6Fc
	Q3U1DrLuwJL3PUrAee5h+w+MI4Vb7kzSaB7rkqizD/XlClEjucKQuqbFWefeTYv+o1ff3e8N1jo
	CpxCJ5NGgLGWeJLFpPbf32D0BdI05lltnsH4ypxIdrMlLh/j/YorD2+Yg8Pfx8PzJrnzVWRNE16
	zjt3zn1w9jbvmUlf1sttCE2ytRKKjlHFLT6s16Bx2F2pLdKVZBuL9HFzzhyv7qzv1JnOSjVS96w
	4zawC/GniM7t4
X-Received: by 2002:a05:6a20:43ac:b0:39c:4af6:4309 with SMTP id
 adf61e73a8af0-3bd4ac6181fmr6501194637.12.1782438294463; Thu, 25 Jun 2026
 18:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net> <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com> <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
In-Reply-To: <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 18:44:42 -0700
X-Gm-Features: AVVi8CePO7sLLsN4XpGKZsba-S-SCeCow-rJOQ2O5WodW2mERu7mursGgyYu-lk
Message-ID: <CAADnVQLdDZR+q66XgCgprPnikhE_Zf_LH3XTFh43u_ks62cWRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 6:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 25, 2026 at 9:16=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> > >
> > > For all the reasons I gave previously, I can't support moving the
> > > existing security_bpf_prog_load() hook at this point in time.
> >
> > Paul,
> > it's not up to you to approve or deny where security_bpf_prog_load()
> > is called within bpf subsystem as long as it doesn't affect behavior.
> > Daniel's patch doesn't change observable state from LSMs pov.
> > It merely moves the call from syscall.c to verifier.c.
>
> Alexei,
> It is my responsibility to speak up and voice my opinion about LSM
> hook placement; arguably that is one of the LSM maintainer's larger
> responsibilities.  Non-trivial work, including several allocations
> (which can be quite large in some cases), occurs between the current
> placement of security_bpf_prog_load() and Daniel's proposed location.
> We must preserve the existing security_bpf_prog_load() call site.

I don't think you read the patch because you're saying nonsense.

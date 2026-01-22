Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497437106B
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102846; cv=pass; b=Vbt5xKCdmv12uvk18NC+ppQMtHopfNGI3S9r64UGN7clX0WxXo3qYlLQpCmDXSzdbpsUoXLLTKMVak40NKQu0QbhuUMOB8AkWE+LFw4VbxYwI3OziapMAJijrBmljCFi77dC9I7c1ZpTNINPOF01XFmk8XGACozAfzaqN6/U+tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102846; c=relaxed/simple;
	bh=i8wRRwgcRBRX/QtBIFh7w+tGkhK9mt5SnMal1LQmNU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brCOJbtwEEWFxcT/4Angd3OV5034yDCc7tvnqOH5aoGK3S9eGW1MBNzCgwoHiRLm1Vj1WiGE5OccrLL5bHAWEpX//+PbDH+LTIVs9Uw+mUPfdV3c5BmSMAA6T5ccsgQJM/EvSpo72RXugpXJSz93j8j58qjGvruOJaKBe54Qlio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TIpC9eCY; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TIpC9eCY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a79ded11a2so7976935ad.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 09:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769102832; cv=none;
        d=google.com; s=arc-20240605;
        b=gZzx+SchRDrFueKHxtyIKEscVIJIKZXlA8I6BGD7p5YF7G3VhQa4EFwrrLwohOYaAg
         gmhO1QO+0niXx8QRuJCFRLafSQnpg5Ye/YRLadiZ+oZ+NxaIFP6fOHVqcn6LCWnwASdq
         UvVXghHyGXUyqM1RCXnlpuzBD07Bw7uAtifDowcBq/WRAIUyBk1htQZczVnKLG+u35lh
         5j24honmszp1MgB2YdCw3zHAfO+vojo/IIVgl0k8GOaRvBQaFZdBRjIdqiqYTfwYGy/8
         47ybfb2EmViodX8TRlGGUU60NlBVrnpwYB1/MvN+yDwsmCyQ1U9tIqjk4+3utsHZf0vM
         TgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        fh=sWGVTpHPFXbGErV7ZfNAtvFh1dXpQsoSImcPyhBgjC0=;
        b=ka8ysKVJAHORHi7F/jQTDG13c+eoXKNxCqlzY5ExVgMwhCgi7Kj/uTN3ct5aOz8nsC
         N9a3scC6l3ImAEAaqVR9uMvIF9sshCeKnoWcDPMC6383f9bW5qSOMYDdC5O6+rg1pw2x
         6D6sJ3J88NcxNU614cAtT6kPvgly2YAFyl7qN9y4DuFrWcOcCFamy19fmwlZUlXZjgp1
         6doLeCkBilOBIcebUmkCcwcS059bW4N5n9qf+FC55zEczErGZn5gzYTEYCXDwTNRdR+b
         +Dff5D5fx3MSR4ydX/KyWVlP4itp+w6uTucaeNgc5aYSz+sTnqV7XQxBbA75/GbL6iYY
         ssWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769102832; x=1769707632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        b=TIpC9eCYYmP/8eAsufXnWfk19A6gwFSMJhwsyZO6KpJQLjosuWfxLdcSL4wS1GlXcw
         Ug7TJlzwAai2JjaVu9fkv048nDt7ajKnPypGlD20dtrv2G02hzpL78SewscmE9TcAmlC
         4fWeubFHYy2ub1amXcLOFPoywOWGlp4BVA2a6KX/FnV/6l2IxuBNFp8i/WIdaKFbx95y
         De0TK8thxowJW+DfGSF1QtBadyzK6CAfXiOqu+ENMGrK8VMZMgsBJFqsqi6jCoQw9CXJ
         /jArDod06bGKlyOC2nA7YxZfVFStgPbp0RfcizS2BE5l3vEchsykK3zzHEDXevErnCQU
         UO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102832; x=1769707632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        b=T4dx1hBbOb7hRDwG/Ptw3oaelRvMIlqWjiGlc8lRnJ/tIpsG8t6mm85TbhdGWf/Cxe
         aRHrOQMBDGSVYdM2eVM7oPdxnO2BOOq3UyoN136V0waaOalIrvBGA930jm3mxS768hpD
         MgInNUvKuJxvPRYUO3XMex5NIlXZbP6nebSP9MJzYBvj5Q5jpWjZYbKkXX7fjSuHyl0r
         cagQWD5oCL5J0YrRoYhcxEp/ize16OBafpukscBTXIpx6YlfcurZKQtYvdktm90dELfQ
         k4sJYMk9W6nyjGALZEbCN4Wtilm3OdKNtVBtWAxZnKRSESrbuD6JSvh89ce/GdymhXUc
         wjmQ==
X-Gm-Message-State: AOJu0Ywnkj6t09VtG7IoDWrliWvBPzdUI17FoJ0QJhpLbb/zEC9uNze9
	lCY1LNIaf8OEotRXVAnTLUlj4RuML4O7nHBv/A7KmcP4Yj8B9stpZRmPvhC03qosTAoinfnEzrv
	njiigMOxRgkXTq/hvlJ19GlMaj1Wzotnwuq5qdkY1
X-Gm-Gg: AZuq6aJ6xOuT23tefMbSR1UCeLW9gxjRN2EmXaOubX+VJ8jPsnUAS2oXZbLACz4U5cJ
	OgLoNLve53S3eo75qAQ7XQ/dV+t41kmi4Jyu95Z1OlbSScc36OXoBESV3ZvtWPrEGulPYaUw880
	9QICDrWZm6aXu+tzqLe73HOl++u0wyyDFy5H3KVd2TOCe/CxmM0whnbU3fH6LcpYnufMCkXPpge
	maTYORcTy4ckM2SeMo/7260hEKHspV9pNqru5NwMTDD9iNn6likLuGfMN/rvGSjtbq5WEU=
X-Received: by 2002:a17:902:d4c8:b0:2a2:dc3f:be4c with SMTP id
 d9443c01a7336-2a7fe442a86mr1368065ad.10.1769102831964; Thu, 22 Jan 2026
 09:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com> <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
In-Reply-To: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 12:27:00 -0500
X-Gm-Features: AZwV_QibKES0kD4tscaEcwePngrOSwTB4wIlklspWkjv8E3aPoOucAI-iTyzcnk
Message-ID: <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Current LSM hooks do not have good coverage for VFS mount operations.
> > > Specifically, there are the following issues (and maybe more..):
> >
> > I don't recall LSM folks normally being invited to LSFMMBPF so it
> > seems like this would be a poor forum to discuss LSM hooks.
>
> Agreed this might not be the best forum to discuss LSM hooks.
> However, I am not aware of a better forum for in person discussions.

The Linux Security Summit (LSS), held both in North America and Europe
each year, typically has a large number of LSM developers and
maintainers in attendance.  The CfP for LSS North America just
recently opened (link below), and it closes on March 15th with LSS-NA
taking place May 21st and 22nd; reworking the LSM mount APIs would
definitely be on-topic for LSS.  While there is a modest conference
fee to cover recordings (waived for presenters), anyone may attend LSS
as no invitation is required.

https://sessionize.com/linux-security-summit-north-america-2026

The CfP for Linux Security Summit Europe will open later this year,
you can expect a similar CfP as LSS North America.

https://events.linuxfoundation.org/linux-security-summit-europe

> AFAICT, in-tree LSMs have straightforward logics around mount
> monitoring. As long as we get these logic translated properly, I
> don't expect much controversy with in-tree LSMs.

It seems very odd, and potentially a waste of time/energy, to discuss
a redesign of an API without the people needed to sign-off on and
maintain the design, but what do I know ...

--=20
paul-moore.com

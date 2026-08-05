Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C746F4BE
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943891; cv=pass; b=e4czCyZbBMDyVCyK7FY6tOIGS135n7mQScQpXildtmO/eCvSbPo8VX5yTcYImcmSiNgO2UEXO8JnIwRz/Jwk2J3lNk9B6a1xVfokp5jvS/yU8RzClnQzKlDH7dsrbpNu6/YDP8w51yVoFHOM47fSCRJTGIYM4tDXgnmN5NK0VuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943891; c=relaxed/simple;
	bh=dJPCdypeOQacbOHsNXmqZAmTMKMgt8YOMGaXHcDNHkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rlw7eI3bol7lv7r4NIWgIxS10rIyOdrdCsvGbK77lTUmsnMLd1BBg7Fd1pSIYP3CYouZdYdBOquNqEeXO+uVtg6T0xSCmUz7wCgcNCmVDudoK11l+cwFU/wBNDLxK+3f3tnem28jNoYXnlfdW/HK6n2vyGba4zEkSDiz3RupSeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDHleAUJ; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDHleAUJ"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6acb63301acso841126eaf.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 08:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785943887; cv=none;
        d=google.com; s=arc-20260327;
        b=OclQ5pe2MBJth7ByEuA/7MVy4dvkDn98OlDjyJurM5RJmzXNykBhKzyUjVXw7wBgOM
         qANPshk8OpmXfKkX11Qlu7XOKgVlRLfeYXBRECteHdvAst4VQC8sfZU9hEBWZ4K2UwW2
         bxc99U5rifnCvYOFx4yy4OjBpeJF4Dx02cBnqBQdQUzhOSssGKB8Xe3jaKSQHcSQ3qM7
         sK2O4Q/FqzrfWvVf+qQX5blvfqwBYVpyfmfWJCACCIUHUcCrz1sZ4l/2AfIsB+m+niQJ
         agRGqRnDruSGYsuJY8miOuRs3Z3pmZ7Et+U7TsZ+on1GVVYH/yT0j2BPxAfu8H+UvmrO
         kyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WopFs36fjBNe4p827wx+9JX7Lwtk8JPVIwqGHdzA5zc=;
        fh=jPSDVx6kqAg6fAN48bxjffn4xh/Ko33mHoa/lyQo/F0=;
        b=UDZRKvATBWFdyZi02izHoKKQktkCZT16NFXdGfKGCMWYkTniRlToF1Xyri4A5YQ6fF
         +j2p6e5Ez2Kr4/mLd3uJ7D9gxiwAy1kQdghxl58K8m92hQu7GoQR1biCVDuLmySvm17g
         0N85mm+jUVZs+t3RgHF4Lx8z1NkBMFD7L8gqjVQI8exa+x/kqb4RKiuTDyIBm6qS2kz5
         wZtdLpDcQ71PaCNW6xUrEx3bW3Mbt08uHDwfrtFzx3uJAxsrYH8nJS8l12M4bghgssnc
         R+YTrmNwSIRm97HJp8uEx3RLUSCxnaXuH2Yf+NQrdLI5zGF4zeO3hvVB2dF6Yy0Y+O9i
         WOAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785943887; x=1786548687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WopFs36fjBNe4p827wx+9JX7Lwtk8JPVIwqGHdzA5zc=;
        b=qDHleAUJxgsCUfR4HPO0zhUwzygyenvCoRBqDd+OmmfbyVu5gxD8Op/C7KblzFHtFA
         K9YMj0V5RfemHBeGZLLV7U2pNIs2r9WNsWoCLzjXxI5dxgJxEDvY7YLdDBouEpJSP9xx
         4v5OSNazeMQn5tX94yQareFcugZ7TsnIHNfvFtwuKMScCdtaJD6vP4deuDJVKfxbfoun
         l3OYOSdWbgMASS2e53DO38uim+uz0m8/wrYDExO+dmCIEIRkwNjyF/H99L/5qpV1HeCk
         4nJPcy5x/FvFxrjowSQAbmdj/DWIYwkBif9y+ZI1omcjaU2XPPox/wpu3TIHAXmtMrKq
         0Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943887; x=1786548687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WopFs36fjBNe4p827wx+9JX7Lwtk8JPVIwqGHdzA5zc=;
        b=Sc71S9gQQWVGs1EfQB9I4gGK+FQZzgp0LGh0lSAWRVqW3uNddth4fda8yW37PQvnb/
         dqrLM2jDud5OgFMI7z/LYbcIsw/lOf98ytJt7yilrZcWWJYSIcG3gWWnJ4YWA5lijP59
         cbCtcV5+CWD3YbADmZAYVZFOvCRqcot/Jt27biqortgiqQ+DEDgVKpNgqrcdJsNeoazq
         C5j4lxkdtReQaPnWEY9nL9/ODc+GDOk/I5VVF7lsvTa1zrrGzVZEiiRsfHZqqwXUkgpw
         faZj6BWhZ/uNbsl4HYbSa05l8PLbB+Qm9TF2odg3FwBgYFPBo/MJhVjgRiYOzoRAZ8Vt
         eSoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHvPMCueiUYVNvnyB9tF8wCO1/fEmHOnJH2Aq1rbO2qnHfmxGPZtdLKImbCMgm+VDnhLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoffLk4qEtQX8Gz4/xq4ppn4xNKmZh0Q9jUHJz6y/R31HhveM2
	Ysvma35afuDiZCq/rxSt5hy+l/v8se5jN3NEQfWTTiD9ShR9ntpevnxudPI9NvDov84qHFUz3L2
	3fS33MBwfmtbkUEzelQ4I46xx1iASRFw=
X-Gm-Gg: AR+sD13g0jYzpPdK1F9o3r4BducJ0HBZTr0M5s2cES2iN0vwDULwKBYUoQs/UJEuIOy
	Ppkbo72+IRS6bduIqdYpWgcMwfTzXXWXn01IppgZCH2Vba1766cZkGAvq5qiXaNIJhSuB9qBbqR
	cGh3DS3OkCCyklCuIdRBCx0c/3wPwDQpE0vRnUcErK7iMYANL6+FWcCWxtXJxfV1OR2AxRki9g6
	nvjtzb72k1pNOglI9JSXvnU3HDJC0MUIkVmhWsGQ0OXky1XDF4bvZ9uTSXfox9t4+eIrQZEKMQz
	ru/TohivXXc5KZMyT+G9emvHbCgu9vQehTLET8WkZOY=
X-Received: by 2002:a05:6820:4b04:b0:6ab:19c3:370e with SMTP id
 006d021491bc7-6aeaba25ae8mr23166eaf.1.1785943886510; Wed, 05 Aug 2026
 08:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
 <178571387898.1880415.17662890925792360904.b4-review@b4> <20260803-notunterkunft-wildtier-restaurant-1733e9660017@brauner>
In-Reply-To: <20260803-notunterkunft-wildtier-restaurant-1733e9660017@brauner>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 5 Aug 2026 08:31:15 -0700
X-Gm-Features: AUfX_mzXyERgbDVMxdqUz6VFtphDyebsN972OxffP9NIbYDefxKewbjkZdrOpws
Message-ID: <CACCo2jnjvYVG82cgwq-UcEU7ZLRaMp12xG4wBLM=zNHUqqVg7g@mail.gmail.com>
Subject: Re: [PATCH 1/9] binfmt_misc: let a register string create an entry disabled
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, jannh@google.com, mail@johnericson.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:18=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Aug 02, 2026 at 04:37:58PM -0700, Farid Zakaria wrote:
> > On Thu, 30 Jul 2026 15:34:03 +0200, Christian Brauner <brauner@kernel.o=
rg> wrote:
> > > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > > index 707f8a14f8a6..ca7840b01a2b 100644
> > > --- a/fs/binfmt_misc.c
> > > +++ b/fs/binfmt_misc.c
> > > @@ -75,6 +86,7 @@ static const struct binfmt_misc_flag misc_flags[] =
=3D {
> > >     { 'F', MISC_FMT_OPEN_FILE,      0,                      "open int=
erpreter file now"     },
> > >     { 'T', MISC_FMT_TRANSPARENT,    MISC_FMT_OPEN_BINARY,   "transpar=
ent"                   },
> > >     { 'L', MISC_FMT_LOADER,         0,                      "loader s=
ubstitution"           },
> > > +   { 'D', MISC_FMT_DISABLED,       0,                      "register=
 disabled"             },
> >
> > AI brought up an interesting point that this now changes the set of
> > valid delimiters which you might want to call out in the commit message=
.
> >
> > For instance 'DnameDMD0DmagicDDinterpD' was allowed before.
> > It might be a very obscure feature to pick a delimiter because
> > https://docs.kernel.org/admin-guide/binfmt-misc.html does not even
> > mention it beyond 'where you can choose the : upon your needs'.
>
> Yeah, I can send a separate doc addition for that. But that's kinda true
> for any new thing we give meaning. So _shrug_.

I figured but thought it was worth calling out.
Maybe you will want to reserve A-Z for non-delimiters; the
documentation seems to point readers
to #:;- all sensible options. I don't have the history about this.

Having a growing flag set and arbitrary delimiters seems odd.

I am headed to DEFCON tomorrow but I saw a few more patch series will
go through.
They are getting a little more esoteric for me though :)

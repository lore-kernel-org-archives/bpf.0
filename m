Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B99304BDF
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517891; cv=pass; b=ZA3bpnnBvQSPbGRKfsrN8um6nMEDLYRBcf/ne2ipSPWKQRtjUvA34zGBOFT5guCXkYM19PQtLyIE+QLJyR3FaA7Dc4R7e+UVvbBxlDmwrle0w0g9fcGvpPNNniMV3J8iU+77pd4O2Dgu2BbGVaBPe0ZHIElntcCzfshDORCqgHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517891; c=relaxed/simple;
	bh=gCJIqEfBHdWZLIfLLkUByoZiap4h9NMvkXjnioy5hKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKD2OOqatSoTwVHjyX3w6ufJj2hJWGF0pkniv+8aiV19fvvigal+Nv5KwTsoVS8maifFwcvfmUXCJmcEUgiN+cPlHG0Zlys4vQwbuxH7qdRWx19M+/p9dGhYwpo2vnGUezuaAvhCwi3auFpqIJk05cJ3aqGxraCrCpPZ2/SsC28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3cnK4yU; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3cnK4yU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso20441005e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 16:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775517888; cv=none;
        d=google.com; s=arc-20240605;
        b=Oa0wNA3DN0m26fC2b0/gcc0Ac+ZWI4DSWBA9O9nzKxmm5O7bR9p4oyBMtMpSUtwqMF
         omhCR5wcgDWCjFwR5U8CbZL5AjlKIZnMPCfPT8LNLoyxyQ0+57A+OFQTf6kZFZYnpNRA
         FgY3IhGN/3aTqKR2onn2woko8R9cCaV6EgBxfdM8bYKCjg/kde1o7NqD3fJgXRMkkboq
         XArOjJEHZTHmYfFCp7ScZEDXdn3BfWAVbu0dYSm6pBgKx5KwGMHsLo9l0pndibr9YzuD
         Vha6gvGbxiKGZ072Jb9e/miWNKQ0LZwUhwZzvni2K/Tjai40VOurKeZNRreCnku82OS0
         Z/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=giiyAPaGWC/+H4R0yj89JGnzz5C2kC6xrCa4cJrqs9k=;
        fh=IxUhG6HhZRYhSJiA37EE7A7DT/KB7ltnaHKzr+c+Eyk=;
        b=XOEFqv4YsaIeyrHuDgd037S/Na+8xgw8FL7j4iE3N9fx3ZttAzmhLs6aYN6h+XP1Pe
         cdFRVKK1xIkCZPLTfVxr5WITqlK571B3CYcHlIsDmdF/TbMy+FDKmyv9Pdxx74Zjcd0M
         1NJls2O/LDxpUPy0KQl8tYqdkDbijBmvhQeKs0rx2W4kAOfbIB3jU1R2iqLZFri1CbXq
         kSVcvE0d4U+ASUUVHIDiqcgKfrI5aW21Re8bm+9sqUILKLUGI1EGWy2DWgLmuCNthAm3
         S9FlVfXrzOAXGg5qU+HjSTdPvJ7BC1J59moiJd5T57lJyF5OreLKuuHmMDmfEAHF2Nrn
         dYww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775517888; x=1776122688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giiyAPaGWC/+H4R0yj89JGnzz5C2kC6xrCa4cJrqs9k=;
        b=J3cnK4yUKb8M9LewhSmna0CD1zNwgZebvdnxVmzN9Rq7KuZHSrho7PwcBafPWH1dir
         Z8k4EeDfzhLucdY3lQtcMV9kREh7saN4p5eUOX/nSmnIA0Rq9Yz5PWjXJUX2JdLMhdOs
         /x/sWRzIbE7EAEN7OoBEyJ9JBvjC8bKUzWjlSGuY4fA4cBV6Pm5yrcby3UFKIWmRZBlo
         rkJtDBhwkd3s6yGl++5RxfGUKxl/aq0/AJ3wPboMKA8qrj6HSyJFxAaU1HcHVQdNFPIr
         0rYiHa+CMH6tjO2CDh3Fnirue34uqR1XQMAqjRgaBnH9h0ew0IEQMiAGkOf6l+NzPfVA
         qVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517888; x=1776122688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giiyAPaGWC/+H4R0yj89JGnzz5C2kC6xrCa4cJrqs9k=;
        b=of0HfNVag50LDNk/8JS4xqcxuqkdjI57vT7vEf9f/o9DvdE6hajYj+56ZfXcthfY8X
         J5DOq2/oc6uGWY8Xuca3TIIWgDxXyYQ3Bd6W3hTr3kJ0UcgvroN7UpmsZWEx7MPS4SRx
         vYg6pNRrfTmd+9+nIsp0X5R1NYtb3iZAAdn/cwEU1ogmVbt53DPAj26U/hgpWpQDYJbe
         BV9XnSbNGwZS50vBaj3oRjFViji2EEUR9/TwuAPfRCegXNhpgMz4Ql12VBt5cKiuUf6p
         QoF36TNn9cXiP3ZxthhXVjlLT1uBD83CCZVqeJS9tYyZhLjN0Z+AzgCyjsshVC1Q+jSg
         fMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfae7zznpWLRIhakscaywYOgWnd42h9JybP5BW2UOXLxbnV3EMrl7/LY+7caJkQV2Ua68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4OM7BKEjUbqtWGRQlHP0R31SkzHuJGdDY65VGCn8vCGiT5/t
	xN9V1emfuaxWLBJ+ELL77xh4HvirpKZlyWnbOMGw705u3XiUrmdi8uRpasLbaRejdPH7ON9PwpC
	hi+ye/YDJ5DC6V4ftNlXPJ+LKiWzCdcE=
X-Gm-Gg: AeBDieuSCGPvxU0LH7Ybto3fPGZ6TuORMmPYr9Fs4uMk7xAG+29wS1sbytZQNutb9TY
	b7PStdmBWOYf6Et2T8+TXqSwW+XTufs4Fyk5wU0McsZTB6B5XVtsOu4HtquQms3hS4wz8PS1/Na
	KCuCQG4W7EPGglMh7ck87aQXNFNCc+lzz15dQ2IofzBtr3cCPQdCuwT4nOdrfhdOLnSRRUpCA1j
	4YCCMiGVdJxfhFjyVWmNAyOGyaF2ey6bJHIYK/rmHLmj5eNoEJ/SINtGxHUK6PBY9IHe+/Kg2VH
	eDMwJwAAZ3mv91RoSVX46wxYgmlTZ8RwQpM+dUrt2rLi0rS9THjpd1pBIp1czLZ9OIQSOa5ravA
	sbDQeUZISoCsChElJ9JkIqP+n6A==
X-Received: by 2002:a05:600c:a47:b0:487:1108:48bc with SMTP id
 5b1f17b1804b1-48899775d9amr222192405e9.17.1775517888153; Mon, 06 Apr 2026
 16:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acr7Whmn0br3xeBP@kspp> <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>
 <202604052007.4EF0560F@keescook>
In-Reply-To: <202604052007.4EF0560F@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 16:24:35 -0700
X-Gm-Features: AQROBzDda2R46zaFR44hh-lUnrF-5MQQDqCYqqirlLv6uqn548J31w5zS_2FGPQ
Message-ID: <CAADnVQ+NMQMpkG8gZPnwBD1MMPsH+uJ65C9bMeGf_YH5Cchxpg@mail.gmail.com>
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of -Wflex-array-members-not-at-end
 warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 8:27=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Apr 05, 2026 at 07:44:51PM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > Apparently, struct bpf_empty_prog_array exists entirely to populate a
> > > single element of "items" in a global variable. "null_prog" is only
> > > used during the initializer.
> > >
> > > None of this is needed; globals will be correctly sized with an array
> > > initializer of a flexible-array member.
> > >
> > > So, remove struct bpf_empty_prog_array and adjust the rest of the cod=
e,
> > > accordingly.
> > >
> > > With these changes, fix the following warnings:
> > >
> > > 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a f=
lexible array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > >
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > Changes in v2:
> > >  - Remove struct bpf_empty_prog_array. (Kees)
> >
> > Kees,
> >
> > It really bothers me that you ask people to clean up
> > warnings for the sake of removing warnings.
>
> It's not for the sake of warnings; this is to remove the ambiguously
> sized objects (i.e. structs that the compiler cannot reason about the
> size of).

I read through the AI debug logs. What steps it took to reason that
the fix is correct, and it convinced me that I'm wrong.
Applied.

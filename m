Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F62DC78C
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566049; cv=pass; b=agV6JmRCxgbjKe4N7sm5UsxZGM+96OyzyOeeQ2QpIAFSdduvl3JTu/Bit0+EHuDbSoDo2Eiw6eNHrkBoxGq0Fqxg7g7c7OK+s29wkSmVUW+e7HK3kwk6DBZUPRUjJ9dcUn3jhZGH5olGV2pDaEcMjsVH9OIEJMIXPGPhfx+s32I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566049; c=relaxed/simple;
	bh=noM8Pndrxxbhseocx5Q+6xiGyCG3GeD3xMiC0eHOmkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtB9BarJPZFCTItCh66EDRQIvB99CVHiE9bTUZvCCV7CGoaBPEPvh6l5TbIGhv/bDghEKSlkRLDkA8mV990m4J8m66xItaVTkb1JGvyzbpz7LSc3e2kpVn+HJNZaojpBo9Dk3Hs131BRhKuJjil2bnt4rvxugmkSyHJiMyxXq2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXKnoOYD; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXKnoOYD"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so628279a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774566047; cv=none;
        d=google.com; s=arc-20240605;
        b=J+nT1+0ZoXg03ERu7271xCB2iUsj0xA3Q5+lMFzBeggWPWkJOb7Y+z8YLOisu9OPKC
         MB9NMg337UHxIGwzL2Uc7TUqpuOvaKcbByZ5sQtTj3yKzRsKP1GscFlDCaChqm8Gv/AE
         RZRDSw8Cv/hXnnmkrjVOOLEskyzJVTmjPRmQOA4UeyNHib4TFOyy+NLKX88DTvGZN45U
         NEfKIpi8C3ZOSuzCPBbNiyQL2XhMI6oQ9+pJTMB6eQjRwrAhnctEkYQvOiRWRqnwkdHM
         Wmwkan9sDt7uqnHVxvbeFobUl8UKtXctCfhSVNS1FUYsq1h3olcJNmnyY4AGDHqzat5d
         zZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01cNlTLSix2rETXJQRSWUJG55TfE2TSxosVCrsn8W3Y=;
        fh=CMKt418lNpu1zNx/8+qMH3mvDCmfIjFGi++/7hpTCJU=;
        b=RUztL5LFbYfKvUQc7DpR+4wzFRM4UMBgWh+mQfnddAQFxkze3gOiJiEuPmbneivG4g
         os890++MdBpa4tOhzEhxAIN4ihAHAkhtQ4QEZek96EVmWNlFFe5N+WsBRsKiiztRACBS
         VNfBwL5UYhIOFFVw5AmQGrvda0kJY9+O/6rINd+JJb2PMMK5gGFh8FQKwifNumUcDHAo
         iI8+/gLx3fxZuMV3HJ7MEpRCbWI6wxb1rlXOV76pMR42jtuBdtsn0C+ZSPQM6qrbxw91
         IjdHnh2Y6y0bbjzNbrHNHTbmvUaVs5c3dvTY+xqnGqmF+y8WdiC7I1o1PF6GZ4EQTIPv
         3aEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774566047; x=1775170847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01cNlTLSix2rETXJQRSWUJG55TfE2TSxosVCrsn8W3Y=;
        b=RXKnoOYDcbSyREcJjXoNIExqPsHhaFX9Mmyptjxf2FHr8JK7i+gUiwwTz1J8K6tNWN
         lYbZ1jfhmWYKA9puvuEtcAi18pKvCptZnslA4ijz0TuUSd/T1jZlQLFAizPq3Vl/xb8c
         yFhGa641cNcNP273y0AR8TNGy51n6JrRaWqTxtItGzAV8dTKYRWDx9WqTBAcdctFi7AZ
         b4KTxzLRfUcALHJNhpOFA8wzwKyCTGnmfDTKVSWbXuJw9AzEptqfUQq28TE/V/8cBuTm
         /X6YA6bdvCFaS1df81wCKO/eWVHP+nsA8tCgRZQOQFZHULvSQCqyYwOVpMub7CVKvuhi
         cNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774566047; x=1775170847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01cNlTLSix2rETXJQRSWUJG55TfE2TSxosVCrsn8W3Y=;
        b=RofiJEdatugtPJxwT5byH4S1n7rEoOiiDd/q0vivXnTGNEjyC7uqYbRvXPc5/2cbbq
         5xtK3tu1ulxkwbLNFiniLaY1LN9Q8zhdg4ebhOHnHceHcfOyxAltEL5+LE/jYjrh2jxJ
         5SajezGWZ3ItoVw3uZPaJriLFqF42xFR/SgtbN8XLEq540tyW7VlCYRQ4nLLu+NxFMLM
         VC4XHciYlnG047lu9ow4NwDUtJDfkgSqr3cM5/3HiYcHeNdbmXZpsls3yifuHnF8vGA9
         4mltBN7KSsb17IcASwCagimzvl/1SBX1R3Yf54CKuO3mdoLGEZvfZ7oQpUT3/eQqgpyh
         P5GQ==
X-Gm-Message-State: AOJu0Yw4rpu6UnO3lNRbxCeauHO6zS0lSREsmqgGMgnLOaGUhqV6N4iJ
	VBfhsAMxNvQqcb45Lz1cV8uGfPD99C2tBQCeLgzP8PGDOBMWAOnXPl4xopkE/lM12UvmMeUi+P9
	xI5ztwkZARy+kMFuMbJxaqkOh5gXBSho=
X-Gm-Gg: ATEYQzy4lap1aett7PTvAbySX8yit/8vJRYGZ6zDgo6zsGzXDBZIBTlGbyx93/6GTSk
	dXzU5m0dOqf6pjpbKgsJ8UQ6wBSsEpSa9C+GblnBd5CpjtbR6SP6wUlq2rNSzC+XEtzCDULkM7+
	5J/cVRpVlfbLtDX6iMG5QhOP6PIWU8zVlVojPGl4ldXh62rWnDN/AJ+vaFzu2ydj/+ZDUKujap9
	eKRTbfZEC3sB7LyamPnn4+SD3TGrIbw/jJr56KIluhGuwT076UBBmLj9xB+hx+1YbANb0G/Rk3k
	Ag3V/54bnxHmJPe6t5A1KNU=
X-Received: by 2002:a05:6a21:32a5:b0:39c:235:c5ec with SMTP id
 adf61e73a8af0-39c87af0699mr433453637.34.1774566047310; Thu, 26 Mar 2026
 16:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
 <CAEf4BzaQqWprVN8RcvGvAEML7rGsGE+x37+RYRHADsGRNd4JXg@mail.gmail.com> <46b5a0cdcb00899de5580896596ee5d3c693f3ac.camel@gmail.com>
In-Reply-To: <46b5a0cdcb00899de5580896596ee5d3c693f3ac.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Mar 2026 16:00:34 -0700
X-Gm-Features: AQROBzBGPat9XyImaz_A7XgbZtIFTM07s276cLXcSlufrXGZ_xCHSopKBMsWfKw
Message-ID: <CAEf4BzaETjC-_mZ_rpDkbxnXXBZLvh74mzNE3oW_Ra-VgGMRyQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test decl_tags
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-03-26 at 15:47 -0700, Andrii Nakryiko wrote:
> > On Thu, Mar 26, 2026 at 10:39=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > Impose global ordering for all decl tags used by test_loader.c based
> > > tests (__success, __failure, __msg, etc):
> > > - change every tag to expand as
> > >   __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> > > - change parse_test_spec() to collect all decl tags before
> > >   processing and sort them using strverscmp().
> > >
> > > The ordering is necessary for gcc-bpf.
> > > Neither GCC nor the C standard defines the order in which function
> > > attributes are consumed. While Clang tends to preserve definition ord=
er,
> > > GCC may process them out of sequence. This inconsistency causes BPF
> > > tests with multiple __msg entries to fail when compiled with GCC.
> > >
> > > Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++-----
> > >  tools/testing/selftests/bpf/test_loader.c    | 174 +++++++++++++++--=
----------
> > >  2 files changed, 130 insertions(+), 104 deletions(-)
> >
> > [...]
> >
> > > -/* Matches a string of form '<pfx>[^=3D]=3D.*' and returns it's suff=
ix.
> > > - * Used to parse btf_decl_tag values.
> > > - * Such values require unique prefix because compiler does not add
> > > - * same __attribute__((btf_decl_tag(...))) twice.
> > > - * Test suite uses two-component tags for such cases:
> > > - *
> > > - *   <pfx> __COUNTER__ '=3D'
> > > - *
> > > - * For example, two consecutive __msg tags '__msg("foo") __msg("foo"=
)'
> > > - * would be encoded as:
> > > - *
> > > - *   [18] DECL_TAG 'comment:test_expect_msg=3D0=3Dfoo' type_id=3D15 =
component_idx=3D-1
> > > - *   [19] DECL_TAG 'comment:test_expect_msg=3D1=3Dfoo' type_id=3D15 =
component_idx=3D-1
> > > - *
> > > - * And the purpose of this function is to extract 'foo' from the abo=
ve.
> > > +static const char *skip_decl_tag_pfx(const char *s)
> > > +{
> > > +       int n =3D 0;
> > > +
> > > +       if (sscanf(s, "comment:%*d:%n", &n) < 0 || !n)
> > > +               return s;
> > > +       return s + n;
> > > +}
> > > +
> > > +static void *realloc_or_free(void *ptr, size_t size)
> >
> > but why?... why invent a new realloc usage pattern just to save two
> > lines of error handling code?
>
> Yes. We have this in verifier.c:realloc_array() and I like it.
> Can through this one away if you don't like it.

it just that you still have explicit free()s in that function for
clean up, so this realloc_or_free stands out as a deviation for no
good reason. So yeah, I don't think it's worth doing... but I'm also
not going to fight it, it just caught my "traditionalist"'s eye ;)

>
> >
> > > +{
> > > +       void *new =3D realloc(ptr, size);
> > > +
> > > +       if (!new)
> > > +               free(ptr);
> > > +       return new;
> > > +}
> > > +
> > > +static int compare_decl_tags(const void *a, const void *b)
> > > +{
> > > +       return strverscmp(*(const char **)a, *(const char **)b);
> > > +}
> > > +
> >
> > [...]

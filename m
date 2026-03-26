Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA62E3AEA
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565487; cv=none; b=shJvfJr/aJo/Eyx8BS0/U7OTcwA8mig32EqN7T13aoKdMGG/qLIHdCbIm8+CAltqKcKK7tsiqUdqrEwFNRVUqZgOZPwYzDNRYjaUG5F2h7DJ/fkY4q54hDzJrCi7IvTru1C0AS4uNDLXasJtMhrdw7AEHnn9W7ZocqHXosfee6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565487; c=relaxed/simple;
	bh=hPlCEVowVgLGk4422bazB6rDsuk/gYC0dG2/JRaZmKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ci2JHMZ1bHpLkEPTkiEbCiDx5x2kNUIWs9fZjTrtGF1Smpf8baTUFU+6tegxq4mITs3iLO4Y9efk/8viMMf7qsOZRFHI6mhTqaDLra3eeVzSJSGW2lzaO84dstrwDW/f+0UeUJ7f3aRaQGXgCuM2OUg+jvqKdlLw2eGuW3e/NFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlBdTeJW; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlBdTeJW"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c179d4e1a9so1397331eec.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774565485; x=1775170285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Malv6BS4qjNsLSYNxsubg9OArYSqkE3PBnFEvAKNips=;
        b=rlBdTeJWjCR2l7zqH2EkLBaQNapEw/GFio1ReP9TC/ZZhrw6QYNzChWdUl9Q0EeOyS
         UbuZJvKrK3LvxE2sUyjiPObPVljMDNwapBKuL1SWhvFzxqfwhT279Ceu06ylfyDazLGn
         gQpXZjcE9r/UIuYb+hWOusvUCof5UgCvyLdaq36C8lCLfql618gvkHYqNxjp1G5jsQKg
         Uq3/AvPN1iyXHL5zAOsXKLr0c9cW+PJDqOWntmKrEO9S3PoiaB033MOf+bdWXmbMRfQm
         6ksWtXDIgChzL1/Fbx8KWu55uxO6UF5wfpu94zDqyt8GamlBm+h/OrQtNs/6WTYERJjd
         SpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565485; x=1775170285;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Malv6BS4qjNsLSYNxsubg9OArYSqkE3PBnFEvAKNips=;
        b=a2rc3dAlPFdC/VaDNUtc+jamVjmyt+RyEMbt5wmtoxJl46nM2pmS07sUJ+tP+c6e/8
         7mQif7QyiKvcfWLrMDaukwahAidC2gH3DBqvl0Y1XFDtVA35m434zbyfvU+iKpiED24/
         pE4UoT2SBhTX3Rr7dF0Caw7K5huDmRFg3TTg792n68x4VVHgIgkymPN96Dj+1eOlKo7S
         BsQwTfR9uFBwuNswlZvRTYHvWM1PU6JvDdWtg6Q0aLSEFWp5Pwib63ftSo1TQ67kminj
         oV4QJCS4urUI64QTYgT64u47Q2KFbCH1igamXiTQXLXBeChEtuPsSh/Md5fC9i/9Y8ek
         Zsdw==
X-Gm-Message-State: AOJu0YwcpPHGgbPQCsHhJOi+6tCeV7gNObOEXnBLr/g0v+KDeJ2pHj6X
	q0dg9BehjTErvGd+W7CU/LYXApABphdPUpa8jvmDgHPU/aIdA84R1wPH
X-Gm-Gg: ATEYQzyIXXwmwk6cfv4ShjuzLmFABINO1xAVCaGaRKrgD1JqBTIF0HIyp5dyw8tFog5
	K3/wAWk3QTFe7FJL6brCWOYAPQwEBQjLE7+OuI4YhlbshWGlI6Hu0r1fZxj6HtWDjmQVQ+ZXfNX
	qsFC/hXTQAn89ZnZRHLg0dAp+TV7CPH5RcI+t3HLfsEUA+/mbU9ZX58OVbeG0tIAPxl3zC/kb4x
	3IB+xgn3SZY3w6VNRYmAuaYCCmnJqENOU66KWqN1Bv5Rd+zTLr+bBXfjDfwBX1bdTrs9A/86PeF
	YNWzcyj8osNa6YUyY087QtbJzIEZScrnWnBGZASNta4tgDV5k2jc4Dq0/ZSf92gPPr9fUkWqkWX
	5lanz9iDUKP21LgKIOMHKtWwwojy9epBdZxOK+1TDii4cmKTXfZj52TRR4jCcJBHxh8pTpcHzvV
	LNMlWdlTzUksLTOMtiX34lOiwOYSMo3+vvGvmrBsMAIOmz34y291WAOKlibtjvv9nUpd+LqVxqp
	fpkqkJL
X-Received: by 2002:a05:7300:371f:b0:2c0:ce11:770e with SMTP id 5a478bee46e88-2c185dc6fd1mr216686eec.15.1774565484959;
        Thu, 26 Mar 2026 15:51:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:4a82:c020:f551:481c? ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ed9ceb0sm3647477eec.19.2026.03.26.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:51:24 -0700 (PDT)
Message-ID: <46b5a0cdcb00899de5580896596ee5d3c693f3ac.camel@gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	cupertino.miranda@oracle.com
Date: Thu, 26 Mar 2026 15:51:22 -0700
In-Reply-To: <CAEf4BzaQqWprVN8RcvGvAEML7rGsGE+x37+RYRHADsGRNd4JXg@mail.gmail.com>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
	 <CAEf4BzaQqWprVN8RcvGvAEML7rGsGE+x37+RYRHADsGRNd4JXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-26 at 15:47 -0700, Andrii Nakryiko wrote:
> On Thu, Mar 26, 2026 at 10:39=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > Impose global ordering for all decl tags used by test_loader.c based
> > tests (__success, __failure, __msg, etc):
> > - change every tag to expand as
> >   __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> > - change parse_test_spec() to collect all decl tags before
> >   processing and sort them using strverscmp().
> >=20
> > The ordering is necessary for gcc-bpf.
> > Neither GCC nor the C standard defines the order in which function
> > attributes are consumed. While Clang tends to preserve definition order=
,
> > GCC may process them out of sequence. This inconsistency causes BPF
> > tests with multiple __msg entries to fail when compiled with GCC.
> >=20
> > Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++-----
> >  tools/testing/selftests/bpf/test_loader.c    | 174 +++++++++++++++----=
--------
> >  2 files changed, 130 insertions(+), 104 deletions(-)
>=20
> [...]
>=20
> > -/* Matches a string of form '<pfx>[^=3D]=3D.*' and returns it's suffix=
.
> > - * Used to parse btf_decl_tag values.
> > - * Such values require unique prefix because compiler does not add
> > - * same __attribute__((btf_decl_tag(...))) twice.
> > - * Test suite uses two-component tags for such cases:
> > - *
> > - *   <pfx> __COUNTER__ '=3D'
> > - *
> > - * For example, two consecutive __msg tags '__msg("foo") __msg("foo")'
> > - * would be encoded as:
> > - *
> > - *   [18] DECL_TAG 'comment:test_expect_msg=3D0=3Dfoo' type_id=3D15 co=
mponent_idx=3D-1
> > - *   [19] DECL_TAG 'comment:test_expect_msg=3D1=3Dfoo' type_id=3D15 co=
mponent_idx=3D-1
> > - *
> > - * And the purpose of this function is to extract 'foo' from the above=
.
> > +static const char *skip_decl_tag_pfx(const char *s)
> > +{
> > +       int n =3D 0;
> > +
> > +       if (sscanf(s, "comment:%*d:%n", &n) < 0 || !n)
> > +               return s;
> > +       return s + n;
> > +}
> > +
> > +static void *realloc_or_free(void *ptr, size_t size)
>=20
> but why?... why invent a new realloc usage pattern just to save two
> lines of error handling code?

Yes. We have this in verifier.c:realloc_array() and I like it.
Can through this one away if you don't like it.

>=20
> > +{
> > +       void *new =3D realloc(ptr, size);
> > +
> > +       if (!new)
> > +               free(ptr);
> > +       return new;
> > +}
> > +
> > +static int compare_decl_tags(const void *a, const void *b)
> > +{
> > +       return strverscmp(*(const char **)a, *(const char **)b);
> > +}
> > +
>=20
> [...]

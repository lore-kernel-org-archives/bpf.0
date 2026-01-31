Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC514367F4E
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885389; cv=pass; b=O5l0jTFUTOAyNKoJwkw0BXM5qOvnOg5JhqRtf6ud30PKnEa4PgfyQWGbiY3QMq8ksT6kHY6vBlZtB0NsnLenryqwqzbLfNWSQXStP3twA54d8xqVb1b+ZFwCWL31MkrmO3XVDwNghcTgGip5f0FPj0zPhEBQMkoIVS9zVfvg5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885389; c=relaxed/simple;
	bh=dEPIDbpVDGVStP2kmKFvVuPvvr0MPhgKCs/HsINDJWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdGEXc4VIbScYbVhhQdqyEOS6nDDmc5pKX0EDXr7pMoh2DUx+P+QrFoeRF3k2++n6FlL2bFO5fJOaVdegEwJh3s2LLTT0g4VdJpL/VjLUeyqUZ+2zNwKVrjyVN6CPQFCZ+Bnth5oStAAjgcGJgEGW3u8RlDXwGxz78wGAYaQ2lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKE1i082; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKE1i082"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6481bd173c0so2798321d50.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 10:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885387; cv=none;
        d=google.com; s=arc-20240605;
        b=HiyUDTL7jJNH6JNx8CzzzY0Wc8q0plc9H5YURD6ETkInAFlTbUri1g88rxg+jkc+/n
         u0N6nRGJ8zYfw/+rEJeVWL+wwHKGVvGRwr+uF4lo0Od/oUvjqShy24XJp5cA7Rgsg93v
         Ru9Gpg5rA/W0ryPXG7zDXxMkqVVshTZHdMkXmerHk7UmBH9FR9epH4p56Xz7gOfE+m/n
         AYdB2EaxsQmM247a/we/jB0gliGINz1El8zXxLCrN8k0dRi8mdREfc2JVw1u7bntaxh+
         xD4WeIpeASpgpOBVDytrlYxk8pFyZHOkXVVgdmRRb4UnTov0wWl0byuz5VSAcld8vfgb
         f/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXHEZMRB2IMrYQ/E3FqCsNDjQQs4Qzp+JLdtQMC292A=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=U7SiEoZhicMynsgVk5J2YP738U7lyP3cS6l8AqISpui2h2yoPjSimmgVdpnbu5wd3O
         t1NeFyAB66TVT5v09W1s4owqR90FQWLmPBQ+QSoOenz+0S75DG8sEPCzDsKLnO47T/Xe
         S5THed0bYsPaYvhGpq02OEXArC0pJ0VCZRD+6On70IFoQZhQ+MW4FRW/cxsLYsqDOH5k
         I/vseYSK04RUWIo+PolDrtNcBeBE2OWSNQwevS2E2QPRTFhABgPQGsh/AEnd/0yml2qR
         2NGIKXEi901il/3B3P9026f1UgPoiUg9GZbPwgRQJhV7RlxXt3Vmb+Sn0GJQ1hSSAi3a
         2vww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885387; x=1770490187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXHEZMRB2IMrYQ/E3FqCsNDjQQs4Qzp+JLdtQMC292A=;
        b=FKE1i082Z2NwDu4VoMW/vaPiRWhY3cYSHXiFeP60l/GRCm96J8NRch0H5L+ka3Mig/
         TPNbsJLiYvdPLAkX7MiZjogmJbWC9odVahKTikyEYyAkrqqO0ZYeWbMiDn4cpZuvBTuE
         cQYHvMpT8fMMF0bJRfDwv4h21VsokUoo/SJMjBtOkyecZGfhdV4DFEu9FCVzSQrfQRst
         vrZu1TpsvWZ5RcQAmwE4H/Tpxvgg9FtEIlRZqhk+rOdMlE7GOuHy9okF0Mc1WepCw0e5
         kaTavF4RWv11YkJM3AbcGqhTYlK23eiuoauv3QLj4O8kxCXL7aDo02yo2/eBprJFd4VI
         Y2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885387; x=1770490187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXHEZMRB2IMrYQ/E3FqCsNDjQQs4Qzp+JLdtQMC292A=;
        b=KZJw7muIzdDZPkyfFi5jEVKQFuUZkVMUdg8RQgsSG3SGc3TCIJJqJ2XQ9ctB5Rvd7u
         HykP1Gq/N6hLzInPDq1VK15J0r8y509HSnqCI8gnOZAmu2JbFsiVyAuRGQSGP9vL88y0
         atUMrI4VQHKYUyVzuiwq1faF5/HCvN8N61LX9fXvUNW2dO0PfEEVVtfQTltG+s00JEwS
         gOVhcOgOiuSGfq4lgIbatza/zZvkT/REDK8WXBmolqdea/P4HgWKHIyjMZWHKTJ5V19C
         hSWX7WGLTZflzfC9c9RoJvsR5drQpcmMq+Y2DvEpovx2LZoWOfKqCmkVbIjSsKsaF9ij
         TSJg==
X-Gm-Message-State: AOJu0Yw5d3uvXBzUnVUHi4W8O8SebEI7qxjLFgFSJKC+DHvEGL82DwBm
	pcN8fht31LcLeQxieQJ66NPNr0N+AMMrLaH1OkOix0vn2LCoedXpMfEXpSngdU/USgN5TP7ppV1
	SNnHv4XuxSiXVwqpFibMbnBkLaZs7jsk=
X-Gm-Gg: AZuq6aL5K3+SUxJpXpiJa0OezjsXJ42eJ18d1NzRmaWYaG1x+zIFgDgDHR97RApOSPE
	Ja9YNWl6ZU5bteNxhktic8L9YC8I/k9aqYzHCPH4ucivvfiDOsQHt+k997P3NF3E5JOzZ3gBdHN
	McXGhfRQ45vyT6pVotgWqGlDyG8KhM7hlpOUFwPPk/ENP7Xlzb/aB6FalKUo7QECHpRiidaOVDv
	Ytv+pwNwSLAd7+y9C/2mAqX+8EO2lTtpIwujGbaG++LrIUYZWsArsMwmWgRYucf6g9/tqI30+en
	j0wrRw==
X-Received: by 2002:a05:690e:1249:b0:649:5685:450b with SMTP id
 956f58d0204a3-649a8501d25mr5195022d50.81.1769885386844; Sat, 31 Jan 2026
 10:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-14-ameryhung@gmail.com> <82944fa5ded226a7a91da123ec384e8e353df448628c47850c6bfa9917f85960@mail.kernel.org>
In-Reply-To: <82944fa5ded226a7a91da123ec384e8e353df448628c47850c6bfa9917f85960@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:49:36 -0800
X-Gm-Features: AZwV_Qjt76zOwuZDomZAmIgIfiKk0V-KRrOkxhySSSMNB-cnFg6UnsRAQ65kVsA
Message-ID: <CAMB2axO4=-b4PekKq3OzB8o3DeMM-0oCF7w_P2cfyHkYK4ab7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 13/16] selftests/bpf: Update
 task_local_storage/recursion test
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.=
c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > index 42e822ea3..559727b05 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > @@ -117,19 +117,19 @@ static void test_recursion(void)
>
> The comment just above this hunk at test_recursion() says:
>
>     /* Refer to the comment in BPF_PROG(on_update) for
>      * the explanation on the value 201 and 100.
>      */
>
> Should this comment be updated to reference the new expected values 200 a=
nd 1
> instead of the old values 201 and 100?

Indeed. Will update the commit message.

>
> >       map_fd =3D bpf_map__fd(skel->maps.map_a);
> >       err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
> >       ASSERT_OK(err, "lookup map_a");
> > -     ASSERT_EQ(value, 201, "map_a value");
> > -     ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete bus=
y");
> > +     ASSERT_EQ(value, 200, "map_a value");
> > +     ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete bus=
y");
> >
> >       map_fd =3D bpf_map__fd(skel->maps.map_b);
> >       err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
> >       ASSERT_OK(err, "lookup map_b");
> > -     ASSERT_EQ(value, 100, "map_b value");
> > +     ASSERT_EQ(value, 1, "map_b value");
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit message demonstrates deep BPF subsy=
stem expertise with detailed execution flow diagrams that suggest human aut=
horship from a domain expert.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Stale comment in test code references old exp=
ected values, causing potential confusion but no functional impact.

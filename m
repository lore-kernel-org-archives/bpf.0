Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CE3382CB
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788320178; cv=pass; b=OsBAJMHoxQEi250fZmsbhSfJajP1I+jZJdjVqFNAwoyRvwBe6l98+ltVD0c2fP3WA1agRcG2HBBCP3fXUB8AaVg9kDVs+OLhYsjvP1zQLtamHRS+5rkwNkb7S5rdWDju4SXc4HquxoeVA6Yv6GooqadYOpX/jU+/U5nYObtXshc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788320178; c=relaxed/simple;
	bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWLJbx0kqAludZmRrKsSGg7/RX7J8s5nzIvu1LROXTm5RBtO3R+GjhEPGkmxwYDSpBlwD2inLBWE0D6XONj83NpQ+z7ctwzMIIdsXchhZXz89LnbqJpfBmyH6nbmlNrKVu4/HgFR1hV67PBS1S+OwB06HEq48kWoCooErPpWy/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkeglZ/Z; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkeglZ/Z"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52fac937235so79301cf.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 20:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788320175; cv=none;
        d=google.com; s=arc-20260327;
        b=eX6n6nn+WSxR5EsvW5sc4spXalzmWWpJ5028fWMrG1uAdPHKPHFFNhg+6huzYxT8J/
         KZDkgzFwLfbPHLXNpqdaQm4bt5aza8V9txbKFf9+J67Bzb8eYPpVhEbEz5ZYw5ilx/oR
         8KElF30UHvF1E+g9X2DB+fu95eC+yQSVoz3j8GBLjTTi3gBr4uBVJvmlMFRLZgUwaIsz
         LV+3qqfYV9SvlARSddqghmFn3klQwoBkPMiLs8e2qZ/D+TS5zl13w5WwlHFaiwlDBKUI
         +rKQ0ZPdrqWyNmWPrKk2a4W4qZQV7WuZLDNO/WZXVp8BtVfgbajwg1uucbYMXxRW5hff
         pX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
        fh=de6QzoG4w2GVPXpFrEFy74uuJGx+QWPfS8b04waC4sQ=;
        b=EJYbVcM7qcvcCS1xNwl1qOKUoCA4zw/vTC64goAoP+oFe/S0Wz/pSLWh48eb7KrlZB
         NXBIGLkdhqgi5sm7i2jM2I8/BBLHoA/E+DyZHUvTL9XaE8VmXqRhx1HjkWnqLdMA7tTx
         hW3n063YyObITVrlD9uU7AbSUetVwWi/1U41nYnFDXOS+Rzl8EVjpXpucJr7GyUO8tJH
         deLZ4favbKpI3kov7HEadxkgVOiiE3vyVWnPaXJNZRRSuFGP5HyjTrf+O1S9ICLn/Xwx
         KSyRvVEmZFhAW88otMxGzilpQ5J3fOQgtDg3dHoLMvEgbp7tFyfXwnj/sSLedphax10t
         mJIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788320175; x=1788924975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
        b=KkeglZ/ZTSO1YaQfEfX1Foq0beIc4AqiL15dpbfgw3vejcWeupvEQAhjGXoe9fZHCd
         FwTwL8cebNrVllETNERZTuYX/rUwk6IfRfrBODBiELrwFtuOwYX9VmoMr6Wt2wSW40Vb
         /RbXfhnYAcjO6ttXgPtYeAVxVCTMAYtJKuXIJh3BA1kHGdj6hxTfyUoTq+gsMNuOG5OR
         4eCH7cEhiw9kzoYY7HiN0ZDZziYOitn5KRxG25mm6ftEVCn8zX5rRA15IL81DccZZHjz
         DjIG1uQ2y6U9wbspCH/BwFP3ZjXr+QBisbvT7zYJS01yMbg/R/LTGL32h8Xz708nsOvw
         pQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788320175; x=1788924975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
        b=iMVUPBZE5LJH9Mg+WyBIPzSlZ78Ssn/oSF9eZNmWgSQ2DXYPfAnS4ID6QiW25wWiED
         1pu5nxmlzEp4nKTgN7S7/45OaRDgj4GEaYQ9Z7i28TfPLYIKqCbwE1TuXLDTqororoRT
         9ZO1mzmHjONAJJGEv0iY76VXEY8txz1W0rD6JOqnj5JqI36ojspD7p6R88MVtVDd9oCE
         IqZwbJ8vq1M464HmCDtciAlcU8W1jnBPzGJFwoFdOq9i2K9j33aZfJkzfvArX+LCtU9D
         GEhVLM8wcsUmhKUCtcgGOi5zGTn2ByQjF4WF4YRK2A37Ty3uzT4HDQficKbMPltklocg
         LR2w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0z6tumyoCRA5+KnIy0tKTvaN8mbAh3wYCpIDqa9A1Wl9+MFPgEpXD9D3BkmqJvQm6WDc=@vger.kernel.org
X-Gm-Message-State: AFuF++kXQ6ptgEqlpIt2uJFq82ho/MRf54ldGZNDFdTrz124i8eeA9Js
	jiRY3nWNT6Cs1ZVygYKNyg1AHwYnHF1aSfTjh6vVaCWkM7fAnAVm0XnXdWbUwn0S53MZ2cy/xXf
	jHF9v6PyNi7eWzqrry5e+XkpCcM5EHFSNmb4OfMq4
X-Gm-Gg: AR+sD11kwOG4bty/KxvNEJ6f2iyTwyw2vatbVKcMW/+G4GNPg4maUyjcJTH2+noKXNH
	LnagwfobyW45PWfQYwKL+PIL29LPHVdiIXyrSGSO4XO5Gzxp3w2E4nXgvtpuvzvBvgW9AJL1fF7
	WIt11Wte+c9EfFFmbPNo59I9Fc6NryePAQNh3GWY/Egl5Eqz/6b/Qm+swhyuWseBJZSHaJYJnpZ
	r4hydH6eyZngSwXEs+fp7XyLX524MPVEfHvXNWLW6Zt+bqIhwlYqMhBlv9vvU+s82GNbC7CQXNh
	yNVhBse5+FychP8MbWu9P1OF0wo2e07zI4NY5t5Pj1yDZAWWYOkizD1wnLnwOjiT2U9RVFIS8Pn
	S4avISmJji8H2HfRbNSatvQOmNzF9
X-Received: by 2002:a05:622a:1b21:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-53035b635edmr5765381cf.7.1788320174962; Tue, 01 Sep 2026
 20:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com> <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>
In-Reply-To: <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 2 Sep 2026 13:35:56 +1000
X-Gm-Features: AcwNN1UK8iToxVRYZbB0QJOeCKOrbeItGVVek4Zgwjy2T1K6oHlYjRUdS1Q2Ww8
Message-ID: <CA+zpnLeAag+YBtD1Pe=8UPc4Veq4k1yGkwtaJacz+vB4mwbFqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Introduce LOADER_LOAD_FD
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Eric Suen <ericsu@linux.microsoft.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Sid Nayyar <sidnayyar@google.com>, 
	Neill Kapron <nkapron@google.com>, Eric Biggers <ebiggers@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:11=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/13/26 2:26 AM, Thi=C3=A9baud Weksteen wrote:
> > The bpf subsystem supports a signed-bpf infrastructure to guarantee the
> > authenticity of programs [1, 2]. While this infrastructure is ideal for
> > dynamic environments or enterprise deployments where untrusted binaries
> > are loaded post-boot, it introduces unnecessary complexity for static
> > platform use cases.
> >
> > In the Android ecosystem, platform BPF programs reside exclusively on
> > read-only partitions that are strictly verified at the block level via
> > dm-verity. Because the kernel has already guaranteed the authenticity o=
f
> > the underlying file, parsing and validating a secondary signature insid=
e
> > the BPF subsystem is redundant, complex (because it requires X509 and
> > PKCS#7 parsing) and necessitates introducing additional signing flows
> > during build.
>
> Note that the BPF subsys doesn't implement any X.509 or PKCS#7 parsing,
> rather we reuse the same mechanism as the module loader has been using.
>
> > Furthermore, relying on signatures forces the kernel to manage a
> > dedicated public key keyring. In a decentralized ecosystem comprising
> > various OEMs and SoC vendors, managing these keys specifically for
> > infrastructure BPF programs presents an operational hurdle.
>
> There is no dedicated BPF keyring.. an OEM key built into a kernel image
> has no additional runtime key management.
>
> > Thanks to light skeletons, it is possible to embed the loading steps
> > within a wrapping BPF program (also known as loader). In turns, the
> > loading of the loader only requires a limited, well-defined number of
> > steps. This series introduces the bpf command LOADER_LOAD_FD for the
> > kernel to directly load an ELF file which contains a loader with its
> > data. By moving the loading within the kernel, the authenticity of the
> > loader and its content can be guaranteed by existing kernel mechanisms.
>
> Same issue still holds as described in [0]. Also, this sounds more like
> convenience for Android offloaded to the kernel.. (you stated redundant
> given the signature validation and complexity wrt keyring.. so what?
> don't you have the latter anyway for vendor kernel modules?)

Thanks for the feedback Daniel.

Vendor kernel modules are verified as described in the 'precedent'
section: there are no signatures per module. Instead the combination
of dm-verity and SELinux policy ensures the modules' authenticity.

> We're not
> adding yet another scheme/alternative for addressing signed BPF via
> separate loader mechanism.

I understand your position. Thanks for taking the time to reply.

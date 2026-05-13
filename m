Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AA4CA26A
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691524; cv=pass; b=N3ePoY5UnBLizasD6Ie3in0+TbZMfdy+/52W/VUbzbPFrtxrTGQBQ8K1DIHx5mbCznM9y9i3BcjtACam3o4HpG3B05TL6T5hMWHV1C1SdqOEeC4EstXEdSJfSu0p+b8RvSl3b1X2K2bj273plYd5hdOpveq/Z2B8KPMyWmIHSr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691524; c=relaxed/simple;
	bh=SqJkmzsxQ6Bg+3993aoSopYTOKABnIcT2B3LrMMerNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbqBSr/uzuK9eBC607du9wmy3QEe++No6OzLB2MCA9xwsdiLMkNREluHMnHibza0xcpTzcMQ/9PWSdI1hyyv/7WFzy7Y7ks3fmEIQo5Zazpgp2pT6p9qjIc9nx0+X6biO096BwTyIdJICuSCIwiWdOJAMa3rafWMb7SKNcLK+C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF094GlF; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF094GlF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891f625344so64403915e9.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778691521; cv=none;
        d=google.com; s=arc-20240605;
        b=M42JIdCKGmH/AZnck3NRRovxpRiqA5xKc6N5N4sla+v17veqnpFvY6hvVATalq7kbr
         6XPkjKd30XZgC16TqcmfPYnl4su6wtNJnOeoh0iU1P8O9057Y6VqHkla2n5A6b932LxA
         L0ooIshbYGjE8ChTBVdx19xE+kRgpM+fIzN4pmWl66uslGDKuSN76o3egHkKYjGheVKd
         +WLDO0dPsfn2zEAFcmgqX7U9JLsqNaCIyOgsrhw2k8UhhsmOOmcWNDHbR5XGxZN7lntw
         Nyk3JZaGMOdmTdpzDMkjO+pItSH3lU3vkKflLbK8KM/TNE+Qv/vZYFz44w4qGqcaTnCv
         ZMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cYn39bxkUPJdxPW/51bsLAUNQTX3vZyidzaMcAYM4Ro=;
        fh=57+5Z/IGIG1TJYQyacsf1am2sxn0G5xfDMWCPBlcKqU=;
        b=k3KRKL8RwlujcuDLioMTc+WQze5QYxxZFx5bvZ8cjkOKYXcXzfI11DWYG1IY9eZK6F
         FozpLCOr2zCK7acxFbIpgE1HgPQ2ptSFGjlyr0t1pgI1Oo5tvTeI6F3MNxcdahOTBZ8b
         yS+sigvDB+Si3/usB3Kkzr0vbabYKEoVJbMKshb9ATH4KcdXe+iLeU8UFkBEjuT5GzVX
         605EBM8au+wZ07Yy5V/w7KoaNpsZ7dMQNcvH/X6znWeVCZRMDNLeRlRW7b7y2vxJv0DZ
         wK8Nmzp5VxIKBdLDctJUz3Rnr3hGawTBm/EVmeCqJ5sihAFlFXQS3wBH76eifHqbLZR2
         HHIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778691521; x=1779296321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYn39bxkUPJdxPW/51bsLAUNQTX3vZyidzaMcAYM4Ro=;
        b=EF094GlFt8ZQzniLzJZaWVPpJst8SSHNoVmUrTypFXkvlkQXwaZjY9KYd8a6wdyXED
         dGQCOfcX3HTQUBqgRlghHBOLk16Y0eraUlb6Y09HkXK6uxek1WWSYpAPYpCDuaISsCKP
         rHFHQYYgeP27dgdaN2eL8guogqctYVnGBBIMCCxsKJjVMUqHS7BWwbHLCWcVXOJY8X2k
         bOCThDSihfNqbBy4Sp7rl3gpPbIXqHyBVoGga11t4q9R+PtkgWOHyll1l7Sf5l3nAUpg
         SGVQD/PN8AN98ffAFKaZ9gxlrGyDPmA25pFd6kOjTJthPr/85esJk+v/fz/A0iGINNIV
         fNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691521; x=1779296321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYn39bxkUPJdxPW/51bsLAUNQTX3vZyidzaMcAYM4Ro=;
        b=ltQCSvE3KSAAw49U+qeUJ7Oqpjst3z37FxvrjGeF4njWTEc8t/Hiddcx7NvG+h5MNn
         SLpg1uFYyiDcTzy0Io61hNQtYrvvLjYv65v1pfw6ZiPgi3N94gRfmFHW5y+EzNl7R3nV
         1KNnX7+sSACAqUCZHutNtS7dXtBtnwnH5RIA97Aq7Qm5Aid/kJwY9pEs79n0TnvNwPMp
         LuIxo1+6zAB/1uXt0/2heWGOyH/0ExEpMWoEcIrwKYYfLxx9+qL6iVzTLuMHXMdVPVT0
         WznW3k8FQ/Q4EeSolTFO08d573uQkBqKH2Vec0TBD112oBeo569/S3qHqd0bqtg1IfhB
         SoJw==
X-Forwarded-Encrypted: i=1; AFNElJ94tQ5B4e+1euCgVF7PHte9ZmCSn3apMJjfP0529iKzRZQZeQLrdOnSZMRnovMijry4OOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpReZmperF6sj7SEchcDcAK5uN63ctTUaajnVpX0rN11O+HM7Z
	oxbAhf1dkzMby+16J5Kdd6PJVQaPXiEtaq6i43l2XDNHbz1/ehv32iC8Tu5OVZ2qkUkPmkM+lcC
	WC+rdT0pEsP1zgOIAqGTBIWJvDFj1H4+QzA==
X-Gm-Gg: Acq92OGnbgpGCDpmmGvueuRhIAG75SVNPqqo7O044/uxLMqAOtwySReYkwlwT7ZXGnd
	3+hbL6ZLtDqKoRwYRyYzpfmaeFJ61ylciqQob4GMx4uq3uefGpjA+yOyfSgu0QmVtqSA/Cssj2l
	3AOkIcTIdCBUFNR4Jum+AysdUbL9K6DpQuVLZdPIKjou2ddZf3uEL4hDfWpSQsEYh6oLNp23036
	u8MzrGG/okfwOT6iyglPTvTACWIErrk6RBA6TNwrY+Ele8hRC5hXac3o/mDZsvuBh4xuz4bh9q+
	hYr+ptNfUWWVsYtthFH3e3A951k6LNUNI8jl0K+NCmHz7vsnnHM8XKjv89YZ7F7XUF66xFRUR9Q
	0QykEgUzD/CGyxDx+/TPDlnsI1Q==
X-Received: by 2002:a05:600c:570a:b0:48f:c649:e6fa with SMTP id
 5b1f17b1804b1-48fd636a2f4mr3781615e9.15.1778691521043; Wed, 13 May 2026
 09:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511152817.89191-9-leon.hwang@linux.dev> <20260513003358.55836C2BCB0@smtp.kernel.org>
 <b22790b4-1e33-4cab-bc2f-92cf7fd60bfd@linux.dev>
In-Reply-To: <b22790b4-1e33-4cab-bc2f-92cf7fd60bfd@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 09:58:30 -0700
X-Gm-Features: AVHnY4KVmxpLGhSwu1nYRAjRitowA6SWqDXC6Ub7AkvvxHCT8-OofyNdXkODyIo
Message-ID: <CAADnVQJk4WRFrwfNAgmFSbS1AgBHUok48ArU08SwSn32GNwbWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 8/8] selftests/bpf: Add tests to verify map
 create failure log
To: Leon Hwang <leon.hwang@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 3:47=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 13/5/26 08:33, sashiko-bot@kernel.org wrote:
> [...]
> >> +static void test_invalid_numa_node(void)
> >> +{
> >> +    const char *msg =3D "Invalid numa_node.\n";
> >> +    LIBBPF_OPTS(bpf_map_create_opts, opts,
> >> +                .map_flags =3D BPF_F_NUMA_NODE,
> >> +                .numa_node =3D 0xFF,
> >
> > Is it possible for this test to fail spuriously on large systems? If th=
e
> > test runs on a machine with 256 or more NUMA nodes where node 255 is
> > online, the kernel validation will pass.
> >
> > The map creation might then fail for another reason, skipping the expec=
ted
> > log message and causing the test to fail.
> >
> > Would a value like 0xFFFFFFFE (avoiding NUMA_NO_NODE) be more reliable =
to
> > ensure it exceeds nr_node_ids?
> >
>
> Practically, NUMA nodes number wouldn't be >=3D255.
>
> Instead of 0xFFFFFFFE, better to get possible numa node number from
> /sys/devices/system/node/possible, like libbpf_num_possible_cpus() to
> get possible cpu number.

Ignore this bit. There won't be such numa nodes any time soon.

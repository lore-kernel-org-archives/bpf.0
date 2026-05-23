Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55805343890
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509275; cv=pass; b=ZV30mhlsJijIZ6HPMv0gAXyyRc/iRTJM6/8ekLRe/50LlguJHJFNNpn7QpEZzAhPUpOCT0nePTkTPKygFj4v2HrqF9fXoiuFdfB1+/wz89OPilGoohx+z2iKCa2yDS/bA4vzBnAhb+IUS55iJdtJnazJqI7JpYrU/h5Ik3kpe4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509275; c=relaxed/simple;
	bh=vGEb5VSmkEMcF3xQd5x9evuFv/txRodMq6g69B9qaM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZbG0sui9ru7UC74WyR4OR/j84eez0DbNmvrKO7jBUB+bM1jj+/N+RFJl1SipW6wGPK3/LwlEoeN1J5WthTWfi6mro2r5GUfinYsJicr+5Z6EWtpO3tQzif0TeOlz1WDdIhbE+1yYptHSr21gXH8E+4pMzyxRXCJ2GDvCHtBNxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aAZG2YcH; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aAZG2YcH"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-837b39eb078so5434327b3a.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 21:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779509273; cv=none;
        d=google.com; s=arc-20240605;
        b=gLnl2OQvK6hwOjKvakpvhdJU/BVwBAgTit1OZcvTVtMXPg8spwtaTBuVdzebF2Ol1G
         eSEQWaLrktWibs5mV+7hTrR7aOMH8UoHmDtNv8v8C6euZnPSuipGzwGK/amvA4dGjy/J
         C54QjQN0H79emPc2e5fzOAiABJUQK5YJy+rKMahJA8tOS5ZPdTh1fu6kC5PBib9mFi1A
         5wrcd0UTsjRfReOjAMAlrSzP4n0KcuhR6HUMmV9I7mZWk5Y/vPIYyXDoAFyz+cKSmdG4
         bTVPOC0PqSzgUfS3B/Lbm9MPKKlLaVLn+d5ir6Kb6CUUaKS6Vsu0fmhUjyt0s/ulmO+Z
         4WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NN+b2sfzxNXDXzV7TDm7hE5fzlrLYeypS0aOQYewte0=;
        fh=JDLGDEuFNz6l+zB8zizYmw/ygnBFpEuIVfKNGc+VVio=;
        b=gJsplHzctQrbMIDuS0f5Atlc2hdlLNFWWWQyTglx3Byi0Xqtb9TTIQQmCOR3CERLr0
         lOR8mbTeDS+WsqPFL8AkRjgyy8DBz2Fbmq3QnEqVtp8MDVJEjAqD1pqh2Vh534T3E/79
         QWg/rrquB6uoGDZmcPtgtthpKGwjDxwoYsspudwMbIN+qbMDH9IcnT2jXuB8ZRf5uuh8
         AQYCagwZrve/Uv1ZMYYtgvjIZUSSztVh0CuG/AZgrkC3vk8XwSvZon08aV+eEx+wb+pK
         RLcE1/spI/DpUwPgYRBjw5Gvch8rnAYgtcJDPqn+Z3Ihp8KKBL8nwcS2KugONTKff+8I
         wSyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779509273; x=1780114073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN+b2sfzxNXDXzV7TDm7hE5fzlrLYeypS0aOQYewte0=;
        b=aAZG2YcHkvqZqx0R9D0Yf8PAwjGMvjS2Q1yXVnZW/QcJsKG7e7u2yVJTQ8LkSA59RK
         x8cEgwwrfmdg0/TgovS8Ius8gJ3nLsQXfsLvtSnSarEwXINoIe8WW8u5dMG/Q3Gs0t27
         JIx5mMP3RoexXDAht1bfIXw/UxDlBD0ZC9tjzBGKFU0oKCfd8au0OqXSCOX8/ycnec8x
         iiK4R9DSnGW+v1feM6/VKFF03/29HQx72XTBbg/SJdhRqE7NLtQN4ti+C+rSOdfeNHaJ
         5A0nX6RXQkPzQPNPQZpCAGd5BS4OQFhJkQfuTFhCOO/fsFj3CJk/rIkZE1n1f+AMt6+N
         CdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509273; x=1780114073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NN+b2sfzxNXDXzV7TDm7hE5fzlrLYeypS0aOQYewte0=;
        b=LGQhuUbG3GxLUlWeyD89vxlOb0bW8KEoRHb6TkFa15zdMLwI5Z4jQRr9Q/xCUvl4v2
         0iPQf6h+Oifa6ot6FzAYUTZMPatKlP7aXJjg4g81PXnk2yaljRzVFIaPyfR7VBT0ZI8v
         A/T22b5NxN0740sVzZ/T62WCLd5qCPFQ/nRucMs/2rnOOZfIe+eEJfaq6Q8pzH8iCprS
         AA+sI6XGU/080/t8Lti638pkjTj3UxCA5stFW8YV8CJgflD1S0s5uV+8uSosUf+Uae/i
         SEUixTr8n6wOCdDGD2I84Ptd7+eTGAqVE2flOayE/ZGB25FSj7KCHp1wNXWr0IGQ253B
         tr0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/EBb2F0Yp3bVuMwWBvWdJdXxmZKUEyzoNxC37VeSJaG90vAAD2YJuETfefSldQM+4Pgys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoTc/2gMNcH2ZFduvhV8vTIbA6GQt2m11CnjUxUrcSTA57kJ4
	gyIirvAGboyaDl5NyeeMFHv2xAfRZU464QZqDuubEfwdmx5nucg2OlEycUcp/HdMgWrcT/YV05p
	qFfX2dhHzhKBpa0DmcppEbGULRFKm+q8Sr46YucNk
X-Gm-Gg: Acq92OE8yZotQqxq2cIW6PhpSz1BxrFIZgQXOnolSNMD3Gd2+sMX7fc7jLMlHrQwoRF
	+JELBA/YLcqHijrlku94IjzmWMu3aDlLZzTBOjVkaJq3+3QCC01vDlLF9RMSyOjesJzWd3ieuv7
	x5lq0wZgAHudrDabwqMBmwbE6QGy3FsCN+iyrzRPiuN2OpwaeijO1qBqPzxTIgdujiMr0hYvZT9
	Op2mrVzIy+pY6bOb+Ww/bi1Eqgjg4owete5DaG3Von8qCXvBf3TWFyqrMjKH2qdKg5Rt6vyvaF9
	06I1
X-Received: by 2002:a05:6a00:2da4:b0:82a:6ef8:cb43 with SMTP id
 d2e1a72fcca58-8415f53dbe4mr6009724b3a.19.1779509273360; Fri, 22 May 2026
 21:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CACYkzJ6e4LSPr9pbjAMze9-CpXvFMKdm9xXHepvjhMxMAw+=RQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6e4LSPr9pbjAMze9-CpXvFMKdm9xXHepvjhMxMAw+=RQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 May 2026 00:07:41 -0400
X-Gm-Features: AVHnY4LH13W4v-QECn_JRP_dXtczIsWCYDboQl6EfJ4JTRf8VAQqGMzOrZLpzzg
Message-ID: <CAHC9VhToAU=pj3eFsNswot_JAmujguuUCArHAhpqvqjmSJxPSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:46=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, May 21, 2026 at 10:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > >
> > > This series continues the "Signed BPF programs" work and adds
> > > the missing pieces needed for an LSM to do policy enforcement
> > > and addresses the concerns raised by the developers of Hornet.
> > >
> > > One signing scheme, please.
> >
> > This is why we tried working with you and Alexei for quite some time,
> > providing requirements, patches, reviews, and code suggestions.
> > Unfortunately, our input was not reflected in the signing scheme that
> > was merged into Linus' tree, so we have had to get creative to meet
> > our our needs and those of others.
>
> Is your idea of creativity to circumvent working with the BPF
> maintainers and community?

My previous comment should answer that.

> > Once again, if one signs BPF programs using the Hornet signing tools
> > provided in Blaise's patches, the resulting signed BPF can be loaded
> > and verified using both the existing BPF signature verification code
> > and Hornet.  It is also easy to disable Hornet and/or IPE at kernel
> > boot using the "lsm=3D" command line parameter, and of course one can
> > always tailor the IPE policy to meet specific needs.  Although you
> > surely must be aware of that as your own patchset borrows heavily from
> > Blaise's original code, albeit without any attribution.
> >
> > > Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
> > > on layering and TOCTOU grounds.
> >
> > Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
>
> Please record the NACK from Daniel and me.

Send me the commit IDs of the patch(es) you wish to NACK and I'll add
it.  Daniel will need to do the same; I generally don't accept
metadata tags from third parties, whether positive or negative.

> > > - security_bpf_prog_load_post_integrity LSM hook, fired by the
> > >   kfunc on a successful metadata check.
> >
> > Does a kfunc calling a LSM hook open the door to a potential recursion
> > issue involving a BPF LSM?
>
> What's the concern here? LSM hooks can fire from BPF kfuncs and
> helpers for a while now.

I was under the impression that BPF wanted to prevent things like
infinite recursion, from a safety/security perspective, perhaps not.

> > > - IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
> > >   two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).
> > >
> > > This series address concerns raised by the Hornet developers:
> > >
> > > * The metadata hash check should be in kernel C, not BPF
> > >   bytecode -- Blaise Boscaccy [3]:
> > >
> > >   The bpf_loader_verify_metadata kfunc moves the hash check from
> > >   inline BPF instructions into kernel C code.
> >
> > Please see my comments above.  While the kfunc is written in C, it is
> > still reliant on the loader calling that kfunc.
>
> Yes, that's the idea of transitive trust here. Ultimately you signed
> the loader with your key. The mechanism proposed here allows
> verification of any dynamic metadata, it does not need to be hermetic
> to the loader, provided the digest of the metadata is incorporated
> into the loader's signed payload.

We've talked about this many, many times already and the differences
in our security requirements are well established.  You've satisfied
your security goals with the signing scheme Alexei merged, we are
working to satisfy our security requirements with Hornet.  While
Hornet requires compliance with your signing scheme, there is no
requirement for you to use Hornet to utilize your signing scheme.

--=20
paul-moore.com

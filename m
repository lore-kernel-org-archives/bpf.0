Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04264396B7F
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218616; cv=pass; b=D8adXBYlTnMpYq8ZExxft6cyMNsE5JC2f47jUG2Jzp48m5J9l+hlPkPntrEV6q6ZQmmGaenTcVNogbK9JjJDRryMJO+0zxNobCvI39W/wbCspc8FI3bM8xkiw6UxYiojMX8hMfHAjBQHO5YwP8WoE+qOZdbV9TZ7nspBLpYKQXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218616; c=relaxed/simple;
	bh=80IYC70Oqf5mkhaHEMZbvU5upw4Wm2QTz2Iwsnv8oa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAiCKHtTjgfGE85iDWwXKgZqjCCdy/b+0mr3wehjOYk9ylnzK2le1nTh9PIZqCmgRNDVcFO8p5M4ukES6N2T+7J+SZuB2C1etYHD/pF+/0Xb6W2TnLkrIYYiSrZT9lokYkJr/udYjpWdAJ6bPXJCn2M4EyYlk6XyrTNGci7MrEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Uvf95QhK; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Uvf95QhK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso2780915ad.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 15:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218613; cv=none;
        d=google.com; s=arc-20240605;
        b=Ab5JeSCp1G+395gx3kBmtDt3fxGmFnv6INTy776abIwV4/Bk0mJXMVpl1Z07L2BG9H
         iCMx+nrJQEvzLDcmE2VRr8R0byk1BNUefWW9jvTSj9UTD9w5QG1zwjzXdyTSiqtsteBO
         SCyOcmXqjjJ3heCLc69QKP3WiHltNjSk4NZyL/y0hlEFZJO6p7YCTvLwrCkA7VvoCF6A
         aFCrFdSbo51kTs3zQp4BZs4DymVmTtHg1bJ5XKK4td38N5xuF/4WdGcMNEjlxBHlKa7C
         c9iLoudjN4ca/gpWE7m2T6vCjgZJzFF/Mfo5mZybdTxjm1SzD+N7kj+YUyN9diSpPF1k
         Yueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGYX8yE3GouSmB36dE4d3FWlMSjRjKMWRg/5nxp8fB8=;
        fh=SF4ldo6NxhnR/a3QlrWrqrwYN8DiRmzbDzDpeDYcD88=;
        b=QJQ+6MxWjUGDM++rtaUpMfiEq8O+z/gwkcdS8eXlSxpaxVO1wz7dvIpE6M2wqOcZz+
         PcpJpJx+CUzOdUZ1NoViOh2+c/iQJQCTg1oJZFnAzPOJAbzsNW8zXJdkCy8Az8iSJxlT
         kdDe5BlZQb6uIc8GX9BpYWt2WU3xW4VMpJm/u9Ri3Abe7YVorNXSzgG/+pofBCx20ddx
         r3x9HQKGVDbThzkYa99QQVgd/ajzmmilxu7tZnxwl7M0xnOfsKtrxnDdBIZY9l4sxdiH
         hRiDr90dc2M9X1nbV+Xb3sAHKjjGkqmpyDDEJ51b+Z1Uhe31Bnuqa9u/NpRz71USzhUi
         KmyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781218613; x=1781823413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGYX8yE3GouSmB36dE4d3FWlMSjRjKMWRg/5nxp8fB8=;
        b=Uvf95QhKe8gsE507vXK4mzeblnXg7tk9VfD49UfRShWQGtWCXXjk054NlyEz4g4FSs
         FSAU2N7j9bswIIDgbxyjpQmtoJBjXDUeCQ+MBmN8AIqBBoqPTVbY4h+a+tBEDjaqGBhH
         lGyGIy2ugrZx+hoqee+0a9Oy6781Kscl9DECIaTEKivo9FCDgrry6rA3wO2etmUP8rEx
         J2VNKhZ8HKzijzndbQnZtS5GjKrQtCYHPtv8W0QoyuK41yE9z4QYFsJHmCohs6vgyXdc
         e9okEfh6U6Gq29IOISlSSzL33GgzIPy3PDkcnMMwTVdcNi6pLKA/S/k6Jgn4K3/xg8V1
         tPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218613; x=1781823413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGYX8yE3GouSmB36dE4d3FWlMSjRjKMWRg/5nxp8fB8=;
        b=oV6TqiWwW6zUkItPnX+X/2najUYCUdCHU0zCMZSATBL5xq6I3J5dap5Fzif7Z9hdbD
         v6Q+K3h+gV5+2Coq5Wix4zyg6sVaBegcdNys7pPH3E1U+gpi6weP3aBw+QJzyCRBP1SB
         WbySbGrLA9QoLrCtEo5+pQ38/Y3E9/veyKjvKSvb14cnFA28HN5H3Dt3jZSbnESfFLmW
         MgCDuhtbvFxKOgzdowiDdAclb2fqI63ZE549Mhb4LtfIR2X+6wgd6xcTq2Hu2kal5d6f
         wXXEiLA6UXMFTTxgNjez4q2RkSDPwouTQz1ZIRccHtwQ8KdonYlok2o3jAvi8GeCW3bD
         N5CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kqT7S3bB8iXSBkCPF6bN0TlbYgYvDvlQTKyIJ9Vb33mHoe2LtWQf25xO31h+ruAU3Zy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7P669tlYfUbdTLx08KN3rKXybtb2lEkMpJEI2wBIArKfwZ6o
	hZUGc8cur8SghYCT8WuLkZgAATFyB+QvG8b0eN2sDY0Yjhw0kLG4AZMHeAlBoFWkTt+ve/tFX8a
	6vL6I1O4IZ5Zb1i4/hWwsYPsOIb8otXsNLJuMP/D8
X-Gm-Gg: Acq92OGm8zvXawTRtjk/OMhCRJqjq6RD+0LQUQDTOH4hWMr4J+aCE/0WEnu4SgdmK5F
	HGse8LoH4ym40EOpd2SGrN1fWsiIXwOuLYYWHyknjT52P/GncOp7E4oCJoBPzReNlYj0Pojkds2
	tJcdI5G2u0bRWVzT/0Jb8pfkRRBVe5RKw0ht2jJvT/FIMxm0C5NPz8fQlB8VhvlXHoycF6BKJWb
	1UY/8hv/7PkBkKB9+uxogZmMt9Ge4ORbAtv99oFl7R7BoMgItByfSrwpwb40oZ6/e368wgTnfFB
	18bT1PM=
X-Received: by 2002:a17:903:1b23:b0:2c0:b19b:ef0d with SMTP id
 d9443c01a7336-2c41255f24bmr4235855ad.19.1781218613229; Thu, 11 Jun 2026
 15:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230329.727075-1-daniel@iogearbox.net>
In-Reply-To: <20260610230329.727075-1-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jun 2026 18:56:40 -0400
X-Gm-Features: AVVi8Ce4dPShB80KHWBIUCrtea8Uet8pr9jdlDCau5GkiPWMBa1JwKrUn85Nfmg
Message-ID: <CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=B2smEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:03=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> The BPF signing scheme signs a light skeleton's loader program and lets
> the loader vouch for everything else: bpftool bakes the SHA256 of the
> metadata map into the loader's instructions, signs the instructions, and
> the loader compares the (frozen, exclusive) map against that hash from
> within BPF once it runs. The construction is sound as a trusted hash
> chain, but the kernel itself never attests the metadata, and that split
> has been the recurring objection from the LSM / integrity side since the
> scheme was proposed.
>
> This proposal closes both gaps by having the kernel verify the metadata
> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> verifier, /without/ growing the UAPI. A signed loader binds its metadata
> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> are already bound to the loader's digest via excl_prog_hash. When a
> signature is present, the kernel collects the exclusive maps from the
> fd_array and appends their frozen contents to the instructions before
> PKCS#7 verification, so the signature covers ...
>
>     insns || metadata_0 || metadata_1 || [...]
>
> ... in fd_array order. The in-loader hash check is dropped from the
> gen_loader entirely: generated loaders carry no verification logic
> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> operation over bytes that sit verbatim in the skeleton, reproducible
> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED
> with nothing in between.

I'll be honest and say I'm a bit surprised to see this patchset,
especially since KP and Alexei argued so strongly against this
signature scheme, preferring KP's scheme where the loader verified the
maps.  I'd be curious to hear the reason for the change of heart if
you can share it.  Regardless of the motivation for this change, I
obviously think this is a significant improvement over KP's signature
scheme which shipped in Linux v6.18.

I also think it is worth mentioning the similarities to work Blaise
did before the most recent Hornet version:

https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-bbos=
caccy@linux.microsoft.com/

While Blaise's patchset added to the UAPI, that was done simply to
retain compatibility with KP's signature scheme; your patchset does
without any UAPI additions, but loses compatibility with existing
signed lskels.  Beyond that, the basic signature scheme between
Blaise's patchset and what you are proposing appears the same ...
which is a good thing as far as I'm concerned.

--=20
paul-moore.com

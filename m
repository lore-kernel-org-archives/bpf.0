Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1A29B781
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488559; cv=pass; b=uO5sVUedDMwD0S6CpFp7972VqF1Vjw8tcwOHXUsQdFwJ6/ML/bqn8xF1Vh3wIuDCQsI4K7HMBpwIw+DnBosoPeB5oeQVorSnxrnuqzAhCpYtJPMm4gTxOFxlgaGM4XYyNOKCQLkETGGkMcRs9B2XOGygNxVGWrA8F3oweviNm10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488559; c=relaxed/simple;
	bh=oc33NITuMFr+/cdVCzGL0NIlaloKnncBOr2F7xyiq00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txZuhg2GTS1/PRcE69Ysn6ODzCLoGUQnmk1aKdi2TEyl4+duecLlhIoH4QaP8nyTYR3/7KId/2/6TgIQUBQzRhqea9jEmMXMQ6UxefDRgzx3MZxdF2AT8cKWvZ7KOAkLH2RWG+Efx6gIIT0A9eOKwqfarNTNAqzAsoLBghoW54s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys8eMSo0; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys8eMSo0"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66ce4a63e17so481541d50.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 19:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788488557; cv=none;
        d=google.com; s=arc-20260327;
        b=Enj9RdCSQQsdTSbUumDUJvJkDBUF/r1tJBysI8X03ch4n/YjiL5O7X1RiQN0xCVokg
         2CIRlbZrzL6t+Xd+RtCDG+Ldrtc93WIB8EIbRnIBLS3sZxR3acmFPL/PjZA84tvqghLY
         ySwtUtxbpanAHVGrbpraiHtMMtmWk6xG4McHOe9HjWosJ/FnsEw7gsaWovzOmDcfinhr
         LObLDSmzvgXKMYS2Z3VPvnRb9avMwokaJ/Rw6gIdwjPVVrZLxirCd0ZFJdLqC6QKHb3F
         yLwekRpBtNyQs49psorxERJq/7cX3vJClUyHw/DZZj+1cPaMNr/2KDzW7LJ7DeskXru3
         YGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oc33NITuMFr+/cdVCzGL0NIlaloKnncBOr2F7xyiq00=;
        fh=JOAf1fCbQNENxcc54IG7a7EqxYzGaatWbCVGuROy2dg=;
        b=T7VjyU+P17YqIJ4Der5zBdlz9GJTz9va5fhZcZVWMr1ibmUySwMDS7QE6GKL/wQdaw
         KdiaQgOFtpMCnuQ5/4LvqeotQokJDjZBKZookwtPR78zPuiQK88KdSuBuVnVQx+ctXP9
         o593DsFOhDRMws65zUWLDfNFVpS0yPpOWuRe3kvzu2hsGQOYCvUSEGVN+KiXCp9MuPZk
         eudPfiqp0c49Y660CUehovbvEti9O4rmReZ6vxlcd620/GQLSzsU6fLghbjMmda3wbA4
         JEXO+xaCLvumOjowN3D79juzK+xJ6YHvxM+lVJAVzF63VbWOzJViZypAgy9YJILsirOd
         Actg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788488557; x=1789093357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oc33NITuMFr+/cdVCzGL0NIlaloKnncBOr2F7xyiq00=;
        b=Ys8eMSo0njp164XKLUF+MBGvjZ/lVdjilTqAyBiF5Uem6RrpMzWts4s03xjg7DKfbq
         LP51MYZV1kEoYRUhZfDs79JtARpfj4au6Zz8LvtBqZ2ubmlBxB3b5kMNcGdtA0kb54J/
         XjGA4sPYAwP/h6a1aHkd7q+1Z3jvI7wOagbxpGcrVd5s4oZ8DtLGYzYxDvdd1Lg4Cwvo
         foA5CGaBau4oODU67BQtnMI52FMQtxpqQFAufEApijMcuXUg18HXQSNmrUe6h6YZ5MMu
         n+7Fya9qTM0PSuC/AFrIdP1SrXcsGFI2Q3NmkAAbgjqVQDLl4smI6oqfp7Ie5swYrSvf
         HBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788488557; x=1789093357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oc33NITuMFr+/cdVCzGL0NIlaloKnncBOr2F7xyiq00=;
        b=Ms+zMWwiYOE32j3MzGly4Ah4e9MLOKtIexs0Ld5pOQ8OdixxT+mzvwTUadA27+DyLS
         iLtdrNkSK6AwtnCEoHUGFzbQZZ4GJmnZa49qQ/fabTwlbwA+u3KA3dMhH7zvWt36BZX2
         5JAM3REMR4Ep5UjJWeOIaCSVkUJQklZqRuPlCL+az23CdXq42KFWxdhibY7Naga0hSOu
         pUeAwq8UTvWva9kw6qbLZZt/5v+cW3tlbwKqbeZWfIR6eWZkk6K5T/ceK8Eb0wgpWNdB
         5C4X2fDixwmTrO8PbFHfxPKbQWhDxbX8n1M47gNOoPE27i0hDm7uRE/4+b52KlugMYnP
         wGpQ==
X-Forwarded-Encrypted: i=1; AKwUvByr/lLr0kZHl6E72fL7gSz3CaejZrBRwkPkEkAOm/4WevDVZobfdhGYSmBdk4B0/1ira+s=@vger.kernel.org
X-Gm-Message-State: AFuF++kcmSGwRuTdnT9fBWUhYDit8PTfSN5KTj7t6NQdGMRfqyQ8QEkq
	QUQg2IuSag0ckF752qdeKUlKOMxze3NiwMz6VwGl88eGvJwzocC2KbtO3jXpfaGvijJ/+nZFQz4
	GCvVX4nvlhXX0GxhoZlugkCg9LD4IlbI=
X-Gm-Gg: AYBFou0BgzOPXIpBmZ7aNRDQlfIlVL3WRaedD8KbMpRKGlt1+5aWsO7bHo6sxKrfxmp
	DUeHoYOLshoh3HMHXTZUbvu6wZB2qQNXkbQFrbs4XUtu0tEa6Rad2V6e9za5R0h49lBzgzazfZb
	mMZsAu6l3TrbGANM3YLDLhDOetVmd9n5IHuVdwsyLphFMo6KKbG/6fTqcY8Eebb43YsA/qAY8W3
	zZUhvxkZ9/86WzjKpEr58T0fFuVuBz0eZFAo04hCmJBCF+oIddi6xvHDHzblCofuEA/2eVYvvZ7
	M9kPvDLopLgEiq+nwWI0d3aTOpqQDpwK9C+z+vhqCjy0UwTwdJFy4Mqx+EbuUHUkendihlH4l+v
	Wo562ltXrnnZdnLG7JRp0Rxu/mxkC
X-Received: by 2002:a05:690e:484c:b0:66e:44e4:436f with SMTP id
 956f58d0204a3-66fb592e358mr730170d50.14.1788488557299; Thu, 03 Sep 2026
 19:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903214758.2727663-1-memxor@gmail.com> <20260903214758.2727663-8-memxor@gmail.com>
 <aa58bed78ecad82b396abffbf512f66891c2e2d2.camel@gmail.com>
In-Reply-To: <aa58bed78ecad82b396abffbf512f66891c2e2d2.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Sep 2026 19:22:24 -0700
X-Gm-Features: AcwNN1Wgem9PhDjTlJlOUOK8VF_8ZopMrvHQBsCq0Ar3rPDJUo7ZMbA0qN8q3iQ
Message-ID: <CAADnVQJzp6TaxSS9L4JPs+BxKL-28fuJQP1s20mkvrJPsm4e9g@mail.gmail.com>
Subject: Re: [PATCH bpf v1 7/8] bpf: Reject legacy packet loads from callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Sashiko <sashiko-bot@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2026-09-03 at 23:47 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
> > Global functions are verified independently with a fresh frame zero, so
> > an active-frame check cannot identify a global function called from a
> > callback. Also check the complete subprogram call graph during stack-de=
pth
> > validation and reject a function containing a legacy load when any call=
er
> > is a callback. This covers global and static descendants without making
> > has_ld_abs transitive, preserving its per-function BTF return-type chec=
k.
> > Ordinary uses outside callbacks remain supported.
>
> I agree on a first part, but why is this part necessary?
> Return value from a global is modeled as an unknown scalar anyway,
> hence ld_{ind,abs} short-circuiting it to return 0 should be fine.
> Forgoing globals cuts this patch in half.

Better safe than sorry. Soon global progs might return more than scalars
and we'd need to remember to revit this.

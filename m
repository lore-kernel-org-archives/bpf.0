Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664C3876C7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165549; cv=pass; b=fEpxueAAp1kpS6eCO1TUOVsokdOi2QU7xrFeAO4yWpmA3knLgiwAR8LSCKGVMix2ogzspY2MTiyVMudVsitpTj3LWO5RLco9RtMq1SB0RBXzciX+B6xeEt46zN/xpVZ6NxRgr86+98E11r1rt2mp/NzVUWc7DgSGmkdnOBk8O/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165549; c=relaxed/simple;
	bh=mYA75vD/y5BsPTNsZ0nTgxVTPAUbKSUN7Gzb1lDOkMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mILzVZMATSTHe0rMQTa41YvU9uUmYKlPADMJ9illw+tZEhBih9zgRMvrZFd3eb9pwa9CeZrXDgBu6RBbENAx5q9dEJKq0dwFpx+I29vpHyNNNATxX8bfUGc+7/40m7gfss6Ml1SJ9ujEaym/Jr2boJmQDMOeNVukV0hkVcYQ5EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+yijFeO; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+yijFeO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so1215428f8f.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775165546; cv=none;
        d=google.com; s=arc-20240605;
        b=gAxkJobkAFLJ1/lmexwvkzJA7fu0MkWGA0IGP68vkEVJR5XC2I5IMbG4b+IkpLGyDD
         LbnRWhExPsOx8pZc8ujB8pRX1hbk56SlYpq9b1JYO01rFLN2HQSk9eb8hnKXoH50fc4W
         KosjeH/zVxi6nW3h8DSufC3Q5mkoqRzMgguf3V3bJHzcgejQQs1iiPWPwb7rvM1pk9eG
         wDK0aj6a3te2N/tT7nDVPuR5GTDFnPrCP6zCqrioDxUaL0R405QMJDnRvYC2cNL0LT2f
         S+t8CAFyrcDkGo836a3WFRogyazMfVlT2xYduSP21I156mokEjqWKSRHtyqIdxl/pO17
         0CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVy5Tbnei1eWt4wSZsX6hqdbPSYc1a+XqXRA3aol11A=;
        fh=nK1sKfOAOlKgx9LOXsQrEFK5C3aJSpECzQWLF+tENHY=;
        b=TJlbUS3LiyOiOqS7GzaN7mT3gH2S1dc0czuBaEZB6SrBZ+ofmc1dfHuD6f4+8bHSPD
         nuIGgGUXh6cPbaWNK8zcil/0gzWigLsMnmGrP0bKMajoxary0cLNKqNdes++lnt1MvVo
         qCo4tR7hqSha8+ynRhrrNHIAUjFWf/Fauq2m5LuUouQJTOK+7d+YdtdJxrw9zhFM8hTj
         CklrG39uYXL0Dy4GcHHIdNGUvIwKxe28JFiCRJqkQ1Hf5o8gnN8PRjBK9DGV7zLrruT7
         FsUMqHnIlZjDNe7ZhgXqtseiDqAe1UJcmZjeedSB4JAXMxZ3wXrD8CyqGdECxEYtb9cn
         vP/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165546; x=1775770346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVy5Tbnei1eWt4wSZsX6hqdbPSYc1a+XqXRA3aol11A=;
        b=g+yijFeOWar9sD7gjnwlODZiHW4/x5aTkbKUdUY1pljXmKaPAeVcm4ghwKIYx4JWJH
         MNhLVKTpPX/CWuO3NDrJrUeQ8FT8LC+HAG3Hc6qTkMBMRhJAlt5Ad/hErWTeWnw47mGP
         lYCKekz9EjWAFaner4cR4xvEzdACyNz0ovGRlp4zzS5anIeDTg6ujz7p6d0qfHxSv8yq
         Q0oinC7QpZ6QjYOtV4qrqmekS5+iEpRg3veO2HHLuQtsnFXW07mQJiR/lKFUx9HRw+oL
         np/58mBmoKnR4QXk9+rp0yEzc/3QjE9nk3dO5pNyUc65RdTuAuSZ41fSi+OFcF9utu2A
         H0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165546; x=1775770346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVy5Tbnei1eWt4wSZsX6hqdbPSYc1a+XqXRA3aol11A=;
        b=JBonzJotuLGmnvsdtd/iIyBio4zLllV1EeVN9LH0QWuVjgGfhFVH7non333s2SfDeT
         NaKgUOvOGzhwEPiRm4GN7O4de8NICZ3mCj+qzsYey9o3IbnJX96VOMehxkjViSzY37qu
         SNffYCg31/dYchLAII0yRwvyYZeZvUa1Pq/EuSCuWMi9+hl77XvDBrKwIlkNIPNlEW0C
         DCiOUF/MrL8D0xuCVRtN5P+A7NL4OrXWGRHKFJJ2QNGAnPpxf223rBYd0Bi/a1OEZwvy
         85sXnlRPD6iO88ikAtNJ+hqua5pI74qXxwal0tuhuo8aJXudAo8hqI1W0Ehac4dVp97O
         L1KQ==
X-Gm-Message-State: AOJu0YwRUqzqfeWT20ygaKsRe087T+N3fs0pnGnEvHhmZ3CmyIWhU+7Q
	BjTBagLSBTKFZ+VAKos87Mve9qf8MhLTaVap85rSvpp8y1+wbC/Ll1xrO2WDu/Itedx8zsmhqaZ
	xaAPYxRqDx6JceWHSLGGQq3fSgNiZwQQ=
X-Gm-Gg: AeBDiesxUO33Hg57esZCJDlWj9Ts0SPg72c18KG8c6BgEbxL10j1KIG2Paid4Ekrikc
	Nd6DjCOmsMumAWpMK+b6zASpwGvudVOWrL72Z6V59YjLkW6lfjCR49y1jgqVOJT0u2yNVzdkyhd
	z/LOQh3LZ42HV9UOQqHaMxuIAIFsBeDFAJ9RpI3/PXPqNAWLFF2P4oJ0LcGH311XrHt+pGCDMrA
	UOCiq6PSAJvOfPymvpufllII0mP362qfxWWWJAD5yNJ3lrdFH+jyhwWD+EQSgfPUEtEIjdg35WV
	/UCJ4PM9uX09WnkT36MHY3bHtT/eLCyTr+Jj2L4J3Vs6UgzF827UiL4Oz3xRjRQmdAPDoH3yuVb
	qAUIYUQyV4qP78s6WKR3/ztxplA==
X-Received: by 2002:a05:6000:2885:b0:43b:447a:11b8 with SMTP id
 ffacd0b85a97d-43d29269802mr917226f8f.6.1775165545717; Thu, 02 Apr 2026
 14:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com> <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
 <ac7XSg6AsJq99WvT@mail.gmail.com>
In-Reply-To: <ac7XSg6AsJq99WvT@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 14:32:14 -0700
X-Gm-Features: AQROBzCgMD9HpjNFt4GT75mR23p0LOTNkrYsUwb3bXZbzrIkUDHhkXuZd-FC_Zc
Message-ID: <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:44=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 11:38=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > > specify an offset inside the load instruction. This is a bug,
> > > because while the verifier ignores the field, JITs are not.
> > > So, patch the verifier to not ignore this field.
> >
> > This is too terse to understand.
> > In 2nd patch you're saying:
> >
> >    r1 =3D &map + offset1
> >    r1 +=3D offset2
> >    r1 =3D *(r1 + offset3)
> >    gotox r1
> >
> > Here offset3 is, normally, equal to zero; but this is not guaranteed.
> >
> > What is this 'offset3'? Where did it come from?
>
> The offset3 is the .off field of the BPF_LDX_MEM instruction.
> The BPF assembler will correctly work with non-zero offsets:
>
>     r1 =3D &map;
>     r1 =3D *(r1 + offset)
>
> > What do you mean JIT handles it?
>
> JIT will issue a memory load with this offset,
> but verifier will ignore it (before this patch).
>
> > can llvm ever generate such code?
> > if not, reject it early ?
>
> LLVM can generate code with non-zero offset in BPF_LDX_MEM,
> say, if one jumps to a structure field, like in `goto *p->j`

sorry, I still don't get it. What kind of syntax is that?
Could you share the godbolt link where llvm actually generates
such code? If the verifier will reject it anyway it's fine.
I just want to make sure we're fixing real problem.

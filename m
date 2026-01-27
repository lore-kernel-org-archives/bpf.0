Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168729D267
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480971; cv=pass; b=OhZpfai1XISWFKy7h7J2up/uAGlcHO5MXhnFgqhOpTLIxmJ3cqBGvoVcAkxO+ro16d0dEtYv17MiXFwh4As+coR+SPl4rvnZRTUAXFXzpV4dMd5q7wsTwifR3o1i1FfoJdKzxXfUXtunT1TcMsq6UgAfK1oNQ3sLrjAHKEKWeFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480971; c=relaxed/simple;
	bh=yPX2UxWW7N4/r7e8BpNoc0/2oNDWfidjBmr6JaklJzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9pBzzH8qQvKwiB+wLyeGWNcSstMCO+lteVjU1hDD5JQ/tZkK6sbJUzkiOltZcdReX4ewk78+J2ncYK1++/is67pxWSVKmIP/mpslf1+zZqZGREbyQZv2HiWekoA72Hd+1XFZaDuLUIKcXJmP+oPL1hsm+enWKcunqnnxdu8//8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK0bjd+C; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK0bjd+C"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359249bbacso3907659f8f.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 18:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769480967; cv=none;
        d=google.com; s=arc-20240605;
        b=Fhw6jc32Lu90kXPyN+T/7aSzHTJxKLBg4dfIGsadFUwqRacSjQqohs+WoK+IdkqohH
         N35IvsVE9joPsI6r4YpQ6FwLeqvHOX5J5BpBh9KBNRHgJpuAeYEDlOzhwGcKV4I+xXN1
         Y4iX3odNRb8rHqGwr5bD1slYKiJhoS4fOUi9Ym/1lYYzK0m7bhfKiaK375XDpAgogds4
         zDYZtXMaFNdlVGu6solDONix886oLfEjlGdebz2Hnf0MtJs8i04nhyQt5O8anpAo6jw3
         d+PlOen8v06ygeY6DroEH+7uAidqVfJ0XodHyVOqz0gZrGaqju8In6wdz8GUtgmGndHB
         ovWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zC2j0Jfkmlqo+I0JfCWbANnbTnMT3Wh8bohHZbF81zg=;
        fh=07BTDdF2UaNE6zhSlY+pZbr00r3LKHX33/cE/TDbpLs=;
        b=MXbmjXLj8nlTCyLEY+smEGW5sU/lXI66RxyJ7Bcnl0+urUcm0jKuHO7bn6YNWf9b5r
         yONxDBaVyY3LYQmQoZDWqvmRTrJOn5G9kYmS5rZi3Af7Y9No2PrhyNZ5wEI/zIn6PkQZ
         CK08Fm8us2AdcctIWD8VHMSVZzzy4os0U1olaNj5wziTvnKNuIfNSrKkPlKsYBA/YpRZ
         uuS9VzA5VPWXBkduxRii9m2rr4U7ZL8U7aXdzsHOXPZ+H1dWoso7DhsNrmlw0y0cqHhe
         pj5m2sU+2Rwb3g5FaqpsvojT55WzLcrtmRfD5Z7J7qiLhOUl2Ris89OuQuc/Xc1+b1Eu
         v8LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769480967; x=1770085767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC2j0Jfkmlqo+I0JfCWbANnbTnMT3Wh8bohHZbF81zg=;
        b=CK0bjd+C6XNjOsN/hYQ1T+8/RN5loGRzlOWLriQt9Gfvv5eVr1pv9c62wR6Hvq7JeH
         pYCKKC6S/lwuyYcAom6d9Jj/PR30T2bAcniUIqd6phSrPPw6kql1ILQ2u1zF8xNA2aVE
         yMCdFZTJV+nSRch8v+iE8kIgVL1gdx0zzKeBE36ZxB4y3B5/1QRo2OrBQeZ3OT3iOuNT
         DgJEZuxBMxRJmavAG6UuHRMW0Ow7KCXHnaPL5F2APGCgbu4hd9pUOgDqTk6TnpBYIdjV
         Qo+SLfnVZhKiTTP2Ue7d72kPJFSqnmECj6q+a1WiDIELRDlOq2UQANJu1PtOQRQNKyY8
         0nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480967; x=1770085767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zC2j0Jfkmlqo+I0JfCWbANnbTnMT3Wh8bohHZbF81zg=;
        b=QYBTZqt7eI69cC3JrjZnkSfR3cqsXtiWC3GYQAUObwm438EUO7uE+gdHsSZO3C5Mf1
         5wp3RQvU1JCj360eQtjlVh9V6G1LfEF9zmQv/sZRTjRcYOi4BaKW0mJ9tQq0SnJLaWKX
         FP6fOfBShbuw7dOwFb0loMxZcn1AXYJ7ktu+v1dvhRNavVgg2bumaJWQxqQFzDTMpPyE
         uriq1Zf+jNZjXGniViiIvfNw1wXtr5DvH6KdVtXteg3vMpcFYuFEJXm6pFuamExoz861
         divTsE6+OVinykeSU7un/8oXMlrfoMQvQBoO0FLiypbPDcraHznrKXOBZyDR263UaTol
         p1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrovhldGjwmFMJMako+O2gc/bkpwKCPv4VGYFDk1MIG9q9bY9y5KW16ePZ/S27xiKAi94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAUkj2mWs3ljO8xo1/pojUpI+ueocMQZaTX+hJQqqmBfoUt0y
	J6RIh3cJG0iPL35AUL6j2VyS21OAQR4Ve0MEfHx61BmP71UUYfXpwbE9jSvUpuhOErvXL5Zm5WA
	LavaM0eRefXpFLu0uIFhf8x06jruu5lU=
X-Gm-Gg: AZuq6aKHN7vBIv7aRUOZ+KHj3Jza9vKCTvrFQgb6ZmvT80nFPqNJ3GgE3F+phkgjGhB
	2iJU2SHta/m7ccfKuKUkUu3kbjL68FP5eJWwc9p2+JHaxCdKXl6+BkO51LNGKv2pVL5DoDEzp8o
	BNm2Dn1IlLKVO8RlB+EmPtGIivfapsxg/D66qt0eN9guOFdsW0x4AAEgIzM+EbZx26fP4S1MmC3
	XLlwA5TY4hYDyzLz2G/ow4Tn3qvWdg06F5wV5kZd5k9dhDUXRWTA3daCaAzU76IRDnnz2/3X3QP
	sbMI0xozIP++C9ab1DcxXkqaiEFU9zbGaMJH87OFPw2+FktRX5yoPZnIIajvE/Cdd7rvXsy9+N1
	kfVKZy1crHQwLtA==
X-Received: by 2002:a05:6000:2c0e:b0:435:9a50:bbc8 with SMTP id
 ffacd0b85a97d-435dd1f7abdmr108303f8f.18.1769480966854; Mon, 26 Jan 2026
 18:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126173431.19825-1-ggonnet.linux@gmail.com>
 <202601270903.NBB1BD47-lkp@intel.com> <CAADnVQJNvx34irz6JYbmZvmaYU0AGRDcu8znsKjA_di798RisA@mail.gmail.com>
In-Reply-To: <CAADnVQJNvx34irz6JYbmZvmaYU0AGRDcu8znsKjA_di798RisA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Jan 2026 18:29:15 -0800
X-Gm-Features: AZwV_QgGJ_z96uCfVOYhpG9WlUFldQomgN8ann-MUm7tE6c5sB77qAxilutzk7A
Message-ID: <CAADnVQ++Bx+xZ1jmeM6rLC7xeLHfsSUNizzMtw0=zOcPfLcc6g@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't given
To: kernel test robot <lkp@intel.com>
Cc: Guillaume GONNET <ggonnet.linux@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 6:11=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
>
> On Mon, Jan 26, 2026 at 5:57=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Guillaume,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on bpf-next/net]
> > [also build test ERROR on bpf/master linus/master v6.19-rc7 next-202601=
26]
> > [cannot apply to bpf-next/master]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-GONNET=
/bpf-fix-TCX-netkit-detach-permissions-when-prog-FD-isn-t-given/20260127-01=
3722
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.gi=
t net
> > patch link:    https://lore.kernel.org/r/20260126173431.19825-1-ggonnet=
.linux%40gmail.com
> > patch subject: [PATCH] bpf: fix TCX/netkit detach permissions when prog=
 FD isn't given
> > config: sh-defconfig (https://download.01.org/0day-ci/archive/20260127/=
202601270903.NBB1BD47-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 15.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20260127/202601270903.NBB1BD47-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601270903.NBB1BD47-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from include/net/tcx.h:7,
> >                     from net/core/dev.c:114:
> >    include/linux/bpf_mprog.h: In function 'bpf_mprog_detach_empty':
> > >> include/linux/bpf_mprog.h:348:24: error: implicit declaration of fun=
ction 'bpf_net_capable'; did you mean 'sk_net_capable'? [-Wimplicit-functio=
n-declaration]
> >      348 |                 return bpf_net_capable();
> >          |                        ^~~~~~~~~~~~~~~
> >          |                        sk_net_capable
> >
> >
> > vim +348 include/linux/bpf_mprog.h
> >
> >    343
> >    344  static inline bool bpf_mprog_detach_empty(enum bpf_prog_type ty=
pe)
> >    345  {
> >    346          switch (type) {
> >    347          case BPF_PROG_TYPE_SCHED_CLS:
> >  > 348                  return bpf_net_capable();
>

I dropped the patch from bpf-next.
Pls fix and resubmit.

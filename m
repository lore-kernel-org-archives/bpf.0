Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0AB2848BE
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551770; cv=pass; b=sHJTgd/m9HDZwsN65Ridiv2wQV7nDOV5H3GTwdYyWqJEqfmIEePMguapkUJKkB04yK8mw6KhGFC0ccvClTR2goNKC+60by3MK1X5w07HLK6IWF89v04Iu7F7FJtW4K9Y6SYefqBF1aOaZuAFi93+fO8mqitOGBqI3e1/xcwgVOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551770; c=relaxed/simple;
	bh=Jh+iMjgNyFQszMCiB1NQMMTdb4aDvjEfdudedfcNapA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvXNgkY8bD0Il3cvIKsLqTI7PGs4+op0EwyZGEWuST1LZ4h5cuR9cltfEnu2GHIm859mC5+Ybapc11waZv8UAH6QjndfrJDzyzt8aaR0ztCwI4xsagFktPoqiM4mLof9vlbLdTl1duCCk2nRQd/SwyxAGv03pBOSIam13PSGSEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOPo/yda; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOPo/yda"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-44e5624c053so2756670f8f.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778551768; cv=none;
        d=google.com; s=arc-20240605;
        b=Q1FohQzaQfGtLI/8qajc2K9se+YCicvtvih0qdj2fF3s6Ah3bo28kAzkrDl6Bbu62F
         zpQzEyWtBTkjRRid4PGS+nSEJKkwjgfT6Qj0k9KEP9FZqeuJqyyrr2EIt2eZWlTmjNpy
         PqiQLxE7UwfkNqHk+Ps4QBT2qLsG56pfwjIiCYSUsNPGqOEgEw36i27wVTEauIS6+Iip
         2Qfpj4Dr9ncEtiFstp/aquFor1sG4WsFDJDTHdUqLKUBaiURgcJ7/eNSOB++ZCoIey44
         pxOlIlm/DPnRPuwxJ/nVJu45hrAHejXnxtpJvwVYJB1cJsEJ9cr/eLqdU/AqHkHVv3qj
         Bvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jh+iMjgNyFQszMCiB1NQMMTdb4aDvjEfdudedfcNapA=;
        fh=elYI+dO/+553aA8100eD1YWe7o1cTAg190mW5IAm5k8=;
        b=T3R6DfnOph1yjL4NiD8d2vqFu7rTvJZmu4VQeCaGBt4oGoJO2caWlvhBeoY5oAzmrk
         JzmlhzI6ETzFIAoOV91SU5JhNnMsDHVFKPIqZ4YYwwLV0OyRUVYa25GkHZRD1yPFRBIz
         AX6XodxaQo7YhrdCBvOZbDoTH8JzHkgo9As8QtnBdm2k3VrzP4Jxhgn3kz3L/w5bKyI5
         g7ydmQXO104QEUoOjY+LdQ4uRs9H+/WGLaf2AmfK+ZAgYOMn1wEk2b8BEh5bhWy6T+ij
         5873bhY8DZyh++deCu1/bZ1epbDh03b590Tx/YwFB+H68N8sZ6Uf5mpla4gILzMDGO4T
         YC5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551768; x=1779156568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh+iMjgNyFQszMCiB1NQMMTdb4aDvjEfdudedfcNapA=;
        b=fOPo/ydaidiTgB4nixNlNKiMn8TQUJQFSR8RbdRhtqd3xFMIhi5wx6loVIXnmmDcsb
         htXeU42IOiIdzk3Atr2T0oFklYozHquYjBrhtgjZA6CDuHwT8z+I37bYCvFRl2y2ES2j
         Wv8/2+dFt3mACqg3bT4d2uWk0HXZd5e1H6tuvDZbSeJGi/W6EXitRsKPl44fLVV7Y5Nj
         OQ43uWj8yU2PYFN8MbEzNvBhGvmA2RVeglM8c+10xTyyNQFi7zuirkCmzOXJVZvx9Jb0
         a92MEEUWgx5o5sFNzmiPVOqCNEz7Wt+Vk9Sj9TrcJWKygrq+bGH0tjy/hDG9fRam0AUw
         jqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551768; x=1779156568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh+iMjgNyFQszMCiB1NQMMTdb4aDvjEfdudedfcNapA=;
        b=MqLQRAmUmLmJNNrnziqTmtJIpKgcJQhtcJeHwg0aP2RAi12/s3gIa6FhM45JRyE9yh
         jBRoyYGf/2i1iCIGqC/Z8m58FI2/UMeBFFstu9NL4X/h4j1NgnpUHRAbpHr2gwb1O+Mq
         UIZSt6dbBjKZCl7Ia1NqOASMiRcyXPoc5gwgfOxYtPR4lcZFmVOx9uqZKKJ18vCypAiZ
         43EpvPRaxSoZnxjjZmgElg7OtVIDqUUXt5S3hMvq9kHw3dy49g56Ff7miSuqf/KdjHVK
         8P5l56CflNBMxdI2og9qTj/2DJs+uD86baC7PuGJ3is6rtneSrhdrQy3XMhAE67idyLv
         8Zyg==
X-Forwarded-Encrypted: i=1; AFNElJ89bMJpINnEX+TYtawhBnh+IeW8La5GbMd6NCn8g4lBeNWNytQxwiHWn7kV0Dgt+L21yao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqmt4B1uIJ/Gb5fprTava27Gqi7zRYJLF8r7CUtnD9i1uKD9v
	Iu32IiXFP0cr6Q97eFUaNQnHaYrCL7yFrr99PsjEuN8sLtYRVns47GrFaEwzuV33NmTauEI+4xB
	WkrATjOZ8gHAeKlYhdQhnsJ8+01+yGNg=
X-Gm-Gg: Acq92OHUCnN5ZufK+/JRp9654sHQhBkMy6c/uLPablmvHpxdNXly85cLlKEtsKga4Nr
	H6Ey3Q3zNfd+xmAgUAmv/7U5oqhZmS90rODY2HVLo1LOGo3ncd4UKsXx5vWUPlP2RAS4uZ6ahj8
	4M1uO/1wjfMJCbdqhZWpettgqU+qpSspqzk6dfHZnkBCCj1gXCS6KhhtjrnvbzV6t21yq3qv6UQ
	IpY8r+4UkwUOM9mD1QaHETapcz6FhibfMTKN+XCLDL8YT0Ny9oEwsVzN70E4yztxH416wVd3ikF
	9qadSVCJatmgOzF8plgOOe91gHF3c6H+xDtaLt7+moW7Un4LbMra1IFzlH/4cg81VPfVnRaudJ1
	69t0pqQU1p2vFrEgM3y0n/aQJi9TDySXeXB4et4JMlzFhOITIHytrSiELO8EiTm4q6tU=
X-Received: by 2002:a05:6000:200f:b0:43d:7275:c1ec with SMTP id
 ffacd0b85a97d-4515dc80c49mr40689298f8f.40.1778551767666; Mon, 11 May 2026
 19:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agCXEJKJh-JGMhjG@zenbox> <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox> <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo> <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
 <agKBE4Ci4_LmJ1Dc@zenbox> <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>
 <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com> <agKJzaG6U9-XppgE@zenbox>
In-Reply-To: <agKJzaG6U9-XppgE@zenbox>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 04:08:51 +0200
X-Gm-Features: AVHnY4LdMq09AYWTdREsN1g0HNk1L-NmIPCvlLrhaBtburmlHA4cpo0l3Pqz9yM
Message-ID: <CAP01T744a+hHqS83jC=eh_kwR1jCqdak=tjAEeQob0N3L4YMsA@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 04:07, Justin Suess <utilityemal77@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 06:55:50PM -0700, Alexei Starovoitov wrote:
> > On Mon May 11, 2026 at 6:46 PM PDT, Kumar Kartikeya Dwivedi wrote:
> > > On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> wrote:
> > >>
> > >> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
> > >> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
> > >> > <alexei.starovoitov@gmail.com> wrote:
> > > There is no deferral here. I'm saying that we just cancel for timer,
> > > wq, task work, and leave other fields as is. So we don't have active
> > > work pending for async items.
> > >
> > > So as long as the item keeps getting recycled in the allocator, we
> > > don't free these fields. Once the memalloc is destroyed, the dtor runs
> > > in a known safe context where we can assume bpf_obj_free_fields won't
> > > deadlock or run into any problems.
> >
> > So the plan is to do
> > if (in_nmi()) && case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
> > just ignore it?
> > And no other changes anywhere at all?
> >
> > That would be too good to be true :)
> I guess the last question I have is what would prevent an xchg() out of
> a map on a recycled kptr from causing a UAF?

xchg() is atomic, so either a program now has the value, or the map
has it. Whoever has it will end up freeing it.
If the program has it then the program frees it. I don't see why there
would be a UAF.

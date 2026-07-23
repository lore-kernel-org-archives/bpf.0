Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E839CCE5
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829483; cv=none; b=GpqDThh9l5qGEuTDt4jtiNekP2wOxGncILhqGWCdklWEwu+P4Uah+4MAmaafUc4wfA3JUnMFLIZ2HGbrtsLvkf5p2M/12RiHT2+stz/eO3Jb5N2MMAnK50csLCZ9/HIWopivrhaEhxqV+Qdb63OzTUEp8xOBKfPtA/lxlwTH5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829483; c=relaxed/simple;
	bh=uhSaHoLoNEt+88qNE9tlgwbWDNke6X5OxSpVGKX1ccs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MN1pDOV89N20tTqtx9brHkBFejQqjyb7De7f/EDkx3T2+BsmpxcyAVqAM2jEd3ffhzxHBasAqKdUnBYn+0Mxs3JLQjEH99QA2eEbKZ7oTfHWVaqsxtvtebVHNwGXAilG3SPtXuvie1PrQQfZaYI7Xw4SZyenmsArJYyHeYe8Nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQfHPoeU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQfHPoeU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so886161a91.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829480; x=1785434280; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RyhZL1WSIhCm6HgTN87jBbUJ2Vt3tknSGNAZ68PW66g=;
        b=JQfHPoeUYOt2CFt7bVfp7u1IggAurZ4l0B5QdoN61uPUGCnc4FAb/KFPx7bbDqwiJt
         6Ed/Pbx8okaIRMcjXiC6/Ue5YP2G1v8uM/BZo+dIilYK51ZTeT3NR8oxuIholwMpkpCs
         K/yHbpfJCWyHEm4Je21dlHT1zu1pImOK7vPv0F2Npr3q8jfHNljiZN2FC1gTa5/KIfk/
         1VCv8srYyfn5iI7momEDUq26Khqma6tmuPMb7NetH+vWxvSOFG1L5G8Ik2DI3Zw3xxMZ
         Eco9XsFtckkR1qt0e8CHnKknBejtsT4+VfI8RC7+X9oYOp3l0sMSvEfMaj3/dhW2odIy
         DZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829480; x=1785434280;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyhZL1WSIhCm6HgTN87jBbUJ2Vt3tknSGNAZ68PW66g=;
        b=aWscT2ERgAS2ujHpr0DRnb8mfGei9uqE49DHZQtgyIESqbuBU0HXiMiEgixTuhmGYY
         ianmlM7SoolmUEZoLvhitcCP+cFu1epyVaEz3AMKYpDsHFDLwkvNuyDjC1zI/BXq3y7u
         HTQm38ezg7844I9cQeu4KA6Tc8k2DQ2/IklcCfOi5N8PaWVOPMVH5rQI1zWruuM6XUMe
         awVhzCzJq5bhhO8TG9VK9YXdX/uT+HMgs1nJmeTr/OX1eKhGSUSLcD1NIAptN5E7Ngx/
         ZRgkcg/8Do965c830MtfD3SO9RRolykTdmBaWcXdSh4i1DJ0reoA31iN+KOCUrRll10w
         ZMkw==
X-Forwarded-Encrypted: i=1; AHgh+RoLFNo8hT70CccbyPN6oDfxWzvzpVPLN8amHfXFORHrHXbMtGBDuPd+HP3LdMP2kVczwvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHley2xZQbJXJmh7B8E/G9pBJHJ+cTEQGDIy9Gl0HGo+bAs5d
	RAEU2oGtBPEbjOBeiBw87dtg+XpHpyNX14KfEpKNAYXce5grfgvOQlEL
X-Gm-Gg: AR+sD12AyCfPFd7Gx7zvGlsKJX96nK/d0D4SDf58RS+20+sZHsifElny/vtvEpo5UBJ
	K/EUSs7uX808dwJAv7sTzQ32j1VhGOqIgilyiM2P3xETZsOgEOnAQXte67BtoBB7nM90QSjvo0M
	VXH9KJUHTR6OLJhDRXDuEsPptvCWmThT+pAA9nP8t+vmCk/KWGI/BhDOemLqVv7lkuCC2sCcE3q
	Yg9BeERsQGmQzPAhfcTvktEcZXprG0R3zghybZPI5L3aWItBSuuRhmRGD5kydlovzJnjSCbdXu9
	z1hBkGyeebySM5pEWMIewJLeUw4VLV/sAuUQfvh44udng1r5f68ReuQ+sm6BYCXYbYXrzZw/QpH
	ksU1chZAKb+4BfGY9YgWVuB230DAExNXDcoUf8TQbkxITV6nhibOCE197C38opHwJ1WQSbnxftr
	srtUENOl8nx2+zji+pn6OfvbtGhv9yoGkdBKxRsCn6yoPDqg0E7gKUK8jc16k=
X-Received: by 2002:a17:90a:c890:b0:38e:dc4:3fbb with SMTP id 98e67ed59e1d1-38ec68982femr3801803a91.43.1784829480429;
        Thu, 23 Jul 2026 10:58:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c221:d012:6e37:77f9? ([2620:10d:c090:500::2:8dac])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm18568791c88.4.2026.07.23.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:57:59 -0700 (PDT)
Message-ID: <22df73ce6c09065672d3a9406ae59c2cb264f96c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for
 commuted arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Yiyang Chen
	 <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend	
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa	
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 10:57:56 -0700
In-Reply-To: <c5c2dba26e217763c73c237daa6d8639043f5207.camel@gmail.com>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
		 <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
		 <amGUjFu1MN__jM4c@u94a>
	 <c5c2dba26e217763c73c237daa6d8639043f5207.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 10:35 -0700, Eduard Zingerman wrote:
> On Thu, 2026-07-23 at 12:25 +0800, Shung-Hsi Yu wrote:
>=20
> ...
>=20
> > The sole purpose of having orig_off_reg seem to be for satisfying the
> > 'off_reg =3D=3D dst_reg' conditional in sanitize_err(). If that's the c=
ase,
> > maybe it is better to change sanitize_err to accept an ptr_is_dst_reg
> > argument too.
> >=20
> > And given now that we are starting to make more use of scratch register
> > states, it seems better to get rid the likes of 'off_reg =3D=3D dst_reg=
' all
> > together, and simply have ptr_is_dst_reg passed down by
> > adjust_scalar_min_max_vals().
> >=20
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 52be0a118cce..72d49f2a57a3 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13505,13 +13505,13 @@ static int sanitize_ptr_alu(struct bpf_verifi=
er_env *env,
> >  			    const struct bpf_reg_state *off_reg,
> >  			    struct bpf_reg_state *dst_reg,
> >  			    struct bpf_sanitize_info *info,
> > -			    const bool commit_window)
> > +			    const bool commit_window,
> > +			    const bool ptr_is_dst_reg)
>=20
> That's a bit invasive. I think the simplest thing to do is to drop
> off_reg and dst_reg parameters from sanitize_err() and re-derive the
> information about which one is a pointer.

Scratch that, dst type is gone when sanitize_err() called.

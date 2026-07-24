Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E60372662
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862333; cv=none; b=u8w5DFlp0qomupMgP6/62Y1vGww37Av3QqoEXQsLe34M4GHA+aPxWduIEZjICzoNzEYlaTiOrnrNN+KGUBSelnZ5f3k2nMm+DY21gzHiYu1hjLFG8f6lVPeT6oPoIJ1y1SlZp3ybi/nzATebWkVhI4OzZKA9adMaGITE70tqq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862333; c=relaxed/simple;
	bh=cRMYG/X4KbTYbEkrDkF5vJoRcZP3moe02DkXb+7WLrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDOI6wBP6W5Qki5TLjnYoWlmdfDoxV9c9j2sUfbOAX+VXaiKMaZh3CTUCofGwCahxkA6cubknFjO1wXvvRr5f71t8sReYIdkjbZ3PbV+EGFwehAv9Q76+4B4XIhROt/vEN2ruAgezxDX+5mesFcvKaPgmwOpY+mjKlTgXwmugDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zt/zGpoz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zt/zGpoz"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1592217a12.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784862330; x=1785467130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YkgPqMzAP2ofbMJqGwKnF617Gb9fXhy5NfbpimZP8p0=;
        b=Zt/zGpozCJ810tz+dqs8wujvG3xOrDortXUplZ3rnjfqWPWCJaPHdgYzw9384oErbi
         nN0/Sq3RFmtn0OisZGpgk1lXa8pQU+HU2sTJn19qE/CAYxhEl3fITNUS4rstucwjny98
         ifuDVjAAHxQ0NCBbBdjvJXe9GxHznMMqi29Kivx3dAlN7lxLv2XJjRzYNBGXTaDynPxg
         2G8JDTK1bK/B3X79ZwwVv+WVSjLg9CHyGXLTLrTBBjKJZgrZ9/71G7NoWlI4NHj/fwd+
         gcfbaSx3unyX1/by51CY9yCVReI6VAc5UnOCMvJyrrKl6rd2K2GBlEzYQtvfmD6wFLlV
         61lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784862330; x=1785467130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkgPqMzAP2ofbMJqGwKnF617Gb9fXhy5NfbpimZP8p0=;
        b=atha1dwW2F92QatVR5ZDtF4j6Y1xYlujCcYL/30oUGTSJuFxnWkR//4LTCQMuludCe
         TfcykU4vZaQWRK5h6qNcmslOUpC6Lc/V0KwmscGcMZ4wCtRW2Uc/e5dVyWx7amgvLLLC
         kW0XGLcCCIUQBhnBLeRsgl6d2NzX6H4Yx96Ly04gR4SX8l5RCs5N4NLYR0vPiR3gtkeV
         WJrNdoH3lQ9gQltQGLxTEmriBcpefWkruG1ALt5igJFZ/PMCt8awb/AKCmZuwuCIVnK8
         2TLfv/7sv+9PkhEw/PmiDch2Kmg/bhjGxVeMn1Oba8bOADlZPZIhs+Duev54jLJofw5A
         uD+A==
X-Forwarded-Encrypted: i=1; AHgh+RoFG/HXC7S2jiIL2k+ny7stXRjGf9mahWrRWf5AFQZSTcm1VOmHZngUc0O5CIqhO/F6RXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETcULSl+rRqjUsDaRtD9iTVWRr0jQXdquOvOf3wwfH4R5eEOh
	Ny5fCxyWkqt9xGOGEngqjANdfRXcWOn398QATiTXYEpHmw07IBJoBdMmKpgbSC/Vwlo=
X-Gm-Gg: AR+sD12Lc5i2PagrzHP5a8/b3lbxzycXh70CLIKasRsXxM46wuica/koB6/5wTLKbfO
	ZuXbc75AC1AIK+8tdDju5NIHXH5oFpj+z5lzrQy9IhADgI2QLAUToGzoa6Ds3/atPybyKHmwsps
	2BKHguD4gDkEUqT2LW46nRizW8weIzEjgaNsqJgy3HAOJAZr/10P//C++/EWARXJisUoQI3CxDa
	eDoX0rc821m2uiPnzp+HEFZch4GKUkE068ExsWWtRrPooRUFcux84ghA6y0MTs1R5o3p9mAqIYf
	suB6ZjW82YdCQ/0HtYswt+JvPxTxW88+9sod/2OcetIq+KEvLfEGLNII7HoPKBJ/NnMbZR2pn9v
	SF2u63fZeV8/XTgW9B/GPRVZLxz39EK/jYVbBw3BpGfq3xfR4jjyMrIhCFgjoCg6B3n7eEd2Gb0
	sN8TxsJyVIpcgJkfOw6xctKEcFuQHouCdAATU=
X-Received: by 2002:a17:906:9f84:b0:c08:59dd:3fea with SMTP id a640c23a62f3a-c1c50bee0b9mr277617166b.27.1784862330234;
        Thu, 23 Jul 2026 20:05:30 -0700 (PDT)
Received: from u94a (27-53-160-227.adsl.fetnet.net. [27.53.160.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f31f14csm42880555ad.63.2026.07.23.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:05:28 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:05:18 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for commuted
 arithmetic
Message-ID: <amLScROuY5oleavT@u94a>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
 <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
 <04c2eab092885ed738fc87f2db344bca1319a90b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c2eab092885ed738fc87f2db344bca1319a90b.camel@gmail.com>

On Thu, Jul 23, 2026 at 02:07:20PM -0700, Eduard Zingerman wrote:
> On Wed, 2026-07-22 at 05:27 +0000, Yiyang Chen wrote:
> > When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
> > destination register inherits the pointer state from the source pointer.
> > Copying only selected fields is fragile because pointer provenance is
> > tracked by several bpf_reg_state fields.
> > 
> > Use verifier-env scratch storage to preserve the scalar operand while
> > replacing the destination with the full pointer state. This preserves the
> > frame number for PTR_TO_STACK registers and keeps parent identity fields
> > consistent.
> > 
> > Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
> > Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> > ---
> >
> >  kernel/bpf/verifier.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 52be0a118cce0..085cbd5222737 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13726,11 +13726,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> 
> Yiyang,
> 
> I noticed there there is a temporary 'off' reg allocated on stack by
> the caller of this function. So, let's reuse it, ...

'off_reg' perhaps?

+1

> and also adjust the
> sanitize_err signature to minimize changes.
>
> Could you please re-spin using the attached patches?
> 
> Shung-Hsi, wdyt?

Refactoring LGTM. Feels like the alias check 'dst_reg != ptr_reg' would
still bite us later, but perhaps that something for another time.

...

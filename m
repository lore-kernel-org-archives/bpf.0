Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D293F65EA
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875081; cv=none; b=sObtaYNJTRe/73bWbsEbgKqiHbb1BxAXXl332Q6JOPt2L6qpCh7lnjGy1SGga2SfuSm/Y0BEIPkb1UchssjSzvBSJ/3KljfkJDjvYXwjaBGW/8srfw9sHaTsEWPZ2ySgz6kxduwNp856eVOU3I5nZRFZgsMbfBHpDebdQNEGBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875081; c=relaxed/simple;
	bh=TFtUI7X5rMkCcqj2wjxxpXXGLNUTWXWHbCt2vucDWGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kko5IeLFuO7DSslIz/sVgux5Cxsi8k1qBreg4NS5gejP9hJXonN9gXhssYyWNfjUrdK+oC7dlNSl+HDaSi29v5FsFTQCutaYJVOf04lbCvW5CnU8VNfxZBMXUzdHOxnj5ZsY2Fi+oU1uiPdXFIQnLKlTpkH++SEDXQgCwWPO0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLuKIYQ3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLuKIYQ3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc61541f8cso17591385ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875072; x=1786479872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TFtUI7X5rMkCcqj2wjxxpXXGLNUTWXWHbCt2vucDWGw=;
        b=RLuKIYQ3z58XIs5Rhg20kiDb3L+3pctPsBR4+YCEx9BrvnQhHSn6wTXvH9waQqAYLJ
         ncPZvbTDo8Zne58+PUySKe//kDE2/JUk5mcgsmAa9PTWWR1CsfQtYSvcWvT7SmVkYlJy
         87twhkzcd1z40pQ5HI4FaIKTGlrDgNnig50RuLQwsl/nS/2fU3+hfBk5Tr19KT679nO3
         Abf+JC2YH29nlQIwLb0qIR5QR1P0nfuptL7+5um7apD2MAngn0vhzsZ8Izkr7uccsrh9
         bWi+bz33rDlxayrcWX6KlOxhCzh4KAlrFMYe25xgdvGGuhgdp68XrAPEYGMskg56tCcN
         VO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875072; x=1786479872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFtUI7X5rMkCcqj2wjxxpXXGLNUTWXWHbCt2vucDWGw=;
        b=hD8ovM/sS/ERc4rQXoZTjRI3ZcbQzGYK6Gfi6tcqC0gqZvmfv/qY8CUENC7UeXe6TH
         +mSh08GawBdzwSuyGjvK+0GY9mkF5TnlhXyE6SuGb0XC4g6XhLnSKK1U5rL5x38sbzUk
         GTTEcqUjWrotWDwzcqXP5AIRKIOLLKOHry5HaLBUXlH3MrhNczl8hTAbtU4vxZVNMv7d
         uixlokHEH7chVT1R6tLwL1ErvoEOVBqQ9B3fByFJN2sJeco0OJl0aDUrGx+qkHHHt3MX
         9BkW0kH3SkmlZ/0k8nf+io4ZREFvZBJ1Uib+/VP9qoToqvFVhqSIhQITXncBIJ267+e7
         cEoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXgONAd2Szgi4EpKNd0NXV2faxXyBS8itNDUlolJLLeosBVFZO/0BOnZzs6KVB8dfzE9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55nJ1GHACGd+XYFofMsRrp3EQU/Of4EZXsU/nUX4nCJjH9/r3
	GKok/c4TO1XL3h7lNBASCc2Wn8FSa28Af5kgn/f+/Mw9M+rjWWJnUepL
X-Gm-Gg: AR+sD12Nv8v/Qg5d3oOmWjyaNph7fupPcYs3QjEs/G9hnJi8eJUXMjB5hSo9tsXVUjK
	LQ0djiE8L44st3tBwaN3KWx8Du3g993uVAsRPPqWwGDX93W4PjRAPcggBPODBFgZP75+Z7tviPt
	PVYzLm/oWQv4Xao7xKsCPb6rrIowegf5jxGcEX0n7f4CVASJmm01qdS4ddQGdP4Zq3VXm4n0WVX
	uTN7ZISVUcAC87y7rWEHl3YITYsyu61CwsHfMVm14XBohJnaX8xZR0zdc0fBMXAAGMa40iMVZyb
	HEVMXLdtKheIsAY2TAs5XEthwe6b7vgAsWBd4v14yQ/nXVDwHf3REL/pKQZ368BIIUDQstsa6Nm
	FAG+woROfRldIJvxxXKW3m0uQu6PPvH1qtlctJPt0CdbnngihlxU969tfr4vD9dhNkwCiBIskCR
	X2vcSBVOWYaVPF+DKQVVLML4feRGP7yGXQ3IAcsajAWo64obqAImwQyQDN3y2KWwDL/yF23A9ET
	U5gVOOUpyUgDxMAm3bo4YsQp0A=
X-Received: by 2002:a17:902:e5cf:b0:2c9:d8c5:d55d with SMTP id d9443c01a7336-2d0c9b48c3amr7707345ad.16.1785875072502;
        Tue, 04 Aug 2026 13:24:32 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b6c66sm12992155ad.55.2026.08.04.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:24:32 -0700 (PDT)
Message-ID: <4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 13:24:28 -0700
In-Reply-To: <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-6-memxor@gmail.com>
	 <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
	 <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 22:14 +0200, Kumar Kartikeya Dwivedi wrote:

...

> > Which leads to several conclusions:
> > - We should reach a consensus regarding KF_ARENA* usage, as these
> > =C2=A0 kfuncs would clearly benefit from having __arena annotations on
> > =C2=A0 parameters (on the BPF side, on the host side these should be
> > =C2=A0 declared as plain pointers).
>=20
> Yes, but even if we do, for the time begin, we won't have support for
> automatically emitting it until resolve_btfids changes are done. That sai=
d, I
> can manually add the annotation for now.

We can fast-track resolve_btfids.

> > - In patch #1, it appears that there is no need to allow PTR_TO_ARENA
> > =C2=A0 for parameters passed to such a function. At-least I don't see a=
 C
> > =C2=A0 code not involving manual casts that would require such support.
>=20
> This one I don't understand. Why wouldn't we get PTR_TO_ARENA typed param=
ters as
> arguments?

`(u64 *)val` is translated as an address space cast instruction.
This instruction yields PTR_TO_ARENA. Except for explicit casts,
how else can you pass PTR_TO_ARENA to such a function?

...

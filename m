Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12773E9F69
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911217; cv=none; b=anqlk6Je49E9ezBct1aQVfhj4q58JGJ9c9exrDAw6WIk4swkDXwxNl3WcM5O3L6jplQkGgSdzrq/on/nVL2PCSzLG3EXhTxb87bywOqxLv6JdaFQ4GO+h3u743ZP/a4HvOuFIjDoFsa5dLwVXgzo1zhIQEWNuu5i5BH+HdU1eK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911217; c=relaxed/simple;
	bh=hxOMQsXhpEEGd+ez4Ulw8IauP4V/YC23p/Wwz9RreZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9UhVhKQe5hEKunxovPNprMaea0r2gKbYUij7FcOHJgl6lzon6PHjXDJ9VY9mPTiinIWbb7uWXpoe+VdqPBMdvfLjmfbIm7hmY2grhB64FO3XOwv3O1JoZ1MbDnTnJ4XLJdF8GM0WQwxfOB/ORUKC8tvhkaQy/e2B7/3T3MuQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jddQb4W1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jddQb4W1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0c8362d93so28699835ad.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774911208; x=1775516008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxOMQsXhpEEGd+ez4Ulw8IauP4V/YC23p/Wwz9RreZ4=;
        b=jddQb4W1pX82cqRkYtJDNVe9d4wLnvPWBipFFwS63l4eEZpwAt1Rr/Kn8rHeXn0HBA
         jtO7gkMKTHzL8GLjYGfWsUP+JWy0At8LiFjQNJxEY6BXx6OBhH+QcLNvAHPzln2jE548
         bILkIC/kGjdwlFTi/setC3th2Ib2ftJMp0FofYYYMvbpr8NRgMxThQTY3k3r/2Y9USOw
         3IKIsq+df9UAe2xdlqw/KaZ0G/gs2h/1tULWvX0r50sh2bMSbRmptsusMpp3PA7BIMSa
         TmD385IRITaNVh+zPmozwkICBd5mwiQDoiPQEaQA7ktkmZr+UeIxIDAgq0J9N3D+t1H6
         3lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911208; x=1775516008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxOMQsXhpEEGd+ez4Ulw8IauP4V/YC23p/Wwz9RreZ4=;
        b=STYYeWSEYgTaOnNV3ieGa7sTsEBAuqJT0nfbjMD7vrav9M2SqVdNxfLB+H/I22S5aU
         4NmiEGzqlTZU3fd3UIYvoUGphhIrGa3WE4VSFd/o72ZoL1oXXeViXq9zPentEMgUdDbH
         mu3XjyjQCTfEp+GhVlgbEyAM+jhcc/VPv4+PhQuM0mUIKHVm74OZqofXEN8d64sR2zYP
         gSsCnMHliDTvBfwdbjxwxVJGbCWgCZHeJKSb+Inkc3uziigR41U1YJSrIUJnxV4NMM7f
         xComrMGTk7+/zHxoQGwhubHsS6JesAOFQT03OXcxJccGnjHECJaqAT4kZ+VtlwY79/X+
         oi9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/b0b4zA/CR5sF5PT9YOtpAQmpyrxkAN+yUXH5k8cT1djQ9hGIbixAdYgu864Nbu+hM7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZY7namvNg+YgU+kF6jBenc3tCLn3uFYs3D7qDOZLGk7qSGDr
	PaLKlXHttsd72IrKouCpUCPm8r7cGNw77OxhGa8uOgEEmCIzicIFOefN
X-Gm-Gg: ATEYQzy917E5xFq70pGJExvMU6Sm2Z9cjv0qlPMqdEOo9K38jPP8DatL7HjTPv1gdBI
	bXFlGcLXG6qLrsO1XWjRvtf5TAD0f8THnw33DbnfqHQ0qXQTXHtzCdr1YQl/AeCs0r9OLQMbuau
	Cd/KKazVyZ6+RCqIc7jUbUlOevh/1aQnjMDv6keOnUxQXoXZeNKYu1f/RiXQdKCi9ibo9y+XTfW
	AehCV1xxoRgroUGe8zu1HeUX1tv9C0KyHerDEGjtAZrsJd+RLo3oDgj7hoR+VgYZydGbI3uEfrY
	hwjgEAhRIqtNuQh1V0XokoosU8WT0yL+Sz9HOcSSRH7Q3wMtNAr1pPnXIXRQ8B06/D32AwgtNyW
	xtZmZt16ATS4H13063anC4xN5d7pGQh66GCPECJMUf+In80FCjDgl53ndFtgbntjG/Kh9jyWPbZ
	DLEDVY2oGktdzyYhYjhaZo0bApHFeopf9xkYipCi0SZCNGg5JjEK4=
X-Received: by 2002:a17:902:e54f:b0:2b0:6df2:8cd2 with SMTP id d9443c01a7336-2b0cdc239a3mr145683505ad.19.1774911208307;
        Mon, 30 Mar 2026 15:53:28 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242795195sm94027615ad.61.2026.03.30.15.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:53:28 -0700 (PDT)
Message-ID: <18e46696629a86bb59d8d67b07eebe3e40f177a3.camel@gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, 	andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Date: Mon, 30 Mar 2026 15:53:25 -0700
In-Reply-To: <m2a4vppc78.fsf@kernel.org>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
	 <m2a4vppc78.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-30 at 16:30 +0100, Puranjay Mohan wrote:
> Eduard Zingerman <eddyz87@gmail.com> writes:
>=20
> > Impose global ordering for all decl tags used by test_loader.c based
> > tests (__success, __failure, __msg, etc):
> > - change every tag to expand as
> > =C2=A0 __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> > - change parse_test_spec() to collect all decl tags before
> > =C2=A0 processing and sort them using strverscmp().
> >=20
> > The ordering is necessary for gcc-bpf.
> > Neither GCC nor the C standard defines the order in which function
> > attributes are consumed. While Clang tends to preserve definition order=
,
> > GCC may process them out of sequence. This inconsistency causes BPF
> > tests with multiple __msg entries to fail when compiled with GCC.
> >=20
> > Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Checkpatch warns about this:
>=20
> WARNING: Co-developed-by and Signed-off-by: name/email do not match
> #19:
> Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Add:=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> to fix this.

Ack, thank you

[...]

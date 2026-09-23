Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CC39D3D0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139309; cv=none; b=kfeRokEipz30ojjJoEK2nwvGdFxD+TqRiSCn2P769wvKW4FqJIHk9aUtYUGDotPZDJqIU7GcRPf66p5bZWgtb0dn+jEKwocywefNzsPtiZ0LI3mP5M7oeIHOKmM29t5hd9hatZan3MSU9hSdED9skPaFkZeypCS5THxnodMqP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139309; c=relaxed/simple;
	bh=pkx11twBw72LRxjXzrXVqUIa1EmVkbSeH/jvbimaE8M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iRZqZ6rXOH4xXOyF1/39/C+BL4AEw7CKLA18/LIsPl4GCvAG1pc7kSaXrjOtMjD5ymIHBvo69EQ2QCh1jMrtWu4BEo+9F+5C3Hfues240Ui41w3CueFvrHDmYpgkb6W+yGg3GgtbzOVILWFUSYTQBfE1xWPxmtGKZxVYAnoolC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAVJDfx1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAVJDfx1"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d93ff61046so2860385ad.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139304; x=1790744104; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l7U2OrxQT8YmF1Y8YGLXqyPscqsMFydTopyqOMXxMGM=;
        b=FAVJDfx1dnUgFPhRra0XI5IEiyDEB6dkgH+vhzGp0uJ0UMtoTf1erQ6s50CdYZzuYs
         lHovxjEKS2DfYAAAfw03L4QwCDobnzICrWNcZvwC4Td8Y35SdQMZU0GBvk1MXotWAw8e
         CR6fLj1XjkQOy8hmTsRY+kVqgkajbWkphzK6Ib69thBmeYSeFfA5u9UwwT4sr9spcQ9r
         pu1vw7ViV8iMtHBFkV40H9XUsEWpteccJ7FSMhLhvTKc7v3kj1XYj/ZicPX1eFnUdNPC
         QB7zmlkMiSFQtSdx2LC4UtXtgNEMCE+nXVdvq5iLieB4gJa7hJPGzlyZVK+9vD3SmSdb
         PXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139304; x=1790744104;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7U2OrxQT8YmF1Y8YGLXqyPscqsMFydTopyqOMXxMGM=;
        b=Ae/pdSnmVqIT2km0Qg6jzfpYESK3qmA+1jR9jJdXrslA3zFU48RS0LN2dSTDTkmHGy
         w1RZ7IJpyKWG+dwRQ/9y4UxL1Bq8ucYySotRSjn8ypH7sUKbpWSz60A/yRln3iTYb+oC
         SKLSLPHjOoONynF38zkbt003iMGQrWAtL+qQXjozru22K92vNvoKNIsL8HA/YfIfE2YP
         ot7+vnANf+mpycjfLsTiUYq8bJtc04UxmC5xJJSQvPvqyG2iceBgqPPaSk0su0F3hhhL
         rNdrSWRdwAsSuL1JBm7UPo0ea7d5vCaCB3L3MBDTw6vrLXUH4WWG73YbhNq330lusGzh
         Kw/w==
X-Forwarded-Encrypted: i=1; AKwUvBxO3VMguGP55y63wtSMllwYmCkcMwAlcRm9I/7Okx2j0OyuWfkKti4Hug0u6qBT1Ne1i2o=@vger.kernel.org
X-Gm-Message-State: AFuF++lcqR8eKaJHb6Jno3fyjsIXbdPn3zkJfYJSGZvpdSUY2UzWGkmx
	A4d6hhQmehY+RYjE7Rp9RmyoZ3aUZKlnV4PsQzCHTMY7t6E3QxNY4dD1
X-Gm-Gg: AYBFou2ziIni3VdS2eZUXh2gFfjz04DUEdjMkaCecW77Y3T11zukoUIwiBzEsnNtF3o
	ohSRc1ysXhKMEv4FqJ7me7VZ5KuVzJVGZB0wSBeclKxasG2c2DJeJD8NJ9/3C+sKJ3blwWTucIo
	lzeLW8y02LiXhtZrm67w2R+VkBbVtpTVM0RdOeiKTVBEua2/g+v82fXYDWlO5Ib1GL86W8375m4
	x1Oquc5mdk1pp39Il5/+HEwVAZo4f0z2f0t4UCt7dZalPx6iQhbpXBEh/eRE6gfFnS6eDy36SZM
	I4QA+RW+us3+2SgfzdeCnKUskNQavzc9Kx2l+qri84L/+UV0czAFwx5TpgPcblDEBurcNV+8nqg
	QHUT2EGNchM75VyKanYSPwYrocXBzgV9Q4K2li3c+jvuQwe8sfW4CyGYYejQRZ5P/QZ3QgXx6Vo
	KZI3WUPkqyIonZzV+GkeL1zGA0mbt7vsR4IzAo1zpdsNPkGaITM7RckwnHqkx+C3TFcg2MLZjo7
	m3YYSXZsJNTSMtJjMpDyzZadFRNza9BFsMYErpmleeOhVlDYqgmpncJb76DSMVMn0vMFgSS4F4x
	eJA=
X-Received: by 2002:a17:90b:2fc8:b0:3a0:345a:3634 with SMTP id 98e67ed59e1d1-3a07e64271dmr1647088a91.41.1790139303946;
        Tue, 22 Sep 2026 21:55:03 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc4109dsm2922099a91.14.2026.09.22.21.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 04:55:03 +0000
Message-Id: <DLMFF6THNB1F.260JQGVX0PO8Y@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923032703.59816-1-ebiggers@kernel.org>
 <20260923033742.D45A81F000FF@smtp.kernel.org>
 <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com> <20260923041124.GB42709@sol>
 <DLMEKP1LHU07.31JTP12GKADU8@gmail.com> <20260923042128.GC42709@sol>
In-Reply-To: <20260923042128.GC42709@sol>

On Wed Sep 23, 2026 at 4:21 AM UTC, Eric Biggers wrote:
> On Wed, Sep 23, 2026 at 04:15:13AM +0000, Alexei Starovoitov wrote:
>> On Wed Sep 23, 2026 at 4:11 AM UTC, Eric Biggers wrote:
>> > On Wed, Sep 23, 2026 at 04:02:22AM +0000, Alexei Starovoitov wrote:
>> >> On Wed Sep 23, 2026 at 3:37 AM UTC, sashiko-bot wrote:
>> >> > Thank you for your contribution! Sashiko AI review found 1 potentia=
l issue(s) to consider:
>> >> > - [High] bpf: BPF_CRYPTO is silently disabled if AES libraries are =
modules
>> >> > --
>> >> >
>> >> > commit 1bcee0286f1c7c6c86befd107081ebb8a0fb0eed
>> >> > Author: Eric Biggers <ebiggers@kernel.org>
>> >> >
>> >> > bpf: crypto: Use AES-CBC and AES-ECB libraries
>> >> >
>> >> > This commit reimplements BPF crypto using the AES-CBC and AES-ECB l=
ibrary
>> >> > APIs instead of the lskcipher API. It adds a new BPF_CRYPTO Kconfig=
 option
>> >> > to conditionally compile crypto.c based on the new AES library depe=
ndencies.
>> >> >
>> >> >> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>> >> >> index d7d25477ef481..a44ecfa3e9ef5 100644
>> >> >> --- a/kernel/bpf/Kconfig
>> >> >> +++ b/kernel/bpf/Kconfig
>> >> >> @@ -91,6 +91,15 @@ config BPF_UNPRIV_DEFAULT_OFF
>> >> >> =20
>> >> >>  	  If you are unsure how to answer this question, answer Y.
>> >> >> =20
>> >> >> +config BPF_CRYPTO
>> >> >> +	def_bool y
>> >> >> +	depends on BPF_SYSCALL
>> >> >> +	depends on CRYPTO_LIB_AES_CBC
>> >> >> +	depends on CRYPTO_LIB_AES_ECB
>> >> >
>> >> > [Severity: High]
>> >> > Does this dependency logic silently disable BPF_CRYPTO if the AES l=
ibraries
>> >> > are built as modules?
>> >> >
>> >> > BPF_CRYPTO is defined as a bool in Kconfig but depends on CRYPTO_LI=
B_AES_CBC
>> >> > and CRYPTO_LIB_AES_ECB, which are tristate symbols. Under Kconfig r=
ules, when
>> >> > a bool depends on a tristate that evaluates to m, the dependency ev=
aluates
>> >> > to m, which downgrades the bool to n.
>> >> >
>> >> > Consequently, kernel/bpf/crypto.c might not be compiled, and the cr=
ypto
>> >> > kfuncs could be silently stripped from the kernel. Existing BPF pro=
grams
>> >> > using crypto kfuncs will fail to load with "unknown kfunc". Because=
 the AES
>> >> > library symbols lack user prompts, users cannot manually fix this b=
y
>> >> > explicitly setting them to =3Dy in menuconfig.
>> >>=20
>> >> The bot is correct. Looks like a regression.
>> >
>> > Users can enable the libraries indirectly by setting
>> > CONFIG_CRYPTO_AES=3Dy, CONFIG_CRYPTO_ECB=3Dy, and CONFIG_CRYPTO_CBC=3D=
y in
>> > their kconfig, as the self-tests config does.
>> >
>> > I do not know what you expect.  The libraries themselves do not contai=
n
>> > independent functionality (besides functions that other things in the
>> > kernel can call) and thus are hidden symbols themselves, as per the
>> > usual convention in the kernel.
>> >
>> > As I said on v1, if you want a prompt for BPF_CRYPTO, I can add that. =
 I
>> > can't find any other example of kfuncs having prompts, though.
>>=20
>> No. prompt is not necessary.
>> My question is why disable BPF_CRYPTO when these are modules?
>
> If libaes is built as a module, then either bpf_crypto would have to be
> built as its own module (which we already ruled out on the last thread),
> or else this code would have to be merged into libaes.  From my
> perspective putting this functionality in libaes seems weird because
> this acts more like a user of the crypto code than part of it.  But
> maybe it would be more aligned with how kfuncs are usually implemented?
>
> Note that it's kind of hard to actually build a kernel with libaes as a
> module anyway, though, due to so many things needing AES support.

I'm still missing why it's hard to make this kfuncs work with CONFIG_CRYPTO=
_AES=3Dm


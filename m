Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794507230;
	b=nv19ZYN61IoTt9ZJIvUqEszdQ8tydz8EPU09MtP9qrV4/y8BB+JsCadvmhhQ4JJ9OTcH
	 avfWHwhCVxkSRkyDsUJ2NZ0X6oWJpg8MyP+VdgFKdzEJENt50EDJRbViCKw9I2cRr77MG
	 +v7Nc1cDLRDc7RwsntMH9hn3wJBjET11AaEPHjgK/UmByyBwEinQbU9gSsA9edOGHY+kt
	 n3SklkXgI7F3Jfmym+GyUuiMtJasVT6cvVPEfVe1LTmH77XJrsGCMo02wiJ/gPI8AC7Yp
	 3QtDvH76ziXHO8zE54tH87dkbXnpwuPi3yCxFZkHoYiC6lhMFu0AvCxQFRcjYFz7OHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
	b=221WGHUPvQZXoX+foMbadXQYiIVJ/qDR56V2TtgnNlQuOHqfY+vcKQGygGc3Pf1Z2Vmh
	 zb5O9ML+ZSvo3+1aiwy5UWI8hjaZXcelZbil9uzFlTCBGJ6RARLkipx4VZp1HKy4+DTwt
	 1T3xB/yILinBe4G4fqd9oqwjzaJbiYLdfN8MXVB2rNdDZVQS02aynoAtPvEBWcYvFcYNJ
	 8DuNPbqKVZtkLDyz+xEI4GWu3UNZZojxoEURZPPGF9C55m+7TdXnZybrBlJQZr4OIOz3U
	 8gZSp//4t+r+ULmgBPJEK7MOsOI1umDXNDxq9lyd0Q/zck7mshw87SAuBNjY5wSQ/rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QAOT/jUa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A7606A88E
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC7A7606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QAOT/jUa
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so7331cf.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794507229; cv=none;
        d=google.com; s=arc-20260327;
        b=RTiEUu3Js6S2pHI2kZgvSBdc+Z7QSDUXc5Nr6JB+aEZ449+VdVAfFw2z7w5B87Vrlh
         Xpc2qqyYcjp2frT/gI/RxpSoM72KQLRft0oGsuuNBEDp0idWMNjFRLHTKw0iec05OyLi
         J8+nNELPCxikGnxLElz7xNzBmv4pSi7202kHx3DEXspUgYBp2ZXEBNjGcbah+YSyDQ5H
         aRrApKMzuo4YudPjUti4IaagsrcMrrTJRdJmmxQ7WemYcVwZAEizAqPW2FAwCph2Qf5y
         sPmTGUrbb6o+Kx46vMgQs8RGiHviDI3NAlxRhHtCR6QTZpkyqgichMmMtXasesFUN7zp
         rPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
        fh=UianaRj9NrWcq94Xvbh7oWkamvk/lsrDbG4eLJT7RKM=;
        b=ZuTlZlwxz37E00YdHAUbyBn1pxDuFHL7pOOzDB3VRWHHsy4d2KvYjtTXuEI5k25kBq
         wIk0P7UYWVS8Vd+80eKrm+9lShiGiBTuArgOkRRE+v705xns9LmFii8GR4kuFsynJe3k
         uIu1RqGIMByXn8slbqzKVcCTGBvcqoWfPNLc+0BsTA5M8q3HgzTgxY/losKC9Js6jtv+
         JjxxKa6mk/MYDjVzBXxMhEtuVbweK8r4EERy7uesfbUBO0todnqbZ/nvujqGoIW1LH+X
         92bpcAkXNOBSNJ+gOoUoWsDX822/OLP7OnGfBsZFNoO54+1/sK0vr1rBWiX8YlKxA1AP
         j39Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794507229; x=1795112029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
        b=QAOT/jUa1ge+FjhwHcidPWqHm+YYo2QRnirCuBNYMGRauQmP4nWTzYMNyQy+u3k+zu
         tKbYvx+UacipiubMSX2t0aNrINRm7JGqNgE4HnDn5ONmnfqtBlekoPiY6RyY8TJZdqB2
         iMPSQi99rEXSAFVRN+O5374t02u1cDpUtC9gCdwxOQi1tDaoYnuxIHmFNDKqKWxTLKbS
         yD/UvRB7ECUE0FZhxd0sv0OzKQeI5b7SSgNPE5jKeoEhoVTsDve8pyILpbnScp/cH0k9
         e0x9cHDKovRAfsJLx0KDxuQYUQ4dTbRAqXvjFi+foSzaKIMiYm0P/fJ4606JrVpwnrVb
         ZQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507229; x=1795112029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
        b=VqIL6UT+Ly+20iCYE4tUUpwbXKdBq0tO+XYTF49lKc8BQuZnczPu5+r6q0zfMunZ85
         nBJp5FjjE50dlg6PwqYwY/gc1nIRdTU8O4ZRSFUYofK44a+L93eDyZxgFZruAlBZfu6z
         Awg1xmUIpunO6u/8/BZJr17wv2aXVqNYuUTM1hCP/ztk0c3RLlk5WFfcOdonM19mMCiC
         SE1E6e67C+o21+eIKLkLY0J+1NnzoHydbO4hC7Gb2jctNc/BTRPymwDUMCaxB6hwv1sQ
         BQ9IGjupkwGNuCVTSDAjhy71hqyopjr6NR17m32jMTdpD7LFTe2c5k2uQY5v59D9ejXD
         BZ7w==
X-Forwarded-Encrypted: i=1; AL+hErH8fjyujuLlXUpitRyI+j86qYie4FxdpAsOZk1jW0zrypRtVRQo43jWKAosUEf4+agt1bo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+i+iUH7OtY3OLvxyUyppxPEGkvwrZoqb2+sDqHJ2K1NipQaR+9
	AO1hjwiKD3cGd+mnyf5WPLKHfPgnHHjPOqqJDvCQsmiYm0X52HU6++UXGxsZ09897pvor+YSUl+
	+eRtyJGtnOAhbrNisk7Phqf83YWM57sIC9HbUChlo
X-Gm-Gg: AYBFou0tQXoCevoZ0/ybYn9eTcMaxW3/+eB9EstXed4XG1a6AtnqD6GyZTH8Ayxel9K
	XZEZQItHpUfirPTRVMHJUn5RYSPJBqFSTNSqYp66lcP1sdnMy28Dv4ouvMkOL/fkqlTnI7i4JjR
	r7RflCiHg8ikHPf20rjPmQRoHto529heQawV3cBOxVayp1a7ur3g3KrFgNHGeS9W3EK6KuQMqro
	5iDKPKcbbx9gvUaE/5/jWLlc++ngaCVbxFB1fzd1ajVUeOwtlEgYnjV+IaBBcw4x0P0kJwSaYMx
	WiXDoB5qcU4gssJ9Y419/Dz71nK4qZuTMqicrmXeuq+GWdNDgnIIuD1gxCfeK4jdhJcOqB8fe+s
	/53sycEiHABomnrZdmymvNrkuEd7V+eAA+l8OW4wZ899m7VgkdEmz5kVzIqLf4aPJPnE=
X-Received: by 2002:ac8:5c84:0:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-5598d505571mr21838081cf.9.1794507227881; Thu, 12 Nov 2026
 10:13:47 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104043006.1199857-2-irogers@google.com> <d94520950f855a1d5ac4b51975988b70185ba7da61836aa84b044b69e8104bbc@mail.kernel.org>
In-Reply-To: <d94520950f855a1d5ac4b51975988b70185ba7da61836aa84b044b69e8104bbc@mail.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Nov 2026 10:13:35 -0800
X-Gm-Features: AclHuK_VHOAaoYtWAecnECui2dC3TEgW3VbUrZGpnHMy0F3WB50lMjG2hgO8I_c
Message-ID: <CAP-5=fWekVEnxS_eSGsrCPM2XzoY=Z5fkYYK_dD6MGgxX3N2gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
To: bot+bpf-ci@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	qmo@kernel.org, jpoimboe@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, james.clark@linaro.org, leo.yan@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org, 
	mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:03=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > tools build: Add explicitly sequenced -lzstd to libbfd feature fallback
>
> TL;DR: Possible build break at this commit: the libbfd -lzstd fallback is
> removed but no consumer uses the new feature test yet, so perf may fail t=
o
> link and bpftool may lose JIT disassembly.
>
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
>
> [ ... ]
>
> > @@ -249,18 +250,21 @@ $(OUTPUT)test-python-module.bin:
> >       $(BUILD) $(FLAGS_PYTHON_EMBED)
> >
> >  $(OUTPUT)test-libbfd.bin:
> > -     $(BUILD_BFD) || $(BUILD_BFD) -lzstd
> > +     $(BUILD_BFD)
> >
> >  $(OUTPUT)test-libbfd-threadsafe.bin:
> > -     $(BUILD_BFD) || $(BUILD_BFD) -lzstd || $(BUILD_BFD) -liberty || $=
(BUILD_BFD) -liberty -lz
> > +     $(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -l=
z || \
> > +     $(BUILD_BFD) -liberty -lz -lzstd
>
> Can this leave perf and bpftool unable to link libbfd at this commit?

So the concern is that at this commit, not later in the series, a
feature test for a libbfd built with zstd that previously failed to
link in this feature test will now succeed, but the parent Makefile
will not pass the -zstd flag and so break the build. This issue is
fixed later in the series by adding the -lzstd. Will this impact
anything? It will turn one broken build into a different kind of
broken build. I can reengineer the series to maintain bisectability
but this seems like a low priority issue to address.

Thanks,
Ian

> Nothing here reads the new libbfd-liberty-z-zstd result.  Neither
> tools/perf/Makefile.config nor tools/bpf/bpftool/Makefile calls
> feature_check for it or has a branch that uses it.
>
> On a system where "-lbfd -ldl" fails but "-lbfd -ldl -lzstd" links, the
> parent commit gave feature-libbfd=3D1 through the removed fallback.  Here
> feature-libbfd, feature-libbfd-liberty and feature-libbfd-liberty-z are
> all 0, while feature-libbfd-threadsafe is 1 through the new
> "-liberty -lz -lzstd" fallback.
>
> With BUILD_NONDISTRO=3D1, perf's Makefile.config then passes the threadsa=
fe
> check but takes none of the EXTLIBS branches:
>
>   ifeq ($(feature-libbfd), 1)
>     EXTLIBS +=3D -lbfd -lopcodes
>   else ifeq ($(feature-libbfd-liberty), 1)
>     EXTLIBS +=3D -lbfd -lopcodes -liberty
>   else ifeq ($(feature-libbfd-liberty-z), 1)
>     EXTLIBS +=3D -lbfd -lopcodes -liberty -lz
>   endif
>
>   CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
>
> util/libbfd.o is still built, so the perf link can fail with undefined
> references to bfd_openr(), bfd_check_format() and disassembler().  bpftoo=
l
> goes down the same chain, silently drops -lbfd and -DHAVE_LIBBFD_SUPPORT,
> and loses JIT disassembly.
>
> The consumers are added later in the series:
>
>   6eb66acc776f ("perf build: Add explicitly sequenced -lzstd to libbfd
>   feature fallback")
>   155513d3a59d ("bpftool: Add explicitly sequenced -lzstd to libbfd
>   feature fallback")
>
> Would it be better to keep the old -lzstd fallback until those consumers
> land, or to reorder or squash so that each commit remains buildable?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/417749=
22004

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355209;
	b=mZbckbtDYAK58bWihPAf8JXXRC4z+YbtAjGL59y6OT1zrwBvirYQfk3eTITZUCr/FoH9
	 uT0VpQnIXl1Vh71+UcTNZfKCmBlN1X/OO6BipFnUTKfO04dPSvjq6oxPzmn1lq1E35kFm
	 YK3qcVwEHDSLeejALUGVlF5BUeRIJjRqN9CKRzoaGkViCp54ccTTdhQwuxjwPv0d8AS3r
	 h8zwLdbng/PFeHFFCTG/8+b6DhPa2RpIp7m/rchniVd52RiET+6ON2j2+kmza4oDxcAy7
	 qk4p0a0Zd4HGf1h+fEqpjzCnM7TuRogZtyNtRB8CFaUM42OVKHh540/HhjM2tjvgT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O0rp/2ctYtAz5V4l4tmKFoGrP6ExbbPlGpEkX5p3g2U=;
	b=1ib4ULN8HNnT+Pq+WnD2nc73zBCi2NTdPMbW796l8GE5ohfXggbQjCv1jIXNNAmbF3e5
	 FW5sL2I3RDIg7m07gXJ7i7C79mC5oGlmFnAcm+IyG0gE9NEILpZtFv5xnNifPWcUYrk8k
	 Q8d4luQ23hqQkisSP4qvem7UiuAvKqyBQ9AQa/fg+h0U3cdW99Txn+dd4Qv+mDBttRM90
	 mGioOuA75ikZ8v4hO3YfPnZUE0X28zyCpLsI9q7InySN4tzDmfvKByaIxrFqugDuEYbqv
	 0ahwUNJ/8b8zmJYdkooVlltTuLeNuZ1jBrbJzVkKC5rU7VnqQcnDYIAh+PCOlfIf0/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3h9DkOI;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EE606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 10:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 634EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3h9DkOI
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a210470b49so3445475e9.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355208; x=1793960008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O0rp/2ctYtAz5V4l4tmKFoGrP6ExbbPlGpEkX5p3g2U=;
        b=I3h9DkOIpQJfiLOJkWzU+F+nPPRWSkcb4dbv9kO6K07IIVFYsKxGLBPLOqWTMuykEn
         VKDTCbqKgutj4HKN5yEW46u6stV2GNB6iiHZEHO7E+flswLc9KJKu8DXDL+rfs/DapUf
         2XcMWn40rVgoIOd/hjL5MmxSr9pUSIS1AmE1i1IRDRtnnGiFhiRwiTQQt2BioISqbPOJ
         Hf4LRtKKXm0QHr1WLLFC+Ipj+mLyjBv4YXUEHPHSHKiSVolTgTLyM440W2IYv3VeTo1K
         SfHz7uZ3RLIGapJidF3e4/0IodvjQjvRAvHhTbJa+WNZ03WefM9L5amBDUVsUWXoMCJa
         FgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355208; x=1793960008;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0rp/2ctYtAz5V4l4tmKFoGrP6ExbbPlGpEkX5p3g2U=;
        b=oQx/wC+YElRG11JUlZkp4yZef9xsi0J30tz1lgSoU43C8WXcrDbFHT3Tw6FmOO8R5/
         wHMEXkP8OUNB0I5eGPVEqKCByA5v1z6TjO1FMqfcI94nITGspD5DNeCzEtV/IiOeuwFG
         W0CgoE4ViGBtKjX3Ked2PV8Qzqyt4T4KAAW0erMV8nzJQAd4PYgEFeYpoSIFJdf642Hb
         2alBzcihHwlKHYmfm9hZrEXdz8xhk0ZDCzC5wZ94BqGEB0XVNSWuBT3+2u7IkU/d/G2M
         jTxtCePEkWqM02igYzO3tuysY4EezQAGDzr6r6wWnPnlP7nqgdP2HNInzJiZnEST6qwa
         OHwA==
X-Forwarded-Encrypted: i=1; AKwUvBwosWVN5ETW/xDp0ULPUJOApNyslumD/Rjztmeibwi6F9xNl351HVEXNKqP0oqOZ+IRc5I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1117X2dyFMRpGavwjxG4oNEIvv5Jb1JbPxytDw2XYwww/vX/j
	viqH8VnuXgedtNi+A0/2Y6aUXzrqU++sj/tajW40oW5FJeL6flcVlDb7
X-Gm-Gg: AYBFou0+fP3N+tX1RlCEWhmlcuGZVV2xVxi4EpyOoH78kpTN+nXI4DnnXFSsW/Xlpd/
	O/FtDOBB8ndE1VNJKONwEbpCUfIH8nPvE6JPnPPtFyEFSZdEw13zhWLbwai1tEtIsGYJmqMQ6Gc
	pnU1J+vKk2IWeXoUxM49mIspeYo/3SCyhBEc4qDfoxVxQCQKJAaHOHcGhD+ludl1sf6zIIywW5W
	AZ85uhTvavQV9jNkKQBVILTrdhlmP01nuMXZxqGYdtRO7VXj9DZ3FW2cPkVIG57AukXLJWBCvTh
	9Tcsu3mVKm3/cRmF2EFvXjdNvOWh+LDpiyvkA5WTT13uPCHjB8inLF4GvvG3/HoZbwAk7X62Dp6
	wHRnZ87OHuntAMfailWFVEmP8CYgPE8zpWU1qxpzKCUBevlLwib3N75lkFvvdgEmvuCAUm+ck53
	1FwjGz40DytS9HDzX7gYlsnjvbDsSUZ6cQnk/ifUfUZXmA6qZmyJ4HA2zYVyuJ7gK5eaMa/aWFm
	78dYKr15ARfXtecIRImOjlmWK0Uq2chic20KAHLkdfz9bqjADGn4A1IZlg6KdzSTqoRq6RO+/p2
	jzKfhtJUurZ0xzL+mgWmcSkRkakyDNdbIYuc7UDNCPgK+J3on3GxCjEOCRwdFIdhVkuU24zAy9l
	CTjuAuMRhUK4=
X-Received: by 2002:a05:600c:8b06:b0:4a2:d:5ccc with SMTP id 5b1f17b1804b1-4ac17b2bc63mr39008955e9.10.1793355207707;
        Fri, 30 Oct 2026 03:13:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm133317305e9.9.2026.10.30.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:13:27 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:13:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to
 /proc/kallsyms
Message-ID: <20261030101325.6406e8ce@pumpkin>
In-Reply-To: <CAG2KctrwzWGFRs6CZcSRaFOWx49WbH9LQVQJunWsPD3MOXn_iw@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-9-wusamuel@google.com>
	<20261028134012.01d52e94@pumpkin>
	<CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
	<CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
	<CAG2KctrwzWGFRs6CZcSRaFOWx49WbH9LQVQJunWsPD3MOXn_iw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 17:28:01 -0700
Samuel Wu <wusamuel@google.com> wrote:

> On Thu, Oct 29, 2026 at 3:16=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 29, 2026 at 3:06=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
 wrote: =20
> > >
> > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > > would be different symbols at different addresses. Please correct me
> > > if I'm missing something here!
> > > =20
> >
> > foo and foo.constprop0 are different functions with different
> > arguments, so I think we should distinguish them. The only special
> > case is .llvm.<hash> because that suffix is added by compiler for LTO
> > and I don't think the function itself is any different from the
> > original =20
>=20
> [...]
>=20
> > I do think it would be good to spend a bit of thought on how to
> > support at least one-by-one pagination from the get go. The same
> > mechanism can then be used by batch version. I.e., think what can we
> > use to provide data back to user which they can use to continue search
> > after the symbol we just returned (at least for fixed set of symbols
> > in vmlinux and modules; we also have dynamic symbols added for [bpf]
> > "module", etc, we should support those as much as possible with the
> > least possible deviation, IMO) =20
>=20
> Let me sit on this a bit and figure out how to distill all of this
> into a clean interface. I'll keep the .llvm.<hash>, pagination, and
> batching in mind for the design.
>=20
> [...]
>=20
> > user code can be easily written by always setting buffer size, even if
> > kallsyms_query is reused. This is the pattern with PROCMAP_QUERY,
> > let's keep it consistent. =20
>=20
> Ack, will have size in the struct for v3.

It just adds code.
If you use the size from the ioctl (which will match the structure
the application passes) then you don't need to do the extra get_user()
just to get the length.
It isn't really hard to have:
	case KALLSYMS_QUERY_v1:
	case KALLSYMS_QUERY:
		return do_kallsys_query(m->private, cmd, (void __user *)arg)
It also saves all the problems of the two values mismatching.

That is why there is a length (and the r/w flags) embedded in the ioctl
cmd value.

David

>=20
> > also, returning actual size even if buffer is too short is a good way
> > for user space to "probe" and increase buffer if necessary. unless it
> > adds tons of complexity, this is a good and flexible UAPI =20
>=20
> Ack.


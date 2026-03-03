Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A171A6811
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535743; cv=pass; b=it/8icrjczJ9YdP79qPhFvQMO7s6YA4YCOc5+xAm0DGoc8wCryRMY9eaxkPV5mhoiaJbd0WLDZw9NngbxReOBt7P7QzZTJaAsy4fiKo7LjSrlPtLJPr5cBg2wd/a8eUe6f31hdYpt4gUJilQRXNdH1ToLgtcDSfTA+OVde4ymqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535743; c=relaxed/simple;
	bh=q2JJExAxC2TtzJzsIROiri0j+cMXu1NLqvz5H532HlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaQ/8ZXVMf5ZSAkjAALMIaHFNzeW4AiHoUQk9DhwrHwArKXbJWnn2QCAoOA4Qmons5s5b7svZLnuPlGZJruu46qPn+J/pqO1B9nLTyCbxNUMqhteqkii0SCz90zF3sBW3yKf2fSyPwOpxVvssgdWBNVE5mEs0VxgC94kirls3b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fghd0QEP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fghd0QEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772535739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDNXTdEhsZuDSlsnR9FJK78Yt48gWyWFipvm9YpyX4I=;
	b=fghd0QEPt4czlRp7rUaT6B6aPenMvZPnnSqzHdWvKUC7GfPsWJr/6Yw2N7Zb1RkhU8sIDk
	vDr8h8tQegTnC+QtqcheaxdVCWCe0N7uLw2QLwtkpUIWOjAuuiVFJphnZwSKGRbInKeGBo
	SShCHzmErAOe1Y/KkthC3qX6GN2eFEs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355--HRYa9qWMEOMqx2NQBz00g-1; Tue, 03 Mar 2026 06:02:16 -0500
X-MC-Unique: -HRYa9qWMEOMqx2NQBz00g-1
X-Mimecast-MFC-AGG-ID: -HRYa9qWMEOMqx2NQBz00g_1772535735
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-386fc5cdd1fso46221421fa.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 03:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772535734; cv=none;
        d=google.com; s=arc-20240605;
        b=i3ObmuaoKY2qhk7ArIUgnNPQLzIDSK5eFI5oXdKNJQG+4pwtM+I68/qS4aOpo454n8
         P97TqDqG69v07XFxewsngSNS6OH9SmtDMsTe7wgCz2I0VDEG27lSZDLER0Bg5GUFM8Eb
         YktyJtbakyUoPAGlYbZjd8dU88X8NG0pNnOurgpLPF6NvFkkAOx5lG7aOcNOxRJfdTYm
         +UaAGsy9Oqz90LbOC3UdFq2ptVvYSv5sOZNcdxs0bV13z22RzIN/gMcr/dPbRpIgGWxU
         pobu6+ZVzL1G5K6JZlQmmiV7Pqu5zscHgq2kfED7fMlh99vWStLA/kDDmdevFNhbUikQ
         fxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=tDNXTdEhsZuDSlsnR9FJK78Yt48gWyWFipvm9YpyX4I=;
        fh=NwG+yX7eG6t7UJH0Ktz47AXvtn6YGcm56tPHJSpqd2c=;
        b=AvhFsScRgdAoc52DUDPO5h8mkvZhb0QBi9p3cqK7C+LITzD9i8aZOT5LcUQFoKH9Gu
         S1JfRbMEGhEQVSt1eu57Kz85kU+IA9o4VpbXH2xHF8JKDEk/9dC95BBQgFuLXy8fsrLJ
         FiQViSIixXM/hP8a3iyzV50pTzdF7UXj+SnO72QNM9iO6wQYnNgeuuoy8GGtM/Jb90eR
         WRO7Xk4Gd/hMXg06hXS+8D3sXeyBLouKk9xDjbK6BERZ2JC2mI/16+6IggqW5lan+4De
         ehF8NfArq5BjBu1+fA1penUbx/ccT8UDnj1In9HlgNFJ+8weFQtxFTSdR8Dh16smygud
         BwNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772535734; x=1773140534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDNXTdEhsZuDSlsnR9FJK78Yt48gWyWFipvm9YpyX4I=;
        b=Y2GXhEyatoy1uAxtw0M89VjtAeVDd0IKOMIADarUYymSUwwPEyltJBUqGBSppPqdaE
         7J6xkD1Kvs7IeVy0DC4RYYMMRz9U4/z3kC0KGu5Y9thPh0MLlW5axkeIvgzwXJJUX5Bg
         cwG5ss5tqe5RYDYzECuX3mUK3dxIT5+Ep4mkuX8E5Em3e9skD0VpfVXtv/wOLPevyztE
         CMovaCldJIF5rO++isYFExCu3O3zR2xiFykYsudMe320iiE+I/AQuJbeHWK5Xx5iIgC3
         WjLrnO+COjbllKA2nJn3i4omQps5jlexwsWzYB6THfC9ztgVNETbRolg+hPo5su2SytM
         wM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9a2/Aiq3XwTOjJmj0f8eiP6w7GTq+MqflAC4qwLsrb5Ve16Tg1EaXnT1HJ28S7GaoA+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrq1GCWlSVu2RpN4w7kxJ9xWFDdwODd01sdnblnNUKCda36Y0u
	g4P+r/LKZE5+FguT3ZHLwRxY6TXHxXPzpVOt5MKTEAwj/EJTVOSKoeA6Jo8FTgcrSV94bbwlAMT
	Ku+nWfWXh9pYPOHvGgIzQqZgmmBN7gxDRwFmRjGpbTjToIbSeOFqUJg5vbRJXiOtFRIB5B0tvKG
	2TuwMzddIY7ZV7DgviD2vMgNGdc765
X-Gm-Gg: ATEYQzw7yOt7fyxtqgooge0rlEWip3sTY87jWU1rCIX6Pa2069Ibzy0YKaUHQt9G2Ac
	od5kLiVK6yot+EOJ+OCoIKP0lilfTqrTOU+ijq9Rm75kr90Wvx/NbUWeMdIncogwNdUxt4jVNJD
	CzSc+TV256t0Zwsx+XRPx0bkl0OQUTt4zJQncO8NQyeE/S3DiIHizOZMqQaWfC0O72utXyeV3H7
	stlEo1lTJSCG0E5JAEAY5tkUkXyJwc0IL/WtxQPQC69JG+eMSJ0fzFpJ4KWUbaTD4c=
X-Received: by 2002:a05:651c:304c:b0:389:ee95:e238 with SMTP id 38308e7fff4ca-389ff111fe7mr92003131fa.1.1772535734365;
        Tue, 03 Mar 2026 03:02:14 -0800 (PST)
X-Received: by 2002:a05:651c:304c:b0:389:ee95:e238 with SMTP id
 38308e7fff4ca-389ff111fe7mr92002891fa.1.1772535733857; Tue, 03 Mar 2026
 03:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-8-wander@redhat.com>
 <CAP4=nvR1YMQerrJUfKG6a1WaR_ajhOda=Ee5Jit-U=mB6Y9uWA@mail.gmail.com>
In-Reply-To: <CAP4=nvR1YMQerrJUfKG6a1WaR_ajhOda=Ee5Jit-U=mB6Y9uWA@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 3 Mar 2026 08:02:02 -0300
X-Gm-Features: AaiRm52aB5mNrgSUriPTM8H-k-A8l6JJMEcw91RR_l_OtUtdxH2_hQHzgn0B_OI
Message-ID: <CAAq0SU=EqDsHNxPZAbn3PVFm24UdKsF3BOP7f_8fBUAnooS-ZA@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] rtla: Add strscpy() and replace strncpy() calls
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Haiyong Sun <sunhaiyong@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 11:33=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> w=
rote:
>
> =C4=8Dt 15. 1. 2026 v 18:26 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> >
> > Introduce a userspace strscpy() implementation that matches the Linux
> > kernel's strscpy() semantics. The function is built on top of glibc's
> > strlcpy() and provides guaranteed NUL-termination along with proper
> > truncation detection through its return value.
> >
> > The previous strncpy() calls had potential issues: strncpy() does not
> > guarantee NUL-termination when the source string length equals or
> > exceeds the destination buffer size. This required defensive patterns
> > like pre-zeroing buffers or manually setting the last byte to NUL.
> > The new strscpy() function always NUL-terminates the destination buffer
> > unless the size is zero, and returns -E2BIG on truncation, making error
> > handling cleaner and more consistent with kernel code.
> >
> > Note that unlike the kernel's strscpy(), this implementation uses
> > strlcpy() internally, which reads the entire source string to determine
> > its length. The kernel avoids this to prevent potential DoS attacks fro=
m
> > extremely long untrusted strings. This is harmless for a userspace CLI
> > tool like rtla where input sources are bounded and trusted.
> >
>
> strlcpy() was only added in glibc 2.38 [1]. It is thus not available
> on systems with older glibc, like RHEL 9. Using it for strscpy()
> implementation causes RTLA to fail to build on those systems.
>

Thanks for pointing this. I will fix that in v4.

> [1] https://www.gnu.org/software/gnulib/manual/html_node/strlcpy.html
>
> > Replace all strncpy() calls in rtla with strscpy(), using sizeof() for
> > buffer sizes instead of magic constants to ensure the sizes stay in
> > sync with the actual buffer declarations. Also remove a now-redundant
> > memset() call that was previously needed to work around strncpy()
> > behavior.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  tools/tracing/rtla/src/timerlat_aa.c |  6 ++---
> >  tools/tracing/rtla/src/utils.c       | 34 ++++++++++++++++++++++++++--
> >  tools/tracing/rtla/src/utils.h       |  1 +
> >  3 files changed, 36 insertions(+), 5 deletions(-)
> >
>
> Tomas
>


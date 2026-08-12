Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8BC354AEB
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570926; cv=none; b=ap6O8Mb5qtGWLqCsghXhxSIppTsEATBvw/sDWDS3erhsreMEesKHZJ8CM1oWktxgJzajWW26PqX9Z0Gr1a0HP5uvKRIhYguhvE+dedMvNwAjnv8hOeHSwMCQi2uixbe/B3rWATkKbPnYpAwXRrSyXTJHhzSfLU94UByouI9kkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570926; c=relaxed/simple;
	bh=SAwA59bmp2AxMWZcqYMiK6rfjhd7MnwANMKua7E2zZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdOjGmb7a+i3LWpCYXY6gQUfl6lNiTf4MdG0AOQEv+l1SijBbXv9SYY/2LrmiDPrsqF6jZXORlWyWX56e9uLb3fQDAGezJs6Hf94seAgxb6Pb+etvls0QoGi6g+IbNfR1I0NUxOuKSg+Z7fEKFFscB02EQ+s7srqIzxEFMZ8gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP/ULXoA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP/ULXoA"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca80d708489so244485a12.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786570924; x=1787175724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SAwA59bmp2AxMWZcqYMiK6rfjhd7MnwANMKua7E2zZo=;
        b=QP/ULXoAVJlwHUlwPySDCo4Q6/idQutuqDkC3DfQtCIxwQ2RRW8DRNMeAFtnYbsOJ1
         K7V3O0hkOXYjb6kwolockGgXHTEiYjD5fSV86KY1S5h4vV0sUhtNC/qdw0qA6PVZFuHY
         H+2NTZ9/0hm9ozSfdfKIL41YKnr8CFVRCjjEr/m7q+W6+VuuSeTvMNJBQAY8mDbIPxJo
         DMRViG0jlc42Io1TX9hLTFUuOP7OlT+LtVLchcypAz9wZTFpZ2Fh0kafCUepUiGVZlhB
         C3RIJdbdYWAW0Qb3b3RnfZJSw0P8DevRhAWcxgGPiRlWAAYaZ91Wg2OENT5t+j7jAIGG
         thlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570924; x=1787175724;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAwA59bmp2AxMWZcqYMiK6rfjhd7MnwANMKua7E2zZo=;
        b=gjGLtXZ2iMhOGgWtVVY5swnD9IbTWnYcQfNoN3PdsXgjJeSjl8/qxMyfRf9ipFksQm
         OUGe50u129O4vAQV1GnArQugGvmVyVrnZObGTN1V6vWeJlH9Iru0+AhdQG7TrcbPa67b
         +xumd8FiDbCCUA2LuryeQd1ikw02szdNI5SEzHcMH3QnZ573dmglaxTvyP80waQ7C6ne
         S0GWW+ssLexa9kx/LiZb2CMdwo5Xxh63nwHie+Q4zZDuvry8ogUdDAOUVksGCqKXZnEv
         AganNH+ZN5tfvt088tIuFiWDwx/ao5uefxtHYcgos1lrAE8LA6mJPrsAIrDVdo2wFYKH
         5oOw==
X-Forwarded-Encrypted: i=1; AHgh+RpbocsduH4GSAufW/n0bzxxNA3TVQwGnAMywTxOL2L5M3xuDU7I8PSR4WIbPZHzmFBfjxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcx6CqbUBLIux6vrg2qLFxXG2ne+W5KpeHOh82BK2NDD4kOJr6
	KCz0BQVMaQVOdW2eggHiwYjqoKkx3b11ze8pbekz6F7yNpMdvDq5ncY4
X-Gm-Gg: AR+sD12MfEVX11wZg7oWCt67vl03XkVL7r86PRyiFrGe9l4vYcAdy0p5+Fzfg3zMKfv
	cIQ4YseCQTQm+09+VPsALSy7v49eun1HDMYQz74/LK5zZA+83zMU85Z4eqSRF/9/Yix9l+V6iE7
	krU+uD+kEBtKbUZw5eVV8xsrEb2m9nFiCn0cp9PsoJN1fwU+ZvJ0R+S8x0rBYk0jij+CdX2UQyJ
	QMqn59G3jhpEwkOTe9JOKMar6X+o7g3S7ZV0dyepmieJUwToPkqX6UduYw/9wbHJ1oi7QCUmIO/
	6hi4yl4Cfrph+BIxLz2IW67iCckks59+hWRu/1XwKGf6lLWRgIjnC+GKwwflOvwK3QaijlAaf87
	TkMkgMrxLMMRHX8Dfx80YZnz6n3Wk4gv4q4efR6SVPPuR7vpr42lkJGZlluPN3jG0V6etA6L+O8
	LAlCMnmhD2nODxFTeAe2lECsxPdncrXHwvfx3o0fieyfQzTsdaFFPCgHtXJHc0eQXB7Z7e2Y4N5
	/UwonImWGee1+RJ
X-Received: by 2002:a05:6a21:6009:b0:3cb:b6b0:1b83 with SMTP id adf61e73a8af0-3cc57639a14mr974014637.9.1786570924182;
        Wed, 12 Aug 2026 14:42:04 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef7234a87sm181180a12.29.2026.08.12.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:42:03 -0700 (PDT)
Message-ID: <db5893ed20101addde654bc51b0e54fc0e6cbed1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 06/13] bpf: Reject callbacks returning more
 than 8 bytes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 14:41:59 -0700
In-Reply-To: <20260811000942.2381774-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000942.2381774-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
> A callback handed to a helper or a kfunc (bpf_loop(),
> bpf_timer_set_callback(), bpf_for_each_map_elem(), ...) is invoked
> through bpf_callback_t, and an exception callback is invoked by
> bpf_throw() through
>=20
> =C2=A0 u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>=20
> Both prototypes yield a single u64 in R0, and neither caller has any
> notion of a second return register, so a callback returning a value in
> the R0:R2 pair would have the upper half of its return value silently
> dropped.
>=20
> Reject both at load time:
>=20
> =C2=A0- check_ld_imm(): a callback is materialized as PTR_TO_FUNC by an
> =C2=A0=C2=A0 ld_imm64 pointing at its subprogram, so the subprogram's ret=
urn
> =C2=A0=C2=A0 convention can be checked where the callback pointer is crea=
ted,
> =C2=A0=C2=A0 before it ever reaches a helper or kfunc argument.
>=20
> =C2=A0- do_check_common(): an exception callback is not referenced by a
> =C2=A0=C2=A0 PTR_TO_FUNC, it is named by a BTF decl_tag and verified on i=
ts own,
> =C2=A0=C2=A0 so check it as its frame is set up, next to the existing "ca=
nnot
> =C2=A0=C2=A0 return void" and single-argument checks.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

The code itself makes sense to me, but do we really need to check this?

...

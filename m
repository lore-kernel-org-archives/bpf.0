Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D43B4EAA
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718328; cv=pass; b=BBb2GuGy3YZUAz3xlCaiVP1c9dU4aNZF0eh2yi8KxfOKh96KL9Kk4vx7xWNiVOiEc7w0KE8DxpOv9jk87/rqn7SuidO1lnnXSVl2dIXashCCIGc6OxdYZdzREf+JK64+r9RSrhv50AGGqTmmoRDOIJFMviRK84ArVJl45WpF1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718328; c=relaxed/simple;
	bh=GiCC4yWZSZ7UIG2TMvBSXnbbYHY4f/eC33dIeVrWUvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcmZaCqQmJEWdA5WRnYxU0cMw2WfQVWc6of+fTOelnE3GW9Xq38jd02ZDjSqLF/b2iceEjWKna7mIjOqXvpgzXgsuOMetbK4LIv1un2mUaustpVGbkzPjMORmkA5tP9QXwhWrlh/C/3LrUEaNE6DVsU8mmsvq6rMdoXAAqycljg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqrQdBH8; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqrQdBH8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c7c61b5292so23685195ad.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718326; cv=none;
        d=google.com; s=arc-20260327;
        b=kXkTna9/VNg9zhrtGfwjMcHSDHKqZbozxb3ZOf64lr6UCLQbS2WyPx7zLGBXmdQWdM
         Dir71p+T3gcUerQ6XsStsGd/Y8VAmj8sT74NdIjTy8qQx/9S9p2dVz0LrKuFScfzehdZ
         6LTupfUi/H4AOlxVFd8G3PaiT8BhHyZn/ao/wh1UZEPTiEatztUiP58Q9EDw0pjbjhmm
         15B79LYMz79sOezaxCcjdvLqmiAec4fOmzZeYuOAeJWeYwI/Upg3qUYWPEdGTvSNWzVr
         3USxOCW7bc3XhFrzQebH6PwM1NeN9lu+NhxPqEFSMQeygiw+UnSTfupRmdluNBiZJaD9
         BqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgJ1gfbiLnrPYiVKgfk5rYd29jlG0/PTDNNdbkrgtPk=;
        fh=hKJj9zsZ9dO6WjZ9zefeCiLqjNfC3WfgcEOmK0adJMc=;
        b=m+5Ctcvjrjb30WQFytDC5hmu7h6jR+SKYrsVnvgVBgUiteoDP8Uy1tttgLegsZW59o
         Ez3XwqRoBSL+IRT350hCx9ciOir3NjIqqbygaNDVQMBYXKUtriQ/JETL2oam+CZzE2uq
         Z1duevILefc6BmayuaOf2XODWgvcmc99tkoBn6KR0ODCuUMjExL4E6ZQa6qcwA/Z43GK
         MnXsmZAmNmqOqCijbQd84TCRL61m5sjWjmm6VQJKzCghj0nyRiMJynqjoEeDTVHYWnyX
         N7nXakyE+kk1x3+FwE9K3SOvF8EPNZI1E+/QHgqDMLhs2YBtckTlkDvLosVGV/Ef73np
         EJDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718326; x=1784323126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgJ1gfbiLnrPYiVKgfk5rYd29jlG0/PTDNNdbkrgtPk=;
        b=mqrQdBH89c/VnqkFLjDDp+hjeSfDbbRndG8GXS8yivRqx2c+b0P56ctLheAWefET2I
         hU9Q/hv8dFm99Uhu8ILnxyJS/f9VzS/Mm63U/5MW/xCqmVUxlqhXCCsVKIzY1K+1q23l
         5Y0+RsbwgNSLkyl3wcqXEuTz/5FpTrRyjUGXBEyfT3dYGDvQ9WLyYDeq/jdT3QWAHhpi
         AdH9lBbSeRMgSaTc3NjyjYrX2VcSrcMFT5g709waVgmT36h5dIA+C+piW8ojtsDjEsar
         ARsJZut2unklXGixslG3Q/Lqu2JshXqjLQzTOoVC9h+S2I/HhnVLU174y/wArpBu94YO
         Zb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718326; x=1784323126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgJ1gfbiLnrPYiVKgfk5rYd29jlG0/PTDNNdbkrgtPk=;
        b=EGdYlW45qi7CW/HkzELU9zsxKa8rcVOiipeBhR74teGlMjwnU3x6AmxSGn3CZJXOFg
         nLHlB7/jx1SYKvvYS2A0X6n1UoGHcR2X37qlIkzKsYmssJy/yt40BTjIu1zCpGb0AkoR
         m3t3sxdhdISZnpH2LtXXiYwc5Xvuvdt5Nd4Pi+76yq+y9bXAf455qzEK7M1x4VRFOEUG
         mSgwBqLuxD8bmGiGsDPh6Fshe9vpeINBG/Q0GaMpzgYVQQgQ9t9zareF/6J1a+vnmrpg
         31nxnLyZbwBcsPyHo5eDlWyA+IYHnmsm9WY2N6Q1OuTtulpMGOmcYiGyoTGNfONRnRGH
         7cbQ==
X-Forwarded-Encrypted: i=1; AHgh+RokpmPF+RAT8CA5/J1W0Db2gaBA27KyZsG0QsUOVsWzyXS/RnNdxNDKa3ndgciRGUqP/n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzezTe6INnKLQmKz1YMvDVIPqW2PQMXsQXHNGf674YmejtmLz+
	JqFSImuUrBxwRe5Y0wbpomhL+xsSSPnA6LcaFgjx+qm8qoSHzUCJSTHdviAaR7FOD3itL8/2JHV
	K13ilrhypnGujfexdH3pFqHzRffVq5xs=
X-Gm-Gg: AfdE7ck8PRhJQU0rXlQPWZ2G8TebqwntnOm02KDb64Brq1qG41wZeMGJWxqHidaRT5c
	CR4ZKztxUp7jvJgOKwenefIch7zq4BB4HUbMH5lbFb+rtQy7v8DAgZP0xL6v74sXBbQnwMSq3eJ
	7rSU0RbnDc06650WngCNVqot+eQCB0DzpBGdCg29Zf2O0J2UGR3h7D48bhf3Oc5oVKpaYbSHfsM
	XIG/HnY9qSLlZXVYy6R+74b7km4JCy2kHWV4ynhEvcmWurUhdn7UPVV8sAVr/AZWqKCTn/FxE7w
	BLUpFXF3lfF0nYv2X+26LJeTQSB7tNcPJsXp6S1NEkn+L5Dip073kg==
X-Received: by 2002:a05:6a21:9187:b0:3bf:a698:ce40 with SMTP id
 adf61e73a8af0-3c1108c1b22mr596690637.58.1783718326320; Fri, 10 Jul 2026
 14:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com> <20260707120046.31573548@gandalf.local.home>
In-Reply-To: <20260707120046.31573548@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:18:32 -0700
X-Gm-Features: AVVi8CfrRzjVYUtzteFA-fYu5IC19YXoUvmg6lzUqxBqnajl5GV1bbXCnexW1M0
Message-ID: <CAEf4BzYDZKiRg689VZL==ZNetTgdC2a5-6DHrhU7f4afXKxE2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] tracing: Expose tracepoint BTF ids via tracefs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 9:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon, 18 May 2026 08:23:14 -0700
> Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> > BPF and other consumers that want to attach to or decode a generic
> > tracepoint need three pieces of BTF information for it:
> >
> >   - the BTF of the object that owns the tracepoint's types
> >   - the FUNC_PROTO describing the tracepoint arguments (with names),
> >     consumed by raw_tp / tp_btf BPF programs
> >   - the STRUCT id of trace_event_raw_<call>, the ring-buffer record
> >     consumed by classic BPF_PROG_TYPE_TRACEPOINT programs
> >
> > Today none of this is easily discoverable from userspace. The kernel
> > knows the ids - resolve_btfids fills them in at link time - but
> > consumers have to search them by the naming convention
> > ("__bpf_trace_<name>", "trace_event_raw_<name>"), walking BTF for
> > every tracepoint.
>
> I'll pull this in even though it adds 100K to the kernel:

Great news, thank you, Steven!

>
>    text    data     bss     dec     hex filename
> 40506047        15709518        16661184        72876749        45802cd /=
tmp/vmlinux.new
> 40499064        15615294        16661184        72775542        4567776 /=
tmp/vmlinux.old
>
> -- Steve

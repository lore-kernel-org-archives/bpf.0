Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E01442139
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791634613; cv=pass; b=qu9cs+0LqSrubIiiGBMUqvB0mnMBasNXNRUhmhd1mcO4YLMFm3/KVO32yjpxlLuaP8XmF70RVPXmgX+mRqsqSLdezzJDj9ZbYkSDf6ITlRNwDfk8sP5IwLK9+99+OhENR4EJT53a396YBe3Zbf/l6FJ0Ohtt8Z0O+8FltTMMAXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791634613; c=relaxed/simple;
	bh=ZGJygfgJ1vZiogBEUmUhMjrRiIMouFDNzOqzYt/kMEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZz5D/+NAUiInwtYm0VpF14urKMc7/+lUiPHqmC2d/8vIrbqe2/45LusvzZJvfk/lFQB/ZMtPTkoM0ejT2Oj6qj0kZqJH/97qrXqIQvzhOyKg5z0+rMF+qSstunooQTO2IyZxbdSgXk5j66g0TT4L9+YRoVKb+xQtwyqmYoP9EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLzotch2; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLzotch2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a18617ae90so17425e9.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 05:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791634610; cv=none;
        d=google.com; s=arc-20260327;
        b=pupLqzPXxxLpovDIRaTlT8J2J9iJ1zl8RtyrTxZLXNEXQqVCTeg2EFt+esp1r++Rxs
         QVKgFmu158II03jhxSuFJnJpad+JLDOHw3ZdCNUZiz84susYVGX8KXB17oAoBCys0vnW
         uhsJwKUmRoQi6c5wE1zwUAKkyjUd1BLxDmzkmI1JAkmj/korK0a2PG+phTyEzYHHCyIF
         VcTFC5B2/sNFHUCwmg5UpfJT3RKi2YS62yQVCFgH7zseMSqMCQ/uxS1hl8IrRSrXNhWG
         2wxBasrQ7IneemC7L0pYK/yQ2Cnz8MYx78qCazy2WYYDpPSfPpxXAExPSjbOEQjmHazX
         fdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGJygfgJ1vZiogBEUmUhMjrRiIMouFDNzOqzYt/kMEQ=;
        fh=24FfbEACayKCUgF9oDTfZ/Dxw7qoqjwW+3SMuKsTmwY=;
        b=hg9py2ftqC0fLX9lKUjpRDVwlRloBOBDdMJQaVL/+Fx5VwY7EavbPCZmomhhx22d7f
         aVB0Hz5xy448pBds7CSTeRDDKfhOYAPfbJU21+pkUrcRMBq78l+BbPyHSszyvddGIYYa
         gkfaMZhwvq/sLyjTiC32dMTfC7c9xOO6ZCmATcwgCAQ387yhodhI9OF9yPxIQP95eUgn
         0K9qlGCfZe+J8GqQAgSEEjwHTbIY6650JhHfU9FE1VAbQwdqzsX6wG0FVu0BiLY4i2PY
         QpQtdobJh/sOHgta10Jj6+TCCIqMWiZUInoMBlXPworAHKd7LjD9kriwLxTzS7zn/XDz
         RAGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791634610; x=1792239410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGJygfgJ1vZiogBEUmUhMjrRiIMouFDNzOqzYt/kMEQ=;
        b=SLzotch267cSplIFK/3jOGd2uYZhN2LkMIowWcOp2gwgO8AfsKn45zcr0lLMYeW+NH
         /XcTIARa8COLG6FrUJIn5H5ZynRIoKUPPcOejFhIJCM3pb6LNaMKoFPDBwtPNaDDEhLV
         4yHDHF4wXgQmZtp+g0avsyh6UmpteQxwzs9je44ybM2qydvCFEPGgT6P7LMA2+6FD2vd
         83vJXIJZ5PdSwJB1NtvOy3vqts1q9HskoOq0XJDLhJHYTzqcCbQjAyMfBP3O/ahEJDw/
         t58CusoJuXmpGU8sMqK3wDIqFOJdg7OHbWQYIWKJ8sPqw/a/7LcRYIHejnp587v7Kb48
         lddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791634610; x=1792239410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGJygfgJ1vZiogBEUmUhMjrRiIMouFDNzOqzYt/kMEQ=;
        b=hGy1BIRUCXXfAGPBwEoCz8pb/ttgDgWY9cn3L0PmJzzS7VmcVBa7Lzvr5mqLypuqLJ
         QVS8WtKJ0PrjCa7pCc2yHA8nItlhcnlUZ79jMXWBgZdXFrcgxx4ZTr2rjPs3Ibq6MSD8
         /PeXM6vRk2FKbg+vmGPVcxeRhLUX7d+05FNAmPIMauaaPI/6QhaylX3zPG4x/fk5xg11
         2Ffmpcfl5jNwVgbkgwWFaaZ2Dfk8djVJNWSAQ1aXshir+D3ZlxprLYyL2g6I2nVywAOv
         UrXnBWKNx7WGQg4EvSlSuthcxVMpRsOeWxAbPoKyKp6ZTvPrMRHEH5Tueq87PP+OuQgJ
         SxmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyIgvhjkMWFvkfTgD/A6f1FNkE18MgSIv1UWgEVf7HF4150rAHJgY1nseyfcnxcigqJgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5u8BtUb0vrMAUzfkB9VyIAKMPDhBQPMEt5KfEZ0XUSW6h8ZRM
	0vwRVSvqyZxBRgHs1iNoXzO/941x4Ic+0aysnf82NlrER0hyIaEbejGfMYPv7kUwsrY5X5k/3KE
	V3Niq2MWJqaDbgM+r5D0nl7wC5+thywACixwR8CA2
X-Gm-Gg: AYBFou3m/Pe99PrHpvkXSLsFEDWpHddZgLHm3n9BgDG9objt9YsFc2iTlP/09NFnqQx
	E0irOhgqLX7ivt588fbOeZpvPXZDjyjqYtNltJZA6ViVWXMCMdcM3OgTwmFLs+zXHeHH++Y0ofE
	xQIocVAnFIG74WkC6Z6CLjZsohMF1sr2xsZrGAP+xFpEjkjIK3XS0wkv6nvTsau2f4igD2p7qEi
	1h98ph4ekjibjHtaS/s59mr/uRUEyzzmDLkpeEZ3X8+tsjtp+lEV1/j7l1wNoaL/JLcJ3a5oz1I
	sm6zm3bFB/LxtpifVvZ+Yly7zVZJsYwvHAIn3LOP6CflOQcjitZXF1P8GxaXQjYGg/lRwGJru0i
	RdncPK6OO1iE=
X-Received: by 2002:a05:600c:a10e:b0:4a1:80d4:55ce with SMTP id
 5b1f17b1804b1-4a195b30c84mr305755e9.4.1791634609468; Sat, 10 Oct 2026
 05:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-selftests-bpf-dmabuf-iter-unnamed-v1-1-962ee94f7a5e@gmail.com>
 <CABdmKX2VHqWrPb2O3Uqdccx=nP66gECU0kVc=4tZdGqSEZvuGQ@mail.gmail.com> <20261010025252.3716641-1-odys.yuan@gmail.com>
In-Reply-To: <20261010025252.3716641-1-odys.yuan@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Sat, 10 Oct 2026 05:16:37 -0700
X-Gm-Features: AclHuK-buTBub6GSvkPbrPC0OJrukJaaCD5TTns2vZsTz9QpTX-JSgssQ-hs3Wg
Message-ID: <CABdmKX2CkaBzSqeaDHYUC594wiwjJ0edjZyGp6uSD+5GeDk_zA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Accept unnamed dma-bufs in the
 dmabuf_iter default test
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 7:53=E2=80=AFPM Qiliang Yuan <odys.yuan@gmail.com> w=
rote:
>
> On Fri, Oct 9, 2026 at 5:07 PM T.J. Mercier <tjmercier@google.com> wrote:
> > Hi Qiliang, are you running this locally instead of with:
> > tools/testing/selftests/bpf/vmtest.sh -- ./test_progs?
>
> Yes, I ran ./test_progs directly in a Debian testing VM, not through
> vmtest.sh. The VM runs a GNOME desktop on virtio-gpu, and gnome-shell,
> mutter-x11-frames and ibus-x11 each hold a 4 KiB udmabuf without a name
> (their fdinfo shows exp_name udmabuf and no name line). As the
> iterator walks every dma-buf in the system, default_iter fails on such
> a machine before it gets to the two buffers it created. The minimal VM
> of vmtest.sh has no such buffers, so it doesn't show up there.
>
> The subtest only checks its own two buffers, so skipping over the name
> of any other buffer seemed safer than relying on all of them having
> one.
>
> Thanks,
> Qiliang

Thanks for the explanation and the fix.

Reviewed-by: T.J. Mercier <tjmercier@google.com>

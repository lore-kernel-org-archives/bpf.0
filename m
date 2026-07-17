Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F706390CAD
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317479; cv=none; b=lsGeEY69y4lKW9RRpvHGmhgvg2x46mLkYjITOz2OWTlLlSctWfaFwpkw9PsaFzMwpIumQ1jAPtLiz6TsIvoDjWwdrkoGWmGTJjzSl4eFQrDsSXyIb96a8QEefKw4Nw9I/O5Wgv3Uo4k64RtGZwKw34dgr+x5b0Der7PAGXazfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317479; c=relaxed/simple;
	bh=8MF30aRlwAjLEItoJr9uuia8M4q/ivgKYTeHDmlSTrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbZbGAXYXpq2dO2Efw63gKi4ez3JCMb3J+Etn5Bj7pS2ns3Qoy/XD3ifZejtVSSNswZCZX/HGKER+UsyHBqakERDaPZ/owJZ26QbxdtMj33y7teOpQ7r+OvzAp6hDT9zukwSKVAF1oEPNBnFOuz0/S6ihT4n1VUBD8TVEysKx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhFfVP8W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhFfVP8W"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf27856f9cso23753735ad.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784317478; x=1784922278; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PQgoW9XL0qGnRNZe8u238aJuYpKbxhMKyO36Yk54ScY=;
        b=KhFfVP8WKShEhQms8lIDecMs3Mju9pDi3bw6iB1th78tnrDm4GM48fC0zKtMlxAAwu
         bmWVOYElx1kKP7pp4DcQpNKCEKJxyxEIMEzrOT0YOJd/OzCF3I1jr9Q7+18NBnL6nMiI
         JmPdaeRaI6/MmmgfzQNu6nlAiF7l43BD7FdqGGUvbl/UxE84qs3Lt1ERO2oN5bjPoB7u
         Kl2hd1GNAHhxPxnp1Li5xuos1dlog+3F3YnuoIjw+q+kmrm9TboJeXhLe9rGYRQEAFM6
         jGMpTh5O7FDYCUOJLZrJPakQw2CHrq8WfiQ41mxOsLurazDweJixqNj2LnAU12Wkzv2Q
         6yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317478; x=1784922278;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQgoW9XL0qGnRNZe8u238aJuYpKbxhMKyO36Yk54ScY=;
        b=emCE88Vc97gHrSaU7R0o7UslkU7SdvYgVTRmY9OC30heq0fTLEzYCBNxFMSZ6eqPn7
         QQaCCNJ0sG2DLdD6GfBtre2NW7fK5aafkToT7Ymur8mjavOSutn71Dp3mRRW2YhUO0iT
         1lD0yMp2QTIaBDjtP24yvyt/RsAJWiXqOVgFkW/vzsiKFB22v9t+4vgYGiVd3mCvimv5
         Jf+7mdLanE5nH/Q6Zce7iP7m3JSFeZfNPDleWHzm4wKTNfyDmhsVByoI6yGoTLlQFPPh
         dED6YQIUi3eMsO91xMEcUxE04RFvlPEO369jM9ySn/UamyJJXLTSlXpDCRmWxzUFEAgQ
         fX7g==
X-Forwarded-Encrypted: i=1; AHgh+RoYUhB+i775y5baFGqn0zNDOZWI5jxajruAQvwib87OgU2tNH/B/cQU8kuv1gNlA9kSar0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejccAM6lGV56J4tPwQrZP0gxULUM74mHkglvHRJmncdv4Lxi0
	LhDt1FndSPTHjCctoAG7gNMICqmN3iwOsmsRpRXDnKfLFx1wp3I+zrwEEIIpD6zT
X-Gm-Gg: AfdE7cmrfHXDdPHXE5YMlLPpSM6pQViRR0ivxXtRZU1hJ9/F/kGqJ1DULQtsNoXbKor
	nVZJ5APzfcd7T1BxQkj4cR1vwm7QVk59Zkqb6ygxSDHL8QORLZ/HYYbAouyT8rITl3Zhcs/BYfz
	DpDEam5BBuZ+Fmh4yP7yF8s4n8XQ38Fw8Ia/QwbUxXrHvR27aUCV+y+wUnjfVMZ0GNylaZGFA81
	hNDXmIMlXkcxTgZvGEvB9ysDYzpQn4Od5O+Wo/mfWZeiQ0IAQzrDjRAQAW2DG8r7qlDlY1Bkm36
	SxZDdJfdAqkRyyXY4wZiBaplex89Z/JV214nMQFfxSYeyILXFcCUZsVCADodFRhNIWgd1kicb1l
	cSxdGsH2+tHxJ374BSorJEAlekuG0mibtCutVVZVQObPoHc+GBZQzmLFjhGzWaHHQLnA929zYJQ
	W4tYTxWeg6r+VdcGtDh8JQl3yNWS95CJ81lvq7wgah1lYYTveMYyWMJGifrQNEbP1r2CWe
X-Received: by 2002:a17:90b:3dc8:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-38e4b3e1419mr4056299a91.6.1784317477871;
        Fri, 17 Jul 2026 12:44:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:87e3:2c3:b68c:94ea? ([2620:10d:c090:500::1:14f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm9636549eec.23.2026.07.17.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:44:37 -0700 (PDT)
Message-ID: <6b8ea7274d44b1687d3d9956e17300e3af4f993a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Inline bpf_iter_num_next() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 17 Jul 2026 12:44:35 -0700
In-Reply-To: <20260717120215.2171057-3-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
	 <20260717120215.2171057-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-17 at 05:02 -0700, Puranjay Mohan wrote:

...

> +static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
> +{
> +	/*
> +	 * s->cur and s->end are int, so the (s64)(s->cur + 1) >=3D s->end chec=
k
> +	 * is equivalent to a signed 32-bit comparison of (s->cur + 1) against
> +	 * s->end and needs no sign extension.
> +	 */
> +	insn_buf[0] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
> +	insn_buf[1] =3D BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
> +	insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
> +	/* if ((s32)(s->cur + 1) >=3D (s32)s->end) goto done; */
> +	insn_buf[3] =3D BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3);
> +	/* s->cur++; return &s->cur; */
> +	insn_buf[4] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
> +	insn_buf[5] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +	insn_buf[6] =3D BPF_JMP_A(2);
> +	/* done: s->cur =3D s->end =3D 0; return NULL; */
> +	insn_buf[7] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +	insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +
> +	return 9;
> +}

Nit: let's have this (and others) as:

  int i =3D 0;

  insn_buf[i++] =3D ...
  insn_buf[i++] =3D ...
  insn_buf[i++] =3D ...
  return i;

The translation lgtm.

...

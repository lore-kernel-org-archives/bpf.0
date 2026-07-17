Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCBD25F98A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316662; cv=none; b=i5Nq9fW5bZ72vqqOAceVuTTZLu+w2azsXI3jrjAUK61QkiMxd/0V/QAcmSFC/M6JOLCkobeqOEjFSjbRArzttsAs4U1YgTjUEV8be+4CC9LBlBmwcVosCw+LtyQH/nf0VTJ2VWkqqvYTXZ5nSa+26kfCwMsFEzMTUk/pQW9cU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316662; c=relaxed/simple;
	bh=WpdnELFnxBK1OI3YHY06HL3QCl5XSfCWH/ps5poBk4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ke/ayNn5iZYA1aZHCycARItsG85b97254xAloJ5/fTyP8gffRNtW++e0SrQUIRwGa0xPZ7N1syreD5vXQS3o70fymhoO0t0NLSGyiQwy+QXbJhcWEjY8zNmC268U+Ntw5b1LHE+1/glzw/pPCgyQqJKW0oLpThbUj37lVKTKVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCbs4PG5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCbs4PG5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1559798a91.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784316660; x=1784921460; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C/7hianKOQfNcAt8s/4jC9J3uBkEwMkUDFzqkU7M4Ck=;
        b=gCbs4PG5d27dYt1wJJMCrSYMn3AqR9SWJOtKS0cCu/rOWpodgqDV3oS0cbae/6EZRI
         5y6QSZ2Ys7krX6dPHb4nCcewtSHeazOcI9fX66msCMEMutSuXoKlk6V0U/oq5jg/Iowk
         bAYxzQbAn7QJM5QoFRDtoBNYNjWcYXXTDWQwerD7/I1AvfGg/fZtbdRxFZJvRVg+qybr
         OyNCzAEhskeMmZ8XCyu44XerNegovy1rxWk7mf+Y7PoRhBDEVgDbtyGZO3jOJjBiv58s
         nN4I5RtBsrAXGIw631hmEUlTwfJvsCpYOJjpfC8sbYpgm2g6oxrtE+O0s0ShuPJGlDP6
         l52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316660; x=1784921460;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/7hianKOQfNcAt8s/4jC9J3uBkEwMkUDFzqkU7M4Ck=;
        b=hdEkcjB6SCQeLlLZyu3sBeCkf/4TG3jwDzRoWhX+Fs2w9z2pMi1ysLXVtIo8Of7XVT
         XTGjXYpjQqeVcQe4exOdfUDkKEUrPdUSS3aQ2xRMRvwXiL/uvb4V1+YVsv36Edo+WXsS
         24qkNYg7tWg4pdLjazB3hwN3MrpGUAlayEqUK7CdtEaWBPhnVP0SViqI8FmUyWGeRxNK
         1RA0/VxMMoii77EGYhddGNrtF3V8OeKss+B4f7u8FkmW3LvN95eR4sPs3D7pi/hv8kDg
         /7xpT1C9laj/grl7ma4j0cmhJjHpcdzDu8jXzaNRa60J0e2wIWVH5PxkLVzSZVE1ydBe
         +oPA==
X-Forwarded-Encrypted: i=1; AHgh+RoSsG7n2yTEXiNDTi5QrfYwlGofDv/nhZFTH6Gx8dJ84I6cesKyIzSK+SqBTOWIqoP/ekw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCbl5VRdwjRf/XbHR9SGG+DQhSFqBhBBvam5j5c1SsQ+DcDLl
	ysMFBoO8pxgIyVrTZviNoiw+K9aPqPGF/krVrjE9KlIecgWuK/9LYNx8
X-Gm-Gg: AfdE7cmAw1moJpwnNYKBx27ROL0juRA++D6PZZBDI/uXMrM+YqCr55RH9/8G5QiQUTq
	1TYqL13jqHnwETiDJRUkoswBXGBBY8cssuoLvfagLrv/o7rmZj4LAurgPoyD4ek8Otv6K9myfbt
	1qy7AvXjeLI1dqs3X4hCHl4coMyN/ZP8HeF1aelkvlAZKILZuLV+26uZg2vxqHxPZwh1csnK2PL
	VOXwMLMno+rI/mzp1ezEruXsay3fbMLxrvG+NKMHJdURpqxexz22qL6mcDn3zsvaX2Y3+iIyB/x
	9nWo/3x6WyEDRNGHqJfOnwjooXfeGPTvfgZDvyD1F86ujV3mbEaiLmVSbwIxGv2XlUdyqLkr86o
	SwVJUo/oahIg3gOCWOHCXUIn2ZFrGEpBpU4kHBxUEtLyGRWhUX6ojFOLb51Ip9kbvBuTFNlSXNQ
	jFDThnXfJjRHGLN8E3bWJCe9tm80745C6yCw0bpzeqre4y5AMTMK8MuXXwb8m6Eok2RoWp
X-Received: by 2002:a17:90b:1345:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38e3cfd30a6mr8466788a91.0.1784316660140;
        Fri, 17 Jul 2026 12:31:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:87e3:2c3:b68c:94ea? ([2620:10d:c090:500::1:14f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcccsm11075356eec.4.2026.07.17.12.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:30:59 -0700 (PDT)
Message-ID: <6094a8f1a9e58e90d28a54864650147cf19040a1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Inline bpf_iter_num_new() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 17 Jul 2026 12:30:57 -0700
In-Reply-To: <20260717120215.2171057-2-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
	 <20260717120215.2171057-2-puranjay@kernel.org>
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

> +static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
> +{
> +	/* if (start > end) goto einval; */
> +	insn_buf[0] =3D BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8);
> +	/*
> +	 * start <=3D end here, so the range end - start fits in a u32; compute=
 it
> +	 * as a 32-bit subtraction that zero-extends into r0.
> +	 */
> +	insn_buf[1] =3D BPF_MOV32_REG(BPF_REG_0, BPF_REG_3);
> +	insn_buf[2] =3D BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_2);
> +	/* if (r0 > BPF_MAX_LOOPS) goto e2big; */
> +	insn_buf[3] =3D BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, BPF_MAX_LOOPS, 8);
> +	/* s->cur =3D start - 1; */
> +	insn_buf[4] =3D BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
> +	insn_buf[5] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
> +	/* s->end =3D end; */
> +	insn_buf[6] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
> +	/* return 0; */
> +	insn_buf[7] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insn_buf[8] =3D BPF_JMP_A(5);
> +	/* einval: s->cur =3D s->end =3D 0; return -EINVAL; */
> +	insn_buf[9] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +	insn_buf[10] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
> +	insn_buf[11] =3D BPF_JMP_A(2);
> +	/* e2big: s->cur =3D s->end =3D 0; return -E2BIG; */
> +	insn_buf[12] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +	insn_buf[13] =3D BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
> +
> +	return 14;
> +}

The translation lgtm, do we want to avoid two checks at the start in
case when r2 and r3 are known statically?

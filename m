Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EB12D1EF
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264592; cv=none; b=ZLc5SIQ1oV3kFOW5epMJzNzzgM1PZlLFYZDMLIQ46g5dUaDTwT4bqLRjBG9jCSd8mO5SqlVQ6BqcCWP9xpxSa8oB7v9kx9x7+6ugCGuACXYI0aloGJe5GnPq+yJaMnsoP43IY+5sE7so/bNbP/hpv2VTk6XIkYNzOm60LB7zoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264592; c=relaxed/simple;
	bh=vzHDwHhoIPHVOZrL7MZ+aBtCaLKoPWctEs71zg5BJOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeNy2sPcFTYRP64QxOmtmn+8o4s+FQaYdGMoIOJQUvswZP8Xb/DkhMI4Cbx3m8DbNfQdsYj2FFhRFSc5Vt4jlxwSV5lgQngdKsyR9/lLMklrc1amJ3B9LirHrEaAOjVS8E7qn/ZqftNAOxxFvcJxJ9BuDWSaZ+2nYQINJ00e/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H023LuwN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H023LuwN"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d2600569so476714e87.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712264589; x=1712869389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GPC+rQLzsm6Oh0UAwW/Bd3SMOvUfKqGD+h107mpDoQ=;
        b=H023LuwN9pQI1uv+PQWp/kE1fer6igTa865zG9v8zOHvydIdoRXF/4ncMnl5j119Hz
         8cNvFUCxc2Pl9qy6UBXItAk+p+yvLUTkQutiuRiY9vEm8qp4rjjCWtMcv38PKjJO75lr
         PlJ55/qJEW3iAQrTAURjnMy5Dc7DXeopKUf9rlOBay73kYBSw5aw/mzoJzra6dGFDQDN
         +KojnCOoG3/XfCdFo0eVkXtKHXatCOCSt25Um0jcCJ5gVZxnKDEDHnRcgAEIyrxVrtPx
         a3mIjgTY7X0s2pF/pBsCntIdRNdFGSl1ZoKr/Ufnq6VscEnTj9XbbIHi2aucPDf+eQg9
         3Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264589; x=1712869389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GPC+rQLzsm6Oh0UAwW/Bd3SMOvUfKqGD+h107mpDoQ=;
        b=aDx4IB9WXh2RleT/cqZdLn82Wlj5PP80nECx0ZLeldJWwkJ1c5ZSujW5ToPF9sYQsd
         7h1LZ0Fn3TD1csS52BHx7/0h3u7+Pa7ALw1PJHHBr7t2AYRhhYeRS5jzRdIIUYUGvKGm
         b1kRUUMjvdZi8aSvUz5D23m33kCTZ4Q+uLCjOeMc+0QPRXJNDJflhRG6a8yiGxGRLWvn
         zzMNKgXwdkHPI2jYwugQCIFP1yMdZUYaoKFTKrOnmDIcE/SFE8JvTjASZT8hfD72QpM9
         DV9+OQFftW1Anc5SQSGv/hOAL/yCBg3RdQrxv6jY5tG3oKze7qBS6qSRByM8AC2QJmdz
         oQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCX54cFkVc4JYu/QeTKR3bkiQTMCZaI+fVIVzD747+rbftBv9MSE1IlnT91U2+IrgMoVfM8HL03IOmwz6jSLSJ7X0Gd+
X-Gm-Message-State: AOJu0YzZXZ7jllXhS5BoYY0+mkSJzYrawTUgFvRLUVrqx+Plsna7Lzsu
	vXCHThre6xoldtgmzBKcikMMLboxfzdpP+IWq/iBrcvFUDoJtqnC3KP/ajRSnnTG95y5AL6JjhS
	DaBCJcSAr6uoTYwvHARPOiZ/TrMs=
X-Google-Smtp-Source: AGHT+IHI72su+dkjwPG/SLQ0BLUC42zFU7gjpoQYRk+zaIn9cuirxe6Eyqu30sBARHAA+1zKtM3WkFWq7brzwU50eWA=
X-Received: by 2002:a05:6512:33cf:b0:513:ec32:aa81 with SMTP id
 d15-20020a05651233cf00b00513ec32aa81mr3475965lfg.13.1712264588802; Thu, 04
 Apr 2024 14:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
In-Reply-To: <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 4 Apr 2024 23:02:57 +0200
Message-ID: <CANk7y0jpJuLsnD1fmK5-oqD5CWvrGkzaYU1+Yya_7VuYtzPpMQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Thu, Apr 4, 2024 at 6:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Add a new BPF instruction for resolving per-CPU memory addresses.
> >
> > New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
> > insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided per=
-CPU offset
> > to an absolute address where per-CPU data resides for "this" CPU.
> >
> > This patch set implements support for it in x86-64 BPF JIT only.
> >
> > Using the new instruction, we also implement inlining for three cases:
> >   - bpf_get_smp_processor_id(), which allows to avoid unnecessary trivi=
al
> >     function call, saving a bit of performance and also not polluting L=
BR
> >     records with unnecessary function call/return records;
> >   - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bringin=
g its
> >     performance to implementing per-CPU data structures using global va=
riables
> >     in BPF (which is an awesome improvement, see benchmarks below);
> >   - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just like=
 the
> >     same for non-PERCPU HASH map; this still saves a bit of overhead.
> >
> > To validate performance benefits, I hacked together a tiny benchmark do=
ing
> > only bpf_map_lookup_elem() and incrementing the value by 1 for PERCPU_A=
RRAY
> > (arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below) ma=
ps. To
> > establish a baseline, I also implemented logic similar to PERCPU_ARRAY =
based
> > on global variable array using bpf_get_smp_processor_id() to index arra=
y for
> > current CPU (glob-arr-inc benchmark below).

Can you share the code for these benchmarks? I want to use the same to
compare the performance
on ARM64.

Thanks,
Puranjay

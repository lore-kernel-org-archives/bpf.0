Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37122068F
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333092; cv=pass; b=GEbRalxeFm1gAUeM+xQzZhIWFGZBhwEpUUTVitF8AdeeGZcNMMKdLWP8NbySqAmRsmUaqLPe0dz+ZjD7fAZMw35vICprCKNQidxoOwVzSBPeIbOGi+OKswlfaEiBngLud9unCrXWViVsON/k6y6YgWneElp+j2vcNw1g2Y1PByE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333092; c=relaxed/simple;
	bh=qCgVnwX89Yd0Ex7A149bbP8MgtAFhmd/Hfdb0p01Afg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWArf1tqCyRchaj94PdEZTNw7nN0lLDR0URDj+paCrDkrRuls6cl+YinUi7S3vM8o9rc1ibGZvGvkgHEccjtXVt3vwdxhS4OkWwhdviZKMcKHresRy/dmxVD1ERMFMxMaAgkaaXdyLMP5kjSVHT7Qv5rDc3neStwRkV24kr9m2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMhwgF2n; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMhwgF2n"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so1176175e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 15:11:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770333091; cv=none;
        d=google.com; s=arc-20240605;
        b=ecn2VM6LCUIZejfZBNcOOuxk/WJnmxu34IS4NLZZQu8XLmNpUm5E5FhQ5Jxp6lDHMn
         CdSpu8KuH3apy0OGyTLBOY6H9RNzVghbomAInAs4gjTiFdxP8KaZiLFBjnVRP0JIjWdo
         1sqkHajByL1nERF8sDpayeOk+5nCebP3p2iKZNKic/Ww7jEqUpJEl7/2VAmp6+6AFs6c
         t7GHL/JPSEY2hQJ1fEX22ODOCsAtV8Mzy0RAP4EGILPKfmjT32x5ZQy5/qw0T0AxIkiT
         4CuYyIm7DKLhqiHaM/63YyDMqYXHiRtztc1ypqWxLcp/V3FZDxidIg8QlOKLyC9Vs8Mu
         i3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FpRmCrpoQ3w0D3KbMk+i1AmAiAcOEZC7KDOd6scjVe4=;
        fh=j6t72pnwF3y+YxGCRQExh+xvKVr4oM50FmCTGVsJqSQ=;
        b=UHlrsozmDLvN7a7zDeLZaCoKMtu4bJNGQl3bYVWXGH+6X/hDhTYJc4f8IOd0sf6tT9
         oFvShOY8TkKnOZKRwRkTvdCwEinoejtMG1Kmi1dcjMMusMtv045m0GzGVHpkT3JZOvsF
         OTD+vx3wAhb7r0GK/NXHAju3fhsSM04N5kW1UucAop+XZQueZ3i/6Z5SWKmeDSSRGoxV
         8XgLBtlY2+prLeC/fwgZ4Vo3tmd6fF6l6Z1RX2lg43qUxsaCjHcQUYBxiiUDvj9fvPo8
         HJHJnM9PUZgIt2TCyN5HSjrtjtinXgUODtye686mUv2cK249RDOftp5i2ntNlFqET73Y
         0tFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770333091; x=1770937891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpRmCrpoQ3w0D3KbMk+i1AmAiAcOEZC7KDOd6scjVe4=;
        b=cMhwgF2nz6NdkFtcFKcOM1bYI6mwr2pzBNLlsbG7nsVt/o3B+7tAq0zANF52HoDyhw
         NyODihY1kwSVyxmQufYIih2jdfK9pYoHV2vzcyGO4FxHPctAfqlTUmrkUNN7l1htCTCW
         pU3CAos0wJ/NjmvlBaAWu0vyl1c+3pT7LBkqCY+6s1d3rQmJJuYX5Z1WNegRUQGEir/s
         leMftCVY0L4wzjc4NRb+iVqDHwf5z+1VbrgJvzCRsnhBNhlnAlY0aVeAUhy39N1Am8Tk
         gHhB0wKYkBXXDyrlyfc9Srj6Uj/AJpLcCixbXUC8TZHHo6r8qpioiGwhwaeimKuIJLP4
         /lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333091; x=1770937891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpRmCrpoQ3w0D3KbMk+i1AmAiAcOEZC7KDOd6scjVe4=;
        b=w87VYIz1a31bxMFUuS0f9L4nYaq6sH2jGtzz7VVfhychytyfJEHPalavUMwMr8nfRx
         JyXCOe3Tbx7AXI296swys7hbO0vpnUBENZcDSCJzFsPcmZWpOWwS1fyFw37xGhdS2WGb
         I+zVCHPr3qYgj9vzNA+nd6seB279WtIhBrYne1QAw3kHfVj146Iz0tuvvBB4Z8az2DjJ
         /t5fQOve+RE9E94xQLGO9WAztC73jdhoL+w6AZZ4tjzFyM4KOW8TCou7lLut9aVnBfnX
         NtjAc83t+we8qwtfiXQebRc4N4ki6mkbaOLt/rRrN8zeeCJWSZIWFaYS5/V51ZTJtDGj
         tLmg==
X-Forwarded-Encrypted: i=1; AJvYcCXxvLdGzFTaC1t9LOB223hTetkqj2ZWRhGNOzokcQ0G4725gz2gP1z0lpZAjRC6YOSkqNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3NTV9f/rPCg1w6G6skrEn8LhuH1DlQWw70yhJy64PIGCnEsI
	Wrr9gGwAchZc2yXewY/ErPEY1rlQZFwlsMeVo5of5ROpVsykHg4/cmlAL1CBg0p9stk3Z5nxami
	5cdrr8LaC1F5ZWoZK1Gd23VKAQs8+O8g=
X-Gm-Gg: AZuq6aJ17rYLoCCE0uAxdLcrtiYQSvjigES+fkx9/Xz4C+OV+AIPqKW7Ta9apQ+x2db
	YDV7oB+Pn5yjPUIkOcKE9b9A0XHeN2stT73TLa4ExAWH/nNIq1Iq7QRoHGHmcooLftaWzyCvqVT
	K6hNn9X/scjlWFQMjcBoDYT6nrTbNDwKpXA9kXKG7FNc1qw+asghxY1VPBQVHy5ZWb5vupzEWRO
	kQHqpEoRrTFolVus0LBgvfXROWQ1FrXAzmnKHj70ckXOCNm/RvP18wSEjsKzjG6Wyl6aCVPqRqP
	gV5eXBLOnX7YXCeSugj/1BM+MKs5p3WsaYpd/JOVDpaSqcCUqNv90ycsCKRDZLexYUGJFYydvoL
	8oKlguakZflzynry/juZ7NOR9
X-Received: by 2002:a05:600c:34c5:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-4832021e972mr12974965e9.28.1770333090690; Thu, 05 Feb 2026
 15:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-ivan-bpf-ksym-cache-v1-1-ca503070dcc0@cloudflare.com>
In-Reply-To: <20260129-ivan-bpf-ksym-cache-v1-1-ca503070dcc0@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 15:11:19 -0800
X-Gm-Features: AZwV_Qi8cOWwfwRBUp7E9Bur4F-2GQd8th8Scs7-sWlBraFzCdnu_QbUwK59JoE
Message-ID: <CAADnVQLaGNF=QypjnM1pJV_-49D3AXaRLpvCb31ozpg_39GO=Q@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: cache bpf symbols to avoid quadratic iteration
To: Ivan Babrou <ivan@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 8:50=E2=80=AFPM Ivan Babrou via B4 Relay
<devnull+ivan.cloudflare.com@kernel.org> wrote:
>
> From: Ivan Babrou <ivan@cloudflare.com>
>
> The existing code iterates the whole list of bpf ksyms until the right
> one is found, which means quadratic complexity on top of linked list
> pointer chasing under rcu. This is't noticeable for most installations,
> but when one has 10000 bpf programs loaded, things start to add up and
> reading from `/proc/kallsyms` slows down a lot.

How real is this? 10k bpf programs?

>  static int get_ksymbol_bpf(struct kallsym_iter *iter)
>  {
> +       unsigned int index =3D iter->pos - iter->pos_ftrace_mod_end;
>         int ret;
>
> +       if (iter->bpf_cache) {
> +               if (index >=3D iter->bpf_cache_count) {
> +                       iter->pos_bpf_end =3D iter->pos;
> +                       return 0;
> +               }
> +
> +               strscpy(iter->module_name, "bpf", MODULE_NAME_LEN);
> +               iter->exported =3D 0;
> +               strscpy(iter->name, iter->bpf_cache[index].name, KSYM_NAM=
E_LEN);
> +               iter->value =3D iter->bpf_cache[index].value;
> +               iter->type =3D BPF_SYM_ELF_TYPE;
> +
> +               return 1;
> +       }

I'm sure there are other ways to speed up get_ksymbol_bpf().
bpf_kallsyms is a list, but the same symbols are also in
struct latch_tree_root bpf_tree
Integrate it into get_ksymbol_bpf().
latch_tree_find() will be surely faster than linear search in the list.
Or go the extra mile and implement an iterator for latch_tree.

pw-bot: cr

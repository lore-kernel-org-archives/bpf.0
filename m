Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5911DFDA6
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271503; cv=pass; b=L4/zg8neiQnIerbKIgDfL2MfzALwo6SY7OwY5nTdRCmglWZHxumNQCdsnTJ7aWOL9LpW9p1Hfre8bO9piyCMaMd94wwW6LHANhHU2W/6LmnFtpLAjo51q7yBueIzE017CaQTcml8gqKkZNdeO61eeB5M1Wiwhb0dEkQHaDvzEHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271503; c=relaxed/simple;
	bh=EsehABZIMAMvIlkWfGNeZ+SdsjNLE9RT/8p/eokJUrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIR+gMqwyd2C2eR92FiDuo/2n4TZyGYfVVciSAKQi7Uf2HR06DrHTGrY7FGvWMhfUGYhM/a3gMPd0MqLBEXbBoNPCy91d4JivPkVRGkNqM0GGMgBqWZ3uy0ru11cGjIroRXosiW8kzw1hQ3jx92FPh5yDH8FTbCSAtn3KoSW04w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIeWvD8N; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIeWvD8N"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc891373e0so5865465ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 17:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787271502; cv=none;
        d=google.com; s=arc-20260327;
        b=Hdd1vqv2KpCj05ow0xwQRWez98DGKNL0g/c5UadrquR4YvjOw/yh+cAyGB51ZSw6/1
         0zoZ+FYvozScqNyAbuxa1to+WM/TOWGpHotkQ7Bzd2zIxxumaFEA7viKj7kafXIGx9zJ
         WlV17tXe+byhgQOz9qY3FOlsE0N9LbY3arg4FRY7DvXSdKcLStIg2WJrnOh843XFjq/E
         clMbHoueJ0wx40gSUmxb0t5Mr8FLKA9o1aCYJcgkAbatRPghZtENlfUwOdn7Redi9Ety
         5v8LRhzgQP4XBU0MAtYODXc+LnA6lt+XhrkoETNpBl1eCwQRqaQhcqe0cOd5+6/TYq5P
         yY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4M5y8c7OB/PRO1X+VZPVGhO8kfA1utMaDwX7ewtebQA=;
        fh=QcmVKBPWPOOYErLvNrGcxBjfTh/Q1fEi8ClZJROS/aU=;
        b=P4fxfQTCNGg9qY3nfbDVOfFtNlRsVESSzbME3EGC/1NLlRaUNxYhA4io1H/4SGuS80
         Tobdu1uq0A7df9hg0FxiB3XdZ4CRFfJdksitZKfy54jqSHnRZm3tjz0Mo9v0ESlThSEh
         /lzR1ichteLwABL8E0xOlBxwHG3+ak48XXnh0uKlWMR152v1Fx3mEm1MxAIWx+ZGdW2g
         Bzhsomaq5+pEREHPKXKFl+SJgtCa3x2rNVPQdVxqoxkmliFpMOiCEjGMgENOczc1C+7k
         dNDJaRr+mmTdENtNTy6kz2la7v40MD4TTB0MkalY011n9Nx16giCgeW+xNsoP1KlC6vy
         cHXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787271502; x=1787876302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4M5y8c7OB/PRO1X+VZPVGhO8kfA1utMaDwX7ewtebQA=;
        b=lIeWvD8N2vJwOmrivahL7qciOme7DFVr3acH5gPw92LhO2WihnxyIyhHgI9SSC65Is
         TCQWjWTz9+dxTNBf7gBWaleHjz5Y0A8rZO6dNz0tYOKTTL6OEVw4VY8oeOnaTOCpIczM
         U5YOl0Uv/1Hjb7vS6YNH4qC/Sd7+g1MfyTHenxBkgKTBWQlhPSIgbiRlv1o+n43fMvfp
         FoQtnSyoV+/U8y8yvYyjswsPzNib9mYugxr+zLZgLcvEubNSELgh0PLaw7+Rttri89As
         gHVSCoFIest7n/Qs3FMvM04r8E87Cq0s/SFafFQCadW1g/nyHVxBbYcMiT7yoztQpBgF
         sJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787271502; x=1787876302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4M5y8c7OB/PRO1X+VZPVGhO8kfA1utMaDwX7ewtebQA=;
        b=JqVmQ5W0Wi5Z0qz/Y5fOvDvQSPP5n8mFsaiuloAGv9LPoYcFlu9yuoZ36bALyxzV1M
         8+/5+Ddn+mXQ7RHCvkP+wzFncPnGtTIa3IhVWXAC7kQJnvRI6pIA4ba4d1Kswds6zDCX
         4JahRaCV0TVrTRWK+FqhEE6XfXn7bdtqnJFo3aPoG93N57V5+/OBl2GO/9Uq4WwCybc3
         /Fwl6/MeXiALqi8jtQRYJ0JvC1I84LZjE0pRHWdayMcM4TwTWDJtGnOxTdEoRe30Y5N3
         hdKscmisHUL1jkmlrERHsFXHQmmalIxzZQzlUt5zz/sxfvCbMds0CBwJAjmLwJW/0MYl
         7reg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9YYc0fOWfoBeTDdqv4WXuZrhmJTlJ4v7567Jvi0T90MvP3gyDGGZHpcfCu8OPgNsQaxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjk7OKist2f9KL4fXaqkzdmngaozqXFmcBTkPa1vD4CAq+UP/W
	fT747ayEmZI0hBUcrvBgIvCwZxa5nwD0TcCVdUVu/c5T7aL0YNpEd84pqqyCHMO80M/9URN3F9s
	3DIlbYc7XzeFpwCoEEfKCTTaGjy4XPWJ4+IlP
X-Gm-Gg: AR+sD12TV9gz5Eo+Pav5KPUm5kpaBqohLDCWyEZjnVNfMkV/YEW7zMx/1lcwaubDKUY
	7y90O6KeeTY1/rdkEYqKmLk9Pej3++T60T9CRvBLo6WV6LqACx4TBzIPowTq4X816BX2bZlPPeA
	fSeJFcMgCCIVVo9xnZeFLYGvtXC5qxqu4RcfxV7VD/b6HTVTHkRoX85l9rz/RrfMhltEM3m5b4Y
	o6IQrqXY3flvosUG8mT0PD3+EruE4Wn6zQ7BlVeSQ6DkXnhJzOFHfn0L0G1vkoToeWz64enxrRo
	uvKQrWIpkIyFRaeekiJsTc2sIiqu6stI1TcqcKHlh9VhJvK6bOyMXmky/kjLDF9LJ/GmvimKTza
	JHeme2cl2SMPVBSk6qswo6q3dDoGcjTgS3ckY
X-Received: by 2002:a05:6a20:3d93:b0:3bf:a543:e7f5 with SMTP id
 adf61e73a8af0-3cd2fd8e9camr3401813637.3.1787271501710; Thu, 20 Aug 2026
 17:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev> <20260820000627.3826188-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260820000627.3826188-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Aug 2026 17:18:08 -0700
X-Gm-Features: AcwNN1UaS0E97lc3H07XsdcZzPeWipIGIalXX1dsD6gEYXuB6Jmsfptk_o_ESBQ
Message-ID: <CAEf4Bzb0ybaCSPU9pTKhW3ZEtmWS+o+7MShpDCLysQrULM8aoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpftool: Don't drop a type in the sorted
 C dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:06=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> The C dump sorts types by default, so that generated headers are
> diffable. The sorted dump emits one type fewer than the unsorted dump
> of the same BTF.
>
> dump_btf_c() starts its loop at index 1 to skip the void type at BTF
> type ID 0. That holds for the unsorted dump, where the array index is
> the type ID, but not after qsort(): position 0 is then the lowest ranked
> type, and btf_type_rank() ranks an anonymous enum 0 while void takes the
> default rank of 10. So the enum is skipped, and void is emitted instead
> as a no-op.
>
> Skip by type ID rather than by position.
>
> Fixes: 94133cf24bb3 ("bpftool: Introduce btf c dump sorting")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/bpftool/btf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index c9589026da8d..345d49a9a22c 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -805,9 +805,13 @@ static int dump_btf_c(const struct btf *btf,
>
>                 if (sort_dump)
>                         datums =3D sort_btf_c(btf);
> -               for (i =3D 1; i < cnt; i++) {
> +               for (i =3D 0; i < cnt; i++) {
>                         int idx =3D datums ? datums[i].index : i;
>
> +                       /* type ID 0 is void, skip it */
> +                       if (!idx)

nit: my personal preference, but when dealing with integers that do
not represent "error/success" (zero being a success), let's not use
boolean operations. this should be obvious `idx =3D=3D 0`, IMO

pw-bot: cr


(but nice find!)

> +                               continue;
> +
>                         err =3D btf_dump__dump_type(d, idx);
>                         if (err)
>                                 goto done;
> --
> 2.55.0
>

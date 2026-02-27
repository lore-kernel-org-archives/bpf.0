Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC488346AD6
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233899; cv=pass; b=gROK6QYfNhwUJ541FdTgaivAy6TvTtbupLUrNxszSrrlMpMnkGxRhMf8V14uFVHvPZIFjgaCenPVNDvFXzeAHlIQwFIOHQkydufXVbbc0tL7O+Fxz2zid12dQyvEmzewUr779OS8IIGIf++hDBjgJ6XoFoym7qdGTpDmD1x0Duo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233899; c=relaxed/simple;
	bh=ZJtIL/YuAAUbmVjuxoDUXEYCDVNpG+0hh59tvVeMMCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YD/0uWOs6SGXZugt0qhNZ/+esD8MJLzEnm2WO/qjrrDBpofdm7JQWdaBNlZOtJKIolO2cfr3k2j5MFDyyUOD6BnLGj4UVxWUWjz43pKRqliL6u3vrgRE9OzmzhRPRc6mXCzwRtWid7UaP4HNu0BMuah5NAhW5VMjYpVQrRIHXhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Qwx5Dy; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Qwx5Dy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so27625265e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:11:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772233896; cv=none;
        d=google.com; s=arc-20240605;
        b=DS70oz7c55pPnse2uRusdtxly8uAL15B/PdvtKUw3BbjLMyknJdI6G+F5M2hViXp6Q
         ZsXre3sCcXrZ6RpqAD8fPHg2m9xX4ksPi8XuH7PmRLi7U0ESSVzUkjefEikQEl3gk8iK
         HydoJAmb5+kX1uvkuVFPQPxFYDPCaLyVjCUPgRLgKtL0SiKTsACIFXp+ptf71AnOQ3G7
         7HmZ4N5AiKz5Yb6mG0E0OW0WEAX1fwHhhews8UoTkiHXymSzvRIXVfwhoF1gM4j8KDbt
         6lvTRuF1sufsRLBKKakDbZdZnZD+33ry0niERTcO0MaNxKbXPvUDL5gqO5VYjbXvfjQq
         XiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzA6xhht+8ueih1UIwxBkikWdTm9mNoQ6gN29hqEPNE=;
        fh=uK/eSNOL05IGuCBFGnD7T+gPSFSxuUlrM01FcLIgkW8=;
        b=ialWoy/nfiB2Qx3bfynBj6FLR5pAKhiaqJPMWpiS6NEmYMwuW2Hs31LvmCRMxHPNNx
         Z2DygL6k86zO8MHY0On3X6jpoj0BGHZs82BZ/eqEf6FmV4Izmj/lqnqEWgmELv4Wb8ti
         NJuCsecGAncQeaz64NCukGEeLgevMnxjzSSFPUeCqoFPrgBGCs+QRfRckhy0hNDrOj3v
         n9w7xeVaAtQLVzYNCZu0G5tXEoB9cmu1YrHOTHdO83hLcURtG6clOEAkakSo2k3fj3tq
         h/Tgb/94Qn7qbfa91TAik5Lp6Acrew2N/nG+1UiB475bOCmAKtuZYReChH65zVu2yy3T
         HDig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772233896; x=1772838696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzA6xhht+8ueih1UIwxBkikWdTm9mNoQ6gN29hqEPNE=;
        b=g6Qwx5DyJHD0rjqIef7ToBRWMpl4y5qjJ8PrUgxzXm4UQrqxfvqlyq2bpXvfmROI/Z
         +Mv+ZFbBz6ssrAJSC7RjAhZVsp1vlMIf07tmnUXr7vvHMUjAONw/nD2oAwSwx4zLjLCH
         Fu6TkyS26hl0AGwiJWth14+1VhyWgIMaiooptGEtGMBffK7YpwKVJh86tr40+XDbeEFs
         938ffjOEHCP+eDKeIo/UMKgGKPmq7U2/ekTlWlabTki7HIWy21y6yjCtxtDqETx6IHGo
         LBCpo1ueA84q8SteUsHHbEOqj9NvtxRca1XL2byTo0/rp6aPuHACmk17Sa1nW1VvTn+C
         fBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772233896; x=1772838696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzA6xhht+8ueih1UIwxBkikWdTm9mNoQ6gN29hqEPNE=;
        b=u9nUzp0gblTZkDo1zcgCgJwU3URlD2GFzkeTipYv3tgw//VCAvY8jwKm8IR6x3qvcH
         vYI7L3KvuwyjNsVFfwsJLIb08mW2NEGi2HHKPXfWxJkvKrovo8N8wuoaKCqEzQ/0ABfI
         7RdmYBte6EOrwmZRzFDJnji9Mh/A+R5flxKIayu+xA6m28HV1wDL5iZRy1uHvL/GDtkM
         1BFTR+1DDd2tKg4kTRnWsSJdL7VJwtsOXRZda8upTaKRSCD8ZCUozWe81pYz+F+CRR9l
         WWs+WyhhdV/X0C8/bhcvUwaibMLgVHBAfnm1hU33iNJmv3MiGqQEw/JO5rXWfwxVQtv6
         F+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXG8j84vTgD3iJkcXWvU4JTQoPpmWEUinBcJMAfIAIfCrpJHeURrp80gURtrhU/28K6XKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++T+i44ZPDK3A+eabhE5sEcseSXL6eNlruTZCudyJfHgrUwkR
	UQbjepbvZjvwML+Ab2NUaQnvJ9vvYwcwFRv41TqIB1ozdmL7TI69yoCv9QJhX5TKkO75UKZe1AS
	YkEQlBse06YC/qv+53MS7VtTYwPVaT8Y=
X-Gm-Gg: ATEYQzzw1/YbJ3/7wgDA4CvnxNs1mSlt7ZBhsYjILhSadQOBuH8mPhS3tATplCzx76J
	rS3vHlDK1K5F1LtdgimlWUMaBpAFoNdwRPLuZvA+A8x//AYYsu69E8NtnU225WFI872aSm8ag05
	pjLIlnn3wXLdlPl2UcdkY4Ii8WE64Uft4s+/jq28mPgvfm9x5kocGH3CyDOcQvVthJPNufQiInd
	A2tSampaTXLdDpJgBg2gq5/3hkrN+mvgBLjY1AUI3WB1B5/yHDP0IHTmUt1B6ONqcCFOwzTEoZJ
	7jxXPmcIFvTleg1dolXVkauvMrYIbtgVBvUOc75rgPHDoCQH08mIja55vf6JufojnsCqYg4e80d
	0MuFycf1c8ZY8QtGPTcxWyOANYg==
X-Received: by 2002:a5d:64c4:0:b0:439:9564:4dda with SMTP id
 ffacd0b85a97d-4399de15292mr8596463f8f.23.1772233895745; Fri, 27 Feb 2026
 15:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-3-alan.maguire@oracle.com> <4b1bf31957861b05ae30b2e2380890f820604cb8fcd7f0414ba706e25a8d54ed@mail.kernel.org>
In-Reply-To: <4b1bf31957861b05ae30b2e2380890f820604cb8fcd7f0414ba706e25a8d54ed@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 15:11:24 -0800
X-Gm-Features: AaiRm51y9rA2RS_cWTzMeltHg1l6Igh3OVovGeqLX7TgUboY5BPlWdShdPJKXKg
Message-ID: <CAADnVQJ_-6n-coJ2=bWRfBUfvK0m5QPcqjnW1vZjqau4aLy8+A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 02/10] libbpf: Support layout section
 handling in BTF
To: bot+bpf-ci@kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 83fe79ffcb8f..7b58724a90a2 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> >  static int btf_parse_hdr(struct btf *btf)
> >  {
> > -     struct btf_header *hdr =3D btf->hdr;
> > +     struct btf_header *hdr =3D btf->raw_data;
> > +     __u32 hdr_len =3D hdr->hdr_len;
> >       __u32 meta_left;
> >
> > -     if (btf->raw_size < sizeof(struct btf_header)) {
> > +     if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
> >               pr_debug("BTF header not found\n");
> >               return -EINVAL;
> >       }
>
> Could the read of hdr->hdr_len at offset 4 above be an out-of-bounds
> access when raw_size is less than 8?
>
> The previous code set hdr as a pointer without dereferencing it, then
> checked raw_size before accessing any header fields.  The new code
> reads hdr->hdr_len before the raw_size check.
>
> btf_new() calls btf_parse_hdr() with whatever size the caller provided
> via btf__new() or btf_parse_elf(), so small or corrupt input could
> reach here.  On the mmap path the data could sit at a page boundary
> where offset 4 would fault.
>
> Moving the initialization of hdr_len to after the size check would
> restore the pre-patch safety:
>
>     struct btf_header *hdr =3D btf->raw_data;
>     __u32 hdr_len;
>     __u32 meta_left;
>
>     if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>         ...
>     }
>
>     hdr_len =3D hdr->hdr_len;

bot is correct.
Let's avoid potential oob read.

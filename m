Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E6328B7A
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892989; cv=pass; b=sGHQlThOmnhVrIgJFF2EHUoZli76ExpdbHtaLp8jcVkMrWi+tB+LZjEaWfJiv3+Ss4+d0MuCAYLWCLPGQo840juUG/ENYk641AIFueUHkXOlYn9N8nVRoa88Ujd5asNeMOXY91t2W+cUfZH/bPXgiuYiqSvN/CL1bO+YJ6GFkm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892989; c=relaxed/simple;
	bh=aeWXkUxxIcuaEjtJ/Uc247f8Zx5omtmo3ktQhV9cwDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnaMlFmDY3+lFoym8e5+M6aaRRnU5f/9hdysfZK0Rpkn3lurNli0OC7fICRrm06IwRbThQ0NoCm9XIh61ct2SuTDyVfrsIRUPizwJZ834GaqKZI0Ru5n/K0qDeVgP4VfKxYAawQYyXpPESAvM+pMTmkrX3tSqPdIBncKB7Y2Jno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPVViH5u; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPVViH5u"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2429f98d0so35015145ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776892988; cv=none;
        d=google.com; s=arc-20240605;
        b=juyX7/GO+XfC/OlOxpWLe3qY34cFZClcbxAuRdbZgk/sJNc0rexohNRIbYjMFjLN/+
         wGgKeJUShRWJli8SbIrs1vWpZLQJJmo7S3eqkofVv5rQ2CQCB88TRLUIwmdUv7bnXx2G
         cE2PDw03pv8Wd8fCfZ/8n2iNBpnbYFo5AC/uBiwq85ecG7E1zT2aeOnt7GE4tPCMo6vS
         a5DXriwzCMZTngoEk5x8njmyMmU9ibdp1PUfjHd+PT6bIkY/QEYNH2zASy17uTgY5WCy
         uhjfYxQ3VjlssTO2FPO6Xt0vtF546u5AyphGjtQ6TkhBoUoV+BiQj+aNwEgSi2G14YuW
         Lz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6lvipwowPMdvQcg3dKvcqZ/djKCTNc/95DYGcG9P7s=;
        fh=vwHJH18DLZ9SRF6HZNYr27HcdWDuMSdwJzwmTTE+/Z0=;
        b=M1jZhIM7Z9ie4IRLnNGGAOwzXHD4TRxI1/39bnxqvvPuSlOREMgDcw5og+5FF+IlDs
         HQcxyKvLMW4aB905xvsUq0qJC12X4tXI/y7m5t9NbLMMfmg2dAUJiPNQvxgPOt+c+vLk
         QHM93BkJIbPK7ACQnEcc7k3f4SyQIHHA3JnaUiEmbaPxVYAs8bWliFexgoQbgdsMVWkH
         yn8g2+E1pXq2WawSFPnw3Y7tvjmmqp8mne+9rM/oAFLbAX4DViOlE11O51lAbqBG9P61
         bnXRULCpGtaSBo75A/aek7vD+/Ke+BsdQO5qjIA1t+J4oaVXQBZ9onnO/A0Q+pNlIdas
         XYyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776892988; x=1777497788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6lvipwowPMdvQcg3dKvcqZ/djKCTNc/95DYGcG9P7s=;
        b=jPVViH5uAFI2B4OsorPi48T/dNVPW00BCz8uTUwG4dTopxUCfNtYCHP3EFMzcqTp4L
         Jg72ebIleJT5RMFOc1Xq7F1oCkCBt/wLXoXGnXmSe32gA2AQ3jLMfUJ/IOyjhZG31BZF
         B+ym/exspjvbWsfiquBpHg0T9s7WHVgVY/PRNlt4uXvISuu41dSauAm2HtrfvnlXwjnE
         I/BKRhf5XYHuBaEfxMOd/tUO1rEK6+s540ymLtQ7GoAKSD93tPX63dxy7ee0xrs6J+KM
         hXiL8fMd2zKPLKMoBKCdRa1jGLa33sAAcPxKHUjehJpeYYuvxhMmrVVcFRntykB/x0KI
         qjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892988; x=1777497788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O6lvipwowPMdvQcg3dKvcqZ/djKCTNc/95DYGcG9P7s=;
        b=LdKgeuTvD9VhLJA+c1JkObHSsV9SRjnsbEqmISfPLGdPNw8IuOWKP6agfR86U7yCum
         3kTSOPrHihK6W7U+Ql1n40XfdLUOAzM4Fzd+GP8fg/z2Yazy/zjVbJMkvff5Heqryw5A
         wtrYNsAyvqTnlrGWiIpXzCqeU/pSFinWb+21dJz5Fg6IhofO+o3/xWx0UbvHjUd0Pb6U
         OO9PII33yh8UZgobLDosTxOBw2inWYwtJ1wsmDn4Heu4DOXVGtskno3BFZGT8Fa71nMA
         VcE+qVoESGa6aVNaqWwLRlT+J4xWkK8KzXfzg0decasl7sIjScV/edMuOfUlgHBhBDnS
         bqow==
X-Forwarded-Encrypted: i=1; AFNElJ+HuwvcKDsmKUX19VXw/XNXvEkd7+ORFmXYR4f0DoQSOiHOAzjwUjtyL+XzLNe29zHC3KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMrdO/QzDm/FlEgFRnLsE6CLaX+hGuo9WzBKBNndEpCFL8dKG
	uBfWtNkB5eRXryj7jv14jxr0KI5uEGVTKbX3/YmNxtfKO7bGLBlCYobKiQcr5WMSN28he3Vg5mf
	ePiRA5VBbeUCpWuynp9+/QaK2ad3FDCk=
X-Gm-Gg: AeBDieuIPbYiPbGk5rHS3/eGJCHSufTpM8isQH1+tDczkUPxMdLKbLC1c6wrsozNK5g
	XCsRuYAbbuI9YWoYnY00TSG9thINWoPxAwjXkV0PgRqjYeXX0YX2hvNt5KK95YeFL4jYzkTdwnU
	Z3zXHOuy78PZpKF8TdV75brCOcA3CweKB7jqZQ885cxI1IrMJvr16eJMJc9IX0mbrvK6aTvA0es
	kqEtbo4jnVfxrTQaGW+XPVZHbg+q6QkF/3gsW6AHD7fzaSHbr2UGlis0ySsKDJNTLsSwl17+kbo
	xd8h56FWwi62QyLk0mLD/HCxEbXcJABoLw==
X-Received: by 2002:a17:903:2392:b0:2ae:5eee:7a5 with SMTP id
 d9443c01a7336-2b5f9eacaeemr267169185ad.12.1776892987594; Wed, 22 Apr 2026
 14:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422103206.533695-1-alan.maguire@oracle.com>
In-Reply-To: <20260422103206.533695-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Apr 2026 23:22:53 +0200
X-Gm-Features: AQROBzBjILVQ4chQtpIGJCLf1mw8mYCRm8ZVntTd215snLeyljOpF16cMxKy_A4
Message-ID: <CAEf4BzYgTt=bgx-KYjBMU2PvnfV2=LFXu-pY-L1yOzNpxoraTg@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix type size overflow in btf_type_size_unknown
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org, 
	sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:32=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> A layout section with a large elem_sz/vlen can lead to a 32-bit
> overflow in btf_parse_type_sec() at the point where a large
> type_size is added to the next_type [1]; a sufficiently large type_size
> on a 32-bit system could lead to the bounds check
>
>         if (next_type + type_size > end_type)
>
> not triggering (since next_type + type_size wraps to a value low
> in the 32-bit address space).  This would lead to a bad value for
> next_type when we add the type size.  Avoid this by ensuring that
> the type_size we return from btf_type_size_unknown() falls within
> the range of <current type, end_type>.
>
> [1] https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel.or=
g/
>
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Fixes: 2ecbe53e0e991 ("libbpf: Use layout to compute an unknown kind size=
")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>

Is this a real issue? If provided BTF data is corrupted, we don't
really guarantee anything, do we? And if it's not corrupted, then
32-bit overflow cannot happen because btf_header cannot even express a
type section bigger than 4GB.

I'd prefer not to pollute logic with unnecessary defensive checks
meant to satisfy AI complaints.


> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a878..d48ac5460d1d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -420,9 +420,11 @@ static int btf_parse_layout_sec(struct btf *btf)
>  static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
>  {
>         __u32 l_cnt =3D btf->hdr.layout_len / sizeof(struct btf_layout);
> +       const void *end_type =3D btf->types_data + btf->hdr.type_len;
>         struct btf_layout *l =3D btf->layout;
>         __u16 vlen =3D btf_vlen(t);
>         __u32 kind =3D btf_kind(t);
> +       int type_size;
>
>         /* Fall back to base BTF if needed as they share layout informati=
on */
>         if (!l) {
> @@ -448,7 +450,13 @@ static int btf_type_size_unknown(const struct btf *b=
tf, const struct btf_type *t
>                 return -EINVAL;
>         }
>
> -       return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind]=
.elem_sz;
> +       type_size =3D sizeof(struct btf_type) + l[kind].info_sz + vlen * =
l[kind].elem_sz;
> +       if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
> +               pr_debug("Overflow in type size %d for kind %u\n",
> +                        type_size, kind);
> +               return -EINVAL;
> +       }
> +       return type_size;
>  }
>
>  static int btf_type_size(const struct btf *btf, const struct btf_type *t=
)
> --
> 2.39.3
>

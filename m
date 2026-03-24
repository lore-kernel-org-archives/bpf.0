Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9A378D64
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318579; cv=pass; b=juGPozC5/QLcCZNddn2rJ+zAtIwphZkzpoeWZXvq5p9K5XRN3CO9QhK8mec6O6sjmLrjysaUl5ufTHAPiVf0r3mY0bQxhBRzM+3YhGV4gKj8WZRRhiqyZrx/0uvbMVTa3YUjdpJ8pLF8jhxh79caTEjNvmYVAsRfFlcRmuiQ3tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318579; c=relaxed/simple;
	bh=wWbHGOahe1TmIl8FAwScQTkdwY/rQIonaOmU2HriuZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwECNVzPZjcOp+8X7A99wBHofg0DtcLXLGR2AbzYF3Xy3kaVnCKB+/pwMix1HmVZf8eENnsNXaswjMwoJC4+BdO5T4CHjZX4y4rEULw/AFzrGw9MHNy65vomKC8LnTHkQsfxBDp8H0ia5SwrwZaj2kR0VKSIvKIM0UB2yV2xR84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPM8x6NB; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPM8x6NB"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a8e873ca1so39164107b3.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 19:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774318577; cv=none;
        d=google.com; s=arc-20240605;
        b=hSuxIfCkQJWixWzvPMZIUmr/8tV8usEWeXDqtausTS5/wttyRZv6pRD1+y8RrDgm4P
         9cKTAE8PdGrt7rLlIh+6+EjJ2V97iD93CkGR2HdUc5919Sm62rNxCHtlO63cXt/53MOv
         iWrDacTs+131tlnmz9qzQlz4zfFA3ytnO94PZuJO0tQ9Jm2nwkpISwRcaiOgKwx1+e01
         7XCF9wDDeoMqRVro5ixfSiSuUS2AvFyXN3ybpW9eUKVHGptb0LeRA3f3XmIVz7dbkj7i
         wvE40ZENKEzq/hWREmlFNBlKy/s7BJR3sRqanUG+/A/Q5rb7EA/i1AwvKgcSqtVdpl8/
         O5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXYWZ3Af8+UWCG+9zf8xt8wJvtMCh01uE4kwpvainlo=;
        fh=2oNmZeg6WvgxpxCmCsnrq464yYa4H4eTRXzratzBPcQ=;
        b=AJeedj80DX7kfzmKuCAxSpmYoMwwiAtu6dX173N/1Pix0Yoigl0zwLZ/i7ANLm24Wf
         BnurTukTIgIWLTYS36BKqhgDxlAWerPgP9nHcNPmtL7O8dAFPCVcXu6oA5btNmJCXiF2
         UNye+U/1GQZhKi6ztmUk/b4LHooNlkTBWOodvu+qcvSc33846+Pmo2Uo+Pr9spIe3al/
         t7IVEPLYItBZbouYS5tPct83xUe8joPoTT7rS+Vo/r1JoQyhmUzUD5Ssg5mcU5FPxRJo
         BTlyv6BtIGv/hIrmv3zIwe3Ybfs6BGtg8jbQxPN16eztxtdACBhkZmjLnozKIcOUq7ta
         mbwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774318577; x=1774923377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXYWZ3Af8+UWCG+9zf8xt8wJvtMCh01uE4kwpvainlo=;
        b=bPM8x6NBxGknS1C2c8f5PJLmbGuw4/Wl/fhqFpQnIVBUwuD92BqPmNv/1I6Gr8z4zk
         2jbeo+Obgzn6SukTfCrZf6PDiVHWIpYxATpr1l2PSGklhd2TvoZYk2X3pxCPnmSUWo5i
         4qPvobQ9vKjEPeOV4qEgFE1x1SZ2NO7sIzaPqNmLHOZvUpAEFQveW60+95nwKc+ClKxf
         9jv+19lZBNMOzj5TTI2MpsVb7yIjdJkjc+a/eIkN7dRNKdFy83mNqaLDswZ7FQWLhkGl
         ogm1HYcH6ZtE60g9zNrs71+YkIDF4lOTParLswYnZz7KcOwjaiFA3qW1i2FeUkyQX8NK
         a6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774318577; x=1774923377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXYWZ3Af8+UWCG+9zf8xt8wJvtMCh01uE4kwpvainlo=;
        b=f0DCgc7W9uppcmpDGSDnpNQyNiM4feWgP3BoeColWSV+/3Pocveh/uy+Z7sHoqD/fF
         m77PjrlUpNGVCGMCilzjKNOplJPvqxKAsIGR/AjuFTsWzwSArWHvoZnHxuIL2zJH05px
         Tul87XZND0oTwHuxXRRQmDEZFO6tkEPj/TWl4swXTIvqYLauqg+n04lJDveYuaotrVNI
         wrqMvOiWBQ2Tpb6XdOKyffSuSYUpig4yFubHu1ZeXVgruhR8SnPNriBMTExQdbiWbRsj
         JSV6vIZkPuVO5xQRlFamQhtEGByYukT3Uy7TqAnyEK+4h2JyE1EJ/tuOIrVuyuLuBl1h
         1y4w==
X-Gm-Message-State: AOJu0YxOPclB07iV8MWepTkcLphZW44eroPYQMx2wnFtQRPR7ksYi++e
	0cvtlxkyyyBwEfWDyIif70qFjdXFc/e3C7AQvEPL1LpRAi3MnnJlIwf87eRVTZP57WB2+qIKUZe
	JMsRyjqlE5zTI0bfIKZ4jtgplkMkEQ2t7tzgB6MgWTw==
X-Gm-Gg: ATEYQzx2J0J5yUjKLhsbSzQXt5EywWSJXBsLwtqrSKRjyrx48AE2ofpjeQL73Oc7reA
	trTc8l1mglQi54sGYBEoGqlVd6c2+JIwpNEy+ru/cA2rEuwATLVOvRlqs4kdqrtkpdp/Gd56b+4
	7glDVp6juQfDREqxtujZm1M0XKaIQlqTM5fmdML6heS+YCtQzRq+BJakkRajkP3mXEsG7okma+1
	SEd0deM2bXdIK3Nff8QT4vYmyweq9sHqlfAy2v+2Tlrtyo90njhZMBxxj7CNFY7Z3XTqD4fPunE
	UcI48nAnZQE3KA05yt3ZVe6A2mvYR9pFBSV4QCSLeOaJVIx99MSNJEsrV10=
X-Received: by 2002:a05:690e:4383:b0:64c:a41a:3a65 with SMTP id
 956f58d0204a3-64ed78937efmr1191837d50.13.1774318577568; Mon, 23 Mar 2026
 19:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323225250.1623542-1-martin.lau@linux.dev>
In-Reply-To: <20260323225250.1623542-1-martin.lau@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Mar 2026 10:16:07 +0800
X-Gm-Features: AQROBzDmBOwVNM8Iuq0GXGbuwKqfn5aRlGcf3rHTrRU9EEzZvW22fo-B-XQzorA
Message-ID: <CABFUUZGdgV9RgsFLnayOisXOAzyvT0szFTuV9miR0MnTxbaiJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
> BPF_PROG_TYPE_LWT_XMIT test runs.
>
> It currently checks ipv6_bpf_stub before using ip6_null_entry.
> ipv6_bpf_stub will be removed by the CONFIG_IPV6=3Dm support removal
> series posted at [1], so switch this check to ipv6_mod_enabled()
> instead.
>
> This change depends on that series [1]. Without it, CONFIG_IPV6=3Dm is
> still possible, and net->ipv6.ip6_null_entry remains NULL until
> the IPv6 module is loaded.
>
> [1] https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de=
/
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  net/bpf/test_run.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 56bc8dc1e281..fb25184ed03b 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1157,15 +1157,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
>         }
>
>         if (prog->type =3D=3D BPF_PROG_TYPE_LWT_XMIT) {
> -               if (!ipv6_bpf_stub) {
> -                       pr_warn_once("Please test this program with the I=
Pv6 module loaded\n");
> +               if (!ipv6_mod_enabled()) {
> +                       pr_warn_once("Please test this program with IPv6 =
enabled kernel\n");
>                         ret =3D -EOPNOTSUPP;
>                         goto out;
>                 }
>  #if IS_ENABLED(CONFIG_IPV6)
> -               /* For CONFIG_IPV6=3Dn, ipv6_bpf_stub is NULL which is
> -                * handled by the above if statement.
> -                */
>                 dst_hold(&net->ipv6.ip6_null_entry->dst);
>                 skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
>  #endif
> --
> 2.52.0
>
>
 Since the CONFIG_IPV6=3Dm removal series also removes the stubs, switching
 the check to ipv6_mod_enabled() makes sense.

Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>

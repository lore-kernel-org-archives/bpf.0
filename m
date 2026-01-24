Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699B14A8E
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769274034; cv=pass; b=TxNvOPOYFCW/ECbcqasltByDCyjo2dzgtp5vYmUpY5UnQAZhZoM1T5clhtmd/pQvDLlQ5YKqX3+82FVNBhluLYdoMnU8Oo3j3l4Wupiw+176LavGeKqG3YW6UxK8PcTVUIcrWGPyJO7VsVqXd4btcbo4zyMbV3sgJQtXxVsAvmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769274034; c=relaxed/simple;
	bh=KuY4XRIu52Qp5+8aW1jRHyNLyOFCxulTOAnLEE5Y4Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5dg9JNcbPphIz15ccEnZ676e8oEtEGQcq1Mq9/CBT3vNh5BP7OehzJQu5RM+p08aPHWxBGChkGpEUwttFcxgiX2xTanAer1MzmTecsC9XN/Yy8Kk9d1D9m4/it+e2GsvZppebuLMkdKk3WsTMk/Y5caQt4uI7u7nUoD/LlfeRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9Bf9Yd5; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9Bf9Yd5"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649523df010so2845748d50.0
        for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 09:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769274032; cv=none;
        d=google.com; s=arc-20240605;
        b=KAf1RU4zImWoaPgITcXV4qqweFdv5DbOUAqmOYNgn6NSbA0CB+84KKlu2xSbyOSl7R
         cjcZnxuTWCF62G4kvIpntUuVbkyKNZ9Uq7XkeWXQ0IROfmy1zYnLxpk/MsUFK8OSSODp
         p0GaS80fNMf9MZu+KeoD0+cE6mXqJbkVJofMyepjNjIZ2zCa4LwxAFwSFfUYyCOKNp6Y
         GDoMrrRI5S6Kb3amVHGd2qNHTHS5GnOC80tJik4NmMTIbocG/FqdyHxNuc9TTsjSB4Zz
         Pn2u1/5umqzK5d6S4b7oSce91Fhh+0N4TC6XmrqmNCoxikBgcaYxOPvTqCUMt/3QUtlh
         2YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uMJdluCy17as4/mLl0Bw6nO41RiQesIQjTHkBOgvE3c=;
        fh=4KubPJPm/oify4h8BPjn9mdYAYp9R/C82vTyHZeZ5Mg=;
        b=i1yjdbhF/cBqgtdLtz2HBFxxl5rJVpXjKFsW5YEQfiJLwHSFlAMhikRGOKjU3IArQ4
         g2kMiVMTGhfIwViAGQ27NtpddGmqKx4OIjY7lcpFNOQjhcTx2iGvUeRY1WmSzi5c5dRP
         9EdGDPvERG86hv/Zz1shqdcKbcw8Ks5PLnY5pwz6cyfCmlK0XhVM63MtUrALPm/O4d64
         LNtSCNMRMDxyuUqmPRAP1YNW8ZQmmudWpbjAjKl+MaSXZraNeSiRH/Exa6C2t87ZyJmF
         5Qco6T77ifwQ3xE5XQhV61991ozBRFfbtuwvrluqSzX5WYj63gg2GF6typm2eiuRZiWJ
         XA+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769274032; x=1769878832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMJdluCy17as4/mLl0Bw6nO41RiQesIQjTHkBOgvE3c=;
        b=Q9Bf9Yd5C8hJVqn5V4aTUcNC1BSfechpU0dr104H8zWTVerdFEdco5eonRAvQLUETb
         eWzIxCc2nY/GoQ6qT3sJgn0Il1PYl51iKqFMslDOwSqQ0UA8gIYaGOwAYumFvMSbNFQb
         NtKQ5bAM9UujNOEdTSrojqs0cHyfcNMQIxuKp8P5aZHhWlzGQ26+tI8NjfDFjdn6ivR3
         mQ7ZogGMS4IA0eYMq0Ec7wA4eQw1qXY3cNolfTzbzVKaIE+es5OwH7/WYxF6ocLJtyZq
         FGTXmj4yck4VglqDzwDIut2hQ6pAwMqC9tHL6XIWivc/XbL2flOpT/pMui2bot62KIfU
         GGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769274032; x=1769878832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMJdluCy17as4/mLl0Bw6nO41RiQesIQjTHkBOgvE3c=;
        b=px77/zUnEMhjcEd/3KBBkY9qoBGR/p7ZXepbgePq4bIQNcvzWosH+WW9w3/a/xEJmr
         lBCWK5aRBsEizzxQKtTXZ3dNu5lrc+PGdKyTa0kC4ZMY8E0vDTSK+v+ukIWpY+Of2s2M
         m16AE8S7/gPg+5aFIZRpuLTce/DhgjHb0sHd/GXjZb+/mly+w78EP5R7grLCGLVN33/8
         ogQJE/OQI30KcnomvSRtpfnQP4yjrk4kFqNLpZ76pPzazJOgvvZGo0SlR8CFkACTB8LT
         4ng0MfeWv7jKIocPuZssFUl7+TQZ6CcngnAHTK/CaxozT8uOdSpgBYYflFxBO0xWB30g
         MoeA==
X-Gm-Message-State: AOJu0Yx/W4ORqNNs8MuOUCUM9huwCre8oJ4RMQv6WbjeM3fl0ASJGpQH
	ePtuYadMVtwWO2o1xaZ0cllhn0XqLKEid17mWCtae8jnJgXstMIP9+tVdPgsP0ED83BWeUaXFCA
	7tHMQ2E4FfkgywDedYvPX5b/f1+6HBBE=
X-Gm-Gg: AZuq6aKa9i9aa/EjBozeN+4EHTeYch6ZXnHUOmHntyUj/ZJ6zo1lvW9O4wPLhA0kC+o
	hh8zQ3ZF7+jirFMhoeHaov2/mAD3kQgPsP4pg0QfIObNQJU37l4FtXR9/tnUgsWu7XiRwvhgCid
	InI805GXyjtBgwiLBi6xLSuELbHSyLXM/LhfAADLRj2Mp7rn81lHDo+sn923eyWlDCPzaA9R8cz
	/156kqbe6Ui4nHZDZ9fsprBiPvX4wMwITTi2SFiXQodIR5d8Wu3TNCz26pg00SH01Q4wh+J6L/H
	reM+SkB6ogSIBLgl
X-Received: by 2002:a05:690e:13c8:b0:643:55d:7731 with SMTP id
 956f58d0204a3-6495c045992mr5603067d50.83.1769274032023; Sat, 24 Jan 2026
 09:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123055122.494352-1-yonghong.song@linux.dev> <20260123055128.495265-1-yonghong.song@linux.dev>
In-Reply-To: <20260123055128.495265-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 24 Jan 2026 09:00:20 -0800
X-Gm-Features: AZwV_Qg5YsGs-UjMqqNtKXlOONrZLxr_nlr_WuAQSgeH58v_peRgYa0NCHQJN3M
Message-ID: <CAMB2axOEtiSGk3SkYVpUQD3MHeEwC7eB+9R8_U4CoOQZng5CCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:51=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
> will close to the page size. On arm64 systems with 64K pages,
> the pull_len size will be close to 64K. But the existing buffer
> will be close to 9000 which is not enough to pull.
>
> For those failed run_tests(), make buff size to
>   pg_sz + (pg_sz / 2)
> This way, there will be enough buffer space to pull
> regardless of page size.
>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Amery Hung <ameryhung@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/xdp_pull_data.c     | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> Changelog:
>  v2 -> v3:
>    - v2: https://lore.kernel.org/bpf/20260122162621.3579387-1-yonghong.so=
ng@linux.dev/
>    - Reduce buff_len size and cover the remaining two run_test()'s with P=
ULL_MAX.
>  v1 -> v2:
>    - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.so=
ng@linux.dev/
>    - Use pg_sz to simplify buff_len calculation.
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/too=
ls/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> index efa350d04ec5..910dabe95afd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> @@ -114,12 +114,14 @@ static void test_xdp_pull_data_basic(void)
>  {
>         u32 pg_sz, max_meta_len, max_data_len;
>         struct test_xdp_pull_data *skel;
> +       int buff_len;
>
>         skel =3D test_xdp_pull_data__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
>                 return;
>
>         pg_sz =3D sysconf(_SC_PAGE_SIZE);
> +       buff_len =3D pg_sz + pg_sz / 2;
>
>         if (find_xdp_sizes(skel, pg_sz))
>                 goto out;
> @@ -140,13 +142,13 @@ static void test_xdp_pull_data_basic(void)
>         run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
>
>         /* multi-buf pkt, empty linear data area, pull requires memmove *=
/
> -       run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
> +       run_test(skel, XDP_PASS, pg_sz, buff_len, 0, 0, PULL_MAX);
>
>         /* multi-buf pkt, no headroom */
> -       run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MA=
X);
> +       run_test(skel, XDP_PASS, pg_sz, buff_len, max_meta_len, 1024, PUL=
L_MAX);
>
>         /* multi-buf pkt, no tailroom, pull requires memmove */
> -       run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
> +       run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_M=
AX);
>
>         /* Test cases with invalid pull length */
>
> @@ -154,18 +156,18 @@ static void test_xdp_pull_data_basic(void)
>         run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
>
>         /* multi-buf pkt with no space left in linear data area */
> -       run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
> +       run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_=
len,
>                  PULL_MAX | PULL_PLUS_ONE);
>
>         /* multi-buf pkt, empty linear data area */
> -       run_test(skel, XDP_DROP, pg_sz, 9000, 0, 0, PULL_MAX | PULL_PLUS_=
ONE);
> +       run_test(skel, XDP_DROP, pg_sz, buff_len, 0, 0, PULL_MAX | PULL_P=
LUS_ONE);
>
>         /* multi-buf pkt, no headroom */
> -       run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, 1024,
> +       run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, 1024,
>                  PULL_MAX | PULL_PLUS_ONE);
>
>         /* multi-buf pkt, no tailroom */
> -       run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
> +       run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
>                  PULL_MAX | PULL_PLUS_ONE);
>
>  out:
> --
> 2.47.3
>
>

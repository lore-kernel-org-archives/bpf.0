Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283C73527
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133583; cv=none; b=jYhmLA9PIdlaZgld2tNCtX3q8BGquq3x0xdJ21IFDlZPDf+JJLJHm4juj8MWdI0pu0oMgNFS/+visjxi9SwaAu9JW06Rrp3tSZeZpfv3AFBk3C7YH6YvYVpVpY0lqyZPjfmLCVK8AmW6DxCzqjkEtpI+X8qig5nMrBQQMJ1lJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133583; c=relaxed/simple;
	bh=9sDutrQpAlcB2a/9Cf2yDfINkIs5tFKJc3tg4Z5NBaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6QD+xrEuJ4J+vXGpZ3Wm38by8DRbH1qEEqYlbNdsMf+daJxAoOpJWaX5OhOSpbvnliDz2vTLpBHTHDawqLsfeH7G1+9icCGcxvSy7q1QxgqZBr+6O6saWr0u5GvBqvbK4UwF7GsQ7gn3pukaU8ekFDfrR61Uu8dx4GAl8f6lvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1fu3Re0; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1fu3Re0"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2607073276.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711133581; x=1711738381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWpsr2dcqIpPgApuZ3dFqSQ4BkljSuKYYTb/9PY3ksQ=;
        b=g1fu3Re0aZYbPwpBtbn8xj8d3t5CUXtWwQk6jZj8gi4kEAaRpXXg1Lp5PPniuagi4C
         oi/DaC/6cS8gDRvJS8O5O1B3EnYaZgQukJp5IyUMloLFEn5nPoPKVY8D6GQNF2k+agJr
         r+zwBB1KXrZC2JJjRocVuH06WJGQEAxdvFzhxmiHTbcWrAVFqptABeo/OAyMstmYVmPC
         eZL2QME8hNvkkkgu4oxv4XsO5I0QMR7gVJN0cYm5dmIMiL9R8Ea6GbIGC7OdK8ot6hKa
         ASqwIXhR2BLr/o8eeQ0ehUBo4tFt1PEBwfkIfW2EnVu1vDID2LuPd31osWCFobYbn+/t
         dCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133581; x=1711738381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWpsr2dcqIpPgApuZ3dFqSQ4BkljSuKYYTb/9PY3ksQ=;
        b=KbkiZ+PXjFrJW7XezjcKM6ICSlzSka9uy46MLJzzt/z8SH/HpAz1T0rKc61SsyNR8+
         nSDnaF7jWBQmk9isZ5+I2jXcwmT3UutbR3LYkEtJxUF+tZcfQkq+aNIKvgZsAIVmxIJE
         B/iqyxZkBzA1zHClOmeRGwDV3NboNJIO9SrhClxHzCwzX5BU/TGy2TOM8GGGrQl2fcli
         hDUQnYCRtJYde466HC0SV86fhJSJ25Yb9Dh1WhaXIiWfjDSGXMmcymuff85Jao0EnXMt
         AxnSU0dfNs9jHOkqJclv7HpkbyoLzB+wqtO5NzO3rZU6cYUzr7PbSiTMm6e2SVCM5VL0
         NjoA==
X-Gm-Message-State: AOJu0Ywc30PBnI9zvuJ7apSWZnucrQObPH0zGjtiVZGwmHwJg+RMyO1J
	ipuMjN/EqzriuvlReP5vLPSYwv4xFaKdIY3nWVJK2yxuOVPwx5ecwh639z1B/0IcstXb4dwYzOL
	x/bD167Fd0HdBVfriddIWWOV0b4v2HsMstW0=
X-Google-Smtp-Source: AGHT+IERNuXmJnZudeWNLc55nLbvNjLREweGv74rXc56OhwrSvREASikQHvJx8P+QUafEba1je6KMmDj6sa9Rog5T58=
X-Received: by 2002:a05:6a20:3baf:b0:1a3:2f19:36b with SMTP id
 b47-20020a056a203baf00b001a32f19036bmr432102pzh.24.1711133260968; Fri, 22 Mar
 2024 11:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319175401.2940148-1-yonghong.song@linux.dev> <20240319175412.2941149-1-yonghong.song@linux.dev>
In-Reply-To: <20240319175412.2941149-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 11:47:29 -0700
Message-ID: <CAEf4BzZTc0H=GkOZPNAuvZ17Jz8W+yqkpBW5k5Diee31ejjiLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] libbpf: Add new sec_def "sk_skb/verdict"
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> The new sec_def specifies sk_skb program type with
> BPF_SK_SKB_VERDICT attachment type. This way, libbpf
> will set expected_attach_type properly for the program.
> This will make it easier for later bpf_link based
> APIs for sk_skb programs.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>

Seems like this was an omission and this program type is already
supported, right? Should we apply this to libbpf regardless of BPF
link stuff?

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a756d61c120..7d413415d0d5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9312,6 +9312,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("sockops",              SOCK_OPS, BPF_CGROUP_SOCK_OPS, SE=
C_ATTACHABLE_OPT),
>         SEC_DEF("sk_skb/stream_parser", SK_SKB, BPF_SK_SKB_STREAM_PARSER,=
 SEC_ATTACHABLE_OPT),
>         SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT=
, SEC_ATTACHABLE_OPT),
> +       SEC_DEF("sk_skb/verdict",       SK_SKB, BPF_SK_SKB_VERDICT, SEC_A=
TTACHABLE_OPT),
>         SEC_DEF("sk_skb",               SK_SKB, 0, SEC_NONE),
>         SEC_DEF("sk_msg",               SK_MSG, BPF_SK_MSG_VERDICT, SEC_A=
TTACHABLE_OPT),
>         SEC_DEF("lirc_mode2",           LIRC_MODE2, BPF_LIRC_MODE2, SEC_A=
TTACHABLE_OPT),
> --
> 2.43.0
>
>

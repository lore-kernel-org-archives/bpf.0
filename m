Received: from mail-ed2-f29.google.com (mail-ed2-f29.google.com [74.125.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6B220F2A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118858; cv=pass; b=Q9QtZYZ/tkxxrUGNvS6wDJsfvh29CpSeMGeRU3ayh2U9gNY5AANdPHsbCMg2mWNGKV3q/ozEQxrcO1HDmd1GV8DOEwB7OwRhYyGkx2JxGfSTgEWGxtn+5IpYlPfLGQFqt6lZaG29fND7ta0S/8ZCNb9OUjQeojJIikwH35H6P18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118858; c=relaxed/simple;
	bh=XzmrFGXevgu0aXvSM1lRNDbtFQ/4dOk5WN4cs/ZFEg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx6JCgNvV1Aevc/KeAC7yPdCyf9K7t1vggEi3cx8qxh8FRcqqe8iAG6Fcif6/2gqUDMIUHvC83Cr6Z5wu7f9dXygZJnJLiD0dZC6JejkLylBu8s59Q7q3vLiIJ4JJrg56cM6BvC+NFZiTKFsJ4xiuYVOwuWSpnuelw08ng3Q8i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/woH7kl; arc=pass smtp.client-ip=74.125.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/woH7kl"
Received: by mail-ed2-f29.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso458769a12.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790118855; cv=none;
        d=google.com; s=arc-20260327;
        b=NYja8zNiteIXK4KcZtlJ1l/P9TUpohG6Cl5k9IRKJ0aUuDQ0eAkbUf+89dV9PgQ+2h
         30V1X9atwwhfDC5YGgbMZEOr/53KebvyUaPu+coTcf+YmNbMbve3ybSSNjOJ8iTsU6vs
         Q3jcntsrPUoyjrnNSBLx8/z3yw5NzWJ4fAHm8Ax45BwOaG6REYZf43eBVwtvC3FMBVTu
         4hwfMCe7K0YPdtZIVk9CyCS6x2NYKZQAssdXG7qGGl4NA/kxQTsYirppjEoTr/wVWHdP
         RjPSnRhj9LEJBMd/Pb3hLaAqCDS0bTeaDD1Qrg/xV1NfLpTiLtZCk3JY6pD4WN+YtTNi
         JixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B0dFRptqRd7KQ3pJ5dVThTpLmZi/C91RkoLlwpKtDjE=;
        fh=05cLMoX63Q+7dal3KMA7lCORvbPwm6d5g2QfFf64IGc=;
        b=r/H7EEHupjyTbLiVxGIBJaRwW5OTwfXehq/MxOAogYphSqc4TH9TcUn+0YZkY0BarX
         Qg0a6knPRIQZ/Ww1aTeBHRCabJPuIsbwLYQeCmiw3rHUnT6amkfOlnGQZZHIHhYySQfY
         P0e+u85OULf/WTD4m/h+O2kD7GJ2EbgdXzVDSxY57k35kTFzjDpCiQ3UfNp0JcHraPkw
         E+1M5iGAkPCXX0pGybtd8nL+x2IAuAJMmXxc7oYqg/1vqjhW+317uvbWxdMYLtYG8P+3
         XCtY7qhk4DT2eWP1qG4OU9A3d9cTrBCBjU5sqTKB9xhijLu86MrPPNcGLdJ867SmZafn
         fyPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790118855; x=1790723655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B0dFRptqRd7KQ3pJ5dVThTpLmZi/C91RkoLlwpKtDjE=;
        b=c/woH7kl8+72JTvu1sv55cGVhVvYJm3o2axYMY+5gkTj9C+JxmH+FLgLAF6Yic1rgd
         LLIC4HRmVjTy1FETKAe6dNwDrwEcyquq+WACGaP2WsM7bqFZKl1oKFN0bGYos81mJcsX
         6gz9aCmHnl2S5axn+ZIDLBc7qIYrDMexlweajWift+9Au+eaOYth5ON831imO7ulpKPh
         rpk28d94HNmtL2TTaJ7VGWO/yHy/l2A6+uZTR9fx2KhNWS3qNqRQ9tQvtHlW9/GQIW/v
         OLUWdUX1hsPP/+tciqBjWAWFbu5obxkeKIcaXZ3RrKFb/gvS2BDBF3FMerrlBxQpIUiO
         Rr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118855; x=1790723655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0dFRptqRd7KQ3pJ5dVThTpLmZi/C91RkoLlwpKtDjE=;
        b=SRMZJY+DFV4GXSYL5HV9X5GvpxHk8Mglj2sfKc9n7VB+SawJaWjCUG4nWNr5lTkdBn
         kofmcUN27qN9jHnaJ2HIC9ivvsbRzZEqn6aqIRztwuBXtTqSrbJGry22H8fD6g8isbFy
         zDHgBOZ6OppjwXZA1IRn7kcZloAu0JT6Ax+Y60AdO07AXX3w9nturCUxPMXDkSomRZdz
         f2Mg6+8cHhNTJRrnlGrfcZdeHlRDTamIfAcEEUSPKJSTMSD1vjLbemX4SoBB6uRUwADT
         +ZisFs+b9CYt9FJ6bGRNEbVOUeR/MmPA9Nr0XYp/sW4LAK9y1bSyAN7+9Oplha2TS6KC
         Krpg==
X-Forwarded-Encrypted: i=1; AKwUvBwuYcBRmHuUp4iImnhnSlynROLn/QGBKbmy+Nqh2uAN2UMEaSu+N2oh9C3LY4SJGklDD28=@vger.kernel.org
X-Gm-Message-State: AFuF++lm+K03W13+5v/DXGBaLHo0ed8PeS0vAKAs+GvnETEDkj3EN9fi
	0Go//I2jdJVDG9LROioO7K7d8X70wRzdg605fYUMAbKgcYDeYcIXeH0Wyb1nqf/gvBP0EiudLy2
	l/uTacU44RipL9iys/W/G2M0bXQO6EWdN2YTu9dU5
X-Gm-Gg: AYBFou3oWxsb8Sh4SawDjLINY5CUQETMMmrruR2Y9AcR5vpNF/CNqHbeLQjhQCq1s2w
	/1fTQnM6JcoW2b/PqCS/KbXd1Ua2+AjzuWBqt0I/qGznfArXAwEeqHtZvnRCq8txCRQ+z+2qh5T
	YPQCxUJwxj2Nkj0D02M4EYACV6fIe/waOZqamRKr2Zt/zT2m3KA4XmWthLECS/MuLSF5RkCID0N
	4A6B9tlAnvuNLPRHhjzldZabCKcNOgDt7J3FawIFRZf84TUwB19H6KXCNSNKqhDj1/+gV58rLZt
	+C2i1hYD/okhb3Q8BiE+Ok9ZL1HUFTwE0AaXzsV0U2g7aiH0GwYlc7NOV3jCAvlWxWKGoKUfyn7
	+p3NjVYewOtkeyBkaqXN5EDUiWmVCijlKYxldfLqE5pGUwK4OOi8EsFrHWDRG73Jo//3o8QXzRb
	kQGkTE9ZgUQDdSyb4bAOdVlg==
X-Received: by 2002:a05:6402:42c5:b0:6aa:734b:1a33 with SMTP id
 4fb4d7f45d1cf-6aab3b87f76mr617243a12.45.1790118854995; Tue, 22 Sep 2026
 16:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com> <20260920195633.3033620-8-kuniyu@google.com>
In-Reply-To: <20260920195633.3033620-8-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Sep 2026 16:14:01 -0700
X-Gm-Features: AclHuK98iIjsApxg5DATUyS2svgHdgR8okQeN0Kcw81aR5LsnSsr5UG44LuOVk4
Message-ID: <CAAVpQUAxLHoXGX4H32SZ2_Wjwq9qnkO3oheQL_1Z8FC4QsiqgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 12:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/te=
sting/selftests/bpf/progs/tcp_autolowat.c
> new file mode 100644
> index 000000000000..bb96e19e7589
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
[...]
> +static int tcp_parse_descriptor(struct tcp_autolowat_cb *cb,
> +                               struct bpf_dynptr *dptr,
> +                               u32 seq, u32 end_seq)
> +{
> +       struct rpc_descriptor *rpc_desc;
> +       u32 rpc_copied_seq;
> +       u64 copy_len; /* u32 should work, but not for no_alu32 :/ */
> +       u64 rpc_len;
> +       int err;
> +
> +       rpc_copied_seq =3D cb->rpc_desc_seq + cb->rpc_desc_buff_len;
> +
> +       if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> +               copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> +       else
> +               copy_len =3D end_seq - rpc_copied_seq;
> +
> +       if (copy_len =3D=3D 0)
> +               goto disable; /* FIN. */
> +       if (copy_len > RPC_DESC_SIZE)
> +               goto disable; /* always false, only for verifier. */
> +       if (cb->rpc_desc_buf + cb->rpc_desc_buff_len >=3D &cb->rpc_desc_b=
uf[RPC_DESC_SIZE])

It seems clang on my local host omit the base pointer offset
from the comparison while gcc used in BPF CI didin't and CI failed.
https://github.com/kernel-patches/bpf/actions/runs/35774477359/job/10691055=
8464?pr=3D13945

By changing the line to

if (cb->rpc_desc_buff_len >=3D RPC_DESC_SIZE)

, CI passed.

https://github.com/kernel-patches/bpf/pull/13991/commits


> +               goto disable; /* always false, only for verifier. */
> +
> +       err =3D bpf_dynptr_read(cb->rpc_desc_buf + cb->rpc_desc_buff_len,
> +                             copy_len, dptr, rpc_copied_seq - seq, 0);
> +       if (err)
> +               goto disable;

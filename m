Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981612BAF8
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771556031; cv=pass; b=LIk9E9vs61rsudxTD4BnnVP9zESKLiBd4SMFcq9fgOflR1089rq3pPOgNe9Z3fsI7M/O1UrHeACo0vnAadFybZw/8efbZeLRDXoFzrGFbEq7MSQNyj+cUJNU93Na7oS9PffNn8ViK0HKwEd+HQIfmsWCsKmgDDq5h1Z+XykOSyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771556031; c=relaxed/simple;
	bh=4ZweesHW/El3kcS4FuZpUAzUaUkj9fi5Jawtj2vboSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNTXzT2Ngi5osRrxtCNmEPifKj/414SzvhDUEmJNgoaH+IKtROMiOVvzT/mlfNL2pUvK9LX2LQoKu0j7xEi1h4FDnaGoZpJSyjvnIHTQlL/nqcOntfZLfTmSRgV0beLvsE/3yJvxkYKVG2hcIHISGkpV5b6oFkC4DlE6N3wbt/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkoB5E4k; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkoB5E4k"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362197d174so1023106f8f.3
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771556029; cv=none;
        d=google.com; s=arc-20240605;
        b=EL9SvlKQ/m0xdramNt+CBjFWCxMn/E7/ssJ1nX4cX4CLGPA/V0o3YDa92LcYOTvgTZ
         J7RsNXe6bkJxxC32eMy/+qdgXyxsgx59QXMo8YdAnQB8EirBqfLMOou9Nh5NjM8hWTUC
         lmC2qw4X1aHKDQk2oLKptX8mceNEsfaw05RyACj3tHWW5YGw5vrPaYF9ZX9+m2NwMPSW
         dxM9bcFCwps79bmQ22UXxGpjsIpln+3QjGmHT0kDwbY8v1gTdhM7o8ZHnOJp4DWeB8Za
         ZfYK/VVQiFXLp+8SqQPJ87LygbH1+WWrpk7mk+7iDNliyKrCk+tNRzq9/OcypUJWd4Pl
         TNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XclhKGEMPuoe0CG+SPJejZcbwGMnNs0QnOy5CoQQz/I=;
        fh=QDvfpXeYrmSU2PgJEUpmUNgwZ2UUaFfLPX6y9FZDKfY=;
        b=EiMR6FPy0oxUP4bhwONzmeqyY55H26SGExhdmm9Tal5rUutJwEYmORN/6ujWXxXo/g
         029GBUmSBEQ91lrO41EaI88B5Sz8bKZD2MvJw2i6f5xPlMwZqi5ynsyZXhsrpFqADc61
         /OnvSFpG+jw8spLVjYW1LcwvijCTtphIB3lwilV4kgAuDXTALvg7p+xIfquYveCy43CB
         4i5jfhO+fDP2mRsB/CJ3+V2peeBwiW5lrVm5ZMBEIprAKh+BKi7D0QHTEYytwf7BkGzX
         dda+CudtXBkDKDjRAFlGx7XOerCoFmbi2ekglDbHmr5zvljyHEXRDWUazYUrvtyronCZ
         Rh+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771556029; x=1772160829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XclhKGEMPuoe0CG+SPJejZcbwGMnNs0QnOy5CoQQz/I=;
        b=EkoB5E4kxUGOjYS/Oq7bKOzqquqQJwOhgmV4qbq0vD16ZpsYQsGGUzzCSgQLEo1AL6
         FhmQYRIoO2eEE4Q5UQPGktqIYCOo7VTDgkiUFFTeNfvHA2FZlLvXcdSuaY7rQQZ7lnyr
         9ZQp5I3rcYla78ms7Wwb6zM5hid3CaQOFp2Wuf/iKacqp6pARzrlSAMaNJ9Wz23cAdAH
         K2f5A7AU+2Vd//HRdWUzd7KQIfma1J165UUvEa9qIfhCOXTBMSjeAoRZnl5WKL15kG4L
         xjg2XDoa7rxyrcVcGLaqCGxIGvmP6jYb/XQ/+owXcUuxJ4P2jtFP23pptymImKKGbw4G
         SSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771556029; x=1772160829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XclhKGEMPuoe0CG+SPJejZcbwGMnNs0QnOy5CoQQz/I=;
        b=nWRy58HBwmxt8bfYVEgEllyOWT9GgBBK1AuBbfL+4htQPMrcY87RFEUaCihElw7nPj
         Op2XhIhqt1boWXjYkBrzNf2M2SEBLCG/jxeyzmfIN60Jpn0dVMwsDP+DGqJonAl5g5L0
         i47Ctmfu5m1v5O0W1Xq2E6Kntr2g6ZugN9HsB2W3uH+R+qqVfd36Y8hk4LV34g8t4ZFY
         9QNDeAnwQqG/mmgb5HldLxzJar+CGjhHemOf7Dw4I4EIxlYyM1zO7AfxGJc4KfqrZ+WJ
         qlwXj47Eq5q6iWLj1yMBp2zbkAVkhh/t7bYKnMib69mRN9m6s9FGmY1LHGfTn8gTxFAC
         TqKQ==
X-Gm-Message-State: AOJu0YxgjqJAxc/yAYbtX9tR31Hr/jGQtsJpjtQvhNBA31AZyxYJGbsP
	Xexx+sdzKN6B4orLUTg5h3Ma2UfDXZBEXFLe1Wca+iTqrnlcX251Fp+LMbwOW01QWUA780MJZj2
	HXb2ImlOwRYB2/Jo8oIJKkPAA7oxUNXY=
X-Gm-Gg: AZuq6aK2oebLf2pV9NRQAU3q60Z7vNQ3QiutmHOEjqj3v5OC+XhkD4bbHHTaffIXSmM
	NeDUjCyIVSFAqvvf5CUvZGvFV24y52lbogGwuPZFZNagsxivO4Ff1C/ULZo43h85IZ6NvDGnqfc
	s3rFqy9NIUjw6bldczvwdwn711AgNe1RRJYT9kn9CxtbhX3WS1L2smLCTph0iNWeG042MqL/mkV
	keIG2Id3A9A1/af7c+6neo4kPEcM/ejSZZuhkve///qZNvj8FAsV9AJPDV1+aE/N+WSdT9ppF0b
	Kc1XndehaomvUc6Ojwo33lWeukfP0C2f+xGrGCjlsqlszKX/HO+UeyygE2gvwdSgsBhBXRIiHbV
	oG5nOkcas3+sCs+rCFg0dEClpVXzJc8E1q+EL
X-Received: by 2002:a05:6000:2689:b0:432:5b81:498 with SMTP id
 ffacd0b85a97d-43958e037abmr11871132f8f.23.1771556028711; Thu, 19 Feb 2026
 18:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216145306.96108-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260216145306.96108-1-anandkrshawheritage@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 18:53:37 -0800
X-Gm-Features: AaiRm50WeqM_XdU1pVUW8HVyIvZxa-UEV7BN3MvVxZQJFRMSw_YWtv2ChsrZEp4
Message-ID: <CAADnVQJnZk+=OwUEyf+grv4wj5T+Jz9Fw=v_pAdTLOwqT3o4Bg@mail.gmail.com>
Subject: Re: [PATCH] bpf: devmap: hoist loop-invariant xdp buff pointer setup
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 6:53=E2=80=AFAM Anand Kumar Shaw
<anandkrshawheritage@gmail.com> wrote:
>
> In dev_map_bpf_prog_run(), xdp.txq and xdp.rxq are assigned the same
> stack-local pointers on every iteration. xdp_convert_frame_to_buff()
> does not modify these fields, so the assignments are loop-invariant.
>
> Hoist them before the loop, matching the pattern already used by
> cpu_map_bpf_prog_run_xdp() in cpumap.c.
>
> No functional change.
>
> Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
> ---
>  kernel/bpf/devmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de..568477ce7 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -341,14 +341,15 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xd=
p_prog,
>         struct xdp_buff xdp;
>         int i, nframes =3D 0;
>
> +       xdp.txq =3D &txq;
> +       xdp.rxq =3D &rxq;
> +
>         for (i =3D 0; i < n; i++) {
>                 struct xdp_frame *xdpf =3D frames[i];
>                 u32 act;
>                 int err;
>
>                 xdp_convert_frame_to_buff(xdpf, &xdp);
> -               xdp.txq =3D &txq;
> -               xdp.rxq =3D &rxq;

Compilers are smart enough to hoist on their own,
but with this change the humans would have to think harder whether
xdp_convert_frame_to_buff() doesn't touch these two fields.

pw-bot: cr

Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8E2ED17B
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931011; cv=pass; b=HutCpKwfO4ozjZj1zjo29hXkYKj2pJYO+Hd2QSHC5T9XrHW62tHkllyXKbvdvmxN7l7qX1mYQ/JDi63kMhOGICwkPaByqyTUhLAVj8O2zWmoHKBY3Rw2ymgsXI+oJDMCWuyFeCdU2CCWnfyly6ruAyCyj66KYeE6J+NT1It48Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931011; c=relaxed/simple;
	bh=yvcW02x1KNbc8+q/RDgH4lZx+kL+dYQn2iR7/553JiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6qkoZ4/YCwdXLLQiinnXk0tDkZaFcL/YYIfPGK6efkBKpc8ruu//Fvwdsbvjtdcd3AsmP7DAOCg6TupYucGyvUMbjCR3DuJ6orYMj+P46tTCg0Uqo6oTSkzZ5SicrWsCD05Z30ZszOG3mnShgm8z2WUwfHAGeDUGgx9HgNRnao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz4XlJxn; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz4XlJxn"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d70c30767so59429f8f.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775931008; cv=none;
        d=google.com; s=arc-20240605;
        b=HiLs3zGRDaZ0Q6ejKb/O0vzyuvd9gJgUxeKy5VHwp6WK3uEh5NZGmIH4xFErFs367v
         zLV15VyBfuNn+vyKrMs2is6ajj6bY8nCjg4oHiIFkPF6/HHvELWtxKCoquO4WdrdWEj4
         /EHu2wWcuVXE0ionRk1P2OQpQAeZAlzFvLUTXstZiA/47gHKad6SGGBZTrCjJyBXjuHM
         iF129KOZioXSj1uInOQTZGlJlnIP+7xRnJp3iglEDOCKxaFWaT0z0yTt024bVJTJiDbS
         qo45j93VMZNXLwyoqBCN4Ge0zbJWWgvMkDdzRHEhWAVrjxXuKAtUV02VUboBIDLMwUpx
         h16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/7dYnA2K4xT6LPd1w0Mqp4/PRNYQI3twve+b/J/BZA=;
        fh=bDDEM18lcmV1PrlC3b9UedbqYoS6CR0ZrRtZmmprsOM=;
        b=b6EGguwD7Y3aL+LBUuLzkoYpFBYKWLUaSvZW9ce7qDashN4on1mOZr+1A3sxF9xCsA
         HZjSBIQjuAfU+4B6JAQTzRXF/LquaB2hrhq9egvMqr9r67Kf1FrcjFqIFbbJrfcD1sbT
         hiBTTYbF43Yu1wpeTYE4J8WMzaR4w+GHbjA+sb4UZ4aVHpsGXtx0YS6bsJDodKcNsA8G
         mVLZ+e5YkS9Bej+Y8B0NF3iwuMPr/VN1m6IzSriwHJvwq0YUFMwRjqIjK13MkzNHwOMD
         4qC+TaHZIaygOfrkWpVybhHRzH0id1AOi0zki+ClWKYvlXGIwq+Khbi436n3cFHD+qtG
         rd4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775931008; x=1776535808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/7dYnA2K4xT6LPd1w0Mqp4/PRNYQI3twve+b/J/BZA=;
        b=Kz4XlJxnybR9zYLKc9uHx2nKfgOZ7H4Ow6eYj9Zj8YG2okH1pibUCaPgvRp/CiGJOp
         S9Cx/dX9pHvA3+yp0xQfmHpKeSNlxwozlMD7cyDh5fuc08OfTrvSKBFt5i3vKNdELc+X
         QxzsmedcugLCfARokQAhRxOqxiaUw9nTfunzN2X4K2JOl79wtpYJjzP4C0OUWZSYgzp6
         6NcWTG8DYWOku4bRoGMx7M+OE72FyMhelWPlM09vTKz76dtAOehdVltq+0sM6W5yc3gM
         LhnoVn9k/3ygd6hgKoLs6bnmbMelL7rkTgQnViCWka8iGuzJMh0dZ81YQ9C34Cd6OSFD
         SaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775931008; x=1776535808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/7dYnA2K4xT6LPd1w0Mqp4/PRNYQI3twve+b/J/BZA=;
        b=nDqoundqzQapCmspFwkYpIKEEbpY+UFimjZCyofqRkLvp7RxzxKnswqOsv/J99p/+X
         pN8ZyVsbpRubv1nYTb900B0hwGbF40WiuvhU7sX2/z2q1d9ONwzb5+Zr3HiRxeLoO21L
         ykeJ7KUecJv8Fu6gMygwfOyosPLlTZ5gSYc9JFmdqNLH0rkYzmDQrI4+IwD4Mzirm6gX
         7uI7dqmWoqCsNKOEIOcQ6FgK6GOKU8grRh5Gib+PR2lAVYZl3MuDKMNhpbSxMXe8q3oy
         ubk60285axMLk1P9y9uK0CqyttQmJcENljKbz9CC5ByzezXFofmFJ0rHzIyNzQjI4TZk
         gFaQ==
X-Gm-Message-State: AOJu0YwD0knEiEKGU4qci1rOhhIfH2Aw+nhSdrwDaGowRhC+BPEbXzbr
	i3MzlDPOTiPk6eh1lQHR1To5a4DRKSvL5av4q3OOuM4Rj3R/NlQmoNWZXsHI3SoYhD1l42slioL
	y0RfIk4bpfvhJDJCLTlUeTbNUgOKu5nE=
X-Gm-Gg: AeBDiesDpuKGcWBe9a3ARFt+I4cksIRjCOB39Wg0s7odfx+U63hquDIdUG4z+D3CL0H
	OPwmRt93rueYjifRHNcpMWbh7ffs2GrL9m3iMDkc3kynfDJYequsLjqUWTB/xBRiemv4Te4Q9ir
	zsUFADow8oS2bS8fOQsNpsamQfxODhqPYabVzIFBVdbM/hP9L23FKJOGwlc8vzgnxJIIgpc4jc3
	GU+O+8Ka8y5/KicICT5f6tW8H7YDLQIeQzQrVaFYzhE3j64wykqrvm1Q56530c5VCL4dQtyyQO9
	iO0WuBckSpmHTYVAH269u+hfMpArDA1aveZxLraMEYVAdO1jVNioyyGS9VjiSpv3QMm3p6OyiJr
	NDnbMtswyEKXzBrKEVORFyFcW/g==
X-Received: by 2002:a05:6000:4b0a:b0:43b:a16b:ee69 with SMTP id
 ffacd0b85a97d-43d595cf8c2mr16086425f8f.24.1775931007845; Sat, 11 Apr 2026
 11:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411175134.771552-1-azpijr@gmail.com>
In-Reply-To: <20260411175134.771552-1-azpijr@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Apr 2026 11:09:56 -0700
X-Gm-Features: AQROBzDujJvl5xUrRjTM_VNS1HlF3KROSrKOJXIZiSQeN29h2QIoJ69GUdo-T7o
Message-ID: <CAADnVQJOKc0zP4=-STEX0szgzUeS7RaxQTtre=P92R0UStug8A@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:51=E2=80=AFAM Jose A. Perez de Azpillaga
<azpijr@gmail.com> wrote:
>
> When a packet is redirected to a CPU map entry,
> cpu_map_bpf_prog_run_xdp() reconstructs a minimal xdp_rxq_info from
> xdp_frame fields (dev_rx and mem_type) before re-running the BPF program
> on the target CPU. However, queue_index was never preserved across the
> CPU boundary, so BPF programs running in cpumap context always observe
> ctx->rx_queue_index =3D=3D 0, regardless of which hardware queue original=
ly
> received the packet.
>
> Fix this by storing the originating queue_index in struct xdp_frame,
> following the same pattern already established for dev_rx and mem_type.
> The field is populated from rxq->queue_index in
> xdp_convert_buff_to_frame() during NAPI context, when the rxq_info is
> still valid, and restored into the reconstructed rxq_info in
> cpu_map_bpf_prog_run_xdp().
>
> Also use xdpf->queue_index in __xdp_build_skb_from_frame() to call
> skb_record_rx_queue(), which was previously listed as missing
> information in that function's comment.
>
> Also propagate queue_index in dpaa_a050385_wa_xdpf(), which manually
> constructs a new xdp_frame from an uninitialized page. Without this,
> queue_index would contain stale data from the page allocator.
>
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
> Note: this patch was only compiled, not tested.
>
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 +
>  include/net/xdp.h                              | 4 +++-
>  kernel/bpf/cpumap.c                            | 2 +-
>  net/core/xdp.c                                 | 2 +-
>  4 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net=
/ethernet/freescale/dpaa/dpaa_eth.c
> index 3edc8d142dd5..00e36b0ac74d 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2281,6 +2281,7 @@ static int dpaa_a050385_wa_xdpf(struct dpaa_priv *p=
riv,
>         new_xdpf->headroom =3D priv->tx_headroom;
>         new_xdpf->frame_sz =3D DPAA_BP_RAW_SIZE;
>         new_xdpf->mem_type =3D MEM_TYPE_PAGE_ORDER0;
> +       new_xdpf->queue_index =3D xdpf->queue_index;
>
>         /* Release the initial buffer */
>         xdp_return_frame_rx_napi(xdpf);
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..6db10e6a8864 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -297,10 +297,11 @@ struct xdp_frame {
>         u32 headroom;
>         u32 metasize; /* uses lower 8-bits */
>         /* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> -        * while mem_type is valid on remote CPU.
> +        * while mem_type and queue_index are valid on remote CPU.
>          */
>         enum xdp_mem_type mem_type:32;
>         struct net_device *dev_rx; /* used by cpumap */
> +       u32 queue_index; /* used by cpumap */
>         u32 frame_sz;
>         u32 flags; /* supported values defined in xdp_buff_flags */
>  };
> @@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xd=
p_buff *xdp)
>
>         /* rxq only valid until napi_schedule ends, convert to xdp_mem_ty=
pe */
>         xdp_frame->mem_type =3D xdp->rxq->mem.type;
> +       xdp_frame->queue_index =3D xdp->rxq->queue_index;
>
>         return xdp_frame;
>  }
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f05..448da572de9a 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_ma=
p_entry *rcpu,
>
>                 rxq.dev =3D xdpf->dev_rx;
>                 rxq.mem.type =3D xdpf->mem_type;
> -               /* TODO: report queue_index to xdp_rxq_info */
> +               rxq.queue_index =3D xdpf->queue_index;

This is like 5th time people attempt to address this TODO.

Just remove that comment. Don't send broken patches.

pw-bot: cr

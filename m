Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F638E5E6
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496029; cv=pass; b=byte0LJzH9SjHo7qfC0WWZkodJ6zY+IWdX8tep+qQfhnJGJqJTzC/bYjppqG0dnY5DL+uEeNcW965Ct+RddkMlofGqgMU/khzlvLiY3C8C5xeytxbrEND3X8HFmMS6aM3KAn+c8PRNmzFatVzgw0zmfFIe6uRnaUldgHbdXmHkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496029; c=relaxed/simple;
	bh=lEVBCbF6QFJjszOEOEjrEA3iMIh54Y/X+DBW0VL32jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGYdZStlPlLrNq9gC4eczsS+j38BLKCiNJ7bUgQ0PfQD4z1W6R41KbeeSrBQlBMFqdrKS5u5fLxHQ9r47B3qmu9TxqC5wPhARWmXym3qMNsl3ej0qUGB19Kf1430rJB4Iu8eHQ6YpUiErkMg69A8gbXLn4V7qRr48ubP7KVuXKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhMBbiaE; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhMBbiaE"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2461268f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775496025; cv=none;
        d=google.com; s=arc-20240605;
        b=W2v92JWImPY1Avw59mnbUtd4z93BlYH6H/DQCKRrEc7v/YSwx2WiIeJ/cGB2Gaciez
         qc1MsDZzEHLyaxgfokPN4S6dDcgddF1cYrJUSAXpaFF0bbXkdAqjskgXXSGnyJ3T0aFM
         mGG86G2bvDb+8mWx+S7debkU08A92oTeb6OBBFYnhmI+wNE/sMkmwa2/SwgWA42u0Ahl
         s/Kt4EbiKpGnGPquCVRzd+fsdzggl9cNK7AIR52U/DwkbB1uuyZkLKQ77OQG2EwAwqLb
         ND3aG5ZaOfex3XAhCytByLlho20sxXOe6A9hjDzyXt6Q0ULjAsNqp6EZVnje4WfdDA0M
         5kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yjU+cEeids6ZXiki+2FnGVHWSPIFkcoVpANND97XwaE=;
        fh=DKzUNIUqUP95TGag+Q0uDky206OkL75xDe4D+E/+wGU=;
        b=eOgx1IspLOTP22VoFHME4K9UZVUAHJS9UNlQzBYvjf5BxqzFxmnxJ/+BSU7w1zxAZr
         DBmLVmTNB+SItPPtQt8ry85+4WQBnt0tgNj6J7O/fqGoKMYkjnLqfk19aOu6evSJPbY0
         jydPWyrbLveqjG6sUJfMBg5njIJLQ662f2DQA3/moknthKtnW/FwA68isvKpOr7eAwfF
         wzSXpt7sNHsrih/VMg6c5X3XBglqZUKn1yZSq75dNWCqegE0cWsjUFy9Y+uT4aVD6cb2
         Ote17uxTTYh8ALGMR468Y+pcorp1JXG8FV/PPgFWijJGqnVMx8gpPuH0u9m2cQrul4HP
         wSnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775496025; x=1776100825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjU+cEeids6ZXiki+2FnGVHWSPIFkcoVpANND97XwaE=;
        b=IhMBbiaEQ3EaQiJN7tW1NgdYw5ws+vZ7VHOdosabxCGuqWGEBYD9BSXdamr7hXMhRd
         5RAKArtmXYwE14so9z/IIgM5ft8VUZ9xIOfaxfUGmDcKyxqfH1byA9Y82PoJCT7PLaRJ
         07pyuHehhGvQCl7v0Q1MnsFlLRj5+lLW5c1nDHIRujf3Yy38Q/vtBgW3mS6iUXBn/WWr
         oc+8WK2S8TLPrzYQKfJEbqz5ZxLdsaCtQCWScr5wVOMUVBndoA6GFM8HazfIYHenKNWS
         jyLq700zbVCaRiBoFVBniJK1O6LcDJkF0fUOQUUjeNf/C66ZOxcH29pQ7AJ2pgo+YRj9
         dndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496025; x=1776100825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjU+cEeids6ZXiki+2FnGVHWSPIFkcoVpANND97XwaE=;
        b=AVI4MG+HYQEMcBWvas/bX/jV7LQjX3SwTy2IYdooZNZdxOvvznFZg0IqM0dlOEdOQn
         h/nI41v94I8YybDIxWKe/vHJB+7QMQMVYImZ1saadYsJI33cqr4grcx2zHcAFk7k5IQ9
         AUl4KSIUJ1Yzth900UOOkZLgn9O9cD0fh1FRmLIaDg3o/LeQvIbqUCPz4lUqYZLJhiaI
         oqsyW76RMxJXBReoLIZ78iKY7tSwZxINGmKABgyDbeaYYF4ntnAawhyFObPFeOvZu5Y5
         Mhbqyp4Cd4eYughTFYdZlBobrevhh/C3sk3Uxd5Swd5CP0pZbGm+11ljR3c7/qcr4mnB
         5tdg==
X-Gm-Message-State: AOJu0Yxcdc3nEdVodb2yOBYtFwW8Spp9judJcq5zOPQhL7w18o6t3hnx
	HQyLy3gxdFT5HYWkk6/1LFGqNYqYm4cQrjKYbAE6vwE6giV8sRd8srNWGYmRszOyJPzMF/1Rj7P
	kjN09B4RhAbhqz9XhByAcB2l0jvC2k5g=
X-Gm-Gg: AeBDietmMM0wu+oEq9TEZeCcVs3vb9J8sf7VG+2dvBofKSDYUYm5GVXmN7VK9pC+Gfn
	IakqcxY9r0H8bWzFmAA2W7wXQ+z9xIsDo6XqF5IkVzGcdWAyI+pj2uJpajOGtP4GFB3fDAVMQl8
	dLfZubLgcjSoVPvTvaJfAjrMrJTFx7aXcJCsgs5u7pWjG9t4h9WQPUpzCJwelpfwHH902W2OmjF
	1pmFoTEqgRO9GRrvNJHG2KHSf2gAPEucsf0xAQfw9fykKzGi7IaxrYXCnRub3pEZTJjWVQRt7go
	9e0Rx4TmBW/lMgejC21oiX+ujUwrkPSWuRkYW4XdZpEXZ3UnfvmTtPFD6OZK5OmEYyJqT57d50+
	a03P4uIPP5xQXUfyUxja/xAWMSSaQ6iJMiQ9q
X-Received: by 2002:a05:6000:40d9:b0:43b:a21e:9c19 with SMTP id
 ffacd0b85a97d-43d292e285dmr19844678f8f.38.1775496024627; Mon, 06 Apr 2026
 10:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406171226.13325-1-adithalex29@gmail.com>
In-Reply-To: <20260406171226.13325-1-adithalex29@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 10:20:12 -0700
X-Gm-Features: AQROBzCJrAIPjc1lNvUC2waSuVFGs8aY64CSTQYbWx5bOe0FKmdbvpEHR9AdD04
Message-ID: <CAADnVQ+KGMhpsrc1PXVVwZMD3WXf2OqD43rFiADDryrNuCfA5Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] bpf/xdp: propagate queue_index via xdp_frame
 for cpumap
To: Adith-Joshua <adithalex29@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:12=E2=80=AFAM Adith-Joshua <adithalex29@gmail.com=
> wrote:
>
> cpu_map_bpf_prog_run_xdp() currently lacks queue_index information in
> xdp_rxq_info, as struct xdp_frame does not preserve it across the
> xdp_buff -> xdp_frame conversion.
>
> This results in loss of rx queue metadata when frames are redirected
> via cpumap and later processed by XDP programs.
>
> Propagate queue_index by storing it in struct xdp_frame during
> conversion and restoring it when reconstructing xdp_buff. All
> relevant xdp_frame constructors have been updated to ensure the field is =
consistently
> initialized.
>
> This introduces a new field in struct xdp_frame, which may have
> implications for structure size and layout. Field reordering was
> considered to minimize padding, but is not included here to keep the
> change focused and avoid unrelated modifications.
>
> Feedback is appreciated on whether this approach is acceptable or if a
> different mechanism or struct layout would be preferred.
>
> Signed-off-by: Adith-Joshua <adithalex29@gmail.com>
> ---
>  include/net/xdp.h     |  4 ++++
>  kernel/bpf/cpumap.c   |  2 +-
>  kernel/bpf/verifier.c | 12 ++++++++----
>  net/core/xdp.c        |  1 +
>  4 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..11aecf84a896 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -301,6 +301,7 @@ struct xdp_frame {
>          */
>         enum xdp_mem_type mem_type:32;
>         struct net_device *dev_rx; /* used by cpumap */
> +       u32 queue_index;
>         u32 frame_sz;
>         u32 flags; /* supported values defined in xdp_buff_flags */
>  };
> @@ -347,6 +348,7 @@ static inline void xdp_scrub_frame(struct xdp_frame *=
frame)
>  {
>         frame->data =3D NULL;
>         frame->dev_rx =3D NULL;
> +       frame->queue_index =3D 0;
>  }
>
>  static inline void
> @@ -392,6 +394,7 @@ void xdp_convert_frame_to_buff(const struct xdp_frame=
 *frame,
>         xdp->data =3D frame->data;
>         xdp->data_end =3D frame->data + frame->len;
>         xdp->data_meta =3D frame->data - frame->metasize;
> +       xdp->rxq->queue_index =3D frame->queue_index;
>         xdp->frame_sz =3D frame->frame_sz;
>         xdp->flags =3D frame->flags;
>  }
> @@ -419,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff =
*xdp,
>         xdp_frame->len  =3D xdp->data_end - xdp->data;
>         xdp_frame->headroom =3D headroom - sizeof(*xdp_frame);
>         xdp_frame->metasize =3D metasize;
> +       xdp_frame->queue_index =3D xdp->rxq->queue_index;
>         xdp_frame->frame_sz =3D xdp->frame_sz;
>         xdp_frame->flags =3D xdp->flags;
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 32b43cb9061b..e475a732ceca 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_ma=
p_entry *rcpu,
>
>                 rxq.dev =3D xdpf->dev_rx;
>                 rxq.mem.type =3D xdpf->mem_type;
> -               /* TODO: report queue_index to xdp_rxq_info */
> +               rxq.queue_index =3D xdpf->queue_index;
>

nack. please do your homework and research the mailing list first.
Other people already attempted removing this.

pw-bot: cr

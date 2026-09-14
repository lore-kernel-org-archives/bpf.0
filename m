Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135C377AAC
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789361817; cv=pass; b=CnH4ZOX+Kmqp+ECJZ7HTDhfAPWo0TME5Ot+K0c0NHxeTf33ph45pchVEkXDp0ljRG8T9QUmgtuGI9WXzB/QQ89wJAO0+Pto+Lq8WSSVR/mU77uPM3fMMN7RNHHsqq0qhKHp1mmo6dVb7xDuMYlp/mXgdqYUf6B46jVxJOdT/PbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789361817; c=relaxed/simple;
	bh=XJttOucUkwqKV5SIpXoyNSSoVR/yWjRXPTa4zl6qOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxXdPiKULSq/0vOIw5ohsQr12/wsz1oMdlywxWuHFul1OoZ0ttZHnMSl8+JxXdduLde2cT8dlI20Ki/zn0f9oAsb1l5qS8lwjRZCPim2DEYRcjGaY675asq3H06BRLdGjDlGoR6rR6cMtGTmfQ83OLH/Ixi6nYj08P6E9s5Px/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHPiqd4U; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHPiqd4U"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so1238689b3a.1
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 21:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789361815; cv=none;
        d=google.com; s=arc-20260327;
        b=SLefaBKuLJwUzAWi6gxcmbWp4tuYxCkaoBUht1NkmjmE0maxjgUSPeOiKC2wEWI7us
         EUoUTUdBAfkHVSZjtqvXONSeN/6ejbKWsoino7/FK+2S/jiiBlS7X4IDnDaolpum1cIk
         9/1DJ8YM6Wj3HWo7YbFGvaN/7yLE5sDUP3dtTyZJA5ZneFJasv23ZSFBuaswAbd3Hvft
         nC9xrmFze+0C6h7DyDDrOwhdml/HcFy6Yj141opw0q7dEyLUjUSeLB9TQKNKQqJOETUw
         QxjBefZuoICx1480gmKknEq51XCf5UcEzLRkq1aMEYu7wjZ3kzpehrzBo1V+xZLE3njC
         O7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6z8L6rXqNfxAj7abEXiX9kfEbaPtyTmUGq5VEFvzYo=;
        fh=5cqqZLaWckXCAcUPWlY2tAFy0CiTQuN9O2ljJhxbFi8=;
        b=TijgKmehT00CMEtHCXJ73c+3yh0r7uRSRt4GsWV0cDig10J2Yp8S/fxeQzj2YXn+99
         RhkALiE7xSL3lxhs54MR/1RiADQFCDc920MMESIm8Ja+N5CZ8Vhkj28ZvQk5YYE6GTvh
         ztR/xUqJsaQk+BNsuDEgXgGpVjSFxR0j/Gt+GdEwgmDX2OUr6Ft19KpV6bE/NUyhAMKI
         xjy3jd6GsG6yjGg3gxqYDANvD/CZ2UiVG+rCLCoY5bz4cOFyE/l/sSmLfZfwnoNwSrwB
         xOPdcB5L2uOSmhGxZD6fRxT7VcrHOozEvMmvuhZqA9AjHctqBDvEIkEZlun1UqBoUVgS
         bPaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789361815; x=1789966615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6z8L6rXqNfxAj7abEXiX9kfEbaPtyTmUGq5VEFvzYo=;
        b=YHPiqd4UDJFcLSim8h6foqhDfLIQ3xRTfHsrqalCtj+JzOgTe/cksF2ThWOCC8Sk/A
         f2+hWx7Zncb8TyBclkIHMsvfYsfb4XLGryppNx5vhgR2ScNW4ilPBA3ZzUkcdzzTAMRd
         Zlen8kemyjWRSChH45qrNnMtUFYL/gmDRP76xJq9tVlfRSLztxLzDsrlA5FI10MmqKzd
         mFMVT3FSKHGNz1Z0kE+NlGUkA5ZtUK6E8vkTe56+08LKufB6pOU39CqLg/EMoghMm5zR
         yoa96SAFbX0pMR+Y8xxY54+OcQljZ9GR4xCpmpqpUXulTyoS1bK+G7j8J4VOyEt5TRl3
         n16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789361815; x=1789966615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6z8L6rXqNfxAj7abEXiX9kfEbaPtyTmUGq5VEFvzYo=;
        b=DYmIdiwc9cPv+3ZnWuAZ9T1fMuH8V6BQ0qI5zF4BR63EBRMpuGck2kLqliab+uq5Xp
         nKKH1Am4hhXPdsojh5pk1Q2kvQB0N3YcoymP1jS4VM6K7W1IviiOEB26XsonuiXiBJTh
         cjAYaCeT8ZChXDLt+cvYjF97Us2VMAI5njg/9PCvDZjfH1wnMORzR1YJFt072j89GvkM
         Q5VdLngUuUgbLOEsIOH/MPBabFumjG1+fLWu+d1dXZXepkRfjl5QUmutfjdO9j5+v7a9
         TDNadZn2koaoX7qA41jzPEqzD6cdwDvmNjcTVJVFtIBFNRlCIbTNkwEC/kmIiyABR/zr
         nHRg==
X-Gm-Message-State: AFuF++nPp1RV+pbyzgmyAkpj4PXaYoD14EKf9uqjYuGhq7DZF9cGBSv4
	rU6rk6UMfJYKpu4KWYnyvtyZRGX+cfAIdLXAQGE47qgfOePfdeHMaw9KGjDr2QS8tciCm7nQGz9
	5hVxbVuMU2KdgnqnsoSDTgi9vb9PkVug=
X-Gm-Gg: AYBFou1ubMS7nLpH4lhC9TmJtFxJUav3xC01rwJ3aG2cPgOjLYB1Jl1lt6f2ZqgyM5V
	KDjKnrE3QMUW0pnDkJFD2e+QdgBjEb/pX1l//k4fWe0NZpldSY6hL5zZXIeClDOapbCK+HfmLQd
	W1qC4NlZTxRq3ohKN28LcmAOGkyI4+1X8jAo5spZZRxpOuaBiStm+lHrqnuUfW7ipJGGIh7TZJf
	4D/t2gtJWoiTmbCm6s9GRWOAxKXLPoR1PJpIc1mqze9I5xXC31Su+73xQP848Q84jBfZIdPenOS
	yFLHOatuYNlrzkQMNK4A92ATg9XSHfC+ekN0E8rmv5hIRuG55sOzkKfVcmRTzP7Vamz6YMlGKEv
	cuiIgwfRLb2sitsbqZJCntFz7BBtYtS3B6wApMJXkyKqfI+zf5Q==
X-Received: by 2002:a05:6a00:1916:b0:86c:52fd:fbdf with SMTP id
 d2e1a72fcca58-86f863bb784mr1977203b3a.20.1789361814478; Sun, 13 Sep 2026
 21:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910142522.45014-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20260910142522.45014-1-cenzhang@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 21:56:42 -0700
X-Gm-Features: AcwNN1Wb5k6vxqdzIM7sidRn28OXJvGl-UnASr4hD185qUY-L8N3wMNZHMnDeEQ
Message-ID: <CAADnVQJceTGftun8NfbyQdWe1FqLDsd6Ut5mrQFxuVkAvrAAEg@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix non-linear SRH access in bpf_update_srh_state()
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mathieu Xhonneux <m.xhonneux@gmail.com>, David Lebrun <dlebrun@google.com>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	AutonomousCodeSecurity@microsoft.com, Xiang Mei <xmei5@asu.edu>, 
	tgopinath@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:25=E2=80=AFAM Cen Zhang (Microsoft Security FORGE
Labs) <cenzhang@linux.microsoft.com> wrote:
>
> bpf_update_srh_state() locates an SRH with ipv6_find_hdr() and caches
> skb->data + srhoff in the per-CPU SEG6 BPF state. This assumes that the
> returned offset is within the skb linear head.
>
> That assumption is wrong because ipv6_find_hdr() uses skb_header_pointer(=
)
> and can locate an SRH in non-linear data. The direct srh->hdrlen read and
> the cached SRH pointer can therefore access memory outside the linear are=
a.
>
> BUG: KASAN: slab-use-after-free in bpf_update_srh_state+0x1bc/0x200
>  net/core/filter.c:7027 bpf_update_srh_state()
>  bpf_lwt_seg6_action()
>  input_action_end_bpf()
>  seg6_local_input()
>  ipv6_rthdr_rcv()
>
> Fix this by using seg6_get_srh(), which pulls and validates the complete
> SRH and reloads its pointer afterwards. Pulling can reallocate skb->head,
> so refresh the BPF data pointers inside bpf_update_srh_state() immediatel=
y
> after the call.
>
> For End.DT6, make the inner IPv6 base header linear before removing the
> outer headers. Pulling only the outer headers can leave the inner header =
in
> non-linear data, while ipv6_find_hdr() and the nexthop lookup access it
> directly. The helper parameter may point into packet data, so copy the
> table ID before pulling and potentially replacing skb->head. Clear the
> cached SRH pointer and refresh the BPF data pointers if the pull fails.
>
> End.B6 and End.B6.Encap can insert a new SRH and reallocate the skb befor=
e
> a later HMAC calculation or nexthop lookup returns an error. Rebuild the
> SRH state when the skb length changes, which indicates that the new SRH w=
as
> inserted. Failures before insertion leave the existing state unchanged.
>
> Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action help=
er")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.m=
icrosoft.com/
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Link: https://lore.kernel.org/bpf/CABFh=3Da5iLOEJdPhoaWUhLc0eEqAuhnd83_jJ=
r9MVZZG6gSJAEw@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/CABFh=3Da4VyzxsQqsayWpTKjxY3HL2C072u=3D=
pbecEpNDbL9eBNKA@mail.gmail.com/
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.=
microsoft.com>
> Assisted-by: Copilot:gpt-5.6-sol
> ---
> Changes in v3:
> - Copy the End.DT6 table ID before pskb_may_pull() can replace skb->head
>   and invalidate a packet-backed helper parameter.
> - Rebase onto the current bpf master branch.
>
> Changes in v2:
> - Rebuild the SRH state after End.B6 and End.B6.Encap only when the skb
>   length changes, avoiding selection of a spent Routing Header on errors
>   before insertion.
> - Rebase onto the current bpf master branch.
>
> Please queue this fix for stable kernels.
>
> Testing:
> - Built net/core/filter.o with CONFIG_IPV6_SEG6_BPF=3Dy.
> - checkpatch.pl, diff --check and exact-base patch replay.
> - No targeted runtime selftest was added. BPF LWT test-run does not suppo=
rt
>   non-linear skbs, and the existing SEG6 netns test does not create a
>   split inner IPv6 header for End.DT6.
>
>  net/core/filter.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2a84f9d01131..06a748c07747 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7017,15 +7017,16 @@ static void bpf_update_srh_state(struct sk_buff *=
skb)
>  {
>         struct seg6_bpf_srh_state *srh_state =3D
>                 this_cpu_ptr(&seg6_bpf_srh_states);
> -       int srhoff =3D 0;
> +       struct ipv6_sr_hdr *srh;
>
> -       if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)=
 {
> -               srh_state->srh =3D NULL;
> -       } else {
> -               srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srh=
off);
> -               srh_state->hdrlen =3D srh_state->srh->hdrlen << 3;
> -               srh_state->valid =3D true;
> -       }
> +       srh =3D seg6_get_srh(skb, 0);
> +       bpf_compute_data_pointers(skb);
> +       srh_state->srh =3D srh;
> +       if (!srh)
> +               return;
> +
> +       srh_state->hdrlen =3D srh->hdrlen << 3;
> +       srh_state->valid =3D true;

This is not equivalent.
Pls tell your clanker to be think xhigh.

pw-bot: cr

Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD830C61F
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756224; cv=pass; b=HSlMEdVO9+3rKIHu3rdw67UE9C3HcrrLikz8Xyxh0Dtmd+qVmkGLziTvFhTSl3WR6fLswBBzGWoN35Jjh7Uelx17Tt5GYDMbGsrVeftz4qNzjhCYnmW7P9JTfILj291AuWV4YssALnpqe4HNOWaDaxQbDo3AZAczAvXfFMyb3No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756224; c=relaxed/simple;
	bh=bHqLLs/9sFWvIV0+VuBwONWdIQRlmR6TQ2B2OYKGYQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA4gSCv3fJmezzYTYRTOUfkVllLcK9JVTjF0XRTzFtnZyHrli07nryB4+fdIE/oCMtx6yy5FSVMrRVF+UhLXorjcEnvw2ac2gC2jRKopfc2h2G2HDhGfTXR2VR82hpgNIo0dTsccR4eQEotpdc6/tMi9fpskCBFKAblEnKuT/eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXlTXoT+; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXlTXoT+"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a153f2dff1so926952e87.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 07:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756221; cv=none;
        d=google.com; s=arc-20240605;
        b=h1btURWu7WnRh+g04eb6cXSFLhxal7zJNhFER2Ltq/LxNoQDjPSdzG9Niqi0r4yArr
         vyEVaEPowXm6QyrMEsmwFMieLOuRToHNlN9EBuyA5lySF/h6UK0wGbZQp4NVF823QeO9
         3+1350gRSZVwLrbNAAMioP2iF1QlFa8VIvAEOz+95gj3jDzUoXZUL2hTAXdUwajRqmCX
         Gn0idsBxU3w3fvu7PIvvzuGd/rhO9l1nehc+KWiJXs89MMRpXEpA5lH89u0ntmg5XENm
         nq7CbPwLJu4DaExg/8r8bqTO9IMqEPsHWYjdfTWBrMM+OfSjzrhGd8X+aoVjWc44iUZC
         jlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/3f58iu/+g/g9Goo1LOfp9JAw9bH8W31yo1xCwf7o0=;
        fh=5s9lsWJsaExT7Sc1lVPCbQlTOQnqnFd/1k967eXnPok=;
        b=iJZplyxr/uV0g5801L+5A7Gc2Loe9DrHFvhz7xtcxTdY9jL+R1fmi29GChRedSA9d3
         roCBgNBOnuD0oMqxkxk8fZl2NbcJQKxjn0Hk5IegisiqJxd7nEBDPiRzweVQ1+kIN7kO
         ZifVLM1SSD7vpVf+YDhAZobL7qi8Vg26tuCOF/+uJLODmNapxJz7bGfUedN2D1xkhlfQ
         J04Sj1u6wzSW1/QQEprtyaC6LiGxlaM2qgi0maHrggGXPG6Ya72CDak1QdWMctAo7xGM
         2qXKL0Mwy7exjq8xOOSCoFxgS6xUniBFt1n75MgAHYo17VckDk0rxukK3qlGU49bqYkL
         t69A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773756221; x=1774361021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/3f58iu/+g/g9Goo1LOfp9JAw9bH8W31yo1xCwf7o0=;
        b=KXlTXoT+gjnAk/FMQ+yJ5GslHzTnuNE+0hOJ709cBfrx8uxhL+hZ4i+UgAZVUm1KcI
         yhMh/Hp183ZFEwN0RlngbnLHw1oUaUTEw1FQDQY+xag+/8SDt+tgnyDBC0rmqenBT3Q9
         bZCZJ1KO0T/wXCBOMnAiEVQ7ss59b2iXMtOTZUtLivwhxI6u2i5Aji5CiY7Fs6VD7MsR
         DRdKN2AvIrxBiijSkQ/IUhF2y6PkxNKO2fQ+MhRAOIJlMlOJkWpgx8hrf7hlCdMov2wm
         rDzocy4L0lWWUj2ZpFoS5N3wk+RmqssD7ZYCX2aCZbmMJRDchR/WdsTOmjaWXeHhz6xd
         PO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756221; x=1774361021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/3f58iu/+g/g9Goo1LOfp9JAw9bH8W31yo1xCwf7o0=;
        b=mXOf2+rpA9ipHLXWFdb/32kpevnPq9OgKA/8xdxTLvqmF/N6J0w7eN9wlfoJfPMsqU
         3spLmXp+GO0P85jExQHbL3/0khrttPPVVxCLRS+gxP+TQlg4TW2RmWnvzktgWf8WdUyv
         vroOrBdPCYUrJvJ1yPujAuWTXWCviYu29+0OklG4dAR5fjc7kLG9SD1+GxUnUjtf7ewd
         Ff7HeZsRBrTFlhFfaay03gf0wJXj+qs2/jdLJ4pA2jOl9TwosHVwO31A0qObi4rOX/z1
         5kM5ZtZQ/vKhTfOU5RullI9G1tm0hrq5MQEO6fwexMIM1krmiaHpTB9cX9mOJRVImPjt
         Qohw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFvhEAdheSiFFyLZvXMgbzD0eYAfmaqh4Q7XI4PS42qg8qVSczquiqMeGRIL3xvjDI9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRIlsRXOxmXWCDM5XcHQp/I2bdWkTOPO/GG+3XoXx4wClFCn1
	fKuSw2k/HDiXaOmp5+/aklOhEjY7hSqKmIxtfkoh9/WDKek5lS42+ZgsQrqRLIBADAuH8AmZdeM
	c/6E6SbA96nW4EXHu1ObUCXLpN9ZEwoRV5ZrFRALE
X-Gm-Gg: ATEYQzziNLHwZDvnNxy9dPLcq3OOkMOtpnfZ1jgWTwQKiJD+Bi8EEGzCHNsrqcrY1jQ
	A/o+BurizIi3QtSClQxb+8S9mW8T1olAWuiKV+AXeLD8Kni6KaVFf1bXi6/9zWDFvRQpmT/Lnwe
	dbSoUg6+YnpG1GBfJ4UoFZW9Fmt5kOm55TSMCSrGfT+3EkrxrZVvKjS6uZZxhFIBRd6Jw/In5Ir
	YFlDGrPOmTOKtlEzPbnyrfwjRWQXImcb47BTww4cOqZlYnuk9imLM5j6aW/JkkPgVHy5fDE3gWa
	dnhIj4N/QZdHYKiAaTC7d/bIMonTMIz8nZ3YUSUV5HMbm80oTWo=
X-Received: by 2002:a05:6512:61c6:20b0:5a1:3deb:c073 with SMTP id
 2adb3069b0e04-5a173b9c0famr983817e87.1.1773756220885; Tue, 17 Mar 2026
 07:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316230434.1398828-1-joshwash@google.com>
In-Reply-To: <20260316230434.1398828-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 17 Mar 2026 09:03:28 -0500
X-Gm-Features: AaiRm53yfwWdQK9oY-u9T0Uwef3SLxbw8OQA83QC-nJ5xodPhrctAZuW02VZjwU
Message-ID: <CALuQH+WVSVuan2WRtnugnWo0ZK7dG4Z6BWgHQVULb6m5TZ7vrA@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: add XDP metadata support for DQ RDA
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, the commit referenced here should have been
1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode"). I had
mistakenly drawn the hash from a different repo. I can respin this
change once others have reviewed it and left potential feedback.


On Mon, Mar 16, 2026 at 6:04=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> Commit daa7ff1e1269 ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> exposes support for the XDP RX timestamping metadata operation in the DQ
> RDA mode. While the operation works on its own, the intent was to enable
> XDP metadata support for the queue format as a whole along with it.
> Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
> This change updates xdp_buff preparation to set meta_valid to true, so
> metadata can be fully used by XDP programs.
>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 7924dce719e2..48945b4b6766 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struc=
t gve_rx_ring *rx,
>                                  buf_state->page_info.page_address +
>                                  buf_state->page_info.page_offset,
>                                  buf_state->page_info.pad,
> -                                buf_len, false);
> +                                buf_len, true);
>                 gve_xdp.gve =3D priv;
>                 gve_xdp.compl_desc =3D compl_desc;
>
> --
> 2.53.0.851.ga537e3e6e9-goog
>


--

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108136B076
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296119; cv=pass; b=acXQcA9eAKXNimiQ2jof20fZe1ostFhbPycP0iPuXwpUy6LaMsjRXLOlU6dcNtJmzi5ECQ9FrMqeCn13GrN1M7xZTe9bAtdXNBAU8FJaMgWwC/S12aNEoG4KMdYSOQYXePKc0+CKHhYjQxg0sOTdJuR1d9SMbg/yuooHnpshw9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296119; c=relaxed/simple;
	bh=Tlp+lJfyp95vJQs35m1dmjtFUmnMeO401FStvstIVLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcExQgFYwPOXoVJ/gy557bQJMS4L/owYLs8eX18dnZgpQTzXsgwd+68tKdTsuGYwDMWns8axlUL70hBPcvCRmo1IQdtUbppvgl3tK4T76p73ZqOWZVf5/zXrAFw2NQ9fzK9ge0R53ZlxVGHnmzVZCYQ52+eoztjWxFzzc+j4s2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfwJxvy3; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfwJxvy3"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a27d39067so4002421fa.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 13:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774296116; cv=none;
        d=google.com; s=arc-20240605;
        b=aT959i9LY7Z6LLywR7j7v3qrnWopcNnPh+K2HB7ZgWFL13oihLU+H68OFLFJgrqSQf
         a+em7mR6uwpx0rC5dGMLfAxrGZcgMqBaRfOWLnI+UNYtRsSAGw+v7sUi12dkK0G+WiX2
         AxrGg56fmn28XVAJqc/P/LpjE7Tfnf2Y5n+21LV6Xp0RnmROss1xFawNbzEKZE2Qg2uR
         5Y/Fv8GXXrJiu9drSx74qsp0G9MevTzPoTT6SfHrh/ZM4JuDQ+12lqshMKn0SgBHrIaW
         1Sq99Lo7m9LmWSLjLH1kqJevYAebYCwekAK/9HRDaU1ynaCIiNGyGTk7nQmwQ/faS2B0
         nNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wc4FZh89TF5QoyDdncx8+R5TP1/bGV0DGvKJ7mX0G2s=;
        fh=A1ss7rxvEO0XpT/s0b1s9H4+sNz1aJGdrTnLwtDZ2lM=;
        b=QwqBpoqbM8GO/5YyCNFAkNfnPZfn3ssG3M1BGqT/dBbs8kg203+ByAbBgaronMOZtc
         wrgXjP+J12NFN37I9MB20zgviAqWHGSvHY86lAcwKhLyafVWXrpWOC5f+IJH7YS8UyCu
         qYGO3HJGwGxjhOqmupwtHsUrUz2EYRr48i6X4K+7XD4zy8knrjZbdaUbCXwpXgaF7JRF
         FGd7cy6DsS+TfDdJ3P5WrU6Pwufg4Dv4uGAjQvcIWIMkO5vKxmziFqx9WeONf1lCZqHS
         BR0+TBJHSwjDqwl4diRQq6UGL7rR5aBQLhAG0+MdPDR9oETFU6KJtSyWQKqBtl3YLwX+
         nL9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774296116; x=1774900916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc4FZh89TF5QoyDdncx8+R5TP1/bGV0DGvKJ7mX0G2s=;
        b=FfwJxvy3o6ZSWo99rpdjavXxAmxrl6y1Li5eD4RweQTM3KWsaSplrQJhQ/W6lQW/lN
         0trlHS0Jdn9xmIHFs4krURcXC3Sr1UTg7d30hv+ZVp45XinWJRcxcPh85qLo0pYbmxP2
         RvUecojNXDUbbYxvNg0CDJF3ZRSGP5GCIolg5Xk2HmFQbvle7s+jk578jMi/pFUMsrDI
         hMS40/B4VATfOUBr8dM1bl8S6onCPmiWyDATnShlZTG3/+OqUMPCv5HYrdZ/WNNcxCSt
         VIRhDlove7cjpRDk0V1PPhn54Q2E4ahGw6O5oDFRa5BRxEYtmT8nEfdUvcrFaJYS/AAH
         TOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774296116; x=1774900916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wc4FZh89TF5QoyDdncx8+R5TP1/bGV0DGvKJ7mX0G2s=;
        b=SSultz+wlE/qLUz3AX4KcJmTNCow53Ht8P7oGbhOgLBFPEFllZOAGXukJIwLgSMaIz
         SEUai4J13JP5QGy38+Dq9t5FZM1L1vveHxUE5IbK2+198uKEOEwQtT2k6w7spHSKsz55
         AppEQRMhdG6WJouJaeKXEyPcMcNdNlJEZCJJAIBnk9JCrBYlEpRHl9aSN1X8GVVHAWyg
         zntXnFgqN5Wmkt25g88edD7f5htCBhsFIvyfBtT47TdBqIOBOS2KhTqFbajdc6HWyBjV
         qcMONraze5PVcfRMsH/x6fD09sE/l28/LAXqPvlsTWImlzyR1XIsvQ/iArhOANDIy1jz
         maLg==
X-Forwarded-Encrypted: i=1; AJvYcCW90WI96ES1UfDJb8XCaDXpkak/I3x7AZEz29/9U9+WyU6oLCcRoF2KbfmA+Dwqdt26m6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVm4hVXfEPtzOeywepbQU9zicZsXjvf8GhQXFE2hEyhafcSQM
	wM8/zVya8CSGqlE7LHTxL/e6/4vZ7aa+N9QRk9Gpyypbw/lC+Sa8sYVTUQclQrurDWl2AJlpszD
	22w8lkNy+vxvgm3ajxtVWRwPcgL0PhkAP8M/BAxVN
X-Gm-Gg: ATEYQzxX3m2LhBTSlKPFiFKl9CFmkW9/eAbCwqtsvJfsfGrCKNzRWHR+jExnSMG0PUQ
	LlYPyN8pH2nUWvnn78FK4i0NhT1OMtl0XmYqRgJOCfzWRWhjvbScFTMXRYDQU1yXrFYjxGYbrcE
	Ac4VLze4PknxA+nzjnnacFkBwGOhg7/TljboaUhSep8U+DNCH8+jmamvi9mp8QzbyDOUW27goEc
	lNSCEuFipJITbOXh67J5RxP1b0I+xQ1Ww9FZy/9prDxzVPwZ8D5SLi/s20t3iPN2hS2FWUrAwus
	LbymXgTxhyUkXZZITSRcps68FJj83DsV004h
X-Received: by 2002:a2e:bc83:0:b0:389:e6d4:e7cb with SMTP id
 38308e7fff4ca-38bf96d4978mr44138121fa.22.1774296115882; Mon, 23 Mar 2026
 13:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318192450.3400774-1-joshwash@google.com> <20260320185546.6f7e95c0@kernel.org>
In-Reply-To: <20260320185546.6f7e95c0@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 23 Mar 2026 13:01:43 -0700
X-Gm-Features: AaiRm52ue7c-WC307Fjz_fnNrmCK4W9Lk9Y6g6yN01Wq9hoWYtCeBnkluHofDOA
Message-ID: <CALuQH+VpVpWq6yvRSCpyOSkWBEOXsKF05=fz67J8zWB8gcbzfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gve: add XDP metadata support for DQ RDA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 6:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Mar 2026 12:24:50 -0700 Joshua Washington wrote:
> > Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> > exposes support for the XDP RX timestamping metadata operation in the D=
Q
> > RDA mode. While the operation works on its own, the intent was to enabl=
e
> > XDP metadata support for the queue format as a whole along with it.
> > Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
>
> bfp -> bpf

Will make this change in V3.

>
> > This change updates xdp_buff preparation to set meta_valid to true, so
> > metadata can be fully used by XDP programs.
> >
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index 7924dce719e2..48945b4b6766 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, str=
uct gve_rx_ring *rx,
> >                                buf_state->page_info.page_address +
> >                                buf_state->page_info.page_offset,
> >                                buf_state->page_info.pad,
> > -                              buf_len, false);
> > +                              buf_len, true);
> >               gve_xdp.gve =3D priv;
> >               gve_xdp.compl_desc =3D compl_desc;
> >
>
> AI says:
>
> While this allows XDP programs to write custom metadata via
> bpf_xdp_adjust_meta(), does the driver correctly propagate this metadata
> to the SKB after XDP_PASS?
>
> https://sashiko.dev/#/patchset/20260318192450.3400774-1-joshwash%40google=
.com
> --
> pw-bot: cr

Thanks for bringing this to my attention. I'll introduce a new patch
updating the XDP_PASS paths to make use of `xdp_build_skb` kernel
methods, which should handle metadata implicitly. Besides
commonization, this also removes an extra copy in the XDP_PASS case
for copy mode XDP.

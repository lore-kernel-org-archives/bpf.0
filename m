Received: from mail-ej2-f29.google.com (mail-ej2-f29.google.com [74.125.228.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA03544D60
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704147; cv=pass; b=PRUaomvao7b9OAVjZsSWSRRPKlr7tBPo2+LMhILoavbbtpnSFoafc6G8yY7HDr+dUtAInMTTqE22v/0UzW5OzYFaCA2cEsTPOUEkxSziBFqp3gcj5iiamLhF9Kg43dKeXryjAfQ6CSKGcRtObQLcEUoBP+l/tha/cOmMPXdUUOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704147; c=relaxed/simple;
	bh=EgbFuS2Te6lm8qVRteJKBIzVGTmmynIix9CPN6Z3edM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGZbqRVXSed+8D4wecygee/CmXK4y+CjEczBRmjkM/gflVJ82IVIFBKxjSizTNe2CY3Nc9YaUiPDwMcLpA9AzchvMxLCV34886FErI1Xcq39HMqtrfJM4w9xAfvS52QwhJHTBMTYwrHVxL6W6TG0dqU5kuo/nuZ+Coi7/iqHqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjJk/HSI; arc=pass smtp.client-ip=74.125.228.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjJk/HSI"
Received: by mail-ej2-f29.google.com with SMTP id a640c23a62f3a-c294496989aso603699466b.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790704144; cv=none;
        d=google.com; s=arc-20260327;
        b=hwetLA3QbBQ+ocYgEtj5ijdSF3XjMYLWfGz9w9yUw7HEE7XlHUNSIM2NJZnQN5gAej
         lC0IeexgMkL7ngK/ZeH0GK4KUdxACOoTIHad1Viwvm1RlUhMAu/Fu/Tpn8JfApzFsv/X
         UfY1bNIWfRVKZmc6z8VsowrEPo9dRDli5R4iqakdr99AUK4eyOwzJrSBVRDRcV+Ai1cW
         OtQP2C8gm3vIZ/jWsJkeGLkTEaelP7BOh7JZ2SiNsblV1C4nzUJ/bW3Of+z1zCHzB/4t
         7mcYFWMO6H0BreF0C5H/DlyX3yEMMrBF6VCydOyEcms0XSw2VrX7vZXhe0tBtd4WpVWC
         g0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThdPZzLhMx2EO2ovYKz1eeb+03YA/YkkzTBKjXEislI=;
        fh=Fw79DnkxEWRXN0wnHpe5eJN+I1jou+ZccFNmBuML0nA=;
        b=iV6GQKU+HbleMt5UBz6meDX+PIr9T2Eyu7/1hLfZMES6EwLR0P3LwBxz0sJDvNC/jW
         YVvjvTs0NKHUYVy+uenEhoW/YHwiLwkGIhRc//kG403+cCOD9XWL3DME63Nt2Hv+jov3
         1yIDUXKgt4rD27jqX0XMZ3GHb1kQR6UwmkQ26xONXSd82itydQ3B+jhq3FRdvd4hkHBv
         pDhRXlva+0q+CIxRne2z8pND+7M2oYMOcIXQlsavnI0tAeLY5OnO14Mq+8f20EdLsTXl
         1vR4MZ/9leXAtlDpUMsyZTkKEMDWQtUFqq9Z4UEH1xbqey2799b0cg0XTexenBJoTivK
         o7Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790704144; x=1791308944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThdPZzLhMx2EO2ovYKz1eeb+03YA/YkkzTBKjXEislI=;
        b=BjJk/HSI+d90L8k+v3ogtsrpdBV9RBnS8n9GzfFAp2qbzia0SRN0MnUBBfbhTcD5bQ
         SKlFbDp1k3y4hc1U+ArLcT/CdMPQw9rDNtPllSD+amC96TQqeF36EtM+zHn16BWbFGQo
         v0YYl2anDZBgTxw2WKpOjBYmiZQkgZyjkQiW2hZC7677ZQaEhs1XMpoNUdlZ7pwRFczJ
         PtTN2FTUT+dqknbyhByvt9rPvNZF4KTFNegi8e3DNcGfF20nLlIS3EHgQvm9GDvyX7s3
         d7N+2F7wTDYiitczhVvx4FnL9GQe/QDPEqlpCEFIFWCOrSZlRyFZqvvnDXGwyei20/nw
         uC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790704144; x=1791308944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThdPZzLhMx2EO2ovYKz1eeb+03YA/YkkzTBKjXEislI=;
        b=koY+dCOqWX5MOgPWoita2+fPHpDKDddSUZyHuIolPXFrqtOvnKr5Rp2eZm6nZGXDdA
         EeRY+QqUgjuP8z+NJ8AZnNJ5iMt+yML8+eqC6e9Qm6buz40QZbzV+NbcC4xgY9vzx12H
         C/f7wq61MEudPhj2RMe3aOTWF8A0iW76NGr9GincFxUNdIU232JNnqEdJqmvncUyQLfT
         8Em67xpI4LCXo+vwKhEce2fqG9nTCu6WWamsO8jMgavuCAJlfD+oo7fuFJlbaP0NxKdr
         TIywE4u8L8rF/9FmENBDM11bxt7dbxQTClVtpJfvdS0PHqVjD35DBwXAMmO3N6UZdsfU
         DkEA==
X-Forwarded-Encrypted: i=1; AKwUvByT9XyRoxfOoWR3uMuDH2Jv07W3jUrKURhDQzf0DDTlSfZ+itQqExADK4mA/Ee6s0J4s14=@vger.kernel.org
X-Gm-Message-State: AFuF++k48zKcWRHd7tjTgMpLQJgoTlaNPoFAIltd/60k3D7N02lnfDpR
	ux6JUp0hG9iy4aQgzXzs4IT5wBpmIq3p3EUKDp7fKJCxvk7zMU2Oq+1r0s73JNzHwVH/YBj/Pgv
	wg86QXAHiEfMqnBxRKSVqMLsnpQVa9vGnKfHiexqL
X-Gm-Gg: AYBFou2vLgUWhmk709lgoKcf+WeOiEHgPMZuNtySwGDLNv68xk6eZaNDAiaw5CWlcWG
	NG2TLyjENcaLfp+F7eLHbz8HBsNW3hwkgkkdzLtqMBcjf+LSPjPdKX2G5MSpCXSMDsdz3UfoC8h
	w2HoqNVGJ9bDG+fM/OJgP6G03fNHYJfdAI5jnXils8v6pcg3+wWFU7mToVoip/lDPA6Xsg05kHa
	smFT3X8/L0LQqFKcXr47ruHSa9V3HIHpoQjuEXKUoT4zErSqi+SLMRhi/AZ9ynGIHCPIFbS5/Ax
	CypL1bUcXexnQdKGDaae/k2565Egi5A6zeYqAiB9Op2Gjpjq43PXmML0
X-Received: by 2002:a17:907:7289:b0:c2d:e067:275d with SMTP id
 a640c23a62f3a-c2e15c0da9amr18432266b.2.1790704143373; Tue, 29 Sep 2026
 10:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 29 Sep 2026 10:48:51 -0700
X-Gm-Features: AclHuK-4Jen_xaBqivrTS2m8jiJGtwTSvDPOut6gW97lQXY41zUzIIPLnIv2r1s
Message-ID: <CALuQH+VWjT2VZTOUjseLfcON4=Me6v99KyW=k=Uh2Y1dvpNkcw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/9] gve: various XDP fixes
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:45=E2=80=AFPM Joshua Washington <joshwash@google=
.com> wrote:
>
> This patch series includes a number of XDP-related fixes, both in the
> control plane and the dataplane.
>
> A summary of the changes:
> 1) fix an issue where XDP packets weren't being counted against NAPI
>    budget
> 2) fix an issue where XSK buffers that have not been processed are
>    leaked when disabling XSK pools
> 3) fix an XSK buffer leak when an RX error descriptor comes back from
>    the hardware
> 4) fix a NULL dereference due to incorrect registration of XSK pools on
>    queues not set up in XSK zero copy mode
> 5) fix a deadlock introduced by attempting to acquire the netdev lock
>    after it has already been acquired
> 6) fix a racy NULL dereference due to DMA umapping the XSK pool before
>    queues are fully stopped
> 7) fix potential data race on priv->xsk_pool when the field is set while
>    NAPIs are enabled
> 8) attempt to register memory model in all cases when disabling XSK
>    pools
> 9) clean xdp frames when tearing down DQO queues
>
> ---
> v2:
> - introduce 3 new patches (7, 8, 9) based on Sashiko feedback
> - corrected stat counting for packets according work_done behavioral
>   change (patch 1)
>
> Eddie Phillips (1):
>   gve: prevent XDP frame leak and corruption during DQO TX cleanup
>
> Joshua Washington (8):
>   gve: increment work_done for XDP and error packets
>   gve: fix XSK buffer leak when rings are stopped
>   gve: fix XSK buffer leak on error descriptor
>   gve: don't register xsk pool on pre-existing queues in RDA mode
>   gve: fix napi_disable deadlock when attempting to disable XSK pools
>   gve: fix NULL dereference from premature XSK pool DMA unmap
>   gve: disable NAPI when registering XSK pools in QPL mode
>   gve: ensure XDP mem model is registered when disabling XSK pools
>
>  drivers/net/ethernet/google/gve/gve_main.c   | 153 +++++++----
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  31 ++-
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 256 +++++++++++++------
>  3 files changed, 314 insertions(+), 126 deletions(-)
>
> --
> 2.55.0.1082.g2b9226bbc0-goog
>

In the interest of getting some of the more trivial fixes merged, I
will send out a v3 with only the very simple fixes, and continue
working on the more problematic/invasive changes in the background.
This will include patches 2, 3, and 5.

-- Josh

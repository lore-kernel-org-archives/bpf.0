Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAF3939DE
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781749; cv=pass; b=pV0JL8u0iKJ36OfseW/tb9e0E2pn6vdKiYJvyA5PCg0mJv9M5ObfxQhZVl6wk2SVufsKqScQ/C4TCG74FKLtRMr8ZWiqUVay8weKYKwjJWpWQyQ8pSdomxBOwjFsSfyP/UuXstZ2QT+cvV5P9M6Qn3TED/vqjcbNKbRB3X/nsiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781749; c=relaxed/simple;
	bh=E1TyiApiS5bm5Tut4IctQMM+vsxnN5fZtwjU08KtTEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZwOuR2VFnVhi2KJ5s4FNk3y7Ft7yeyXtmBGwpzO4Ovr05AsN48iIfxYxoDx5tVWjcK9s5WklD+ZBDi1bbVfYCK/FgOpZD/khx9KCad9ETML+WVMPQqP6DJmbFj+cg4m2peP41EYoQDurPGZPOpQjuX0rbT7OGXIDEJw1zx59Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOsysA/m; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOsysA/m"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacef7d299so19495ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781745; cv=none;
        d=google.com; s=arc-20260327;
        b=BgNFnoAzQL1yrghhHFPENX4fPcxwPMcxV6oEI8NZkVsV7WilJXnRSXot7J1c3dM8Sk
         xM3BhujTrlXBMHwHDLy4CNT87NdZ33F42zc4yu1HL0pfMRvKExS0PMb++q4GH152qO0X
         Txmu5/pvh8Y6fy9JSF/hcsABVWQ2ORi1RuRNG84QU5Yi9+FOc7mB8XO1wVo3KUlAbQZB
         qaXjk5gqdVzbei2Td7sGMwie81+CNZwKR4Ty3iTCXwE66a2407qeRQLKxxco8AENAGgQ
         +T6v0ErygbkM8vKyPN5C9lyG6sHRDiRrhngr99yGxDNI6djBb8z1aU4FFJ+dk91ILG3B
         D8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iaNYqJr1zGl3zigrxrLoyTzIuzipTS2HMILZRq0rjdQ=;
        fh=X7LUPbvQObOYVs6Y+6afKQ35UWGGRuDjpYsDhF98p5Q=;
        b=ROR/3LfO3Og4mrZcOcnjafpybKpSApcvJFEummucRJa3crtLGUDF/cbmokEAKVbkbn
         lKmT5NSLHIz8BD5+CxBJiH66I73tTddVBypoHFbxQ+GS2jQ03nW4DiHN2pdYgw8eN+Vd
         LdMc1gOIBbOLVcD9ZpIJXz0KwsOL3lvoCOfz48abB8RmGWO9AaeJ8NlWncSco1nIsv/b
         XOF8Fn4OxpumDztiMyVL/L4DQUxP+34P2Fl0kxnrX3MMQmmsZUl/kplrWbkKqTIvwxE8
         OmGTXyuSK7Qo4UV3tGEhr2WEDPaVl/Y7fiR+YVovN5N4zZOxJ+GVmCvxxpaAG3JoqaJK
         Gp6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781745; x=1786386545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iaNYqJr1zGl3zigrxrLoyTzIuzipTS2HMILZRq0rjdQ=;
        b=UOsysA/m4xzaSv9EmCuqqFCmJelENK5zKJe2RX6RS42YGe+KbxDIShwX5dqhg6sr9K
         TF8Ct766bgV3bvSGm8EefCGQRQvxn5c8+7Eixq0FZRUyCZs9HSrhOsCeFFmDXM5S/hCX
         y4R7gOnZO4BCnoDyjuHKjNKMW7qR+kI5TpBu2+eGzh8D1WZ/XCxBr7nJSxctVmzVZO0T
         mCIgaExokwYUFjfir8cZo811MR2292sr4QaiNcXlSEqHLbbDBfAlaVgr5eKogUspEGR0
         nZaMeDofiRUJN53oWzRil26492UG+3U1R8iepQYLB29xdulr4VVMsC2DLG9gZ7/AHl24
         Xwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781745; x=1786386545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaNYqJr1zGl3zigrxrLoyTzIuzipTS2HMILZRq0rjdQ=;
        b=CMwAtlJnqcaw6MKQwOGPLfVH2ea6lSdimyhULUjty1srWdSlrWbGgqJp4Ph3XiH7cV
         hV3P3AhTWKvzDRtrNQnMnzR3YzqDYC5hlednJjGarM39Ck+jbeLpf//owEVqOdVjAYdi
         SLq/MH0IYa6e1ZmfMYkQbKyCaZtZARAU/IHI50ZDuCNLKeLl2E03WdQ0kMwx1YyHJEtJ
         4PL2DVQeyOq7VgAUm4R2EJf1tWMrl7nfLrm2WcRUoSWGt9HcKyQ56zQdjEVUmYdVbF7V
         OHmp2qJC+72Dpzb8MxqZ1e7jzZp/Lky7l4mEB/Ya5BeSp//EWICkxMEDmKtH8EKexW51
         fIIQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHIuJbl1NPP3xT5gA66ILL63cjPy60JtSnWTE/CmGkqF7Nx/2s+ZGLKtFEoMC88dMPRWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWU9yfxY702u+wk+kUFr8FRyXhqjW2wOrWhk8/lryOHp88kG12
	t5PwJ7bl3olqrBywhGjXSP+ryDk8f5dOLUXdiospSUYyJz3GDxpd7/HTzd+Ai9Hx0FAuHEvVvzY
	AlkwavQdT+atb6hxlH2iibgyhz/A9F5VS3cTm62GT
X-Gm-Gg: AR+sD10Oq4Ipsbm7S5mwxQ4G7Iksrao0J8PLjljT+qaSGeDFZTd9K43J8ISWfqMlBoA
	UH083nN1mJpt9AaTAxQt1AAQcQeK4afqycB5yQGb6Nj+1BiIxaMVrV4BSioTik578tNiDP5GKhM
	KZzYkGoRPDdl7d2dEjzw4E2UOYIfUJUoBH1976vNXTynKlRCkZ6Fv28JxvNl2HUhKXpfb2vZdLc
	CFJLG5ta3mLd5Maf2IrtG6Ef+Gwo5YSZOp9Yl3wrMbIi4ejsLGC7tKgltvpBShkz6hQxozaR9XU
	x3xFQ4GMVHMrefL2zRIQhZcgjQ789q8D2D01/qVQRv/O
X-Received: by 2002:a17:903:1aa6:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d08cbbfdc2mr1235065ad.3.1785781744793; Mon, 03 Aug 2026
 11:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
In-Reply-To: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:28:52 -0700
X-Gm-Features: AUfX_mywewkX4aY3CNMFdzMOYyTmV4cVRuojkSA4Tcxx7W5h3VoMAU_1bnR2eHw
Message-ID: <CAHS8izN2q1n4VEoTQ9PcMRCwBrekQx=hXXZ0QK53U9xzXfxhSA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: enable devmem TCP in the
 test config
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:38=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> The config fragment already sets CONFIG_UDMABUF=3Dy, but kconfig silently
> drops it. UDMABUF/NET_DEVMEM both depend on DMA_SHARED_BUFFER, which we
> can't enable directly, so we need to enable a config that selects it. We
> use SYNC_FILE for that purpose here.
>
> Additionally, we flip on CONFIG_NET_DEVMEM as well.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

While hacky, I think it's okay to find something that enables
DMA_SHARED_BUFFER for us here.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/drivers/net/hw/config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testin=
g/selftests/drivers/net/hw/config
> index ed8642b68094..d89a9ba17655 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -15,11 +15,13 @@ CONFIG_IPV6_SIT=3Dy
>  CONFIG_IPV6_TUNNEL=3Dy
>  CONFIG_NET_CLS_ACT=3Dy
>  CONFIG_NET_CLS_BPF=3Dy
> +CONFIG_NET_DEVMEM=3Dy
>  CONFIG_NET_IPGRE=3Dy
>  CONFIG_NET_IPGRE_DEMUX=3Dy
>  CONFIG_NET_IPIP=3Dy
>  CONFIG_NETKIT=3Dy
>  CONFIG_NET_SCH_INGRESS=3Dy
> +CONFIG_SYNC_FILE=3Dy
>  CONFIG_UDMABUF=3Dy
>  CONFIG_USER_NS=3Dy
>  CONFIG_VXLAN=3Dy
>
> ---
> base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
> change-id: 20260731-selftests-devmem-config-f4f843f0f0ad
>
> Best regards,
> --
> Bobby Eshleman <bobbyeshleman@meta.com>
>
>


--=20
Thanks,
Mina

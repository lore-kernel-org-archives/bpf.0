Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEA34DB74
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974962; cv=none; b=jP0XOgApq4mXVNkefb5UMuKdbKtHafYzR6weW+w3VD4do+ljs1mzCI8Zl+8DnT4LdGlgqmfZsnlJaILzOksiXL0S0P74D3DN+2Xcdat/MAHMAc3+JI+UF50C009JUfDvIDyzlQUOxyL8UwmpT8mddC4trFvVSI//rHVVIen+Gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974962; c=relaxed/simple;
	bh=i4TALkxCAVMteGK1DB5/DA9ATdL/J6spYDvGFVc3dc8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dAaKV6bNnR1ouFeidtOcZDvD1vxEoGYtK8cl6WvXCpIpi60zA0Vc+N8tgVWLqeFUZbHD1e0z/PQ76a6vx3e2ZCQUNNcfW/E45QjV1X/zb3HTsmaOduqpvfSgrX6gBw0vRk7HPEnQUYiut1cZifJjb+sgcnF25kx0skIaTvn+j2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MP5b1u+y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MP5b1u+y"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad8076b01so41686135ad.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783974960; x=1784579760; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dkco1dRBz7qBpSbwKfMxu97d3aGY4fdczk+e7FiAUMY=;
        b=MP5b1u+yCsysHnmC9t1sZE1I5WhS351PDSqd6GTRiGnqSRNt0AqFKLSuOh7Zy6ut8I
         xHWhDrco7vAk/hGuEzQSSm+DOSWrJ5hK+e/nocSOENvZ1H/XJE4nFTyEyGqePXqNCb4O
         3J/FaXQmPsafHRsRNwGJ7JnIHO3WV6Sk7ehPB13UY94UPWCgr/gJqw3VG6OTbrna6XRE
         LKjj4A/9+1vKehQOnP4+J7k64I/xG3q6pdtVDVf1k8UCPdUEHp58YFKw1tjmvnRtH3rg
         ZXrAqqOHHoPmeX+5USgbNqLfic71bpb1DejvoV79VX3Z0rK50LdJLTPew6AyiFjvZspF
         Jkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783974960; x=1784579760;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkco1dRBz7qBpSbwKfMxu97d3aGY4fdczk+e7FiAUMY=;
        b=SJe6OHOe9r6z+4sILjSl1YuYURl4Y6bdI36vnWkJXlHNVnD0mmpPpqwrSPG73lIrr0
         9tCICf8r8NS/uzgkrJMc70Xqqxs4qajjRJOxGsZgIMHLqPMWyJDERT8EsNrVUhGa3uXe
         xeOU039ZQuG7krFzddBgzJj4Zu8MOlA3wlzzqYL857NuEfXs17lNG79sfj4uKUFAcRe+
         YWmtTOID949f9izennxQCUwG5EDTCYO1b4Q9jbaKtpyGnS2V97SdlNw4UFSyigPcbFQB
         aCND9N1KovVUBGvg2VLo47p2mm+rJan7Bgca5eDKvnautLQlebxMTAy3uTCzZHlvn7C5
         OFmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkMBr0KBZdrqaj6SWji35vAKp9Sq1z2HdRp56tbHBRZMGfeEPcyZB9Rz3xmJJEfz+cjQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYY4bNdrkO6RON4vPF1iZKjDJI8uCIr8CjUx9megqU/NXDivc
	q2rYgo+nsbNLTx18+7Jw1bgZxrFErPVXIsZd15vNkTPE9/icQcXjk7b1Zk5G2s0X/xY=
X-Gm-Gg: AfdE7ckMZbKbohima57b7utd1hsb18WDiTAQAZB1h29sbd/F0d4oxebmLkVXN7BIAhq
	ryE5M1pII1A9DEZvpA4bYnFFsf6ADxnNLP9iMljjHtHmhkqTeYszsS2MB6SRxHJdAnXhI4vkGD9
	mlfZCxDScPJ+b2+657x/cuRK6qb1MW2/2l9HM5hohNrafnUF+DdkKaTOlblqTYhqvKJZ1Okcrp3
	3CNjZOj5qoUOEwgtnAzdjMOffpF27pC+wSkU2QiPcUVLZ+9Kq+xO+KQGOhqEqxkERf+4w9YQVVJ
	zjkRndQi+DtyF1ro7jspWxDIPt9qFV+kbhSzM9R1Y2iSsITWonZqCtrNFyEmRyTynfKU/MzYy9i
	6wmcbtCISeu5Hw/C1SJy9j5nRw+px4XatJu+U6WrJsXnxnkWFPRHUV/hmQuH+naxtjGpMC1xfpv
	B3uyxVFkmnL6uQmmCDGVGqbAcFgM9ZpfQKaA9aZwfo7dXysIQLpv7A
X-Received: by 2002:a17:903:190:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2cee9a65ed1mr6395275ad.7.1783974960004;
        Mon, 13 Jul 2026 13:36:00 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c100adsm103385245ad.32.2026.07.13.13.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 13:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 16:35:58 -0400
Message-Id: <DJXQCE0A0P3A.1O2ZPP42RKBWH@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 04/15] bpf: Remove unnecessary
 prog_list_prog() check
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-5-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-5-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> effective_prog_pos(), called from replace_effective_prog() and
> purge_effective_progs(), tests "!prog_list_prog(pl)" to skip a
> 'detaching' pl.
>
> When detaching a pl, pl->prog and pl->link are set to NULL in case
> the update_effective_progs() failed.
>
> However, replace_effective_prog() is not detaching a pl,
> so the case "!prog_list_prog()" will not happen.
>
> In purge_effective_prog(), the pl->prog and pl->link are restored
> before calling purge_effective_progs(), so the case "!prog_list_prog()"
> will not happen either.
>
> This patch removes them as a prep work for the upcoming work
> in attaching struct_ops to cgroup. When attaching a struct_ops
> to cgroup, there is a link->map case and the prog_list_prog()
> will not consider the link->map. The replace_effective_prog()
> and purge_effective_progs() will then incorrectly skip a pl
> with struct_ops map attached to it.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/cgroup.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c..b64f6757096c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -965,9 +965,10 @@ static int effective_prog_pos(struct cgroup *cgrp,
> =20
>  		init_bstart =3D bstart;
>  		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
> -			if (!prog_list_prog(pl))
> -				continue;
> -
> +			/*
> +			 * No detaching pl (NULL prog and link) is visible to the callers,
> +			 * so skip the check compute_effective_progs() needs.
> +			 */
>  			if (pl->flags & BPF_F_PREORDER) {
>  				if (pl =3D=3D target_pl)
>  					pos =3D bstart;


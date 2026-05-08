Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7913FCB3F
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252617; cv=none; b=bpif26F14m2edHCnxVCd6dwGG1R+/4KwLcyEpU6ofmIOtasHxJ5XlsWSB7MHtzvOyzoDlPkaOVyfaGoNiaQe9u7EZnzBB63wBdPiH+WGDQf2fo0vK4LJ/dZVhOpt4iRb9aevus+hD8E3xLqo18POf9bkRogReWne7vn7xv9Ur9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252617; c=relaxed/simple;
	bh=t0Nlu+VexUsTkUu/gem9W65q4/pks24oKx+COgMx/io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFgvpRwHEFdtuW6za7vIHwZ7rmqI1wS9xEjPdC61bPnQOw0/f5T8oe2pHwnS5FGg3deAMp4byHDOAbv4hPpu20iiSJlAUqwNYzw0xWBUg3/o80hpG1mBXLo4I+2IgU21CgTrWUJ3acE2nnqBz6OGxXjfZiwPfHtLAQQcuNu5m+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1DV9bSP; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1DV9bSP"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2b4583f0a1aso13875595ad.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252613; x=1778857413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4XSckC+6HeNNAT2ObXLyFDVqOgPjF3vQM49fr0+IcA=;
        b=M1DV9bSPdIpo1HCzS+chpKLRw9yZEaLHH4hWt/8vF7kwxIMdWiQ56TFDetp2fD3dHK
         R0u+n+5f4iBWZtmqUudWXsg0H8PaVHkUHak4NyF4Yl/tD9W5Q83ulCRhidXVrpgwF1zy
         OxnEv1kIXlzfCWOaLDPy/oadOs/Vnb/U/6AFDW6eOaaZEx/e9U2TiiVYVT0MOCDY7TlL
         C5LkiulOrgIE+dbWiLgv+jXSyxNRbrdi7pje/7CMtnoub8nb+Fa/L6vaaBQZ9ozgoVvQ
         9Ia6bUMPwXknOYTSdI9JX8ETBTps+Uue9bS/EYFde3ymahVl65AjQ81p4ufqD8Cn23Aq
         FXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252613; x=1778857413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4XSckC+6HeNNAT2ObXLyFDVqOgPjF3vQM49fr0+IcA=;
        b=UXJd1VuEEm3st6f86AjnGC9Ta9bg4j0O4ExcM0pqa+YzlFGYuYyCgNf2XsE5VIby4Z
         E1R3qWo7pbkIFQSm7Nk8H05FAxVYHBM9d8go3n/6iMDDJ5Reqfp5fVC/xoT8QRYyceYg
         hJrfeTRSab03zOcpxfpBxPtcwm5v6EXt7ECvGD54hA3hmCf1A+pnPVblootUjDYsVAGF
         TKhI2b+AEWbhWhIc4JmeoSzyP0gox8Iiy7goO10EEMblaQmmaz5U+743Xs3rTIOCv6qM
         TTHzvPgjYIxYH8hYcV+pOIaJb2Bi20TRghSxa9xeA9JsMUmo9f0jvyIr2DWK9cIMJZpB
         dtKg==
X-Forwarded-Encrypted: i=1; AFNElJ+0O1eDlEILTmCmB9yxRuMJYR2t9VslO1TOlSwGxelZ0vWbcEzIXJyDKtUCLesfTovFdbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzddNxr79VIBfupbrWRHAyuXFqmCpx1HJmxuAoOSpY5BhSbZmI
	mmvOGqkG6TYgRSTu+kNgrPu9PPagoMYIaHEbbMHQGHuJ0QoIxp+OFveR
X-Gm-Gg: Acq92OG/0MoDnvS1qNrsuB/dqaTsMELe3/Gbk2rbaqqaCm9H1k/Wj4TbDZ8xVijuMqD
	lMK6j4BzCpqPhAqhs7z4tppH5g7HyL11G3I6x+PZuuB9Af/NK6k03M1BEltn45wtcUyhhmunQ1Z
	1X04o/ZupbWvHG8dg/xAFS2KZ0uMzRQMrSh96T7qSWhKPuLjUFFv4UPFLc9uEskXlu3uaa8U4Ii
	qt9VaZTFiU6E87R8YWeBxE85M1uguUbEcXvk7lgD6J4+WqSSAE5AgB/Gpf2cJ9JX/6Gi4hvu8ye
	dPj9crDDJN6zeoyAvRkBpXrCaq2eCOYnvUiD2e9W8IGcHQ32KqagCgJThZdtmWn4PcjXou7HxfA
	tPwrJcJij737LcbzWh26KymPCqWwRddHQwiN4AxvDH4Vp4BE1UXTdt1rMOED5QmrYvqaUZrjCSZ
	CR
X-Received: by 2002:a17:903:4b0d:b0:2b0:bed1:46f7 with SMTP id d9443c01a7336-2ba799d5f4dmr143685845ad.37.1778252613411;
        Fri, 08 May 2026 08:03:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ecc4bbsm24477685ad.84.2026.05.08.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:32 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 7/8] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Message-ID: <af37O7TXJm9wPl1h@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-7-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-7-52821445867c@meta.com>

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When sending from a namespace that has access to a netkit device with a
> leased queue, the nk primary in the host namespace needs to redirect its
> RX to the physical device. This patch adds that redirection bpf program
> and teaches the harness to install it.
> 
> Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
> When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
> program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
> interface. The program redirects non-ICMPv6 IPv6 packets to the physical
> NIC via bpf_redirect_neigh(), with the physical ifindex configured via
> the .bss map. ICMPv6 is left on the host's netkit primary so IPv6
> neighbor discovery still work locally.
> 
> Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
> other BPF attachment methods can use it.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

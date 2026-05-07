Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D23EFD2E
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168347; cv=none; b=GsnnN3+LilQUxwtSBxXLM6A0gn+BcY62HnOa3x3dhsZOMvmhUxtlABxkSS9TDJVbjT2b6tvUVQP+Lp3gWudpM9YEOhX+R8eUw81f4hOLGRgtGYGvQ1f7ZgvOe+EZRUz5v9mYkAiXDafLfRKR+73oj/qx0EgcTsb4oJAgflc4BsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168347; c=relaxed/simple;
	bh=I7bHVcUPCbFavnPQE9NIAPWTbSlQISkdMWu7R9FX+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZvYyCAF6QpVe6qR97mZIJ/ddFWd584bJbFN/tyoXrEemgOCH7JIQ4cO1Mi5TnbZFojbRCDQjMhbzyVNsiHWvGwiWjOr4zcc0sKRTsqAGNfvMJCozqmIE5fJZ28bQxn6k1v/HcfBMc0V8JBjwEa3L3NBMP/IGDZIvdgdXB234uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lELMVwd2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lELMVwd2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ea8563c693so108524085a.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168344; x=1778773144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQASz0K9bAEWsvTANOg3uGMuZOgruzesi2JgdTAVAkE=;
        b=lELMVwd2v+v3Y2UjmN0rjzuYIZkTeRK8VqQUHf+rI68gGfgcG8NCRLWnzDSU7Ejg3a
         Fkw6my+S6bAF/4E4hCUawNWJPvhr1TNcPhPRWjqkvLDfn3aOBNptDGyNH86WSvyJo283
         sWtpk53zfbttBN4gwE+xdhjPtewc4RWBahS89D/lN22YvuzFwhbBxwkjAQV+wl+AgeCk
         lXNzb4qXqs00gTDv0uytVS0ClClxoEGzxVnEniq0d3y4Gw9GHs0fmfn66iThHtOpR7TJ
         l3wCy1J1YODPtn2r0c+N3ZstW4mN3WeMU4SFG3zlY2trp4eE2dESUXTSK8mMG8ZRqvme
         3PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168344; x=1778773144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQASz0K9bAEWsvTANOg3uGMuZOgruzesi2JgdTAVAkE=;
        b=rSuBLjSplXEONPq69zcZs31qcu1j90aAJx6e5g88KSgV8FtVYsMv3y1hUaYvfkM6Hb
         KX00imrXfFdi5T7EYwV36OMbUmfsaRK76KnUiWzfGyC3rRCbVd/akFXFrQ6RN5rd+g+O
         xjx0q3AO5AZHF8vNyRySuFbYdR5Oc4s4hHFfpTp7B+mpIQwqCMkawx7FQpvghNkP/D19
         40gGplXfRR7HwysOyFy/SqLzE9LfsT/NIMNqJYWSC1dtD4FSIupQSheJmQ9tnTdlT0kI
         1EzQoJDJweqebKuGi1HkTEviQ1Y13ADpFQKRG2Z/sEvHQJ9VdPtrTEBp3gQepTTqZqgD
         kgUw==
X-Forwarded-Encrypted: i=1; AFNElJ/oU8nRIIl7Nhy7O4/rBiQYoLMtuPanvZGPFDw/im/418EYD3WMys+ca8DovKB5vkN7Qi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ULOnQ1sUiv2aAwZuqsvehIDvpztxtvfPNXkeHeJSpG+u8k1B
	9u/r1Kz0jPZNX5I0E7Af+egCUw3m2dx1RbmoLfHfcAZKM+uHQ+Wm+9j+
X-Gm-Gg: AeBDievb3BH2jVKtVuNE5EzWxOPIkVd2KdQu8SfPflOYTzsOF4yQ0bnUcI73YYYaXkw
	MwYX1oOBRrXPr3DzU8Kv/O23eJclDbC9aA7Q4Rg7y+AaXrN6vaG6q4m4dCbGsGp7s5NkG/JSNqN
	ghMVvPtlzzrWMMmF9sH4qMyM3QmqSmO87DswJNlLfqFR+/XauzE2leQP8CZlMkkJc8ffKWh0Oz/
	0Alch9CNtWCLBMr/OrNQmhM136EnYt0a9gtIw1rs1o0T8NLHN5kLuYq2e/2FRqwEQ9kpsiuB3Tm
	mRlofuZDeRz9IcFgC9m7qVwDJB8dkwwng+PPhb7Z994WazaFjG0jlTh+LIotDILM/H5zzv7m/nm
	LCJqHEpMIqYNchfD0H7BPrXfZJriwF+ox6dUkDWFaxskNOBOICBA48R5nW/9OmjyvJI+T4RPxbG
	dHCZ7m3xPU3eefzhvIDgWfWcy097FrjukWQuejuyYY8B+6IvEuPJDFWS0O3Q==
X-Received: by 2002:a05:620a:440f:b0:8ed:11b9:1ecb with SMTP id af79cd13be357-904d4b58929mr1205520185a.20.1778168344205;
        Thu, 07 May 2026 08:39:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:13::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc293837b5sm2153539785a.10.2026.05.07.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:39:02 -0700 (PDT)
Date: Thu, 7 May 2026 08:38:56 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/6] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <afyyEJNbrBem8igi@devvm29614.prn0.facebook.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
 <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
 <20260506193420.575e1806@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506193420.575e1806@kernel.org>

On Wed, May 06, 2026 at 07:34:20PM -0700, Jakub Kicinski wrote:
> On Mon, 04 May 2026 17:27:49 -0700 Bobby Eshleman wrote:
> > +	if (bind_dev != netdev)
> > +		netdev_lock(bind_dev);
> > +	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
> > +	if (bind_dev != netdev)
> > +		netdev_unlock(bind_dev);
> > +	binding = net_devmem_bind_dmabuf(bind_dev,
> > +					 bind_dev != netdev ? netdev : NULL,
> > +					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> > +					 priv, info->extack);
> 
> Not sure if it matters but are we intentionally releasing the bind_dev
> lock before calling net_devmem_bind_dmabuf() ? Previously more code here
> was covered by the physical netdev's lock.

True, lock needs to be held at least until after binding. I have this
fixed in the next rev.

Best,
Bobby

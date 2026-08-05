Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F83E4C8D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918147; cv=none; b=afn+05KK2+vNI4mj7SrlmKT4ln3WZW27P5lcTYcce/IciFcrCqUm93MZRsNwrEu+O36L2ZYQQQWDcFApWFUz9pAZQPJHF/nMNhVmZh8yosZVLUoC3ZemKPXE81GPi8DuRNU1GcUNyiUbDhxOv8jpe9vntotaW4OPnnPCLvbwKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918147; c=relaxed/simple;
	bh=QHYfGuMolQ8A3YO3Jr6H088OtOknOcMyY41/gK6OrmU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNYVJrlJNKT/pa/S3knfB3zz6h/lQ7ZSqDrlK17d+SZffy/FFTt7UaExOBQGrVIiqyoM3qNzu5D4pXwWwX9BXvkT/iGQdqxxOo4OPsVLUYrqWwuNHQrnk1Za5GKfSYRtb7Ejyhm393zlMBWdEL7Ea//3zBMMDZ4ZIbF9XoYaxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5XVSPn5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5XVSPn5"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so611512f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785918144; x=1786522944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTnN+TvzBg4AjKqbGE7dFy9XV+JzEvnALTtq5MKiwe4=;
        b=U5XVSPn5x2NOpvbxG5Y4MS3/Mu1Wr/pqqkBPSbq/68HEWhDnikxR1GdK5NnZfRDT2s
         sL+wvmGm+H1FmecySVa2CBL/C2an+CR67Dk52cauAq7qGPU1XgLIJHqav5zlEqYbZy27
         KbqJNxlBHMqnkx1ajOOWJnFws0KZrWTFAZpke9a0vVVs9DwRoevXRi9FNGWI2eSzENh1
         tm0cTpExIi99tUbRBrwoSSCo+dMYUS46zQNoByFSQKWQH4ycHs23IlqJADuv0lg8WXEf
         HNN0rylmS754BnlHhUzdYQXVaFlyf+o7qO6+yq3w23E657ooYA+Ut1e20Se2GvM2GB1N
         ajLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918144; x=1786522944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTnN+TvzBg4AjKqbGE7dFy9XV+JzEvnALTtq5MKiwe4=;
        b=meOxPyI63kcfQjffnCTr1fQjsOx9a7xfrFmqTy6hp3afn6NNjU2lw2J0mFfcjUHBCI
         2+M9HELfcJZINlwR9hJq7gi7qZcgMsahhzencfR1Z2vnMlPAQOPrv5ZSQoGc6B05m9iw
         LyHiBupZeKhqDwvkucjTTr6itpitOr74E548kdnkohxW4xXZ5dniUTe6yaje57SUrFUk
         QiVyIGve0MZV4Zli802wK5ozUDUWWriO3PpCr8+0D5JNBpTj1rISSareX6C4depbRUGv
         cYdW8STbM1gHXR5jgoCMss8j/StoiWauJqxZuttrqlwCWnq8yjynmQyYIduwlpufhNn1
         SmaQ==
X-Gm-Message-State: AOJu0YwytEJNmpKSX2pa1VgnqkURtnwMjxVsyh8Drq4/Hv++hOYdNNfo
	qjXPeZuBWXifYBL8rIZiapW+j9guRmiuie6vcpG+MgL+XAOFkl+A6dnWTJRdfq30ixo=
X-Gm-Gg: AR+sD11kJMRg7B89HExG6xEGa1gFJhWUaHb0Xmv+DpqVsZuAb9mDMO9KhySrvaVWCNS
	7xovF5cKjEu8+0BL5Nm/Pn1iOHeWon6wKjrBLFtXhTYOBq+rv1Es4FqW1+XRy6dvXKkxuCZvBfo
	gXVoioCovr+QBeUiCUUdUT7qC+Ul6T/xFgr7q4ZZGRkJ+IlAXKeqGEO5Gtz0FkNCeahqi7ltf/8
	dg15tV/kmePJlFo+azC6FyxGw3iJOX3qrbCqLYFK027uF7HMdOCIC9/iVlq5ikxWX9+BN+UX0rb
	ZDq73WhhQL8JYVqSn62/6SMGH2Yk444udFp2faYFhYSybbuQXny5tOXAMo/QBnugMWVL67Wxzk+
	px1rLebgMuBvPusIEulXPGjuWNtDWV8Vz73nIUGfQZQieUf97SkPOJge26Ly9D+bmzvJkO27vmt
	mwtzAoFJBoRazI3g8mBjKDRw1luMjYhS7e3uR7Y6Z8xYlgJ0OTgCBAzIDm6k7jL4/cRyyV00J+b
	vvyiYntAwncxPLj3kUoaq4ydUCqQukPzsThgAlVGRxYqdMIYhP5
X-Received: by 2002:a05:6000:382:b0:476:7036:f854 with SMTP id ffacd0b85a97d-47fec52a21amr8100866f8f.21.1785918143400;
        Wed, 05 Aug 2026 01:22:23 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5d7csm7233885f8f.15.2026.08.05.01.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:22:22 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:22:20 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@google.com, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sashiko-reviews@lists.linux.dev, 
	linux-kernel@vger.kernel.org, emil@etsalapatis.com
Subject: Re: [PATCH v7 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
Message-ID: <anLyIzAs9JBhZnhe@localhost.localdomain>
References: <20260721223807.75101-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721223807.75101-1-nnamdio@gmail.com>

On Tue, Jul 21, 2026 at 11:38:05PM +0100, Nnamdi Onyeyiri wrote:
> Spurious wakeups in tcp_msg_wait_data() aren't being handled by
> tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
> EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
> wakeup and a selftest.
> 
> This issue was first discovered in an application that adds sockets to
> a sockmap as a way to view the received data.  No redirects or any
> other operations are performed.
> 
> Sashiko has noted a few other pre-existing issues in the same area
> (https://patch.msgid.link/20260714205118.17DB11F000E9@smtp.kernel.org)
> that can lead to EAGAIN in tcp_bpf_recvmsg() and
> tcp_bpf_recvmsg_parser().  A local run of Sashiko also identified a
> potential issue in tcp_bpf_recvmsg() handling zero-data FIN packets when
> the MSG_PEEK flag is set.  To prevent this patchset from growing too
> large, I intend to submit follow up patches to address these once this
> one has been accepted.
> 
> Changes in v7:
> - In tcp_bpf_recvmsg check for data in the TCP_CLOSE, !timeo and
>   signal_pending branches.
> - Refactored changes to tcp_bpf_recvmsg to reduce duplication.
> - Increase the number of iterations in the selftests.
> - Documented selftests numeric constants.
> - Link to v6: https://patch.msgid.link/20260720171535.67867-1-nnamdio@gmail.com
> 
> Changes in v6:
> - Closing the file descriptor in the selftest worker thread.
> - Ensuring the selftest loop breaks early for an error in the worker
>   thread.
> - Added comments to selftest regarding focus on EAGAIN error.
> - Updated selftest commit message to imperative mood.
> - Link to v5: https://patch.msgid.link/20260717155348.54975-1-nnamdio@gmail.com
> 
> Changes in v5:
> - Move selftest from net into bpf/prog_tests/sockmap_basic.c
> - Link to v4: https://patch.msgid.link/20260715213538.37229-1-nnamdio@gmail.com
> 
> Changes in v4:
> - Fix potential data loss in tcp_bpf_recvmsg() when a FIN or RST has
>   been received.
> - Check the return code of pthread_create() in the selftest.
> - Fix race caused by using EXPECT macros in a thread in selftest.
> - Link to v3: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com
> 
> Changes in v3:
> - Added the sockmap_recvfrom selftest.
> - Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain
> 
> Changes in v2:
> - In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
> - Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
> - Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain
> 
> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> ---
> Nnamdi Onyeyiri (2):
>   bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
>   selftests/bpf: add sockmap recvfrom EAGAIN selftest
> 
>  net/ipv4/tcp_bpf.c                            |  72 ++++++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 136 ++++++++++++++++++
>  2 files changed, 199 insertions(+), 9 deletions(-)
> 
> -- 
> 2.52.0
> 

Hi all, just wondering if you need anything more from me on this?

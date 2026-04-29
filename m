Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBB3783D4
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475915; cv=none; b=nfZCdl6kqG58hg/Mx36Zsryp56wPd/yH6e84QBJXpdhKKhQyc5ONENvJJbLmqJOBQI5es6qEDXI1tq7DspTwVSTFDIwGsbW8fsKlSXxCHUoTwo9Wn9ZtWmvnpPFTESMZz4ik9PqcAzxltvEn16QS287veJk3MtXSdQvdqyjTECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475915; c=relaxed/simple;
	bh=/BimwSCUsuashVXwD+dzxd+4t5G8fzzhA6oBT4Cnlr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYNGHYj8GAABgFz0y8Hl0dxDTqeKEh1p85B/HI2AAeNjP1ycldb4tU35Rhcmx9JhHzW3Q0TWXF0c4/mMeXNXIJXn+ft2FTXt5CmxDMjzNvsI4pnOW81CO90HpyFwhv2hifpPOEVHitW2x3AI5vR1SbMRWNffGVPCiw8/DiGUaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7iJCGba; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7iJCGba"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd17e19b6so5499722a34.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475913; x=1778080713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hCAZnYdZvdp+ak79vsUFUwhsK90OGnLnVC3WYq76N8=;
        b=b7iJCGbaNlXtp4X0g6/WayFeLAL1bJl7AXsejxs7Gg1yd3+tXxfLCqVRJ6zgl+87Ty
         AzkjBbmGxQXA5dPHLvzunpTs8WxAQ7r7BYtmSYzNn8xmKooUmrYgvDByEfrGR9oMNHST
         6CYlQCxvgSVqcxF4KUQH1q7M9m7OjIWYp2+HxRh/LoRPURMvrEgXRK9WNLNlB7BsykRX
         Pmu2UsOH9F8ek8o5h+A7RETSgO/zEg5diwBo2XSltxub7IYnetVfLLiar8QOKiuubRSR
         mVR2pcvukrXZxLDMZLKOgq8uo+utneT0SkFkFgAMAA8W5wNs+4wTTLLdIaYkjcrXUpMc
         ExWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475913; x=1778080713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hCAZnYdZvdp+ak79vsUFUwhsK90OGnLnVC3WYq76N8=;
        b=cCkVboGespVwVDHelEiQEbMZN/foY1UcM9nXSWC+seUM9gk6aCgF+nsDy4mp4eZIBl
         GFocgRFM1Q8+g4Q2WZTiz+8yPpBivTo+ByikVtgbO5aZFb1Gu/5eIOGkuwZVlJh4BpCZ
         bpG3ZdRp7EPLMcbWTd3wlxkpw5FWr7jVnpeq44ZZP2gVh3eqIAmKl4919MF8oXEESfye
         6uiIUzEQ8Pip8RTG7S1MGmKaUg6A4dyNTtan4bRVKL2FUHpjJVf3PZVn5LY6uCSTz/V+
         SOB1q2p9KKAQYZcDgFwx2Bp2/WZIYiyjv7t9WWDZXzAdwFJRD99KS6jaOztlKxKTLjgl
         M16A==
X-Forwarded-Encrypted: i=1; AFNElJ/mwrzSN+a7Xiate8Ef5hMYpCOsiuoaIPqSJ+2mNOb/SK8ptJ9XHsQw1U8JVLQV7AoUfbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHioSUu9ERHxHoI0Cfqfq9nTgG42Iy0hCxgsGcvamdInAVJmIk
	sE2l2hhGY+2B0xhlX83fMfw+2bfj2WBCe/Z8xzNsv6ogBorMznmjBi1t
X-Gm-Gg: AeBDieuK7xyAERghV1M0LLQzkAUxtWHLz9iou9RNzmi5BfDe72nw/42UDAEbzp0uUNU
	q7tODZFgk3YfO+6nJMP6ekNxHl3ehi9dxSOXvA35yTbVle5b9uS2uERMsIpm+3duIQg3s9V6mU/
	RUPdK23LRjbzyx2tDsHAnswuB+eTtujsePZfGQkj0qq/OT9Sak37b1rJA0+WNFG1aSeSk6wesDf
	ufw8at9cLa6WRc3lqm17hfCn04zXyntEKCuZ8JstnHkLk5cSLER6FRYt0HnnawGHfgBzyzqY8tZ
	2rZIE7PUnWIF/CIHs18zFV6gr7YKblCnbQFAQxo0w30LicdrDTfmoNV0pse0am5/gXsACJjtjV3
	RulpZOCQZ3UDfpLGhZw0VzUKLxaoxyaqHeE5edi/k0mrURVgivmqsqvHcr4eqU+si+ncj1N7cV7
	/8G1VQ/Qg7lhtKSFb9YeQ/C0uxWBL36xkpphbX5PKxfzKp4M6xMWHN/IhN3Q==
X-Received: by 2002:a05:6830:25d1:b0:7dc:da80:42b4 with SMTP id 46e09a7af769-7de9a1002c7mr4284996a34.24.1777475913099;
        Wed, 29 Apr 2026 08:18:33 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f812:6a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab99036asm1469135a34.17.2026.04.29.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:32 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:18:23 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Message-ID: <afIhP5dtlzCtzn1T@devvm29614.prn0.facebook.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
 <f954a636-4d21-47c0-8afa-cc4b24adb0fb@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f954a636-4d21-47c0-8afa-cc4b24adb0fb@iogearbox.net>

On Wed, Apr 29, 2026 at 02:08:31PM +0200, Daniel Borkmann wrote:
> Hi Bobby,
> 
> On 4/29/26 12:41 AM, Bobby Eshleman wrote:
> > This series enables TCP devmem TX through netkit devices.
> > 
> > Netkit now supports queue leasing. A physical NIC's RX queue can be
> > leased to a netkit guest interface inside a container namespace. This
> > gives the container a devmem-capable data path on the RX side (bind-rx,
> > etc...). On the TX side, the container process binds to its netkit guest
> > interface and sends traffic that netkit redirects (via BPF or ip
> > forwarding) to the physical NIC for DMA.
> [...]
> Thanks for working on this, after the RX queue leasing got merged, I've
> been looking into the same actually. :)
> 
> I think the NETMEM_TX_* enum approach seems reasonable.
> 
> What I have a PoC on is to build out TX queue leasing as first-class
> symmetric infrastructure to complement the RX queue leasing - basically
> I implemented an equivalent to the latter in netdev_nl_queue_create_doit
> et al, so you can have independent RX and TX leases and per-queue
> accountability, such that ynl queue-get op shows the full picture, and
> lastly we could also enable AF_XDP TX-only support through this infra.
> 
> Would you be open to collab on integrating both and migrating the devmem
> code to work off an TX queue object? Next week is LSF/MM/BPF, are you
> there by any chance to catch up in person?
> 

Hey Daniel,

Definitely am open to that. I will unfortunately not be at LSF/MM/BPF,
but maybe we can schedule a meeting offline to sync up?

On the approach, explicit TX queue leasing sounds like a better way to
permit devmem's tx binding than implicitly via RX lease.

Best,
Bobby

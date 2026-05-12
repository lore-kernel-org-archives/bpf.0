Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055E3932D8
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575924; cv=none; b=obVBCLlD5TuSO/NcVrwBYzT/h54zIRXZSswzA2r8238HgivPez3eZlABeQYxsxOd1UVWnnaTnTP4B2O88ObWa55HV10rUh6U3RSWiRivVHYk6RIL3g5FV5xq0fI3S8IUdNdLHs+ZGwLNmbF+Op8T1Z86ebvKDcrnSvnng+UsWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575924; c=relaxed/simple;
	bh=wokWFNz7bI63AAOLseU/bbt0uw6Z1LwPBKX32U58g8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swHSVmy5Cm2eOQQqxuusSeeeASZPAzFO1b3Nke/dbyPGOBKPx4H667a6FyJKMaxMi/qz12D3R5PI8GWT4pia8yS+ZzFgkwVbL0bsRkSdYiede1hOiAduRCOGKQCrOLIBeaMRV39Ld8dle7ys7ojHQCo7J1e20NS6P2WX1LLlXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2jZ1sI2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2jZ1sI2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso4236438f8f.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778575907; x=1779180707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdKS6wt7hvbXtMDkCbUOAbdHuESGleb4r7UDdCk3stc=;
        b=c2jZ1sI2Gs7G+Ce3RMTMzMtX9UiYIIFrMizPfwJE3fKSNyqwrH+oY96379HQBqS1B4
         Nvg/RG0Thi3zhDpRTPTHtW7qBn0eyNdiuu4mAh9rjG7G0VRN1FT7KGdCTva84CFp8d1i
         lxQdhdJ/brD4ybg/6UQ1ZR+PlNbdqx5jPKoSC5xapp0iOmdtUYNeBoY3ZOEiNXt5Pe9a
         3aYfRsgtcqaZq7iCnnqPWOPPuIQYmPFKQXtQaLhm6Qm2VwIClV8tBhSob3++V3lLv3Io
         7Bz3UAz29OX72glUrL4Pa9ag3VDhUziTiRUmzU+vZB10Pq9zYFOnEQ/Wneb0f1uSN1wR
         ZnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575907; x=1779180707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdKS6wt7hvbXtMDkCbUOAbdHuESGleb4r7UDdCk3stc=;
        b=eozWGHkABZtVUajyA9KNEX2zwDPysqc81dR3X8Sd6K64HLkHvPqJENkDAgJU9kqF2h
         je55lYuWAVUvsIlUfoh2LdpZgXuDbtA5YOEI2oBcXwao0p6ys6NvXR3uU1j0CQ1nFuID
         hflEehVd3qb6iNxwI4FBU2M/EcZSNfl0A1lx+Fyh4Xj/WbRMyXmWVmocr0qVQ+vpYC37
         PJN4kuxvDtZIxMnMT3xuLkUypc8fWwS6v2ZonggYG2JDMejM7SNYDhFJppIWI9x10eIL
         0BkkFy4VLwHEVUe2mXYj9IjESrMB3D2mP/QhWm4xi0bibIAFrDpQOYfCAqNs/NSpvIPJ
         nwwA==
X-Gm-Message-State: AOJu0YxijmVsrN0gIxcNpGUAIMgHFaOHMnXGZYXbJ8JUq3NuPPJ7rQNx
	/wxr17rtsBqZTQY5QzYQMgrNTQn3a5C/QlpF3gUTOQHpyLG7hwbyVaGz
X-Gm-Gg: Acq92OGOCYqAXUKRYc3qgFDVzvhkeQNkmnXWAzOFx89MhL+1zmqzQ7Lh0ZhDo4vht8M
	Grx5uZqSpbztMYZdSL9ymELgnZJRuNhPjECNhZcOWwOxFrmRoGnaMvSiYcDKurBtAomcLqZ/YlR
	0JtYpgBWI+NKkfRywZPwaAu3OkP5smuzHHm/Ao3Jp051/YIueoWWACtzy7w28eWqoYT7z35Kwif
	+d1t3Ap91n4sDbYx7brjkkdFCtRQiMVcBkKzA9vgBiHv0bHlaNGr42hPKvwjFwrr47hO9JhTOV9
	/DcWhVtgTK0zDDS1IEREEIHb12haoeyv3ge8GuRQ8VEIPVfStacAT5ZS8mKolSI6Ry/Ta8HQ8UA
	d+hbKkHn4t7a4PjIVFSD+obGThxFuOG99pYQ+ulOXNJHqnwUn5tXmS06Uyu8yV4d13aaZCd1s+k
	5/yPVOWH/BZ+XNMxDX5h53ENK0ueTupd83Kin1YmE=
X-Received: by 2002:a05:6000:22c3:b0:43e:a70d:763c with SMTP id ffacd0b85a97d-4515df65cc1mr43842070f8f.42.1778575906668;
        Tue, 12 May 2026 01:51:46 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:cd04:3ec4:fb74:7d51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm15570952f8f.3.2026.05.12.01.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:51:45 -0700 (PDT)
Date: Tue, 12 May 2026 10:51:39 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, davem@davemloft.net, eddyz87@gmail.com,
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	liamwisehart@meta.com
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <agLqG31sgzvBN3Sl@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
 <4b64ecd8-eade-4676-822e-da73abe2421d@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b64ecd8-eade-4676-822e-da73abe2421d@iogearbox.net>

On Mon, May 11, 2026 at 02:05:26PM +0200, Daniel Borkmann wrote:
> On 5/11/26 10:53 AM, Mahe Tardy wrote:
> > From: Song Liu <song@kernel.org>
> > 
> > Add BPF kfuncs that allow BPF programs to send UDP packets via the
> > netpoll infrastructure. This provides a mechanism for BPF programs
> > (e.g., LSM hooks) to emit telemetry over UDP without depending on
> > the regular networking stack.
> > 
> > [...]
> > 
> > +config BPF_NETPOLL
> > +	bool "BPF netpoll UDP support"
> > +	depends on BPF_SYSCALL && NET
> > +	select NETPOLL
> > +	help
> > +	  Enable BPF kfuncs for sending UDP packets via netpoll.
> > +	  This allows BPF programs to send UDP packets from any
> > +	  context using the netpoll infrastructure.
> > +
> > +	  If unsure, say N.
> 
> Do we need the extra Kconfig knob? For most other BPF functionality we don't
> have such convention. BPF_NETPOLL could be a hidden config enabled when both
> BPF_SYSCALL && NETPOLL is enabled?

Okay I changed it to:

+config BPF_NETPOLL
+       def_bool BPF_SYSCALL && NETPOLL

So now we need to explicitely enable NETCONSOLE since NETPOL is also a
hidden config defined by:

config NETPOLL
	def_bool NETCONSOLE

I somehow initially wanted to define NETPOL by having def_bool
NETCONSOLE || BPF_NETPOLL but then we have a circular dependency...

> >   config NETPOLL
> >   	def_bool NETCONSOLE
> > 
> > diff --git a/include/linux/bpf_netpoll.h b/include/linux/bpf_netpoll.h
> > new file mode 100644
> > index 000000000000..b738032548c7
> > --- /dev/null
> > +++ b/include/linux/bpf_netpoll.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > +
> > +#ifndef _BPF_NETPOLL_H
> > +#define _BPF_NETPOLL_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define BPF_NETPOLL_DEV_NAME_LEN 16	/* IFNAMSIZ */
> 
> Do we need this, can't we just reuse IFNAMSIZ?

We don't really need it, done!

> > +/**
> > + * struct bpf_netpoll_opts - BPF netpoll initialization parameters
> > + * @dev_name:	Network device name (e.g. "eth0"), null-terminated.
> > + * @local_ip:	Local IPv4 address in network byte order. 0 = auto-detect.
> > + * @remote_ip:	Remote IPv4 address in network byte order.
> > + * @local_port:	Local UDP port in host byte order.
> > + * @remote_port: Remote UDP port in host byte order.
> > + * @remote_mac:	Remote MAC address (6 bytes).
> > + * @ipv6:	Set to 1 for IPv6, 0 for IPv4.
> > + * @reserved:	Must be zero. Reserved for future use.
> > + * @local_ip6:	Local IPv6 address (16 bytes). Used when ipv6=1.
> > + *		Zero = auto-detect.
> > + * @remote_ip6:	Remote IPv6 address (16 bytes). Used when ipv6=1.
> > + */
> > +struct bpf_netpoll_opts {
> > +	char dev_name[BPF_NETPOLL_DEV_NAME_LEN];
> > +	__be32 local_ip;
> > +	__be32 remote_ip;
> > +	__u16 local_port;
> > +	__u16 remote_port;
> > +	__u8 remote_mac[6];
> > +	__u8 ipv6;
> > +	__u8 reserved;
> > +	__u8 local_ip6[16];
> > +	__u8 remote_ip6[16];
> > +};
> 
> Could we detangle this a bit and structure the design similar to what was
> done for the bpf fib lookup helpers? __u8 family and then union.

Yeah I think initially it was heavily inspired by the struct netpoll for
IPv6 boolean but they have the union, let's do it, I wrote this one that
is similar to the fib lookup params:

struct bpf_netpoll_opts {
	char dev_name[IFNAMSIZ];
	__u8 family;
	__u8 reserved;
	__u16 local_port;
	__u16 remote_port;
	__u8 remote_mac[ETH_ALEN];

	union {
		__be32 ipv4_local;
		__u32 ipv6_local[4];  /* in6_addr; network order */
	};

	union {
		__be32 ipv4_remote;
		__u32 ipv6_remote[4];  /* in6_addr; network order */
	};
};

Also used family instead of the bool with this in the kfunc:

switch (opts->family) {
case AF_INET:
	bnp->np.local_ip.ip = opts->ipv4_local;
	bnp->np.remote_ip.ip = opts->ipv4_remote;
	break;
case AF_INET6:
	memcpy(&bnp->np.local_ip.in6, opts->ipv6_local,
	       sizeof(struct in6_addr));
	memcpy(&bnp->np.remote_ip.in6, opts->ipv6_remote,
	       sizeof(struct in6_addr));
	bnp->np.ipv6 = true;
	break;
default:
	*err = -EAFNOSUPPORT;
	return NULL;
}

> Is the remote_mac strictly needed? 

I think it's indeed needed since netpoll is pushing the MAC address in
the skb at the send step. It's not reusing the network stack for lookup.
I think netconsole is using the broadcast address by default, maybe the
kfunc could default to it as well.

> Feels a bit like a burden, maybe for the
> selftest, we should first do a bpf_fib_lookup before the bpf_netpoll_create
> so that the use case where the user only cares about giving remote_ip/remote_port
> and maybe local_port (e.g. to as indicator for different event types and/or
> RSS hashing) works, but everything else is derived via kernel fib lookup.

Yeah that would be nice but then it would mean we need to call fib
lookup from the SYSCALL programs without any network context so I'm not
sure how it would look like.

> Thanks,
> Daniel

Thanks for the review!
Mahe

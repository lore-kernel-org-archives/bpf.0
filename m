Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795613385B2
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501156; cv=none; b=QTFVF8F4CshYN4L9Shhnz2+P36MKXkMViRvdtupU+b+pmKG8qaQFbVKCxcBocAXrCjHBwtsM+OLTu68xpe2GJVYIZj1F6GFkkccigF1Yi1tPYpUPyO4tUuNcYnIpid9dXqPBjtdzBKNUVIHno26bjOET8QosqMmnuCB3xWLAT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501156; c=relaxed/simple;
	bh=c8/SRZCJ5uGxAkH3s7SfDETGeS5qDsQrGb0XJggV2WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Egy5l/VaHpHQ0xjXkahhtpDbqvGSUmFh/BMGW13qfiotzSJ6LGZdlP8MsZVpM3JdsH/ag2X6rmLkUtC91+HTOI0BD8/7NXqHdFJ4MGFCZIgVzEgX1+perRAzSfQdIHc7kQlMDFP56FOx/uKECDTc2aEkuZnVA8iBACrc/TbLukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=kCtS3j0i; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kCtS3j0i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=300dYBc+K80+eqCP1j40jz7SrXIJ/gZPKJ2ppWO3HH0=; b=kCtS3j0iT420bHAaLdqQQ9qsFJ
	blM0tHy+eBLX7svRAHjkkSHQsY09a6GhS5p3Y0dxc3skohDt+cTaYimgwEL/JS4URV9L81nLVfAfM
	sI2DEkAgEr4lucB77IzHkLTGuAQSqs0CNl3pE3fydFRrfkZZgjTGAx1MyzO2h2B8CidrhoH7+hWgg
	JHIP6CmQcUPJan2lsKw5eHXAmSIrhfqAcyBjNwNvMsPhq2XdpdQrcVCsReg7VxCJf8JZQlIuFuHG4
	KfAnGzFXKbOOJnTF7MEMN5DY/jHzpNx71h4YU1DCGvkHvU82RNhHFhJidDy44oNfmQ5L3+EY95tzQ
	4cms0kJg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wMPO3-0008Bz-1b;
	Mon, 11 May 2026 14:05:28 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wMPO3-000KWc-0P;
	Mon, 11 May 2026 14:05:27 +0200
Message-ID: <4b64ecd8-eade-4676-822e-da73abe2421d@iogearbox.net>
Date: Mon, 11 May 2026 14:05:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com,
 john.fastabend@gmail.com, kuba@kernel.org, martin.lau@linux.dev,
 pabeni@redhat.com, song@kernel.org, liamwisehart@meta.com
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20260511085344.3302-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27997/Mon May 11 08:24:57 2026)

On 5/11/26 10:53 AM, Mahe Tardy wrote:
> From: Song Liu <song@kernel.org>
> 
> Add BPF kfuncs that allow BPF programs to send UDP packets via the
> netpoll infrastructure. This provides a mechanism for BPF programs
> (e.g., LSM hooks) to emit telemetry over UDP without depending on
> the regular networking stack.
> 
> The API consists of four kfuncs:
> 
>    bpf_netpoll_create()   - Allocate and set up a netpoll context
>                             (sleepable, SYSCALL prog type only)
>    bpf_netpoll_acquire()  - Acquire a reference to a netpoll context
>    bpf_netpoll_release()  - Release a reference (cleanup via
>                             queue_rcu_work since netpoll_cleanup sleeps)
>    bpf_netpoll_send_udp() - Send a UDP packet (any context, LSM prog
>                             type only for now)
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The netpoll context is wrapped in a refcounted
> bpf_netpoll struct. Cleanup is deferred via queue_rcu_work() because
> netpoll_cleanup() takes rtnl_lock.
> 
> AI was used to generate the code and each line was manually reviewed.
> 
> Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   drivers/net/Kconfig         |  11 ++
>   include/linux/bpf_netpoll.h |  38 +++++++
>   kernel/bpf/verifier.c       |   3 +
>   net/core/Makefile           |   1 +
>   net/core/bpf_netpoll.c      | 209 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 262 insertions(+)
>   create mode 100644 include/linux/bpf_netpoll.h
>   create mode 100644 net/core/bpf_netpoll.c
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index edaab759dc50..8d94c9d58f32 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -364,6 +364,17 @@ config NETCONSOLE_PREPEND_RELEASE
>   	  message.  See <file:Documentation/networking/netconsole.rst> for
>   	  details.
> 
> +config BPF_NETPOLL
> +	bool "BPF netpoll UDP support"
> +	depends on BPF_SYSCALL && NET
> +	select NETPOLL
> +	help
> +	  Enable BPF kfuncs for sending UDP packets via netpoll.
> +	  This allows BPF programs to send UDP packets from any
> +	  context using the netpoll infrastructure.
> +
> +	  If unsure, say N.

Do we need the extra Kconfig knob? For most other BPF functionality we don't
have such convention. BPF_NETPOLL could be a hidden config enabled when both
BPF_SYSCALL && NETPOLL is enabled?

>   config NETPOLL
>   	def_bool NETCONSOLE
> 
> diff --git a/include/linux/bpf_netpoll.h b/include/linux/bpf_netpoll.h
> new file mode 100644
> index 000000000000..b738032548c7
> --- /dev/null
> +++ b/include/linux/bpf_netpoll.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#ifndef _BPF_NETPOLL_H
> +#define _BPF_NETPOLL_H
> +
> +#include <linux/types.h>
> +
> +#define BPF_NETPOLL_DEV_NAME_LEN 16	/* IFNAMSIZ */

Do we need this, can't we just reuse IFNAMSIZ?

> +/**
> + * struct bpf_netpoll_opts - BPF netpoll initialization parameters
> + * @dev_name:	Network device name (e.g. "eth0"), null-terminated.
> + * @local_ip:	Local IPv4 address in network byte order. 0 = auto-detect.
> + * @remote_ip:	Remote IPv4 address in network byte order.
> + * @local_port:	Local UDP port in host byte order.
> + * @remote_port: Remote UDP port in host byte order.
> + * @remote_mac:	Remote MAC address (6 bytes).
> + * @ipv6:	Set to 1 for IPv6, 0 for IPv4.
> + * @reserved:	Must be zero. Reserved for future use.
> + * @local_ip6:	Local IPv6 address (16 bytes). Used when ipv6=1.
> + *		Zero = auto-detect.
> + * @remote_ip6:	Remote IPv6 address (16 bytes). Used when ipv6=1.
> + */
> +struct bpf_netpoll_opts {
> +	char dev_name[BPF_NETPOLL_DEV_NAME_LEN];
> +	__be32 local_ip;
> +	__be32 remote_ip;
> +	__u16 local_port;
> +	__u16 remote_port;
> +	__u8 remote_mac[6];
> +	__u8 ipv6;
> +	__u8 reserved;
> +	__u8 local_ip6[16];
> +	__u8 remote_ip6[16];
> +};

Could we detangle this a bit and structure the design similar to what was
done for the bpf fib lookup helpers? __u8 family and then union.

Is the remote_mac strictly needed? Feels a bit like a burden, maybe for the
selftest, we should first do a bpf_fib_lookup before the bpf_netpoll_create
so that the use case where the user only cares about giving remote_ip/remote_port
and maybe local_port (e.g. to as indicator for different event types and/or
RSS hashing) works, but everything else is derived via kernel fib lookup.

Thanks,
Daniel

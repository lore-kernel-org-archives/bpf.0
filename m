Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C6425CD6
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195264; cv=none; b=ZfxtkJ+Tf/PL4ioa2S1K2rnDUYhqdDg3eMsBUoMhjNQ3OUhNduJIDC9QYooGHIuzYedzvKKZj1Dbkz14jQTaVZhjqfgsT8vAwOU1yg29S1I3teJK76ew0MmY3kiynRx2VlDA+zSpk6mVZMSHKE6qUW75Wg9AL6SI1ELaGPZDluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195264; c=relaxed/simple;
	bh=o6+f15UBh3/yTDV9eUcXAhmyyH3yJMXjUp0vK+0tjRo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nL8d/0hb2qqRkRcz3aEAC7ufrTDGFdDEWpZiniQA0PID7eIIul8/mwegcVyIcXiZoUvHbrM99QM/3nbzo2dbs35KEtpSiQ7VbwZiG9SO2H8UJ3I+mPnY6o2XPyyQrYFhE9KXXq09m1bNBFVRSyxFq8i1cOO1h9qGja2I2lhN+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZRdybbqo; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZRdybbqo"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13809ed8fbeso8978c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781195261; x=1781800061; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHOgJn/4y6N8Z6nRlIY4TDWtqDPGGDCIQEUNbW0Y9Ng=;
        b=ZRdybbqol5AdhTR0qOBDpYqif3qwT0nKMSbxUWBx89q5/fO5PpOCMsZkcLfD9dZxkv
         1HTW57Divqu5vCbcrSlmQWq4/N7k1g8FoTi/cKdn2PUlJK7zjp1LxV/TI0mVTz6Dug48
         Yym0XhMxlX/wLyOqAnGD56obI/tp6bys5v2D2P2kpWzv+sxV1GH6qcNduDZgTAra8/ay
         YOjVm/5AVJuXTYM1i+6ChGkG8NVaWFrMlvIqQFF3ctYVUFAwPT+AGxZxPceMQW72iVyy
         rFy8U1/xQGmtpEpn/DDY+A9LoKfTEsQKpk2wRA9w8R2HFY12/x6p112HEimbLz8F3wi2
         BNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195261; x=1781800061;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHOgJn/4y6N8Z6nRlIY4TDWtqDPGGDCIQEUNbW0Y9Ng=;
        b=QACuVEH/+4pz0InsNVA8z66w+j7MVK/cDHU+EUrwQtTNPWdNRNSQhNu34zdHY7Vjhx
         4FZbTzMP4zTH9bA5ic9Il1TwQKN6edZriopY4+7TgYfV85AuHJzp5XV/u6U6WXIMGLj3
         ONS8bvIRws/BXhHrORxjKIb/JnLGeCDV2wnPajMs0RTs8UYiWGJFVQjXFdbyygvZdIQf
         uRX8bCw5UoCYPvl8WAA2maYt8v/i8uaLgiPuoT6QYM0Zy9v2dRYzBCX6GwDFFVJzlOPB
         Kbnn84jEveNlu0n/zWnOnuSOb4i8FjrDtJ6q9R9pTbK1KXQ3ayt9WVFJERY4z87N7GN0
         BX0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+xJnrty6f6sUoWRUGjA3ewYBXN2odvmPS2gX+6uL3JY2Uzgo4oMeU0YsTVwI3texA4tSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+apQK/A1XA5d4bpyRPvAN2oXH7HKYIaTb6+vTpi1PG8seAoM/
	X/gAJs66y5lc6XE+SNSpOraomD1c7/Rk1fdtWgWHJzl0NxVFOTlkertYBd2E3YglVr8=
X-Gm-Gg: Acq92OGc/y2lWbQjt1RWegiNiV0T3vZ3WPMyVbxwDTxDLL+Ubw+GkxV4ufOessYe+wF
	hBSYWAwsBdjEgbsjgvAWd+KRSrMKtAdlz4v1J56at4JGRTqsyKZ4nC9kgl4mCX1pmpbuTBzs1L3
	qV1PZnqKwpe1fti4Ng5jLwCLyJYrkCJBqBFZ/HckB0ez1GiyEmujFVGrGvjy8KmbOJKQcbpkoyI
	e78wdi55O9n2L1uV3q3Yf+PXSXaglqVccBJLwDCdEKKYqPniNxLXWMp+eq/gYJHm6h1qRY9nP/C
	+8RzqMfioivM5axcz8Zr15BsOs98Fr5xBosnMdkUdXpZqM2BPmjuNhdC5vxsX9MaZIvCuR6gcVW
	GgVbCmPjVu1UkQQRufIkOEovWe1hwsG1z+jjaYxLrBuvcGmby8AINKr+8fHYZ4PCAIq4tC+5jK6
	G/u4KV
X-Received: by 2002:a05:7023:a56:20b0:138:576:fd with SMTP id a92af1059eb24-138421833f5mr1484959c88.2.1781195260827;
        Thu, 11 Jun 2026 09:27:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384303a312sm2857258c88.12.2026.06.11.09.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:27:37 -0400
Message-Id: <DJ6D0SSBHB0K.3B83F5Z3EBQWN@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Weiming Shi" <bestswngs@gmail.com>, "Xiang Mei" <xmei5@asu.edu>, "Xinyu
 Ma" <mmmxny@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Cong Wang" <cong.wang@bytedance.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/7] bpf, sockmap: reject overflowing copy + len
 in bpf_msg_push_data()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-2-jiayuan.chen@linux.dev>

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Weiming Shi <bestswngs@gmail.com>
>
> When the scatterlist ring is full or nearly full, bpf_msg_push_data()
> enters a copy fallback path and computes copy + len for the page
> allocation size. Since len comes from BPF with arg3_type =3D ARG_ANYTHING
> and both are u32, a crafted len can wrap the sum to a small value,
> causing an undersized allocation followed by an out-of-bounds memcpy.
>
>  BUG: unable to handle page fault for address: ffffed104089a402
>  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>  Call Trace:
>   __asan_memcpy (mm/kasan/shadow.c:105)
>   bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
>   bpf_prog_9ed8b5711920a7d7+0x2e/0x36
>   sk_psock_msg_verdict (net/core/skmsg.c:934)
>   tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
>   __sys_sendto (net/socket.c:2206)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
> Add an overflow check before the allocation.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.=
org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> To sashiko:
>
> Regarding bpf_msg_push_data() reading "copy =3D msg->sg.data[i].length" w=
ith
> i =3D=3D msg->sg.end (appending at the very end of a full/near-full ring)=
:
>
> This is pre-existing code, not touched by this series, and reproducing it=
 needs
> a narrow combination -- a pure append at the end so the loop exits with
> i =3D=3D msg->sg.end, a full/near-full ring, plus a prior push/pop histor=
y that
> leaves a stale length in the otherwise-unused end slot. A freshly built r=
ing
> zeroes that slot, so copy stays 0. We don't consider it practically repro=
ducible.
>
> Even then it's already covered: the overflow check in patch 1 ("copy + le=
n <
> copy") rejects the dangerous case, and __GFP_ZERO in patch 3 prevents any=
 data
> exposure. Not worth fixing here.
> ---
>  net/core/filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..3c8f1cedb217f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;
> =20
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));
>  	if (unlikely(!page))


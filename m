Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977D348C70
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112916; cv=none; b=Sl2uZe276V3b7PIcZ4JAaBreG+VlY4tLZKJeF9SXLJq+t1kz2MHdKmdu718CLuSccv/pPVd+vM5cT+xq5BwaW/pqMw6YvdKKym5UGT0bQBDxKVJGr59OmchqSWHMWfYRvWv8WiKssJFSgmB3m1VayJSH0cmiFfQRQPVG+OXNQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112916; c=relaxed/simple;
	bh=GC4dbUj72/CzNM//E7ZABcGs/pl4qLAV5yt/OMal3/E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u9QxNkfQHHsappMXMtKx5xPI2ZtWQag+Av932D2G+I2UAcHTteM9Eyf7aCeSwKRVfS0s4uyMnjh6Rki0tS2wapz5w4Do+3sMmLktafUBLH7FVzYuxFbc1nOTAntoxXUTTGuhY4RXAP8Emjzxx532Srexn2Wj9ns2Q5ItNFtgiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKvri2hf; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKvri2hf"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43b7e186a0cso2870971fac.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112914; x=1781717714; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKXcTAXyiY5MMHqAfWwxOYdso2q+yhhH5j2phXAXPxw=;
        b=mKvri2hfaIpYBPgrMl5ojn1pAFQQ4qGrSeuxtj39iQ7QolwSgmurRK3KTHszE3dvt0
         stkf7MCF7zu2AFFOS2U0s6a2QiNQB3avcmI3uZEmItSwsyhplQ3RLWREwIWIyi8PYpf8
         OudqskRW2+FJ8yIQBiVs5QVZunlYwQm7iT0fcZeR+F+YwhPZKPZO2bKZ3M/pPsKChH1U
         XCXZbDiRArSO913o2Es+6kaJNM9cKKkA56Y4xcyEmuze2m4zbunOefHj4ZxeX/CEwkE8
         B2Q7Z/Jmut6f+RQ3uYKo58BKeaEk4xxznPgZNL/CIMtJOxKzOm3+tMVHfaGXPAae4Jq7
         0C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112914; x=1781717714;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKXcTAXyiY5MMHqAfWwxOYdso2q+yhhH5j2phXAXPxw=;
        b=YEOgAJWtXimXEWYz/V+bWStSBjRsEOOPJFweXfx5NnqMi/jgXmfARCkmr8OKjWKp7E
         ww3l9ylr7o+QwLTOHrDYVO6SbonYCB1ApTmVieXBV96doR2WM1YXucdilSsC2XLGoMuM
         KIUhhK8QqTEl9oBj8O6pWrjxmmxR6Q926m/QTr71wn6Gy3xQZkyt35yIfRTsExgobIfN
         j8ojNWj+eADlGrwbZVdmrk/GmT9TSDxUaJiRpjyrFIjcmgmfYdSgLaLnA/3qkWNY+1XF
         2OYNL/9xMGlNoFTw3aGSw7BwKYxCJj78QXcc65eDdLrNwntf8C+Kv5iGAYGioaE9V5Y0
         18yw==
X-Forwarded-Encrypted: i=1; AFNElJ+6AX5aSl5eUXORVCo5vZla9hqNWkjyQE1l19mI6aO5uQ9ZJFQHlFQllEvpFrMtDfI/lKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOia15rb61Np9XCAEwJ0DVP/9AxIxwndEpOLIyH28gt/ilELKu
	3R7mw86DB+QuuvVgghfFZA8Z/TWzcomO8V2byUaRbq44NBAiNoCE8Qlh
X-Gm-Gg: Acq92OFJZPKAg+XGOKmRO/z5hLyAMd/McVz1HOOc1p3KYygopAFZMeqZAjdOxYElDTH
	5olpQ4MPQUrYd6hnBWEa8Rt4EXGB1G4pwvBn1Mfcdz1UsqHkvLPlOwye1iRW6n675C+T3cVYR4+
	muFDaE+VvW3kM2jck6AthsylDKgDbXr1HDZzvYN2rvqMl4+l/mQLaW72SA+ws9X2yEds8dveolb
	c3gC2oQjYD4qjsLb+sDCNcqKkO5h0srnxZtfo1T0B8q5sGLxe4FNoEBA2RTGETtFZicolMIdL7z
	3ED5wm8HnCN1V3vXG0DyeUll+SpXlh7ElK5RPilbEHMmgYVFdgP3Kp9G7DSF48O7vWBhVh0YSn+
	KUTLxcZhyN/NHwyMTZ5xOTmR5kn+vxlvp0sawy0lObLsYqz8OXdd+vEM9bKvqq8RyGFSNbr7y5G
	0Nx5hcBorrD5x1HBvuoQponXeccYOSNn/3Weat/L/11/6uSAIECWEDSbbFphx4W+dIYkl9WedYL
	Nh6Eat9IycFtjMARpunlCPr0wA2
X-Received: by 2002:a05:6871:606:b0:442:3434:7dd6 with SMTP id 586e51a60fabf-4423434e34emr404867fac.14.1781112913657;
        Wed, 10 Jun 2026 10:35:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7263efcsm22580309fac.0.2026.06.10.10.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 10:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 10:35:10 -0700
Message-Id: <DJ5JTZ788GDY.FXAAY47YDG3N@gmail.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Cong Wang" <cwang@multikernel.io>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>
X-Mailer: aerc
References: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
 <20260610081218.506709-2-rhkrqnwk98@gmail.com>
In-Reply-To: <20260610081218.506709-2-rhkrqnwk98@gmail.com>

On Wed Jun 10, 2026 at 1:11 AM PDT, Sechang Lim wrote:
> start and len are u32, so
>
> 	u64 last =3D start + len;
>
> evaluates start + len in 32-bit and wraps before storing it in last.
> The bounds check
>
> 	if (start >=3D offset + l || last > msg->sg.size)
> 		return -EINVAL;
>
> can then be passed with an out-of-range start/len, after which the pop
> loop runs off the end of the scatterlist and sk_msg_shift_left() calls
> put_page() on the empty msg->sg.end slot:
>
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
>   RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
>   RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
>   Call Trace:
>    <TASK>
>    bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
>    bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
>    sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
>    tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
>    tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
>    __sock_sendmsg+0x153/0x1c0 net/socket.c:802
>    __sys_sendto+0x326/0x430 net/socket.c:2265
>    __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
>    do_syscall_64+0x14c/0x480
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> Widen the addition with a (u64) cast so the bound is evaluated in
> 64-bit and a len near U32_MAX no longer wraps below msg->sg.size.
>
> While here, change pop from int to u32. It counts bytes against the
> unsigned scatterlist lengths and can never be negative, so the signed
> type only invites sign-confusion in the pop loop.
>
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 80439767e0ee..9cdfec2ca11e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2974,8 +2974,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  	   u32, len, u64, flags)
>  {
>  	u32 i =3D 0, l =3D 0, space, offset =3D 0;
> -	u64 last =3D start + len;
> -	int pop;
> +	u64 last =3D (u64)start + len;

sashiko is correct that there are 4 other issue in very similar code path
all in skmsg. Please fix them all in one go.

pw-bot: cr

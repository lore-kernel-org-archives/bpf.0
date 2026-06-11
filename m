Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9940BCD2
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196858; cv=none; b=One+k8HHmiTTxiOUK45HFQvWVmeUmesKEqsUUGoQCs7nPnw/nG240tmUg27h6gCu53+WCN3fE2CORQQVGPWSivAY7E0uuKF1UYH6SpjSSs1G2/doyYFktyZjPI9jh1V0dIgGIOSRjGRBIQ52VX0mta3DUZzM+WsCG0/DM6b16Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196858; c=relaxed/simple;
	bh=xQ7CqVM6Cv/wUPHS4u37ELPAUEgOdL1GoqD+eDoxsTw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CXBdP87ufEYcoRn2D0CmRBCmHW2B8St5J8ohNFvtIuDYa2AhP/bEMdN/glMBN8rM5Nwtozv5hmhBSZRCE0ZvlcOXw9mPhcekDP32ec7iTV93pO4V68t9A6L+yS0Mlu8aeVKtNmziGq00DJAHXZ4uXHMJDGAzK6JDuRpD+a1c6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=piQdKggZ; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="piQdKggZ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-307d0405e07so144699eec.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781196856; x=1781801656; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6ceVOGme5lPB581G5XFGTQ1yGvtSh529zyR2h7e/S8=;
        b=piQdKggZb7scrSLHx6CVg3bcoXXRmB70LzOUxA7VJ/k9a8e50JQE3GQZZ0xyGuhOzx
         fPXbi7Jb2abCZA/r6sXrdb7UpO1XBE8qIE7pFVSLBadLs8VbXVqFzZRagAtabVIfjx8M
         kGVUBxcDnm+LF13lASl8u1q/ExUhlCGfCnDr9/KFpeR1jx5mgGM9Li2oxPPC3dOTz85s
         /xF/MThN2/pD9/uvo5N8N7Ri9LYX763+B5f408FYJR+mmMcKEXWQyM69zohd0/1d2Yyj
         4FsWWx6OVZ/+At3P4QdESrGL9I6Y96r0o2BNMs9OSZkU96+Ki8OoqMLSvFUVlqW0+6Wd
         9Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196856; x=1781801656;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6ceVOGme5lPB581G5XFGTQ1yGvtSh529zyR2h7e/S8=;
        b=VnYToYKUqhoDAbVB5YL3ky0gVA3gduwPlOP1/R9CM0zk66ttXE5Uy3CgBGx7Eukt/S
         1G96oNyN0pOxAo6E8ePWcRCMUtEdx8/vSmYzBO7Un7jAV1lq7Xp6Bppg1fqjIL2SxysM
         1hEL5DF7R82F1UrtSHfbBohPmBLcfg+Gh9i+NZLNcLfwrtZLpW5UJZ/iXHuCMLlkLHNH
         +2N4LuEPm28+UI/HKvhVuesda+HRlNy8KBKOLIPsnbaG2AfB8CK0xCQWKAEeohr5OKAC
         m6CcZ3/UDz/iBAfRu/QZ0mNyqHrS8d0N8H4NvrArKB2rXeBwU0vBIRzgNkn7S1Mu6EoT
         ED8A==
X-Forwarded-Encrypted: i=1; AFNElJ9V76Xflle90ZXr71DYSCEgNxcHS13uaYPS+8RKKQQ0jkyjCyotIdfQ30kWpxUClPW/4b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5Fk8DzgWW0huomH6vZz73B3Vk4FPSwIA4kpsHtMyV24Y4XGG
	8AdE4S/9Aq/ar5/tZMdFbD6hZcVrVVQJ9u81Swk3tJuVefoukSeTh708fcik62geZ0k=
X-Gm-Gg: Acq92OHuMUae1FrdjTQvZUby4ocFiU3zyPM9IjPkCTb6I7ysuuDBtxRR0sPmHUx9J3/
	dhVVzqWV0wxbLXhnMqljnv65J1kWILvq6C/tzcEHXdqJFIE+yqTR42fgZ9QSHKaUDX0cPX9TEwM
	+ZqC8T0wy2TG3iGmH/muWzLCeRNKS/Uw9rQaETZl1Rp+tEAMZ3kzIDlGUNBT2PGLCtBGTaNCd8K
	mgunB/Kvvas8JKnLJ2Kxx+7j3cYV88Lt7x2HDLKwOlDTSzKaoK81q2AzPHR8A6nfneGQ3pVRU04
	hfcP+S0jczVvmy90iVF/n/qg9eEZpkcMeIMAGSpnNayB7AoqmUaTFmeDD/rlGewGJBPFgE+trK5
	NxVTwiGIkbTUSw4s/APlO6W96yyQiINxue9nyBjoLWcpNoradxFcmtSoAaq9f8Xy315bV2Wmqvz
	i8XfuV
X-Received: by 2002:a05:7301:688c:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-308049fbd21mr2915715eec.22.1781196856367;
        Thu, 11 Jun 2026 09:54:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c2f3absm2523710eec.5.2026.06.11.09.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:54:12 -0400
Message-Id: <DJ6DL5UQ8RM8.15SYAIW57HN7I@etsalapatis.com>
Cc: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Cong Wang"
 <cong.wang@bytedance.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 6/7] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-7-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-7-jiayuan.chen@linux.dev>

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Sechang Lim <rhkrqnwk98@gmail.com>
>
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e35e681a15dca..742aeeea13c26 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3048,8 +3048,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  	   u32, len, u64, flags)
>  {
>  	u32 i =3D 0, l =3D 0, space, offset =3D 0;
> -	u64 last =3D start + len;
> -	int pop;
> +	u64 last =3D (u64)start + len;
> +	u32 pop;
> =20
>  	if (unlikely(flags))
>  		return -EINVAL;


Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC3374722
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074197; cv=none; b=SdM3koVcIr1VMCD0NJlAWmlTBysOI8PcvrI0D/na6DZ3DXNHmZuDE3NvtzktSDEhaI/9EpWvFIw2DHvIJFv1DmfDD7QGKLUqLsQZJFcHjDn8wd3V4aTJwYehEjzrDCCGVcqSjqU/Gi9CU/Aple99B+iuJkq1dMtkFkq9d8Qd+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074197; c=relaxed/simple;
	bh=m+rtffXbk4ifCJBFq9/62HPPJp20vSM/VxyiWysb+XQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ieh+cqA46qOU/FuXG2azFzgLAfhjF3W8Les2cio387Ojyi+xwPfutq2n5LlEuRq0vNnZkMbzQ6H9pLgFBcQ6Esr8VklJX8ZfKQI6lFhDmz0I9lhxpczsQAzBfY9nxZaTaH75Y4uanPHpK49Lu186zuSmtbG+9mu9vV9lSR3Dm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qR4STwXp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qR4STwXp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf1f074a12so10940595ad.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780074195; x=1780678995; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx8SRsm+SrxoCtbHYDythYGmPY/DElxD8wrBjrt60Os=;
        b=qR4STwXpn2pCA3llybBdmOQNpRkL+dJSvhUE9bpQVdAhdp1ux0sFzmBORuPVWwPKa1
         SetM2Kn8tFtLtYEhKxxyY0mE60J0vO9RQk11qLQjO8MQCTJpx5uUM98WuDlThqBvFXU0
         alLFD3WtBdEkcmwvS7tk1/jAhXemfP3iJhBjUegr33VqZESEmdYneKA1DLJCYDUGGepd
         W9RsXe1ZomDl6Vg3LpYJyde8lIPVTQKUoezH3tBhVH/kIJOUrDdrXgByLxIY4DOsYRzy
         TYkbFj7gMOKAyPYz3TgnXJYE1nJBP+HSclGHoztqtqZ62JW2ac2skMMMFzTLZVdpBxYI
         97kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074195; x=1780678995;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gx8SRsm+SrxoCtbHYDythYGmPY/DElxD8wrBjrt60Os=;
        b=ZMCyd4w8IOC4HdOg6MsJdI/VUKfL3LjkhZTw5IjXigNgsadhCuiCl5gWIfIipK9qqm
         4IGIbqD3qXQTlaLCbzNFCqUuxOgNq35I7UnbTZIBLqUK0HsCVxZofALlDEey0kOSTCJv
         I1APX0txziM4F6LgJmKbtc95x6MDkKYUpidFoIdIlcxeXHnlw0QeKvCe/xRDY2KGK+jC
         RbGQXh9FEo4UpTP14vzwMhjgLehcjMgfvOgOXhZRyH95UJp0o/S/UjGbBvI74tMFVJKY
         Ev2mNCKNJDuc9BjISXMX/YaolfEXi4KGTvAryZz4SSfh2PpMlLSuvZDkyA27T/KHpSef
         PnKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vgrneFOlUEdKDUX+85Ab1BZvK0xuloI8KWgUlxPBZQ43/TMJ2KwtFS5edHCegaDxY0HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHi9BGlJRMPzJ78Izr6cbF3k6WrFhrqlVG18uaD7CfsSTWtdU
	u1gG7XCOl0sEp6RtURep8PfWL8wPcDm+Y4mbCkyZvRt/luPlnNSK1E8Zh4Ufpq//Tn0=
X-Gm-Gg: Acq92OFSy2Z8vzQ9eVv+GP7q5g74nZ9xiaxHxydpNlXGm/3g3e8BLbCCkqEMdeqZypM
	mXhmOS74QulAlntsdroF+gVT3gbxnHm9bsn4u7d+JK7FlM7IOsbqUy0pPMQF1fqWK8neKQfiWxm
	/j4KvE2kR2w2JjIv4+cbBJED+e2oaslN7uehHZj+Cpz1mkN2ZlLt3cf0nLATzWYVru35WFiN1de
	RJ+Xul9Qf6nDJxx5CwFnyQsHBxXkM4mg7vm7ZlFe3js6lOauVwZcoe50rYnvAzEUQ7bWJ51rFx+
	S2U/jIMtuwJy7JRthkGewmyDZnOFNJXnorKkWZrEPNQYM5I8Fcr9uRhU9Xo1nAqsf0kJ994VLwm
	fnAJli1JWp6flMy/gjFxS23p/mRBDVFP7wNGS87QxbeomtWsuEg07SaJiHLrQErT8KAzw1FJ0gz
	0nmlcC7L55ebDSyCgt9RvAmUMWZyXroptLjq0=
X-Received: by 2002:a17:903:1c6:b0:2ba:4ad9:70f6 with SMTP id d9443c01a7336-2bf36875e60mr8242725ad.31.1780074195151;
        Fri, 29 May 2026 10:03:15 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf7b6609f5sm316825ad.60.2026.05.29.10.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:03:13 -0400
Message-Id: <DIVBMZAORQJO.3T89A5STQCKTC@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <zhuyifei@google.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: test fork on zero comparison
 with wrapping ranges
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
 <20260529-cnum-split-at-zero-v1-2-986c03752226@gmail.com>
In-Reply-To: <20260529-cnum-split-at-zero-v1-2-986c03752226@gmail.com>

On Fri May 29, 2026 at 4:13 AM EDT, Eduard Zingerman wrote:
> Add tests verifying that the verifier correctly narrows a
> sign-boundary-crossing range after comparing with zero.
> - fork_on_zero_cmp_k - BPF_K conditional instruction;
> - fork_on_zero_cmp_x -
>   BPF_X conditional instruction with src being zero.
> - fork_on_zero_cmp_x_swapped -
>   BPF_X conditional instruction with dst being zero.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 ++++++++++++++++=
++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index bc038ac2df98..f97b0e109326 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2294,4 +2294,72 @@ __naked void range_within_cnum_cross_both_boundari=
es(void)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__success
> +__naked void fork_on_zero_cmp_k(void)
> +{
> +	asm volatile ("							\
> +	call %[bpf_get_prandom_u32];					\
> +	r0 &=3D 0xff;			/* r0 =E2=88=88 [0, 255] */		\
> +	r1 =3D 8;								\
> +	r1 -=3D r0;			/* r1 =E2=88=88 [-247, 8] */		\
> +	if r1 =3D=3D 0 goto 1f;						\
> +	if r1 > 8 goto 1f;		/* r1 =E2=88=88 [1, 8] */		\
> +	if r1 < 1 goto 2f;		/* must be dead */		\
> +	if r1 > 8 goto 2f;		/* must be dead */		\
> +	goto 1f;							\
> +2:	r0 /=3D 0;			/* unreachable */		\
> +1:	r0 =3D 0;								\
> +	exit;								\
> +	"
> +	:: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success
> +__naked void fork_on_zero_cmp_x(void)
> +{
> +	asm volatile ("							\
> +	call %[bpf_get_prandom_u32];					\
> +	r0 &=3D 0xff;			/* r0 =E2=88=88 [0, 255] */		\
> +	r1 =3D 8;								\
> +	r1 -=3D r0;			/* r1 =E2=88=88 [-247, 8] */		\
> +	r2 =3D 0;								\
> +	if r1 =3D=3D r2 goto 1f;						\
> +	if r1 > 8 goto 1f;		/* r1 =E2=88=88 [1, 8] */		\
> +	if r1 < 1 goto 2f;		/* must be dead */		\
> +	if r1 > 8 goto 2f;		/* must be dead */		\
> +	goto 1f;							\
> +2:	r0 /=3D 0;			/* unreachable */		\
> +1:	r0 =3D 0;								\
> +	exit;								\
> +	"
> +	:: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success
> +__naked void fork_on_zero_cmp_x_swapped(void)
> +{
> +	asm volatile ("							\
> +	call %[bpf_get_prandom_u32];					\
> +	r0 &=3D 0xff;			/* r0 =E2=88=88 [0, 255] */		\
> +	r1 =3D 8;								\
> +	r1 -=3D r0;			/* r1 =E2=88=88 [-247, 8] */		\
> +	r2 =3D 0;								\
> +	if r2 =3D=3D r1 goto 1f;						\
> +	if r1 > 8 goto 1f;		/* r1 =E2=88=88 [1, 8] */		\
> +	if r1 < 1 goto 2f;		/* must be dead */		\
> +	if r1 > 8 goto 2f;		/* must be dead */		\
> +	goto 1f;							\
> +2:	r0 /=3D 0;			/* unreachable */		\
> +1:	r0 =3D 0;								\
> +	exit;								\
> +	"
> +	:: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";


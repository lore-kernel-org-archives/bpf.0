Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31AC18DB2A
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779507932; cv=pass; b=qg35QicmQzhEejdeTtIEf3P31Pi+ismqe0BElkqvM0UtwLsu6HSUBba6adc5Hv8IpeFCvsRgwRDqcg1imZrTst2vFFIBQx2s8KKRvmqX2U5VhNyzumH3MjCUEe874aIcxriAMSKZaAJCn3fRDlmiehneEReWTgnKv/s3N6KfeLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779507932; c=relaxed/simple;
	bh=lRHjyyY93s8zco7Hkw4E8F42qqWqrJl7lyHZv93adbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFXo1ZZmCSMOVLTpuogUr4NWEyW05/cr07LLmIiNKiAYwbYfu93t/GYvjasQvXboBpkxdnu2rZCLoKua4asuA48m5a9f6VqESL6hPEOv+hx9fkeYfXnIXeYPV/QxTjOAjJC9PELam3cucUhLPXJwPbeBpwpsGUdSsxNo2/f0rPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSRngL3e; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSRngL3e"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12ddbe104ccso5960765c88.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 20:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779507930; cv=none;
        d=google.com; s=arc-20240605;
        b=UU4I45a75xYgGGQafw3KFCyqqJ2b3EW8jWGMQnmvUHo38j0GFt7A6SZHpn3ptv+IWM
         Cl2xBw6A+84VMb8uMnp29sMlpmfp0FGiwTXGX5qV/kvWIPBty4P/bcDjbuwdjmATBvMH
         6kSB9ab8ZIUuUgBqZQA+7dSMpPm5gF7q4pKOrPlY/UmQQazgNHO0EgXGtPRtgVzsfWIm
         rUDtqSyfqLOWFwT5wXffX16cPvByMj0oRCifp4iYA6K4T8yOthJyx3ML1+Ax31iqigav
         BrkF6XYe5P8u1uFLWo7Y7mkuXHGDY8EUH9xKUzVTw5UKz3seXTP/e+moG91wR44Jmxmh
         NhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q1lxXIMKtRJqWpbij0xKSJz8c1311LgC7gC5lh2geAM=;
        fh=KbCmgLmnz48qjhDirqy2wjZgTl1POFQi5QziLuG+CXk=;
        b=jECTMwq7UxDgpcD54rxwm6ucMrg2aTxSkNdFjAY8WgazuKw0tdmbb5pjmdiCwt4eK0
         f7TMpSh7iE1jJ/jFGLUR6THVQkFA/DHf3os5AVnIr9a/Uff1NzLKIXzVVHem1C67Phpg
         PYJNLomSu6J2WXdS3frTJiDCuaCcaFQkhMmfybRucdaa6io4ruB86FnZF6G3qzMvLUls
         hZ+77wFTtd/4+EwSfe9GHYDGihrY63Zxhk3mHRaCzuJywOMndY+TvBZAVrMebbZo2cY2
         ROyn+f4rBwanARZmAtuGGNgLJ8qS9onE1abuqWrWfcfNRgQ3n+e4ti5Jr+iLoQ1EsHWO
         HUOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779507930; x=1780112730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1lxXIMKtRJqWpbij0xKSJz8c1311LgC7gC5lh2geAM=;
        b=pSRngL3eFtqungHJAMa+yDXG9DZk2mPCOLR4LSBc04LrTDbf2EUDShJhwf5AA/ptHw
         mIeTjrZKOfXAOqzfZXq/Q3xPRPBhYVl7Nf0F++/53FTnUeudbCZR6E3r+wdsN/hx7Hyn
         INDD0+wncOxU3VWifyGETiBPBVy1kkOZx/ukurdhisRsNlGUlcbj3/4Ywy1UHH5F9sdw
         Fbjxrf41T+pd5NLBtp/jGUbrXE+J+ACsxJNjPTk1W3kwj++ZRUQSUl341kf5xLHDTkzU
         KIu3bVnQL596hxh5lU4m2AS2vJyCLCABa1wmL362N2TNREYLFiLroV+S7GcXg4ZxRred
         g+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779507930; x=1780112730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1lxXIMKtRJqWpbij0xKSJz8c1311LgC7gC5lh2geAM=;
        b=aX2A0VRAbODYjUVH8Z0gtvXtHqchv8qzQqBTj8aApiq+RsYWErjmdy9+dqdjDpy7i9
         CbVvv5yauT7S6hCaE+ZAeq/Ys0gYImQKVHiX1Z5ZduAC0nQSxRI0gH5gWx/A8V2Zbv43
         y1kPm9V0jeadjeYSFlsMkN5Bq7y7PpELbwp/jGzSzQPizwknEqDvgZg9e3HaJXRZpSJ9
         c2z/gnU57VmHXPg5a7hsz0iJR9oqK4DytAuwCI7E7PvcKODPJV8PTcCXsoq/lorEzn96
         F7wF/on8E0x22ColAfEcD3GoSkU1sJ+NfJCE5QGGnQ8SYz7EInrcG59IWbpJSBbHM87h
         VQ3w==
X-Forwarded-Encrypted: i=1; AFNElJ93hhf3wBZYojfsp2PppbkNoa99FzYOONdWDuUDWZvSnyf5U5VzqkWLsahHaml/bERCuLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRe1R/n/vIt9BZ0xydcSyyLWWQAYN64hlaF/zcmlaZ0OZr9gY
	L2izksP6eQHITc+ffM5u6surMP3gNZg7E+o6wJEqefPqsF89BP4+w5jdgpBpXf5zAASm3J3XrO8
	POmMYzkxJge3TWtV2qcgn6E/4Odc/D9QknM66zkIX
X-Gm-Gg: Acq92OFlOgAHpf4sVcpUGKfD6pI34zKpCZpnPN1CKRNJ12fm/1+erSBmKZFlrd/iI3x
	8e21U210PckzNowDS5nzNOK/bJVV1exPA9cgJbuleZP5iugpCOUVGN76n7YU3DEuUda9ZgNrqGW
	krzKy6kD8R1cvbGEbouA8+xwIEuCXy0p6cYGxA3uKkLi+P+uxwJu9X/3/2ux4+7TQFI0YCiVQM+
	FcIkyxtv6RhGYVZIGzbZJKtLIpXqGVGQApMsQYbnkJfOZCltnXnpZbL+m1m/ZkQippWzuVv/8h1
	//OAtL8Ld0DI8KgVYjXk4DkVAccXo2MX/ujpHd6B6Ug5yXscRPLdzntFoZkiBS31S2OO4eKmXNH
	LW9k/1MemKVBzAPk8hmP3o4y6GIMwU9GtL19KKfjwxsZbZqL2Q315OqkEhE/cK80=
X-Received: by 2002:a05:7022:31a:b0:130:ca3d:f963 with SMTP id
 a92af1059eb24-1365fc637cemr2036341c88.41.1779507929294; Fri, 22 May 2026
 20:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com> <20260521135244.40869-6-kerneljasonxing@gmail.com>
In-Reply-To: <20260521135244.40869-6-kerneljasonxing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 20:45:18 -0700
X-Gm-Features: AVHnY4IeLjCR1jS6PCs5Xcpr8mg2UcgrM7Vo5vku5jBhf71wpQp-9S3YIggYdNA
Message-ID: <CAAVpQUD8gsYPyZS4Dbyo0DMEjEczBTJRZ3OW51CPZhnLw22YGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add two if statements to accurately isolate bpf timestamping and so
> timestamping. They can work respectively.
>
> As to so_timestamping, only add a loose condition via report flags
> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> and performance impact. If the loose condition is hit,
> tcp_recv_timestamp() is able to handle the exact case and doesn't
> hamper the existing timestamping feature.
>
> Make it work in TCP protocol.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c71612..7ad3561dc8cd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2353,6 +2353,16 @@ void tcp_recv_timestamp(struct msghdr *msg, const =
struct sock *sk,

Simply drop const from here rather than casting to
non-const for bpf_skops_rx_timestamping().

sk in all callers of tcp_recv_timestamp() is not const.


>         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
>         u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
>
> +       if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +           SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> +               bpf_skops_rx_timestamping((struct sock *)sk, tss,
> +                                         BPF_SOCK_OPS_TSTAMP_RCV_CB);
> +
> +       if (!sock_flag(sk, SOCK_RCVTSTAMP) &&
> +           !(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +           !(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE))
> +               return;
> +
>         if (tss->ts[0]) {
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>                         struct timespec64 tv =3D ktime_to_timespec64(tss-=
>ts[0]);
> --
> 2.43.7
>

Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD793ACEE2
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249539; cv=none; b=bkKDdvEKwTdMctGwWwxw+TotbYJPMobzrwb9lM9YCCK7rI/mjXUlSBrtKAayJVe/nHUGBBnpneX9Rcp81ZsOZF2Xi3dN9U4hKCfQjJg34CBxS2bCBL8qrXvIfrDzBCrgmdfDoEly/jSNuelkUrBuoG0JEF6Ve3gw6KNm+JjfDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249539; c=relaxed/simple;
	bh=S1eJV4kJ7nmlMKv2y9bZFvkIcCAM5Cr9BpnHbu8WxKk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mRR1u1gdT6w/1QSunUqH2KYZ9ynoKYkxGXKYyp/5n0txq1G6XKiupZa9ARSrQRVw/BJs2r2fuMpFh0Z7qNJHqpvzHjkbj0MRVLgz6BevVXgC6XntCCsgaxe2DFnebAwZwb36dZzPxYJ2dDzgWVMA8BrnUgkHhgFfL3sWj0HWHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=H4IMWqok; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="H4IMWqok"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b9e755555so643537eec.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782249537; x=1782854337; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5BgpTjoZgaJ0PY0iyE7wkUjb4+de8IJta3bMQcWgWQ=;
        b=H4IMWqokzreXoxF6LhqOcwkZ4vx+rw+H0FX7qiAwN/J1zBaJLHXXaQ+sstJscd5NKE
         ev3girfSTJ6ykmomwCNCuBdSuAdhdSLdb0K42mPZXTvKKW52Fa2OT+WcdA5cb2uBs5O4
         J5+n5o7ExL4Vr569d5xX06ItFCu0Xkau+PpLv4EBVAhuu97+FK5G6QovaiCqi+6E6bwH
         QgYdn8jFiY3RuXd9V1DQypoOC5Fb1Kvnpaxa49ZR+9aR5SShTVjfHaPvxeWOAq3lM6v+
         UUZYE8Hms+UNxdm9o3nRfn0yfKIMhLTKPUk/m88G9/XZT+EPzO0+HeLfzMdzw4+YKUQQ
         Iiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249537; x=1782854337;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5BgpTjoZgaJ0PY0iyE7wkUjb4+de8IJta3bMQcWgWQ=;
        b=cUGGiYH17IxhHTeYC/M26tmHMRJpYHhwsxRuKPzaL2/u9jFReHMfFD8ACUVv+OAy+I
         6hbZgfcyhMuV8tcw9LV2yPLfoeR1lUTaKCveV5cxaoE/LN0u2sZvKPOzBFg3iBnCs514
         d7v6LswuhQeCPTqyfxy9WSwmDmhbZRvw8Poc4p08l0cgSp9/gaG+Db99e4vZu1GzJAuV
         7kasiOodMsdy3yiGCsEeixiRgA6SIFxHGufqbFir9ANAqB5tmKc9CIm6U7Y5DXozF3Pm
         fHjm0G7kbOZ73BCxyXFsYK7bVq/TZLnScKp/4PhK4IEnVoWM3LGODP1attUwlmpCIWhW
         uLRw==
X-Gm-Message-State: AOJu0Yxj2d1Bep6wbU6wrBkAh2f7npMEchhQckdMWVAe8umj+qBROUaT
	WX0ZcHelJjGn1V9bQ9ukmM064tlziEQktgQJVoTM8ki506L8A3r/9CNVSUoLkOxU2BZJu8/elNW
	fuABfCD8sQQ==
X-Gm-Gg: AfdE7cmXBLniGKGj1BFmGSRLYezAlmguGTQtX9lER8KvjXQwGE9sE0V8ZGIjSFfq6zD
	K7DaVhTGx2Pc09nuuV2X3vgojb1iK8+/11G2Vf35u0EuoYaEzw11SEM87aJ4Pzs0a6BINzeGscI
	6YDZljY2sjasRrFNi2JiPwTD3eALVND9ImBAdjAcX34IFjkQFTVamhWTxOqS6KCC0fU+fvSMNea
	3KJajvUNWYAh3iu9WKVLKwiucMFifSn8PnwT9ERgxzAho4SaGblXkRgTzA9CfdtiqhPbKx5cyYj
	RLEYUhK14WHVDR0dEi8gCFFSTm49h+3t42d1d0Zc4VnTyKbR06ccldov8d42W9LqgLXXK3py47Y
	h0QQWDoAqNqFhvbW8H7i6yXtfiBN9yTK5Va+yqyWiOp6nHNfwvD6zUFRvK1er6WwfNOlvmg==
X-Received: by 2002:a05:7300:8b14:b0:30c:5534:e6f1 with SMTP id 5a478bee46e88-30c68df3b11mr792681eec.29.1782249536721;
        Tue, 23 Jun 2026 14:18:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm18297838eec.5.2026.06.23.14.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 17:18:55 -0400
Message-Id: <DJGQQDCXHU7C.8HTXC4NI0134@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Michal Luczaj" <mhal@rbox.co>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on
 sockmap lookup-bind-release
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
 <20260623190018.2B5A11F000E9@smtp.kernel.org>
In-Reply-To: <20260623190018.2B5A11F000E9@smtp.kernel.org>

On Tue Jun 23, 2026 at 3:00 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] The cgroup file descriptor `cg` is leaked because it is never =
closed in `test_sockmap_lookup_bind_release()`.
> - [Low] The `struct sockaddr_in sa` is passed to the kernel via `xconnect=
` with uninitialized bytes in its `sin_zero` padding.
>
> Pre-existing issues:
> - [High] Calling `bpf_bind()` between `bpf_map_lookup_elem()` and `bpf_sk=
_release()` on a UDP socket mutates the socket's `SOCK_RCU_FREE` state, cau=
sing `bpf_sk_release()` to silently skip decrementing the reference count.
> --
>
> commit f32ef88a53a5c519bf4b22a337fa782c27f0ecda
> Author: Michal Luczaj <mhal@rbox.co>
>
> selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
>
> This patch adds a selftest to reproduce a UDP socket leak. It sets up a c=
group,
> attaches a connect4 BPF program, and triggers a sequence of socket operat=
ions
> (lookup, bind, release) that leaks the socket on an unpatched kernel.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> index cb3229711f93a..11972ffdb16ed 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>
> [ ... ]
>
>> @@ -1373,6 +1375,52 @@ static void test_sockmap_multi_channels(int sotyp=
e)
>>  	test_sockmap_pass_prog__destroy(skel);
>>  }
>> =20
>> +#define LOOKUP_BIND_RELEASE_CG	"/sockmap_lookup-bind-release"
>> +#define LOOKUP_BIND_RELEASE_REP	64
>> +
>> +static void test_sockmap_lookup_bind_release(void)
>> +{
>> +	struct test_sockmap_lookup_bind_release *skel;
>> +	struct sockaddr_in sa;
>> +	int cg, i;
>> +
>> +	cg =3D cgroup_setup_and_join(LOOKUP_BIND_RELEASE_CG);
>
> [Severity: Medium]
> Does this leak the cgroup file descriptor?=20
>
> The fd is acquired here and stored in cg, but close(cg) doesn't appear to=
 be
> called on either the success or error paths before the function returns. =
The
> cleanup_cgroup_environment() function cleans up directories but doesn't c=
lose
> the test's held file descriptors.
>
>> +	if (!ASSERT_OK_FD(cg, "cgroup_setup_and_join"))
>> +		return;
>> +
>> +	skel =3D test_sockmap_lookup_bind_release__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		goto cleanup;
>> +
>> +	skel->links.connect =3D bpf_program__attach_cgroup(skel->progs.connect=
, cg);
>> +	if (!ASSERT_OK_PTR(skel->links.connect, "attach_cgroup"))
>> +		goto destroy;
>> +
>> +	sa.sin_family =3D AF_INET;
>> +	sa.sin_port =3D bpf_htons(1234);
>> +	sa.sin_addr.s_addr =3D bpf_htonl(INADDR_LOOPBACK);
>
> [Severity: Low]
> Does this leave the sin_zero padding of the sa structure uninitialized?
>
> It looks like this partially initializes the struct on the stack.
>
> [ ... ]
>
>> +		if (xbpf_map_update_elem(bpf_map__fd(skel->maps.sockmap), &u32(0),
>> +					 &sk, BPF_ANY))
>> +			break;
>> +
>> +		if (xconnect(sk, (struct sockaddr *)&sa, sizeof(sa)))
>
> When sa is passed to xconnect() here, can it leak the uninitialized paddi=
ng
> bytes from the userspace stack to the kernel?=20
>
> Would it be better to fully initialize it using "struct sockaddr_in sa =
=3D {};"
> or explicitly zero it?
>
>> +			break;
>> +	}
>> +
>> +destroy:
>> +	test_sockmap_lookup_bind_release__destroy(skel);
>> +cleanup:
>> +	cleanup_cgroup_environment();
>> +}
>

I think these issues are borderline cosmetic but valid.

> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_=
release.c b/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_rele=
ase.c
>> new file mode 100644
>> index 0000000000000..cc77b193893bd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_release=
.c
>> @@ -0,0 +1,37 @@
>
> [ ... ]
>
>> +SEC("cgroup/connect4")
>> +int connect(struct bpf_sock_addr *ctx)
>> +{
>> +	struct bpf_sock *sk;
>> +	int ret =3D SK_DROP;
>> +
>> +	sk =3D bpf_map_lookup_elem(&sockmap, &(int){0});
>> +	if (sk) {
>> +		if (sk =3D=3D ctx->sk) {
>> +			struct sockaddr_in sa =3D {
>> +				.sin_family =3D ctx->user_family,
>> +				.sin_port =3D ctx->user_port,
>> +				.sin_addr.s_addr =3D ctx->user_ip4
>> +			};
>> +
>> +			ret =3D !bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
>> +		}
>> +
>> +		bpf_sk_release(sk);
>
> [Severity: High]
> This is a pre-existing issue, but does calling bpf_bind() here mutate the
> SOCK_RCU_FREE state and cause bpf_sk_release() to skip decrementing the
> reference count?
>
> If bpf_map_lookup_elem() looks up a newly created UDP socket, SOCK_RCU_FR=
EE
> is not yet set, so sk_is_refcounted() evaluates to true and the reference
> count is incremented.
>
> Then bpf_bind() resolves to udp_v4_get_port(), which dynamically sets the
> SOCK_RCU_FREE flag on the socket.
>
> When bpf_sk_release() is called, it evaluates sk_is_refcounted() again. B=
ecause
> SOCK_RCU_FREE is now set, it evaluates to false, causing bpf_sk_release()=
 to
> skip the sock_gen_put() call and permanently leak the socket reference.
>

AFAICT this is actually not a problem for this specific test, because we
fix it in patch 1/2. We have already added the socket to the sockmap so
udp_bpf_update_proto should have triggered. It looks like Sashiko missed
this?

Specifically for UDP, I think the code is fine.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>> +	}
>> +
>> +	return ret;
>> +}


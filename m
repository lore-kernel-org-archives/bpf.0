Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D238D40D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765581; cv=none; b=TDO0Sl8WsnG9U7gRwaHRsw8gLhSvSPaAgoLdMBYrfFuJoJgALyg4bp9iWrxfTezShqCcIp5Fr50IIWP9hn7FNm8D2yWet1vidW3so2NpfWO37Xmlr9yB6V9WNVIPcIrzt5Old7bZ6+g/gX36olcDpWze6dovlUEEMhqS4x1kA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765581; c=relaxed/simple;
	bh=se1FOkSfRfU7X0OFhGaQBFmVranH4EIPrVu6ylNOmCU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cy9psipk39ePwT7t+izo9LxELIyGIAB0Pt8Q+VBo1ERTyjqYPRtb/vJHtT1GGTNvBB2/2tvr9Gu6VxyfQBFJEawrlSmgw54AfAmLSOl0rMJwNXiyjggrmqIY+dK1s5f6oizRgj+J0f1sttWXC8pm4wgrcsA9LRtdIy2g+U2y430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=a7ZHZhOG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="a7ZHZhOG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso3752055ad.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781765579; x=1782370379; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sEnXo35JuQ0QnVsUJrbhZuqaUj9pBPf+Es0v6/00A4=;
        b=a7ZHZhOGc4790ByHzZh5vLNknMpyB6aoYDthj1c7vxJqH0EM7qmAsoymSVotedW21Q
         vPSDhaiBbFFq/BFH1ST4d/6G8mXVqQwcEV2tENRun9TYxNLQAVcimyW57amVHhqVkSf2
         +n3UFzGx8aGhJZiHXhnePAkOgT2onEOOm0QQ7RXqjUdqoNIR9cTy2sGZe1XSdznmzEyf
         60QoHuJplDYq77baLuI8Ln1b2NOP/5oY33TCHMUSQda8PD/LuZCbKJYTM+5h2NfI+ENa
         Xa9WJKiABkbLmmZC17DL87b+ABIA9uv3jBz2HAP9J1oUEZB2AHXS6fi3u2r/tuNVeoxc
         FQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781765579; x=1782370379;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sEnXo35JuQ0QnVsUJrbhZuqaUj9pBPf+Es0v6/00A4=;
        b=KalvaMBAEB02iPW/IHjntCieOf+Fcm5ed0r2EnmNxHR3yB3jR2y2pqqDe0hZe2l9tf
         3sQcuqKwCo2WDMQ0OYKZGOkMsYbQ8IULN14ZeQsakee9VWd8GdlQr1g6FJYKDvZYQYI1
         0S3XEwtIbFKpIg7Z1t3j/e3BxUWPjl6BXfy1Ppv+goxc38hCjVC5WkNxi0pV7GVbuXJC
         Qu45rXbeNSn6SsXK1JRKCA3dTRc0FB3Tu7XVuCUD/hisoQWgtivKHHYXteAL5iNQIWdm
         C/119qwfUVh5xXiVZBjLwuVK5HCiM6YXV5Zw0dI6JIrXgaI4pdd3mWURFtkTKV/pvOxf
         cAkQ==
X-Gm-Message-State: AOJu0YwTH4vE37KrYGNTuFFe8gMAgyIw3SMLnzbdHXSxWIm1C5vYX5DV
	lo/jC2Wj+8J7b0dW4mosm/2oJ1sZH0l0WpMU1dOnDY4+0MWdUWBpPnLB0KzywgcJ5aI=
X-Gm-Gg: AfdE7clr2FJ/M77YYhun094XPJg2BJUYSIWs5sMpM3S5xYLpVgo5L/I13OKPg6dHEWZ
	FNZEgcBhncoEPhXwWCVYboxERLoRBXSkh0ZS7drfuSulOIIp77VkLw2OHaE+txU7F3vE8LyKTWj
	T1iiu1GE7r1zAvomUH3ynERM1CEs8SXpbreRkMswU55JRwc/K4w3TtszCH4c6C2xVFWh3hmnMbx
	gzh4ABg36hgbb1qX/spx+bfPbMvMgL4w8PC1fCBbMsTnt/s56YW7Fcl0mrvig3SABzY56S+nZxr
	3u7wWmZDvMMltTD5IFACsBxz+qU9jfkt3uTwLmZ9O6Yy2aMbS0glD7wUlVbXWmAb6Ii2EZyqRrP
	Sbbja1Uja/wNtzcrhUKGfLxbBNJCplG1HjEY9fFuoESfRGMq6/Jz3c2EbptrN30iH1FM5Dd8bAH
	Nc8FaU9SwxHU2dn/DnCeG2NcBxQhottav9oe4VPyGRNk5X0Q==
X-Received: by 2002:a17:902:e54a:b0:2c2:2a8a:af69 with SMTP id d9443c01a7336-2c6bc0c4a66mr71528235ad.9.1781765579163;
        Wed, 17 Jun 2026 23:52:59 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327aca9dsm182685375ad.50.2026.06.17.23.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 23:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 02:52:58 -0400
Message-Id: <DJBZ6ML455FF.15NG4FYCAX9DE@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Andrew Werner" <awerner32@gmail.com>,
 "Zvi Effron" <zeffron@riotgames.com>, "Andrii Nakryiko" <andriin@fb.com>
Subject: Re: [PATCH bpf 6/6] libbpf: ringbuf: Reject overwrite callback use
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tamir Duberstein" <tamird@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Andrea Righi" <arighi@nvidia.com>, "Xu Kuohai"
 <xukuohai@huawei.com>, "Andrea Righi" <andrea.righi@canonical.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-6-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-6-e623481cb724@kernel.org>

On Sat Jun 13, 2026 at 9:48 PM EDT, Tamir Duberstein wrote:
> BPF_F_RB_OVERWRITE can advance overwrite_pos past consumer_pos.
> Callback traversal does not read overwrite_pos, so after the producer
> laps the consumer it can treat overwritten data as a record header.
>
> An earlier proposal[0] copied the readable window before invoking
> callbacks. Review concluded that callbacks are a poor fit because
> copying penalizes zero-copy users and the API cannot report skipped
> records.
>
> Record the map flag and reject callback consumption with -EOPNOTSUPP.
>
> Link: https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=3Du=
ByFSup31FMA7hw@mail.gmail.com/ [0]
> Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h                           |  1 +
>  tools/lib/bpf/ringbuf.c                          |  4 +++
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 39 ++++++++++++++++++=
++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index a3b8f606a91d..899457d5d536 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1439,6 +1439,7 @@ struct ring_buffer;
>  struct ring;
>  struct user_ring_buffer;
> =20
> +/* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps=
. */
>  /* A negative return stops consumption; non-negative values continue. St=
opping
>   * can leave records queued without a new readiness notification. Before
>   * waiting for readiness again, consume until no records remain.
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index ea8909fec4e9..f7972eae05ba 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -30,6 +30,7 @@ struct ring {
>  	unsigned long *producer_pos;
>  	unsigned long mask;
>  	int map_fd;
> +	bool overwrite;
>  };
> =20
>  struct ring_buffer {
> @@ -118,6 +119,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_=
fd,
>  	r->sample_cb =3D sample_cb;
>  	r->ctx =3D ctx;
>  	r->mask =3D info.max_entries - 1;
> +	r->overwrite =3D info.map_flags & BPF_F_RB_OVERWRITE;
> =20
>  	/* Map writable consumer page */
>  	tmp =3D mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, m=
ap_fd, 0);
> @@ -233,6 +235,8 @@ static inline int roundup_len(__u32 len)
> =20
>  static int ringbuf_validate(const struct ring *r)
>  {
> +	if (r->overwrite)
> +		return -EOPNOTSUPP;

Nit; unlikely(r->overwrite)?

The check makes sense, we can add it whether we keep ringbuf_validate()
or not.

>  	return r->sample_cb ? 0 : -EINVAL;
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index 5f0c679bf9a6..a6c707af1134 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -684,6 +684,43 @@ static void ringbuf_map_key_subtest(void)
>  	test_ringbuf_map_key_lskel__destroy(skel_map_key);
>  }
> =20
> +static void ringbuf_overwrite_callback_subtest(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_RB_OVERWRIT=
E);
> +	struct ring_buffer *ringbuf;
> +	struct ring *ring;
> +	int map_fd, err;
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, getpagesize=
(),
> +				&opts);
> +	if (!ASSERT_OK_FD(map_fd, "bpf_map_create"))
> +		return;
> +
> +	ringbuf =3D ring_buffer__new(map_fd, process_noop_sample, NULL, NULL);
> +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> +		goto cleanup_fd;
> +
> +	ring =3D ring_buffer__ring(ringbuf, 0);
> +	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
> +		goto cleanup_ringbuf;
> +
> +	err =3D ring_buffer__consume_n(ringbuf, 0);
> +	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_consume_zero");
> +	err =3D ring_buffer__consume(ringbuf);
> +	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_consume");
> +	err =3D ring_buffer__poll(ringbuf, 0);
> +	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_poll");
> +	err =3D ring__consume_n(ring, 0);
> +	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume_zero");
> +	err =3D ring__consume(ring);
> +	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume");
> +
> +cleanup_ringbuf:
> +	ring_buffer__free(ringbuf);
> +cleanup_fd:
> +	close(map_fd);
> +}
> +
>  static void ringbuf_overwrite_mode_subtest(void)
>  {
>  	unsigned long size, len1, len2, len3, len4, len5;
> @@ -760,6 +797,8 @@ void test_ringbuf(void)
>  		ringbuf_map_key_subtest();
>  	if (test__start_subtest("ringbuf_write"))
>  		ringbuf_write_subtest();
> +	if (test__start_subtest("ringbuf_overwrite_callback"))
> +		ringbuf_overwrite_callback_subtest();
>  	if (test__start_subtest("ringbuf_overwrite_mode"))
>  		ringbuf_overwrite_mode_subtest();
>  }


Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D2149DF1
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781656511; cv=none; b=nvR4Qz4y0s6uYIWXsrwoccIoIqkG1kQ+2qEHP8FF0fayKq8CKaz2n7Kl5p0hHyZCGFQQf9j7T/65yRW2VTvnlYt0PAtmvARDB/wS11IRmu48yZma3M6evX8aOpm5NyesOhIfv8vDRlruy8uBn28Wn3C/BZkVA/0sJy2folRRZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781656511; c=relaxed/simple;
	bh=EcdgWXvdiCrx70PNlZSyRm33SXh+/kxxRcfNrkwZyQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WwKPoL1vRp9eoJftvXNgPGkaYsPXRXrf4vSAkJ3ol14HGm+RhlrIoy7fY6L3Sr9vMju+wvDZkw9/8uUGpvEXDcVX7ucLmfCtQBC9/Ic3zm0uPcYcF496wRzE3bgMpU42zmYX3by/L9Pd1VWhHEYBTBgZqFl5x1Mbtp3YQ3WmcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=n726NDA8; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="n726NDA8"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137eb0d76beso340216c88.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781656508; x=1782261308; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyrlFIKHgx+ek59/K68bCVWO+77b440bupQ2LUc3ApQ=;
        b=n726NDA82UqCS8FkLmLSfOmShrJRipxkpteDzqjQ0NGjoKBRxy1ANf64cMm4sc5wAb
         jnhcANwIdlzz3Q3QbDwIKFYBWDs4P0z7RSOXpW3YTskY8XHvboCqJN8CpuijuEU7/ia1
         CR7u584TYNRYdutQpTbUapGOeFYePJUdxlbQfE6YWQACdIb/K6Y5pU02spPt/NtGXBaB
         Xbso0Pb0CyuJmavRQoxLGL6QIRJrSJkMssR7yQWOMJPVTcGRaY/Yt1u54lmIdhrAxfF/
         LylJckvmpv3pRN0s53MnPQCmNP5+/yOZSPJq0nuIOvPRuxej2xE0AC5djL4cfA6lODhv
         m5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781656508; x=1782261308;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyrlFIKHgx+ek59/K68bCVWO+77b440bupQ2LUc3ApQ=;
        b=MyZ4EndgSoYleIVRFT2jwOb9jYZUqOL7F52dpt2uIxBhLuij/6xyaLdwril3vW8G6i
         RWqk+gi0pQiig/1PlRhwXVTC6hEZNcEIt/c9v71C6HGz+3TVHRC3aPgXaVL/MFH223kO
         B+Jv7cfsGEc54sFRSIsIplM4csgmcYhMEZf7slrvWsg/GP557X4eRTMBbY5BhIBiSsxk
         3GpSaB+Jdp8bOmoNfwjpEMR1VsL/j/iZMBMNLmxZMRNCsNG1Cwr6Icfy/ES8uvzBnftj
         rL4icB3VHTnQ1g+4TX24+LUhMjwUgmG4TEdONTAcZLMDYZPpkc4llqmcSRF9pwSMSlmq
         InAg==
X-Gm-Message-State: AOJu0YyMFEM/7XZqOw4c4TEummBlwuEra8IbSFbw4OG/XZbk7dBowVv2
	L88uBlsBtFJEAnCVW3DCfmYl6heVIFOWx7W5g1UeDoLWP+UKAy/bSn2HILf/QqPTQ8I=
X-Gm-Gg: AfdE7cknttA5Vco+cRQvANQAelsVqZWILis2QXmMX8O2sb6Gio3LCK2puEfq0Jlx8Nb
	8jD/n/dbQJ1Qtf7E3rIRGd0ZlC7VLuMccDw3iqYoKV/l0mpoK4YVMRaIRfG1RxQ+8k3iZx06bvN
	oCuJFOVXr06G1AMnr8mD4GhmywqSgPZlL7RIfQAham/vzwatcaeXN8Dsvn8mTEn4kLltILiVMnx
	2gaqf6XctF6KiISqeCn7Wb+XifvI6vjpZHSMq4TkFfn8m01P98MaKIaZiRXdAs/rCuxa1EuRuA/
	Awxif6PIAVFcrnp1UhBcg8zi2MPPLi/TkpCnyql/wFvWWITsoRModfd92Hur9e6TpneQrgSB6wf
	cN6YfYbF9MD8WF4SZJhySN6WpYCppN3eWhiSl9vk9trgYMPtcYet2X5d+Bw82Y0anboN5SjpUa3
	wJnnWu
X-Received: by 2002:a05:7300:6d2b:b0:30a:e52f:9b99 with SMTP id 5a478bee46e88-30bce88dc80mr606538eec.0.1781656508118;
        Tue, 16 Jun 2026 17:35:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2568])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ba6b7f840sm7145654eec.19.2026.06.16.17.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 17:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 20:35:04 -0400
Message-Id: <DJAWIQZB9PYZ.7HSUY99VJ2JY@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Andrew Werner" <awerner32@gmail.com>,
 "Zvi Effron" <zeffron@riotgames.com>, "Andrii Nakryiko" <andriin@fb.com>
Subject: Re: [PATCH bpf 1/6] libbpf: ringbuf: Honor zero consume bounds
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
 <20260613-bpf-ringbuf-fixes-v1-1-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-1-e623481cb724@kernel.org>

On Sat Jun 13, 2026 at 9:48 PM EDT, Tamir Duberstein wrote:
> ringbuf_process_ring() checks the record bound only after advancing the
> consumer position and invoking the callback. A zero bound therefore
> consumes the first available record.
>
> Return before reading the ring positions when the bound is zero so
> ring_buffer__consume_n() and ring__consume_n() leave all records queued.
>
> Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_=
n")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/ringbuf.c                          |  3 +++
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 00ec4837a06d..f2bb619d5a75 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -240,6 +240,9 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>  	bool got_new_data;
>  	void *sample;
> =20
> +	if (n =3D=3D 0)
> +		return 0;
> +
>  	cons_pos =3D smp_load_acquire(r->consumer_pos);
>  	do {
>  		got_new_data =3D false;
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index 64520684d2cb..4f0558f14847 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -404,6 +404,7 @@ static int process_n_sample(void *ctx, void *data, si=
ze_t len)
>  static void ringbuf_n_subtest(void)
>  {
>  	struct test_ringbuf_n_lskel *skel_n;
> +	struct ring *ring;
>  	int err, i;
> =20
>  	skel_n =3D test_ringbuf_n_lskel__open();
> @@ -431,6 +432,18 @@ static void ringbuf_n_subtest(void)
>  	for (i =3D 0; i < N_TOT_SAMPLES; i++)
>  		syscall(__NR_getpgid);
> =20
> +	ring =3D ring_buffer__ring(ringbuf, 0);
> +	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
> +		goto cleanup_ringbuf;
> +
> +	err =3D ring_buffer__consume_n(ringbuf, 0);
> +	if (!ASSERT_EQ(err, 0, "ringbuf_consume_zero"))
> +		goto cleanup_ringbuf;
> +
> +	err =3D ring__consume_n(ring, 0);
> +	if (!ASSERT_EQ(err, 0, "ring_consume_zero"))
> +		goto cleanup_ringbuf;
> +
>  	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
>  	for (i =3D 0; i < N_TOT_SAMPLES; i +=3D err) {
>  		err =3D ring_buffer__consume_n(ringbuf, N_SAMPLES);


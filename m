Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469A1A76BB
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670568; cv=none; b=tWFgLkWyUn7I/WlvuKeZmSygptDo7rVBbSx5+/uCL1brZV1qFyCAOjoGxG2UJr1ES8XXQtcQl+IaEByOFehJ4RSZbdc9g0xut7vHy82d0gtcP6UBEdUpVwwIMZkQub6kXdqHlsQIRgqpFkQFJZy/KNxkpmGt6r4AYR4Fz6ohxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670568; c=relaxed/simple;
	bh=QJkROlYAAMtA2AGK13Zr9Dg6PXgZQvDDOmnAOX7+8uM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OeEHdEYTfBUQOV1/YyHP9P2o8l4uO259j3mhDnkDpnkcVwG88HO0sJsdkeVsvjRluy/dXlIIkm+ksw8uNW3ZiTEd4bDbwqN3CB9Pa3WXbxVspNVeTqEwX61l2a7U2ox9Ezbscu0tOZzFZqU/E8injHlXfZOpw9uebPEae4xbX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=yBUJs0Th; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="yBUJs0Th"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-950b8124974so1123497241.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773670565; x=1774275365; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+pZogzXY0yFkLhI9otlHstzKzlH6EsSqZlTH+u5uWI=;
        b=yBUJs0ThfOMd/s94gMUZpyhuGcJ9LQJdi9D+Jz7mkWH4Fow5FBdeWXzKuuNXHRTaL6
         ckxTwd5lluNe1doeUx6QfQ9bHyNEMDTOm/cecSPqdg0IVj5Qwa4XYE22sD2yWRBH2xIH
         59KDIadZCZPxTbP3Lz25iBATZF2GqefI1Hc8faEu7sTAMWF4AZT38H64zsj1/nW90O3g
         jGqPz8DdFUe/RB4uw7XjBGc8utnW+yIGRQzTAfu8rkOWxYXNyT0Wv1BTKQ9SQFzwLu7w
         XHxfTzxaqdDC0Au7DVsM3cyx2HLL/zcugOMeEV63Sj+j9TE9qmJo96pVO13Clo+795Rd
         8QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670565; x=1774275365;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+pZogzXY0yFkLhI9otlHstzKzlH6EsSqZlTH+u5uWI=;
        b=mbc+YNKX5fHzUe3zk35u9qn3doPBLaN/lbHKvSXhPDZZ0C5ml2ncjIt5/kZ1VAHzsH
         a6GsPwNpZI3fiY4KDqX/JTmXNF+EUaasDKGnOY/tuX/is1cJ8XvgOxGSu57SCTheloTX
         Q2qetcxzJp4f8Pcni250ymxS7XfUTk89avSa06Mh1FFOw3l1vdrG9SCnXxvMgcRS3zNv
         loejJWPQ7dHs/zAl/OlN5Q0sTRJHkEjiqgPNHkqHSkTFdE22PSM+RofPKgJc3CW6axDG
         4r7J+7m1mGoFrVVXdVG0JD8VBbwKNjYomogSS9UfRW9vcwribVcyjZK5ndYtZIv94MZK
         5nkA==
X-Forwarded-Encrypted: i=1; AJvYcCUw2z0fmlwYFpGyRDWb4O7YQ6ledWYyorCmauh6gkDx3em41ysgLiB7ihqf2WlvEqpr4Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyJqAEhADWHmlzhiWEoY5SHysRBD2+Nr8m2X5Op5nybz4RqjN
	Oz0RQOuJReiQ2FmUgPxOtIJ74WtSjRA/9F08FxaI4DoUBX9CAQuMijdQwfX7jCk7yIA=
X-Gm-Gg: ATEYQzxCNGwAkDRWr7aB/rSER9BdcLpBNMcn/rAyT6yiJN68bwS/xtrTX3NR5JqfBPB
	WXdxY+x8Ysg3uatBaC91Ms7lnyMmnJW+Ok863MAWz2y1cE4CpwxDKbMGRqNZLJkgtjD+1BUw5Pw
	/T+Uj+QiCzLIweUopjP1RIv4p3vDYwa+5xSpfg+skGOU4n6V9PgE12XHjXzVxqjtF1WKGvGBgQx
	Atb3ZhjjZjMmWoNeTfF/30IFiDtbprlrMtC0JJZXM+TEH850MNSHmDZgtirGK3YT3ACA+v8cba8
	5hDZMbHWdLcF+X2lWa4sSVv6z5sd/u3fYTXOD8q0yDDBJLIYaJbCBw4ocfx3njZ/jZnDIWJ7W1H
	6gBt/TxzZV2RNayyypTAocm10XSmk+HWmN/O6ycI51IBJbkohgx46E5kiOve5ESz3J0rp2CROpz
	kewKmaoYpKrf3ymr/cK8/EyN4=
X-Received: by 2002:a05:6102:2911:b0:5ff:d434:b507 with SMTP id ada2fe7eead31-6020e2cbe78mr5485366137.17.1773670565121;
        Mon, 16 Mar 2026 07:16:05 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2152a41sm1223428785a.43.2026.03.16.07.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 10:16:03 -0400
Message-Id: <DH49QO1Y58GG.2LRJUAR3P1HJT@etsalapatis.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <shuah@kernel.org>
Subject: Re: [PATCH] selftests/bpf: restrict ns_current_pid_tgid updates to
 target task
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sun Jian" <sun.jian.kdev@gmail.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316073409.4040-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260316073409.4040-1-sun.jian.kdev@gmail.com>

On Mon Mar 16, 2026 at 3:34 AM EDT, Sun Jian wrote:
> ns_current_pid_tgid uses a shared syscall tracepoint for
> current_pid_tgid tracepoint subtests. When selftests run in parallel,
> unrelated tasks can trigger the same hook and overwrite BSS results,
> causing false failures.
>
> Store the expected pid/tgid in BSS and update user_pid/user_tgid only
> when bpf_get_ns_current_pid_tgid() returns values matching the target
> task.
>
> This prevents unrelated tasks from interfering with the test, allows
> dropping the serial-only restriction, and removes the obsolete TODO
> comment.
>
> Tested:
>   ./test_progs -t current_pid_tgid
>   ./test_progs -j$(nproc) -t current_pid_tgid
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 5 +++--
>  .../testing/selftests/bpf/progs/test_ns_current_pid_tgid.c | 7 +++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> index 99c953f2be21..e3938bb48151 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> @@ -34,6 +34,8 @@ static int get_pid_tgid(pid_t *pid, pid_t *tgid,
>  	bss->ino =3D st.st_ino;
>  	bss->user_pid =3D 0;
>  	bss->user_tgid =3D 0;
> +	bss->expected_pid =3D *pid;
> +	bss->expected_tgid =3D *tgid;
>  	return 0;
>  }
> =20
> @@ -200,8 +202,7 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)=
(void *), void *arg)
>  		return;
>  }
> =20
> -/* TODO: use a different tracepoint */
> -void serial_test_current_pid_tgid(void)
> +void test_current_pid_tgid(void)
>  {
>  	if (test__start_subtest("root_ns_tp"))
>  		test_current_pid_tgid_tp(NULL);
> diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
> index 386315afad65..d02c182a7100 100644
> --- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
> +++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
> @@ -14,6 +14,8 @@ struct {
> =20
>  __u64 user_pid =3D 0;
>  __u64 user_tgid =3D 0;
> +__u64 expected_pid =3D 0;
> +__u64 expected_tgid =3D 0;
>  __u64 dev =3D 0;
>  __u64 ino =3D 0;
> =20
> @@ -24,6 +26,11 @@ static void get_pid_tgid(void)
>  	if (bpf_get_ns_current_pid_tgid(dev, ino, &nsdata, sizeof(struct bpf_pi=
dns_info)))
>  		return;
> =20
> +	if (expected_pid && nsdata.pid !=3D expected_pid)
> +		return;
> +	if (expected_tgid && nsdata.tgid !=3D expected_tgid)
> +		return;
> +
>  	user_pid =3D nsdata.pid;
>  	user_tgid =3D nsdata.tgid;
>  }
>
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c


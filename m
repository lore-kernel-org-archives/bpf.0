Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600115;
	b=rqdkMMogaW+SdBJY7CUK5fp4GoJP5GzBy02I4HiVwY6lJFbjvlMnYa02aq79aLYU1UUC
	 MQvLJgzgoOe9XBXiUDC4gLgbynYgM6QP0KHzxUxBBxoLS/4xBioGJYU1Epxg2uXRFB1zY
	 gE6f+Ppi5uLwC+qLvMMw7sSGZZ/bIo4iKf2VO3dkE+NVGamzqiHB5TmCqUcBCoBdRB6EV
	 WovYXevhFHuoTXI/noAVqWVBAMVsCVpSfVD8KKkXx6ZwFnZiQUVcL47yBg8L6mujpnJ2G
	 c89r7yC+APm5fR55s5KUO0mSuuzsTrlqgA2WRy9rb8rBc0ThF7xAVL8nhfx16KzRijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N9p8p2HdUkdNstArIXEZ6d9TeiYQDnJxf1m9IIs2SIs=;
	b=oytBdNQ5cXsJeOYpVWBWNwcyeaEZHB2R4oEK8CzxTjR1JUOQgHmfbW+5s/wmHSUIdeyw
	 SCAl4MhnpoVGkPHrSIXI6V0r7MM8wXlFwGxM61ejmXMj163YE3/97wfZvbES/R98kanSQ
	 //h94TwimkejH6da38OClsd+LI3GZVIUCnyaFpejmqmDXkTrj/l78z7VAjivhkxHXOsK6
	 zjcVnfWN2mA23rApq54sDjyu++62TZnZ88XpYeUV3J9s4yOfLg6WCR4P47bCUYbygj/9P
	 WAUycyOj/F3NLbR4bkbnjRpSAQjhyaOORkiEGyJ8MDeEwpM8Fek46Na8zCYBdc3ILjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4zjSubf;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF47606A32D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF47606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4zjSubf
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso731675a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600114; x=1794204914; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9p8p2HdUkdNstArIXEZ6d9TeiYQDnJxf1m9IIs2SIs=;
        b=f4zjSubff7t65yc9TzSFbWKzjEAU6ddyIxf7Rl1tmnjRJRePp4qnIdD6CFk1rIzsf9
         RKB8I39qlVFwEAJ2BouHPHj5aImJHb2nRDs/6Z1bqSTKoflIHa/vXKhQIQe4FdUVOMr9
         dwCaKBwj6Dx8Cm5Q85FpOHauS9FTuxWOs748MtKdp4H7SKrtrV7wPHk6vIOOEhSo+ArD
         GsmT4WQ8X3l9VGF7paEw2Dz762JpqwtLjzZyPl2/yyP8AhwYX0t6+1Sps3UbQgLEM3Z1
         C8fN8KrfjH+6Tafp/j/Hy7W4O1OIUVxT92pNORqRWsX+KFeYR1aIiEV445G4AtfYj34P
         fm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600114; x=1794204914;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9p8p2HdUkdNstArIXEZ6d9TeiYQDnJxf1m9IIs2SIs=;
        b=XTVs20F9dKA+Bv1ZyGUWIG1sjpU/+a6jjXPqEwd5S6h+Xpm1vHo8B/dBp5Mlw3OZkB
         lPeSduN7TvN9RS+WFaoH+XWezFYH0WRFnldr8jrFfgwFWUB6O6ZYafjspblopqdsuzE3
         TuCrGj8XB4+7hgsFdw0Rel4N4mpFkDZDHTYdg/S8uzeutnJkpidqjOlgEla/EZJGoRNt
         nowOTVFp5UOJT3QCxDF2C5EMH+rRDmCWs1qp5TS/gfT80Zlq6AzaQ1nXQIShVVXvg1Gf
         nz5FO7OnD9o8bTa0BJbeMfbdf/BePsi6nFhph72j/WukQ8V936bvOE7X5m/Ghs1hxk8r
         hQfQ==
X-Gm-Message-State: APuU4Z/uYWHuokVDhCSFmjj1WmY3uor0HJ54Aojei4lexDhE5MFFUNmU
	6nWC4cIboYe4WeZyVbmQ5HIQKVa9qImztqIzetqX8nk7IOotvXyfbpNk
X-Gm-Gg: AYBFou1++JuC38RC9EHB7VpGUhX2xvRqHt56nyeJen0kSPd4h4GdyXz6F56R1ZYufLZ
	aX7PFuagyr0KoMOfcd+VlkewfV/UUz+6WLrCFwuRsjACPnB4Hrqg4ivoruB8/kLiXuD21zJR55F
	jtn74WkkhNhKJ6mxQWqtAssRwXO85FfNHHVX96k7KAluvdWUJmQTtN1/6Cpqqdvxied0YIfavsr
	LUUTZB2ISFMZ9/YBC5SHePqfkfAl5X42x7Z2N0lh4Q3TSxtz9pkc2Px9XAaD9ppoLnnsHGt923Y
	xF/ERU8+e9Hr/VN5ZN48IKk8eg09DMZSoaE866Gdl/eitxVGKKDGCSaxxxcyyAR3PJNZkdUIgbA
	aCD15Jt4bpE8bZUTXJGhr3Ohs+DSlgw6Yk1Ww69NIcUbn6fVgHA9igsWfJxgJQ3+A2vHhFYkIeY
	HQ3a0RrfLcwqUtPeGGD6JGKay7UI1PfLl4wb+szNRyW8UjjZJmAUDcLMZqx1ekcYXwFpzV2NtxE
	3opIwhRJMscJtYQ92s08zaE4y1q4vCpLya2dxU6eQWK/mh7D2vgnlF8Z3GRyNrhQRW9CpRmNpv/
	rX8w6de6QV27sgZLzI3PZNzyfwin4e15W3W35SIcswE4XPqkSPGbsXqb5dwzoLqZUKuuLmiTeeY
	6NxBTWaqdlyuOPF9svu/crdXymv6zsHcuzw==
X-Received: by 2002:a17:90b:1b11:b0:3ad:4bfc:1e77 with SMTP id 98e67ed59e1d1-3ae897dd40fmr7444865a91.66.1793600113727;
        Sun, 01 Nov 2026 22:15:13 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm17118903a91.13.2026.11.01.22.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 22:15:12 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 06:15:11 +0000
Message-Id: <DMKI6C7FPCCV.2Y4YLRGWNSKW1@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mykyta Yatsenko" <yatsenko@meta.com>,
 <qikeyu2017@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Wait for wq callback before
 checking ok_sleepable
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <thamrinjonathan@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261102-wq-poll-fix-v2-1-48b7d12815b8@gmail.com>
References: <20261102-wq-poll-fix-v2-1-48b7d12815b8@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 06:36 PM Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org> wrote:
>  	ASSERT_OK(err, "test_run");
>  	ASSERT_EQ(topts.retval, 0, "test_run");
>
> -	usleep(50); /* 10 usecs should be enough, but give it extra */
> -
> +	/* wait for wq callback to finish */
> +	while (!READ_ONCE(wq_skel->bss->wq_cb_run))
> +		sched_yield();

This loop can spin forever.
The two ASSERTs above it don't stop the test. When retval != 0 nothing
starts the wq and wq_cb_run stays 0.

  what goes wrong                  today   with the patch
  -------------------------------  ------  --------------
  test_run fails or retval != 0    FAIL    hang
  the callback doesn't run         FAIL    hang
  the callback gets a wrong key    FAIL    FAIL

The second row is what this test is for.
The watchdog doesn't help. watchdog_timer_func() sends one SIGSEGV.
crash_handler() prints the stack and returns. The loop goes on.

Waiting for the callback is right. Waiting forever is not.
Keep the loop bounded, like prog_tests/ksock_wq.c.
Then there is no need for wq_cb_run and for the changes in progs/wq.c.

Something like this (not even compile tested):

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 97926e3..c4de70b 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -7,7 +7,7 @@
 void serial_test_wq(void)
 {
 	struct wq *wq_skel = NULL;
-	int err, prog_fd;
+	int err, prog_fd, i;

 	LIBBPF_OPTS(bpf_test_run_opts, topts);

@@ -25,11 +25,13 @@ void serial_test_wq(void)

 	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 0, "test_run");
-
-	usleep(50); /* 10 usecs should be enough, but give it extra */
+	if (!ASSERT_OK(err, "test_run") ||
+	    !ASSERT_EQ(topts.retval, 0, "test_run"))
+		goto clean_up;

+	/* The callback runs in a kworker. Fail instead of a hang if it doesn't. */
+	for (i = 0; i < 10000 && !READ_ONCE(wq_skel->bss->ok_sleepable); i++)
+		usleep(1000);
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 clean_up:
 	wq__destroy(wq_skel);

pw-bot: cr

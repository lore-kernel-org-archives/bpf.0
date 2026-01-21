Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D447DD7D
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988726; cv=none; b=MAtgbzdFoVUWrWwlwEEIjHf2LoYTKtc04rb+SW6iEOpgSEoJDWCd8N392kGMVMX7iZk08DjlG8/KUTgOtHjmyCUybXmQ+sEprB24ow2cFWFAZV33aD6NEdhXDZgtavF7vXMlpNNhur0jhf8W/p//m1XIRH0bdinT8l6q2AwZrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988726; c=relaxed/simple;
	bh=LQCZKDYAPVWTL1hfa0m9GqkDC4+oPqHsCFMnnvfMmS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8wRedn43SzirabIdb2DXLJLMTxY2QBUSxBphMeZ4MD0wXE++Yml1+ihkFOIiIoT0KE301Jv24sYGYShphdPYAH8Yi/bseY6lHocpmK3/hshf66DDbLIIi/Q4MG2ndsoAWqW5ZQmwpSzMjB1BYOBb/NAAvUePXrcgkK/1E6UY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zww76dWI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zww76dWI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b86f81d8051so110083266b.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988723; x=1769593523; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ5Xi6Zzr4VTOfswDmjNXoozec/PpuCDq08QJw3b/Ms=;
        b=Zww76dWIJuUUBg27f1wT2NfDrOQVADca67E2F7S3mw9ipRbEBsckDcHsfeCMNjBez9
         YdcFQfVo0rWkYInTS8xClC2HMZ9vtQEjgIktw659+fQogGJ4ZrYy86fyny55ZKmH1zL6
         +JAgi/MbJRRhzIwyoimoKB8cbeLTsnFWvKchpXaTW7imHFdVpUNPIuOpbq/V971GDqbO
         QLM/Z4OCvMUYaXm5zFk4EvaGzNijgXt1sY5N2re25EkmaOoGI6Ln2wy2ynn2edpdXoP9
         C2/p7cUiLmT184PDKbM7cqk3iQPMFJGb9OHmhrwR/yFuVz4g/reqaaHpQ6QfgzmvuKZp
         KRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988723; x=1769593523;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ5Xi6Zzr4VTOfswDmjNXoozec/PpuCDq08QJw3b/Ms=;
        b=G9eNWT800glOxSPb9AdHj0/KhoyX7eroBvupnUR23DFb57edfYERr1l38D+v3lKU33
         tv/pTEJkILbpkvFU2lOfNYxI6lSW/XpNrHDoL7pvRpR/DWMcPZZaoAhDe+OET8IfqoWY
         WGzCr1U9bDyRjQJloqzlgJwYvFpV1G+dMFk46blhPHap6TtuwlO/5rpXaLCHlL1+qayc
         gEncNtNvyp/8HeWH+K+RsRaemuLWMrytKMH4/2q4AbvW9a3Wpac8OR1m+nw5lnexyDs3
         sZs9wqn4tHjUlC2CdVmtzhwzzSsYOqpcnMztwGWNnEv/KxnAK6bU+gg+00aZh3QTfPny
         t1PA==
X-Gm-Message-State: AOJu0YxeVwp/dO3w1KwrtbPTuwHKREc3p1pKgEnhQxkfMVTOFY8W0XRB
	+PCjd/PnqGo7Xv3pZCw1kMLSBXBA0bIgvGCjqLU/ASmwaBrh+VWsqHkCsi9lRoQFn+0=
X-Gm-Gg: AZuq6aJLP1Y1Xhx+QIBKiVUTJt9017WavfEjf/WJQy5z0Oqyp2Ceopg4P2XLr4PgIJc
	qg2eSUM4sg27BxoDjOCkMTborNkattv7QJxiavQ6Rs5K4z1lscFMD/ATlidUTg/3wH6BcuxC5pP
	85YyvAr5w8noJey59mbzcGRyvl3hY7W5CoUimXFWWi18/cbD0ufsoOAKVeL/87MmQJnxtlEwK8A
	qiaMHNeo57spZRkVRVEejfH1GFKedKGyQCWMS8EJhAJZVWdeLuH5BGgvmZu7WRNuATFhEgfCmoB
	Y1ypSjVgRJqQ2uiCydvPVap/CqtPqG74UtL1BttR7Da0tm8Qhj2etp0m58dMG3Nj0AHhx2N/AoQ
	lkdGyXnOTLFMY9gQro3FXnwZGM7uEagrgkcNSNDv+hOrKmkSl+noKsNBBxttxQCEwWvny2nsRdM
	u1BA==
X-Received: by 2002:a17:907:9496:b0:b76:3472:52df with SMTP id a640c23a62f3a-b879388d7c0mr1760882666b.10.1768988722803;
        Wed, 21 Jan 2026 01:45:22 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fc273sm1526702066b.54.2026.01.21.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:45:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Stefano Garzarella <sgarzare@redhat.com>,  Michal
 Luczaj <mhal@rbox.co>,  Cong Wang <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 3/3] bpf, selftest: Add tests for FIONREAD
 and copied_seq
In-Reply-To: <20260113025121.197535-4-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 13 Jan 2026 10:50:51 +0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-4-jiayuan.chen@linux.dev>
Date: Wed, 21 Jan 2026 10:45:20 +0100
Message-ID: <87sebzti33.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> +/* it is used to send data to via native stack and BPF redirecting */
> +static void test_sockmap_multi_channels(int sotype)
> +{
> +	int map, err, sent, recvd, zero = 0, one = 1, avail = 0;
> +	struct test_sockmap_pass_prog *skel = NULL;
> +	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
> +	char buf[10] = "0123456789", rcv[11];
> +	struct bpf_program *prog;
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	err = create_socket_pairs(AF_INET, sotype, &c0, &c1, &p0, &p1);
> +	if (err)
> +		goto end;
> +
> +	prog = skel->progs.prog_skb_verdict_ingress;
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> +		goto end;
> +
> +	err = bpf_map_update_elem(map, &zero, &p0, BPF_ANY);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(p0)"))
> +		goto end;
> +
> +	err = bpf_map_update_elem(map, &one, &p1, BPF_ANY);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +		goto end;
> +
> +	/* send data to p1 via native stack */
> +	sent = xsend(c1, buf, 2, 0);
> +	if (!ASSERT_EQ(sent, 2, "xsend(2)"))
> +		goto end;
> +
> +	sleep(1);
> +	err = ioctl(p1, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) partial call");
> +	ASSERT_EQ(avail, 2, "ioctl(FIONREAD) partial return");
> +
> +	/* send data to p1 via bpf redirecting */
> +	sent = xsend(c0, buf + 2, sizeof(buf) - 2, 0);
> +	if (!ASSERT_EQ(sent, sizeof(buf) - 2, "xsend(remain-data)"))
> +		goto end;
> +
> +	sleep(1);
> +	err = ioctl(p1, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) full call");
> +	ASSERT_EQ(avail, sotype == SOCK_DGRAM ? 2 : sizeof(buf), "ioctl(FIONREAD) full return");
> +
> +	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
> +	if (!ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(p1)") ||
> +	    !ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch"))
> +		goto end;
> +end:
> +	if (c0 >= 0)
> +		close(c0);
> +	if (p0 >= 0)
> +		close(p0);
> +	if (c1 >= 0)
> +		close(c1);
> +	if (p1 >= 0)
> +		close(p1);
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))

Can you replace sleep(1) with poll_read(fd, IO_TIMEOUT_SEC)?

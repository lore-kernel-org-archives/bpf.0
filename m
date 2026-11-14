Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681955;
	b=1uvpMEbJkEF4R+pL9vp4oG+U3HKaUBr0ipUh0vqBRs3KFd/Is12lo5Veq8EtN7k8jarz
	 NIOB6jA6+ylA5iXZ36aAyLCTZEdsxWlqhQ0f4T2gKjDOJzqN1F38LJZFnwjHewc5aIsBP
	 qlZ3yEagaRlV9skky9ehfBu/QWPckvJED6iOkaoVGoGv7qkmeiCK7DaipZctHBtqLQdyp
	 e6QjHI6eWePjSAS1P73pqjR9AFnZeg65bMWWkkS6X5mFjTnTAViLVe3KAnvrB0Zxy5EpA
	 VcFxSu3s8VuAd5IO2hXGAxIN/hVKt/P3IcTWym2Y9rdRpUiuZpKEpyQ+6TPfGZNcJkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=mhjMuwlcmmA6xmnk85ku3gy5AP9/nFkfmboSqD/BPaw=;
	b=3BGPns5QY3PLID5kCb5QRQ+xC1XldaNrp3jEMJhq73ocLzfkSDOJ1MjO0Ct9PHoJwKJj
	 KwLJKCYgvD8yi1W4XVcQTAbiN0SwPiUdv51lbF/WJzV1JCZ9EA6JCH9w0IKnjcsHsomnp
	 DxqC6acExESEIIBO0dEuapHnEsN7In7Q8R61pdcHGKDZ9OwtUIpJfzyv9bv+ABONu3nbu
	 UzdNkOpjuaO9KtPwzJvIXb/U3VM7Piri/yvnOXQsnpQzexK8FbRzXytCfT5rzibXDKKow
	 ysQM7UQOvBNNd+gdHNBGQuAi6GmsXXYXLgYR5U6uKsvc/Va44kXATO645Zgz3A4oQ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUeDpqG+;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E5606A332
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95E5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUeDpqG+
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb449364cso37038126d6.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 10:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681954; x=1795286754; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mhjMuwlcmmA6xmnk85ku3gy5AP9/nFkfmboSqD/BPaw=;
        b=JUeDpqG++mf++7m4owPYQY97vDM1BdXIWpPWR9xMWUZo/jdQTQsMwApPcqakMIy9T4
         bxBTvAMMz8cKj90Y6hp8UVgQ08iHpVMTDGMkUDTTZhVtpCSlyDuLv23ZnhonAuYDQgX8
         oKPmJkcSN/LwL2vss6NxVKCVeiDgu6Jb9i1asyhayqdGhm3Z2qCoxUSeMlF0vthK2ck5
         xAz0/N+HElRMTaHFWZq2OAQvjEq5u87HjKalMvOkcw0cuyITO7+1Q1tMelM41VswOSma
         eUXZCNlTSp9PzhYqOD42jYE7WEurOcBwmyk9tMnP0YI2OkSYeC7Oqkb+p2tb0NKGtJCS
         ZZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681954; x=1795286754;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhjMuwlcmmA6xmnk85ku3gy5AP9/nFkfmboSqD/BPaw=;
        b=X+Zast/YCy9VvWcS/9K8AkAPLLhPqwCw2R7sO+aC+wEcHT9KBysytlCxrzcKihLVOq
         bD94mrsODYwNhYPsaeBtm+5WWk4rhLe6m+gRl4WHzp/PNVm2XvjpU1d0rQr9CwpWi9iq
         Kgy+ydFyZ8nxz5nOwnKDPXren4PHmYdCAGmVpzjp5N3e2QUp/Ovy51EsyARCCI9nZlr9
         lv4tNJIeRRtZPMBQ326Bs1MGFt0iIBL8kNGV/JEOyDhIE1Ae1hVxlgbxoi5HJ6SL0qfy
         9J7xl9pJ6Mzo1W67KYLOwPbKNqynAg8ym/wvU8p6F8ykERYRYsfxj6xdGQjDVEIZ5I3N
         0l/Q==
X-Gm-Message-State: APuU4Z/4rZehIp5FrBTaX8ZGbxyBzb/AbNm+FPEsuMqNK4GO0t4j+yxf
	yP/hccyNOzP8tRWPfF69OHKhasytim7ujgOmOEm/hGIQnQ0+BBmKZslw
X-Gm-Gg: AYBFou2OCXFOql4GOWOIqabgTiBD3yacVN3vRHjPJ3t0M5JQ/WNBlnif9seDGCrurKy
	L8HEN+lYRq8D5r9Lp6cIvCqbtL8HblYeQabAYs4AkngsxfLgU2BYhfY/gb7RBnhI5OkOV5Zp2cq
	/qmupORvZ5RyDW0WyxOaLLhHdDB+QbTNn1bDS0j8JKtO4vIZp6Z6NfDKLMKaEqqIccoVrMLBOkX
	5jPTYVoEZsF0M0DGzgbD14k2bYgKDpVA9+wAy8DAJRd/kpll/zAvZpgsY4pYMFO/v0jhp1QTMNn
	QC1ZzRVxqZEm/YoI5QTDvRx+PzkiOVMNdvSxntU4Wl7gqRiBdsAPlkyhco4SnmHMxNRhv5rybng
	JoLQpslCPZYNAD+HaF/yY36LAc5hTr6+8o8SkeeG6p5ogN/tqYLnQSzRP9GyDC9TYo2ZGIdXBAy
	Qv9WcdXjWT4DcAR0nPekGJ+WORVnHxJilej/GqxVXtSucYENNLww0ZfZ56ho3QHZWT3MP8BJ+yT
	NkOB23ZsFtxdIfk85q8/wPgVdyBudoD9LvpfZLckvWNxlQSW/KtShbljZ1onTxsSphjbRohMoIu
	ug02JfCFjV/YL79kNRQun5X36goG9TymsWdoSPTIKrqotFtjeN4nkRo5tgLeqoCUXUrAWQbneBS
	tdnhMc6inE/k2mSLM6L+CnvpjLK0PXg03lw==
X-Received: by 2002:a05:620a:25c6:b0:93f:1936:b229 with SMTP id af79cd13be357-9494bbfe4ecmr937435085a.77.1794681953514;
        Sat, 14 Nov 2026 10:45:53 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9495a5ef5c4sm338706085a.6.2026.11.14.10.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:45:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 18:45:49 +0000
Message-Id: <DMV5NLOEYFGF.C7ITHCRCNA7P@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>, "Jakub
 Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Stanislav Fomichev" <sdf@fomichev.me>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf-next v3 0/8] bpf, sockmap: Restrict iter-context
 sockmap updates to sockmap iterators
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>

On Sat Nov 7, 2026 at 5:58 PM UTC, Michal Luczaj wrote:
> Follow-up to Sashiko's report [1] and the decision to restrict which
> iterator may perform sockmap updates [2]. Series started short: remove
> about-to-be-stale test, restrict updates, add a negative test. Then it
> expanded: mark bpf_iter__sockmap::sk as PTR_TRUSTED, restrict
> bpf_sock_destroy() callers to iter/{tcp,udp}, few little tweaks.
>
> [1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
> [2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v3:
> - Drop RFC prefix
> - Update bpf_iter_reg::feature docs
> - Fix tcp_request_sock BTF build error
> - Restrict allowed callers of bpf_sock_destroy() to iter/{tcp,udp} (Alexe=
i)
> - Link to v2: https://patch.msgid.link/20261102-sockmap-update-limit-iter=
-v2-0-e96a63c43b39@rbox.co

Sorry for the delay. Applied.

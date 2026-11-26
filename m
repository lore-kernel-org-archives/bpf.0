Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707234;
	b=AnIJ3HInc1Cab58cyIdpKZgih+mK2oSS4GUFOWUKSTBEKRdqQonJt9yW8ydkGCKHY55A
	 0drb/ER6rOWWiJbU7NE24GxbXxN858xC3yvqFY8zs0XVtfpYq5icCEcA63LFD5jTZxZqL
	 X3eIlul/03eYKxAp7CBeL+5Bm71nWtREhiDKV9JjMTYLRPUvMraREcXvTDpqTWTREGy3s
	 DSW6+qzA3ga1v4JAcSEzaqOaef3ExPnJdOjKK2nIFahivefzRkDX72WMeHNKxTkolONa4
	 FF0OXSZUJfCa5npBtAIt4Uxkjoz32JzyM+3yWnICA0l6rR3ZViTNmw4SC/JwsMWCYKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707234;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2t/qriAq+s9/2TT61qP0ALnEqG01i43rdHLuNJHM008=;
	b=IWRRnrdEH4NrfSjVq07QsnJe5/axr5bYMHA7BkzDDU2EkXo3Js5en6bdlTdHEtAbUoXX
	 /2N5DKvlht3SzZ8xR72D5HAATkqbWe4T9El8TcKYPcEIl50YNM+IqiYq2M3VqQBP4MsiL
	 QzEwGmJyseHEmKzykTbk1cuqqcN/DTYIth9vLHqSK31oFkTGLJ4LOm8Cvbq8A43tGA6yb
	 Cd0hMddehOhIQybEo8+wLO5EOB0QV3Xqoas+zZgGrgNicXtYA0r/l/aXw415tJi8eK0RV
	 +QioAQzO+Hs7g2UMu5aFKWD4XMwhqcM1X8Bw+IZZdihpRw3fphwbvZqmytubhw1jGVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpzLRBwb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AF606A31C;
	Thu, 26 Nov 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpzLRBwb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C58F1F000C6;
	Thu, 26 Nov 2026 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707233;
	bh=2t/qriAq+s9/2TT61qP0ALnEqG01i43rdHLuNJHM008=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fpzLRBwb83mu12SXb+xOhWBHhP4ZOBOh542o1H30jAUiEJONAyPacCHLtGkbxVz5L
	 7F4IbYh9FWNLURA/MAYhsm2Hu/nqDIk37ihsVIgy+1JqJQIeAP5kI5aGJQ4ZsUgS+U
	 jPYasZHuqzGlmn6HZ2mIRIfUFFRFA12lXRA4fnus3WuvH0TTStPBtP/fe+brxosN7s
	 jCJmcwLNMGm+ed86r905vtX89v0ClGB7rH7QR+LQcLjfcME6GbNmz+idvlq8EblPz2
	 ROTl/7cLC07OriG0nDcjjGNv0ohLlwEE5Hy3kGkQA7ouUsxnlkZe68gtqzJBGNOq+4
	 QHAyxy35MojSw==
Message-ID: <59f72367-d65a-48a1-ae77-c95f7f805ccb@kernel.org>
Date: Thu, 26 Nov 2026 15:33:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/3] selftests/bpf: Move verifier failure tests out of
 test_global_percpu_data
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>
References: <20261125004911.3937193-1-tweek@google.com>
 <20261125004911.3937193-2-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261125004911.3937193-2-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-11-25 11:49 UTC+1100 ~ Thiébaud Weksteen <tweek@google.com>
> Commit 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu
> data") added test_global_percpu_data.c to LSKELS_EXTRA. Later, commit
> 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data")
> added two verifier failure tests (verifier_strncmp and
> verifier_snprintf), both marked as non-autoload (SEC("?kprobe")).
> 
> When bpftool generates light skeletons, non-autoload programs are
> skipped during loading, causing the loader program to store subsequent
> program FDs into incorrect skeleton struct fields (for example,
> dump_percpu_data's FD was stored into verifier_strncmp's descriptor,
> leaving dump_percpu_data.prog_fd unpopulated).
> 
> Move the two verifier failure tests to a dedicated test file,
> test_global_percpu_data_failure.c, and run them via RUN_TESTS in
> global_data_init.c. This leaves test_global_percpu_data.c with only
> autoloaded programs, allowing its light skeleton to be generated cleanly
> and preparing selftests for rejecting non-autoload programs in light
> skeletons.
> 
> Fixes: 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

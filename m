Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820257;
	b=w4fKasBBSopa1u5e1io4qwn3WqWTpeMMdrFabf3sztQ35WGgcGkFcrRKV8B1cNcB0vw+
	 2CKB6chJey61XzLP/zOQmtqRJJfttNfJ6Jlo+r3kGj+mJvIY5KkgO1pVzM/1DgdjG8/Ch
	 NpX4Pn2Il51Sm5m8MXrp3gh8WDss9Z7QrH7vjI+XPrrwAZTTllGtJ7+GP5p+kfEtyUEsq
	 Q76v44/TgRSThxm1q0GktlOnBvQ10q2gtsFrgbdIZbh+imnatxeTz+7Wi/jJ8SBJAJelp
	 kaAymqm14zWc4xEKk0t0qr8mgmgCMZ1FWErnNYgn8EMBhg17YO5H14BpB1hFFgwd7NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820257;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mR1Obv3OQO7Rr03XXwq0Vuu5vswoLyJMagXWwpBbflw=;
	b=R1T3fWJmP9ckTU+jbmEW6vdgVRpCn+xf7VHCCZ4qdBL2KGAMOL4LSD0HSBTC7sU5tE7v
	 lXDKjHntcnEazOHOgNXri3nayDGLNjdSZzmRCxGEE+IgrIS+tDlvuDrfUAvR3CHAxcvnV
	 PfSaCdDrGWb/Orq5UtYIuQ3iGY4cjOYHzt08HUrTBrWPWgymG7iXDHBqQ5ShBchS2HgMR
	 oyBQb1Btn4gTvcNjzyiDsNmI8Rt4XZOZDeEB7XHyJzDvM8kJJZkoivyeaxROaTlHiBrmE
	 E4X7nVboqRH7M1MJ5gx/vFLTNa5nWwpNfvz1YL6fXOl6TOoHDuqRfFDV7BZJZGBP8rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLzEXYzy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90846606FAC1;
	Wed,  4 Nov 2026 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLzEXYzy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFC31F0093A;
	Wed,  4 Nov 2026 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820257;
	bh=mR1Obv3OQO7Rr03XXwq0Vuu5vswoLyJMagXWwpBbflw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VLzEXYzyB987Mq/g4CO0K7QgCQUco1Ui/zkCG1VglMZN1YSdGOPeeW7zi3yOP/4k5
	 DpvubYCdz7kX1wvpxIcCnGqxqv6q5xgQtXVImaAxVavZdMiophOXe/IU8H1cnisq8H
	 xmqWYQNFFvDSDmXugpk3AFnH1MQFsnH1xfTHYeXssX00Lin1QJ12CVJ82lQv/Vf9wh
	 BNslafcMucR6QIcwhw7h2rgFVy1ernQ6Hywu/nssEiga41QeSyF+YCjLFM10vZcvwE
	 cT4zBqwu8PuMXhw0DIo1plbZq6KjAIXgCeXaTzg55RV5gvS7p/R8W8iam1XD/zPzvG
	 FYtsyOhoZp2Zg==
Content-Type: multipart/mixed; boundary="===============4878618093610613736=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <103bfd4d913a69e7a005386906734f0b702779d435e88572bd94e855a0c59ded@mail.kernel.org>
In-Reply-To: <9a0298fe0bc97f58bc5482f5642bc58835b2d3a1.1793818386.git.hi@tychen.cc>
References: <9a0298fe0bc97f58bc5482f5642bc58835b2d3a1.1793818386.git.hi@tychen.cc>
Subject: Re: [PATCH bpf-next v11 3/3] selftests/bpf: Cover recursive bpftool map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,shuah@kernel.org,daniel@iogearbox.net,ast@kernel.org,alexei.starovoitov@gmail.com,skokovmaksimevg@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 19:24:17 +0000 (UTC)

--===============4878618093610613736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover recursive bpftool map dumps

TL;DR: Nit only, in the selftest: one bpf_map_create() call uses a compound
literal with a hand-set .sz instead of LIBBPF_OPTS() like create_outer() does
in the same file.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c

[ ... ]

> +static void test_unchanged(void)
> +{

[ ... ]

> +	fds[1] = bpf_map_create(BPF_MAP_TYPE_HASH_OF_MAPS, "rec_empty", 4, 4, 1,
> +				&(struct bpf_map_create_opts){
> +					.sz = sizeof(struct bpf_map_create_opts),
> +					.inner_map_fd = fds[0],
> +				});

this isn't a bug, but could this use LIBBPF_OPTS(bpf_map_create_opts, opts,
.inner_map_fd = fds[0]) like create_outer() does in this file, rather than a
compound literal with a hand-set .sz?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41893660017
--===============4878618093610613736==--

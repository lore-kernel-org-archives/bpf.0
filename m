Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198315;
	b=ksZsqbZHfKUbcrBtaifOgK/KlvXUsjIZVc39S4FYq3XtJgQfpnbcickngWHhCfyJDnAA
	 8Wg5p/Sg7uzJheyhWJ7wDq3aUAl99rGZI/ylCp2BUhHCjMsz8N0LaoX8nqnUa9Z7HdeQc
	 +LWhpCMAw/VOvZHnx6SolDGSwbS6l12SygcvUXA+kkegLmlv4hq5/Cw1ewIdPsJNlWclq
	 7c8fr4asLzzlDT2c5SjnOG2TPfAVBCc2jZ2nLiZXqXQs1COgbjWSK1Jhir38mWJiKu0eQ
	 29DWXywvP7OVC+Pkg2iZ+c3NQRSs4y5ITE0qhoMAudt0RlAth+xM1C8jr+TpB365msQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TUVanLa/FUCoicRrrGBPn0JruLFhDIfpxy5nVpA/f3w=;
	b=q0Byi9BFT3h7KWHPeFqttNVI0UiZCsIHaK/lnj4IGxU+w8eQN98GTCv+6Y2+bjug4Pmo
	 Cgt1H8bNYYX7CenE5nffVTY6mjl4mDBrXIa5U5q3DJ/ViAatYAo4JDByUutDSNzKQrNT5
	 NC+7y5Fm+u4A1o5tuu+KcS5TWliGv2OmSGYO+sEiydu2nl6xX/dViKaLc/52C8NO8yt0x
	 RgRRuoz1objf32/jiXhM3ZeY52Y72qEwtEDbEnRdiZMpda/jyyPKhk9SE66rbvRNN+fmN
	 qRdUF7YwmKw6QWoiRgGJXgpl0Lq8EKNvHMEjOBiV2AI5B00EpRUZ34/vEr+vAl4eQ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZQp5fCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21C606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZQp5fCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A101F008A1;
	Mon,  9 Nov 2026 04:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198315;
	bh=TUVanLa/FUCoicRrrGBPn0JruLFhDIfpxy5nVpA/f3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZQp5fCH6nvA8RVhYcejsXaUBluxKz1OshXAAdQfUXf5SEGN1kZmSQIbKMSzeyZoe
	 avLLb1ri1Cbn3NGUt8qWe1bgT6hiUOSuYrA/zmk8BbRdjdeuhAclgKXTOKzbqrtwVP
	 /RGPFbYZo+b0PPxXc9Um5S+EyiApo8Lwdy8tx5AcwZLY++re8RMG6B96Mu7gf7YZDy
	 jH6fxOw+F+dWzatf4t0H2hPvmVWtV1VNLx1sfHgzY4NS+uYQ486E0/WRPtcDruhL+n
	 pMuyaHiGSKIJO4NiqvDlvMNr9ctXvBEWfgefn1Vg2BIVHpht4R2F3k+G8dP4c6W+LF
	 BxB1SgfzzLD/g==
Message-ID: <sashiko-outbox-204403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Skip jit_insns_arena
 tests if not supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109041207.15221-2-yangtiezhu@loongson.cn>
References: <20261109041207.15221-1-yangtiezhu@loongson.cn>
 <20261109041207.15221-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:25:14 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: incomplete jit_insns_arena skip list in
  test_jit_insns()
--

commit 5301df7df06ac60c33f099fbdfa02a082cfa0c99
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Skip jit_insns_arena tests if not supported

This commit probes for BPF_MAP_TYPE_ARENA support in test_jit_insns() and
skips the jit_insns_arena subtests when arena maps are not supported.

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/t=
esting/selftests/bpf/prog_tests/jit_insns.c
> index 0aaab23a2eef8..e8a0e5ec2d6bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> @@ -3688,7 +3688,14 @@ static void test_tail_call(void)
> =20
>  void test_jit_insns(void)
>  {
> -	RUN_TESTS(jit_insns_arena);
> +	if (libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL)) {
> +		RUN_TESTS(jit_insns_arena);
> +	} else {
> +		if (test__start_subtest("arena_zero_off"))
> +			test__skip();
> +		if (test__start_subtest("cast_to_user"))
> +			test__skip();
> +	}

[Severity: Low]
Does this else branch miss the remaining subtests in jit_insns_arena?

Commit a9fee553d3db ("selftests/bpf: Extend the JIT instruction tests for
arm64 encodings") added arena_offsets (built on all architectures) as well =
as
arena_offsets_ldsx, arena_offsets_atomics, and arena_acq_rel to
tools/testing/selftests/bpf/progs/jit_insns_arena.c.  When BPF_MAP_TYPE_ARE=
NA
is unsupported, those subtests are silently omitted rather than registered =
and
marked skipped, so targeted runs such as ./test_progs -a
jit_insns/arena_offsets match zero subtests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109041207.1522=
1-1-yangtiezhu@loongson.cn?part=3D1

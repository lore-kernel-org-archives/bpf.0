Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E93B637A
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558967; cv=none; b=pXnUue9p9YFHbKyOR25sGnJdvvv/Uz0r63a8eNTaNCks5gL7YsbMLewLiGFcUsNcSQO5H07ejGQN5qAuxwEAvvjwk3Ibwtzgz5cn7ei4y9zUxCL8HgWeIQ7qBVOC4/cp9tBM6ZJtJKKq079id8nZb3DrFqSpAjXFe/lK/wPGoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558967; c=relaxed/simple;
	bh=rNvdyzbUoXMVk3xtHbEFF9hvMw4FG4kSsUInu9i58fw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W9P0zoB8kRMiI+9jGmMfSKY97W4XYGMrjb6R7VPlQD9e0JUVEn/26C6ZHXWE1DfBCh4fAB2v3paFFtBvw9Ip7cCtIj6c1PpYsvP6YcngSVKMZdT1r2vcHntMjWr+V21GUF2TUC3/vMlntqEHliexyVM60/ixrZcPPnhBVSfMU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP/4NxJo; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP/4NxJo"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4863a7dac63so2319997b6e.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781558965; x=1782163765; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8fRTrzwESqu+d4IERJzTYfMwrtXeimkMnJ+xEbFDmw=;
        b=IP/4NxJoZMH8dfhJjRL9ogCGp1ZYkxKWRWbUhvCxV+PqWT4prCNwGWgdnhaaDnqcc6
         YTjKJLeJkdnPvEV2vJh/sQQYZb64XAhcgQQX6RSlXKZ44cYYoq7RQoAo0idzhaQsaep+
         wJ5tskCZWbaFkcshrYFRqJsAf0nJdRRyCSBIQizEumFrR6eGkDskHYsjcAsGNfN++upF
         P/M6OJoS0t1OVZsJX1QNowqU49SGwPck9n68TNM4QGzcjGcxvBgPtKnUkgx1EfCBJp1Z
         QfBvkQDwsLCGtjNK+q4eEewi+++FxkdJdM3Zlr84sLL6dPJEVKk79nm7tSAYwLyPhzKU
         pOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781558965; x=1782163765;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8fRTrzwESqu+d4IERJzTYfMwrtXeimkMnJ+xEbFDmw=;
        b=UjQ6rCA/JRa3e5LsJoPuT+8Pn1n33M0PdXXbPNEhs+Qod25k77VpRRSoau80qXpN6y
         XVp7LCHlApaqBH4Q7QSFatx9ZP3RuQ2zWj51WIO9+KFvPWdu7nXHEvsODLDlQofTYT4e
         M9PaxPVTZS8UwEJculNqamLOvBwNfC6gHYeQRdCqph8IJOJfuuwOtjRudUlKMWRnLFwF
         y6bMFZghxi5asS9H1Ifq0ZQdxmI5oBgpR50ipy/Vdoeems7dIpE/fPrkuCGHxJqGnHdT
         Lh9L75VZ2aMiDn6frLGZjyaC6WzXhDRryCnLLyQKXr9MvNK+YJKwQ1mSnSi6N1vBZOz5
         0Osg==
X-Forwarded-Encrypted: i=1; AFNElJ/JMLEqKVTCZ7s1H1lqFNE+abPDK4EJ6xsIQESbaq9ylSQ2+ZkaixqvqCPvu1pC96XM5hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1w7j0jKlRxbqNUwZ1jzTlfzB6G8oT+K/sM3h5oMP1L5lRxAg8
	pd2Mr8HATu2W0wmSHVnEc+1sLYZuFhLpJpO428vt3jgCMUmFjtVh2U2g
X-Gm-Gg: Acq92OHHbg00AD6yUIRypvIHcLcq1Mz4xWTiwnLoeuxRWe/EPT/hDNN2QxwDo/FZ9o7
	Iw2YGCDApG2g0B7Ku16YQR3LCd3slC/IHD+P+4jbFiqzY/ms7pvbw8wdvsJ0Hty2lnsK0vWA0vO
	G5z3nyynL0NudyUerOkAPOkOf4GZ6BJ8asXRTIY5iLqB2wSJ0sT5NWAZ/QZCGqpfgxPwksWsVKd
	+ZjooOq5UQBg+uUDXQE4ZeI02/nFm9CCPR5Tc+0idTtH1OKpTCtYtNUtUT56kk3C5tDHY+fpP46
	0tL5l1k7BDVgdMpFL1IzrSFTyBgsNBmT2rIR27Pd/mLHHgKT1dS2HoDDIb1LgvSyhlPZmC2jfck
	g6VNSKtUI/XVduo8K1uR65p6x3l30cfU06baSz7HEf+wZzk6YF7B7zzy5l+n5n49JFPsNdck/v0
	CuSvxOuR5/cPYcA0uX5Iu2SGz7qXxipS4XCGSjKhtKqiufBkcTPJMzu5pIfR7mVH9S0ow87h0JF
	e0C6TzwP22pjpJ0iA==
X-Received: by 2002:a05:6809:19:10b0:472:b43a:3063 with SMTP id 5614622812f47-4884d07604bmr470583b6e.38.1781558964622;
        Mon, 15 Jun 2026 14:29:24 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb911sm5204742a34.11.2026.06.15.14.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 14:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 14:29:22 -0700
Message-Id: <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify
 xlated insns for global percpu data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260615152646.27639-1-leon.hwang@linux.dev>
 <20260615152646.27639-12-leon.hwang@linux.dev>
In-Reply-To: <20260615152646.27639-12-leon.hwang@linux.dev>

On Mon Jun 15, 2026 at 8:26 AM PDT, Leon Hwang wrote:
> Add a test to verify global percpu data related xlated insns:
>
> 1. ld_imm64: compare xlated one with the one in ELF object file.
> 2. mov64_percpu_reg: it is added by verifier.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../bpf/prog_tests/global_data_init.c         | 87 +++++++++++++++++++
>  .../bpf/progs/test_global_percpu_data.c       | 11 +++
>  2 files changed, 98 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index e4c290492ff8..fcc2c4ec8644 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -279,6 +279,91 @@ static void test_global_percpu_data_verifier_log(voi=
d)
>  	RUN_TESTS(test_global_percpu_data);
>  }
> =20
> +static int find_ld_imm64(const struct bpf_insn *insns, size_t insn_cnt, =
struct bpf_insn *ld_imm64)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < insn_cnt; i++) {
> +		if (insns[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
> +			ld_imm64[0] =3D insns[i];
> +			ld_imm64[1] =3D insns[i + 1];
> +			return i;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/*
> + * Special (internal-only) form of mov, used to resolve per-CPU addrs:
> + * dst_reg =3D src_reg + <percpu_base_off>
> + * BPF_ADDR_PERCPU is used as a special insn->off value.
> + */
> +#define BPF_ADDR_PERCPU	(-1)
> +
> +#define BPF_MOV64_PERCPU_REG(DST, SRC)				\
> +	((struct bpf_insn) {					\
> +		.code  =3D BPF_ALU64 | BPF_MOV | BPF_X,		\
> +		.dst_reg =3D DST,					\
> +		.src_reg =3D SRC,					\
> +		.off   =3D BPF_ADDR_PERCPU,			\
> +		.imm   =3D 0 })
> +
> +static __u64 ld_imm64_to_u64(const struct bpf_insn *insn)
> +{
> +	return ((__u64)(__u32) insn[1].imm << 32) | (__u32) insn[0].imm;
> +}
> +
> +static void test_global_percpu_data_xlated(void)
> +{
> +	struct bpf_insn ld_imm64_raw[2], ld_imm64_xlated[2], mov64_percpu_reg, =
*insns =3D NULL;
> +	size_t insn_sz =3D sizeof(struct bpf_insn);
> +	struct test_global_percpu_data *skel;
> +	struct bpf_program *prog;
> +	int idx, err;
> +	__u32 cnt;
> +
> +	skel =3D test_global_percpu_data__open();
> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +		return;
> +
> +	prog =3D skel->progs.verifier_percpu_read;
> +	idx =3D find_ld_imm64(bpf_program__insns(prog), bpf_program__insn_cnt(p=
rog), ld_imm64_raw);
> +	if (!ASSERT_GE(idx, 0, "find_ld_imm64 raw"))
> +		goto out;
> +
> +	err =3D test_global_percpu_data__load(skel);
> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +		goto out;
> +
> +	err =3D get_xlated_program(bpf_program__fd(prog), &insns, &cnt);
> +	if (!ASSERT_OK(err, "get_xlated_program"))
> +		goto out;
> +
> +	idx =3D find_ld_imm64(insns, cnt, ld_imm64_xlated);
> +	if (!ASSERT_GE(idx, 0, "find_ld_imm64 xlated"))
> +		goto out;
> +
> +	if (!ASSERT_GT(cnt, idx + 2, "xlated insn count"))
> +		goto out;
> +
> +	ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm64 opco=
de");
> +	ASSERT_TRUE(ld_imm64_xlated[0].dst_reg =3D=3D ld_imm64_raw[0].dst_reg, =
"ld_imm64 dst_reg");
> +	/*
> +	 * The xlated instruction has the map ID in imm and the offset
> +	 * in the next instruction's imm. The raw instruction just has
> +	 * the offset in its imm.
> +	 */
> +	ASSERT_EQ(ld_imm64_xlated[1].imm, ld_imm64_to_u64(ld_imm64_raw), "ld_im=
m64 off");
> +
> +	mov64_percpu_reg =3D BPF_MOV64_PERCPU_REG(ld_imm64_raw[0].dst_reg, ld_i=
mm64_raw[0].dst_reg);
> +	ASSERT_MEMEQ(&insns[idx + 2], &mov64_percpu_reg, insn_sz, "mov64_percpu=
_reg");

If the point of the test was to check that percpu_array_map_direct_value_me=
ta()
computes 'off' correctly then it failed to achieve that goal.
It checks that map ID is correct which is a pointless test.
Either make it a real test or drop this patch.

pw-bot: cr

Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDA3DE451
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844764; cv=none; b=oSEBu4oN8CeZSoXM0PqIY3NRkv8JI3TKSJ+V1++BQSZjh39yWj8IqTakiQtheJEUvhMn4qO+tUpeXfZHvxw7dHE/y8ekuKG0rPBiWaXN7XsmK2BrNpAoplQG3InUHgUjyARQvY6wYZGPXiDr9PBxLZrgexVozeFerB9S7mvWLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844764; c=relaxed/simple;
	bh=H70csWnjwhvHsTTiICrOOEO4ULSD24owVdAdOs71oew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdhFhH2b1CtfGlDkK4/laKNQB5ApdQIr5bUNfLEj1TLLFGBZKbObNBw+jj4dCgPgsFj78BOlXufSn4cy5s6/gQZ0B1Qp9QNQ8Niy2zs26cDYADGMlDdxuCPUnpxjijehNHxbU0hLwssEH9NqCEOfmOxKIWF7ipOrmZEfq5sqnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHYc1cpq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHYc1cpq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so40863505e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844761; x=1783449561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ZeRAV1Zm9EVHndjVQcGurctctXfH0NpsD2sgmvkVo=;
        b=PHYc1cpqDiVD8/LSCd69n5+VmZvKKvQ2nRqps2nErwodg24EuzuAaIqLPMARu2qqPj
         eqWdnkOhv3iDNvXzfPA80X7ErtZFbpfihBknw8NbDePP1UGm4h3bjXNr2ZDczQ8T7m1v
         b0mWaB2lDzK7SxzURCd97OkFuvVteIVqOdPoAvVDavbP5iEeAfna/qJL42ijPQ0DY+b8
         7W6FxQHCEuG1ugheBAhkkaGSgqHTMSqXaODAxP4um6383YTHpfeKiNK1fRRNjn8M+oi/
         Q/39LOU6/LGkVtFwQPJczTJiCotOlQW/wtAcqYcX5DOQ2rwOHN+Ny6rWENyoW6t+IlOY
         d+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844761; x=1783449561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2ZeRAV1Zm9EVHndjVQcGurctctXfH0NpsD2sgmvkVo=;
        b=UHJqhA/Xr5HlXet8MqAGgVViDgpEm7P5vzxjIGS/V12/iZ6BFt/GeoXTuzGMQ4wWVh
         3D4losrAFJ/Y+T8u1LPjSHmnwOnrs2YBxNSJg23tJvARO0hfiqIFrh6mf17FmgTsWqnV
         Ms0zso48Qbl9PXV5lz73Wfz5LKUMZBUt5PpBL+yX5VzS8GZ6yAa0OPpjK7mC9dy7k92x
         ZJqLyrDdXnDPSVy0FsuNZZvMemhf/BmSQk5yiat5MmrX6gBYpJ/bTz5rEXDQLJ1i1rw5
         WKy8qD8/gbgVByjTJF8/7LLpBpP+39uigw5rL///7/iSSW8Hs4Th5qKMCGmonpjxClcI
         jM8w==
X-Gm-Message-State: AOJu0YxupUfvaaJw+SMZtqZ9GZ9nHsMgQbslEiVOr1qeaFUg1eZAHjcO
	20TbjqRawUOgE8IEq6Fs6+5KuRQb7lgx80T3VileA3LgNSGMaYEt39Vt
X-Gm-Gg: AfdE7cnnSahdNEZaON6scDb0I+zdyNMN0NVzxXEt8cTsD/zcCTj4tLnCA6TB/JQC6pJ
	UCT52PpIcXz4izhl3fMcvmNUZQS3FuribA8rd32uZhj95MjtvJ4ov1uBbZsT8WB+PGADsugdN96
	A4iw8mObUDoeuS2S2pFOu5ws5UWBnqkdVQ81aetC1mL5yzlwbLH2jgBPzHmUO0J41fTJ5/DkU4k
	T2oA5XOHnN9Gofh2CqH1iU7QbVFKBjYtILXzFg4rG8fRPjt8AkZBV+iALLM2JEw9uB7+ygUPcfA
	30Mw66u//VisO0pAfiNwuSJO/dswHafV0Te850ZCqiy4zjsTS7/i3NH1d8iO4Wf32S3LRTXBA0c
	HFDTymdroolnRLaNhGnfk+i5qnAqBX+5y1PHQ/OaaF+2ZYPVbcWmVukGq0cOtr8allZeKItCjhl
	ULj+tRT61vrj/lzHGRITQHzA==
X-Received: by 2002:a05:600c:1f84:b0:493:8391:919a with SMTP id 5b1f17b1804b1-493b828ebb1mr71769745e9.16.1782844761240;
        Tue, 30 Jun 2026 11:39:21 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be81df2asm21496495e9.12.2026.06.30.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:39:20 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:49:23 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Message-ID: <akQPsxoMVYx8+9Ap@mail.gmail.com>
References: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
 <20260628-f01-03-gotox-bpf-next-v3-2-b744432e1361@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-f01-03-gotox-bpf-next-v3-2-b744432e1361@mails.tsinghua.edu.cn>

On 26/06/28 09:59PM, Nuoqi Gui wrote:
> Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
> model a map whose target stays in the main subprog, while the verified path
> can load a different map whose target is the first instruction of another
> subprog.
> 
> That second target is outside the subprog that contains this gotox
> instruction, so program load must be rejected with -EINVAL.
> 
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> index 73dc63882b7d..997724c61c8b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> @@ -255,6 +255,30 @@ static int create_jt_map(__u32 max_entries)
>  			      key_size, value_size, max_entries, NULL);
>  }
>  
> +static int create_jt_map_with_target(__u32 target)
> +{
> +	struct bpf_insn_array_value val = { .orig_off = target };
> +	__u32 key = 0;
> +	int map_fd;
> +
> +	map_fd = create_jt_map(1);
> +	if (!ASSERT_GE(map_fd, 0, "create_jt_map"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0),
> +		       0, "bpf_map_update_elem")) {
> +		close(map_fd);
> +		return -1;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze")) {
> +		close(map_fd);
> +		return -1;
> +	}
> +
> +	return map_fd;
> +}
> +
>  static int prog_load(struct bpf_insn *insns, __u32 insn_cnt)
>  {
>  	return bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
> @@ -393,6 +417,52 @@ reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int o
>  		close(prog_fd);
>  }
>  
> +static void
> +check_cross_subprog_gotox_target(void)
> +{
> +	struct bpf_insn insns[] = {
> +		/* main subprog [0,14) */
> +		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0, 12),
> +		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, 0),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, 0, 4),
> +		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 0),
> +		BPF_JMP_A(3),
> +		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 0),
> +		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, 0, 0, 0),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN(),
> +
> +		/* static subprog [14,16) */
> +		BPF_MOV64_IMM(BPF_REG_0, 42),
> +		BPF_EXIT_INSN(),
> +	};
> +	int good_fd, bad_fd, prog_fd;
> +
> +	good_fd = create_jt_map_with_target(12);
> +	if (!ASSERT_GE(good_fd, 0, "create_good_jt_map"))
> +		return;
> +
> +	bad_fd = create_jt_map_with_target(14);
> +	if (!ASSERT_GE(bad_fd, 0, "create_bad_jt_map")) {
> +		close(good_fd);
> +		return;
> +	}
> +
> +	insns[4].imm = bad_fd;
> +	insns[8].imm = good_fd;
> +
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
> +				insns, ARRAY_SIZE(insns), NULL);
> +	if (!ASSERT_EQ(prog_fd, -EINVAL, "cross_subprog_gotox_prog_load"))
> +		close(prog_fd);
> +
> +	close(bad_fd);
> +	close(good_fd);
> +}
> +
>  /*
>   * Verify a bit more complex programs which include indirect jumps
>   * and with jump tables loaded with a non-zero offset
> @@ -541,5 +611,8 @@ void test_bpf_gotox(void)
>  	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
>  		__subtest(skel, check_ldimm64_off_gotox_llvm);
>  
> +	if (test__start_subtest("check-cross-subprog-gotox-target"))
> +		check_cross_subprog_gotox_target();
> +
>  	bpf_gotox__destroy(skel);
>  }

LGTM now. Please add another selftests as was mentioned in the main patch.

Also, v3 lost the ack from Yonghong Song for this patch.

> -- 
> 2.34.1
> 

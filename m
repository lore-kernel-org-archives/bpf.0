Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B603B4E8F
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138608; cv=none; b=r25o3NumQzavlGTV/DjojTvRCyppHDKLNY5n6lL5olun14XFdN8HdIv8cYU3/zFbqpUj/YxOQ3mNBrl/9Rtgib450HDZ9TcMhYKRReG3X5n/5gqh2IXKK+hIhWLR92JPmbLhiF+xY/wSdnS8QBsT3LJjDAf1G09kEA+n4x9XNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138608; c=relaxed/simple;
	bh=vwKiouhuUHCBJqPsJWndI2+FHQK+GYGS0KsTMBGGV4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUTjS19+I3jpK8BdIxuhMHWMcLTebcmVXTsCod997PDxEMk6TYoOq0uEo48Dvf+QChpn7o81kD3Q9U3uR4Mrt/O3kB7aqwImpy1ysjhXI3jdudzEbxuCRT/oCTWjvhtkoOi5p3xBfTpiimPofgQrPYGVyT83Kqoio0jWvTnMUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHXEHWVb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHXEHWVb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so47438575e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782138605; x=1782743405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkgK0H6tpODYh9OFFA3B2B2IjdvuXokUWCmOig3RBWA=;
        b=VHXEHWVbY53rClUfn/JGMaomcdvguOISPgdRa37puEzYgFITTgwKXD/Y/CEzp3tk9z
         zMcuOJ7iUpFG6uvSImvLeJ/0UyN5Ku5Ys8/c+I/mohDjdVcGNpMC1hqpjTwnNYkuDDrT
         w3V8TmrpjSPbSYahH7ruq+oGRTOgs4dEz99oMwKrE+eRPxLhjxZkfKgHQM++Ph97/edJ
         Odttyfx3oe2UPodz7AQY6zZ18eqIHca2ZPBQyAXjg6U81KN4AB8YN/aAI1AF/SjIPR+N
         km2S3dFdM0ZylwrcI56PbxT6d/eN+oBbQ7tmebmMjTFFAn/i28eGODVBe7BbSb1G+5J5
         YOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782138605; x=1782743405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkgK0H6tpODYh9OFFA3B2B2IjdvuXokUWCmOig3RBWA=;
        b=nV+92S30imI8zNE6XW1bR7sR8O8bmAK1DhR8Rz8gVkXQVZByDfhAer6xTB9OdZJr37
         EHr0Kd0+lRelSI2ALWkrxBqty4j9o35sQmdap0NDAAoHbLJDYxSnots5b5QNDxQJOO05
         cgum1Zm+1itSstN4Xa678FetH3BWuhimVpdZqa79QUiw54dtAkm0CcMvDI+aEL/rOgcg
         h0pmimQVjydj0dHjWn4Z/HvB0uLUhyocwUdHaihZYhQIHoM4pjeVqLBAbpEroGm6WTJF
         yMMeCdXGAWTLiAoBmunZeTDvSu+9ffegoETNPImcCwu9BuOC0+eiQ+32iOLitYXuc/fX
         6Z1A==
X-Gm-Message-State: AOJu0YwWqJ3AWH6WatYxqj8i1l+fGdM2m7n1XZ5ydxbMDh0R+8yFAtUl
	P3PH6PDvk+kTeXqm4jWiT9Dyr4YttLgmcHjeF00/Pn/CsJRBa+eCh+9p
X-Gm-Gg: AfdE7clCGZmkRPNOzlHdOBPciOOHiBTKoNszazBIV/BGTCIb8kPS+ZCM7Gk1F7x4BVX
	/XZsBvYENmnWYhdOS/7hazXOGoPzPm3n9t8+letWgonw2uQYfGFXcvRAnliwVGpoaSoDbtaPygN
	lh0xfuKoFll0YjEqspG/CXvI9/U61vv5o79Fav6a7/KT3fnJNHVCiwSBx6ugQIMXs4RyZBF8dzd
	oORiPgSh8m+T6o/RdEhQcMz7dbftcpNiX4SYOv8yWlyX+UGf1M/Vq9p0UUl2EYqbjFTEPNceDof
	no/6p37Q4ImJB5awfb7QqfBHYTwbooQ0nnLXZhi+JPq0Sb9YkVrtrYcRLy1r0JEQqpf5RuKiA/y
	dgKZ13N0mtsfBXqvUMiQK/4rzu/GgV3Kde95vBBxM5ep9xX84iP2iQewsbEnI3hwRlHi4bDkj+S
	ZsK28Mu5YyoKreWcH4Yr0Fww==
X-Received: by 2002:a05:600c:1d0d:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-4924233a8acmr205178035e9.9.1782138604326;
        Mon, 22 Jun 2026 07:30:04 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm505303815e9.0.2026.06.22.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:30:03 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:40:01 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Message-ID: <ajlJQUmKUBkNcezW@mail.gmail.com>
References: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
 <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>

On 26/06/13 05:33PM, Nuoqi Gui wrote:
> Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
> model a map whose target stays in the main subprog, while the verified path
> can load a different map whose target is the first instruction of another
> subprog.
> 
> That second target is outside the subprog that contains this gotox
> instruction, so program load must be rejected with -EINVAL.
> 
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Sorry, was AFK the last week. The looks better now. A few small nits.

> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> index 73dc63882b7d..5252ca09689c 100644
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
> +check_cross_subprog_gotox_target(struct bpf_gotox *skel __always_unused)

Why to pass the skel pointer at all?

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
> @@ -538,6 +608,9 @@ void test_bpf_gotox(void)
>  	if (test__start_subtest("check-ldimm64-off-gotox"))
>  		__subtest(skel, check_ldimm64_off_gotox);
>  
> +	if (test__start_subtest("check-cross-subprog-gotox-target"))
> +		check_cross_subprog_gotox_target(skel);
> +
>  	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
>  		__subtest(skel, check_ldimm64_off_gotox_llvm);
>  

Why haven't you add the test as the last one? Especially that it
doesn't use the __subtest() helper.

> -- 
> 2.34.1
> 

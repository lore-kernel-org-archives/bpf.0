Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF98346AF1
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041849; cv=none; b=EPycSqfbUuWAz40Pd/Nt3yPqEtIaWtjAvM6D9A6FD+7vDPcaoPqghQYeKphA+DBa9HoVwwpb4WYtXPZ8aYnDCl2R+65ktMHY8eTQvoZ4TaLlJUIwK9QJe8UD462uyZYxzrMIicADyExQGHLTHcBpFfOym9TFC4IYt/St44ktth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041849; c=relaxed/simple;
	bh=Ge31FLt3CfoTueh6ISl9oPV2t9v2Nd7ZZ4LiAtNw0Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqZdbGnz+xT6nv0WIDL040M48vKT/azViHYrbbO2zy+wTgHpMCSABRYz4iL7bs8K0aLQwM6IF61M5ge4njP4TJ1hdG0hAoTOOv9+1PQhDbj/ynXyCHdsUmBh7wuiy1Wb6DnS3pnWVb5in68X7l1h15d1DgjYFkEFRrj2lDvYLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN4HfKuK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN4HfKuK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so80506045e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789041846; x=1789646646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e19GNOKtk3BwtTRcf1dnONOtDAh2g2MyeCeLAGR2rY4=;
        b=PN4HfKuKqnYj1l1qwGtl3k10O2cBa/UKxF+N6P/9obRDglswavkf4phHcqq2po/cyj
         V60nkyL51/V6k3Y+1za1o0x1VoNTwMz+dl/O/PhDEtT1wsrTEndkQSxyFYNazMeuIWbg
         SXg4lMj+i6yUnqV91mdeNBwnQw9xML01Wy41MskWz2Cl8atsa04qjDR4n288EjnHkzRp
         i9q/xanAjTLmsfgkn7Thvjs5zFb0ocxzn6P6EWB7v8llawW7Ob6P1h8erjf59mA431b/
         ORiBZF5fuQKJesZG3L5KPx2d1MGh3dFpXUvCzEknnz6SLqoL9NQuadce/QMhgJKKt+dn
         YS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789041846; x=1789646646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e19GNOKtk3BwtTRcf1dnONOtDAh2g2MyeCeLAGR2rY4=;
        b=Wp+QLr37ek1B8HlAnkdbcTFE5h3MZ6g0r6leyTRp3vTLbSi0pqy1RO6UdpEUBYwA7f
         rHrFvIQ7+/UWOLrtL1BmUPk7mGB4f1VWwmNt+BNfpDGEATkLUAQlAzpJCAc9ASHyUeNI
         6e5g99FkcUtRvRNnt8qNhLi5FGJOzP75EJ7jwuqsKtJaOewwJZvEmM7l7/o2sMYxXVTQ
         zemuSmanQbQ/riNPqM1U6LTGceb9E7yA7RV6OKkbL740irZkEyWqgSv0dOt5DzeMTbw+
         c4edIb3+j3nZVSvYsx6kSbj27S87nrRmXEl4vQ8koabaDT+pSOcJKsB7l2fWYRS2UpPi
         QDkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeOAYvgsWyh/fXJvFmtBO6jTd78OvwFZCdyk5wWY8EjQZoX++1ole+djkID1kaJ83nGdk=@vger.kernel.org
X-Gm-Message-State: AFuF++nzbSTr8ivB8S+KbVA1H6zZdYZfzqon+taJvszZq1oe+dxp1bWW
	7IHMU+b3zotatKWLuQo6Yjpq4ag4cHrPRlKAZx+6IaAa9SVa9uo6oA90
X-Gm-Gg: AYBFou2WBeSGHZmo8yL5Hh2w34LCkJit7vDpdbNul8THLdBQApk7CtmDTcHEjp55OTU
	q4QtKikjkzH7ZOzgXhBtkHKQcyaSyzJgepbyQa6nbIyPby4ml5lhow3dz/VGlCdebj2l/Pioa6K
	tikhyS5hbqF2qKyFAdBL+4KferONS5+3fX2bIlgY2VZzDh5/QIW76ftzqnSBN7X8oXz1iFihjhR
	YInuBEHddcoJ6Sg6m0rOQXSyzigAMhwaUb/6hioAtLmfS3NVH/M40FxnZKx0cfjHPfMZCNvpnuw
	M2wxTVKgbLozE0OZyVH0IiBR7y3gEOhUKSmUxpp8y88zdVGIwVMq24Yc0jCh1EAaHXVJi0Tbwoc
	JlCKnZg6J6xf4EXPEbGoRJYPTId5sYQOnf1KhLbYOvwraIzwXuUZ7UECaYmb0lbCviH5VxhR11x
	fv4zXR/6t8F+Yvb8/cAYrd0Gr9FiGOemhMTn7hxro+ul8PaKxRLrwM2b2u2nVXppY9RLr5XmUn+
	bc2JBI=
X-Received: by 2002:a05:600c:3b9e:b0:49c:fc6c:be1a with SMTP id 5b1f17b1804b1-49cfc6cc121mr375780975e9.32.1789041845343;
        Thu, 10 Sep 2026 05:04:05 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bdb789sm81114385e9.1.2026.09.10.05.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 05:04:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:14:41 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 5/6] selftests/bpf: Add tests for the indirect jump
 edge limit
Message-ID: <aqKfMVhdfDEg95dR@mail.gmail.com>
References: <20260909204035.24289-1-daniel@iogearbox.net>
 <20260909204035.24289-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909204035.24289-5-daniel@iogearbox.net>

On 26/09/09 10:40PM, Daniel Borkmann wrote:
> Build programs whose gotox instructions are their own jump table targets,
> which makes the edge count quadratic.
> 
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpf_insn_array
>   [...]
>   #24/10   bpf_insn_array/too-many-gotox-edges:OK
>   #24/11   bpf_insn_array/gotox-edges-at-limit:OK
>   #24/12   bpf_insn_array/gotox-edges-across-subprogs:OK
>   #24      bpf_insn_array:OK
>   Summary: 1/12 PASSED, 0 SKIPPED, 0/0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../selftests/bpf/prog_tests/bpf_insn_array.c | 266 ++++++++++++++++++
>  1 file changed, 266 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 0222a9a5d076..c69d44cd4607 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -453,6 +453,263 @@ static void check_bpf_no_lookup(void)
>  	close(map_fd);
>  }
>  
> +#define GOTOX_CNT_AT_LIMIT	1000
> +#define GOTOX_LOG_SZ		(256 * 1024)
> +
> +static const char gotox_limit_msg[] =
> +	"number of indirect jump edges in the program exceeds";
> +
> +static int gotox_jt_create(__u32 first_gotox, __u32 gotox_cnt)
> +{
> +	/* the run of gotox itself, plus the exit block right after it */
> +	const __u32 jt_cnt = gotox_cnt + 1;
> +	struct bpf_insn_array_value val = {};
> +	int map_fd;
> +	__u32 i;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, jt_cnt);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return map_fd;
> +
> +	for (i = 0; i < jt_cnt; i++) {
> +		val.orig_off = first_gotox + i;
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> +			       "bpf_map_update_elem"))
> +			goto err;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto err;
> +
> +	return map_fd;
> +err:
> +	close(map_fd);
> +	return -1;
> +}
> +
> +static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
> +			   int *fd_array, __u32 fd_array_cnt, char *log)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +	int prog_fd;
> +
> +	log[0] = 0;
> +	opts.fd_array = fd_array;
> +	opts.fd_array_cnt = fd_array_cnt;
> +	opts.log_buf = log;
> +	opts.log_size = GOTOX_LOG_SZ;
> +	opts.log_level = 1;
> +
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
> +	if (prog_fd >= 0) {
> +		close(prog_fd);
> +		return 0;
> +	}
> +	return prog_fd;
> +}
> +
> +/* Fill in 'r1 = 0; gotox_cnt x gotox r1' at 'insns'. */
> +static void gotox_run_fill(struct bpf_insn *insns, __u32 gotox_cnt)
> +{
> +	__u32 i;
> +
> +	insns[0] = BPF_MOV64_IMM(BPF_REG_1, 0);
> +	for (i = 1; i <= gotox_cnt; i++)
> +		insns[i] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
> +}
> +
> +static void check_gotox_limit_hit(const char *log, int err)
> +{
> +	ASSERT_EQ(err, -E2BIG, "program should have been rejected");
> +	ASSERT_HAS_SUBSTR(log, gotox_limit_msg, "verifier log");
> +}
> +
> +static bool try_load_gotox_prog(__u32 gotox_cnt, char *log, int *err)
> +{
> +	const __u32 insn_cnt = gotox_cnt + 3;
> +	struct bpf_insn *insns;
> +	bool attempted = false;
> +	int map_fd;
> +
> +	insns = calloc(insn_cnt, sizeof(*insns));
> +	if (!ASSERT_OK_PTR(insns, "calloc insns"))
> +		return false;
> +
> +	gotox_run_fill(insns, gotox_cnt);
> +	insns[gotox_cnt + 1] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[gotox_cnt + 2] = BPF_EXIT_INSN();
> +
> +	map_fd = gotox_jt_create(1, gotox_cnt);
> +	if (map_fd < 0)
> +		goto free_insns;
> +
> +	*err = gotox_prog_load(insns, insn_cnt, &map_fd, 1, log);
> +	close(map_fd);
> +	attempted = true;
> +free_insns:
> +	free(insns);
> +	return attempted;
> +}
> +
> +/*
> + * The extra exit target in the jump table makes for gotox_cnt * (gotox_cnt
> + * + 1) edges, hence the program is over the limit by gotox_cnt edges.
> + */
> +static void check_too_many_gotox_edges(void)
> +{
> +	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT;
> +	char *log;
> +	int err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	if (try_load_gotox_prog(gotox_cnt, log, &err))
> +		check_gotox_limit_hit(log, err);
> +
> +	free(log);
> +}
> +
> +/*
> + * A chain of blocks, where block k loads jt[k] and jumps to it. The jump
> + * table holds the starts of the blocks that follow plus the exit block,
> + * which is gotox_cnt targets for gotox_cnt gotox, so the program sits
> + * exactly at the limit and must still load.
> + */
> +#define GOTOX_BLOCK_SZ		4
> +
> +static void gotox_chain_fill(struct bpf_insn *insns, __u32 gotox_cnt)
> +{
> +	struct bpf_insn *at;
> +	__u32 k;
> +
> +	for (k = 0; k < gotox_cnt; k++) {
> +		at = insns + k * GOTOX_BLOCK_SZ;
> +
> +		/* r1 = &jt[0], by index 0 into fd_array */
> +		at[0] = (struct bpf_insn) {
> +			.code = BPF_LD | BPF_DW | BPF_IMM,
> +			.dst_reg = BPF_REG_1,
> +			.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
> +			.imm = 0,
> +		};
> +		at[1] = (struct bpf_insn) { .imm = 0 };
> +		at[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, k * 8);
> +		at[3] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
> +	}
> +
> +	insns[gotox_cnt * GOTOX_BLOCK_SZ] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[gotox_cnt * GOTOX_BLOCK_SZ + 1] = BPF_EXIT_INSN();
> +}
> +
> +static int gotox_chain_jt_create(__u32 gotox_cnt)
> +{
> +	struct bpf_insn_array_value val = {};
> +	int map_fd;
> +	__u32 i;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, gotox_cnt);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return map_fd;
> +
> +	for (i = 0; i < gotox_cnt; i++) {
> +		val.orig_off = (i + 1) * GOTOX_BLOCK_SZ;
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> +			       "bpf_map_update_elem"))
> +			goto err;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto err;
> +
> +	return map_fd;
> +err:
> +	close(map_fd);
> +	return -1;
> +}
> +
> +static void check_gotox_edges_at_limit(void)
> +{
> +	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT;
> +	const __u32 insn_cnt = gotox_cnt * GOTOX_BLOCK_SZ + 2;
> +	struct bpf_insn *insns;
> +	char *log;
> +	int map_fd, err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	insns = calloc(insn_cnt, sizeof(*insns));
> +	if (!ASSERT_OK_PTR(insns, "calloc insns"))
> +		goto free_log;
> +
> +	gotox_chain_fill(insns, gotox_cnt);
> +
> +	map_fd = gotox_chain_jt_create(gotox_cnt);
> +	if (map_fd < 0)
> +		goto free_insns;
> +
> +	err = gotox_prog_load(insns, insn_cnt, &map_fd, 1, log);
> +	close(map_fd);
> +
> +	if (!ASSERT_OK(err, "program at the edge limit should load"))
> +		fprintf(stderr, "verifier log: %s\n", log);
> +
> +free_insns:
> +	free(insns);
> +free_log:
> +	free(log);
> +}
> +
> +static void check_gotox_edges_across_subprogs(void)
> +{
> +	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT * 3 / 4;
> +	const __u32 sub_start = gotox_cnt + 3;
> +	const __u32 insn_cnt = 2 * (gotox_cnt + 3);
> +	int map_fd[2] = { -1, -1 };
> +	struct bpf_insn *insns;
> +	char *log;
> +	int err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	insns = calloc(insn_cnt, sizeof(*insns));
> +	if (!ASSERT_OK_PTR(insns, "calloc insns"))
> +		goto free_log;
> +
> +	gotox_run_fill(insns, gotox_cnt);
> +	insns[gotox_cnt + 1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0,
> +					    BPF_PSEUDO_CALL, 0,
> +					    sub_start - (gotox_cnt + 1) - 1);
> +	insns[gotox_cnt + 2] = BPF_EXIT_INSN();
> +
> +	gotox_run_fill(insns + sub_start, gotox_cnt);
> +	insns[sub_start + gotox_cnt + 1] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[sub_start + gotox_cnt + 2] = BPF_EXIT_INSN();
> +
> +	map_fd[0] = gotox_jt_create(1, gotox_cnt);
> +	if (map_fd[0] < 0)
> +		goto free_insns;
> +	map_fd[1] = gotox_jt_create(sub_start + 1, gotox_cnt);
> +	if (map_fd[1] < 0)
> +		goto close_maps;
> +
> +	err = gotox_prog_load(insns, insn_cnt, map_fd, 2, log);
> +	check_gotox_limit_hit(log, err);
> +
> +close_maps:
> +	close(map_fd[0]);
> +	close(map_fd[1]);
> +free_insns:
> +	free(insns);
> +free_log:
> +	free(log);
> +}
> +
>  static void check_bpf_side(void)
>  {
>  	check_bpf_no_lookup();
> @@ -490,6 +747,15 @@ static void __test_bpf_insn_array(void)
>  
>  	if (test__start_subtest("bpf-side-ops"))
>  		check_bpf_side();
> +
> +	if (test__start_subtest("too-many-gotox-edges"))
> +		check_too_many_gotox_edges();
> +
> +	if (test__start_subtest("gotox-edges-at-limit"))
> +		check_gotox_edges_at_limit();
> +
> +	if (test__start_subtest("gotox-edges-across-subprogs"))
> +		check_gotox_edges_across_subprogs();
>  }
>  #else
>  static void __test_bpf_insn_array(void)
> -- 
> 2.43.0
> 

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

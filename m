Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BE36D517
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021091; cv=none; b=sthLzr6dLEiaZCRJu+kTHp/zPi8CfY1YhdWaaZAJO8RtaxOIbE1t4OHQE8Xn2Kh1kfGhfJk6cTbeYFMIgYLGompa8wYxnb0uohzf+VajuV4G6E+yhgyj0FKwUTrBntH6422p4o10lXPIMRFXLBIJSI4DQ/poSkCfef6vAXmx48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021091; c=relaxed/simple;
	bh=1To+keB+5vy5Y9BBXzSUDbHsuvx8B/OUMdT1YWvME6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN2Yhw1B4TNrQKpuYmNNTlDVts3BtSyCnMsCknpoOTtJ2hqSVj2fyNv21A9jJEwizdrNvv/0M4mAPCQqIaK+UjhO2xE9QFLP6Uwf6HipSWAJPWo2EOgYWZ3for6/DEr5dsdJhlSacYthdherdvnQDHWRuXfibgoWjfKnT7UCoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUk0kv3i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUk0kv3i"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso20378095e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021085; x=1781625885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELcI1EAGb1ma2NUUWHn2xhtw3Vi4n0+De/VvgwxlDXc=;
        b=QUk0kv3ifk0D/ecuveFGP7NQNt9YYSknK9Ss+GE4m66syGEFWbf6qmxVhZCl8iPcAI
         vpueAkyOE3Yvjb8G1BvrvFdf7EPO71fawNiKOeZCN+dtCsDH+C03z959cTQIsj3NlIuA
         4fnnGCGYCv4T4vpvr6mti1/rxBtLiABErToFR6nY58D5eI82n7Ba3jPqrAxsial9AHVv
         iBje0i5OPZ864RGPEL64dvrKOKrWcaYCrFZ6Fpz2/Cd+OwPKlvv81TQ6tbkuI6fQLo41
         2wfFtUsPF0jhLG4+45/+uq7FA5i+X0R4OrCdYM2GfHPoWUTFKq7fmaUQut69k+opY2qD
         wi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021085; x=1781625885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELcI1EAGb1ma2NUUWHn2xhtw3Vi4n0+De/VvgwxlDXc=;
        b=CtBlr1sU0tY0UbWP0ki7HaofQIwxVhW9z7pkNOm8U8X8zxtAUiTTfDRHKvIoxAzOqe
         eVOLZ32uUgHTYgm0obM/2vtGjUTumkVyWcYZnWYvYBlqxWGFHRhBH+wJxegCegWVnyXZ
         PCQtSeM+LDN1J7us1OpD8aBp+XCXEm8p896szTZU3um5gYdi3SJhqavBhNFnK2SoHse6
         +uzltcOjQ6rWpnwO4WtasHR7KoyI8qpnSRJbgWpkwhQcTPhG5IVCj+/4Tt7q2HmJirdX
         fSa6yAx5uxD+cFGwc2xqZzMNeamzwSYB5K49MAB9jjpCrzA2l1xQrJrStEMkNaFcilLs
         6Kog==
X-Gm-Message-State: AOJu0Yy6tJY5i2u4slK1xWamU1ps1wtZaAT43/65+7e3/6XV2tDnzak4
	johpXDcdhJbFI9F1t4ZM9tpNHMKXK8ssTVv7xZa35SHle6lIU54hvg52YdhrFg==
X-Gm-Gg: Acq92OGXJeb6oxhixE1qLAR/TlUnZZjpIUuqKCjfvjN7AErb9FmCmdagJzmx+vtrI5A
	Fnq9kUX+WkoFmELSDavolTbZmK+m+gmLx866YA5jNvc1ERvpEEzE4zGLUL1HSc1FEuURC/eJ7/3
	V3oLir+kW6sumRl6CMNe/odkGvYokaU5iYHZ8NPZ71VJ7kYXMSU0VIXnMqGKkh4z3S46PWymnim
	pm4w5m8hAgm+aX+M0t/s7nHhnHnzT6KJ63pAIDsOnutS/X9R9mfmAN579Zk9L46Fb4mL2yMrJvz
	34paX+28+dOpJY82T2DRiiNkqZhQXcnNlBeFAzg7my6KcDQDSfhleghZjZ+Dl7iN2+sJYu7zfRZ
	OBzcGD9fcCNsfnn8+ex+NhzBxO5927zQTNhv8OAtSn2bBgcSInUUO+PpRdWOwcdEkaYraesGKql
	QOkgLRLQ2YhIlNkkHZ6EAbnqFPvxzia2+ddm6Js1o0X2dlbbabBxc21g==
X-Received: by 2002:a05:600c:358b:b0:490:b591:b5a1 with SMTP id 5b1f17b1804b1-490c25da474mr369530505e9.32.1781021085167;
        Tue, 09 Jun 2026 09:04:45 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bda4fd52sm480210805e9.0.2026.06.09.09.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:04:44 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:14:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Message-ID: <aig76Gkk3W9z6U7S@mail.gmail.com>
References: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
 <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>

On 26/06/09 11:03PM, Nuoqi Gui wrote:
> Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
> model a map whose target stays in the main subprog, while the verified path
> can load a different map whose target is the first instruction of another
> subprog.
> 
> That second target is absent from the CFG jump table for this gotox
> instruction, so program load must be rejected.
> 
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> index 73dc63882b7d..866b4a14ccb7 100644
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
> +	if (!ASSERT_EQ(prog_fd, -EACCES, "cross_subprog_gotox_prog_load"))
> +		close(prog_fd);

Robots are right, of course:

    ...
    check_cross_subprog_gotox_target:PASS:create_bad_jt_map 0 nsec
    check_cross_subprog_gotox_target:FAIL:cross_subprog_gotox_prog_load unexpected cross_subprog_gotox_prog_load: actual -22 != expected -13
    #20/14   bpf_gotox/check-cross-subprog-gotox-target:FAIL
    ...

Please the next time actually run selftests before sending patches.

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
> +		__subtest(skel, check_cross_subprog_gotox_target);
> +
>  	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
>  		__subtest(skel, check_ldimm64_off_gotox_llvm);
>  
> 
> -- 
> 2.34.1
> 

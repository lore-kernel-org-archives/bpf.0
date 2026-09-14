Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AC30E0D5
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396242; cv=none; b=eo3ikDWBWlP2zh0jRw8eUauYbomASbdXDEdarv2NzKkbBOt2A0VenOLxvtvNDP3ORrHzoQqZcYdGX174A02aCLUc7vf8xU96gzxdzR1htI4r3p+0UafeRTqzcX+DHC8/yAPFFegBjxALIqX6hx4ovUQX/kPo6hlBjEGOuOApChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396242; c=relaxed/simple;
	bh=54YcCbKHj7Sp+TjnUKbPksYa8NccUDpMhfPy1+YVxmc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XD91g+eghmROCfzYr5K/6Wif9QeKfvIWBt6F73E3BksLC3yjJtbSKDsYRZ1H+Se3s+2AsZKWq6wrJvmgHha8q1a98Eq1kE2fM9mIygenpAXU2W/h+/M/QhBWTLjqZWsUdIeQj0sTaNHK+BqzW32S+B/v6fsUhd9z5Ep6IDNbTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKUHi/cV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKUHi/cV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC31F00893;
	Mon, 14 Sep 2026 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396240;
	bh=utNMAsh6ZSa0WKMODtUETKedksdJmW8rPKzVi7Mbq2c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CKUHi/cV0b5w/8JG/iy5EcYFif0JfRTrdAcUQ/f5CVk4VefZrnFvRahPevngqsQtn
	 yuydcpVeH/OdDUNdxyidMnu8rAi6s1VEJSgo9J1NbMjQTZVjv28/aRLL0UlL4CMuAo
	 +PtFt35ZXEHp8GunDSDHXeVCl1YLGBYzJX5AkidGjY99pRtIQRsV8D5tXkUa3NZX/X
	 RA8rS7N4gvuNZ8v+k/W+YeqKGUQ39TAUsLsSTS6PUXKZI3eU85d9OinZLMMJKjQ5/v
	 Ld0n3fd3jNsKjZXkDE6GgSmMXutPSMYZp+4i7YVv40Se99qcj78c2LqafU/Z529+zw
	 P1OSYLulg/y8w==
Content-Type: multipart/mixed; boundary="===============5964637437599362684=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2449cd721cc18c66d26e3ff4e4ff3facf0e8dbb08b76a478b029bb9bb2c48583@mail.kernel.org>
In-Reply-To: <20260914131701.2529725-6-memxor@gmail.com>
References: <20260914131701.2529725-6-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 5/7] selftests/bpf: Test CO-RE instruction poisoning restrictions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:30:39 +0000 (UTC)

--===============5964637437599362684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb169..158b3e2e3f5f7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c

[ ... ]

> @@ -14,6 +14,173 @@
> +static void test_poisoned_insns(void)
> +{

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		struct bpf_insn insns[] = {
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> +			tests[i].insns[0],
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_EXIT_INSN(),
> +		};
> +		int insn_cnt = ARRAY_SIZE(insns);
> +
> +		if (!test__start_subtest(tests[i].name))
> +			continue;
> +		if (insns[2].code == (BPF_LD | BPF_DW | BPF_IMM)) {
> +			insns[3] = tests[i].insns[1];
> +		} else {
> +			insns[1].off = 1;
> +			insns[4] = BPF_EXIT_INSN();
> +			insn_cnt--;
> +		}
> +		prog_fd = load_core_relo_insns(btf_fd, insns, insn_cnt, funcs, 1,
> +					       enum_id, access_str_off, 2, false);
> +		if (!ASSERT_GE(prog_fd, 0, "control_load"))
> +			goto cleanup;
> +		close(prog_fd);
> +		prog_fd = load_core_relo_insns(btf_fd, insns, insn_cnt, funcs, 1,
> +					       enum_id, access_str_off, 2, true);
> +		if (tests[i].relocatable) {
> +			ASSERT_GE(prog_fd, 0, "dead_poison_load");
> +			ASSERT_HAS_SUBSTR(log, "substituting insn #2", "poison_log");
> +			if (insns[2].code == (BPF_LD | BPF_DW | BPF_IMM))
> +				ASSERT_HAS_SUBSTR(log, "substituting insn #3", "poison_ldimm64_log");
                                    ^^^^

This isn't a bug, but the ldimm64 predicate (insns[2].code ==
(BPF_LD | BPF_DW | BPF_IMM)) appears in two places: once to set
up insns[3], and again to check for the "substituting insn #3"
message. Would a local variable or an extra flag in the tests[]
table make the two-slot instruction case easier to follow?

> +		} else {
> +			ASSERT_LT(prog_fd, 0, "invalid_poison_load");
> +			ASSERT_NULL(strstr(log, "substituting insn"), "invalid_poison_log");
> +		}
> +		close(prog_fd);
> +		prog_fd = -1;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34849913056
--===============5964637437599362684==--

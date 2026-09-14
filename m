Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D33290C9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428532; cv=none; b=OClO/i7FkNL/9B6M9lEgd2Gn2Hx2rGcReWeqW4GfnliX1j/MntjtVHR0leaU0ChFKw+wQJ87mrIzj21xATH0bsuSr+4JxboH3tJ6U2KAJtdR3lnQdxX5orkFp39lTETu4bdr579H+qblGYFr5gmdfzAMAilq6iL8ZH9xzImP258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428532; c=relaxed/simple;
	bh=5Fz7mS2aq725oMLZIKDoi+jU+A2aDchSoK5youq8xPg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qi0kV7YnmmmB3T5V5iu5K9bJFAALvdB7r/Z7IZ+5lKzSgBh0wng3AAtc43zxANZM+MIWATdGXHK+95HFLFD2LXkDSmnmA8zw026ib9UezTR7Hsn5H6Zs9i9ydKfrxJ2KHAwuyqLPqq2s1avLsulJ/3wbo36XTmR5zO+3oP3wiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjBgXIXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjBgXIXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AFE1F00893;
	Mon, 14 Sep 2026 23:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428530;
	bh=MhF2v8dGolrIFzRSuE5/L83qZH3IhPaO19Wxj3Euop0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OjBgXIXEpukVOq50LPRSp/ko0lVPA6M/A6d2s2Ax5uejPst104YNIQywjDm+E9UuU
	 1PJ5NDp2HD3ZEgKVZELymGm3OEdPs3DcIBNG64GsEla/p54P9GZJkl9VieUkTyhm2x
	 zYPqa2zogTLiXzElaQ9mccr5aL+NQ8uV18rqqXZw42OTs0taiMLmq7dQ2dKWHw+q0n
	 0fzxzp8Rhj331IffFxxxyKd8J9Z0kMPJaLIhVvWdLyJdRiMLDno6ZT2GDW+Dg/JBBX
	 qidOFiZ6pDmrBX50L5RV+4NOKoQp83L38k48Q97f13wT2YThpyw/sd9zxCPoK99/et
	 LtNMBH6Z+enog==
Content-Type: multipart/mixed; boundary="===============7969560511899146576=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d5ad141af300bca1b89a93872abcbd02a684750d51c2dee4dc00bd6af81b4f3@mail.kernel.org>
In-Reply-To: <20260914222514.1635018-6-memxor@gmail.com>
References: <20260914222514.1635018-6-memxor@gmail.com>
Subject: Re: [PATCH bpf v4 05/11] selftests/bpf: Test early in-kernel CO-RE relocation
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 23:28:49 +0000 (UTC)

--===============7969560511899146576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb169..6fdeba6d7eaa9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -14,6 +14,133 @@
>
>  static char log[16 * 1024];
>
> +static int load_core_relo_insns(int btf_fd, struct bpf_insn *insns, int insn_cnt,
> +				struct bpf_func_info *funcs, int func_cnt,
> +				int enum_id, int access_str_off, int insn_idx,
> +				bool relocate)
> +{
> +	struct bpf_core_relo relo = {
> +		.insn_off = insn_idx * sizeof(struct bpf_insn),
> +		.type_id = enum_id,
> +		.access_str_off = access_str_off,
> +		.kind = BPF_CORE_ENUMVAL_VALUE,
> +	};

[ ... ]

> +	if (test__start_subtest("poisoned_subprog_terminator")) {
> +		prog_fd = load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog), funcs, 2,
> +					       enum_id, access_str_off, 2, false);
> +		if (!ASSERT_GE(prog_fd, 0, "control_load"))
> +			goto cleanup;
> +		close(prog_fd);
> +		prog_fd = load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog), funcs, 2,
> +					       enum_id, access_str_off, 2, true);
> +		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
> +			goto cleanup;
> +		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_load_log");

Does this assertion break bisectability through the series?

At this commit the relocation targets insn #2 (the BPF_EXIT_INSN()
terminating the main subprogram) and bpf_core_patch_insn() poisons it
unconditionally before any instruction-class check:

    if (res->poison) {
    poison:
            ...
            bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
            return 0;
    }

so insn #2 becomes BPF_JMP|BPF_CALL and check_subprogs() emits exactly
"last insn is not an exit or jmp\n".

The immediate child commit 5dff146808a8b ("bpf: Restrict CO-RE
poisoning to relocatable instructions") deletes that early poison block
and routes BPF_JMP-class targets through the new 'bad_insn' label:

    default:
    bad_insn:
            pr_warn("prog '%s': relo #%d: trying to relocate unrecognized insn #%d, ...");
            return -EINVAL;

After that commit the load fails inside bpf_check_core_relo() (before
add_subprogs()/check_subprogs() ever run), so the log contains "trying
to relocate unrecognized insn #2" and never "last insn is not an exit
or jmp". ASSERT_LT(prog_fd, 0) still passes, but ASSERT_HAS_SUBSTR()
fails, breaking test_progs -t core_reloc_raw/poisoned_subprog_terminator
at 5dff146808a8b. Only the commit after it, 332e04e138005
("selftests/bpf: Test CO-RE instruction poisoning restrictions"),
repoints the assertion at the new message.

Either the assertion update belongs in 5dff146808a8b (the commit that
changes the behaviour), or this subtest should be ordered after the
poisoning restriction so that no commit in the series leaves it failing.

Also, keying the test on which validation stage rejects the program
(check_subprogs()' message) rather than on the load being refused is
what makes it fragile. The ordering property this commit's parent fixes
is observable as 'poisoning a terminal exit is refused before subprogram
layout is trusted', and the exact stage that refuses it is an
implementation detail that changed two commits later.

> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34904671165
--===============7969560511899146576==--

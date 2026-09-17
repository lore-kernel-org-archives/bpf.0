Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C44D796D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648179; cv=none; b=qJ23hj5A024lJ/Ej0VosUeUhtvAQY5uHrS2mlkpIAhlzuMkGN+lzfNHMSeFyYb/tOgPLGUEoba8M5YNUPJdO+lsch3dQzjdUXufYltK9qm3uSUnrS59hRW0EA6cjurIXufi86F2OxFFf70cecpjRnbYyXqsz7m5VginQ+oqG1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648179; c=relaxed/simple;
	bh=Bw59oOc5MxBKZIjVbBVVPs3ksR2jQGo8oejPUkF/qGc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FCkFZLX0HJML8E6ATrDh3grW9fSYR/Oa7ltmNM84kyU+/cnI51oZTz5xBVvhH0f+pfuj3wbX9/7mQhfYJrTa8VixX4XjrCtx842pleYEAzfxxNh35J7CK82dFM/LBbzjJOErCszBZS6dDJgPe+NMTJEYyV4vA1LNSZfKFxjQXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntgdq1ue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntgdq1ue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BAD1F000FF;
	Thu, 17 Sep 2026 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648167;
	bh=sFTM71o1KENFRh9zUiGqaH8RbQ32i3z+xwKEjiy50CA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ntgdq1ueE/+LZuUAYZ5gMgH6hdt1nK8emCk/erdyq4LCOvQTKwJCKWKEiQ+33PwXM
	 tYy+BTo097WRp102FzWQDWDphKJsrqOf+GvW4XHEjbBaBzIu01VkRV42txsCYC1bnE
	 1v83UtLRbqScdydOIOYwpIJO/aoK9g8kdjvcd+oIAcLz2GYqECw/VY2C+7zYHrj1zT
	 +JdZJA8pYBjOd4ugcH6WC9T9sod0xMULazAG7eAAXt/xTr3ETREuo8z6MSTlJxiZEJ
	 KwiP7Tmm5VNRSoU+NpGAxZLaTEZP2oaVQLW4KE3sxm1LMqHOrj0CLr/nwKgcsKNzrF
	 /5rlFDjcZ0Dtg==
Content-Type: multipart/mixed; boundary="===============8727977847784917176=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a89192d1071a217efc2aefb6a1bc8625cf9aa241918f7486a111c9b1f12cfcf7@mail.kernel.org>
In-Reply-To: <20260917111127.3780880-7-memxor@gmail.com>
References: <20260917111127.3780880-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v6 06/10] bpf: Restrict CO-RE poisoning to relocatable instructions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 12:29:26 +0000 (UTC)

--===============8727977847784917176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index ee267289fd88e..10bda3ff80eb3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -124,7 +124,8 @@ static void test_early_core_relo(void)
>  					       enum_id, access_str_off, 2, true);
>  		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
>  			goto cleanup;
> -		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_load_log");
> +		ASSERT_HAS_SUBSTR(log, "trying to relocate unrecognized insn #2",
> +				  "poisoned_load_log");

Does this change lose regression coverage for the CO-RE ordering fix from
dd4db8b6b10cf?

The 'poisoned_subprog_terminator' subtest was added in 0c2f670921a11 to verify
that in-kernel CO-RE runs before check_subprogs(). The old assertion on "last
insn is not an exit or jmp" could only be produced by check_subprogs() running
after CO-RE poisoning, so it failed on a kernel with the old ordering.

After this patch, the relocation on the subprog's terminal BPF_EXIT_INSN()
is rejected inside bpf_check_core_relo() at the new 'bad_insn' label before
add_subprogs()/check_subprogs() ever run:

  default:
  bad_insn:
    pr_warn("prog '%s': relo #%d: trying to relocate unrecognized insn #%d, ...");
    return -EINVAL;

The new "trying to relocate unrecognized insn #2" message appears regardless of
where the relocation step sits relative to check_subprogs(). With dd4db8b
reverted, func_info_cnt = 2 still makes bpf_prepare_btf_info() run,
add_subprogs()/check_subprogs() pass on the unpoisoned stream, and
check_core_relo() then emits the identical message.

The subtest therefore passes on a kernel with or without the ordering fix, so
the per-subprogram array overrun that dd4db8b prevents is left with no
regression test in the series.

Should the subtest be renamed/repurposed to describe what it now checks
(relocation rejects an exit target reached via func_info), or would it be worth
exercising a still-poisonable form whose rejection depends on CO-RE running
before subprogram validation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35216153389
--===============8727977847784917176==--

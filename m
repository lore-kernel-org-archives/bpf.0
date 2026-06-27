Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD70149DF1;
	Sat, 27 Jun 2026 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782574485; cv=none; b=aT+5hLjO1h7BpflprMa3tTr/oAAyO1ecCCMom02gyWMTGT7kwfO+PaSMv6pNdox9tXIZaJW0SCPrQCAYgeLNSdoyr416IeCXidxXy0mcd2mKB/lE8MtwqYIsNRjrcTRJWgzXmRhlZhf15dgn7IBmrypaBy3cStN2yyt00/yu/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782574485; c=relaxed/simple;
	bh=u8//tIBdYgf7KdVvCnTdiBZV2bL4NQMDSX11gztLP4U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dumYSXPah/WhtkWkPW/AZAxhLRVthynRyFaXN/C/lMV1g+oSRchWBdGF275k9ESwju3bqrGFS68m1K2OtnXAkg/SwBifCyQGZjZ9Ftskp43xQAY6uT4fvJMBPr1o9AFCtJdHHaDvTy+rEeCSvEUMXWJGQokoEvgjegyTUakRBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROQeC3Z+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROQeC3Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3581F000E9;
	Sat, 27 Jun 2026 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782574483;
	bh=TeoHmMOiyv3XvPqLIjzqLzJytLAEogI3YechI0KC7Tc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ROQeC3Z+6YjsJfcSDRamT2rYeo3qO0rCeN8W3US+XoXwwUICI249u+QAaj9Rw/Lja
	 FAKigQGzw/ghH8xx7Or8hQVsVCcUH7GveGCfeNBnwqnF6e8JbG1hmSO1hy7rIYeQjn
	 hUzUkKuCIvhlXkb9hN8+Cq+aWFTjOPxen0tKlMzpeW8jOj4h7zfbH5yLiuVCAURt86
	 suzV5n6cT/dJw8dXW6JYLcxjQzqtcPDEXBuKRUxo07ISsAqlBTu8bM/DKRKqqDWlPw
	 2P0By4U15pL1iB5BPxnZw/f4dKSRZaxRCR/HCBd0+ATLRbITmhTQsy2yx1qhNtN1Iw
	 1QprmTsZshSlQ==
Content-Type: multipart/mixed; boundary="===============1749464434001039733=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <52ebd029529260691b55efc0e325cff6aa7f09d9a5a36c2d14484ef1791d54e4@mail.kernel.org>
In-Reply-To: <809bd2ae46a0505a1f8fdaeacb4e1db489bfa641.1782571533.git.xukuohai@huawei.com>
References: <809bd2ae46a0505a1f8fdaeacb4e1db489bfa641.1782571533.git.xukuohai@huawei.com>
Subject: Re: [RFC PATCH bpf-next 04/12] bpf: Create insn_array map for bpf SDT probe
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,eyal.birger@gmail.com,rongtao@cestc.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 27 Jun 2026 15:34:43 +0000 (UTC)

--===============1749464434001039733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 327c9d412fe8..3f8b12a1eb8b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -6686,6 +6692,131 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
>  	return err;
>  }
>
> +static int bpf_object__resolve_sdt_progs(struct bpf_object *obj)
> +{
> +	int i, j;
> +	struct bpf_light_subprog *sp;
> +
> +	for (i = 0; i < obj->sdt_entry_cnt; i++) {
> +		struct sdt_entry *e = &obj->sdt_entries[i];
> +		struct bpf_program *prog, *subprog;
> +
> +		prog = find_prog_by_sec_insn(obj, e->sec_idx, e->insn_idx);
> +		if (!prog) {
> +			pr_warn("sdt: probe '%s' at sec %u insn %llu not found in any program\n",
> +				e->name, (unsigned)e->sec_idx, (unsigned long long)e->insn_idx);
> +			return -EINVAL;
> +		}
> +
> +		/* resolve subprog probe in the main prog that absorbed the subprog */
> +		if (prog_is_subprog(obj, prog) && prog->absorbed_by != -1) {
> +			subprog = prog;
> +			prog = &obj->programs[prog->absorbed_by];

Can a subprog that holds an SDT probe be absorbed into more than one main
program?

bpf_object__relocate_calls() resets every subprog's sub_insn_off to 0
before relocating each main program, and bpf_object__reloc_code() then
appends a fresh copy of the subprog's code into every main program that
calls it.  In that case the same probe instruction ends up in several main
programs.

Here resolve only attributes the probe to a single program via
prog->absorbed_by, and create_sdt_maps below populates only that one
program's map.  Would the other main programs that also contain a copy of
the probe instruction end up with no entry in their SDT map, so the probe
is silently missing there?

[ ... ]

> @@ -7135,6 +7266,8 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>  			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
>  			if (err)
>  				return err;
> +			if (subprog->absorbed_by == -1)
> +				subprog->absorbed_by = main_prog - obj->programs;

Since absorbed_by is only set when it is still -1, it records the first
main program that absorbs the subprog.  Is that the reason later main
programs that also append a copy of the subprog do not get an SDT entry?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28292842584
--===============1749464434001039733==--

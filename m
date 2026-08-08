Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231135B137
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174822; cv=none; b=mY3ejq9emEEhjA1jeVUZFOu2lpJKXPQ0Jru0OWbQ8EHqV5Rv3rYknIvPjoCkafAqD4NFG1cQrJO2JHiEGk5lyjOIZW8w2ENVAFKYVrRPaBF/10bQlxNrUMfMVa6AcU7NNSilWN3/z0Ae4bSZ/k8lU10sVFI6MDgzFJqZBW/poS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174822; c=relaxed/simple;
	bh=zlHBRuhqqI8cpzzLHrcSanLOqFIHcS4i3b/6xrXliLU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CfC0fRfOmDYIyWO+WzW/Zj49Ji5I+NutlZlfYhg6DKhfDmHss0SMCorgDYFSiDeAwo6WPCRkH/Iz2+k/HFgzRmZIZS6nFnkqk5/hZ1Zt1jipIh9hIwvlFIUtPM9Ajtv0tHcrAp8VivweQyDJH5ew+vqYc4JOJsQ8aeHIPQmFQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y74mWH5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y74mWH5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA911F000E9;
	Sat,  8 Aug 2026 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786174818;
	bh=2inV/BVOppWMDflxXntJ4DXgSymrCToz7UIWNhAK+5o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y74mWH5kaJKO27tS9LyqiiA4PfiTXrmTZW9NLGKsdxEiShesXod/14LQlUySgjMZr
	 2hyh7ktu3hnba6+cJ7xJ0ScsZh15/tq3UN3m5CyY5UyNFFEw8ivZHPvAiR6KqIT4hi
	 WnY46VniUKvWwCu1S07WUF+ObQ+g28uwokRfrzFblez3xwl5SlnQkv6okkImWiM9Ke
	 PCMkr5Zn/cywOtIxfsAkPIWuUh9xdfT0Djm1U8tPs3gpC/Om2K2QPgR2Gcbl/OZit1
	 zyjKB/0IinVx6L+4cTYUowwX839eQ/2UgsO/+NzLqO8MqE93lvF+z/BROaGc+PTEyC
	 Ctv9p//8BIGIw==
Content-Type: multipart/mixed; boundary="===============0582643473399374897=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <effd4af12a0a3d5fe02023495163575df8e8ef3f61d4ab63e061c3d798312034@mail.kernel.org>
In-Reply-To: <20260808062601.1070988-3-memxor@gmail.com>
References: <20260808062601.1070988-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v7 2/6] bpf: Attribute async callback instructions to verification roots
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  8 Aug 2026 07:40:17 +0000 (UTC)

--===============0582643473399374897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 855f245e7468..9b76851dcf54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18762,6 +18762,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
>  	struct bpf_prog_aux *aux = env->prog->aux;
>  	struct bpf_func_info_aux *sub_aux;
>  	int i, ret, new_cnt;
> +	u32 insn_processed;
>
>  	if (!aux->func_info)
>  		return 0;
> @@ -18780,9 +18781,11 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
>  		if (!sub_aux->called || sub_aux->verified)
>  			continue;
>
> +		insn_processed = env->insn_processed;
>  		env->insn_idx = env->subprog_info[i].start;
>  		WARN_ON_ONCE(env->insn_idx == 0);
>  		ret = do_check_common(env, i);
> +		env->subprog_info[i].insns_total = env->insn_processed - insn_processed;

This isn't a bug, but looking at the parent commit 01220a5c1336
("bpf: Track verifier instruction stats for each subprogram"), it deleted
the insn_processed snapshot and delta assignment from both do_check_subprogs()
and do_check_main(), and now this patch adds them back with only the field
name changed (insn_processed to insns_total).

Could the parent patch have kept these lines (with the rename) rather than
deleting and restoring them across two commits?

>  		if (ret) {
>  			return ret;
>  		} else if (env->log.level & BPF_LOG_LEVEL) {

[ ... ]

> @@ -18809,10 +18812,12 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
>
>  static int do_check_main(struct bpf_verifier_env *env)
>  {
> +	u32 insn_processed = env->insn_processed;
>  	int ret;
>
>  	env->insn_idx = 0;
>  	ret = do_check_common(env, 0);
> +	env->subprog_info[0].insns_total = env->insn_processed - insn_processed;
>  	if (!ret)
>  		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
>  	return ret;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31244455347
--===============0582643473399374897==--

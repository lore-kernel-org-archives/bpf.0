Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5440C5A0;
	Mon, 18 May 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118858; cv=none; b=coO7amjel4UdEB9XFmk+reWAc2WMz+hXt9AEMeH+OPYl1J5VdMNuAVe8mzXk0YJO3BN/FjQTu6jQfzh21bMtxex0FEOKomQSURMKzk3zp6KJytOiTKwwWTASI7PufPLaX1C063Cv/96AsLSk8inPIc4RIp9lboDVDHz7JFtPAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118858; c=relaxed/simple;
	bh=u8md8HT2Dq71Voc6Vc+DFz8aOUEAC6/sdnzOlk05zvI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZylrmCA3AWQhXd71F0iDb850RMmtETjr3yGAtHGlvuIbXqbkamTcy4atZtO0XAPCq/ShTUL08tXzDPtcK7K0mwiVhahx/0pMavgZGnsbfeYPceZVklCeQerzeVfBku6S5cpR01NFNFlefo+e1EqSyIvpq0YGy4JsTmlyVBDwm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sld9qcYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sld9qcYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD16C2BCB8;
	Mon, 18 May 2026 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118858;
	bh=u8md8HT2Dq71Voc6Vc+DFz8aOUEAC6/sdnzOlk05zvI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Sld9qcYDJcHKUaoP416O0LkllHuLaCpikP0d7mKUHi+p2ac7cd/E2sJeAnGdkiLcF
	 jypLZ8NkbAeOm0Ko5/XU/vTHG+Hj5ai7JNqbInOkNLaWHXX3jpNZaaKojNhDf8Gn0l
	 Ri3i8culNKGekMBR8fpLWzZaLFKMSRDVNZwYiwFxavfbTvrZ5vCs3Eq5Epi3iPE6Zf
	 zOmsb4cMroFx9HwpeapuaQR709wwOA3q23Wzjo0ATfRIriPUh0CtWh+XnTm5DdldEa
	 1bppjMdlGwd3xoDbQobU+66+qhrrnw5xENs3vV2HKChzFjvbtsGPIa3rlsjYJOD1N1
	 Q3oYDJoznfQ5Q==
Content-Type: multipart/mixed; boundary="===============5902182535780880259=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18095298384649847dcbe0293f6b710a1382f9ee3eb9aa2bf8f6d02e56a1f0c4@mail.kernel.org>
In-Reply-To: <20260518145446.6794-3-leon.hwang@linux.dev>
References: <20260518145446.6794-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in map_create()
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 15:40:58 +0000 (UTC)

--===============5902182535780880259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 83de8fb9b9aa..322865a88b3a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1647,11 +1647,18 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_at
>
>  	/* preserve original error even if log finalization is successful */
>  	ret = bpf_log_attr_finalize(&attr_log, log);
> -	if (ret) {
> -		if (err >= 0)
> -			close_fd(err);
> +	if (ret && err < 0)
> +		/*
> +		 * Failed to finalize the log.
> +		 * Should not close_fd(err) here. Since the bpf_map_new_fd()
> +		 * has published the map fd, if a concurrent thread closes the
> +		 * fd, then opens new, unrelated file that receives the exact
> +		 * same fd number, close_fd(err) might inadvertently close the
> +		 * unrelated file.
> +		 * As a trade-off, override the err only when failed to finalize
> +		 * the log and failed to create map.
> +		 */
>  		err = ret;

In the v13 review thread, Alexei Starovoitov suggested moving
bpf_log_attr_finalize() earlier in the flow to eliminate the race
window entirely:

  "bot is correct. Let's avoid these races. Pls move
   bpf_log_attr_finalize() into map_create and do it before
   security_bpf_map_create."

  https://lore.kernel.org/bpf/CAADnVQ+XR3kyqizGgGhtG5xiBu3oK3O+COUMfPDQDBSJbm=56A@mail.gmail.com/

Does the current approach fully address the race concern? While removing
close_fd() prevents the specific file descriptor hijacking issue, the
suggestion was to finalize the log before security_bpf_map_create(),
which would avoid creating the race window in the first place.

Is there a reason why the log finalization cannot be moved earlier as
Alexei suggested?

>
>  	kfree(log);
>  	return err;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26042398224
--===============5902182535780880259==--

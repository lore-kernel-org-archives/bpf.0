Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE93299929;
	Tue, 23 Jun 2026 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198102; cv=none; b=IrPzQsHqsL2QZmSE2FHi767IrxSUKqzGyCBc45Y9ZWpmJGciXBQOKUC2u7MeRaVkdMI6jHr/7w3v+gU9cVwoNx93wNvmESQVHSRlEZv0zyCQDzzlCFq+5l5uFdkFfVX7zMxI0R6WkZm0Y0v/sIIipNDefvnUTFtOzDN0Mba4dQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198102; c=relaxed/simple;
	bh=i1G7hi4tSc8oeFcKEankYvkLkvvD0Ica9ViGXxUmFHY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EekhzMKL0Afc88Rqbt+2kJA6f2BZtr9OkseTDPO6+Gygf06/7UeoXtx/Qwis8XSNdWsGu00754Ka+8kEFWtPTPruZjbQoknUts4ZMabSismklivfE6FiN4vCytUCVWH7KplU5cxlff1Wr00PDfvcq5lMzAIgQ2FAiOJvjV+Jggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXSNBc7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXSNBc7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE111F000E9;
	Tue, 23 Jun 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198101;
	bh=6Bp+V4V6uXwT5iBStYAzo9/nlF4+JEwkkLFhf9we2pg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IXSNBc7DOdi5hS2RaRGJVD3B1jx4L2FyHrkBAhjNvmVqM9prYEtIV+L+W/a/DEeO8
	 ktN75DEJw5J28pboGAuPyPSpsJt3HKVwTB8sqQldMNlavQpJvBW8AkQT8ZsmKwHZYS
	 3oIAfDzMu+4XKLloM73PHF+faGjT+s0oNVp1v29r42aD4fXBglhODdF/iOFfmH380z
	 1F8mAkUH4Bgr0RIijxUtUEn5JHAUx+Vf3WmjOuAJrs+BGw83PcqQhy/YvEQpqkR8uN
	 lBzmhTz9KwgouutqH7sLNCVrUFU4U7MnBcimGjy9WKMEWPlrln2SpCI9TpvB+mwauW
	 1f/kWsGww2RPw==
Content-Type: multipart/mixed; boundary="===============2676016477562247553=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c2797dac0dc56bf183087ed97aed819d1184568d2249b11439ab542afa43b4a@mail.kernel.org>
In-Reply-To: <2f894647f56f71838fdddeb97a3e057ed35ea92e.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
References: <2f894647f56f71838fdddeb97a3e057ed35ea92e.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Reject offset refcount acquire arguments
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: chenyy23@mails.tsinghua.edu.cn,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,vmalik@redhat.com,leon.hwang@linux.dev,davemarchevsky@fb.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 07:01:41 +0000 (UTC)

--===============2676016477562247553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..f65eff28ecd2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12135,7 +12146,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>
>  		if (regno == meta->release_regno)
>  			arg_type |= OBJ_RELEASE;
> -		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
> +		ret = __check_func_arg_reg_off(env, reg, argno, arg_type,
> +					       btf_id_fixed_off_ok);

This isn't a bug, but does this call need to be split across two lines?
The line length limit is 100 characters, and it looks like it would fit
on a single line:

		ret = __check_func_arg_reg_off(env, reg, argno, arg_type, btf_id_fixed_off_ok);

>  		if (ret < 0)
>  			return ret;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28007209948
--===============2676016477562247553==--

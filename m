Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6A35E529
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251616; cv=none; b=eTlsQRSQs0djKQlHckI48AVO/2D6Ag6BK2Ng3NijENPH5Uy31P2UGGEKx7cbVhVgk/othjgtJ6jDB22JHAArzUiPwSqRM+rKJg/8/0jEJpKcb6P5qs3Wp/zfCubKJaQPJ8Vo8eYvP/eOIPY486v3Od9mnJIBYzyBngH88gJ7Ri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251616; c=relaxed/simple;
	bh=4BUCCzRPYNZ5TKyhOA2HJJ1H0SRvq8yGvE3Wjxz0D6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ol/7sMJsl+jJXQm1xa6fAckGh+Mb7EKBNbpYtBUNC9cQEXkcURam1Di8Hblb+Qw8XnWXupTVNIky5srNWNcLqOKa0mG4ukuWsy8xGkRlxTeZc7eigtdKv+qNK9VjNZS4IfyApME6xdeWHXYQQ1ywevBd+nN++kZI+5IEgh2iQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJeyOIRx; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJeyOIRx"
Message-ID: <cda18083-ad51-4f20-9aca-f01d6e17ea6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774251602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvZhmSWeHrMRbaAY1B61sJ5MhxCkaIVEfxRIAp8jjEM=;
	b=eJeyOIRx/VxAPZPhEKOkTlgOgPVSdO1rYoRv75UdyNgQm0C6qU5PSP8Ug8YYPP32P5mJ99
	VxWQnHDV7MaaxzHCeuvzzxluZIt6kCJ6DudVlIU2la8BGCwijtEAT48UZg8IWlrFvJYK9W
	aV6/d+hJ0x8rnilqUTcMjys/A1mMYi0=
Date: Mon, 23 Mar 2026 15:39:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: update outdated comment for refactored
 btf_check_kfunc_arg_match()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
 ratnadiraw@smu.edu.sg
References: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/21/26 6:56 PM, Kexin Sun wrote:
> The function btf_check_kfunc_arg_match() was refactored into
> check_kfunc_args() by commit 00b85860feb8 ("bpf: Rewrite kfunc
> argument handling").  Update the comment accordingly.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> ---
>   kernel/bpf/verifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb12ba020649..c0ecf02a1b78 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14410,7 +14410,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   		if (btf_type_is_ptr(t))
>   			mark_btf_func_reg_size(env, regno, sizeof(void *));
>   		else
> -			/* scalar. ensured by btf_check_kfunc_arg_match() */
> +			/* scalar. ensured by check_kfunc_args() */
>   			mark_btf_func_reg_size(env, regno, t->size);
>   	}
>   

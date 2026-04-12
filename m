Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074282D97B7
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775965220; cv=none; b=hV/er/8+FgOiF7nQuw5uZTXgL3RhioYfmzjKFRFnlgI3lQJ5ZDeO9bEIfbYaleIF7gxOjVCEQstXAT5XCDWGKjy6lVMDtnWPmgEzZZ07wcBkoDp1TnRTx+miByeUtSsKMgewggd6JvEMNMU6yL7Fp1w46zrcPrxNh/MB5arFhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775965220; c=relaxed/simple;
	bh=QTpRIWJBZbo5W+sP8qwmW5sjTJWB3isGCeUcOk8dHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fngu5k/pkrSvOwXoit6RNgGh0VYyNW6MQu3zPVSpXUpLPn5JW0URTbzpFUEzEP4jZpylOsydL+7JIJguWabffcij2FfqywX1LHTxka0n4WtdLwPgOcTatZuaSS5Oo6F78/QrDNiTUi2P8fOnUS6pzKU/2y5hIkg0WCY2bRKL+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U1SDXgw6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U1SDXgw6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775965206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAG0ABuE1sEGRvpt1epm3J9hCMO3p++8dKsbmS4IJFM=;
	b=U1SDXgw6DbvODJVvvWWjlWOCVvjN4LyH/538gr2L9aiGDihVp+tZvXfNg5C8gI2IK6L+HM
	qxtc491nDfKr7h7d/P2vOaCIt73JXT8yFm+rk25A5KEh1T5mVL/xAOD0CKYmOrFLqriLgJ
	K8s31QgpH+bhX7cG8PAY3Rqzb/203o8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, mattbobrowski@google.com, jiayuan.chen@linux.dev,
 leon.hwang@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Feng Yang <yangfeng@kylinos.cn>
Subject:
 Re: [PATCH v3 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in
 kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Sun, 12 Apr 2026 11:39:53 +0800
Message-ID: <4726660.LvFx2qVVIh@7950hx>
In-Reply-To: <20260411163556.8567-2-yangfeng59949@163.com>
References:
 <20260411163556.8567-1-yangfeng59949@163.com>
 <20260411163556.8567-2-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/12 00:35, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
[...]
>  
>  static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
>  {
> @@ -18416,8 +18522,13 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
>  			*range = retval_range(0, 0);
>  			break;
>  		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
>  			return false;
> +		case BPF_MODIFY_RETURN:
> +			if (!bpf_security_get_retval_range(env->prog, range))
> +				break;
> +			if (modify_return_get_retval_range(env->prog, range))
> +				return false;
> +			break;

return false by default, as what we did in the previous logic?

+		case BPF_MODIFY_RETURN:
+			if (!bpf_security_get_retval_range(env->prog, range))
+				break;
+			if (!modify_return_get_retval_range(env->prog, range))
+				break;
+			return false;

>  		case BPF_TRACE_ITER:
>  		default:
>  			break;
> @@ -25460,7 +25571,6 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>  	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
>  					  st_ops_desc->arg_info[member_idx].cnt);
>  }
> -#define SECURITY_PREFIX "security_"
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  
> 





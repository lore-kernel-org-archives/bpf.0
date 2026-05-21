Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7C385D6A;
	Thu, 21 May 2026 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336488; cv=none; b=Sm96sG3a+wtpQgbzIQcAoX2Ua/V8xZOLef4Sdf9zHj1SSVXZw6Sp8DgW33uW5nGjeeH/NjKEUPZ0TFQDkBc4VxxhM52u21xA8WuXUvOlA1y+EuhNI2noq6IEMKvoZhOSdoys1KGkZlTuNGlngKlsXb1ZKbyvID+DPDxyr/W1pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336488; c=relaxed/simple;
	bh=tWvDXSYZFaDH97EJ1cKD4ntvXbHySA0txrLy8cJTm5U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mshd8jiPzoPplFoQ6YM2UOIEcr3LUXwY8RvfQUv/iEX+8aadupJGrdXH2bo/sR71tDlSx+VvwH1B7bNCDgsDA3Z3/aqS8oLT0/1uC4pu5BJNuLcttkEDeKX0bHUFIvux4GAOKPOVzQHvjuP5pK/WiqzRhVhFsix7S625m3D2OLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tic+USRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tic+USRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300211F00A3B;
	Thu, 21 May 2026 04:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336487;
	bh=eQWoNj8AIg6neloKrZ5uxPZGxOnyIQcrCWjq1UZQu2g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Tic+USRH+dS/dhi7szSBn31GoaNpyUrP5XCZZeKIcAwb0aHIYchxR8T6eC/fTjZX7
	 ML7oMK9Sjwyr8TVfk87RUFKZ3bXiIzHryO2gX8X0xBKHcwY+8hvZhYm0J2B3XzwsEi
	 vKugbcfNKwxeBBLQztlmWKBHDI0C0/UQOMubRTv9QkzWGuE3IeOU/lbjlxh3yBv3xN
	 OZZrWHI5gIuSB+BQrYBGlgcMN8UXFTk5g59GVMKeXpROxDLtrpbstiwz4lfC36z2mY
	 lInD+sHfUQGyHTK+rUhQ625CounPe9oB9cKHVvVdmES4I/fVbLiIKCP97ZT/VzFsuy
	 TJ/1yc5c7gWzA==
Content-Type: multipart/mixed; boundary="===============6482725756755353255=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96cd744d0a5a8756cb0c1e31e95fbe682956b97226e2159120785feb01013e53@mail.kernel.org>
In-Reply-To: <20260521032306.97118-4-kaitao.cheng@linux.dev>
References: <20260521032306.97118-4-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v11 3/8] bpf: allow non-owning list-node args via __nonown_allowed
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 04:08:07 +0000 (UTC)

--===============6482725756755353255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..3a9db1108b95 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8dd79b735a69..f3cf8d85bea0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12244,6 +12249,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			return ret;
>  		break;
>  	case KF_ARG_PTR_TO_LIST_NODE:
> +		if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
> +		    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
> +			/* Allow bpf_list_front/back return value for
> +			 * __nonown_allowed list-node arguments.
> +			 */
> +			goto check_ok;
> +		}
>  		if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>  			verbose(env, "%s expected pointer to allocated object\n",
>  				reg_arg_name(env, argno));
>  @@ -12253,6 +12265,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			verbose(env, "allocated object must be referenced\n");
>  			return -EINVAL;
>  		}
> +check_ok:
>  		ret = process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
>  		if (ret < 0)
>  			return ret;

This isn't a bug, but the multi-line comment doesn't match the BPF
subsystem style. The BPF guide requires multi-line comments to have the
opening /* on its own line for files under kernel/bpf/. Should this be:

  /*
   * Allow bpf_list_front/back return value for
   * __nonown_allowed list-node arguments.
   */

Eduard Zingerman raised a related nit in v10 RESEND: the check
'!reg->ref_obj_id' appears redundant. Would type_is_non_owning_ref() be
sufficient here?

Reference: https://lore.kernel.org/bpf/0419643c9a04bf0824066742e52e3f197b43909b.camel@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015
--===============6482725756755353255==--

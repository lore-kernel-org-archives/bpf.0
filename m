Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D682192FA
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620156; cv=none; b=ccU8ZDmgwQ3wYyXXybIc7IdmpTtaUx2JP/1HdeJ9kGasYMo2MAHPsssKpyDOX4l2L5RZb11q6dEHvaFplsVHI7L02gwnoUt9xvJjN1w0An+aaDST07y1i0BEqLUB2ajv0HUL/41orIbRnVOOh/bEkPTd0WQXool10Vnfuw0Q3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620156; c=relaxed/simple;
	bh=OSY6rZG0/QO9sDv8kD3a3y5W/9FmXddazF0o22ynZtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pp/dbYZwjUQBw+eLVXIEJ6n7DAOsQPNMnglM7Y96cO0BzclGj951vPxYuE0aQtbgxb3aV3pnZdVTgZO0FDpGTf9jfelRine/Pl4UTNy5c3FBXuIGoe0C3xUXeXIoAaAHOR+NqPEwMM2n2sruo3PtfoXQIwjCeHX8cVk7A2KJyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjEJeoJ7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjEJeoJ7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36da8439078so1253082a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780620155; x=1781224955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f3SpmDbYrWpyoKhUy5m/62qcXsMlb7jumSKeT/JkD5A=;
        b=AjEJeoJ7PHEtWKAa7tBuF5/5my9QyWYQVhA+lJPVVINnumy7YWXV8ZIztnk/S1yFor
         rOti9TekvP5xFwa19VOqyV2CvSPWpfL9DnwOf+JntGpmP+2iSV+9TOH7W8JE05Qx9a8w
         aYY5qv7GExeVbasbqVhczigsuwtMbmqYYY0efnIllu8K67+gtde2LJ3jPvaO11/gXpsW
         oSzNvAwSuARqUISz+5Rfz6M//NpsXkLSolHujlqydlr4wPUG+VOva3VQvAwd/xSU3QDF
         Ux9h2CMj3qhVf53qunIv5MEQ3yPJCv3qTXELgkP16eaCtw+92ZJULQLt1C6g4OmpZiA7
         18hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780620155; x=1781224955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3SpmDbYrWpyoKhUy5m/62qcXsMlb7jumSKeT/JkD5A=;
        b=cFDtwgfEq+AUYldMK+dF+P//x61ToITEb5hQfXirp3LNSAw5FmlELYh8RRfRfjNnec
         gXY2qCuTq0wn1DcfC+v+HWL0UzfRmxAkOOPFTPMqDlLfKf7fmPDvoGvD5Ij7YmYvBBSg
         mVFVXNhBfeDzbibBcu5iUtVNH2fqPEv1Gzg6dHv6DnnWEOpKXYSnnIKKubfC6u4Hh0kz
         d9RqwtOLHJ/tF8vU1v9VYIJ/Cs2wJLDy85F6PUfyhaSDHiCetrm6bgmpDcEt/i5cXFrt
         Ef++Du0kgmF7Ic+bhgwj+fcMXuI/SsB2U6HynH4s6wravO01bR5d+qM26glvUezV1q/u
         P/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ8USzU+E/kKwpotrErZiW4PzpfFL9R51ZoJ45s0dfZAuZJD1LxzSFA10uhOAglpsPFm0V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5Hw0UZNSPLaku2j7ogIFyRWVfD4pj2L8t3OPOYYb3nobK77H
	r2cr5GTw7aoh+ciWyQ6HkseDs6teXhWsTAw3n2N2h+2F8RCVaxrO0tvY
X-Gm-Gg: Acq92OEboZ+UWPiJsRlFBjmjDd98Gqp5zGGd/MbGDODh7X+YE0Q6hf3fflPi0Q/2TGZ
	EuHGMXcSzt+OAnUvWG7PGG0Xf/JeGSS7HtZpFZ1o0ikisRYWzYEhK+w7EBHou2xarB0tZk2kyXU
	SrmZ8GOPr2h1JMkifs15sAZooZdwQYxfbEJRC5u9C5is7IYovYwPZkotH7EA9vQOh2UxhBHNC54
	/k30ytegsb65zXVpc98yrND7icbI3r2lYFXlTMv6PIqFnSklNKDHUOTzQZ3tBPoX+KCTU1frup0
	bGVgJUoeMSWZ8DxhNl8rKLqwVQr4hCbRyw4L8FQnBtALirzYJjPevVK19GkSmkC+Cz76YGy/Pdd
	F1szP53ll6qMO1tOs+q68iF4ZuyssQhvlGaderuZgOQ+HQEKvrwCn5z5FpQ0oJxc/qYhdfTgMys
	cjYrUgOPDzY2KSzP+KtdFjeM41qt+GAvCsq1nZ5XhS+vb65v2uECG6Pzi/E5cMFA==
X-Received: by 2002:a17:90a:d884:b0:36d:b680:3041 with SMTP id 98e67ed59e1d1-370ee82fb58mr1027232a91.4.1780620154594;
        Thu, 04 Jun 2026 17:42:34 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a285a1sm4645411a91.9.2026.06.04.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 17:42:34 -0700 (PDT)
Message-ID: <e0567d183ee76725d276318c385f0eb568f2b1ab.camel@gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: chenyuan_fl@163.com, yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, ihor.solodrai@linux.dev, 	jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, 	martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org
Date: Thu, 04 Jun 2026 17:42:31 -0700
In-Reply-To: <20260602093836.2632714-2-chenyuan_fl@163.com>
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
	 <20260602093836.2632714-1-chenyuan_fl@163.com>
	 <20260602093836.2632714-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-02 at 17:38 +0800, chenyuan_fl@163.com wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8dd79b735a69..55c74d064e4e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11916,9 +11916,22 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
> =C2=A0			continue;
> =C2=A0		}
>
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
> =C2=A0			continue;
>
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* list_push / rbtree_add kfuncs have implicit args
> +			 * (e.g. 'off' parameter) handled during verification
> +			 * in bpf_fixup_kfunc_call().=C2=A0 Don't flag them.
> +			 */
> +			if (is_bpf_list_push_kfunc(meta->func_id) ||
> +			=C2=A0=C2=A0=C2=A0 is_bpf_rbtree_add_kfunc(meta->func_id))

I took a second look at the verifier.c:bpf_fixup_kfunc_call() and it
appears it handles more functions with implicit args. The following
predicates are used there:
- is_bpf_obj_new_kfunc
- is_bpf_percpu_obj_new_kfunc
- is_bpf_obj_drop_kfunc
- is_bpf_percpu_obj_drop_kfunc
- is_bpf_refcount_acquire_kfunc
- is_bpf_list_push_kfunc
- is_bpf_rbtree_add_kfunc

Could you please extend this check?

> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatc=
h\n",
> +				reg_arg_name(env, argno));
> +			return -EFAULT;
> +		}
> +
> =C2=A0		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>
> =C2=A0		if (btf_type_is_scalar(t)) {

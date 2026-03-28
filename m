Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0085C4A
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707579; cv=none; b=nxOaYwG5rjrrQQQFvgxslJHjFFHVHp5jUKX8HyVnt0jnr0FW43R7C5VsWosqRgBZIZyCHJ0cnFGXP2hkjK/TCPc/t81+MfkWGlnJbQ9xwYX9LF9FJt8Yn7ob1qanREsZUUweh3Sycp6dk7O4ArYpm0vxK/OPfV3fRBKY+7bxPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707579; c=relaxed/simple;
	bh=KhgHCyFR9No8KLt+OlnuwwLQyFERX2PwG/liMhvnIdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIRbaKsyCNDgLo8B0TgBMiO08gj6XaDQPXyLrflZj8p8TBaJUoifVzIOGjVhRO5Pz3vR2xcbGlL3pRlNr8fOj8eQbkioFXltPa26tq5nlC0nqIB3232LRXq0iiGdxZYUzYe2API1Bzm/QmK0Zzerf5SBXmeif4frHWZlwkkpP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnsAysks; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnsAysks"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fb112c09so30722745e9.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774707576; x=1775312376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw/qYDuL6NOAyizpknGIl9vSf0/5ZM/wdACWWsJgXx4=;
        b=VnsAysksyG7vSAzlRvyofGlEvllhHas3/EQv+SZxst2sm6UJsPMyL255Dnd2Aat0HU
         t5A+xoLdAWC3JSf4Bez5AGNLkbmrRZFdJfV+F8uYVg9n1g5MnOFDatVV+QTmIfOTf5AV
         Ot91PqBfEdQcvE6TxNg63XdcvLIut9CJOqTUOwPhOO9MNxVar8VY0ncRmu7hM6I6CuGH
         m7cmpuie6wPfqoUUFqHBQszsjbDCNLnYJkHsUtxJecl17r/U0esEgG6Z6BVZ9LmV0+tn
         8bj/DwdAlzzEPHSBU81MgnzmvsQpQV3OW3KeuCIqjJdESm5nuLCOwDO+fBAqdpy2Voe2
         UKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774707576; x=1775312376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw/qYDuL6NOAyizpknGIl9vSf0/5ZM/wdACWWsJgXx4=;
        b=XNlX3cVaulXhZr9G8GVOzS0KUmRh3Gls5sP1ZOSDixt3X4q90BnHbm5+Drdl2Cb0P7
         sJY8yDlMx2/aIB10BLdILq+DiRpSckuF3sBVUvDCkAFfGBZgou8bLYqPBRJYZoWsMotR
         2SgcLtMmD77xE7JLHsR9x8DzxgW89AnKPA7EuZrGIShwVyOmW8LkuTCYOzS0up8vwsBh
         gcKC55Jc7CN7E5Sz5LR0uZDqCvlvtUq3Krzo1Ury/qXb7oAknUcCk1m67WCIQ60aHiq8
         IVOFyFFnHiDl0j2ujEG/Tof3fT1jtL5TmVpQaKQv4MDZBOdEYtvIqeM6r8VzGDu4hEGS
         rjyA==
X-Forwarded-Encrypted: i=1; AJvYcCV9P6yqguAagrt89ZGC3WBFHnvYS25PCKpYKGGPI+YPdj5/kRIORVTKITn8via95GKXF3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjXRlO6rD1akAXG9cgiCKB+ii2y9DtAXAU6kjgWXZtsFr7bAU
	vO3N8rDtoihweDbcVdMJ9/+t3kgTIWV0vXfr5T3zcVBqILMlNwqTScwaGmpIDcMR
X-Gm-Gg: ATEYQzw67AUnZe201/CcBx802Mf+ip5M30aEvcC13E6PqyQdCsOq+NQjS8JHM2RtasG
	sXtH9S+L7S3XUzMRuloWLjhPvQ9ldO8Xfwc0C3rli79gzIRStaeU2hG5dOiUweYwdsYsP0y3dht
	z92hh7L7UOceBgrH6jo5VlqOrYqZpLUiL58ShwCxfIsp4u5JA2uu6jmWIjbZBJsJYF8yHtYlJn/
	Hb759ZrnsWTGSfGK0mOsrOD3xD5d0NEJMwy9eLJpe8myxE1Sp3GW49Uwuz3q6mkV6KI3gkbO2af
	5Q1dEwWjDkiQQS9jJlJPXvPS9kaTxrzMtrYURzIqTjftr1udQ6YPXQQEtGc+XUzM+adWBGpd53E
	I/SZjgIZenQL5WVT6GaZXCCEo6nnYqmeAlPuhieHwLjShGwrvwuDMTomYvlwfzSGj9qmOI93C2L
	6G2vSQN+c1hxbs
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4872807483cmr106801495e9.25.1774707575925;
        Sat, 28 Mar 2026 07:19:35 -0700 (PDT)
Received: from krava ([2a01:e0a:1057:8840:999:a3d5:618e:57b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d38a5fsm149954545e9.12.2026.03.28.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:19:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 28 Mar 2026 15:19:33 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
Message-ID: <acfjdVLdrXQb6Uzf@krava>
References: <20260327203241.3365046-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327203241.3365046-1-ihor.solodrai@linux.dev>

On Fri, Mar 27, 2026 at 01:32:40PM -0700, Ihor Solodrai wrote:
> The following kfuncs currently accept void *meta__ign argument:
>   * bpf_obj_new_impl
>   * bpf_obj_drop_impl
>   * bpf_percpu_obj_new_impl
>   * bpf_percpu_obj_drop_impl
>   * bpf_refcount_acquire_impl
>   * bpf_list_push_back_impl
>   * bpf_list_push_front_impl
>   * bpf_rbtree_add_impl
> 
> The __ign suffix is an indicator for the verifier to skip the argument
> in check_kfunc_args(). Then, in fixup_kfunc_call() the verifier may
> set the value of this argument to struct btf_struct_meta *
> kptr_struct_meta from insn_aux_data.
> 
> BPF programs must pass a dummy NULL value when calling these kfuncs.
> 
> Additionally, the list and rbtree _impl kfuncs also accept an implicit
> u64 argument, which doesn't require __ign suffix because it's a
> scalar, and BPF programs explicitly pass 0.
> 
> Add new kfuncs with KF_IMPLICIT_ARGS [1], that correspond to each
> _impl kfunc accepting meta__ign. The existing _impl kfuncs remain
> unchanged for backwards compatibility.
> 
> To support this, add "btf_struct_meta" to the list of recognized
> implicit argument types in resolve_btfids.
> 
> Implement is_kfunc_arg_implicit() in the verifier, that determines
> implicit args by inspecting both a non-_impl BTF prototype of the
> kfunc.
> 
> Update the special_kfunc_list in the verifier and relevant checks to
> support both the old _impl and the new KF_IMPLICIT_ARGS variants of
> btf_struct_meta users.
> 
> [1] https://lore.kernel.org/bpf/20260120222638.3976562-1-ihor.solodrai@linux.dev/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

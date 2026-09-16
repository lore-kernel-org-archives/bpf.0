Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB64B95CD
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589129; cv=pass; b=ZcQflAnOh6GvoB+MiLK0EtLNeDdkpX4JY9BIQTNbg1ZeCN4giAnn7qww+Iozx9yEKsZnFlUaIK7vLnfXBDVtsthihBzjUFyDwsNDCne2PnyBaWjweJkvdwrzlIOM60g2qKziLnIbTssPMKmkvUq29d+heIlHfZ+0EYAMghXpaGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589129; c=relaxed/simple;
	bh=nMB7wGaTb6Lmz3EsCvpm7S4h9QbnRIQzNW/w5zSRlbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOMkllwcS2KIXQ2dxszp6cGz31fWu7A5gfK4AIPkLXJUnDunj+x8q7Cjx1lCE87L5MJEOg5Cnb8pdzSoo//swix5RQR0uiBekrJaGvi+ghNd283jzNO4JNaPzX+YqcxdiDt9UkjRK4bc6bpevtJAJPpMvzBtCUbVSLuRE1cFxiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNNzSOCc; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNNzSOCc"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4be07e7c54dso21749b6e.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 13:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789589121; cv=none;
        d=google.com; s=arc-20260327;
        b=rVG52/hrXfYMeyju74REsHV1ZPaBa99e7WbOt9qc7dshZiVp6FxivMWRgwnDkOdroL
         7xyf+btvz4xd2/vPIwNhcO8+JzE0JQZiRDyFc56OmVzTgpKEVBJd7xcQDBeVUUUWtdlC
         JpL/M6/09Ir6Mb1aOPpVS+85LQg0R+tA9Lr6KzJF7fGHkI68BQJEAKR0q4xbWBTN98Kd
         mFmTTJCefrdoATa2AXV7ylrdSrZKynxPdiKtU1DfZoAHunE+Y3WFUUsHRNF4PnwytjsK
         6ekLtjmTq+IAv19UTlNJaxJXlDVVJT906YxatHrqQcCxvQdavvYAmA808dzI8Fx7gX/V
         cv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMB7wGaTb6Lmz3EsCvpm7S4h9QbnRIQzNW/w5zSRlbY=;
        fh=B5cyw1yRIFuY1K+xO+VoEqAhNWQz2KjO7/ov3WrCuBU=;
        b=lIndYM4a01jjrtd//3BeYWVHWX8zTRIIVsuKUIX8yaG1Hoydm4wlXoTeGHPsQsFZjd
         DopZvUM9FaWw7heuEFfZWbT4iQ+h16rPof6XtNUCWiA9uaKe5k3J8lchVQykan3vHmwz
         ++wdNAcRPOq8Vj+ps+6tcIqucCUUa++SFIFaX2TMhW2CX68SEjgQruHojmhXtWuNVRKi
         BB+bgqvmw6KRpvv8Wwfjs4adGQtF4T1Rqj0euKzbfYzlCjllugVR1EW6RjCsKXuC4Oii
         o3yrL0LOCLcuTnz7oUY7ufHiKtn4sejUr6k/jDZEIG2otSGCWHqCMF4mDModzd3/sqNN
         Zbvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789589121; x=1790193921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMB7wGaTb6Lmz3EsCvpm7S4h9QbnRIQzNW/w5zSRlbY=;
        b=tNNzSOCc38LGS9Je4cHqOZ+cE0R9UnwZbrufMPpo/8mpmOBy+xSHKygLJ1VwDOHWym
         7yPFKrvQ/x9i0ITfQu/UND/HlG3fMoZdzZhuU2T0qF51VAL5XrJ5yHP1W6J8tudIZCFE
         GldVsRCE95kiPeSnJz2WdVCX1wxn+eE09k/GjMhab5DsMqfN4WshenbK6lTerakMrUVe
         5xQNUvEsb+JppQgiyFK9AGY+YBTd1GbZr8kwimK7uHhMGZvogQt6l832FiXiPIGztFC2
         ur6824+PhMo7HWKlW3zl/OSVtqb707BuvJLSIQkyhAyQ/Ugb+n9+olCmliov9NCFd+83
         0NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789589121; x=1790193921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMB7wGaTb6Lmz3EsCvpm7S4h9QbnRIQzNW/w5zSRlbY=;
        b=ZSVxu6/lZYy7gKbcv/QfE9rwE3YgGbBrzLDPGG32eIW/GpJJIVNprm5bPEa9VXT5D4
         0q47kISKdi+T5eBHZEN3n3rIamR40avZxPr3zFtW9amt0muvOEk5che7MkE0bzX7ss7l
         71AqR8duwor5xgDl0Sx8TKqoyNuxKy448EpreSiSsIosJTJLts8YpCjdLju8VCbJuzOr
         syulB5EYe4be+jhZJjODogaMDPCulRmfno6u3eOTYxFdRPdcYZsaF1fFmpjP5O5kl+1F
         jq/1BMp58m8ZFERvK676P9BMRoTpJ1Xtf7OFKW7uNX4f++a3+8tbsaM84OaGCoYRTaAU
         N5Kw==
X-Gm-Message-State: AFuF++mqmNGRFSapZfIJDWK5BLVUPMV0fonFz7ZTlaGvTWL6wGT8ELcT
	pf180WZK1CIzJr+TUGKe6RkHfVSQAZb/gj31mC0VDaELk6p/a5Hz2XHYcO85RpvxhputQkAqxBs
	6a6uiSlR2zW1LRTllUW9tKCuXHa168+7cmA==
X-Gm-Gg: AYBFou1ho543srFCedA7HaNwQcgqau+zT4D+qYNgpbSEA5NNMQUVy8/6mO/mv9fPzte
	ztW2WlgO85DqGceDVNKN3DHrqxB8Voms9QMZj1VV83Iqa5k9Kso8wHc0Rg+O31BU6X2l07RLzsr
	4OlUGk39GvIMaVRSlNHfOapmcOq8bc20Z+4/XAfkw720/BAiK9U0U8ayYbO8Or5je33dmcf0YTT
	0hf0zREKLM873Bob8nSTEGrvUmesPa+tIoJN4xf0s8sHfHQWhXX+ezfdjcrOBdJmL6LkIT0IsEC
	ZME9rd0ealCpimyfHImHv627l3knMQFlXyoZy0CzOquEN6GiKeMzVXrdYetyrd2naw==
X-Received: by 2002:a05:6808:5087:b0:4b8:4703:db8b with SMTP id
 5614622812f47-4cb69b976f2mr728625b6e.20.1789589121552; Wed, 16 Sep 2026
 13:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916192805.3991983-1-memxor@gmail.com> <20260916192805.3991983-4-memxor@gmail.com>
In-Reply-To: <20260916192805.3991983-4-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 13:05:10 -0700
X-Gm-Features: AcwNN1WvljfLn0XOapZCccAjJFT_yOot9S_SXNCHkQl_VMPr8KaSPrW3a6TjU0Q
Message-ID: <CAMB2axNA1PAC83-ZRae_-2EOAMGCu+m78YGXdvtBF9fBQzdD1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: Cover generic __uninit
 output initialization
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:28=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Exercise the struct and sized-buffer cases where stack liveness poisons a=
n
> output before a kfunc call. Check that the verifier accepts these outputs
> and that the kfunc initializes the memory read after the call.
>
> Verify that an uninitialized input aliasing an output is still rejected
> without CAP_PERFMON or CAP_SYS_ADMIN. Include an initialized alias as a
> positive control, using an int-width store so its value is independent of
> endianness.
>
> Use __prepare_priv to resolve the test module's BTF before dropping to
> CAP_BPF and CAP_NET_ADMIN for program loading. Keep multiple-output and
> argument-slot coverage separate from these immediate regression tests.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

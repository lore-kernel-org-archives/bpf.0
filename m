Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7C3A7836
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218648; cv=none; b=TbJqdM9wHpOE/iiBYaTaQW2kpLKkkUNP+57dviuEmwC8n7Jzw4cqziL8wy6tps/IbvGdl4Gjrd/ny/wobDLo7WFsJyUDVriw2cY46v9cSROXbChvUtHvJucI0QYTU2N0rfZJfWNOC97Lh+DqA5m2pUOUXU6BvLkdBAQUK1HPLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218648; c=relaxed/simple;
	bh=68zDchBKPMib11nIJoXpaXKcFoYMUB6hIg0N6pNxCqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/PsNuOKcc0hbWWZWqawLfwA99eXXMvqaOWSwv5uC31KCUlq5fh+fOqg+iKrRpzyv4lCNJWBy7yiCN63BfHh8KEf8zyrKHlCBGssTyIkVwsFPLExPYCDFbsSuvY92jPVlx6UkRtTMyl2YmxwqTY0np+kmJNBweMDBb6hH7Zr7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buStiTv8; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buStiTv8"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdbdbc6b46so1647288eec.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772218647; x=1772823447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1onBLalRCI8jNdPSkUZEvwvG7pfaVrg/ZGPL22YmyrY=;
        b=buStiTv84VA3ZChDvI+ZIxvCcuHFg8vgRUvz01IckN8X8MlAnMvMRclCJjVuKUR4af
         B491rM73M8KIC/eKmnmoVdzE/gXqYqYqnx9Z4fvy+iwl7ylCePg/xWZFimuQ2raWMtnj
         UFsfqUdjEA86WIL0QcRJwblfVgyCDyWz+NkL2TC2qPbEl1C5GgL9RLygO7+K00k7RiH+
         b3wuM5+4C+CK37Ib4O5lcL9skS6vk9S5yenu4egA115rvbg5a0hrHMPCSAgF7OhAZxlD
         OCiMTpGGKym/SwKXkNmxpYTXMv7vkDxrHhFD2wuX47W8M8rXV/4MK+5XG/FbD731C9+x
         n7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772218647; x=1772823447;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1onBLalRCI8jNdPSkUZEvwvG7pfaVrg/ZGPL22YmyrY=;
        b=qgEdxu1s6CMKq8QbM9xCxtXgXBSDfx/SuZlUh0Sfu9zUDkd/r+8Wlu1FD1pY6ju981
         w73eyjLyLtft/dQrMAqknjsQlKK6DV/gq5xIDgM76wtvhrVMUhej+wOq95LL7V0YrUPm
         6uMqImrBHmNJfsDIWvBCnYNtIE3mdjsickU2fkgRag9b5DuGFQXPqV74LDO7JAkzmSql
         7ZythOio5Q6+XgQvdEKRa4LnQp+5xPP8wggEdzqPfY2b0BMTnaIdh91sSk61rEUx+YY0
         2eGVTsSpQBgkcHah6dt1o20GTLbqcrfbP/cQf6Rps3g2tZ6SUOC6iIQGg6jv1aigQf5I
         yV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdGnXO0YUMgCvPXt6jzw+cfBO7sfUMz/4k6J94sCn7Oj3U9SjL1k2C0uNmYQ4RdpUArJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Z2EbcHjqbJfZs+QgKEvO3QjJqtcHLoa2XcZnvB4EasJPkpyb
	8hmdaFTYWrd0oiejPUiLxSZBRJFE8TiVySX7UDTAKc/UTioxmjAoXE8e
X-Gm-Gg: ATEYQzxqj2DSLJbM8E223V/m6eHVk042jsAYqMlva6GZXXySprLfPT6MSDuZCjwSMFB
	2psXqlNP/HvhZAv+nxyN1cMwkWbzQiGIWIn6E9QbOszN0RL0aagXgj0AN++Jt/4PyjXDi+AJHzd
	+GLdG28Uf19HIaIPu39bOl//tltydjLusIuYVcVrGKD+Vu4FfC7DX5YKSl9Muqg7c9URSVB/GO6
	YL6Cq293f1nXL6+qKaX/6TDGah5Gr//FUVxt4Y825U8jsFTATUS/wpLylEn+KN8e8Lz/mSpuqpt
	sJvkvnRiOtqitlz+rFffqZ4QFpDMuwu0C+DhFcIiqwgyQ0YD2K0lX+quKAUWwfiMI5BdJNHwZcG
	KLmFsBae7IXwvmZhfetZo/SZVJEyJsbyYX2d2EcGUYHfMYESeDETgNaSGxK1run/aqUaDwbrLBT
	2OakCh6U9NTQOrk4M92ZmF2CrJoweplZHlTVapkyUkWnGDIzpU+EJVImc4kqyVOGvPb5/laiB1R
	LISPASi
X-Received: by 2002:a05:693c:2b16:b0:2b7:4f83:9a84 with SMTP id 5a478bee46e88-2bdd104f8c5mr2376744eec.17.1772218646492;
        Fri, 27 Feb 2026 10:57:26 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dacf:39ea:b35b:a26e? ([2620:10d:c090:500::1:1089])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm5068122eec.9.2026.02.27.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:57:26 -0800 (PST)
Message-ID: <b37f70d205a6d0f25c4665fa34f6700b6eb4a5fa.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Factor out program return value
 calculation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Fri, 27 Feb 2026 10:57:24 -0800
In-Reply-To: <20260227154616.6846-2-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
	 <20260227154616.6846-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-27 at 10:46 -0500, Emil Tsalapatis wrote:
> Factor the return value range calculation logic in check_return_code
> out of the function in preparation for separating the return value
> validation logic for BPF_EXIT and bpf_throw().
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name)

[...]

> -	case BPF_PROG_TYPE_TRACING:
> -		switch (env->prog->expected_attach_type) {
> -		case BPF_TRACE_FENTRY:
> -		case BPF_TRACE_FEXIT:
> -		case BPF_TRACE_FSESSION:
> -			range =3D retval_range(0, 0);
> -			break;
> -		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
> -			return 0;
> -		case BPF_TRACE_ITER:
> -			break;
> -		default:
> -			return -ENOTSUPP;
> -		}
> -		break;

As Emil points out, this -ENOTSUPP is a bit of an outlier and this
patch drops it. I double-checked the bpf_check_attach_target() and it
covers all the cases above, with default being:

	bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
	...
	default:
		if (!prog_extension)
			return -EINVAL;
		fallthrough;

So, this -ENOTSUPP seem to be a dead branch and it is fine to drop it.
Emil, did you have the same reasoning?

[...]

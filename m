Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDE40D586
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781222910; cv=none; b=SZ72SrCBqfiZXrK0ewYwzxHqze3FyeBmL6dDGY3swnpqxuyzz/xnv+6o3Jbid35byA79eFNtFg6KWjpvJ4Ms4n4uSgxFs1Fbr+/nEMk4dd08fnxFgwyHk4mzKO+yOyjFuwCiiKz0b5dmggRo5OO0Q4UFrERNI3v9l8v4SPFIukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781222910; c=relaxed/simple;
	bh=CdX8Qwb4P1o/hcHptjiAg9CZgwE1KcXgvFcvzc961dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtp0/g5oq8EYbzVTMDssL2CH0IzfjFPLkGCynUv1FLLFQTunbPK7QCPWTxzyTePgiUqbUuALtd4xzmwrya4vdTp8cwYGpITE9I5OphNxPfmg+Zh6ZGDSGmii4x1UV05nC21q/sen3PyFpuW0olP/cvVPElcbrwqAv8FZnaUYX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQYdYFyl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQYdYFyl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51761d27612so3839691cf.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781222908; x=1781827708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKG4KW6S/RXhkFtQLuUCBdwnT8PSZQpyI8y4jFz+S04=;
        b=IQYdYFyl5haIjJPowgCvMDhVmGhtOlKqPrIZwLERV+tl6jHyj6ISRn57hCkZTTpLzs
         JzLps3HqWFoOAr2raldq8vDOgdAE5Kq5VvjYqsmNKJV6OPfYgQ781t7tclzV4LB6gCQW
         kLPlEaMUon4Mmg7AlbmECD2tvq51cCpQtznOYNnmD70zH4AxA1JYDfQk3JNYPmX4q1SE
         P6ADQudmVeMRITf+sSgHlbBnfjyyiwyfvbicNFD9ak16OjZxTxZ3cJbxVcG/iPRWwexU
         7lDd4el6GkSzywOJSC76M7VGV5bNSNOy5EtwErIPUDDwZdYOkQq3NOvguXeI/ouSB7FF
         vC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781222908; x=1781827708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKG4KW6S/RXhkFtQLuUCBdwnT8PSZQpyI8y4jFz+S04=;
        b=M7Aj4sxjs9UJGJpUVEmTnT1ovTH4RXzYlmxZKBg4BhdROrc9YmunquweUIoz7Uwivy
         /DFQOqbKCuHDGZ20ICWyXKMVxCt1EvqX6Vhf+UZ08IsQFywSONlny8jNjz6e9VIMu7xD
         R6zGdUNU0GQyLGghsZma1J4JhGu1+lpry93/+0xpavwtoUwWh5irOZWGWlwd6es+BD7r
         EXLhsqB9fyK6YG10IVPw9rWCN9d4qituA5hw/I5YKxtQ7P0ismrqWLPTF6Y1zrnGbNGZ
         0MjYVMgSPl2VWTZ5ZP6+ZYK9/yVME/NxHliL1oD68SrK6fAp5ZvfRXSFz+89FOBoV5o/
         P+Xw==
X-Forwarded-Encrypted: i=1; AFNElJ/ruw/flASDvqx5D9VQ4VloxalLH7tntrwBmjI/w1dTSICnYW0JjCLM79J81TLyPY9t4u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+bHRfwDXe8tFEvcthTzXR+m8ZfcrnR0jyldXxSQb4btuUxbY
	/4sjpZ9aq73wBl+ABKRJWgpx5s4r1AFtLqvyeBIJJBisqwL/TwrF+0si
X-Gm-Gg: Acq92OHL5fI5kThzzakpbpQ/5REsuT/Pr3GdFoi6lrVgQe+R/zg/5hObhB5WwfxXUjp
	NylwrIiYf5IQsvD9xM3V6RKJTjJZDIZ42XZoPYt/R9XA/VvyF/geA1DqFin0RScliCrbW2qbEEZ
	wGJ94uJtx7Fi6GowQBY2Pd+QJmIeO1/XGW1e5S5Dsvyo8cfawHW7da/iUrSlwWmZHu1Ta9oRR+2
	aXt/IsAqnD3aqOHpJWgLUjvvbizBZe969NeXBmxEXQFGz03EZvKyvWgZJovjylBzWYt6v4EUXDo
	onHj7A57iRRYpGvQd8Vvaizpam1bTr2sfbj5FAtNwQJHpomRn/CWDMabn79hSwmXYCmVdLPCiKn
	hoAxq3+n0SBvoTGh9L21zyqy9wSW8Ozqyunyjr2PdD5TE7ALOeioF5Zo8v0lMBh8OO/6WuhjOHp
	/aHvPELwQwNA9QO7B1r70xPYIHwBUnkUXOILey+Klif8M1UA0honcP0inhl4LOj4oiE01+fL2aN
	x9VyCDwsb5jbcxG6BFmQj9sGg==
X-Received: by 2002:a05:622a:8c1b:b0:517:c65c:3dba with SMTP id d75a77b69052e-517fe5edd81mr5583751cf.38.1781222908419;
        Thu, 11 Jun 2026 17:08:28 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79df4dsm6590911cf.15.2026.06.11.17.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 17:08:27 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: alex.roberts109@outlook.com,
	Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	David Windsor <dwindsor@gmail.com>
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
Date: Thu, 11 Jun 2026 20:08:25 -0400
Message-ID: <20260612000825.105100-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 01:59:10PM -0500, Alex Roberts wrote:
> +static int loadpin_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
> +				  struct bpf_token *token, bool is_kernel)
> +{
> +	int res = 0;
> +	struct file *exe_file = NULL;
> +	struct mm_struct *mm = current->mm;
> +
> +	if (is_kernel || !mm)
> +		return 0;
> +
> +	exe_file = get_mm_exe_file(mm);
> +	if (!exe_file)
> +		return 0;
> +
> +	res = loadpin_check(exe_file, READING_EBPF);

Why are we checking current here? IIUC this will be whoever calls
bpf(2), which would be the loader, which would then be able to load bpf
programs from an untrusted source.

In the kmod case loadpin_check() sees the .ko itself.

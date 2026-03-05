Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3B21ABC9
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712214; cv=none; b=V9f0J/pOLfJ3JG0pqkNIFnAJs5PAbeFDqErfjzALVfUO40tHWIY8BzSC+ucdIYm8TfO5qB9GTWG8AbXMjxTrxjELlN6wah3RYlQIO66Hz/7xoMXivJNbdruoR2HZCYInl5hkJbukd0Z8Gh6azEc3i1Dx2RjlVPxWCjhuuXtCWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712214; c=relaxed/simple;
	bh=5xXJdrq+JHTqFz3pgWRme1Carfh6+VV+H5yJyk09Ji4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao0Yshhh+TbAqI7hk5P+1Od70Ylukk2H3nBt3RKoC7/xpyoPe3vgpCd8JmglwIcnnjhL2b4+6SygewmK2YDE5caszMLscaFpBS9e7+orVTMwaYtLZU3S4pFnOplQyhE8ULkW8FkHw5tXSaOAnkpUAIgSsbbXDy5Hgl4TdGFYxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpSI9+hg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpSI9+hg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48069a48629so83636565e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 04:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772712211; x=1773317011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ViLytCis3QAh1nOSVLwwv8YvKJ8zDgH0kIwki+5sccs=;
        b=cpSI9+hgTLh4o+0zOru0DWQDgvgENhM82h6WP/v+rpCg598+KPkz9gXEQ3E01gvSRv
         55fmgevecNfFxPptbah9P7gKV08/Ehi6pcWNL6dVQTWWbGK8MiiXo5Nmx1NaULH1Xlm2
         KENsotcTyPC11QPlRXO44P0xD6fNHC6nsN1gIsJPTAQuduTqdJ5aL7X4HOJH5o+FpP7g
         nd7x8KZ5ZDRtXLq2Ka2hPatd3UmLEqMFoOS5RJc33HEkdVBgLZr0kXpzA6rhfnvPhrio
         o5TMfG4tJ/PTmvfST5Zj9x2+AkHwJRkfIpvazRpgLwThUpI2bfie7yTGqvl8RVWu0YHp
         Ze7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772712211; x=1773317011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViLytCis3QAh1nOSVLwwv8YvKJ8zDgH0kIwki+5sccs=;
        b=if4/zfqYZGTDghbcUc7UrRy2Q82OXp3kzQdQlOI/GFfY/Z/eIJb/mXzZFrDLeeDub8
         ByQ9WNKamnPDYrmECCTz6rI4uhFBe9BCbA4HvRcdhauqYlwEUPKNLwgRMQfkU3SaLIpp
         6S8nnMYqny/KBQLI5KxXLBMjP7WXM5l4rnmHq3u3jLgVQY9NDpXg7tm428SVLQ2XsLti
         +PYd3x/ZAZNQBis6gJ/p38zMQh5ra8wRrToyLiphQUirT2RNETh+CDWsozQeaxq7z2tq
         OGoXtpwdpErP0jFyZcNk8ET34JtRkAlYa9dCVLygQoqg2eSgpDTmni883z2RllXDh6/s
         MtIw==
X-Forwarded-Encrypted: i=1; AJvYcCXMODqGVRwY8IwjiC0aoS5uYd+rnSSGksrmwXqAO0x4RSYLvns8XW9LoGTkuTlyf9j3J/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOG18H7UkIJFZKeGg5NbG9OBCMnzPh7fYQg+8ytVKVojUhSJAx
	g0B71kFReL9WpJqhPr1fLkB68mk8Nm8unbxdfJnIxfCCxgP6Q4NGESmg
X-Gm-Gg: ATEYQzx5MOwcgKVWEV9ONdJ9v6mHT/B4+fREkBA5XzxFz2eDDeHt5O3c9EipvRHiJRL
	YsiZ7tkOLCoEuHmX85F/q/XpIR8L/Ooi3yCqaY0z/ELQiL0UeJgxf9TsdnUeCKQJAp2/Evhyblv
	5RGKlqKifGuNP17FrDOwBbcGsG3DcyPLizrL6cODn6PzsABf5VFya21F4rKhEN+wD6jRMVFnXPb
	ZWZYfuBjrEvyC+/+DFvrkwzn0UuF1303266N+IDu3v21d8oBaSQ/8na8VIKnwxSg2Ob3ycoTFiw
	D/U1aiRzG1C9PotJHy14b8K2GY/zFeIhG/S34l1NsjMIiSmIHuCEi0BkBY9Sx7By/RxI66dj8Ja
	/KUW0RUUP/SEtf5ZUkkvWL4M2HrVfqljIHWIUbLCLg1qlfx3s3jV+k0oYor4j1F4hZRLHmmltDF
	pvov9ZbAqb3SrbL6BdHYnx2pav5A1Z0YbmCMk74TW6nnmi+OojpOxdIGk8tPSy8oGIsn34rsal4
	GTGim85Nin/dxhGtTbfi7HGQjiD2bD87AhiO/OgCQPtYND4QMwhQwQiJMnSPnDCk/Y2TjhqR+k=
X-Received: by 2002:a05:600c:3b99:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4851983121emr92217845e9.6.1772712211332;
        Thu, 05 Mar 2026 04:03:31 -0800 (PST)
Received: from Tunnel (2a01cb09b0519f200bb44bd7cf65ea8d.ipv6.abo.wanadoo.fr. [2a01:cb09:b051:9f20:bb4:4bd7:cf65:ea8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb277e3sm37309745e9.10.2026.03.05.04.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:03:30 -0800 (PST)
Date: Thu, 5 Mar 2026 13:03:28 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vitaly Chikunov <vt@altlinux.org>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf v3] resolve_btfids: Fix linker flags detection
Message-ID: <aalxEFnPAF5U1Y3h@Tunnel>
References: <20260305014730.3123382-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305014730.3123382-1-ihor.solodrai@linux.dev>

On Wed, Mar 04, 2026 at 05:47:30PM -0800, Ihor Solodrai wrote:
> The "|| echo -lzstd" default makes zstd an unconditional link
> dependency of resolve_btfids. On systems where libzstd-dev is not
> installed and pkg-config fails, the linker fails:
> 
>   ld: cannot find -lzstd: No such file or directory
> 
> libzstd is a transitive dependency of libelf, so the -lzstd flag is
> strictly necessary only for static builds [1].
> 
> Remove ZSTD_LIBS variable, and instead set LIBELF_LIBS depending on
> whether the build is static or not. Use $(HOSTPKG_CONFIG) as primary
> source of the flags list.
> 
> Also add a default value for HOSTPKG_CONFIG in case it's not built via
> the toplevel Makefile. Pass it from selftests/bpf too.
> 
> [1] https://lore.kernel.org/bpf/4ff82800-2daa-4b9f-95a9-6f512859ee70@linux.dev/
> 
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Reported-by: Vitaly Chikunov <vt@altlinux.org>
> Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
> Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Paul Chaignon <paul.chaignon@gmail.com>

[...]


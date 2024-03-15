Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3050263
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525570; cv=none; b=twMB2rjH0RsNYmkebur5qmJkqgiGNb5KISWXky8SNwr/m2WU345YV7v0KOJeYIdoJydT67eogQWaPqQAayP7t2GrEgsP6GncrVzg/Up0/s/15e/OCvmnpIV1L0jchb1Kbq07P4HVlORi0dr7JaHINcWm3Mi2MB5esCvQI+tdY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525570; c=relaxed/simple;
	bh=T/8xfkv/Dh0VPAJHUakaljNkwpJLHBIuYF8spzI5GWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOsPo3ncn1IDjc/gUfJlYHEu1hTrOqIOWPUUjHGmawx5o1ppUtIJ/HXCryUt8j1ojwcyb7x3lAHjTIx4DejplT+3fG9jReIDyMLZIY85QSlAPh9s+W1tSRBGOY8mkQEL79VOvvOerSJYlOLvsspnfYrHcQdtT0E4o57UYBiDeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lS64Ax0O; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lS64Ax0O"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6fce696dfso728542b3a.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710525568; x=1711130368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqhShgYSHEfh1hALj4K3Q176sTTihLvAH/49Q9OSGWY=;
        b=lS64Ax0OA19bf4ou1on9/QrEH/8docwKqA5yXdj7dD/Q983CqgNBSDXdxbBCxpo7Uh
         me0plaxRiqvrcz4njivQXvw/uadhpWsxetS//Oc2Q/6lIo7cglkci4q9cDY7K8xDhv1A
         4B2V0RyYgjxgOG5DT3QHqRqGQuLnzVaOlVXWGebriyfxkwnxDiftxbNr4WbVdIIMV4qo
         Zuj6wa8VGSbCNwCrcGeILVjgQnFDGyeV2IC35dI9VA4PpRQnHzkBsUWCaBuzMBKpGm3a
         8kDNd8NWfWdM5+iYDJ2000V2NnrTxg70JAdy4fFuevv3eaKWnRzeTgEwgDsoIapKdLhL
         T9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710525568; x=1711130368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqhShgYSHEfh1hALj4K3Q176sTTihLvAH/49Q9OSGWY=;
        b=hgELwgO5OoSXFhLgN+vf9qZnJ2x6vbs4GVPqE2HcplfX7y59c/OB4Fpqar0M3vyLwc
         K9e2KcY/uj47/LQxS1jR+6kIHWatQu9uSVt0R4dUxY3HdfZmXYlNDXpIbxTdsGTKdpEL
         CbCiXOVwydn4tUgUnnLPHHjwM1NoAB9dDLThSAoJkyi7oiMto3XbM61z417ZqSVsYQBc
         BbwgkKQFQcrba8DSlqbXkAeiLp1WaGI+VNJe0pCxdHGP03m76WLFKMfJa3iYrso8zIN3
         /LFvGRaiZuK/bg0we93/SYxqGMpacTW6xCoVkeHg5cvGzFrSsEu7Zg031zBdImIg1rIC
         ZuXg==
X-Gm-Message-State: AOJu0Yye0oHVA6HOGWrDS8fGIlBsGKsPFJ5tdEuMwotXxAUez1jAbz4a
	k4hAWUjbodAJ7np68NedRIOmZZ28jcVTHXviSwVYZTrsRT8zMy4ocobbRG9/YGyyEQ==
X-Google-Smtp-Source: AGHT+IHHMs/eVxLHESpd24o244nq6Y4EmxbbhAy3iGzv0V4u8To/CmlESw40rAsu3tQ50BhJZmQnyTA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:22c8:b0:6e6:450c:c9e5 with SMTP id
 f8-20020a056a0022c800b006e6450cc9e5mr241207pfj.1.1710525568379; Fri, 15 Mar
 2024 10:59:28 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:59:26 -0700
In-Reply-To: <20240315021834.62988-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com> <20240315021834.62988-2-alexei.starovoitov@gmail.com>
Message-ID: <ZfSMft5k3NMrTqlK@google.com>
Subject: Re: [PATCH bpf 1/4] bpf: Clarify bpf_arena comments.
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="utf-8"

On 03/14, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Clarify two bpf_arena comments, use existing SZ_4G #define,
> improve page_cnt check.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/arena.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 86571e760dd6..343c3456c8dd 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -38,7 +38,7 @@
>  
>  /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
>  #define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)

Unrelated nit, maybe worth doing the following as well:

#define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)

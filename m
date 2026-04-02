Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E43F7E6D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148054; cv=pass; b=ZuSA3rN4BpDfPAJJq8lCEd9fFy+MGrQl1RQx/abp7RU/TGC1kPQ/JYapfnR1lzsQPb+YdO8Pw6tkufsPzA9VxYmc+lE0ZH3hHx9C5k/KDA6xZeVv4X9KrPZXBMiLK+Swcd7U4CmfXrG4PLCP8j6YrA9bFUUJbrYXeXdN9PC9mJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148054; c=relaxed/simple;
	bh=EBFZnp4MAEZ8TpI6Q2vCYA5RF13X98gCt9PrlFtY9R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF6yVVzu7lQLsRxrjwIxqZg61qtJRby1ec9CxBfnazsQ0aZoSilbzy8xK2JhxskKIk1Ns+qrObvNuONP+JS8eQFLGiSGCmiUSRk8P78hVs2TMvomf43wIZ6AMFtIrXkXT3FLQEwtxzg2jKmB4z2mv93qcFakRhuyf0CjzphvXn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvBAEea4; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvBAEea4"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48891776099so10833585e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 09:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775148046; cv=none;
        d=google.com; s=arc-20240605;
        b=Mei5+CguI4zlNcj5kNsVH6FguWeJDq4xZpviNCVRK30gIv0y+ypiPLb+5F0cIX3u3G
         2yiWYaFw+j+Q7rWe+KhLUylYj41ZFUDSLHvpzG9TvCywSXuLG74e+00lRdttwgFBnCc4
         hi0p3YByPRsW5z08V1oKaqX89kjOW383dRaZiwnUe2aYe1KaJGNBEvvmzCTn+vUM0VZW
         O2aDKQU137Z6nq8vdjuzFXvNWA8fWWPAOrzbLLghgFM7Le/rWUjtCuSbpF+PUzIqcDzm
         uayoy+b3iaFk4n3/qXHUgxNiSXugUd1l4JO8+zVtNaXD1aFs5k/2ZNmYqS9/X1upYRbX
         1JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EBFZnp4MAEZ8TpI6Q2vCYA5RF13X98gCt9PrlFtY9R0=;
        fh=XzeAIvAs8CJ81Zhm+bmRkVHuyW271D8C9obIs0MKlpQ=;
        b=SPJHjaAxiPMHROKaAwp7IbrJV34eBbpeREU8VpgG1LykUqQGSudkJ+wo0AwbuFTfwV
         EkCQmTBXrh7GLH6JgErdilm1smLWfDCwn+8b60gzCKIM61BQd6gtxDZ1fy2MlOr51cCV
         oJ4jA/bOicbsI7fYqPEc3Eg5WUhhaW3K9Q3GJ+4ilX6p4nd6g4OQwLujUcdfCdXtP8om
         hrZNn+JFmrZgZK7OOILCWjTf+wKMYeEheRDzwEThkdEXpu0rMixqzx+lygS1V9h5AJov
         NlihofyUNLNzmE+vl/ZGmPHAMoJnOOYadnSFLByJYCdPLYgaaPceQaWvWYCwcut+kmLG
         MQAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775148046; x=1775752846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EBFZnp4MAEZ8TpI6Q2vCYA5RF13X98gCt9PrlFtY9R0=;
        b=OvBAEea4UlRQMIbkA4znlgMNDLlzJ2fXTyStqj0IKFKbF7XjztQdZT6u3V5Y42mK/4
         z6tloY+FTNzqm7YqEyb8tXpsT2RCLyBKxqjylms+nxejTa3dUk8UHPYR/BYpEftf9xGA
         ATTbplh9sUZ8s9s1G0A+rp9TjhJCh28Tgt/veyGeldTgOeFlunYXw1dn/OqeWhNYBDQM
         JSLMD5/5nQ3OyWtycZQGxkODj9h9D4bDTYxznzp7LRYNCed9AFAo3YGKZWEdqjsLT/wk
         aqM6oqUztl/1qPAVPPuGAXBurwXJPD30i8sIkmHPjRgvn9GGlx3kpQ4TE5SmwTQLPRCf
         63Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775148046; x=1775752846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBFZnp4MAEZ8TpI6Q2vCYA5RF13X98gCt9PrlFtY9R0=;
        b=bJcZTNH/y2nMbu0vcPAzDNU+sCS6l9CqK7fhq5/YRUwy3k6GgCoi2iy9DrTGBZazhT
         gh8VQ5BxV2/VHF+AhvGr0uX1UY8adLXEXaIpAj9aFIunsexP7XhPHiH+WhVFf+RWSj8n
         +lHU3stBuV6BCo69p7PVTVyYk6hETQLNibEx8pt3dSxm7W/StWmImOxGdPgxqPF6VjkM
         aOCJK680x4CU84/EAGUa0MGQogPGnTBM+X5UGaqT7jhlluybvZNq3iw8aiFdcM4mDy0O
         Shxl0egNRU0OquLFur6tSC3TgXzLPBtGgAAPf7cDtSzsxx9JtLjToUBi34KhyU7RQf4S
         cLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD75MxHJ/1ODVrJ6rrtNV/Ln94pir4ko6RqLFzFLdCPPfWQj2WZNsxeR+SKy3Z29Nv4I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVnkxgzMHi8Hy046vOImlfP7l6sTxBxJqMgKRdRMewJ2TfQ+J
	TlwUsa3Iw1wsFoq9/2hNMLFnbHeuoc33348g3Wha2GG9Z62NyIAwWJ60CMoFR61HpD/dBojc74q
	cpaLlrv1mmtO6C/Ke9gXzaUBYHo00g8MKUhW2aOg=
X-Gm-Gg: ATEYQzxKUtQvw9MCOOMppc/IkxfsX3S2VyihGnUNPyw+jRCpVQl4oGaxjn9pIjtuiQr
	bVE7YEhS0KI5ZVHpQ9uY+k1PbSTpWZR0GiH4NsH5ETgGaeeoUHfyp9CmNQv59GFLXJcXpIda1DB
	gtpLFqbpSib9o/6+FaBAwfn0Nr+1KMrWhTJzlB02CK4Q2eD++50wZy0VLewcTlyYz4VRZtSKN2O
	VF13vI72NrVF9ldVopY1EDMcqSD0MZdy/LKU2QIz/z+eiMZ4TL5ur+lzZ08AkerNofjBqfJu+QN
	Mf/BzvAarw57PBuEHy4Vat6XuUzGx3vNhTh3ua9X8TGYMnObg2AEukh7O6k=
X-Received: by 2002:a05:600c:c08a:b0:485:33ad:3c9f with SMTP id
 5b1f17b1804b1-4888b79a446mr54875665e9.25.1775148045700; Thu, 02 Apr 2026
 09:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092923.38357-1-tpluszz77@gmail.com> <20260402092923.38357-2-tpluszz77@gmail.com>
In-Reply-To: <20260402092923.38357-2-tpluszz77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Apr 2026 18:40:09 +0200
X-Gm-Features: AQROBzARpXQeXtwrQ9kkuj8uW_11qCxtNeihH-uUMjDfjD7TW76pumy8MDTRlhc
Message-ID: <CAP01T74mqKE79-1x3giJgOQtSHM17T6-NP=jXdD4UoyvCUeHAA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: reject direct access to nullable
 PTR_TO_BUF pointers
To: Qi Tang <tpluszz77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 11:41, Qi Tang <tpluszz77@gmail.com> wrote:
>
> check_mem_access() matches PTR_TO_BUF via base_type() which strips
> PTR_MAYBE_NULL, allowing direct dereference without a null check.
>
> Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
> On stop callbacks these are NULL, causing a kernel NULL dereference.
>
> Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
> existing PTR_TO_BTF_ID pattern.
>
> Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
>

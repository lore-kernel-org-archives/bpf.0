Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EA130E50
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642737; cv=none; b=WLaPo9RUkK0ZQTIYkkN03aqoc9N3yO42z4DnCgxsa1JNFuB5J4VrcMUSvpG0lia9QN/zaTUikW/2Yic72/CnziDFagan6WKvTFz198Jpq8cmcivdPXq1siHE9EchKQIZU2uaBWtW6bttbwvM+KHqxVMUvWeARdntNkBxnP18xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642737; c=relaxed/simple;
	bh=GBsn4xh0VH3bSK4OltJrohHyGLgnl+zZmaIezM4iDdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jz+r5Gral+cwYJ7ksW9fn8vZAK8Odc8sViIWbTsFu9uePxpb7w9o8++DMO0zCMJ6KoT7MFebnlQsXOqShikvfRs5F4vgNigdX88I92QfA0EXPELg9zVK98iFwNPOz5VNvxWLQxT8epvXkT1KtE6kFl8BYakXUOA9uCBJYGsgyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0r/vY99k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0r/vY99k"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so1667199276.3
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711642734; x=1712247534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=umIDKJbLUeVjB30WBmxntoX4c0W2blxouvOQBNQgTYQ=;
        b=0r/vY99kXoMzxkp4WPFgKJ0GDP+V8Gwm+QmvZ+Fc9oyjqDd5/gHMIjMRlRhtHIY10D
         WVDAlKUYiZWlKgYN67wG3236TFGcol02GKfz0/4C0dUcq25hVT4GJk+RFoGPsmFBSGLt
         KK5rOj1yqtH7/2QFgvAuwJf9X7QMZfYvkLZCGs9c0u7h4hbhxSh2VlLzdXGYrn02EEkX
         ix7r9HQCoNchwR6mXhKkBziU3ubyXuEMouTDkkeOH63kgPA5AdHsK3YdXechPbqHEP6c
         Q169M/2uYfBbNUDkJSEkiMvdeXyImB4UCpnzJwl7joD4KsmkbKeuJfvTjdEZDeyhE9pd
         2fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642734; x=1712247534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umIDKJbLUeVjB30WBmxntoX4c0W2blxouvOQBNQgTYQ=;
        b=w3+ARUqZtiW794uLRCpj4TYalZf/G97/ldFj0ZUVIF33hVd83UyQM60BmCXI2XHvQ+
         KOS0ss9QKqWmHxYAIeCmu6oy/OoKMUjRsOwhM6SenjrcdH7YmS7sq9QxoZne5FmBy+eN
         eExvAvv2QW3KynAAGBDEaQka1t0bE3tcP/RSsp9r5snT3KqLnzrzHG+xpij7skMGxUI+
         yQZmnHf+iZMZGDrwIO/5XiB/hEBGAMrysSpnTpCGkPgIytgtvIRM7cNuB+jgmGfn0It+
         ewW/xKZp0SidmuPPI5q9ipLe0kVf2IKOByhnbShMGC6HT/lvN/raTrlmiH9q3a2HdKHl
         nXlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVhBkcVjZviGUqPzeokZjQn2U1yo3nlSvxzg0Uz95ODeNiFjCgU5DHgn4b/Y7dJBsUECZauQ8/yuW23g/flPATx9Xn
X-Gm-Message-State: AOJu0YyJeSqjwOf/OxY0+QviHqcxCBVi3gYFhOd4H4RskPTJ/VipCP6I
	Sb0au8tYFPDuRfiLQSfPrHKEkNcH9RuzZwlkNO0caRpGC2PXJXJ0GU/h6i9w8C9hCwJ76H+sRUA
	FZYROrg==
X-Google-Smtp-Source: AGHT+IG3wG69Xu1UOnAeobYYfeZbnbL1W7AO1OICQ5yW749ORUJQcN09ufbTLMPe/kI+kz+CtqMiH5GZrRAU
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1b13])
 (user=gthelen job=sendgmr) by 2002:a05:6902:2292:b0:ddd:7581:1234 with SMTP
 id dn18-20020a056902229200b00ddd75811234mr194893ybb.11.1711642734480; Thu, 28
 Mar 2024 09:18:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:18:52 -0700
In-Reply-To: <20240328110103.28734-1-ncopa@alpinelinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328110103.28734-1-ncopa@alpinelinux.org>
Message-ID: <xr93zfuifhxv.fsf@gthelen-cloudtop.c.googlers.com>
Subject: Re: [PATCH] tools/resolve_btfids: fix build with musl libc
From: Greg Thelen <gthelen@google.com>
To: Natanael Copa <ncopa@alpinelinux.org>, bpf@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>, stable@vger.kernel.org, 
	Viktor Malik <vmalik@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-kernel@vger.kernel.org, Khazhy Kumykov <khazhy@chromium.org>, 
	Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Natanael Copa <ncopa@alpinelinux.org> wrote:

> Include the header that defines u32.

> Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with  
> types from btf_ids.h")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218647

Tested-by: Greg Thelen <gthelen@google.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
> This fixes build of 6.6.23 and 6.1.83 kernels for Alpine Linux, which
> uses musl libc. I assume that GNU libc indirecly pulls in linux/types.h.

>   tools/include/linux/btf_ids.h | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 72535f00572f..72ea363d434d 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>   #ifndef _LINUX_BTF_IDS_H
>   #define _LINUX_BTF_IDS_H

> +#include <linux/types.h> /* for u32 */
> +
>   struct btf_id_set {
>   	u32 cnt;
>   	u32 ids[];

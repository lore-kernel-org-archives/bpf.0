Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5B21CA13
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758062; cv=pass; b=QWqf9FEW87Ffyi+ahJJyvlQ+7/i4V6IunQA0Cfua5j0w7RAaU90RFYyxtvYXflqtC1O0f+gBybH4FcpD/mouoGSmpXw/nrTDvqPzs+wWb0b5d6hRZaDNNhOnZiYd+fux9xofkmMvXdmniCuh/9tY1lpv05CGIAPyjSvY5kyZ/lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758062; c=relaxed/simple;
	bh=UJZ12x9GiVv/K2vWGadcerZQQaLPYPRDZhTmIJ8jXQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7ljOImJ9LVONH/vNLOaHf3Al6IRByhivGJ1EHrYlXcEB1P+sNg0uWyjsyqTv1S4pavk4sT6UKK3vb+EwPL+kMJp/L2cQYJuDz4k9HrdDahUBhNn9U7mmUWwUpJf940/I7lubjM/i2UeJ1LkEIHwX847yWD5O+mUjI8tJ+fwWT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZasK4PNz; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZasK4PNz"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b7c2788dso3590363f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772758060; cv=none;
        d=google.com; s=arc-20240605;
        b=jqL1cALkhgn+HNhaKc/HVTjk7BB8FALY1seezDEWQWNiUgCEESzlFaizbTbrZBboSq
         eKv0sNhTtqu4tcJqgxT/zakkcpe7PgGa+1WPilrvWZiTRAYI3ISXXaIl6D0CMsCumYhU
         9E8+ZGxDbe9e28MXZN8NjsqF2vhAqLFgC4f0Yxkz0LKAgIsXGMzQswNTZHqzM+GXCAjq
         8y/AIUzfaLR8AIVk6TjFaa1YLGD0yLzVzNumk/NwVi2mcXX6cYx6kJbY8cBcI335t/Qd
         BOSafI614SgNYAmWlpQjQU0R85M0hwdFUjxeF13sqEQAqyAWYUdayc6e1WocQPCHYW4L
         8q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lagd7MB1KvufeUD4xhoUK3YGUYLuUQaZ4KqBVowVLoA=;
        fh=uFSsqlRfHZ+Xa/WsUPincSXau8vU6SEPiTLGpk9XeSM=;
        b=h2FBuv1PTopsz+FfKjbpyboSmOcfwvzAwpsg5GbK7F9eXblvbJYcQAPYYeYdKQgMLN
         PvYZ5p/6Bx5RQbUYmok7yoGxy5jH2ptFMEDyeBLaMzyOlvNLYII5NFej2naxK8QGKY+U
         ZOmXDEyNrtk8aWg24yeafxsKIWWUYYw5Sf9CpeW4zzE8S/BEuLB1OR3KhwbdFjjJ1Iwt
         iAQbCk/itZVVQj9G1+H+ryUCu+S2tm+Hmrinu2vr8lcuqh2wi63gKPwnibqcRFV9tmBA
         OayvewB1zr6mFZnhc8wFgMx5WT3dpkme/NTh+BusyhdTpiMy4Z4iQeVJQPFT6H62Kez8
         nvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772758060; x=1773362860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lagd7MB1KvufeUD4xhoUK3YGUYLuUQaZ4KqBVowVLoA=;
        b=ZasK4PNzkbObL5sMJYmRsgdbjrodHIUjX4DWhvv4lOsqrDEnHxS6cxsx/3Len413Ys
         Hd/CFY9hKMP4bv7ZVcrEKNSsaNKqfVuPv8keA32HfvgoOPOWYmy3nVH170Je1QKHDJR+
         7qpIAgPhuVaX4JMnDo4kUxTWF/O+HrTxWTwhMrD27ACBkEmvH/X5yfEyF+o2TgCRjyaP
         xRghEpBr+i8XhmGaz0kNUlfpbeq/ePdPM1QJq1sTuGILQhJztU2x2g9GBt3AJ5jjlj7C
         642GsUn+e7gMnYBUq8cGQdhCyzU0miBJutgdzpgtU1dp2SdTd4uvyDtKgAxsEcTo8tsI
         +7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758060; x=1773362860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lagd7MB1KvufeUD4xhoUK3YGUYLuUQaZ4KqBVowVLoA=;
        b=bgaYPlQ5d8Czw2T66ZI4v/jRnlKbJMO1Me2JXKt6La669+rd1dh86hRX2ViQLQVO1q
         3AIDrUZIvUa+4dwgOHP/B6e0Sm6fqNKzr7B1gsmbzlJ2gGdNEkGIiaVlAQi4DPlYPUBg
         kUozuzlyvBmevfyABS7oW2f/d4yzQOo5pEreRf099V4Vv+XseuJyKGyRleuBs0twUAzO
         QNuRkmADuA7uQlywb8NRhGH7uDwXgBzwm44Z3F474i/3IlhAKd7e6JF6BggnSfjPj1DT
         k/Q8zQYtC2/StdJqCe4CPke593mI8yThvneByCMyPZBxaDMjwgfbUGoOqF/aHapo0gXh
         eOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXQrd/TuNrFGzJSvFKJcYSTY7wMiYN0AIpL7w8pLTZSzJAdgzxKcAHOm/q5hwIuSXmjfa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBk8T5JGS9aWxXUtU8tv9g82YkvgOFKNPSLRnq8rFjpiwyxuP
	HTCiHaPhA1yNlhwHmvMGd8SKSKGF4MKurnRpEWCZxUnDh4rL8tsGfeQAnZS3lbrXS2n3WP2vL4J
	xsIibGp8NI8/pgqzM5a89draQ1bBru9Y=
X-Gm-Gg: ATEYQzwjqRvZGqN4rXhdrtN2eOx8E5/0xew2881YbVOxwjR0d8EuQA0yEfvNEKekmQ0
	mA0FduLf1MJoVRvDoXeHoI4eS6156MVrUo8/sW4Uf26rNMthiQjWW/HC9ztqaR1PzKCpD3g7iM0
	gfCbBCYEUlI+NY/7kKOmFdGZmCc2fW5IAdpuYFeURK+PzZCOrYuGQkvB28uAxTo24c93pfRIabg
	rR8z4jHokVXlaLPsw8yBRaVpWiYdoxOEuNFp97U2hs2QeGC/OXlxV7QUR/kCep4Mt+rqdq0kmSa
	/jxBOJBfGJv2pxRCjfpp129QGWYpSR1rQ8vSbEZ3Isy6BpWIc2LYn8eBamQ=
X-Received: by 2002:a05:6000:2913:b0:439:af0e:57a8 with SMTP id
 ffacd0b85a97d-439da669bcdmr391532f8f.33.1772758059440; Thu, 05 Mar 2026
 16:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304143459.78059-4-pilgrimtao@gmail.com> <39625108dc3e179cd05df6e35a9e83717b1066376ab0f1aa868ced89abf1d677@mail.kernel.org>
In-Reply-To: <39625108dc3e179cd05df6e35a9e83717b1066376ab0f1aa868ced89abf1d677@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 01:47:03 +0100
X-Gm-Features: AaiRm52K2SnCCvu3F1bjHCaR6zL_rvQ-CHHGfyb4rF8Vhl8qRhUMghDts9u1PFw
Message-ID: <CAP01T77d-qS7xTUbNf=dtyi5458DR4cmG6s9u2pbmSOdEYocww@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] bpf: Add bpf_list_is_edge/empty kfuncs
To: bot+bpf-ci@kernel.org
Cc: pilgrimtao@gmail.com, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 16:34, <bot+bpf-ci@kernel.org> wrote:
>
> > Add three kfuncs for BPF linked list queries:
> > - bpf_list_node_is_edge(head, node, is_first): true if node is the first
> >   (when is_first is true) or the last (when is_first is false) in the list.
> > - bpf_list_empty(head): true if the list has no entries.
>
> The commit message says "three kfuncs" but the description lists two
> and the patch adds two (bpf_list_node_is_edge and bpf_list_empty).
> It looks like this is a leftover from v5 where there were three
> separate functions (bpf_list_is_first, bpf_list_is_last,
> bpf_list_empty) before they were consolidated into two. Should this
> say "two kfuncs"?
>

I have no idea why you decided to combine this, there isn't any
indication in the changelog, but it looked fine in previous versions.
It pairs well with bpf_list_{first,last}. I would prefer going with
separate kfuncs (is_first, is_last). Please also don't skip addressing
feedback from previous versions.
E.g. https://lore.kernel.org/all/875x7bzkz2.fsf@gmail.com suggested
using list_is_first/list_is_last.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22674350640

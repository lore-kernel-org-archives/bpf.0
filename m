Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178453002A0
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019707; cv=pass; b=O854dupHnXG9nvV6v/B08UUKT8tA/KzsqolXm1XcbGcNGv0nmVUpRRT2t+t52B+s1XUch/yF3vOou7jE/55IOT7yvRzBbA+kCv3u/KJM2VtFHyecOMluUl6V9IRTElFFWTCZ4c+tpiBB/eZJ0xNMrdqlLi39OcaWhOO7cUb7gjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019707; c=relaxed/simple;
	bh=XY6VaETd+hAeDG5crprj7Be8rufMkxg+B5f9SxxaoKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0L2ZD1hR8kpOp79onAT3RmcQoAKI1Hf7fFQMtTapO5Pi3HE0NZCt082zmtHU3CFnZaKDM1CULX9iQ02Aj5Lypcct50kzchyyuoJuuM/ILNTOGWEAkjdBk+zqsyuPxGck85eLnKIEt2Ha2MNQthBGBDeJ4/TAG3oi28uw1ktKHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+jky8L1; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+jky8L1"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so2441704f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 11:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776019704; cv=none;
        d=google.com; s=arc-20240605;
        b=fH7TpmJmA5+1fEbLnUmb81vs5y1x2sZL1omPErXqGt7QpRFuuLSwHS/CsZ2lGM1gGe
         5VG+UPIFNp+Y4Bh9PS+sS1xdpksnQkzQg1EWsjkcX+QeRuhbfAWAujSOGT2CXO+y3zsI
         GXxNUXldwGQlTvFr2a6biYhoasftzZ9otdiHD4CH6quyUNZmZSarGlxI5OS/VsKeidjN
         18Ng2i2neuqsUIdpS8lqVKakkYF1bu0xVqbITZC9NCsE5S64loy7yqAImcUnQJeMaNWc
         uAHNbZes9ixWMgJZpsrLJM+C6+X7Rx4z05RJQgQCbXbq3w0t68Ijy9Cmuo5oOv/MApKh
         KiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XY6VaETd+hAeDG5crprj7Be8rufMkxg+B5f9SxxaoKQ=;
        fh=9Eucqq5vQ5myrTLYAMkb1pusjK6Ea69iu5P+Jvr7ylE=;
        b=lInq3VT1Wv8axFOXoNROdA7DJGR2gV5T7Z1RkZoIiy0JsZCx6BexhCO06BY87Hy8LB
         ChjmKs4u17urCsZCp5kcNW0v8z2KSyQ+RHWIjVdLqQVrnMS5yYmqpag7fPi1KWCal1Mt
         FrJ+oLo4wCA680jSW3R3exgvYmanAGG/AwpbjV9Ln1Tp3UY6nsLRu7h/iYlw8uTu+lJH
         86LayZYczqeRpPTgOW9zW5LheeGQXFV5z7hGdSyhPyFJhuKIFNwtYxIirPhmf/e5ldgp
         jp6ylMFbsMmyVTxT6nJaD/C2nVwpaI2EYRnRSb43r7j1tog1vzWx2pXGIrAuvXBYZGya
         kgJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776019704; x=1776624504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XY6VaETd+hAeDG5crprj7Be8rufMkxg+B5f9SxxaoKQ=;
        b=Q+jky8L1hvkPhiwIm/rQ83WgwdkSs1yAl2vnhKF0RU9fDmudVMqbSohtA1BpSW73tP
         0oFEEUW6INo+bSsaaRK8P+N+uusnyafCwtyrxpELxmxmtkeiqMPLH/I4LeckFHYmKGju
         5m2Z3Z/vw0UNMrZ6Rhag+P/LbTVRHwvPOlRILmq2MZp1fQwHxQyqj0JeJiNUJxqsW/LP
         xw7fNddswhLY7PiLpLyuQVlZK24PbGEfEX34zbnabx0RyJuHwNXYxkri/cZQESQRpYKy
         nCYluvgmtSG+jcjB065IG5HoDKVYL+kg61POL4fvQW9eHF2L8uRl30iuIw0vdWhFvkls
         6i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776019704; x=1776624504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY6VaETd+hAeDG5crprj7Be8rufMkxg+B5f9SxxaoKQ=;
        b=QTpVVZRqXMBPlYwfDJgN1EDHVQtEPkqAmAH/KgobdT/RZKszolBzq0cudwSJUkKMty
         jGTzRPtYE+1kwD5sdGbQGmXFXdAYYvxtYIFjHukk6GKOlsKky1NTOkN4RdS3PZ3iAhIJ
         q7YkD9g1u+aazXy001eKC0q9ovK7mh4Mo48UU4DSIT58rZoTo5BrAFD+WT49+L2jX1L4
         R/UiU3/ZTXRclS+w7lzgfsw5q/m+j7FUYI4BbzkJNd7aX/4Hlr8FtUJy2+KlkNphoHke
         5EVvuvEvGFVDIuRHaiV0ZDAuogghkOzesqU2tC+udnyLDXa+tapuJRixcqtSz1CJt0Hd
         sblQ==
X-Gm-Message-State: AOJu0YwmUr4WXNyG/PiIsYVcDzb6Ut/YU4H2d5jeMgKKUK9P7L285oRI
	rHBWLEuuFIndQuAhIa7XGkTeDa0byjBbXBiAlSVqBAM4m9a4JAHdBhK9VSR9hIYwSUb+acgTq9Y
	rMgPInv1SKzQWQcW3MIRWUuOLPvx88HM=
X-Gm-Gg: AeBDiesBHZbiKT0ouRa1VI5XzkWzt4zqYVWugREYpzmOfI8iHB/8YJUPuamOrX+V+XK
	LJ8NvPD0K6F8oZb6gxP+TUK/h2vNYsqIYvuOcdOQyqcuOxo/T8G/gl3CraL2GbYF60GBSoum0lj
	gNTbOIb5cVB4Z4sVywVD9TnW4eFDfQdl5ddUqw3VzLStztWDwgexCcythVpXac2Y5q2sZs4lfYe
	eUZabjSmReb9PKnGBQL3DYLKIbNIzbPDepzpSlrjX8nYgCir4TVxZ3EuI59VMhDJGJyXOEJjFdZ
	h/9ijoxaPKfR7w31FUfuDgZ0u3odLD5IhwrvHWGYeqb/KXeBU0UclpfrqpmUkNlc+Y1v
X-Received: by 2002:a05:6000:144b:b0:43d:76d8:5797 with SMTP id
 ffacd0b85a97d-43d76d858b5mr3214293f8f.51.1776019704123; Sun, 12 Apr 2026
 11:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 12 Apr 2026 20:47:46 +0200
X-Gm-Features: AQROBzBlSTC-ooyH6HEhnxIXDYSWQqGpmaNOqVMwaw3pFhU2jd7Y97-piCZh7y8
Message-ID: <CAP01T77QAKjiGDDjX_f16Ftz217Oir8q08R-u5FP30VoY4irPQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/6] bpf: Split verifier.c
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Apr 2026 at 17:29, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v3->v4: Restore few minor comments and undo few function moves
> v2->v3: Actually restore comments lost in patch 3
> (instead of adding them to patch 4)
> v1->v2: Restore comments lost in patch 3
>
> verifier.c is huge. Split it into logically independent pieces.
> No functional changes.
> The diff is impossible to review over email.
> 'git show' shows minimal actual changes. Only plenty of moved lines.
> Such split may cause backport headaches.
> We should have split it long ago.
> Even after split verifier.c is still 20k lines,
> but further split is harder.
>

Great clean up, for the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D935CB6A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128928; cv=none; b=fAIoONc+n38ukWdtplpX6hcqM/sj5CbmaRh1b73iiqhudS1iKk+nQ5W3LgLKMFfBb/UNtatNa18HET3zxEsicYM53bZdYEK7K5QVl153OqKOlyDRDX0ROH9jf6mSmJGKBTZn1sNFMkJ1+xM8iapQ83sZm3rKhHf0DwAaJ72U024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128928; c=relaxed/simple;
	bh=4F5JsbzlJprC4YpFiWmEQGWzHUTlZbScOYsAXfA0KtE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=qpw7xO3BLQkPc3dTLHG4ydYze3LwXgUU78nGtH5OQprKGXp3AH7tnZu2tofM83Rh6x5Rvz+63uz/gs+45OE4ZwTONZNaOqHa7c0kuBotcOyYM7Xc3h6YMygpKSBLOFjRO+ST1YTqB/TWa+4iufzgr+DjaPxW/uj5K1s1DyjdTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZhuZqHC; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZhuZqHC"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso321779a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790128926; x=1790733726; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2bOFJvTkZBak+qel32NDS0LUD2oc5EBObgtAC51vYYk=;
        b=pZhuZqHCbZCd7POttdOxJfk9QSw7vn/M9mIwIkjJrlBf1mYNzQMhB9uMxV8DhB6zBk
         HUvWa4S7OkMLcfpg0P6/CgOcFkaWICOBjWAQ35LzppgPWqg3QQVqw8w4/j4sWwkmz5xC
         NQk0+zhBwYoNnZ2g0kwftEYLnlfu5/ARkGkJ8feSeA5/0r39ZLvN2TPvm3IrW3dmSGwf
         Oqpn4jLx7eJBbllWqEUEpbBUqjIYu3lqtat3Tf8rkf3HIk7UvrDWzuSwN+02XbiuXw0j
         O/ZzZ0E0E6xo3bEyhR7yPqml3A9qrJtwktTVPaCZn+1isvkju8j8GiNxRVMh/7vH19U7
         8JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790128926; x=1790733726;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bOFJvTkZBak+qel32NDS0LUD2oc5EBObgtAC51vYYk=;
        b=DL5SM6DEdWgVkdj9c7sIAnFYd2109zMT9jWcq+l9SGD5o8lLTxmDZSyXWttmhrzIEl
         HYejDVh7KQck6WXDpJxLQNqAhbVlVPWC6NiWO4xPS09mG45H6OBzelfXqzYFPZ1iwVXW
         yIlzHaGKOkeQyq6fU42ANs5946N524OAwL6344dnAyaaB14QxBd2uvYuYWuOAjyTSz0v
         cL0NuGxqVy5nEUdoo6k8hpmiCi03ySgHr6/kaFUjNuXmvxTnvidATt1AF5XjQBX8IR4j
         PKb/IXApWH9qutGfkUtC8bra+7lhzw25P7xhQP4dTpUujnwzVX2ruOX4acG9pS7SW26u
         gAQA==
X-Forwarded-Encrypted: i=1; AKwUvBwp4EwzWCfnmirsUgpYIeCqEJo80cMAQim1LXDnwd1PpfhzZ0h0vR1HPoB6QSmL1Jn019w=@vger.kernel.org
X-Gm-Message-State: AFuF++lRBu4aAb8pFBu5ooW14vRYCKrELHUk6wJmUdDHuQKlH/fY6Trr
	xsRP5kH2xSvNnDJX5RKxD/bgmtTvTDJEgtnJU1Xlnje4TnSdEJxfsPpl
X-Gm-Gg: AYBFou1FcL2jDMTC32et2DWJ4KG9/+DDn/sSSjY+2mXUmzmI9VP++MS6ZbS2Xu/QI7x
	xsI3pldpdRwqlMeGlzVLHXJhO7FB1f5Pt6omx1NMNzJxzl0MJ/bBjMw03c5wyQFvUFVr9VK8eZs
	cFEO+PvRCPRw4W/aIUIm7wl/E3vN370xV5Z6uuEfcfTE0pI5e2aT+F9DIKeJm7bET9ekcpbWYrd
	Ll7umrnvUTXJNOOHO8gx/OXmhmLYbEhz2ukv3dGk6XdThiZghHQ4m1DQcFeZYUVBopfaIxXr2uS
	+ACnKx9Q/BBbwEHT+lwQXPxLQCQAoEdxJkVKp2lpfOjqySVNtoXalXjnE154IFg5rxcvBGslAEK
	7iRD05yWcOclTA4QSQBQ65OnksCxrjSxR6Q8/Cu4AKLqj1zDn2hvtzzJ5NxyQWr9wLuDqvOCh64
	8jyCCIv35C03HPz29kRj5ejiYzVvA110bclRDs+MnAbHHuo0uP+vZQvMnzI9LhDYHzooqE2Vp77
	7S3JZFjh6R2cgF0J40dNWhFLN2wW9K+/8LTh5NXTLS48ngC/BSJNvx/1CXdE7BUFdTCJjUlpuBK
	ht0=
X-Received: by 2002:a17:90b:2fce:b0:39e:6c6a:6570 with SMTP id 98e67ed59e1d1-3a07e653cc7mr1039354a91.51.1790128926090;
        Tue, 22 Sep 2026 19:02:06 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc7c7b0sm1994886a91.2.2026.09.22.19.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 19:02:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 02:02:05 +0000
Message-Id: <DLMBQRAXRIZ2.2SHAA85YGTKSX@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Yuan Chen"
 <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next v6 2/3] bpf, arena: fix range_tree_set
 inconsistency on kmalloc_nolock failure
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260922072102.3570856-1-chenyuan_fl@163.com>
References: <CABFh=a6QOjBv1c7B0fw0AEqaBXiQJRh=8on5DUfqPC7hYuGBxg@mail.gmail.com> <20260922072102.3570856-1-chenyuan_fl@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 03:21 PM chenyuan_fl@163.com <chenyuan_fl@163.com> wrote:
> +	/*
> +	 * The pre-clear probe only decides whether a fresh node is needed;
> +	 * adjacency on either side is invariant across the clear, so it can
> +	 * run before the tree is modified and -ENOMEM leaves it untouched.
> +	 * The merge below re-fetches its handles after the clear instead of
> +	 * relying on the overlapping nodes being updated in place.
> +	 */
> +	left = range_it_iter_first(rt, start - 1, start - 1);
> +	right = range_it_iter_first(rt, last + 1, last + 1);
[...]
>  	/* Do we have a left-adjacent range ? */
>  	left = range_it_iter_first(rt, start - 1, start - 1);

In v4 I asked why the 2nd lookup is needed. It's not.
range_tree_clear() frees only the nodes that are entirely inside
[start, last]. A node that covers start - 1 or last + 1 is trimmed
in place. The split case cannot happen here because of the
'already set' check above. So left and right found before the clear
are the same nodes that the 2nd lookup returns.
Do the lookup once and drop the comment.

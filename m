Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07B17993
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775042; cv=pass; b=iJ7UacXfIL1Tz6Bhz/EykZyLZbm2XcKqSbHkTHozroT5cGFoZuZ+OHeIrBbW67DOK9CoxMeh10Yl6TJrAu2lp+xrSZPdiWs1O9IXg2P6hxx6XFWG1NLlaDmxPkg7z7AO7JZ7zNXOnhslN5EhMywc6opSYhgSUF97owrEU6mTKsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775042; c=relaxed/simple;
	bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul2tB2xWDcorDgqInqev/jO8YZ6uMEGvrVHXC/+ebQnkxpx3jJzoQsXc8d9G3qX85Ls3TdWi35BCJTIa8e4dCuBsbZtyMxVFcc4i0hRLfhFLDnkg82aFO5mnjUNSJcYl2ZcEqxJyAx8lLEZskKUonv/AG49vpApAl9YkjjICJnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7rY+qlj; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7rY+qlj"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1273349c56bso10980531c88.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 21:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772775040; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0tlsFi0um42Is9aZeEM+3V3mBy+QFvKY3SKCKnS353opm/CVSdANo70BpMF20XHsK
         OghoaYPbIRKNZVrruV+d1r0fZL4LLe8Ocz7O6rxjlpJnFLqr81IE8yVc9sSornDpEY+w
         909fUi3LWcc7kPs981g8BddePKrGEBndKanUBovUYYnFMoaHPGArUESmNmImXEFOjT3I
         DC5Wm0/vfPWLACdNj00ECJoQnBrxFDbhcyHejd8dnno3zSOsZN9WxPI0uUSdWQvlNyX5
         rY4Gy1niE5bef1s1xfTloApckNNokv2Z6xGfd9Mwj5pVNblctTnhORLJr/kJrS9b8wfY
         bkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
        fh=6w8B/w7Lba/SBEV4Lv3nRVf+syVs6P+Ius93zZahmxo=;
        b=XQR1F0oGn7XIS+uFROdp7qsducyKD7W+lq7oM+SgQhOVA1QOHoSGOqeMEe5eLYgJur
         y2Dco4/mRsgQA/gy1Bum56jiGW5Nblxbn+SPU4U+SWJrD8IO1o5qSl8WZfCweN3hoDPU
         rW3r3oozib8Xevia9RJwM0JMxqJhgGZWBQJ9c2UXBc08LSn9JfJ0WcpSxy+nfDx993y3
         lVw3KTYCV0yQzKZ2+/xh2IaJLu2QdEOwojmXrs6UciIw/TiprSl4qpfc8CMo6GzrE49J
         /MB8ZVwp7Plavs4jhHBLCx3nt/F3eDBtKcWT5w81tUI0rP3Pez2nxLpshOcweTX+JOmj
         dYZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772775040; x=1773379840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
        b=n7rY+qljZu+gNr/jg8/Xf2rAwcD38K7KWMkjDOY+RyPTxUKzGTHBhKiw11Xdv31VOq
         de9fBXhEYmuVnQsPfzfit3y+2Ao239L1mpxl3Pyzfa5sQY+E0HrwawSUQJSLyz43ZzTA
         PhafU+MBwH7mQZRjUY9KUuzxx1r49YnP1p+qNz86ABaW/kV8YFAtaRyQOgLE1FLvbDOS
         uqb2DZtK+G7qre7uB2XWIV66VPYOop490DRPlL12n62dVDSZqPlfQht3hizjVB5rBTj2
         j7+brbfpqyTGMwUN8BiGRuXfetXTnrb2rX1Gjrpk/ztHA09+r1WkN7LYVUEgzILyTnLk
         ZrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775040; x=1773379840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
        b=B58qgw7uKuQyJw+GEFYh0HonAW5bE/h0bm6CsqEDR2Nm3KsRyGhIlioA86Ofv5RUAN
         b3rP5pBWk2rwKhLZeWnE/uLr4nv7Vy+CeBALJUo6faPVE0wYmvkDcw81G3AhR6eHQCPR
         ykZSfPcDm9PRdG4yCGKyURTh+abIlB8Nle220CpZtAZvu71ak8Cy7saZsLk3tF/xZsKD
         UHbe7yfb9bstbvwHapEUN2DU5ESYwzRgt4ELPLt8w/zr7s4fKCobERKrqZLtW3llcW4I
         4xP9vfqDtfOGyqJDB1daHp6SxVxsfUDvzTq54WKB7E2laMAOpL5glNekHbbiuRieYhAF
         NdEg==
X-Forwarded-Encrypted: i=1; AJvYcCW8HcLoH+YaojopjXn2FbGuVDwziKybUapV4nYhz7cb2acaisJlMpKWhZsrmBsOOZlsY24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLTORDlkSgz1JkKCedpHRgmTqkSbD+7lOkC9nDlARv/o91udl
	9lPjT+fkTRVnwAIw+XxdnUup6rKnNd3kN99Ba5rcotOklalwYx6sY7EduGV2TzJLMydSfBRi37K
	a9YGjJVn1eR5DjULfYh8Eq9C6ZFkKuPwDIs8J2KxA
X-Gm-Gg: ATEYQzyIdhAN/6Rob5FuK+EaHdZk+BUFZEe6INVUVQwXNc8p0aNCzulYVdAs9JHu5hK
	WsSpLLJRYa816Sj9vGF6FCuqumy7pApBUAHxTt1LpRo0m2mkmej55d/FKUGglEpGm3yvYvAfjDr
	TVvdhLS9Wx3hxEddFseGam7xdWt1IF7VQfrnywq8tPazGfijf4TqkqHahFBsCwLUbA9Q2BqEGJo
	SDzdcTA/Scg9MxstBviUUhekoZFq5B4HlifylT+TidGlScJRM6GBJW9GYwPte5JCpVri3JhUd5r
	oRIzQ4OscaPdcac4bhPu/LWzB3toYxsAdXSaDpgoxidgXobmkySqVALOTdx5Zk7eOrqIGXyGioO
	ObmI+GkI=
X-Received: by 2002:a05:7022:6b86:b0:119:e569:f60d with SMTP id
 a92af1059eb24-128c2d8fe00mr474098c88.6.1772775039009; Thu, 05 Mar 2026
 21:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:30:28 -0800
X-Gm-Features: AaiRm50jkjo2D8__HZfvwOMuhiWP6gML_uFOzVrw-NUHlbujLc2OhzKbo6rD-x0
Message-ID: <CAAVpQUDmSyxGHuyZNGbsbadXBO3yG0qffaeA0y4AzQiSg4v17g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/5] bpf, sockmap: Annotate af_unix sock::sk_state data-races
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:31=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> sock_map_sk_state_allowed() and sock_map_redirect_allowed() read af_unix
> socket sk_state locklessly.
>
> Use READ_ONCE(). Note that for sock_map_redirect_allowed() change affects
> not only af_unix, but all non-TCP sockets (UDP, af_vsock).
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Actually TCP path also needs READ_ONCE(), but I think
it's okay for now since this series focuses on AF_UNIX.

Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73860371CE6
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806841; cv=none; b=OgqI2stRkdvquEb8I4jJUmFm9Rfi6ys7Il5s+x2KytevLdIDP0dWubBwBDNo0fxr78hxnligalU4FddHcdE5gi6vsUAfcB+Ku49bkcjj9BAgCAw8CNJRVPmJ/Jr/EaQ4hDg6jhoqrLZCDCvF8a60jjAj+WkXuAY8d8fMLN+/PJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806841; c=relaxed/simple;
	bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuAQV1CAwF6VYR5n73TykblGOkBo+ZQjmfL+OLq/6ddzqF39DRmnno7bdbN7oZvAhKPFFfamVh6ZQpxTJblgK533PCMSs70nKtvjNc/E4FOZqMIv/DJ0HU9dQUAiV2YiX83ImG7pm2fLpi6Yzgyf3F3/yyKmsKOqiFCf9AeDvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd3P9Lml; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd3P9Lml"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36da8439078so1103946a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806837; x=1782411637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
        b=Zd3P9LmlCJ3UAL1PQbhcEV6ghxr2eyxhvKJ6nkuGoS8zpkgwwAz+EXez5ngHOvG78P
         zaDRH8jQWU1DD1+QgYOYLpPl2zWNw2AAT638LAolJpV9+pzqW1MZRaiwziHqJ+nBTaxO
         qNJBfKVJCPkWGmxlEzjvhXBGcDIiQDP9RmlDq3mqvPFlyYGjDysGZ9QOOlO1sooyU2Mt
         p8ZKVvrQZQW7NwR2XVxqrD4FSoeflSH2xKQW9GsPYQm2kl01jAzwCzI/Lm4g3aptuBkL
         QLX6fbNwmh1kloHTN1WK6f9jcYRMbMXZHIyp/A8e0KpVWMUk9ENc+fWdM5yRE2CWwVpM
         JHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806837; x=1782411637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
        b=fkUDFG/eOJnOigFEfgit0FnrzMrStAytI9qbyQ6ScE5iUPWVfuDAOWrb5CI2HUpkoi
         0J0KwObo+PbOToVG2VdPOlZ1MihK/aHCBh69IcC9PZEuAOdYOTWh7hPUYxmXexWyHFrN
         eiJJWqihsvDubzxbhYZk9GGjOpKnOPv5C1ZDsTvsR3jvDtkiH8lEkJ4nxnkKvBKzgIfG
         bjkpcDCXvwIPuIM5D+v9oa4WzkKgz7kHrlI4Hhf6HYtxkT1kF4akplG9bS2eVAftwNhq
         DAU3jkVdBUUArPRbFaxpj95G8LqQwFCzhrtZD+N0pWB8iypKBb9HuNdYmfu37OLv90kB
         CD6w==
X-Forwarded-Encrypted: i=1; AFNElJ/VNLRr1Y5dkA3+sBK+fLI8C2Cfq9PFo0/fDql9dhaTOOmmVegJInrgTo97d7alvqyYeac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiHU6IuFDglPbDYJzfwVVDxUvslbjlNW6CLEkEcWnAt06W+S4
	qgqZrcSRULCerUAvEZK/5ru/N42JHFpbGOsrNUTaTU3Sze4YTd94BJqgWRGHzw==
X-Gm-Gg: AfdE7cnHRaSwEFejPkIUyHRRSizuhuXz/QHTH6zCd1MEl/C7TeiIHU2srChjbYxN0be
	RVz7QPv25gRvUdD/VC6WVs/+6dk+ZihAesGJCMjOW4v2uCzgp1IGa+fTYrl8xm2++Pc36smHWKj
	HG0uacxj1r+NHoEI93qdk++DNO6c90fjicqNX7/iMu3U7qnjqE0uOjltX26qOJZlJSpgkaICL2k
	JCADZORD8QQbqcqdwsJxr2wW7/w56av10ylM8y1ezc8ctvqd/nvYj0wQ9km/E3StXo2SS7aSh9u
	PL83YrlsuwbSGiHK5aCjjdT5MbAUOYY34mPSIb3fBBjgHV7J9qXFeDHKWxbJSAQivUnP53434oZ
	AikOEdGypXhSdrU5NzdsTDSaH8NZ1MzoDZyVWKrMimIaQ6rHAWVS0EGdcCa/f3flrdvRS6xMKpf
	pIiG/dWLSICw==
X-Received: by 2002:a17:90b:3ece:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-37d15fbff00mr568255a91.3.1781806837595;
        Thu, 18 Jun 2026 11:20:37 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1558b599sm341702a91.7.2026.06.18.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:36 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:20:34 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Message-ID: <ajQ0p4ernwLzxkhu@john-p8>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>

On Wed, Jun 17, 2026 at 01:18:27PM +0200, Christian Brauner wrote:
>In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
>we added support for extended attributes for sockets. This comes in two
>flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
>are actual filesystem objects so reading xattrs must use dedicated fs
>helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
>are inherently sleeping operations. Sockfs sockets on the other hand
>don't need to use sleeping operations as the underlying data structure
>is lockless. In addition, retrieval of sockfs extended attributes often
>happens from LSM hooks that only provide struct socket and it's
>completely nonsensical to grab a reference to a file, then force a
>sleeping operation to retrieve the xattr and drop the reference. We know
>that the sockfs file cannot go away while the LSM hook runs.

[...]

>
>Link: https://github.com/systemd/systemd/pull/40559 [1]
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---

Nice this will simplify some of our socket tracking.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

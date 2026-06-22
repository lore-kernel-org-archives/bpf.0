Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7C38F23D;
	Mon, 22 Jun 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116484; cv=none; b=N2pckOY7QiGI1mVPHekW40PqBT/ZVmamyaOR+jbdlh5Pho5Rtp21n3zSpTK7hIvZv0VhjhYu1eHUZCloxpN1gFNlllXxFqahVMXVc5NoHa2kpZaCJnyI//8sorPJ/aejZlysZdMQtDEoXttM15HkSk18I1Gz9FFA1e/rjHBncKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116484; c=relaxed/simple;
	bh=IdmExyROUV25/EktZki9aBpJp0ijNsEyKNDbjR9hpyk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=u+zxj0RDGsyqBI8mW3xO2qICZrehfZ0PwGjjFmmCek32w4cjlz8g6ZX6N+dq2odSriO324jgcC5Z0wXdA1QkF1ZWJWzFlKHXjCt1IXD/OwHvQJHT1PJMgeAEYy1oMf7ktEK+evA6gRP0Gj1AIhLkNmVK1QHUriQ+FuhOLLTQhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB7uoLjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB7uoLjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B21F000E9;
	Mon, 22 Jun 2026 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116483;
	bh=IdmExyROUV25/EktZki9aBpJp0ijNsEyKNDbjR9hpyk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XB7uoLjJEkleWKn/h6/0LM1GCrUd4baGc2fOGJ0GlCmuiXQG2sAzA7cD7KpiSdHob
	 Ct9uN68rjkmEsAO/XrglfVEcYMuwtQgxzMS0JCOQVXdMqjKppoB66OcyWIT2v5G200
	 bTAFJJfiRSaiPASjRt6jUohUomWsyTaaBNYQQKFCZ4CWKvyk4Kyi2FdeAAJAKxroe+
	 g8ZsoiXj6X1bRBGXTDr/jMd75J29CgMwe+laiSN+i27b60wIH+/1WUo4v0z/b4dXjr
	 PXi/zDR937ZblGH9sODw6+DTwSbChBKbFfooQY4zI+zQ5rA/raHgI7KKyChgc3Aedz
	 QvK8tHhyVmyOw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
In-Reply-To: <DJDJX62AS415.2BVILN08QK149@gmail.com>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
 <DJDJX62AS415.2BVILN08QK149@gmail.com>
Date: Mon, 22 Jun 2026 10:21:12 +0200
Message-Id: <20260622-biobauer-finte-beunruhigen-51cdfc70ddf9@brauner>
X-Mailer: b4 0.16-dev-63c58
X-Developer-Signature: v=1; a=openpgp-sha256; l=116; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IdmExyROUV25/EktZki9aBpJp0ijNsEyKNDbjR9hpyk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZfKgKv+f/V9bx9BVbxmx3V4+LHUcfyBQ7sLb8SjrpK
 fntlHVnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+WjIy/K5x79Ld/o2hWO/z
 ubNb1E7sSkxQP12+5LrtH1NFZqEHbgz/87SnF2yI8/Zb/+34RNltr80vxU1ODZwj+31v5Jx3EWt
 yOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> lgtm.
> How do you want to route it? Thought vfs tree for the next merge window?

Yes, thank you for looking!


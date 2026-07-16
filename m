Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6123A257A;
	Thu, 16 Jul 2026 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194960; cv=none; b=l4ocKqzNvxUQfL8sdJtZQ+0aPb7pUlW44iYtllKDnKutBM/fu6EHdq7eWyf181bOv/vYuCFvt1eokvjqCFXvROHFcig2XXaLaY3t8thdUPguJQl5sT0b/rucNjy+PQKpD38Qbi+zeblaRtSfE3isui0AYgGh/XCc9bpapPYmEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194960; c=relaxed/simple;
	bh=duEPPd/yTQJ52u6LyzWAU7EyjmbxDlH0XgXUJoH+hRE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cIOdCrrX5N/8l5UuOdz71/O5BZMDYJc+Qw3nTGVpewNiIi6MaF/sWKeUZsyoa3mgeqna9FPiOp/I6O8xFVDcc0Ctjuo9HEIe1yWxEVCCDeyH7oLJ+ayGELR7Dgc44phOb5TMWyGGJJYHn3aOVHmRCYpKZjiXhHG/BUkiR2CFluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYPO3OgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYPO3OgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C0E1F000E9;
	Thu, 16 Jul 2026 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784194957;
	bh=HBYaQCEs1XJk4xaIrBgpSzlKHksZLiKKI74oafHAUXE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=oYPO3OgY6OBm7r0DY11biSegBWYZbK43hvQMostyGHiMJbsum0hr35JpPW0LEmMYS
	 norEPMmuWYO2wekH54KF7lEc6sqVTjZqd8Eg9jtAgmKCVeoJSY+rNBggh2FA51R8P8
	 RUIepVyMQa4sm+LQ8Bc2U3ODm1saMHmNHtItLcY5pjoN6DZI7nJGrGIN1hY/LJCbVf
	 tglgL3TjEeA4iZWq4AXQVTdPTcGztKGiYFfLBIVWhA6UmsOyr9wVj9RxWV2R//BzF7
	 qCM7NjdvJarl8UTbHVh/MKTbwMuGOr+EuZ6IGvIVOnQuSmD+YmRv0cYPE364H0cVv6
	 E0mM0SfMw34Ug==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <DJZK7IJ53B5J.141W232JLWL44@gmail.com>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
 <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
 <DJZK7IJ53B5J.141W232JLWL44@gmail.com>
Date: Thu, 16 Jul 2026 11:42:14 +0200
Message-Id: <20260716-surfen-erzfeind-aerodynamik-5dc96c3f136d@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=490; i=brauner@kernel.org;
 h=from:subject:message-id; bh=duEPPd/yTQJ52u6LyzWAU7EyjmbxDlH0XgXUJoH+hRE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRFLK+0a5SdHreq8Z/jY6HHoe/k2Zs/Vqj2LCm757jIv
 aDZ/0JwRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESmzWZk+KSZ8C3P//OOpa0H
 ND60Ldwk//mido7CjY7clNzDfpL75jD8r/t3bEdgQGJvZ3ul+d/QWxmeFoZvb7Umv/r+UCswjs2
 AFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Should I continue to add Reviewed-By trailers to the other patches?

Review them, please where you can.

> (I have limited knowledge on some of the mutex stuff but the agent
> review in b4 was helpful in understanding it enough to give a review.)
> 
> Sorry if it's obvious. I've never contributed to a patch this far
> along or substantial to the point of having to understand the
> merging/acceptance process in Linux.

I plan on getting this into -next in the near future.



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7283BED6A;
	Wed, 23 Sep 2026 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156069; cv=none; b=If8jvO+4vnFvTCOi6kx/eJuUHZ2wbAWZpnNpYWHc10tWoncadQQWTmywR1dCJcEiM7baPiV279G9SKcfbhGlnVA9hmZYpH9lLzm+CgDjHjRKcdZT23K7pB2YXd/8vWjlaNEBIDrHHikqXr2ef3r/SGvpW+cQmcFwguOKXA5ve7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156069; c=relaxed/simple;
	bh=CfE50gjOMJIZIOiIvNlU0diQlCTpqwlV6Vs5njlwQ8E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BpAlGW4j2VUCgKWl2/i3FkQImRQRtWVkXkTLJ+pDoWudYB19FNI1Bt9M5ksU/0So5AGz8ctBpgTWeMkzDIQk7z+kmVrYZiSTjTRf9AObPQnuYfm3CrxTXSBmETDYYBLyFKd4l4UqD1EY6RyWrTEiexQd+NzHytXN4RRbmKUwWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZIYPjHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZIYPjHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC951F000FF;
	Wed, 23 Sep 2026 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790156067;
	bh=zzIZC/0TmFVsfiURHWtB6V8xRvBxm3UJTXCN9OmPP6E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nZIYPjHV0WM7ycAr+Bcw3vrnmkyjLeoMKvJHCCZSKd8bjIGt70AtOMAcG15z1Rsvf
	 uFUsJ+x91uAvf12+qKqy2VBln0lEwQyh8C7gctkZMnbV6lRebdlCqKzUJ9DXyWXKrZ
	 CAz807ML0KI1/DSBPDBGvZ0VYSlAkA5RJ5IvNseJi9e9LvAEtx6AZ+6O+VsBhMWJN8
	 n7/WqAj4N4CO4QhHtvT120p+WTvWMESOTt4I09AGWhluEwLwK2VW6vPepBAzs73m49
	 MGgH4sc83HlnPyg+yGU89rPPInWPsN9bd32SONWm1/TFz1+anM4Cfhu9fP4O52NKYl
	 2SysyDGp21ZxA==
Content-Type: multipart/mixed; boundary="===============1656904363404045793=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ee3c07a18ef7f010f42b75a1dabe1e9bb8904f108398d6556c1119cd20c99852@mail.kernel.org>
In-Reply-To: <20260923085817.365930-2-chenyuan_fl@163.com>
References: <20260923085817.365930-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 09:34:25 +0000 (UTC)

--===============1656904363404045793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
>
> range_tree_clear() pre-allocates the right-half node before modifying
> the tree, so an allocation failure returns -ENOMEM without altering the
> range tree.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This appears to fix a bug where kmalloc_nolock() failure in the split
branch left the node already shrunk and reinserted, permanently losing
the [last+1, old_last] sub-range. Should this include a Fixes: tag?

The suggested tag would be:

  Fixes: f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35841441642
--===============1656904363404045793==--

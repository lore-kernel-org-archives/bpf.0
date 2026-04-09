Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E77EED8;
	Thu,  9 Apr 2026 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697404; cv=none; b=HvNO9kUATD85HIp1/QLXTPXyvqxJvS+6m5L141GoR00oDNH5+xK0uU9TTp9s+7Vl5BBxGtt1HsDVkHmU4tdEkPUzfCeEJZ/MDZMduTyUvpK0xmzRYRsLnZ1x2dEnVRYjzEB2tkkIwGE+ae9u/o3fTO49eoqmgXVq4aALu55KG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697404; c=relaxed/simple;
	bh=iALZeEnXSNK+RE8EKrDOIs8TZ8OS7+bqUjhuduKCHNg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=arR+E0lFZpw+XF2lhJx00DgZIAKglOucl/pn/BTiLUwpcegpxzRwdK22WgO6So97y26kRv4B32QaJEh4gQgzTmYBR6P9zHyvDcqhMCc1LBRV2+ci4masUC+Dfp0em6SizVcgceJTd1oAkEeHqmssY+SOciuZipAvCSjCrxGm9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKpGw427; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKpGw427"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA14C19421;
	Thu,  9 Apr 2026 01:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697403;
	bh=iALZeEnXSNK+RE8EKrDOIs8TZ8OS7+bqUjhuduKCHNg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dKpGw427s0HqSARsFytx6lNxiW7wiIxWjATl3sh7zSd9vtvkDnEFKDV+qWMLV57dr
	 l8YUgkJuRobtlV0GBMoY+KUbPCdonQaQUxiNnv5bEzLK9TqSJlFUgDqdU3fhPTIrnH
	 oPvWycL9T/iOrFW9XnROJa+N0Fu/U87wMn63AKMjv50+ftGYRD86Et6uUzsjMe09cw
	 HFkkqbK5m37XFi2KAOXhCiCkQcO1o6txtyZv+98D3sohtDd2PwxnAwojlleRzVZqF8
	 11SbE0BEFlmZng1s5BX5KvdMTHKm8rtewVgL7TOAYEwcFOPwsXjf02X8bEw68iUv8D
	 3JwJHM3Hs8mBw==
Content-Type: multipart/mixed; boundary="===============6524245521076539298=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0db331580ccc3fd65bab9b80566ea78bab6fde78960f0ec1590486b2452408db@mail.kernel.org>
In-Reply-To: <20260408104732.259683-1-jiayuan.chen@linux.dev>
References: <20260408104732.259683-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf] bpf: Fix use-after-free in offloaded map/prog info fill
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,dddddd@hust.edu.cn,M202472210@hust.edu.cn,dzm91@hust.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kuba@kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 01:16:43 +0000 (UTC)

--===============6524245521076539298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fix this by using maybe_get_net() instead of get_net(). maybe_get_net()
> uses refcount_inc_not_zero() and returns NULL if the refcount is already
> zero, which causes ns_get_path_cb() to fail and the caller to return
> -ENODEV -- the correct behavior when the netns is being destroyed.

Should this say -ENOENT rather than -ENODEV?  When maybe_get_net()
returns NULL, ns_get_path_cb() returns -ENOENT:

fs/nsfs.c:ns_get_path_cb() {
    ns = ns_get_cb(private_data);
    if (!ns)
        return -ENOENT;
}

Since the callback sets info->ifindex before maybe_get_net() fails,
bpf_prog_offload_info_fill() takes this path:

    if (res) {
        if (!info->ifindex)  /* false, ifindex was set */
            return -ENODEV;
        return res;          /* returns -ENOENT */
    }

Daniel Borkmann also noted this in his review of v1:
https://lore.kernel.org/bpf/1eccd7fc-8a1c-4499-ae81-a63fc8d0ff26@iogearbox.net/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24166717291
--===============6524245521076539298==--

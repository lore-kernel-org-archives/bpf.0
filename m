Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5F27E049;
	Thu, 16 Jul 2026 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215910; cv=none; b=QC8Egr+/Rb8tcJqKKxMdCVXFCyhn3XDRWZH1YQ3VRzpsLPFmS+s+j7SUEjjmD4E3dmr9/LP2lt+jL2Qvtgxru4SptJOjRzc35c7mg0XewKkvH11+QYu+SF6fE+mXa+ynwMlfePRI7IKH0siFhz89Q44ppQt9gUYPYMn6eLNSNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215910; c=relaxed/simple;
	bh=J/52MpJjy6vMkAFdhMFZ2BWaMACch7uOs2H4IBpTYmU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lDgRY3IzYVALjC56OgHKAtwitXbkUfN13ycB55n7ndMyu5v69+5dqIjwti25cKfBIKvBcctg5MqEJBU2VdARcj75ykOsQAXwc1G6bX9FYIZw6y6IxscICafVQ7EzFzQ/9aXozM0Ui9ZzMAUgIy2A7g756/0w0gFPFvCbU6tMHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeTuVSpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeTuVSpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D02B1F000E9;
	Thu, 16 Jul 2026 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215909;
	bh=GhAm8PWFqD0O7r69dHyk33FBazCRm9jUO13MjONnboI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IeTuVSpA43pyfgba0pk71G1NJOhRfjPkX0e2vmTEMOi40HDDjFXKAL5uVOW759o00
	 6QrSr7cy2cV/oOJeF89iD50Xa9J+FwxcPNCo8EvQURCo466Rnp19KIXhLk/PTHWVGE
	 hl19L3g9kETnnvslkKO6cb6DnDqHAe7dvXErzvvZc8IL+CegBZjNlq90lfhEcqAEXx
	 8uoslkVenxaD1jID1AFHRmVPto4JwVpyibTthVgAqez7vZIbDe5U9QrD4c9IBwVEfS
	 YnOlJ83qFI/GNhbCc5bCaSpj687/CqdxYwoOE5gl+eaAo5rfwPbb1Oerxf2Ouo8Vei
	 i1EgyTQ6klQpg==
Content-Type: multipart/mixed; boundary="===============6715266482937690332=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0608056ce2c7044917090b1120dc7fd28ae2cb5f06bf3d3dd36aa0e268418415@mail.kernel.org>
In-Reply-To: <20260716142746.8794-1-jiayuan.chen@linux.dev>
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add memory usage for arena
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,memxor@gmail.com
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,random6.xyz@gmail.com,puranjay@kernel.org,skb99@linux.ibm.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Jul 2026 15:31:49 +0000 (UTC)

--===============6715266482937690332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Add memory usage for arena
>
>     arena is the only map type whose map_mem_usage() still returns 0, so
>     "bpftool map show" and fdinfo always showed 0 memlock for an arena no
>     matter how many pages it had.
>
>     Count the pages that are actually mapped into the arena: bump a counter in
>     apply_range_set_cb() when a page goes in and drop it in
>     apply_range_clear_cb() when a page goes out, both under the arena spinlock.
>     map_mem_usage() then just returns nr_pages << PAGE_SHIFT.
>
>     Only real data pages are counted, not the scratch page.
>
>     Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This looks like a fix for a user-visible bug: arena's map_mem_usage()
always returned 0, so bpftool map show and fdinfo reported 0 memlock
regardless of how many pages the arena had.  The returns-0 stub was added
together with kernel/bpf/arena.c.  Should this include:

  Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29508297958
--===============6715266482937690332==--

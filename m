Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C53A9879;
	Sat, 17 Oct 2026 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256674; cv=none; b=CZd1FTPHSHLmT4Xm3abvmtGi8i0VHIAn2WZDWfYAsix4JK/1YF1ntUDetfzESLYSD7dLlFtzVt0FEaSzIM6KL7OYpIMUtZ6tfHwU8rvlU/pQIW9uWRyqRdckhVCGkjfx9IGJdco5LSc0lr6U4wBu1VTYyXNOwIbReUtL7iWwwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256674; c=relaxed/simple;
	bh=TXrw2VOf8xfWYcCPVD0OFlSg0o6SxJV5hW4SlnzaEjI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AMTfsmfgve7qsIY8qNFYWzdGzEm5cYk+4bHDKw7QF6i5+nDHfj+3x/SZqpBl6zo3uYFQp6A93+F5cl+Ze/6uOUpj4ZO3FPedU4DIcK9iETgdw2Q4wvJ8lzYmiDmE6FOxT88OAIZEe8w/8sUR1bShDGkoLYzmGzJ6oIiswmcqI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knaiv/r/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knaiv/r/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191CC1F000C4;
	Sat, 17 Oct 2026 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256673;
	bh=ZqCBzTbKVQvF3YoOddy0pVHhA0A8JpQLrYN6WgJdoRM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Knaiv/r/gIhROK7ajHdWGUgP4kpYGq6ClwHFhWyij+2WWOSxkBg0YzZWPfgh9kwMi
	 kAd8XW+8M+nqUamGzAZGanCIeUY+5tUCwmE00BERE8zQps3HMxTiXlgRfW5usUZ+9j
	 lYAf3EDwxyRYAUxpbcIeaPAN06Ho2re+r2MoXDaWraV11TDq/gYBR32f3aFjCASOPr
	 /6UHONDl3X3UIDCV/jG8cBeo8SyiGz2s3k0h73QQWYTCNUM4GRCquJ1MjcdmlKaDr3
	 TxSb2RdCFTib623ylTtzcI649Dsaqk2lR0k686xvcfAEDvkmZaWS/pL9ms+vJTw6S9
	 cSH4gTtP/RPtw==
Content-Type: multipart/mixed; boundary="===============0146971734298480007=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <57062ef2e3459f43acb9f8797a5fcd14890fbe97c7e9e822a9f5043c08ec6cf2@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-38-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-38-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 37/43] bpf: Let bpf_dynptr_write() mark a global function
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:04:32 +0000 (UTC)

--===============0146971734298480007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let bpf_dynptr_write() mark a global function

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit. It
likely should be 51081a3f25c7 (changes_pkt_data tracking), not b5964b968ac6,
which could mislead stable backports.

>     bpf: Let bpf_dynptr_write() mark a global function
>
>     The caller of a global function loses its packet pointers if the function
>     may change packet data. That is found out by a scan for calls of the
>     helpers which bpf_helper_changes_pkt_data() lists.
>     bpf_dynptr_write() is not on the list, because it depends on the type of
>     the dynptr: check_helper_call() looks at it. The scan cannot do that, and
>     so a global function which makes a dynptr from the skb, or gets one as an
>     argument, and writes through it counts as harmless. The write can
>     reallocate the head of the skb, and the caller goes on with pointers into
>     the old one, which has been freed.
>     Let every call of bpf_dynptr_write() mark the function, as a tail call
>     does. The same mark decides whether a program may replace a function.
>     Fixes: b5964b968ac6 ("bpf: Add skb dynptrs")
>     Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Is this Fixes: tag pointing at the right commit?

The code being corrected here is the scan in visit_insn() (originally in
check_cfg() in kernel/bpf/verifier.c) that sets
bpf_subprog_info->changes_pkt_data from bpf_helper_changes_pkt_data().
That scan was added by 51081a3f25c7 ("bpf: track changes_pkt_data property
for global functions"), and that is the commit that left bpf_dynptr_write()
out of it.

b5964b968ac6 already handled bpf_dynptr_write() on skb dynptrs correctly in
check_helper_call() by setting changes_data = true.  At that commit no
helper called from a global function invalidated the caller's packet
pointers, so the omission fixed here did not exist yet.

A stable backport driven by the b5964b968ac6 tag would also target kernels
that have no changes_pkt_data tracking, where this patch cannot apply.

Should the tag be:

  Fixes: 51081a3f25c7 ("bpf: track changes_pkt_data property for global functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============0146971734298480007==--

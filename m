Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23A381E92
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278218; cv=none; b=S0CpYrqsLzkf4z90q50TsHhPRMuwxuqRuEvBdKzGifZDlPhEscbGR6B+EEjcSpu7+L4u+V8f0W2hA6UaxWDYuilituyNDEEe3qqS2rsqtg4d0KKN7XCVtXwipYPCabKWPmXqwfqsCxui7aELD1BpHgJ8bcsJWp3T0lHUJOO/y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278218; c=relaxed/simple;
	bh=axcuLUHB0k4a2KhCUfjstGSqk1hdgwH3KjINxp48V6k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HSHC0bXG0v72d2Nb+P9PB2leXcNdCUAILqsIOvxWpGrzVRfxyoSQAvjOkPCeelXgM5hy2OABRyFAp5QHRp7aE6u9P743iJgaE26oGsmq0HDgEE8b6AITB4bqbIgm2PJgt3nL0mdK9t5UN+KWRKQGwahNIWohg5JouL+COkszIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiJnivKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiJnivKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2271F000FF;
	Tue,  6 Oct 2026 09:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278216;
	bh=d3J4sblRZznAwYcVBzkh+GKRvd7PAXWPvk5VNJVjGo4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KiJnivKUl4k1CTF+nx5vEmdXnpccjQXF3LyOdsonZx/faXiAjaRwdvtPt49F3+AJU
	 b4EX60NBVQmU2Gz9SeJARlmjoauYvWbzNzczp0XMWjQ+SMmIW/QvzKF5y3ZLliyDJh
	 bgsaA06HuYIXIrmQIzGA4cRQoD25Du1vABzOw9/Jtl6Jwv0QBGmWiQGKAdG1M7OnIV
	 qIECwnujDq/KtSeioopIYnSsUKC9YGmy4zt4GVxWjUJUPnnMsc13S5NdG9nR3AfRHH
	 CKWffxHxQ2ZZkKWkYT4BKpXa2PnOa7e6YCkQnO+vgbMb3oLXO5c3s3EDgYZ/ewOsWO
	 MaEJZHAhL85jQ==
Content-Type: multipart/mixed; boundary="===============2241733100726128338=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de5a36e24f7bc0709ba731a36ca665701efc411ea2e05fcc2ff708a8675d61e5@mail.kernel.org>
In-Reply-To: <20261006084604.780456-2-maghasi@disroot.org>
References: <20261006084604.780456-2-maghasi@disroot.org>
Subject: Re: [PATCH bpf v5 1/3] bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,leon.hwang@linux.dev,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 09:16:54 +0000 (UTC)

--===============2241733100726128338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix incorrect handling of user flags in bpf_percpu_array_update

TL;DR: Commit message only: the patch also makes BPF_EXIST | BPF_NOEXIST
return -EINVAL in bpf_percpu_array_update(), which was previously accepted,
but the message doesn't mention it.

>     bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
>
>     For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
>     is not considering the possibility of a combination of
>     (BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
>     This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
>     in some cases.
>
>     For example, using the (BPF_F_ALL_CPUS | BPF_EXIST) flag combination
>     with bpf_map_update_elem() results in an incorrect EINVAL error
>     response, even though the flag combination is valid.
>
>     This patch fixes the bug by adding proper flag validations and checks.
>     Before this patch, bpf_percpu_array_update() rejected
>     BPF_F_ALL_CPUS | BPF_EXIST and BPF_F_ALL_CPUS | BPF_NOEXIST with
>     -EINVAL. Also the BPF_F_CPU | BPF_NOEXIST were accepted.
>     After the patch BPF_F_ALL_CPUS | BPF_EXIST is accepted and
>     BPF_F_ALL_CPUS | BPF_NOEXIST and BPF_F_CPU | BPF_NOEXIST
>     result in -EEXIST.
>
>     Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
>     Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

The before/after paragraph lists BPF_F_ALL_CPUS | BPF_EXIST,
BPF_F_ALL_CPUS | BPF_NOEXIST and BPF_F_CPU | BPF_NOEXIST.  Is there a
behaviour change here that isn't listed?

The new check in bpf_percpu_array_update() is:

    if (unlikely(((map_flags & BPF_EXIST_FLAGS) == BPF_EXIST_FLAGS) ||
                 ((u32)map_flags & ~(BPF_EXIST_FLAGS | BPF_CPU_FLAGS))))
            return -EINVAL;

so BPF_NOEXIST | BPF_EXIST, with or without BPF_F_CPU, now returns -EINVAL.

Before this patch, the old (u32)map_flags > BPF_F_ALL_CPUS test let both of
those values through.  map_flags == BPF_NOEXIST was false for them, so the
update went ahead and returned 0:

map_update_elem()
  bpf_map_check_op_flags(map, attr->flags, ~0)
  bpf_map_update_value()
    bpf_percpu_array_update()

The new behaviour matches what the code did before 8eb76cb03f0f, which
rejected map_flags > BPF_EXIST.

The companion hash map patch in this series (e5859394034d, "bpf: Fix
incorrect handling of user flags by percpu hash map updates") documents the
same change:

    This patch also starts returning -EINVAL for (BPF_EXIST | BPF_NOEXIST),
    with or without BPF_F_CPU, which was previously accepted.

Should a matching sentence be added to this commit message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37439873908
--===============2241733100726128338==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DD388873;
	Tue,  2 Jun 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388113; cv=none; b=Xly2TUftcUUM7qBVmzLCGSsXD3vDttvx3zUHnfsxHsRAP7GobvGV9/WXqaGfalI4cNbm10ry5rygKFV/p7SaV992ZhX3AORmLiFcLoLFd8R7kQpiCwHUICzwEJbIgAO0IwgZLYnfeLFQ2UE+UR1qUtJnSXcAp/qv7P7wIx+1LzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388113; c=relaxed/simple;
	bh=f1nt/y4+7z1cpGMnJGu8fxq3kg5Yyllyw49r2hhNKmo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HEfm/Ia6zmKxzSiylNJSRGifF49o+lQFkeyM6JFQ1J05+qhqOOySOEgCXs/ga0sDFC5k6TivKyRipMP0TL1EBxN0qx9Y9rb5aCoaHqmwqAlACq8CZgp7D8HACcOI0R8ItYtQw1WlO0XAPw8tooXHdJXKsiczFmnXcfmA307e7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnKjAcXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnKjAcXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE13B1F00893;
	Tue,  2 Jun 2026 08:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388112;
	bh=fx8EiBkfFEr0Wtb03PZwYcY3r0X2ab4fhSX7uBhUyMg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LnKjAcXn21bgBT06yYG1YbvV45EJdA+Ru5z68Q7hbzKrvVNaWZAzAp07uIhpp7I23
	 FIR8XzPI/WNydvabhRAdoHf+bLTwtpp+JXiw/Zeg2NuV2i682R0t3hK7G66aOubO/H
	 cmyliC35liwMfDqaX4u6xF4JahO2QeJO7F8a2YtC324TFPCTchl5WrhwcKEapRKdVW
	 JOF6TGiqQM4CBt2vjXxFme1mFXBRiJIpaG4IArBPX0hv068nZCQxfEA8Tze2VRYmQZ
	 mS2zz/iFysNkLYsNIKSYOBhdIJ+7P2nfHU2MpKmlNs2y8PycM34KOiUhNxazx3zqdR
	 bgo7QVbU7dVog==
Content-Type: multipart/mixed; boundary="===============2932272912810588123=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f4661e6d1d9eaa6b05b0e6499562ad10ff8fa3b7bc6d44ec4019119fb547bd9@mail.kernel.org>
In-Reply-To: <20260602073539.1567846-1-malin89@huawei.com>
References: <20260602073539.1567846-1-malin89@huawei.com>
Subject: Re: [PATCH v2 1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
From: bot+bpf-ci@kernel.org
To: malin89@huawei.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: andrii@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,zhuyifei@google.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ameryhung@gmail.com,malin89@huawei.com,cuirongzhen@huawei.com,tanjingguo@huawei.com,cenxianlong@huawei.com,chenzhe@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 08:15:11 +0000 (UTC)

--===============2932272912810588123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Tighten cgroup storage cookie checks for prog arrays
>
> The recent KCTF-reported cgroup local storage issue assigned
> CVE-2025-38502 was fixed by commit abad3d0bad72 ("bpf: Fix oob access
> in cgroup local storage").
>
> However, the previous fixes are still incomplete. The current prog-array
> compatibility check treats a program with no cgroup storage as
> compatible with any stored storage cookie. This allows a storage-less
> program to bridge a tail-call chain between an entry program and a
> storage-using callee even though runtime cgroup local storage still
> follows the caller context.
>
> Require exact per-type storage_cookie equality when checking prog-array
> compatibility. This blocks zero-storage bridge programs from joining a
> prog-array owned by a storage-using program and closes the residual
> A -> B(no storage) -> C(storage) path.
>
> This also aligns with Amery Hung's earlier NULL-storage tail-call fix by
> requiring storage use to match consistently across prog-array users.
>
> Cc: stable@vger.kernel.org
> Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
> Tested-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>

Should the Fixes: tag point to abad3d0bad72 instead of 7d9c3427894f?

The code this patch removes is the '|| !cookie' clause in
__bpf_prog_map_compatible():

  ret = map->owner->storage_cookie[i] == cookie ||
        !cookie;

That permissive '|| !cookie' clause, which treats a storage-less program
as compatible with any stored cookie, was introduced by abad3d0bad72
("bpf: Fix oob access in cgroup local storage").

The commit referenced by the current tag, 7d9c3427894f ("bpf: Make
cgroup storages shared between programs on the same cgroup"), only added
the shared cgroup-storage feature and does not touch
__bpf_prog_map_compatible() or add the storage_cookie[] check.

Would this be more accurate?

  Fixes: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")

This same question was raised on the v1 thread by the bpf-ci review bot
(https://lore.kernel.org/bpf/20260601095158.1186318-1-malin89@huawei.com/),
noting that the patch removes the '|| !cookie' logic introduced in
abad3d0bad72 rather than the original shared storage feature.  The reply
disagreed and kept the tag pointing at 7d9c3427894f in v2, but the
reviewer did not acknowledge that explanation, so it may be worth
settling before this is applied.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26806034423
--===============2932272912810588123==--

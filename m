Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E6423E9A;
	Mon, 24 Aug 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579759; cv=none; b=agEUdA8d5m8Zy1c2F6FNNbnw6CmjdrEkEvZJgCq+DTcE5oQ5kzgkNC22qn+m6qgXJrBx4AkvFPRcOvUcBXYU0MI3IUl81Txh3KOlRTJbJWZ3BJu8sexw9FsVXy7rlM85cvcTOgyL8oHBGfdWcPE/46xjoaa/R+74vMWOfkt7ZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579759; c=relaxed/simple;
	bh=EmwhhVZEuDmumg7/TKVja1MwTxA/hztxH0vkSVEUNX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XN/klTjFP+KGDmU3+OXnvJrnRK21ikhTHU7E592U41bZ1gxnzmrcfjUdf6L0KNJSC8NeQ1goCNAB7ccfOpBMNh57MFknElZBIq64IAKb6kFjfBXpR1j3zMkVYR6v9DAUX5SoGwByYAdg06npHct7h8n/cg0a0GWuWNFlh5ZOCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbrL0a0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbrL0a0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC371F000E9;
	Mon, 24 Aug 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787579757;
	bh=C1WYsS6LJAsi+Ce/sXBWpQTEKvUILa8q+iRHbNW+wV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbrL0a0A2iCjCXvkUAto2mM6MNHUOr7OzCTQRDZCwa0pI0umkexDqzgFegRgv9R9E
	 QCEbOfkpoE1LqJ+2yvLnPTJzkgEUngAtEu1p9eCbiGy+MbTKA8qcvJJLndYCkyp87T
	 IbhvNFSbSSno2lhqmNN4z+Mf3kL3BXPRRV32lMznpvjFNmrov9KrRBKKpVBKwi5L8x
	 Lez17e5YopZILk+aFK+fa2gOR9JS//t4RJPVieryMj0Vu98Myb33CmYNvz+8KO6w+m
	 8KMVmYmqVH6A+UQr/mukBD8CdZWiNQIS5f+LAzfCl7hytbAzHXuNRM67tnWOhwpSyg
	 /M1Re+F1AfFQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260824133954.561956-1-cui.tao@linux.dev>
References: <20260824133954.561956-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:55:56 +0000
Message-Id: <20260824135557.2CC371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch fails to initialize the new `idle` field in `struct sc=
x_cgroup_init_args` in the sub-scheduler paths, causing it to implicitly de=
fault to false and lose the correct idle state.
--

--- Patch [1]: [PATCH] sched_ext: pass the initial cpu.idle state in scx_cg=
roup_init_args ---
commit 6b122f2bce26c31e18660129955114867f5a36b0
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args

This commit adds the idle state to scx_cgroup_init_args and initializes it
in scx_tg_online() and scx_cgroup_init(). This ensures that cgroups already
configured as idle before the scheduler is loaded are correctly presented as
idle to the BPF scheduler.

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 53e136a47924d..aa149a9c29f7b 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -259,6 +259,9 @@ struct scx_cgroup_init_args {
>  	u64			bw_period_us;
>  	u64			bw_quota_us;
>  	u64			bw_burst_us;
> +
> +	/* whether the cgroup is configured idle via cpu.idle */
> +	bool			idle;
>  };

[Severity: Medium]
When adding this new field, did we miss updating the struct initialization =
in
the sub-scheduler paths?

Looking at kernel/sched/ext/sub.c, both scx_cgroup_claim_subtree() and
scx_cgroup_return_subtree() initialize the struct but omit the new field:

kernel/sched/ext/sub.c:scx_cgroup_claim_subtree() {
    ...
		struct scx_cgroup_init_args args =3D {
			.weight =3D tg->scx.weight,
			.bw_period_us =3D tg->scx.bw_period_us,
			.bw_quota_us =3D tg->scx.bw_quota_us,
			.bw_burst_us =3D tg->scx.bw_burst_us,
		};
    ...
}

The exact same pattern also exists in scx_cgroup_return_subtree().

Without explicitly setting the idle field in these paths, wouldn't it
implicitly default to false, causing cgroups to incorrectly lose their idle
state when a sub-scheduler is enabled or disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824133954.5619=
56-1-cui.tao@linux.dev?part=3D1

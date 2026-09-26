Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1054704B
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382962; cv=none; b=SeIDgULFK0UphTf1t4BtsCmedmMxm3hngYsFDQNYrZ0TuNZ87ZJWWSPZVatGNwfZOlLJ/jPdqoUO/6KklKnMOOUJ27cLwBPx3UDrMtIy9W22RNV1sg7dFwcghKNARZ8Ph/z2GI1fzb8qiE11TAIfEkeGxbYXRDxmBtcz7bsPW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382962; c=relaxed/simple;
	bh=m7ktrSpaqn+VEcM4mKdnqDQdEpRXvNQnS0Y+xAsYKoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CiP+CHalXJebX73klfcoE59mMuFk4YvzHD0ibUtl5uVtIem04bgeQLwG/nn3w3HR2ALSY3BYxTrWr5mQ4e9UMuWRbWappTRMsIot/1l7cDcVpBFuuKrAzeMN05ZMWdYUczmE47B6mPqNSP5NxemFxU9TZqi8hD5eM6pHg/ZQlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ZDdg8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ZDdg8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DA31F000FF;
	Sat, 26 Sep 2026 00:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382961;
	bh=levBHbfWQ6XRcIoXkx/K/zRNBXy9gWpOS187sevqdnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9ZDdg8SUaLVw2cBWseLWYvXLjp8UEEQfvlIfZsLw/xNyPTJQ3zBFxMiaGX1AUffK
	 xCcATmbndZ5+xINbByl060nXGqHGLQmu/Itg6Ljv6k9Y7qlpohZCkU4NsPwL5LPoIt
	 94zp1UzjlgeQglySzQD+dVOuA1OcDqKVLw2n7v+0LvBbq+XProhGNVgD/z/hMtuTOL
	 +1hYO8YN07PUKbC4hQ+x96swGYI24KSo08Q+ZjEcBTATjjbhKck4j5pkPpT+h54si5
	 lL3ka4AokJLMIwRrLxTdAd7uwuDtAsX1lUEjWvs48l9+nOkyEeA02TmGT6UCXIvKyW
	 z2neVUoYCvwpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/8] eth: mpnic: start and stop the Tx HW
 queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-linux-mpnic-v2-5-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
 <20260924-linux-mpnic-v2-5-4badc9b58b9e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:36:00 +0000
Message-Id: <20260926003601.14DA31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] eth: mpnic: swallowed queue idle timeout allows DMA UAF
--

commit 9b058fd2b1d09b6f8ce72863ddb8a3c9c658d5a3
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: start and stop the Tx HW queues

This commit adds the routines to start and stop the transmit hardware queues
for the mpnic device. It provides functions to point the hardware at the
descriptor rings and wait for the DMA engines to become idle during teardow=
n.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index 853976e11b032..aaa3a3e99a138 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> +void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
> +{
> +	static const struct mpnic_idle_regs queues[] =3D {
> +		{ MPNIC_TWQ_IDLE(0), MPNIC_TWQ_IDLE_CNT, "TWQ" },
> +		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
> +		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
> +		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
> +	};
> +	u32 non_idle_bitmap;
> +	int err;
> +
> +	err =3D read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
> +				!non_idle_bitmap, 20, 500000, false, mpd,
> +				queues, ARRAY_SIZE(queues));
> +	if (err)
> +		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
> +				non_idle_bitmap, err);

[Severity: High]
Does this code silently ignore the timeout from read_poll_timeout()?

If the hardware is stalled or under heavy load, read_poll_timeout() times o=
ut
after 500ms. Because mpnic_wait_all_queues_idle() returns void, it logs the
error but hides it from the caller during interface teardown.

Could the caller blindly proceed to free the ring memory back to the page
allocator while the active hardware is still performing DMA transfers into =
it,
causing a DMA use-after-free?

Should the error be propagated so the driver can leak the memory or trigger
a hardware reset rather than risking memory corruption?

> +}
> +
> +void mpnic_flush(struct mpnic_net *mpn)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-linux-mpni=
c-v2-0-4badc9b58b9e@gmail.com?part=3D5

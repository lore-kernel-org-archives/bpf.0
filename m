Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DC3988E3
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970531; cv=none; b=acU7JfqMb/L8se8nrbb+ulKJhvOpYYxG/jr3mNebiQRUy8xSCKxu+imGU9kS12n9mGmmWnyFSfOHmCfLR9Xn5rXyXMsbG8VdLhQM4BXu0rQITn2B5YMei3NAciPEsaGrWOkCSWkIBadmduUcgKY1Owiib+6xO8qgSs+FyVEnhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970531; c=relaxed/simple;
	bh=IGKuxLhgPQHaV1i2dr8oaRbKkdNapfYgtA4yp0+O7FA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m68nRZZt01ZtXs0Tqugcb+Z+CWUoypT9XBfIm0arqzmz1B0DtoCJxk/CHDmXSxAQPtkVnDAO+xCS9BWIkGHeoGzmsyS/oqWPA3LG/6BZPIqtbcX4TNVQrCuyXG2JHPHxRq05342vthW9r5NOhnUnmdikb4J7WNNytEovlOhsnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLqoZCY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLqoZCY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAEA1F00A3D;
	Sat, 25 Jul 2026 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970528;
	bh=WhHibsTIC2CE/fYL7Ny6iXcLDa4H46F4/eV2WVNXCjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLqoZCY04T0p6QoflE6rKuuHBYfOIgDBHEriakMe071J8HTx6nfwyTlIsTVles4+X
	 lrl0iXvQKFDYefX7ol03ie8RUQFADGwckMNIQtydJFo8XdQPUVuwtOsTEmNi5gTYVS
	 uk4rLBRaB4STkBvcX8uF5p0uRpS6AMCPo6NzKAinBsrwuD295p9cRVA3IFmjxHgLfg
	 w90x0TR1u92HOkxNhpCNoQX73RyuKSCAFg4EfMtOgrAPih9ToicHtPu6cH16nLn4iS
	 Kn8WINK3qgmBo5Q+tre7OJfVAbjLRs0sj/1RAGD+CKg7xAs5pdRkMqn760c6Cdneep
	 ApjLmsGJSdEFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: atlantic: free RX pages of
 consumed but not refilled buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_F0FD0A4E6AFB381AE042C7AC87583506F10A@qq.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_F0FD0A4E6AFB381AE042C7AC87583506F10A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:08:48 +0000
Message-Id: <20260725090848.6DAEA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The PTP TX ring leaks SKBs and their DMA mappings on shutdown or=
 error unwind paths if the hardware has not completed transmission of all q=
ueued packets.
--

--- Patch [2]: [PATCH net-next v2 2/3] net: atlantic: free RX pages of cons=
umed but not refilled buffers ---
commit 7a64d2b15db815d6730701e2ca08b6013f4f4ae8
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: free RX pages of consumed but not refilled buffers
   =20
This commit fixes a memory and DMA mapping leak in the atlantic driver that
occurs when the interface is brought down. It modifies aq_ring_rx_deinit()
to exhaustively walk the entire RX ring and release any remaining pages,
rather than only iterating over the region posted to hardware.

> Walk the whole ring instead and release whatever is still there. Also
> bail out if the buffer ring is already gone: a partial
> aq_ptp_ring_alloc() failure frees the ring but leaves aq_nic set, so
> aq_ptp_ring_deinit() still gets here on the unwind path.

[Severity: Medium]
This is a pre-existing issue, but since the commit message mentions the
unwind path via aq_ptp_ring_deinit(), I noticed how the PTP TX ring is
cleaned up:

drivers/net/ethernet/aquantia/atlantic/aq_ptp.c:aq_ptp_ring_deinit() {
    ...
	aq_ring_tx_clean(&aq_ptp->ptp_tx);
	aq_ring_rx_deinit(&aq_ptp->ptp_rx);
}

Does this code leak SKBs and their DMA mappings on the shutdown or error
unwind paths if the hardware has not completed transmission of all queued
packets?

Since aq_ring_tx_clean() only iterates up to hw_head, it leaves pending
descriptors uncleaned. Should there be an exhaustive aq_ring_tx_deinit()
call instead?

> Fixes: 46f4c29d9de6 ("net: aquantia: optimize rx performance by page reus=
e strategy")
> Cc: stable@vger.kernel.org # v5.2+
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 81685a4dc5a6d..e1193c6719d9d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_1F173E0FC16=
06D2AC704DC9C98AF10984607@qq.com?part=3D2

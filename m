Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAB3E1230
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140880; cv=none; b=Cx9MVHMuqWjEGYnmslw1HDoG13h/oamLHo5mp7dfp312A9Vp7+x+az4FNPgYV7x7LAlbQ/1Ym/2fNdpKaOxk9FtKFqHcWnOylQvOfmPJgzJG/XH9HvnEBndqhXQngDNnKSaFTgaE/ILOjUEPMCbAqrTDR7h59MDJigjBPVUe+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140880; c=relaxed/simple;
	bh=qR4IWlBtC3RU+wPpt4QQPuM0pjmesCDHhBX2HwxEF2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJxVnggRszDkFcZdU7MdnYMY+BBGMMyaeoQ41RlO9NmYn/OrUtavqLJ9dLSi1u1uRAQZkYgkTsKRR/aH7ATrIGkETP0eINegu0+v7osqGA4je7yKjf0RQX0Igq6MZxqGamVqS6Nj0BICMtBpeOvaj/NCX/CYhnQ4vy5uB3wdY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XnVDA1Lm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XnVDA1Lm"
Received: from localhost.localdomain (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 21CA720B7166;
	Fri, 11 Sep 2026 08:33:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21CA720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789140837;
	bh=qR4IWlBtC3RU+wPpt4QQPuM0pjmesCDHhBX2HwxEF2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnVDA1Lmk1Jl/V4hyy0mNdnGdcltrQvbxGInz7ibFMnvIPtIv9Clj7tvHhKU91xoO
	 ZTff/WvKrTOJPIdEPUrdsaFMGcyD/QPRoN425LBaF6AFyetrQKDZwg3jt6OzbtaIQi
	 jvWQODOaPezxBAXzBYXF/b8X3goTL6UIjcWpOIR0=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: AutonomousCodeSecurity@microsoft.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
Date: Fri, 11 Sep 2026 11:34:24 -0400
Message-ID: <20260911153424.7051-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911142808.1B1581F000FF@smtp.kernel.org>
References: <20260911142808.1B1581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is a pre-existing issue, but does assigning the socket pointer to
> ctx.sk ... introduce a use-after-free risk for non-RCU-safe sockets?

Yes. As Amery noted in the v1 discussion, "It looks like a valid issue
that should be addressed in another patch" [1]. It requires separate
handling and is independent of the NULL selem->local_storage dereference
fixed here.

[1] https://lore.kernel.org/all/CAMB2axPQ1LVXNybsPY7RNa+12+7mtLaahvr0vFL-xHf8sbJK8A@mail.gmail.com/

Thanks,
Cen

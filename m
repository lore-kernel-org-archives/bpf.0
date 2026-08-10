Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533533F4DC5
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371524; cv=none; b=IfkN0+V+nikZQIPdScAGC7jO4lmzugE7HmY0e2+Tk/A3KKCrdlUTQ8H1lbb1n//eBE9zYmo4M/ApHvFqlfjT0PMAHq1+yhpcZ/VAhhov2gdD4RYRltl//jcNew/MboZR3pWzkNqzVAb7bfdk+x9oEpjmPe6p6kjXhtqgPI0YeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371524; c=relaxed/simple;
	bh=xJWm1qG3Gt0G7if6H4r4B3dNtTSOPHvzoyirTCp7yUE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5mXUokiEkxVxe51ta5rMrg6VwIBnJegTzbBd6h+IDQx6pjhujYC1QHSXg1c3/8wxVX7zyEHdJPeC0+GuzoUCLco4KQJaTEywlEPkVGTw70LCtSsTLZbZbjW8G5fm8VpUnDbkEBjoKmd/vOeryXtrWik4+p3bhubzXWKjlqDEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=O0OBWKSW; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="O0OBWKSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786371509; x=1786630709;
	bh=xJWm1qG3Gt0G7if6H4r4B3dNtTSOPHvzoyirTCp7yUE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O0OBWKSWan280kOfk3GKGCNkMaghmWrxXbAGbcgdQeS2bdJaWckd3tNxI+hqzYFwK
	 xvwCD6JHchEgRBh4YX5Lms4LwwfVBA6KAXZhQpOIzeliWZ42tGIo4GQ+Ss0qCNoX7h
	 QrWB65isrzvmz5Aifp1/M2CkRsvU6ymL2XTt0l4ajq6tljDFp5KRfHjP/WDJosyZtJ
	 YNpnlQaI9DeCNzY3K4a5zLArL2QJVYRd3ot4VOupoVjzNNFLlTS5bmnTSmVaI8ddUP
	 8R01PshmjKwOAnpoPnSc/KR0saNIUWMdh1OxW3L0bxz9IBAsPce0FGlb9HtEcyWm9Z
	 NDAH/vpkx+CrA==
Date: Mon, 10 Aug 2026 14:18:18 +0000
To: bot+bpf-ci@kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, shung-hsi.yu@suse.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4 3/3] bpf: Avoid redundant min()/max() in cnum signed bounds
Message-ID: <20260810141849.17511-1-vldsampaio@pm.me>
In-Reply-To: <a4326cfb5a7bacd867b09b252cb9af1d1bc16ab9c3f5c3cfda7c4efd456f0c53@mail.kernel.org>
References: <20260730102129.15209-4-vldsampaio@pm.me> <a4326cfb5a7bacd867b09b252cb9af1d1bc16ab9c3f5c3cfda7c4efd456f0c53@mail.kernel.org>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 642cfa13490b275761ca9b722b965a91a977472c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Does the new precondition match how these functions are actually called?

Yes, it matches, currently no input cnum can be empty in the verifier. The
previous result was also not meaningful for empty cnum's. We left the empty
check for the consideration of performance and to match the old implementat=
ion.

> Should the precondition be enforced at the call sites, or should
> smin()/smax() keep returning an ordered pair for EMPTY?

The precondition is enforced by the caller as it was before.


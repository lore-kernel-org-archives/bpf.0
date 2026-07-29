Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516C4D2EF6;
	Wed, 29 Jul 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336891; cv=none; b=D/56KNzWhrLiXVtA3uUrfXp+Xv/J5QqizlzeR4L6lAe14HFElbSiUTDZp6c48c95T2Y6Odzj990lN/iUyyRx0LcFmn2L5iLLiyYjPMAghKumTDri1WgW/8eREE+YrXQpLLndqDqy5VxfeBj4m1HvEEMt/PVHuxZylgWGmAv/nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336891; c=relaxed/simple;
	bh=0Ceak2M82FucVlHM9Zau0MlNA0nFVtDu+8nn7FI1Pm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWOW68kY5KO17qZTQjr2Hk3YMJGwUYVH8gZGCh5CTFD0dAx2/luNXMWdrI/gsVCrNFfMbKGiIvo4LV27QcIPVt31FoZ91QZRRNr4j0Xe+mUvs6JJ4bXGjjt7hU1pRuA9tjbZjBHRPMKu+ncXzG7EAeQGz/x2BvHB7hhzbMAwodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=UXDvj4TD; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="UXDvj4TD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785336886; bh=0Ceak2M82FucVlHM9Zau0MlNA0nFVtDu+8nn7FI1Pm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXDvj4TDkCn1l7vovDPDWecG1XB4GAe1LDu3VH/5ObTIjRTGHSVSXq3CRDvr4fVws
	 bVrjLCVnlcLZq2lBd7T2PVacP0s1aizdZDuPcVLCjj9959n4jdFTa6uc0dS1HV7HUH
	 90rdJKUWAFvVDqilNNKsBI1f4Si1VlF9TPLHWl3itX3BWL41fPz2nfK3+5DNtp0jgL
	 H1cQkkNKEfUySn1yh2tk2c9DVA075NguTcQ25g9j+3iFnMxGgk9qeNH5NTu2x2lzXc
	 d0k7r6+zc5OuqmuF1U6ZmmrR+Cx2j9jcdinzQ2MsUu0J/HixH4k4h5/dDK7cF1h5vp
	 EXt3bPCjOWahw==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 3922341CD1; Wed, 29 Jul 2026 15:54:46 +0100 (BST)
Date: Wed, 29 Jul 2026 15:54:46 +0100
From: Sean Young <sean@mess.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-media@vger.kernel.org, bpf@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 00/15] media: Fix leaks in rc core
Message-ID: <amoUNjKOyFMudlDJ@extorris.mess.org>
References: <cover.1785158244.git.sean@mess.org>
 <aa8628c4-0106-4dcf-afea-b350daef0f96@web.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8628c4-0106-4dcf-afea-b350daef0f96@web.de>

On Wed, Jul 29, 2026 at 08:18:40AM +0200, Markus Elfring wrote:
> …
> >   media: rc: Fix use after free in bpf progs
> >   media: cx88: Specify rc type at rc_allocate_type()
> >   media: saa7134: Specify rc type at rc_allocate_type()
> >   media: rc: Fix race condition during rc_register_device()
> …
> 
> How do you think about to reorder desirable adjustments for affected modules?

I'm not entirely sure what you mean. Do you mean just sort the
commits so that media: rc: .. sits next to each other?


Sean

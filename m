Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725C326957;
	Tue, 27 Jan 2026 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537717; cv=none; b=RK7zlUxGhLiWeutKdqHPCoUE/vWxBRulF59wMr7vPeHnR04xdKbLahzQVmxxaiXZ27SDHpZQ5ILHgjhHDIAfesX+8d1FNkEFV9CeaSJHF/WwhoxU06DbXGeSwo+30V0fcKpKLLYE/yiGYwvjQ++vNbERF5f5wwLFAIDkfaDVybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537717; c=relaxed/simple;
	bh=K7ZXAlrlJglke6uja+zB0HsVLBt+qPzcl3G3KJMH1Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeMY/WqOrkNiP7PQfGujNLy5THBoA75x58zxQkkGUBCP/zvmJRFHK8CMgSBgAFyDuFtKw2o6WCWHe9TvT2L2Ubh+ZejgmWYcosNZewA52xCiCZ+gyTMOAsNDpcx2/YjqwqePi87t0tefXA0tEx8Wqb9msMmTFpfL5VlHBQtSkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY1mO7Ax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY1mO7Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93691C116C6;
	Tue, 27 Jan 2026 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769537717;
	bh=K7ZXAlrlJglke6uja+zB0HsVLBt+qPzcl3G3KJMH1Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eY1mO7Ax0SWfRH9whpVFROYiJyOF5PqTkYYdtm9NKXMcBg55xa8OU9O5cHCOZdXzH
	 vmlXrkj3mPfZ2REZ8Rj17JRlKwug20joCcuyhmyEcsfXWTpQC3c5QsQWNhKy4l2ujT
	 z3OTnjr6MODuYJVIG4v60HdQ1Nk1QiYpBJnMSWp1zUOfiMSe7RZe/oTIl/JwDiYCbw
	 iPFe0nnpndjC8tZ6bg25Ddk1ds14WC2OyMowjoy/U1IaJpjL4qc0eOQEzcd7mQN5lE
	 +fCJFlmDHs4LEQL1PftmEkw0+p077yfn3UX3aWdLXsI2UghGmxae8SSrewfz2dYyKC
	 M4H0v4ClgUCcQ==
From: Simon Horman <horms@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Simon Horman <horms@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	john.fastabend@gmail.com,
	sam.chen@nebula-matrix.com,
	sdf@fomichev.me,
	lukas.bulwahn@redhat.com,
	kuba@kernel.org,
	vadim.fedorenko@linux.dev,
	edumazet@google.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	linux-doc@vger.kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: Re: [v3,net-next,04/15] net/nebula-matrix: add channel layer implementation and the corresponding hw interfaces
Date: Tue, 27 Jan 2026 18:15:03 +0000
Message-ID: <20260127181503.1439691-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123011804.31263-5-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add intr resource implementation

This patch adds MSI-X interrupt vector management for the Nebula Matrix
network driver, including dynamic allocation of interrupt vectors,
mapping table management, and interrupt enable/disable support.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index f6fd151141d5..b8653e0039d7 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h

[ ... ]

> @@ -10,12 +10,20 @@
>  #include "nbl_core.h"
>  #include "nbl_hw.h"
>
> +struct nbl_resource_mgt;
> +
>  #define NBL_RES_MGT_TO_COMMON(res_mgt)		((res_mgt)->common)
>  #define NBL_RES_MGT_TO_COMMON_OPS(res_mgt)	(&((res_mgt)->common_ops))
>  #define NBL_RES_MGT_TO_DEV(res_mgt) \
>  	NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
>  #define NBL_RES_MGT_TO_DMA_DEV(res_mgt)		\
>  	NBL_COMMON_TO_DMA_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
> +#define NBL_RES_MGT_TO_INTR_MGT(res_mgt)	((res_mgt)->intr_mgt)
> +#define NBL_RES_MGT_TO_QUEUE_MGT(res_mgt)	((res_mgt)->queue_mgt)
> +#define NBL_RES_MGT_TO_TXRX_MGT(res_mgt)	((res_mgt)->txrx_mgt)
> +#define NBL_RES_MGT_TO_VSI_MGT(res_mgt)		((res_mgt)->vsi_mgt)
> +#define NBL_RES_MGT_TO_INTR_MGT(res_mgt)	((res_mgt)->intr_mgt)
                                                ^^^^^^^^^^^^^^^^^^^^^^^^
Is NBL_RES_MGT_TO_INTR_MGT intentionally defined twice here? It appears
on both lines with identical definitions, which will generate a compiler
warning for macro redefinition.

> +#define NBL_RES_MGT_TO_PROD_OPS(res_mgt)	((res_mgt)->product_ops)

[ ... ]

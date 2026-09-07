Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5B1799F;
	Mon,  7 Sep 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739445; cv=none; b=VYFQna7UQsj0cp7spxCTQBktC1keqr6fcXO6Zf/G/PJ3xD3wZ27y0vUgjME40X5tqKpjhEorh6iLirFTYgqlvZWm8fLsdiJxNHEKH38U16Kvem6y1phdbK4AAYDJvL3BND691VygWxzmbymg4cCfOafRiuLTQp3dXxRo2WqDbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739445; c=relaxed/simple;
	bh=q1pQSZvQesRSxgU7SiEG4r9YU/kd9IhsNQnzrCb401U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBlDoOuY0LzfhCfqqj5blFogO5i1BNmMmh5OU6tRLiWN070UaiDLUwZvp6E3At9zuXDgA8fvmX2GNALwzZxIO957UpcVhQ4mDffiYn40ZES6CvAVx2GnLtnB4ksXcteZvXE2OsYMXyOUkvZI2oZAwFINooE06GVceq1N0cSIqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B97LxB+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B97LxB+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1211F00A3A;
	Mon,  7 Sep 2026 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739442;
	bh=oD73FkIUvgAtG4UpDGnlzd1Ds9Ly7ZbksvsTZGMHFMY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B97LxB+uaiv0jlB93ECuTuyBcG8bD6KQiX9uMJXvSO1PoaiCZZVTTCQD2VK9CW7bP
	 MX0xfpnV02tldRhkD7ukOlPZPoAYf9sSXRRPZH0u8dYYoFil1EnqjfHRFkZMaH8+jE
	 3Pf7kknl+hpXVjlWEox4pCdLwRQK0KkqSJqUriya2yMNaX0GEUpGIxQ0f+EQIWXfXn
	 M2rfhjGZ+NajiNgjLkjgiIgEWhMWrPTbyC4nGVo6K0wz9G1HOO8d0mqdnmLutW6v/Z
	 m8JE36HnmjJ86xjJfk3gwCCkFeSD12w3jSfu8kuetzez4luM61sPBkf6fcpjAf3St8
	 0FaCLvzkWyIpA==
Subject: Re: [PATCH net-next v5 08/12] gve: split up notify block allocation
 and setup paths
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com,
 jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com
Date: Mon, 07 Sep 2026 00:04:00 +0000
Message-ID: <178873944067.219967.11560477351293500761@kernel.org>
In-Reply-To: <20260903215606.31633-9-hramamurthy@google.com>
References: <20260903215606.31633-9-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Style artifact: removing the old gve_free_notify_blocks() body
  leaves two consecutive blank lines between the end of…

--

gve: split up notify block allocation and setup paths

This splits gve_alloc_notify_blocks() into separate allocation and setup
phases so that MSI-X vectors can be requested after the IRQ doorbell
offsets are known. Teardown is handled by a new
gve_teardown_notify_blocks(), tracked by the new irq_requested and
mgmt_irq_requested flags.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 5ad7a8f9bbddb..619ef46a7b30a 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -538,61 +596,12 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
>  			cur_cpu = cpumask_first(node_mask);
>  	}
>  	return 0;

[ ... ]

> +abort:
> +	gve_teardown_notify_blocks(priv);
>  	return err;
>  }
>  
> -static void gve_free_notify_blocks(struct gve_priv *priv)
> -{
> -	int i;
> -
> -	if (!priv->msix_vectors)
> -		return;

[ ... ]

> -	pci_disable_msix(priv->pdev);
> -	kvfree(priv->msix_vectors);
> -	priv->msix_vectors = NULL;
> -}
>  
>  static void gve_free_control_plane_resources(struct gve_priv *priv)
>  {

[Severity: Low]
This isn't a bug, but removing the old gve_free_notify_blocks() body leaves
two consecutive blank lines between the closing brace of
gve_setup_notify_blocks() and gve_free_control_plane_resources():

	abort:
		gve_teardown_notify_blocks(priv);
		return err;
	}

	static void gve_free_control_plane_resources(struct gve_priv *priv)

checkpatch reports "CHECK: Please don't use multiple blank lines" here.
Worth dropping one of them so the submission is checkpatch clean?

Note that the next patch in the series, "gve: introduce new methods to handle
IRQ doorbells", happens to remove the extra blank line, so the artifact does
not survive to the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769E10F0;
	Mon,  7 Sep 2026 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739455; cv=none; b=uxi1s9Gden4StUZXit5W5f2tIKMH5JZfaMMQPsmHPFlgjUfrZL3YrCCzrYjQxgj3zHcc3qf6xrsJZ7h97t6PjwyGfcusIHfcKMX0XEZvC6q6RJFk0Fdl2nOO3vB7U5l60fEBuaz5dt2zqDsb8cVXkkN3TdvIctbGkAtHGtrdMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739455; c=relaxed/simple;
	bh=djpXOHjoWiFjiT5nNO4Lo8kjMOLJuJyHzz666JBCbqI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h29Iu/LlFcQiHllgpMtk0rmtzWmJUo+l7HIGDsqlM4I/ZPayNkwAsOfWGJ/5bYkanq0fi2N9GlPNXPv/lOaDhGYxQAoEOhrBtrLOW420iPHLE2KXk9lpitJAN9zh/s5q9d+Su0sWvaScOGvXdqWEYMCGZtmJvyQXqPeo1zqPjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c90eTKMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c90eTKMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01EF1F00A3A;
	Mon,  7 Sep 2026 00:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739448;
	bh=wKA8NqDMPCDgfTpSSqkyVgeQHJUDiL37zmQxF4Gvu4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c90eTKMR6apTuyfqyiV6/rVuflWnPLrVWVlAcqBkquNWXw0iiVAhD5pP/dfBavDGt
	 XtojeAD1v500lbOTiuEevPnud9Fjuc+oW0VMSUGcIJW94ZBToHpRPB1ALsHwfiO0ln
	 AGu8DLlXfUOQk5KxP4gb7N5oVqq9VwkAnorsRRggCZ7n1opv5KlK+l9QI8eZIfXaPO
	 W1xS45kxI2/6wE5Fvofx3SBcfuMMG2U6SySUwSYbUTLA2aVMt2Un+h37lcDp07cpXu
	 w/cK3qLKe67oZG0KrBMcqXXslROYmfuWdXzHK+0Z7j0DSTvFM1uZ8dBySnvKoSEXgg
	 4HfYVITOt9LlQ==
Subject: Re: [PATCH net-next v5 12/12] gve: add link status/speed ctrl ops
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
Date: Mon, 07 Sep 2026 00:04:06 +0000
Message-ID: <178873944639.219967.903933985096101932@kernel.org>
In-Reply-To: <20260903215606.31633-13-hramamurthy@google.com>
References: <20260903215606.31633-13-hramamurthy@google.com>
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

- [Low] Unrelated whitespace-only churn bundled into the functional hunk
  of gve_get_link_ksettings().

--

gve: add link status/speed ctrl ops

This converts the gve link status check into a control plane op and adds
an AQ-mode implementation that reads the device status register into
priv->link_up.  It also adds a report_link_speed op that wraps
gve_adminq_report_link_speed().

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index dd1c44fedc771..a3220c6514382 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device *netdev,
>  	int err = 0;
>  
>  	if (priv->link_speed == 0)
> -		err = gve_adminq_report_link_speed(priv);
> +		err = priv->ctrl_ops->report_link_speed(priv);
>  
>  	cmd->base.speed = priv->link_speed;
>  
>  	cmd->base.duplex = DUPLEX_FULL;
> -
>  	return err;

[Severity: Low]
This isn't a bug, but is the removal of the blank line between
cmd->base.duplex = DUPLEX_FULL; and return err; in
gve_get_link_ksettings() intentional?

The only functional change described for gve_ethtool.c is swapping
gve_adminq_report_link_speed(priv) for priv->ctrl_ops->report_link_speed(priv),
and neither the commit message nor the v3 changelog mentions a whitespace
change here.  Could that blank line be left alone to keep the hunk limited to
the ctrl op conversion?

>  }
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com

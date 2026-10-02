Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7C47CC6B;
	Fri,  2 Oct 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935598; cv=none; b=pINAbKEvtGnjzgFUSVqAoKck/pjAknys5Q7Z+T654r2/ffEJzbnjyrU37M7c6a5SFvmjEmf6X3faOEbFvOxLLTmiNeREeWw9KcM4boJH01pDKUbTnxqcGuaw5i18A/qTNZZYluRSv80di2vcaml6FIK0yTpHsBCmNK/dXLgF9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935598; c=relaxed/simple;
	bh=6e3ixlPhj2awVe6UBr1r3Vk/nLEDUyj56oDj+hEmPlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kpo8liKFe93dAy9ZLKOnnx4tpc16NLClplIjZy38IEXiRJnNNjy6Qk2XBMN6LRtSe8YhGsk5iA925Y4kSBcHC/EOdGWstYv1jkuIcuKWyD7LHFw3Ti4BpnvZXoUPDJMWMiw7ZEh+9s/ruiytMbPbFPg/Suh3kkAUcKzlp5U2oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GssloII+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GssloII+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68531F000FF;
	Fri,  2 Oct 2026 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935597;
	bh=8TEC1HD9JbWNujBBLtY1hgXsr60/d2F8yvalrlFhfYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GssloII+A/kscv21DXHIvaQruprJQSj+YwJ2Quvkfe4vbU8JYwKYByShYdmHlbDJh
	 3C2ecEoVWb6zcLsFSMIYaqbhiX3PjOqRTRm1fkX5QsrWm8gOfrr5YCan2xSs3oalVx
	 Wyc4iVrik3dyyUXtCOYTfDwUs/viqrBrtde8xzy4S947Vcovr4s/elNQQm2u1e8PbI
	 TzW92caKviuzvzhRFANAXDg3zj59Bsk0Y+rSX5mqnLPeGhTriDGyky3WgE77AgSLMe
	 3Ez7ZV2ZJRZO+7ldvP+I5J8Wv6X71ALGJaLTEbQ9BqCGnCmHRdQBM6rcn7LCfbXs7w
	 ZXQE+Zkq4qKjQ==
Subject: Re: [PATCH net-next v9 07/12] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
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
Date: Fri, 02 Oct 2026 10:06:35 +0000
Message-ID: <179093559552.434549.11576041887360278845@kernel.org>
In-Reply-To: <20260930190428.1130007-8-hramamurthy@google.com>
References: <20260930190428.1130007-8-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] After this patch changes the prototype of
  gve_adminq_get_ptype_map_dqo() from `(struct gve_priv *priv, struct…

--

gve: add gve_ctrl_ops for gve initialization/teardown sequences

This commit adds get_ptype_map, configure_rss, setup_stats_report and
reset_flow_rules callbacks to struct gve_ctrl_ops. The adminq
implementations are wired into gve_adminq_ops, and gve_main.c now calls
these operations through priv->ctrl_ops. gve_adminq_get_ptype_map_dqo()
now writes to priv->ptype_lut_dqo directly instead of taking the lut as a
parameter.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index fe1e8868cdfe2..5e51c060e2372 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -652,8 +652,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
>  			     dma_addr_t nic_ts_report_addr);
>  
>  struct gve_ptype_lut;
   ^^^^

[Severity: Low]
This isn't a bug, but is this forward declaration still needed?

The removed struct gve_ptype_lut *ptype_lut parameter was the only user
of struct gve_ptype_lut in gve_adminq.h, so the declaration now has no
users. It is also still present at the end of the series, after
"gve: add link status/speed ctrl ops".

Could it be dropped in this patch, along with the parameter?

> -int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
> -				 struct gve_ptype_lut *ptype_lut);
> +int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);
>  int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
>  void gve_adminq_set_num_queues(struct gve_priv *priv);
>  int gve_adminq_map_db_bar(struct gve_priv *priv);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930190428.1130007-1-hramamurthy%40google.com

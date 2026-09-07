Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8711F936;
	Mon,  7 Sep 2026 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739454; cv=none; b=Q+hq//2IlRUEyoFdXIJaCBSVwjpXvrXhNR+gCthZzVJcg+OZIA2wBzFKgMWkwqA7DGCDktRBl/PCOv5AZVnFKnch3rwKtqwE3Qf2UYyoOmWKi4ClY/Inzx/D6J5SyVSSWXByzWebTj1clw4cjYNH3jB4ugxAPeJt1zk21BI25eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739454; c=relaxed/simple;
	bh=m7ERNSKwnjjy8TO1w3Mhbo1/waajoi9fxfYZxqZJhB8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pf2PW+0IMqXmeb8nymMan0k5UXa7too0BGgK58RKmRPfKEaJb7KwblX2DeOwWqbMc+TjwI9WTG541MJacu8e7OhJ+iX9A8FymfofglOBmiHngkkz43+TQDGydmdntlmF5x74JIJ0++26jbAuZvlU/ImPPRfOUi16PozUUq/3pUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYThLNw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYThLNw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67091F00A3F;
	Mon,  7 Sep 2026 00:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739446;
	bh=+lvF7Gg0E3cuIVm9ZP7MgfZkkUL4P1mgfGLZkZ5OG+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AYThLNw9w6LlnzJS/3lvM+Yl09EYmFXRPFLmOqoQCAybvT3nJK71d0zJltmMJq8sY
	 rnbUPd9mKDLn6DTsEzUYxhh1XVYVXdfAWIGPmjHLGPVj40tPBPQibsy59n2t2nMFww
	 tyhmiqOFK+rpg5ms7TSNDb+0qggt2rCVILLZIp6QxpnO0t9IeXBh5Tu+JNRujMs2q6
	 IEp1i8q3Gwhm6QSQb+gor9WKbftc7p/vMZrVT/PXLQa6Wq+Mm0lGNGX+4HUlCdN1mi
	 0C4tLapKn7a84yTo6Huiu1waySxgRneMOSQJWDnwffpmXbPZMjEX2rA8RbrsynCIGK
	 cFkpJCFUzmXjQ==
Subject:
 Re: [PATCH net-next v5 11/12] gve: add ctrl ops to for queue operations
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
Date: Mon, 07 Sep 2026 00:04:04 +0000
Message-ID: <178873944449.219967.2021286132976115144@kernel.org>
In-Reply-To: <20260903215606.31633-12-hramamurthy@google.com>
References: <20260903215606.31633-12-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Unrelated, undocumented interface change: the patch drops the
  `const` qualifier from the first parameter of the inline helper…
- [Low] Commit message defects that will be permanently recorded in git
  history: the subject line reads 'gve: add ctrl ops to for queue…

--

gve: add ctrl ops to for queue operations

This adds create_queues and destroy_queues control ops to struct
gve_ctrl_ops, moves the existing per-queue create/destroy loops and their
logging into gve_adminq_create_queues() and gve_adminq_destroy_queues(),
and makes gve_create_rings()/gve_destroy_rings() call through the new ops.

> gve: add ctrl ops to for queue operations
>
> Add the next few control ops to
>
> - create queues
> - destroy queues

[Severity: Low]
This isn't a bug, but the subject line has a stray "to": "add ctrl ops to
for queue operations" reads better as "add ctrl ops for queue operations".

The body sentence "Add the next few control ops to" also ends without an
object before the bullet list.  Should it read something like "Add the next
few control ops to:"?

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
> index 5871f773f0c70..ce402020dff6a 100644
> --- a/drivers/net/ethernet/google/gve/gve_dqo.h
> +++ b/drivers/net/ethernet/google/gve/gve_dqo.h
> @@ -66,7 +66,7 @@ void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);
>  void gve_xdp_tx_flush_dqo(struct gve_priv *priv, u32 xdp_qid);
>  
>  static inline void
> -gve_tx_put_doorbell_dqo(const struct gve_priv *priv,
> +gve_tx_put_doorbell_dqo(struct gve_priv *priv,
>  			const struct gve_queue_resources *q_resources, u32 val)
>  {
>  	u64 index;

[Severity: Low]
What motivates dropping const from priv in gve_tx_put_doorbell_dqo()?  The
commit message says the change is "just moving existing code into ops, no
functional change", and this hunk isn't mentioned.

The body is unchanged and only reads from priv:

	index = be32_to_cpu(q_resources->db_index);
	iowrite32(val, &priv->db_bar2[index]);

All callers in gve_tx_dqo.c (gve_xdp_tx_flush_dqo(), gve_tx_dqo(),
gve_xsk_tx_dqo() and gve_xdp_xmit_dqo()) already pass a non-const
struct gve_priv *, and the signature is still the same at the tip of the
series, so nothing later in the series appears to need a mutable priv here.

It also leaves the neighbouring helpers in the same header inconsistent,
since they keep the const qualifier:

	void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);

	static inline void
	gve_write_irq_doorbell_dqo(const struct gve_priv *priv,
				   const struct gve_notify_block *block, u32 val)

Could this hunk be dropped, or the reason for it be spelled out in the
changelog?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com

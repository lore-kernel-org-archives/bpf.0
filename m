Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7243E9C4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558996; cv=none; b=lbv4kOudAOjC8SZ0DYrYTppfIy7UgDnhNskKwGRmrXO079R+cVY9mHN9CNFtdqomXg1/CJEmfnXd2m9SKmdxX0eROX8OtoZNqPrbx9uqMPo9KZFAeULGY6zlWrQW3j6yY4vhhTPggxo5HQc0RL2yxeNf5p9CYnv0WKyMij4tMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558996; c=relaxed/simple;
	bh=ntxVcBk6nHcaZ5b/wTBpysqrTzRFLn/qwib7Aq//Mk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjuvJXOSKQZBDN3aOFW0BG47kfyR1dijRB4QmTehBvJdm0IiSEFS1zeD7fuzcQHhzkprzx78+og5IcZwkCAoi1zbaGaPlgXlFCv//GwBAsvxLK9xmsRyb98AWFnAFpmIn11c0UV2Ie43mtDXM6oDNpD1d9cot1jkIHMz8nP1xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTnVF9Om; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTnVF9Om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E31F00AC4;
	Fri,  4 Sep 2026 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558993;
	bh=n+Z0YNXdPuitmhFKu4C+iAiD+DBo9N5cAjbZ4jEeSv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FTnVF9OmrKOUO3tgrI9lYWPAgmDFkFuZvzhBljP697XRVHW5lSQc71JiT0zIvXd19
	 /W5zkpqV78PmtyKQyOED5OmBF+hSDzukZJHOLm14tkVlQz32XPwNkfsv1fqdQC6ULa
	 lKfKt9ThQPJKEd/1fBlMho22TcglZJGVtX4TVm9NknT5uS0HGFxNXDUk8pFxznPkKp
	 033QAVWub41GqaYHo1oPlfevdxvJUwoWOz3qafNu3ZEX4FVYlexgnaYsSXV9JYjD8p
	 Rsr6PiuGLnykBFlvI+0YfZjKT8e0uVAOfKqc0HMwi7N89lwYQz/7IB2o8AeJo5SDoM
	 Gju6MqYH/v6JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 09/12] gve: introduce new methods to handle
 IRQ doorbells
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903215606.31633-10-hramamurthy@google.com>
References: <20260903215606.31633-1-hramamurthy@google.com>
 <20260903215606.31633-10-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:56:33 +0000
Message-Id: <20260904215633.8A5E31F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of stats_report_task leads to NULL pointer de=
reference on stats_report
--

commit 2f8461aff00d2f3a048492ca3caad4204f7dac28
Author: Joshua Washington <joshwash@google.com>

gve: introduce new methods to handle IRQ doorbells

This commit introduces request_db_info and release_db_resources to
struct gve_ctrl_ops. It encapsulates the configuration of device resources
such as counter arrays and IRQ doorbell indices.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 619ef46a7b30a..a160d36f718b9 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -602,7 +606,6 @@ static int gve_setup_notify_blocks(struct gve_priv *p=
riv)
>  	return err;
>  }
> =20
> -
>  static void gve_free_control_plane_resources(struct gve_priv *priv)
>  {
>  	bitmap_free(priv->xsk_pools);
> @@ -611,9 +614,10 @@ static void gve_free_control_plane_resources(struct =
gve_priv *priv)
>  	kvfree(priv->ptype_lut_dqo);
>  	priv->ptype_lut_dqo =3D NULL;
> =20
> -	gve_free_stats_report(priv);
> -	gve_free_notify_blocks(priv);
> +	gve_free_irq_db_indices(priv);
>  	gve_free_counter_array(priv);
> +	gve_free_notify_blocks(priv);
> +	gve_free_stats_report(priv);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a NULL
pointer dereference when the uncancelled work item executes?

Looking at gve_free_stats_report(), it stops the timer and frees the
priv->stats_report memory, but it does not cancel the stats_report_task
work item.

If the network interface is down but the report-stats feature is enabled via
ethtool, gve_queues_stop() is never called during device removal or
suspend. This means the work item remains pending because the only
cancel_work_sync() for this task happens in gve_queues_stop().

When the device is later removed or suspended, the workqueue is flushed
(or executes concurrently), which allows gve_stats_report_task() to run
after the memory is freed. This eventually calls into
gve_handle_report_stats(), which dereferences the NULL pointer:

drivers/net/ethernet/google/gve/gve_main.c:gve_handle_report_stats() {
	struct stats *stats =3D priv->stats_report->stats;
	...
}

Should a call to cancel_work_sync(&priv->stats_report_task) be added to
gve_free_stats_report() to ensure the work item cannot execute after the
underlying memory is destroyed?

>  	gve_free_rss_config_cache(priv);
>  	gve_free_flow_rule_caches(priv);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903215606.3163=
3-1-hramamurthy@google.com?part=3D9

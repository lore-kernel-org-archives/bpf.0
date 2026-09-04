Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFB4192F9
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558997; cv=none; b=qSBDmzw3CtWyrNxSGx7ndTZHtY16N1wRxiCmXdpG0jmlGW08znFkMAW62Zm5viEzx6mbdFjCG2+9mXW+qMdU35iIwSB9tL3hZ03/DLkV2MLUrLEdc0KiJTYa4i+CMv4WCtAgLN56DGlKOGx/M/4ZwjidKoWGRhycVNllhUlQ4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558997; c=relaxed/simple;
	bh=JtlaDaE+IoXmmFQMpck+WCu3Q0zK7+6H9aWKU3TJzLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KqsQPbJyUdPi3NcHz7WaXtrzA2J9Ov0dUGGqYgOb5VcFdFm6L0So+YaTysvY9E8ft2dqnlQffUK1NEzdIWGaLZKKzzfIIMVPWflYsbTb3lymETEZOavLhdOtD15UtJH6PKd3ApuAIEZx80Fl8zoug5TqiBkD2GGm8K06lKeLrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmN+YtNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmN+YtNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AE41F00ACA;
	Fri,  4 Sep 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558994;
	bh=GFh44tBh4BNp50sx74KggkEALF36FrdT1OWEq1ns9JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QmN+YtNsxUeUo24867xyllU3zvpMN6jJM7DOOSUXBGKtIlEcw/GxOLbwCVYwe4sbn
	 CGmW5knrygnR60Z6nFvcvm0rwT/E7f8v2/G6f/4s6Y1GRYChCo6j8RKRVNKBdh/RyB
	 6CMQu3jiyGagvZeGKBxpJxD2ZC1aQgmU1L6xglDLKO8fSiwYbMLoT7PhuA9TNql+b2
	 JMjsmQ4JDnMCRj5rTdnDNqzrDDJwkV0uMWOMEYc6x8+5dK0gNdu5CBvmmtSkbGEJzz
	 G5/R1IiqIss/52HZwA/4tFf//oWwn3mUjlWSTbYdd3CBVpPgdRj+7KmBJJxdS/AyU0
	 yMCmbjNUFR45g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 10/12] gve: setup and teardown management
 interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903215606.31633-11-hramamurthy@google.com>
References: <20260903215606.31633-1-hramamurthy@google.com>
 <20260903215606.31633-11-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:56:33 +0000
Message-Id: <20260904215634.45AE41F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `stats_report_task` is not canceled during device removal if t=
he network interface was down, leading to a NULL pointer dereference when t=
he workqueue is destroyed.
--

commit b267ee52d04bbd318d288ea0576f1ecaaa85d7ae
Author: Joshua Washington <joshwash@google.com>

gve: setup and teardown management interrupts

This patch introduces control ops to set up and tear down control plane IRQ=
s.
It moves the admin queue-specific functionality to the admin queue files.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index a160d36f718b9..8522a495b78aa 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -290,18 +290,6 @@ static void gve_free_stats_report(struct gve_priv *p=
riv)
>  	priv->stats_report =3D NULL;
>  }

[Severity: High]
This is a pre-existing issue, but since the stats report is freed here, can
the subsequent workqueue destruction in gve_remove() cause a NULL pointer
dereference?

If the network interface was down, unregister_netdev() bypasses gve_close(),
omitting the cancellation of stats_report_task. The stats_report_task can be
queued by gve_stats_report_timer() if the timer executes just before
timer_delete_sync() runs in gve_free_stats_report().

Because gve_free_stats_report() frees priv->stats_report and sets the point=
er
to NULL, when gve_remove() later calls:

    disable_work_sync(&priv->service_task);
    gve_teardown_device(priv);
    destroy_workqueue(priv->gve_wq);

The destroy_workqueue() call synchronously flushes and executes the pending
stats_report_task. This executes gve_handle_report_stats(), which does:

    struct stats *stats =3D priv->stats_report->stats;

This unconditionally dereferences the NULL priv->stats_report pointer, lead=
ing
to a system crash. Should stats_report_task be explicitly canceled in
gve_remove() before destroying the workqueue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903215606.3163=
3-1-hramamurthy@google.com?part=3D10

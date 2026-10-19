Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D147DD44;
	Mon, 19 Oct 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400390; cv=none; b=OM9FDR5TaTVDO3F8oVZ8LAt7lRzsRGEqKqU4yzG69uQBop2DlUpKF84DP4t1CJTChYOcgAjsV7RQVJBfsBJ9nCKUL41SHGaLDCIrPWJjaywqekcF9lNGKW2LZQRFOUSGszQPOq2Wz1jDcvhAbqUvO8G0bkMlznaV9WlSpixDWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400390; c=relaxed/simple;
	bh=rragoc2iVoGG0i1tEl209EOPicm3/CjMFj/7auF/VPM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NCUllthzm5JcDgpfnRptyGsR/DKrFppWRqtRzOIfBZA7O8dyGtrxdJykQNq6SENHFfmN51SMfS6nGUQDlhefPWV6DoKSkeoi+onaOvyCswFyXeok/sx3gpU1FYbrXlsmoh5lV0D4ru505oW19NEvIwnYhZZExC4kmg5YQ8e4YAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeQu4m7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeQu4m7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D54B1F000C4;
	Mon, 19 Oct 2026 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792400389;
	bh=sCVL4RVHLYpuCYuxj//ChNXUdT91AceghX66I3VsNi0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EeQu4m7M+rJLArRDfjnc0TYAbstjwDqvpihjZ7BzpYQL2mj5qSY+WyoCtI3hwd1TF
	 LZjv9bPsfKrPnypcZPmZ40aEwV+wJUBzlqraa8bBS5oJNr1scba76D46Mj+m70FAgV
	 N6FGWuTHOZt3DVdFIg07G4gRZXXTEgy89DiMWPVLX5in8KCWesbjg3/QZud518uSvD
	 Flmq5a7v+rMGURY3Bq2vq5ALlr5RmqCbPxavQwxeIrRmZxsDjDM90HQLljtamqJdQT
	 aVIFFP7qHDkYDk9JrkwwbSG9KMHDbDhCW2dbvi81I8vj0mNZQLyKUuha7eaUEVgdkP
	 t0u4EyM1UIlFQ==
Content-Type: multipart/mixed; boundary="===============6491243909759321778=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <222cfd632a97f75821b9f4671671253934825dfe1f1abee532816b26a0b47f33@mail.kernel.org>
In-Reply-To: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
From: bot+bpf-ci@kernel.org
To: marcin.knap@vecima.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,marcin.knap@vecima.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 08:59:49 +0000 (UTC)

--===============6491243909759321778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xsk: Do not free ZC Rx buffer when the Rx ring is full

TL;DR: Since xsk_rcv_zc() no longer frees the buffer on a full Rx ring, gve
DQO zero-copy Rx may leak one UMEM frame per dropped packet and eventually
stall AF_XDP Rx; it likely needs xsk_buff_free().

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..0edc160c660f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	}
>
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }
>
>  static void *xsk_copy_xdp_start(struct xdp_buff *from)

Can this leak the UMEM frame in the gve DQO zero-copy Rx path?

With this change xsk_rcv_zc() no longer frees the buffer when the Rx ring
is full and it returns -ENOBUFS, so every zero-copy driver has to free or
keep the buffer itself when xdp_do_redirect() fails.  i40e and ice are
updated here, but gve DQO also relied on the core free:

drivers/net/ethernet/google/gve/gve_rx_dqo.c:gve_xsk_done_dqo() {
    ...
	case XDP_REDIRECT:
		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
			goto err;
		break;
    ...
err:
	u64_stats_update_begin(&rx->statss);
	...
	if (xdp_act == XDP_REDIRECT)
		rx->xdp_redirect_errors++;
	u64_stats_update_end(&rx->statss);
}

The err: path only updates stats and never calls xsk_buff_free(xdp).

The caller, gve_rx_xsk_dqo(), then calls gve_free_buf_state(rx, buf_state),
which puts the buf_state back on the free list.  gve_alloc_buf_state() later
sets buf_state->xsk_buff = NULL without freeing it, and the ring-stop cleanup
only frees xsk buffers attached to allocated buf_states, so nothing calls
xp_free() on this buffer.

The path that gets there is:

gve_rx_dqo()
  gve_rx_xsk_dqo()
    gve_xsk_done_dqo()
      xdp_do_redirect()
        __xdp_do_redirect_xsk()
          __xsk_map_redirect()
            xsk_rcv()
              xsk_rcv_zc()
                __xsk_rcv_zc()
                  xskq_prod_reserve_desc() returns -ENOBUFS

Before this patch the err: label in xsk_rcv_zc() freed the buffer in exactly
this case, which is the scenario the commit targets (user space not keeping
up with the Rx ring).  After this patch gve DQO leaks one UMEM frame for
each packet dropped because the ring is full.  The frame never returns to
the pool free list or to user space, so under sustained overload
xsk_buff_alloc() starts failing in gve_alloc_buffer() and AF_XDP Rx on that
queue stalls until the socket is torn down.

The commit message says "A failed xdp_do_redirect() leaves the buffer owned
by the caller, and drivers rely on that" and names only i40e and ice as
relying on the core free.  Does gve_xsk_done_dqo() need an xsk_buff_free(xdp)
on the XDP_REDIRECT failure path as part of this change?

The other zero-copy drivers that were checked (ixgbe, igb, igc, libeth/idpf,
gve GQI, mlx5, tsnep, fec, dpaa2, nfp, stmmac, icssg and virtio_net) already
free, recycle or keep the buffer on redirect failure.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39223384647
--===============6491243909759321778==--

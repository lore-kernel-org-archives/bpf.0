Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789310;
	b=Cb4MKpXu8NGAdPAdJfTnNVoAj1I3iumRCo/PehQ5391uK6T+ysh8kpSMjlVii/kAulmo
	 gG+dasRZ01GAd534mCrNryLu5kHv6OoMaOOQDPl0CrdySs5MOP7losaz1rdhLt7M2d7Y1
	 XrvQuY79cN+q+60kZuyB1C0UdBSrRXMH6og66ErgeSTnPsV2lzndBRm8QGagW7tDrA1Sa
	 4dIjAHRpBMRsUfbVtgXmcG/c5ULGPeNN+6EwQ9VS9S46JjXPBtAHEovXokmAuPkPlrz5F
	 SDagnKmrzHPDyA0hUY89K2cpqw/d9YeF62zYyT9MGXMFVXWU4ODr1NA2EG4Zq7Pn54Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7+c1Qm3VYeU1+HWEx+l1hojCUO1r8kUOKWi5tpZjEFQ=;
	b=jYSEf8CDvX1WZ55KeDaCxS7QqLRm2iB1EXIVx5/Zn5TqZjZCPbDH3/lxKj/FSJpPFNdR
	 fqE4+Vq4S+aTIvnTAZIPAkzCoO2+SEX5XWd1JieFM5pcds62m52drTplHUbkya4kV+d6H
	 CrXmhYw9nTfJrtpqluvdbpTSQxEhu3Z7jsx3KJRsxbxR/gyp3ZmtdIK063ws/TF59cqS+
	 vCDdA/Rs5u7ob1yb5z4gm58HDUmJ4ySCs0NqZaJlbL7QnnZH+OU+zK7V9aerW8jiYBJA6
	 Jy1AZUoQtpFz8lAuy8txynnY2m9joLM2cDHo0+zREBSH8kuHnkTUF7ir/YNVFM16Vew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDF1YvTc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9A606A321;
	Fri, 27 Nov 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDF1YvTc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29781F00898;
	Fri, 27 Nov 2026 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795789310;
	bh=7+c1Qm3VYeU1+HWEx+l1hojCUO1r8kUOKWi5tpZjEFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDF1YvTcOZIItHkIbN2v0sQMzIKYAr7B1NuEmMRXZfwW5guiOGIRAnfZ84fnza+ou
	 KuIfaYDVPPah8qEPjKTJbF/JnsSI8vYu0suJ4MYpXaG5ZY1/+01Ac7LwPgyZDN/q7P
	 O5Yfj+ZKRvXcITPli95LyIJR4t4Omb4R3oa47Sm702fWwVkP1EWCfqfGUoUQC9ItRm
	 G7Rx2QVLGWzlyukn/WqOwcePlcCASoDSzaUqhAwNg6TSw/1ypspRp2Gq/Q7gGF36oP
	 Nq9px5OqKlKW/JhbWZe/5mbSlGqCImLYXhl2xLCO6hENDPWFhbCtZ8DkbPgzEzdMA6
	 6e+3QF4z0GUCg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/3] libeth: xsk: Count each XDP_TX buffer on its own
Date: Fri, 27 Nov 2026 15:21:27 +0100
Message-ID: <20261127142131.3527737-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127142131.3527737-1-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

libeth reads the shared info of an XSk XDP_TX frame when it flushes
the bulk, not when it queues the frame. The fragment count it finds
there decides how many completions idpf reports to the XSk pool.

The shared info of a zero-copy buffer lives in the UMEM, which
userspace may write at any time, so a rewritten count makes idpf
report the wrong number of completions. Once the next patch moves the
shared info into the buffer pool, the next multi-buffer frame of the
same poll can overwrite it before the flush.

Count each buffer on its own SQE. Head and fragments each take one off
the in-flight count, and the head counts the packet. Stats do not
change.

Found by code inspection.

Fixes: b3ad8450b4dc ("libeth: xsk: add XSk XDP_TX sending helpers")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/libeth/tx.h  | 3 ++-
 include/net/libeth/xdp.h | 9 ++++++++-
 include/net/libeth/xsk.h | 6 ++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index c3db5c6f1641..25cad5566436 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -22,7 +22,8 @@
  * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
  * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
  * @LIBETH_SQE_XSK_TX: &libeth_xdp_buff on XSk queue, xsk_buff_free(), stats
- * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free()
+ * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free(),
+ *			    stats
  */
 enum libeth_sqe_type {
 	LIBETH_SQE_EMPTY		= 0U,
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 898723ab62e8..66a3c4ec9967 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1794,12 +1794,19 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 	switch (type) {
 	case LIBETH_SQE_XDP_TX:
 	case LIBETH_SQE_XDP_XMIT:
-	case LIBETH_SQE_XSK_TX:
 		cp->xdp_tx -= sqe->nr_frags;
 
 		cp->xss->packets++;
 		cp->xss->bytes += sqe->bytes;
 		break;
+	case LIBETH_SQE_XSK_TX:
+		cp->xss->packets++;
+		fallthrough;
+	case LIBETH_SQE_XSK_TX_FRAG:
+		/* One buffer per SQE, see libeth_xsk_tx_fill_buf() */
+		cp->xdp_tx--;
+		cp->xss->bytes += sqe->bytes;
+		break;
 	default:
 		break;
 	}
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 249b1c740788..2cd4252a3445 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -129,6 +129,10 @@ libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
 
 	sqe = &sq->sqes[i];
 	sqe->xsk = xdp;
+	/* Count each buffer on its own SQE. The shared info of the frame
+	 * may change before the bulk is flushed.
+	 */
+	sqe->bytes = desc.len;
 
 	if (!(desc.flags & LIBETH_XDP_TX_FIRST)) {
 		sqe->type = LIBETH_SQE_XSK_TX_FRAG;
@@ -136,8 +140,6 @@ libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
 	}
 
 	sqe->type = LIBETH_SQE_XSK_TX;
-	libeth_xdp_tx_fill_stats(sqe, &desc,
-				 xdp_get_shared_info_from_buff(&xdp->base));
 
 	return desc;
 }

base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
-- 
2.56.1


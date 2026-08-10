Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F7439F8C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387677; cv=none; b=g+hhJ0sQEGrKHsj/tv2vN1JHQRdU48XEYNrxrGmKMdS9WiiZPXHVyzsBirTp7Lam/uLghjvC4WWQDGqGFHdZzyI+oNKghMr+nQxAfnFDosax5ek2jBOBmut9350oQ/XTBWBIg8Uvt+S2eZ90zcQHyxelqOoD3JdOrifF/DQSxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387677; c=relaxed/simple;
	bh=rWuyKW0qJTLaz8U9Q47FHhUR/2b+JV9Wuz0CfR5JtWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0020YeJ0OA4AXjdayDm+6CiYce/HdX0jXRX/oCqu9/9v8suowowhMz4q6R6BWxIEfHA/PKk64DffWR5Jzl/9vT4L66duIR6WMwcRqPLOEUlM7d9pbdfOIBfk43oiu4l5PhGLGLeBznNI5et8ZGP98uZxlwxoQkkJYzS5/+roOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq/ve03q; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq/ve03q"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38dbe53179bso801055a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786387675; x=1786992475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/Ax58T4Q8crjfyLzO+c1sFhNTHsEbLvFPcefzRdh9g=;
        b=Kq/ve03qzmFnoMRnaL8Ei9J6t/Zycq8s2QZ7Qknc64MryfT5AsuShhuIT6lmF+tL/r
         zp4QsbNaxGE1h7IgdVXqUhaQkNkO2f4v/L3klsGABGwEaa3CXMr0uDpIv6CHcyQs96QZ
         2pxB+7shYnB1vjNPyGdjKSyyy/+KenV81MQjsgybVgSqc5yMR3K2OQAT4JPTjmn8eGqV
         e3Edgm33+0BezzYp7tukLPRRGcUi9G9AOH7nu3zU5D7byzl1f9L3dn/IYmXhU6fXzpH2
         2icpGaPZu2iJl3+25Bz0QdLkqhII2ngFv1r65RP/hJ7ZMrKlmG/ZKYGTK8KjHFca+azY
         iksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387675; x=1786992475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/Ax58T4Q8crjfyLzO+c1sFhNTHsEbLvFPcefzRdh9g=;
        b=X9ox6/kx6Iozgv+DAtPDyOze1Mf5Abs7km66jHkhG2nPOxG9fIipxSKleXFjvG/iVP
         GRYxNCZZhLKllmDJCbIVgrEr9fRhEOjGFILYTy03hd5dzRDZbVFB2t0aum2dRVGsBNdK
         gnDb5ae6hTrbjazdinf5Uibz23QdhhKcdO7L2Jge8rN6i6Njk2wPz0J5tlS7APOyQEmM
         QTuH2p+cI0VcSmqpHOPZsyYVhSb3UuMQoqTQIEZp7rU32vqbP+LQFOt+2cCi0tozuTOs
         53+WPbtSOgCwQErURnqdlhBesRziOtAV5MOGEIpqLwSug8luLe2NqlHbOMQ1OlCZGcT+
         qk9A==
X-Forwarded-Encrypted: i=1; AHgh+Roybgs45gwE2yGSy9Bgq4ixTVObvRRaW4e+ZXcigLSc3InVH8e+Es4M5585XOfmeZTxhpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKF6a4xRq/KkDSBUROxSmBvhcAyswqrnfFiuWJmuUM0fPZX3G7
	kxPt+AbtYrxqGsMRKgCpBv0fYmGOxlj4YMT3p2vws0sLyhtLuu3NEUKv
X-Gm-Gg: AR+sD10C1heGTX5GdZA04Vy8KW3XjSNpketPLwV5BaQ5SojNdLS/6/j/z5i8kuu+2uC
	7JQq431v0yO01DWMo8Nju86ZVGc406UiInK6kee/2WNH6w4ObnCwAHyUT+vhES/3P/MceXdXx2r
	DfxUN+3QnL0miI0Z3yJXtJX26udHa8DF+SA65iJ9cBSe7WV2t6ulJTmLqiG2d8EuqlySDKEwhi9
	GIlbIVO3+L6sWJYzmnSl2upEDNYyvroxZIwo5Vtyq71XT5jfz7QKty55abh1hNgnMUGLNqqECSM
	6Z7wuvo+J2XonDhl0/FfGzhIriD09EKOIHzy5XIsrXpYsVMrCTK6RJg+VHcpvRcLmIwbtyjH//T
	X9Hm8DA+t4ncydpfzIo23Tp3H61VCddGPp9Oydri4lwQrw0hPUir4zj+bTRjsfuFmoOZcgVEtB5
	k2Qu+Uuv1GKvKodYOCGNVm67ZohQjyMZ90rFfcYI5pvwDQCQ6r694iW/saeZmYc9l8
X-Received: by 2002:a17:90b:1807:b0:38e:6dd:a9ad with SMTP id 98e67ed59e1d1-39281b1b0c8mr20842462a91.0.1786387675358;
        Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5226b40sm611653a91.13.2026.08.10.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next 1/3] xsk: align TX metadata layout across ABIs
Date: Mon, 10 Aug 2026 11:47:51 -0700
Message-ID: <20260810184753.135756-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
References: <20260810184753.135756-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems. This intentionally replaces the
incompatible 32-bit launch-time layout while the interface is still new.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/uapi/linux/if_xdp.h       | 1 +
 tools/include/uapi/linux/if_xdp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
-- 
2.53.0-Meta


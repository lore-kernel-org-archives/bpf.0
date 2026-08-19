Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AB481A99
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155541; cv=none; b=qMxk7vNY6CCmH1Pb6XGn+8x8W/9JQclB3+1jH+ND/IyIpPROvXBLlPTM2/OtHtog5poXXOCMSUTUkQcxm8InUOCYjYbJrh89afsqsJYqPtZWdnJ+n+IE4J79LauuOC3jokDMGJvNfXvTGYuMHRZ9X7h4xEejUCXomngAAfng+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155541; c=relaxed/simple;
	bh=2PLCByWGgAwhdeSGwInJPW8yjXmeKf4VnccaWVFyDiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuvoRd6BlZKNLeV6YixDAfRouq0569wOOLHmXR/ZPI2dVWX4Dt2PzAqga4tTA3uR6JPMijcd1iWckEdVEfS/LkFjSKMDx5OUSHfjmmaIHOgMyIL0/6Z/loLFx7c57UaUL8UzsAeKaoYdqMOKzYBBEjPtWBOzU8+6BOzS5cNr154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4r++4To; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4r++4To"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so402295a91.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787155539; x=1787760339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7rQxNaXNWqb2c9lwuccfrB1MuTuQX8j+1HrCiB3XiE=;
        b=I4r++4Toa7TpOYhfu0AAjKAiDOoEBpYuAXB4f09fwwzc0G76OxMtJ5TpEtZXVwgKIX
         OP3S/lAoHgO+3tMp+eaxZaJw5XiZ3v6PkOIomnIvHVITNlkG7hGr5svI8kW+R+IrJSn3
         PuJ2MG8TSg4slbA5Z+03+VDdIawGvw7xe0HW2XT0VMXcqLcKdYKEBfedl23qVFu7qg8B
         5nz8rq5pR2F7Rs5OOAyEOY+XkbwgU/6n7IcOcXQLepn3OkcCUzpTqHmtuGwOUBljg7Dk
         AF4Nnnu9kib8gBzBk0UZXBeJ/g3BoX10BVSvun9kmhHANvx2o3oKPu85BPnyqGPz06MY
         +moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155539; x=1787760339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7rQxNaXNWqb2c9lwuccfrB1MuTuQX8j+1HrCiB3XiE=;
        b=WrAGNg9p7cp2f9wGbEXOBF0zmuVAIyZBeT9HMkpeDwnW1zx5v0FH9Xu5QwP8jBdTjK
         v3RsSzzahCF91T1/lCgf0e7Oy/ax6wvdDowGG3AnMcu8jgKCC1UoF0/j7hSFaPRPAtGv
         Mifou7aARepWLC95ye9voQwxE3iu9BTkJ5rT/MN79ddUOj4o+rl5QHNbq/2kACmAksS1
         0LacWwWCzvJkzCfYW4UKTF9HhMLVIrPpz8KCwWtrKjr8x5irRhg3VqN+uEHpRuY8c8GI
         Aph3ha1BrWYWXz5daIDbTSJ98WV9995ubmL2trw3MHMyZ18DFtgawzUPfiS/Txx5MeSD
         uyOg==
X-Forwarded-Encrypted: i=1; AHgh+RreqChSo549seiMDvW1X7VMqjdTS4ntqseCpsiy+8rAM2wQxSJa5x2XvpBf2iCm6DDQhig=@vger.kernel.org
X-Gm-Message-State: AFuF++lu/FDdVSD/falmVBlL3HxloDLm6lN0onlzSJJqQksvjAAQ/dYv
	Vl4e5RP3pjo1rDCx79w87WSAHPukVdo9YvuSLbtAprhxbMXWFoeoqfpU
X-Gm-Gg: AR+sD11oZ1mxjSHInSxiR0lHNG/yXNjJdTHPkXV6msTUuPziDOMdRf5gw/EMXnWv1fF
	PYD4kPLEebh7mK6PdSQlGvj5g9coxagzLG8yIGZUQAs8YTa3jc2qPGl+jB+YIq5il1IGjLPNTyE
	+pMNSnx1tkM0vCdhVyrJzylgSy/qIm1RW/DS6GPol/zcgFFyGqA/T6FhG1GMfQf74LR2SY8nXc0
	kZe7pEhmTyU01p8F5TCo5iXcyRp9ziVEmji3EJPKBqqgvkJpYoRoCXe8Up/0MYCdUvbYcYQ/SPj
	ge1B/lx/+gf3I14xWgxvylTyq7v5OK+jl4G9ER2mj75jbnDGHbzAW2AQ3Dz3mGCXAfDc3D6arYN
	iEy8/IKfWt0C2sFTqKYdtm0uVQUAbNifD0Tz0E1KS+DTAQhQ1x70/7uIKEkGD6HbEKO3j+vqb5F
	V/A0AW67XTxyuChyyO/OEf3zhQa3wPNAvS11BmOt4dJv7z7wVPnD3vUw==
X-Received: by 2002:a17:90b:4d0b:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-3958127d8bdmr9857765a91.15.1787155538709;
        Wed, 19 Aug 2026 09:05:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957faf6849sm3011405a91.10.2026.08.19.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:05:38 -0700 (PDT)
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
	guoren@kernel.org,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-csky@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v3 1/3] xsk: align TX metadata layout across ABIs
Date: Wed, 19 Aug 2026 09:05:33 -0700
Message-ID: <20260819160535.1472459-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819160535.1472459-1-sdf@fomichev.me>
References: <20260819160535.1472459-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems.

On several architectures (csky, i386, nios2, m65k, openrisc, sh), the old
native 32-bit layout put launch_time at offset 12 and had a natural size of
20 bytes. Using sizeof(struct xsk_tx_metadata) as tx_metadata_len was already
rejected because the length must be a multiple of eight, so the
straightforward use of the interface was broken on those ABIs. Userspace
could still register a padded length of 24 bytes, though; mixing the old and
new layouts then silently reads launch_time from the wrong offset and
misprograms packet launch times. This intentionally replaces that
incompatible layout because the affected architectures are unlikely to
have any notable users. (x86_64 and arm64 have the most users and are _not_
affected)

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Reviewed-by: Simon Horman <horms@kernel.org>
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


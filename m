Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101542049D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648084; cv=none; b=L+KBN5c/mIhTMKOyCFoHRb0YvZ5irDUsL4cvbZ/jEOyNk8bzjrcF9r1DQnbrGg9DvtYZz7irw3JFEgVrcvDZM16/O981D7oNakjKvifZduUZPxHKwsLzUA5TWX9px/AZZ6Q0YD1XeIi5/nuD2+9lU/jnoKXUTPqHsNOKUnFVU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648084; c=relaxed/simple;
	bh=Na7MS/Up8XTKb4IX9xJjbtZxGJ7cnEgnEI7V0oawB80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb2emzgkk8PEPrzGilS0tKLztCwgSUIhxYcGy6zZ9goTHztNG5lLsyT6oMjF6ptZDLu9bCBKqBMJR5sRl6ImewNaUyzWy4h6NZp8Sx4mzIzFSa9qabwrSisHsl/RGxKhf6mKCFHOSXGuwVz5GW/MTDOU39XQlaqf+q5uyFhklOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJzKuBu9; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJzKuBu9"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so159511a91.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648083; x=1787252883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
        b=SJzKuBu9wHTjWU9bGfrFJ+r9NiOTAfKB6oHWsgxB2gGcLkXlNuw/60fSe5HwgLxFKV
         Lwn4556+mOBdsiI1xDIPh3O2lmQ6ArIXj3+b2LhXe9HUec8/HhLOiCHa5iQfB6qbWsgK
         gkTPoaLqhYPQTOwAyNbKLfgsPDnaFmboTGIA+m3HkrAezqlhff+2eenRlwrdR8qBgHGB
         GaAFJfzp7ZVNjuBm0kL8g6b9xYAFVTqOXD1Xeh+RwfqPM3uMd70j83ZnmqtzwLZewAEc
         OJjCSEiDCuCvk+9fRSvg9kV2LMeAGHfIoAkBMkixW1E1NLz/Om8a7iJ4OMGP94yaAnw3
         rMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648083; x=1787252883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
        b=lMvS+vk28jIIuDw4rw50g3eE1Y/GG50eAkY/X+huTN5naHJWZRUxQa/SIQivIhmp5l
         1P8FGtysNFTeG8VYhLImEY3aiuNXXz52TtQ+farTJoA3Fq8//e5vcIhiy5KZdTE2w64l
         AoDWJ+Ik+BHBD2PSU+yFlRcNCULYBAeJoyvVmfVzL20ESIvFzapJ8IDCdcwnC6fv8vF+
         uSjGuDC3AX7ScF6F0ia2Ip9LUNEEKo+N+u+9UFqFlKSGkmimiueLVwgRYb3oZ3QnHwc1
         mD8dvPUpJTNtpW5ZrsAYz3LOP+PsY2sSRfysPnXPif5EO3HqCffGAdywXK7F79bC3nFf
         Zq2g==
X-Forwarded-Encrypted: i=1; AHgh+Rr3fX5p4W5gCTNoIHJ0xrJQEJC8ne8SIDgeWc2mNiFNnQ2PjiEFx8d2N3Wx7gxsjHJvqBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8ayQDnQDSO/jDixQ15ICLUFzOdxYWm2TE4XR1mLsT29j6STg
	0uiyez0UEfE+mURektziQnjymnIJLT+Z5PZvbvg/SsvxqE7J9wGZHav/
X-Gm-Gg: AR+sD11iFN59F7vClCAq7ULORD1SojwKE1JzpAS6dvCc4i3/WNrTyUNsNeL3AEyHcqp
	jWZO/gfx2wl2p6tejcnh3a/l2TU+wCMO5FUGXWsocQjy55XhqJb9XWVAANcos7efN9fueM2C1M+
	aDeQJ7gMw8tkDkLgcV2PvygkLOF7FoGD4PHtMIFFvfBbb2sFvaQwX9PVPirz/urFQBupxe2m8vU
	RUbg/lhRi4sriXcI1NlhdLsoFfTn5GR4z3YYVBl/R00jkZGJj9WXNpKGlUyHDsoVyvFwIupB2Jt
	qC8mvFdlCUn1vUEsXokknw13yYKwzfeQ6cknBVwGNLTBNToPEil3Vr9erkdVDp8xnwlpFp692a0
	BlCGDNo7+qzGlVRteLk96FUz7DuYOxhnDn2CFzLLqY3Y4/wiZy7tst+p73WinRv6nUrKohdNkQ/
	sS5DU1hyMYQpscqdnOynEkGM4Bmr5zaWJiefXMmlAjMLiZvjP1W5yekw==
X-Received: by 2002:a17:90b:2b8e:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-3933b8aa611mr183995a91.15.1786648082609;
        Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a009f35sm492119a91.15.2026.08.13.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
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
Subject: [PATCH net v2 1/3] xsk: align TX metadata layout across ABIs
Date: Thu, 13 Aug 2026 12:07:58 -0700
Message-ID: <20260813190800.222527-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190800.222527-1-sdf@fomichev.me>
References: <20260813190800.222527-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems.

On i386 and m68k, the old native 32-bit layout put launch_time at offset 12
and had a natural size of 20 bytes. Using sizeof(struct xsk_tx_metadata) as
tx_metadata_len was already rejected because the length must be a multiple
of eight, so the straightforward use of the interface was broken on those
ABIs. Userspace could still register a padded length of 24 bytes, though;
mixing the old and new layouts then silently reads launch_time from the
wrong offset and misprograms packet launch times. This intentionally
replaces that incompatible layout while the interface is still new.

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


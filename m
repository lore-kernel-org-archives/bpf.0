Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795467047;
	b=Vt2njQ0VM15MgyKq+DUNhZ1ecgJ7OBcoFo69AV51ZmBFT5ftDBNQ0BjBMLb3adM5hqQT
	 LF/fOOwPUo70t+bIg7ZdBDfs5yS/TaPporMszkSR6oJ3rRa+XBfotS5LUzV3tiEfV5BkV
	 dtiF2+FD0nmkZDx1WjiqvqwcM880l8EHpMueMT8oQ8mAVDjtPxFrLzuHXAK8nXtxLZBk3
	 frnBDnUtUzyRhhd3zzlTVOPym2x6RZ54lDx5TFgMbUxW4/uJKFWEtIEy89Y2mjsyAE3Pi
	 HLcA0pR0zyQCuHWc9G+Gs8823WmFQrM/izdn1rZwSNZMoMrZA1s7Y9x/583+0dTPB4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
	b=Rkpm9BI1UaG5LZcyMftqOeqtuxBoIszTYvK2Xo4ksgAQV0rjrsXg82eB5zCOJag6fkNO
	 J8DQ+9uUlydeYcyap1oBhqD7JEHw9s1mBt/ACr1vz0qqU3p9/ir4Fcd28tp2HO4YMPuFo
	 o8an6aBrBpZxaGiHPgJFGYLGPpSDA38Hl00jxHZ1g35jBHRo06RkfEpf9z0EmVrqkISqF
	 JysAJkYwihPWDLChyBD5gcKybiNGcEJ2qy11oyYdelW3MLI7tiKMXmWhvry24FfbT8qq3
	 f0C3lY7f5obSbT9BXNSA56SnE5NiHA2meTpnlPg5k0lhsQoM0OVG5GK7LGGHOzkwqoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XbFKUc+B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262F606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 20:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A262F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XbFKUc+B
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso1676227fac.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795467045; cv=none;
        d=google.com; s=arc-20260327;
        b=nRVo3EKUd/yEWNqaA4ZnBjW3mhnzDbsX9l8fa8CHuutRHWt79+vz5waJ9OJgDkNXKR
         PfKY/lnIevRQn9pauu8A7avaygT1r6csMMt3kkbLwpHVN3Gv7WEwIjIBZtkhbhEV1r2B
         v33eOsnKH7/qLxBQtVe0sF7AT4IvtauAfPdNV80Drg/IeeV2e1cpSj+ogsrd6PKN+acQ
         QJOd41WsjWoo86IvaZ8IUbO9YXgIkLelSR0Vq08FXnMCS5m4NjIfqTBfxUNQe40aj2jo
         z/GzJH4WEGDv1y7jhzKD9tmpHCMYsapPDf9tN2F/DPTjJ8VzpUsgz+N+mqJ8nIqf5CbE
         OBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
        fh=1/2P6KliyMSpACnByxp/2G3cMedcXIcK/1MesULzap8=;
        b=eLnPg8ixnLuQswNk6D3UT//K9YVXsbPralO/TokLxWg5gsGmN3Q0QBADxHpWc8k/P+
         VEGzGO6qIdI3MSeRsYnF7Yu3myxRY1z/zOjBfUOEAcxtyNBT19Udfie04his+CZH41aA
         YMj23OVGls29ouXtJPFuK1vkKlru7D3kBca8+mTPBG++59/0isg/pWuZ5UDBMxNitIV0
         oFbI/RLTM6kjgOeEhgDXrs+WG+j/uN12p5PaBKWx2OpcWo6lu0cTzLl70wxJBUfy0MUn
         U2bYPPo2wkfkKUfNJHNU5K4Bi2fgmhhCcQzidDzQnW905E1LqF4/ASArLv+a7WDd/yGn
         YIeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795467045; x=1796071845; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
        b=XbFKUc+BTIDQ6jnQ0wCIjukRGGRFMm3/5IO4CD4uNpdpTm7+O/bBttTVEdAhjeSz1B
         R40cCAEaHRiqLrrL0Zv354fdTKDUfO4WApALwN2wEiPfMUSbi5ORrgZvLIDy0RNmzFd9
         TsYUuMv0QXF/2WJ3f5LHZpiinh2DkOAutblZJ5FD+o2B/hmcpwZIUt8uuH6yRoWyD56e
         kutdhTQEZstNtZY/RdZfL1MnV14yoRKj1viBQbq+YryTvkNb3p0a9xct3N10qjnxyFoi
         6nX2lhtBMwMSD9LZgtqR7VrTxjW46magGz7fNZnXrcCUpkvGPlIAgSX/msKLCkM5tBPY
         uFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795467045; x=1796071845;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
        b=ECF77rv4Nuh8vtaAeHWoijdUfIPmJSCqqiMqZVL5Dd9FRTg8+tkGN5J/Tc7I5f1P2Q
         DnH6TQcrwF5lEI/pzrlsP7n7cDoF5XnY3X6kOJJ0QSpHgKOsCBr9jWqPKn/S66qDbtG/
         esk6Pz0nHyLanC/4wU/9uoMaRFetv+iGxtHR9qoaaBqFtdA9CE+lqD9f12sfCBsxiQwX
         JvN6kjg3mjYRigYkNtnRB3sMQAK700YFDKBthmpNqnquksC8npZ9RT5YIoCONDHYpeb/
         clTuKJctxpXLblXbU5vBHAL94c7/G0H2vRe+ou2c7XjFtSfquwajmeX7jvpjHimSuHXs
         LDWw==
X-Forwarded-Encrypted: i=1; AL+hErEMpX9Z10HLezBGeX037A/jxvRJkwE1RJmtRvzxfDSPkw4zQC1kurjayEass4XLtc+8jGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vyz0S8WAloAhixc2f2n7P0ERxAc4X9hvyyl8z1Hb5wRbQl+cr
	PdlSGzaxW7/byNBhnqkJIAIakOXmQtvhD5rpq3uy1ohLU+NE7gdm7Cfhdk6U6/n/ZVFzgFPMUNP
	ue3jrF+Yf8tXkv2c9b4sEVE/vYBggs0eNFwwHm+jctA==
X-Gm-Gg: AZFdTZcd3bgAtJzyTON8SFHPDs6LtACakzYfa0t80VWX8ecjevZLoK/SH33jPPShm9k
	hmeLL7ucZXAutXqpkh8RBDl7EXwwusXHgkZWnxF+rBWfFE2KwUjXkIYfT25WVluNhg1kjToLpMR
	Wuf/iNtaPGV0tydjhIL/ap0AgbonXecPui54X/clKDZHxJPBfR4aPvhNRVPs+aHvDFuENpYPoZQ
	5qMXXzqp5N0fMN4M0mJFSehRPwEZv2K/4pSdpRReLoeeZcVIwKmrL2w2gkd7ZzT2k2UWP+zdk8J
	awtIiEEKd8SKBpHXFKzN7kMZ8Lk1azssPhH4aA39l2y4rQAJ9OBv2ShPVyH9tcrUS1KYt2PL+us
	6U3N+m+hpxY4296YB+f7pGpm1CIVLwVt3wODLb/EvADXsqfg8f/WSZ9I3kFZJlaewx6YrgxbLKp
	vG6crawg4glw==
X-Received: by 2002:a05:6871:5214:b0:494:9899:dc19 with SMTP id
 586e51a60fabf-4bc858fe4e1mr11416644fac.57.1795467045382; Mon, 23 Nov 2026
 12:50:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <awSF9MseWZF7GXoT@boxer>
In-Reply-To: <awSF9MseWZF7GXoT@boxer>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 20:50:33 +0000
X-Gm-Features: Aa3M54qknv-LC3GqPC4I5eLThmOD4Cwkbfje5p8LrDaQRMJr2NeCERG3yi0ic8o
Message-ID: <CAG4wq-fmKUPCpvu_m8Zw-9X23QW3k2F3ucjSQdDvWQTpjKNYaA@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 23, 2026 at 07:29:08PM +0100, Maciej Fijalkowski wrote:
> Anyone else besides mlx5 behaving this way?

Thanks for the ack, Maciej.

From roughly analyzing the code, no. At least fbnic, gve, idpf, enetc,
ionic, mlx4 and nfp report CHECKSUM_COMPLETE with an XDP program
attached too, and I am not sure this list is exhaustive. So I am
wondering whether we should enforce it for all drivers, with the
drv-net selftest I mentioned.

The existing tests in xdp.py (test_xdp_native_adjst_head_* and
test_xdp_native_adjst_tail_*) already change the frame and return
XDP_PASS, but they only check the payload. A stale CHECKSUM_COMPLETE is
only reported silently as "hw csum failure" in dmesg, so they still
pass. Could you check the dmesg of the ice-E830-XXV2 NIPA runner?

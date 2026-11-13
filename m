Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611340;
	b=pu7BInAbkEKKRJw43A6/aDDElBUVwI7ENd9+df7eC9udcP+1UDWjiMFbArqqjYGJ9fkl
	 xWqNCJuuYBNNk3TXJG24xJoCN9pE6r00dk565Lz5xwi20GbN8rlB/fWu55iCzjnJeETQQ
	 2fgIDZ2oSnxRsSBfrvxq//Ux0OTsdTEMqnHxI/iOskHUc+rDfnZOHkFUO7TI1le3XJQlB
	 5ZWKVC0p/41JDAjOP+FryPfKeAa4SuILllcgmpjJOqMTWpFoFwaEa/eCtyQvC0Q2ldTDN
	 EZ+tXMTPsiFB/zAOjhrffpw06ca9hCsyKwWFvWhmlOvEcmqJMXbhqucrzxIzXvFW2sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XDe4g1bU/aN3g6zvr+43wMrHIdQQ+2URWWfbfV1wal0=;
	b=mln4n81SYZ/Gd3IKRvb9c2l6+6lvwLBLdk0k2f7CYI19RnS9XDJ4cfEjJXCMfk8fhW4n
	 8YUi3d/U3xNIoeZFAYYFtJsM6eXRswR5DLUpCt0WIH36QB/Y8NflkFrucozIEzKJJeHtB
	 XQyU3wZWoPXYmQLxT0HzeIvGId0v/e/sMQala+1FL3Qz/j0mUIPjwlrD0cKDyhKkp6FAU
	 mHbrs6YK6ZQrx1wJ6BAhLHwZw+Qc7k4HQFV9424Y4mfiCwcnmMQxMKaaXbMq2Kq4E4GX9
	 GUvX9oZUNPsmYZjf5GEU/oGCAP+gAnoXiIQS6cnH9I3zPfP+pQqS2DpbpZv+nVX4q8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+fz4hsq;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C7606A338
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8C7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+fz4hsq
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1778270d50.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611338; x=1795216138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDe4g1bU/aN3g6zvr+43wMrHIdQQ+2URWWfbfV1wal0=;
        b=S+fz4hsqfFKsQn++O8NXFpuD50zFqgPsOZOAkeSGSEyQHnsrSf4PcS1K1yn9iFjzrC
         6G1UNPIWvpZCZvMvoc5tWfz5Z2N60VEThXlOzMy3/XDQjFPCy81NKFemJZZsbkAM5llw
         sQen8whieE7BaBQKTkEF4pUsjgYSW369BghBiJ81h5HSGfxbCJkBO5jM731g02TqgY3p
         SbmpRWhvoHS72+RpuZRYhwa88NCesuh+MvYqN4ILnLt0Cp3J527PnzrMJ3muvWchu69q
         6MzpTX5rwvu+PAdbFBO9BbnId+DBGt8wFybnHd5OEPnC85OYbcpffQj2ftr8kGaM3liw
         KfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611338; x=1795216138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDe4g1bU/aN3g6zvr+43wMrHIdQQ+2URWWfbfV1wal0=;
        b=JDHIiWVgjImgdto3VbFW8cuw/3ezgQjwOOCSALq0egbOb0NY5IfipaLutySXVb874x
         bKkQQJqyj+FMvV2mAcxZA3n4Mecl5ZYg/uwRBrO+68jbHuLPdSOrZ3D/HpuLRV0U5kcP
         7dEosxc5vwTIvePvVvIGDgJFojfwOQGqq7Dw6rMdExHFQHqef6oxj5HwLXo7ZNV1dIif
         CHAHwKOtMVtH6tg6aIDTEFr4cRFr9MYPExTWDXBDJ1wwXsG9C5W6kbVbj1mcYhehatka
         Tj85bzZ8Bnsgl18qRudESL6JZSV0+SK+YxaF/xX5GD+ljr3pnU3Z3hr3QUUe53oGeWik
         dQ1Q==
X-Gm-Message-State: APuU4Z8wa5vkrpBe6oBN7n/nqNXUGSgTRIkKr+C5/HsxNWZTfzvv2TCO
	UZ7sVRqRM/p89A8S3dV3v7Tt5bOIAy3kA5+aWymb9h7u0eGyDhu9mQX7
X-Gm-Gg: AYBFou3PyxgSNEm4TpX3L+yV0nslNypHpr9MPElg3Xxk6CJoC2em+yELm2NBacoBtpW
	8/ApqrP9kj8Gd1wVI8lent+B9J+i/WX7zgMSKVhU7uSwPEm8kYhXqNFGSWzR2lvL/QtjpeNXd0O
	9hPJapveZp2QLbEKd6SI+eTPZBE5kcKe0ZB6AMYXFQzjp2OEuqIOESDr5kw+8LorVLuy465xP/o
	T2KLTX3yjeJqR8WVQkjyqwWW0h8UPZgFZ+VU2262FKKOFmhO9msfAvWdnBaF+obRNgn3auKMtxN
	w40cwfB3XWr+RCywb5cfW7SmS/GlyJiY+eWNiAaIMT5B6THEUjwSb0l0la89QMCvlDH5TRUA8nF
	SHtZGnGMAeaPAEDVCL1rEQFE2TadXbWraUoExCv1GkU+q96SEbY4Ji/7n6OFLw6njP895OOf4gy
	lrxNJmYXmKD7STrqovPlO/OLzrHUpSdIW8qd39abSP/0yTTc0wUO9ReoPyIPVW5vMr4wGilW8Ng
	NbavYbuyh29O7Nn72AWaWmLEzT+LbneSCEjRyX0oHf3cJ9NzBzWcaQS1Hg1HFbYaTFbZgenAPqr
	vWs/JaHNyzDHDAO1t5I=
X-Received: by 2002:a05:690e:4809:b0:67c:936:dcc7 with SMTP id 956f58d0204a3-67d89727d7bmr1097216d50.118.1794611338074;
        Fri, 13 Nov 2026 15:08:58 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a555c15sm3365613d50.8.2026.11.13.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:57 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:31 -0800
Subject: [PATCH RFC bpf-next 08/13] bpf: Refuse the sk storage map iterator
 for BPF_F_INLINE_VALUE maps
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-8-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=801;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=ewBUDz3y7x7l9bM4md7m861Y9DjbtbnnNDsNb1N0uzE=;
 b=kzz/R9zZ169n884RAKFs9/xkNZGHLcxW0FIAeoFZhOxVEu+3Eh/k7NpIfG6VsLfLxJ0XcuSc0
 oE988eXUtjaDPBOfjXHz7FHYmu0IzCWsNK3AyOfqsCFYRuu7BW5U3/X
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Inline values are not linked to the map, so the iterator would miss
them.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 net/core/bpf_sk_storage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 409213755feb..d0eaf4de8090 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -938,6 +938,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 		goto put_map;
 
+	/* The iterator walks the selems of the map: it cannot see inline values */
+	if (map->map_flags & BPF_F_INLINE_VALUE) {
+		err = -EOPNOTSUPP;
+		goto put_map;
+	}
+
 	aux->map = map;
 	err = bpf_iter_map_check_prog(prog, aux);
 	if (err)

-- 
2.53.1-Meta


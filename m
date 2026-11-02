Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618127;
	b=WpeVzEYvHQoUkZU8yODr7hSLFCJrhvzhtvXjPPHJkI157V9B2HqgriiL3o2VXTSbngxC
	 JZEpAvx4zQ4Jl7t/R31BTxGjYEjzYovf3n256ybW6h9631SeUSMx/km023zsqBobTCxd+
	 /rlkbyUgqSqU7GerE4z76KYOgul/CfxfkbrJowTSsVKB5hIdCor+vuQDUqnShkRKPskNw
	 u5pgc8bEsyOSIvMylUmpbBGhTZ+1Xxx/DW3ZDuM/7Pt2yvuV932G1sTPt3AAhCEHpzzlH
	 BzzUJzG4EqK20HI820SaSnBqxmrtdZcUobhqJKG3hJu977xXVTJCzKOtTFV/O9y8arA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=6SzHi6q98Zf0qdkiRBybrf+muUBlPpBVfDjgB0DMVkw=;
	b=YwzPZmi1aYru0g+/gUIZxqZdvgZh4Z1I5Ct1KFHBSfrqJLig5s9BzeQ6aZYrl5hVcyYn
	 pfm2RK53v35SOKIzZaxUQPiQ522j5X+J5TuPko9K9JGi7+tkWXkrUiGSyLYg2ec95ZNtG
	 JJvxPSqGBK91qpSNX9NEEgPM2aPBrXU0bm7amAhBqaJGkicrqXzd5qA4WCVpWmZm60elf
	 xIgK7nLIfwr+348rUrR5nfcWDuHf7GfkeZ/DOy4S3i5Zffln6Sdg3Vnony3fVScStq40y
	 FGLAmTuWC2l1iq0h3dXkHXl7uhvdbThjJPNuplq3iSAXfMniRJ5CUdYJULEqef3tUVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HCdkd8N1;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F5606A333
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 11:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 970F5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HCdkd8N1
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a208d93758so30488525e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 03:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793618124; x=1794222924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SzHi6q98Zf0qdkiRBybrf+muUBlPpBVfDjgB0DMVkw=;
        b=HCdkd8N14dhw0wD76Fi6xYluJmi7zfqdDU+bd4lCW+LOcHyVT31OkC/sUlkbmCxyTP
         kiMh3d6FVUO2vjKqGXQYbYDxLXk9Dr5zhOZRqZGtz7ZgX/D2ClpXVpbyJTADnv8ViCDw
         cvziZAbTssbrRwJZCoJMzs8zs97k2K6y9BdwH2c179M2jN+GaYkvNa5k8D4Ck9WtjiUC
         kk9PaluE9YxpkJu/sXQSpR1DJVn04nCjWcNJUtKIw56sFYVq2BHujRXerBK1NVk93Ju2
         iW8Yk66kGYFAfzGJsABvDfOvp9/gwq6gFysjcQa3bfOBstgYPj2tUAalMbZx0pWrXg4L
         rVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618124; x=1794222924;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6SzHi6q98Zf0qdkiRBybrf+muUBlPpBVfDjgB0DMVkw=;
        b=Jxav3KwybMc/zr70AxWYBHXfgWp26e37ZZDt1XVuLA3f58KhmIUwNXovuxkw7h0hDY
         AI+/X/iIAhzbakLC0wPC3y0h2EoJSDYHrn+l0U1punJer6b14j0Rcj8DDFYRMFql+//D
         BG/0p9ZXr6R57/HNx+4EN4XaCE6x983frJV0cnzX+hRb8X5+GcPOQm3EF48MlZg6rGvd
         9tjkBlks5o4iCoU3V1cTvpu2/Eoy5UvHqpBo9OW4fvTvcxTqAenPGx0+uLpNgSym2Pxe
         88PApHZY2fhZs6X6b4hsnTA6ik5s9dPs8yPIJAuTLRFWKWJg8RG0mHMl6YyaSUKo2LiL
         j0YA==
X-Forwarded-Encrypted: i=1; AKwUvBwC6aJ3UEskPjdUiKX2qIVB3/Wi+RTLyZYyUYGa6Vtj0BwDSy/GN6mjtTKseVIVe333yoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7varS0DN7/cNtD6fUZabwm/31WuqGlr60cH5C9m3BGIZfVCL5
	6m6X20ergv4W1h+9V+B86Lld2byBTmARcd7btf7LwPPyca0FXsAMnyPrngsksfGf9kk=
X-Gm-Gg: AYBFou1lbp/M4Vb2UTB7j2yO/jfVoeQHH/3iT8Q6LV0VGJdlOPXFdyHSDR89O6sddYl
	GTCjU0JLZO2+6c/vvwtD60ffl6oU5rwv58gl4UHfoxFHz5QwmOrM982N17SzgLS18NcJmM90Csp
	Y9/O1c+lAUPbJj64NE4TE7d7xVWLGQOmj8jzGxAdiDbhziZ3gXiIB8zYRkLV1uTiOteRGlRMCTw
	tkSb9aJXP8Jr9pBl4THcgEXzbP5BvawvPfm1pV7akVS0TaXuRg4kiS0uN1SSe9EvIUYAq1Njkie
	uoKTNCqv8/8uPS08hPMSBT9n0OjWpOSciEeSjTgCbWtr/q2FBrFaAOaeskCpXkGFtyfRfUG0MxQ
	NkwnDBiSe6hdBdllC9mY2oKFIPQyfCzG/vEbtB3OeZc2fHMe2bDOK3VFRwKacea9c+WOtx8gCBW
	IYwYvaPM/8rPLS30UOB0sZDAW/1h2IVlz7HeKqCqPuYdaGaV+clrQbV6eN3eRki1bjttYPCHbKA
	s697HoUEKa//CVI6hOsapJkk9hS5fI/tW2qtT/s+fat5wtKUbFZv2RLtBFrK4JXwR2IMNknkNrw
	3vftLBawyHfFZdmIAbu9BVXlJo3/2WzC376nFyrir2UHJvY1RU/Dpfg0tG0wOILt3hX8XdNaO6b
	lxhb9
X-Received: by 2002:a05:600c:1907:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4ac16fa15edmr223689725e9.0.1793618123741;
        Mon, 02 Nov 2026 03:15:23 -0800 (PST)
Received: from localhost (dynamic-002-212-042-085.2.212.pool.telefonica.de. [2.212.42.85])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e71ba4ac6sm20690038f8f.52.2026.11.02.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:15:23 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Use "new" URL to show if net-next is open
Date: Mon,  2 Nov 2026 12:15:09 +0100
Message-ID: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=kpOfJ1TrfdZHVkYvKgtWh+AXcSeppGLvncABlZecPo8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq6HC93TXUT0SXrPrMSnYvXjPvFbwfwFOJYXn43 P33eb25CKiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCauhwvQAKCRCPgPtYfRL+ TgMvB/4pUxHXRzHQ8AGPJ4+Lp/xNQIHb0Cs4nPBQ+/e8+9kS1mMWqvZKaCxJDgfo4Uyc3LNOhBU Q5SFNd+oAZ9AG7cN+tLK2kRrPXtGCXT/rRswzZC4bwIcv/60jCJyLww9H2dFvrOJb1oBqifNyHd 8evI3/4wUM/7Rqqgp5xCQgK9vo9ASpmp2pDTVHkF1NJRLu1OiwX4cf6Ttjl+72IVtue3osS3P/d X/uRWPVKGlbCxK/QsON3JyWBIj9VAsHBmkpdxQ5fFrcxU54ZJktd476W0vlmXC/zREfTjKON7kr 7BdmWpKHO5d+vbXEzSrvvj+j28aEiTxDTfHoCx7sgJydJGQS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Documentation/process/maintainer-netdev.rst was adapted in commit
524500873802 ("docs: netdev: update the netdev infra URLs") to use
netdev.bots.linux.dev as base for (among others) the "is net-next open?"
tracker. Adapt the bpf documentation accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I was unsure if I should delay sending out that patch, because it might
be considered a fix and I could have talked me out of sending during the
merge window by claiming that the (old) URL didn't tell me to delay :-)

Anyhow, it's not very urgent (I think), so I waited until -rc1.

Best regards
Uwe

 Documentation/bpf/bpf_devel_QA.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 4729efd657c3..7f1531f0848c 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -243,7 +243,7 @@ a ``v*-rc1`` after the merge window, we continue processing of bpf-next.
 For non-subscribers to kernel mailing lists, there is also a status
 page run by David S. Miller on net-next that provides guidance:
 
-  http://vger.kernel.org/~davem/net-next.html
+  https://netdev.bots.linux.dev/net-next.html
 
 Q: Verifier changes and test cases
 ----------------------------------

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.rc1


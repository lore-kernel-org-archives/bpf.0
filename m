Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321365;
	b=47Lm7uXZudstrTgzmQMy1A3T/Tk7CPf0BZyDC6PPtMUhNptaOt+G/3Ur4/YdJhZnzF+4
	 Jz9kPIC+u1ZyMNCPSJOSxqGlAKcNj6DG2z6Lw4oUpG2Jl9u/xp31VJS882eKG2BcsNZPx
	 cY10CxDiOB9/fidEcmqjAOJ3lwW2lFfLxcUwk9N4Edom3ROL2pD19OFAQNieR9U3x4FeZ
	 F75+rQDpObBNNnWelD4DjrXgDwDMEpr/NevR+juOk6vW8SKRkfNYZNqIQ3yCRDFL+oE6b
	 /yldP9pwTvFDXrA+YCAoSuEt8n9RUvhC5PXgWg+PYoUqkGQmCh0c9HOOyZm+Wy3lu8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=A5Eu5ZhyKOk1pk18vkdCfLigMmT3fffFGudW1EIUogA=;
	b=3AE9UtVJaXENEQj1897ETWxrO5QmzeJmub1ybSrbc4bhvSWotaE9KLuPC2BTISLY2SxF
	 Lc4fkGuz2DAdSV2dPwVJRFjirGTHE1FAEX5zLhTn/3MtSTCMZmOtYEFaoDFS72Xs9esaV
	 bQRkwZQ6DgMjEdb27+xJFN2RiGM4SibsJ8dLVUy6cBhEM/6xnmN1emazDzweINFyZ0lhn
	 74YLAjzoPS+mK0TL/jDRzafe+0LEt/tUuqYIK/ImEfP1up6FIYB/IRSJLBcrPG1dJdxqu
	 7hakck2+QZ2De2EC/dWvlY9CxT6ZoKCKOpRB3WWmAqrOLslhsQnqWe/+vHiY/8vigTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8sRsd6A;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C9606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 00:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2C9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8sRsd6A
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0d126f631so2398427b3.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793321364; x=1793926164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5Eu5ZhyKOk1pk18vkdCfLigMmT3fffFGudW1EIUogA=;
        b=X8sRsd6AU7DdJ5CX2VaRGE3txO35oFFHjfFwsLJgdvyAV/3shCqHEgF+eQs2EzahZW
         6qIoTpDZ+ZaYkV8SqHfbzPYaYZc26MFZSdW7Wp89V5hW2FsHNYX0rNbCzUkONQrlS76Q
         /a+UGIrg9IvFrZatx+yNZQp+rBc1ywIWzorvY67BxfqM6t2P1nP3WcTFrjBQe02xS8Yz
         3Wo8F64wuGTrGhhnfzfA1+aaP8C5MHS9KgeRG2fVZb/XBvJyaVNoNaczlPVOrysAynaI
         wdp0sdnVlvY76PkU/rPAMhNjMsNEvkWOA98HU/oQKIcicu5ksqa1Aq9laY4paJeQn0Ov
         zVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321364; x=1793926164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5Eu5ZhyKOk1pk18vkdCfLigMmT3fffFGudW1EIUogA=;
        b=BYvtRPuM8YzsKoHtFb2uNZUHU22nthVRkb7PpY9sioiZ7ajEhkNHr7xSjwpoqv4kGs
         Ui9SRRLbmvG6VJ+qZ+hGN2FC8jInUhlbS24oEluXmbp8X7ZvBMYdLoIltRc07VzHpFoA
         YiOSzIWRTs61wxjDV9Arh6nyBRq83xSZ2osbQ8uCh38yrxDwakrpZ6RfzmVkkzz6m/rk
         mbNkeS955WbuV1bt4MGSJnATGDzzIZQyNpfGcrXt0j/RjqbhIep5sfNsxlZEJRKL/h9v
         9W3CMtPrgLBlzyVIjYTBk6/ofGzBkTu2TQYmiMg2x4jKXgm8dQP1sZko7JFyztsP82vN
         vmyQ==
X-Gm-Message-State: AFq9FYLrDWG3B2LQ/Vwm6StfMNjCPxKfW5ed/zxDXLYHAC8IBzA5QzU0
	2xNPNkKbU3cEb2fHGHG/MtKjHCOYTWXucOKBjv2nJm1XzzgVOZ2LBIZT
X-Gm-Gg: AYBFou1aseznPjzKYnYZoYVxOulCXtCDcyCkEOCeJ+e4DEHQQYmHf3tLFizO5cyw4wC
	JRRruRKyM4FrKY44yFFeM2nHdDojKz93bhrrlffL6lHMg/F4w8+0dzrnScQgw+tGDyV/VuTO5xK
	DcVhENZJg5mfrGCq2JUGOwNBfJTp3rM2QTBlkygREvPKxTjtbnoUp5Nf7HWaUvp0SwD9okzNu1r
	YihNdbFOwr2QVzn45eqsQ6IBlAwQhtUgXyB+8IEak/h4n78GRYmV1vLpgJQrWxg5kq3NH2JFHSK
	eyc/ERHqj9cOajZa5FYOb+WqnYpWg3mIkm1YapuCD93C8FoZcuYbI/2rqWXdhFt2qoyRieFcVyb
	+Lfg2W75ShRVUGr6wlq6meLOoi2V5OuT8iB1tMLd+acrgJQGYOgJXetx7lG0ZhFuyPcb9nRPDdp
	w8yRWQ1zycDCKZXxP6G3ZTilloQTO5mMeB8UI5eEyWu30Kn5YAoGJOiAjv3cX43UOPXQWrlkmhX
	GgIDKMMIr19ifRR2Q6nJ0LUnpa1ygX8Yo+9Wr+zlso3G/vhRYSDqr+2ipHb+frr2lfL81L8NP2d
	QWrF6+E66hFa2uaP3ZE=
X-Received: by 2002:a05:690e:4386:b0:679:b48d:4adc with SMTP id 956f58d0204a3-67ba50e21bdmr430367d50.88.1793321362991;
        Thu, 29 Oct 2026 17:49:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba74bbeabsm141625d50.8.2026.10.29.17.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:49:22 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 29 Oct 2026 17:49:11 -0700
Subject: [PATCH bpf-next 2/3] selftests/bpf: Keep payload offset for
 missing strobemeta strings
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
Message-Id: <20261029-bpf-selftests-branch-order-v1-2-425cc1ef8581@meta.com>
References: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
In-Reply-To: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 vineet.gupta@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793321356; l=1287;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=YNYbXrAvJlkS3JEXlv38GKpCp6Ns7J+soNbFnbKHKSU=;
 b=WyTOu7q2gsDJAR95xr0scGQjsFB0IEPMKX5jHc/8s6ltdMZAgVBh3DFxMykhxp5cWyjm/expn
 Dazl2+IjYczDmUHfJQJpYw1Dxwq13W5fuBYueJ2VqY8GRQE3/gOtFNJ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

read_str_var() returns 0 instead of the current payload offset when a
string can't be read, so the next string overwrites the payload that
earlier str_lens[] still describe. Return the unchanged offset.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 584a68248764..626a0abacc69 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -367,7 +367,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 	data->str_lens[idx] = 0;
 	location = calc_location(&cfg->str_locs[idx], tls_base);
 	if (bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location))
-		return 0;
+		return off;
 
 	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
 	/*
@@ -378,7 +378,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 	 * STROBE_MAX_STR_LEN
 	 */
 	if (len > STROBE_MAX_STR_LEN)
-		return 0;
+		return off;
 
 	data->str_lens[idx] = len;
 	return off + len;

-- 
2.53.0-Meta


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513895;
	b=a5amVQj1C9b42nCSjorggmCjNb+deMrRs0qc1RVPNv8VV1I3EjaDlQVNPlJwFhxtVupS
	 z56HpR/yh1KoCAJauQZpn3HPuE/FEOk0dNHURg2cVj/lnBbEjKuzSVJusMWpuij3hk8JH
	 rz0OYkVuiPCpA2Fy7+SzAi0kE5reu7fhaTuGANvhJ1Ioe0DdFG8a9gxIulQxXrpa2oZaY
	 7DhxLL1YJd3cxKtyvdddHRm0nC5jCDpekZElLgHPVLMQHWuP0GMg4xU2xPBX5Tel9wMeS
	 1uN6W+CMaXUJhgb9WHYm6ATU58dDGRFrlL7o8fp1E1CeJYhwjCXNA/t3gj1BVZSUDsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WcAHgOOesRnpg5Fo7kmgrPBf3yTrJRhLe8HkoymNW8o=;
	b=frtxmqKym4Aajp38Eq2eOkh8VXTZYWFr8Kuw9xZbMk+GdRW06A6L4khpAeb3/HrxbVYV
	 wOokCc+DhC3r44p/HtifWuJefRiSr/c4pqAvXOdb+2JSYmd0jRD0L8wROsx/zoOD1PhIj
	 Exvax+SaBde2MczVp+OIhUr8GtriwgDKw5VeadekHPWTnoSsqecnfsBw7dQL4ftmL3vRQ
	 Bgz9ripleg+0y3EvXrYDFb+X9F880IgcBUc5J/WtEdc3I01co9NxYVW9pujBfx11uG8lT
	 j+K5LPUSeKT8AdFOVBPoSWmObyRhlxilLgLv0h7cDc+E4cQ1yQhm26/iWqyGI/luDGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vggPxoWo;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92152606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92152606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vggPxoWo
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea138a3497so1394585ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513894; x=1795118694; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcAHgOOesRnpg5Fo7kmgrPBf3yTrJRhLe8HkoymNW8o=;
        b=vggPxoWoiJ/39E89qJZJH9FH/Pf989NSXBHeza98erDwU1o04E6KcfuzghMwxyqzrq
         8DBZXZvES0wlkSqPXtaZWtHFrYsS7Gm84DIAkiGqHuYJED5N4SS4iOtPr2rDTR8fE/OH
         SND5G9fli5Z9ZKhR/L5taQWjs6a9O5XLC7S86BCxzz4+Rk7/p7uho1Im3fDnYrDb7rpz
         6fGQM6eHHQ6gZXSt/92od+AN1MoZ4Xq61XQ/AvsYfoIait3kbgDNKbw2ZOxvdKr9rojj
         BMS6VQr38yYO58k9M0QK0gXMc0qKx/t/q7HvC5TtiCCNxTiJKzTsmQsNaTGZ0lE6uzm1
         UhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513894; x=1795118694;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcAHgOOesRnpg5Fo7kmgrPBf3yTrJRhLe8HkoymNW8o=;
        b=qFD+Hw8xWCbV7eA7bHTTl7WHh5cNT6Yo+0x5AHQqwe/n4NQ300xMESedPWqdk+q1+6
         vwUT89oU+GJ2CeHuCg9Axy8YTil6XtEeL/8CbljLWfpg/o+lZG+9YIxUxr/uXVq7b5Rx
         zfMy3uoBe+OZjQyUkxa99R1CVHpwcOC3PJYQkFcDGEHsntqLdLBUq5PJEq4T0aByuPxO
         B1m6CfODVTtVi8p4sJtj3aJEXTl1jX7I5M1urm+YWoJ0cMgGoOst/gsOIybFwsRKUHVM
         wHP6HyMPiCj8eTdHT4RUxyj4gB9xQLPy5Ijlpx/1r1h8887k7ntZpOVfl5NDdILN95SJ
         ZPbQ==
X-Gm-Message-State: APuU4Z9v+QvE7TpuGvqPTY+oW6y5eObuGze/GKZhVckI5dJObaUulq3D
	qLvnKKN0psKqAFYW66lismDpRDSyPVIzrwIEY2BfuBP+uzdmThNkSqjZ
X-Gm-Gg: AYBFou1ZfcmHgacosZjmoeB8yrbgpbPrqecabW9N9xpgDaCK8kKiJKz+zCxMcUi4r5J
	oMfX/UkwAECUxj3anXbDfsGSzsul2DHY+/eyfR1/QL3yYxrBa0aPTpqIV60Un+hyou0IO58pHt3
	2Y+Hug1cV90J7uMpqDmVX4pnvPbQhWUq9cDhEW3130ZC997Vtt7cBQ+gQgmIUBOIc9ZM5UCKg9x
	rFLwKxumguqkllAWcvBgdy91fDSbSooo4fSdSY5r9jtTK+yPHyjFzY5SosRDdE8+sfhJx0BDYgp
	AipH2prpBG8MMyXvyP9OJy2oKt6i1wUybnxtfmtYJjbhbvKBujxKQiaWasv/+ZJTi16uA0TcoiR
	9ldPlYsUFMByqdrxdATuI04YyNMtZBgIZamNtyCZza5BgZCH8kmD7gxSX7sw963/fDbdCTcBT8l
	m82llvhjVhnCzwYMQD9gmjGg6Ccp4c4iATrn/D5mjq2l3/bZ4dW81/L3i1c9dV8few5JZPHu54/
	oDKTPJpSLFr9vYXIltRSi5vTCayag9Xu6bi7axVpVSP4uRDJqCzqeUFdfX2TfE9DqQ0Cp8piFKw
	2N+Qbc+VdMtTa7CVrdCTp1QvPa15gsxOsXltcZMWhVPiWBbTEZ6q1uuBY9s2yRLLcOVSIR28SSO
	IAm6qIwM0ASwGpJGtcGG/QiotFNTTR92e/w==
X-Received: by 2002:a17:902:fc8d:b0:2e8:79d:15ec with SMTP id d9443c01a7336-2ee0d664b70mr4529905ad.6.1794513893558;
        Thu, 12 Nov 2026 12:04:53 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c980sm536275ad.25.2026.11.12.12.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:04:53 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 20:04:52 +0000
Message-Id: <DMTI31CK7EAZ.TT2P5ZN7BIVR@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Philipp Stanner" <phasta@kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kang Chen" <k.chen@smail.nju.edu.cn>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 10, 2026 at 04:51 AM Kang Chen <k.chen@smail.nju.edu.cn> wrote:
> +/*
> + * The iterator state is one pointer wide because struct bpf_iter_dmabuf is
> + * part of the generated vmlinux.h ABI.  Use an invalid pointer value as the
> + * "drained" sentinel instead of growing the state.
> + */
> +#define DMABUF_ITER_DONE	((struct dma_buf *)1L)

+1 to T.J.'s point re: DMABUF_ITER_START.
bpf_iter_kmem_cache_next() does it that way.
dma_buf_iter_next() leaves NULL at the end of the list. Let NULL mean
drained. Then no need for the 2nd store in next() and for the long
comments.


diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd50024..1bef87b 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -156,6 +156,8 @@ struct bpf_iter_dmabuf_kern {
 	struct dma_buf *dmabuf;
 } __aligned(8);

+#define DMABUF_ITER_START	((struct dma_buf *)1L)
+
 __bpf_kfunc_start_defs();

 __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
@@ -165,7 +167,7 @@ __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
 	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
 	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));

-	kit->dmabuf = NULL;
+	kit->dmabuf = DMABUF_ITER_START;
 	return 0;
 }

@@ -173,10 +175,14 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;

-	if (kit->dmabuf)
-		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
-	else
+	/* Once NULL is returned, next() has to keep returning NULL */
+	if (!kit->dmabuf)
+		return NULL;
+
+	if (kit->dmabuf == DMABUF_ITER_START)
 		kit->dmabuf = dma_buf_iter_begin();
+	else
+		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);

 	return kit->dmabuf;
 }
@@ -185,7 +191,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;

-	if (kit->dmabuf)
+	if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_START)
 		dma_buf_put(kit->dmabuf);
 }


Pls take T.J.'s selftest as patch 2 and tag the respin as
[PATCH bpf v2].

Also you sent fixes for css and scx_dsq.
bpf_iter_task_vma_next() has the same problem.
It doesn't hold mmap_lock between the calls since
commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks"):

Pls fix it too.

pw-bot: cr

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556140;
	b=3xCk2hnL79WkCqtqwYWUmoPn8W74B7e1cARWHqpeMyp85OiVS1JFKsgK0zx5aDkr+o+S
	 7g5cznUNASK7eYUN3jeVvoJ58l2E/5GX87xTUd0OmVz+1ZDALaA9uPdxWvanCX7FIJ3AB
	 iXYyEqwrxRVcxaA3aIJj+18yE9grRMVLBO/CjpQZrQqh1cJ26xtugdOxRXjEzLtUUx3PU
	 qyFuRnPXZ3Pv+yK2DLsM8N7pjgPeTSFTw3B38oXTlWNMduYQPpfHOjwmc9F+m2foouH/3
	 tGHK98SBetolm8+RX2uNWNI6jPBMLcdbk300MbYDTFXqAtBofyxgo+s0/BkifH/Q0cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FREPCHqd32BxvTRibj2ezyei+u70OcF5BBJs2hCkKaA=;
	b=XrhXCM/q1MsPau889LJ6W+YNaAJ7z1LGYq+eL0boZALkTwR7AClvn9qqsETqb3pSW7ut
	 YkA4soGlbS82q2JWkw5WMzQM7ItYlmxwJ3fToteFExYwN6ldxVTP6kqXaxRn2kwWWCQhM
	 J1hL/OWN5K8nWJFgAnlGEODRbRD0lVL6ahwl6M4F4X8Xbpr0CgRFIJ1ij9pL7/0DE3jnv
	 6/05NB47wW5GeCyvVMSWskKYJ1TLleQfSzu9idrp3NA81cBVOpjKfIggw1Eo4z1fbaEqO
	 t6kVVnvGYwDr7c2vFmbVJBNqocZFIxkeAD9myt+VdvVjRfWuLJ6PsDrhA6nkMhcqA8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slcgMxp8;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFD606A333
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 18:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43BFD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slcgMxp8
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1194971a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793556138; x=1794160938; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FREPCHqd32BxvTRibj2ezyei+u70OcF5BBJs2hCkKaA=;
        b=slcgMxp8RCYEydkkdc3y20upQDeN8khLNYu7y3Nh8Q7/AOFw7WfOqjqtV9/H9j4gyx
         x33+sn4dxMuLkHJRVhs1BHMRmx5o9BqnZHTdzKKTdObJdURiF7AmcWHf+zoO3Qrei1vq
         z26pjR/Zkg74S2vOxlDF6j8pbcqQitmI1PeIXcC3dDwLuIuyULuvB5MvuNI79FzBbWt1
         TSy9iPNq13w3pAuTygLC6mLgBbFQ1vqJAOG0R1iZknuTS7J2qwNiGGN2Q4GCOt4yVIWg
         h72GjTOXlKO+JWXRwo2qs+v4vRwDWUkeRxxHCdq+YsfG1ofPac30PNmC1X5laJ+UHTB+
         4weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793556138; x=1794160938;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FREPCHqd32BxvTRibj2ezyei+u70OcF5BBJs2hCkKaA=;
        b=C0FkIvcfiaF+Cl5j2AZVTL7uwFD7Hdj6RajMhLgonrCKi1uJJbc9jvt8yIPbWE4HJx
         pmH/F+o3BgpktEiCqR4i0agbi6JFOG12hX522rLl3O8p00P8eac0exmshQtceMN4gXjN
         tY8Thp3gyuqMwlqwasYV4OnBh3Po8i3YKtBwE6YkdYZVX5ikKZIxvSQU5MotPzjI38cQ
         5OekqC3e2aBE3d4EOg4oJwLeSI+C2stAat57BOZNBNTWS4zdM/8vhoHWYpYzF4WZQjzC
         QODbaM9PaHQsCESZ17ttZgZ1Qvc/oulnHXTLOIV0b/gYa4C9OPou9md2C2tEuA7VqNiq
         QKUw==
X-Forwarded-Encrypted: i=1; AKwUvBxuexwHkyHNJt4D0flMTGjsc1m3TdiBGU+zukQ24TdlWi1J3I8NiEULR6g559ZHv8OYI14=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aewj6FmnJxi8oE/S1HAw9Ao0/0vFtawCqhEf6q94P80dp29v0
	aYrST37EYUZW0ykZo2EsZrXw/xUF6X15SAMan3RtZYPt9RITTHoIILpJ
X-Gm-Gg: AYBFou2Aos+xs9gCZtwGavif9o8YcB0kJ2jzVtOLGc+Fj33uBSZkb7reBnZy6dSZp9o
	CPW4zbAFYsMHya4MOlmWcoY46sNUOm+aCFCZImfaxrtoyi6akqoldNroS0qldye85IAOT3Fa7h7
	RAJze/8u1c8/PTnIugLaj0EWaxtaAuhLPA3iNWJDcTtOoMmtyRcjtdxdiNHQEQB/MPt1ueDy7oF
	1b/3/Feg1guo6hrp/3C1WK8NwP0JNX//XZ/kM/ibj8bcutFyPTMcTYUgY7FdulJlSeWfWLso1ZU
	QepRz9krgjeWxcwSGHpdMYS/c1xZA7lEF2/+jMS0JK2aBUyZUINC1ujCOGxqpqxFX20zqdMul2R
	H9YW9kuuK7rXPaAjJfAuLYt1A4LajeAfjw2a0em0eCqqVrfxcZ+5vVeZeWZKiocmU0a7B3aopET
	rdnLI6WoyZ/xAHJJq34GHmhpshZYq2BOcd2aDc+r3/5JGt3t399O1Y6Pf+T+188t2n6c8D1hSeH
	6TUipsa6U2077Fkf5MIl5tOwsmJj+VcpUVQNqIg2tfdYT0luaktPGfEY1245f4ju8a1o8fH07sb
	fBRcKi3FQ3ofPr0fnEquvjRB5jOp3bdKuHappMM31b9+Q9OpIOorpH6lDmQtTTeW5v3G/s0aOhv
	mN6ptIUXfqfMNiLXYQDnbsncDcADAvMEv1A==
X-Received: by 2002:a17:90b:2891:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3ae897ab44emr6085932a91.44.1793556138558;
        Sun, 01 Nov 2026 10:02:18 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm15660646a91.1.2026.11.01.10.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 10:02:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 18:02:16 +0000
Message-Id: <DMK2L6ELL4W5.24CXTMXFDKA3P@gmail.com>
Cc: =?utf-8?q?=E6=B4=9B?= <wanghai8081@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Alan
 Maguire" <alan.maguire@oracle.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix stale raw data after
 btf__relocate()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261101155615.324501-1-jiayuan.chen@linux.dev>
References: <20261101155615.324501-1-jiayuan.chen@linux.dev>
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

On Sun, Nov 01, 2026 at 07:56 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> Call btf_ensure_modifiable() first, like other BTF mutators do, so the
> cache is invalidated.

btf_parse_elf() calls btf__relocate() for every module with .BTF.base.
That BTF is read-only. types_data points into raw_data, so raw_data is
not a cache there. Only raw_data_swapped can be stale.
With this patch that path changes:

                    today                 with the patch
  types             rewritten in place    copied
  strings           as-is                 copied and hashed into strset
  named_start_id    kept                  0, lookup by name is linear
  has_hdr_extra     relocates             -EOPNOTSUPP

The last row: btf__parse_split() of a module with new header fields fails.
Ihor removes the same side effect from btf__find_str():
https://lore.kernel.org/bpf/20261030233355.1836749-2-ihor.solodrai@linux.dev/

can we drop only the copies ?
The kernel calls btf_check_sorted() after btf_relocate() too.

Something like this (not even compile tested):

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d2ff6f5..d67f78d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2033,7 +2033,8 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)

 static void btf_invalidate_raw_data(struct btf *btf)
 {
-	if (btf->raw_data)
+	/* types_data and strs_data of read-only BTF point into raw_data */
+	if (btf->raw_data && btf_is_modifiable(btf))
 		btf_free_raw_data(btf);
 	if (btf->raw_data_swapped) {
 		free(btf->raw_data_swapped);
@@ -2099,11 +2100,11 @@ static int btf_ensure_modifiable(struct btf *btf)
 	if (!btf->base_btf && btf->hdr.str_len == 1)
 		btf->strs_deduped = true;

+	btf->modifiable = true;
+
 	/* invalidate raw_data representation */
 	btf_invalidate_raw_data(btf);

-	btf->modifiable = true;
-
 	return 0;

 err_out:
@@ -6642,8 +6643,12 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 {
 	int err = btf_relocate(btf, base_btf, NULL, NULL);

-	if (!err)
+	/* types are rewritten in place, some of them even on error */
+	btf_invalidate_raw_data(btf);
+	if (!err) {
 		btf->owns_base = false;
+		btf_check_sorted(btf);
+	}
 	return libbpf_err(err);
 }


Also pls target bpf-next. The selftest is contrived.

pw-bot: cr

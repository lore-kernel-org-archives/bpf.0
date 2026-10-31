Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479021;
	b=pKV9v5/5Fc74PuXWjKiTo39wfbPdenJTK+f5F5aL5rf/v+SYIScYaa7OpDSQQZ0HkQAg
	 iQegaDiyMT3qLQfqSdoQukeNVwVcta27Bjh1qJo3+y+0IWvdqIiSxiJYd4OBw8kZm0G/d
	 iVhF75L722DRbbVxG8dNQHh8F0eTgwSWbRgyn33qOmfQO5+gyw2bPBhKkPUY4rehQ8jaj
	 ZMwEMl9Xpf6VRuS9aYzSc2eiC7MpDoZ3LHRd1nIpLLNAbDIN3uq9+tuADGrbqbMHg53ST
	 RZ8V+27aTRwAVaCEfuOQKPuXTLdjdaefCs73KUTWTtmPQPSRQoAxFqJm2JINBvMe+XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9PDvTIvnxC4FfEbJ6wqdzI43j0nA6DOZgzVp/xyKDl0=;
	b=yKcfgc1l47LOLRG1XYHRTrofGxZqCRSA1vTA2voooToUwNsGr0MK5gpdF3uLU1LyuYCy
	 8A23QZkslsMwydrOwgaJS1FrO8lB/hGXUHOhEShzlr6pmkZcw8R+Cg+4NtIIkN1LcmOv6
	 DOwQlJHuUPxoCt65Tq0AhIHcr1HTU37A01e1w1ErL1HZlRlSvcsICS25jOvGjYUh+ssLZ
	 94rJMWdjF5/Q++ROqQowsW16OQlrncSA2lvOSKTfYmTlo1PhA0tomegWX36kKQk0ZsGes
	 af+8bTMSL7yiQrwTx+tAxBF75GpybP7VflsPkzAQmwpwWNSOaSfoBBwQ9ijJ71/1Hbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgUFnGiy;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C4F606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgUFnGiy
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1471595a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793479020; x=1794083820; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PDvTIvnxC4FfEbJ6wqdzI43j0nA6DOZgzVp/xyKDl0=;
        b=kgUFnGiyT/QSlvcPOJAeg+ixIQiCfcQDrEsE/oDQwdoeOuUt48J7ODsuXea7bZgMGL
         Sb7uC7F6HbcaVWxv+N04B0vw0I5gmNxmRUrF3ZJLXqnEeEtBebsmKf8PBZg9lta7zKSK
         9KxNmHXrgdecl8IeAQku3FUVXq3sgZIF9STi6w7x0MFjIn7A9UZoYvmG4WpcUIhdsMlJ
         /F6FKeC/ZB9YyO3qL0ZH1hVhgNF+a8LclPlHKO7OAegSwj3sIeSFYeQohKApD6fKXhrQ
         lPO5ovcpEnUFjyddHP+47E6lp0YaEv9Uk6phgPwWz1WylcUhsCELhHbvImNfsfDjrUUK
         4Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793479020; x=1794083820;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PDvTIvnxC4FfEbJ6wqdzI43j0nA6DOZgzVp/xyKDl0=;
        b=ZuFQHyMHSXp/4uxl9gz95S/MpK/lWpjRPHt5WoMgnSJZzzrIZzGKIw5JjsIaWGsHjw
         JKfF5ZakkfZwQx5STK2A1MvRqZcPZ5V9DuJaK2c4xe0uNWunWyrHF0B5UlAukkx56bX+
         nw2G0UvmoJQHml3Jw9s/tIbyd9Ovf30OtpafJxfq2J6+iTP6jZ7OMB2TXgxUGM5xthKb
         ihX3oiJgP9pQghIDlkCMRBvlJg+vRySjnDdjlkYaWoZvYOgM+Sn7WQSHoqHgRejbWzdi
         DGZtTlCTqM0S5sPx6QQwx8epuRI+CgY+vhbstDkEEVMr6gsezOoBtnRAaf2nqy1CEpfn
         dj/g==
X-Gm-Message-State: AFq9FYIsBdZ8EmIwDebbrh4lGgUSMUxFr8MJ8A3yjUfdIir6CqSGKQqQ
	CPXKwlRtqrAjzcis9VWhkf8ixqEp8vYKbsr1tlenPUWdu1bKvzs/Y+ks
X-Gm-Gg: AYBFou1u7j5MD5wy887LpfQVxPKmvvYJZp6LSEeP15IPexId+JIDZYe6swyFEIK0Br/
	NKjrvUYKZSysbnoCDLUCWAtok0Sd1AzV4WKtUDzM3AcfHsq03dcsNY90Eh/kar1X/HosHhzkySN
	/trgRTcDi84oRjwA2UzPmg0F0FtPX0WyiEzWva5MM9C9F0qjrDT1zHWEYk8i75VvkhXBdwbULdT
	b1dTeBN3XJVf5Bo+uVQmLXB6/pF1P+4S6ZUaD1syx172xtqHmyGaqGQzf4X5RSnw7+ToHtarYBO
	CQZMg2olZWglXiIWbHLFz7Oc4rV51geQFV0NPOwI+5gKnYGD+GxIdCY1PrAn0Bn/tDNajKh7xmg
	OPQDAtG0RJv987nBg8FkLF9GM+TqiaQFA80shhU3cGv+Qh5AGL7muw1eKOsGPQ/iiZV81fIuUF9
	SzhRQK9lsKJQ6mwZxvZu7oC6MQdUFjjuRfRhwvBUL9y9+CoDazhCVxIB94mWGLx59FqOo6xwD0W
	VTMMB7jpKSzMHD36xGnGD8JC8/9L4+vEfIUtCHqCOoR5XPueQOwU0Pt4GXIupdeQBObI06Cr5K2
	9MwyWcwXkM7aHRb8oBnzyAvwKkVgyJLR98AxJA+qacn8Y1c7DRP/FJ8JASlEUL9dv+mlDF0lHwB
	ZDugM/dTCb9mQB3au+nvJ4ys6TxxS1xq1ug==
X-Received: by 2002:a17:90b:224f:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3ae8983cf4emr5568000a91.53.1793479020156;
        Sat, 31 Oct 2026 13:37:00 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm13398991a91.1.2026.10.31.13.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 13:36:59 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 20:36:59 +0000
Message-Id: <DMJB936DLIAX.3166HNLTM50U4@gmail.com>
Subject: Re: resolve_btfids segmentation fault with
 CONFIG_DEBUG_INFO_BTF_INLINE
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Nathan Chancellor" <nathan@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Alan Maguire" <alan.maguire@oracle.com>
Cc: <bpf@vger.kernel.org>
In-Reply-To: <20261031040305.GA2789538@ax162>
References: <20261031040305.GA2789538@ax162>
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

Thanks for the report.

It's a use-after-free in libbpf that resolve_btfids --inline runs into
on a module whose BTF has no strings of its own.

With the patch below that module builds and ASAN is quiet. The output of
resolve_btfids for vmlinux and for the modules of my other test builds
is the same byte for byte with and without the patch.

Please give it a try.

[PATCH bpf] libbpf: Fix use-after-free in btf__add_type()

For every string btf_rewrite_str() does:

  off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));

When the string belongs to the base, the pointer goes into the raw data
of the base. btf__add_str() looks the string up in the base first,
btf__find_str() calls btf_ensure_modifiable() on the base, and that
frees the raw data. Then strset__find_str() reads the freed string.

Make all the bases of dst modifiable before the pointer is taken. 

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d2ff6f5d6d..95c31803e7 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2222,6 +2222,7 @@ struct btf_pipe {
 
 static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 {
+	struct btf *base;
 	long mapped_off;
 	int off, err;
 
@@ -2234,6 +2235,19 @@ static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 		return 0;
 	}
 
+	/*
+	 * btf__add_str() first looks the string up in the base BTFs of dst,
+	 * which makes each of them modifiable and frees its raw data. If src
+	 * shares a base with dst and the string lives in that base, the
+	 * pointer taken below would be left dangling. So make the bases
+	 * modifiable before the pointer is taken.
+	 */
+	for (base = p->dst->base_btf; base; base = base->base_btf) {
+		err = btf_ensure_modifiable(base);
+		if (err)
+			return err;
+	}
+
 	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
 	if (off < 0)
 		return off;

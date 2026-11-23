Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393520;
	b=nGM7appIFeR9ODFJnxshSii5US1MUnLDxZko+lewLH0n3SN4Nwi7WDFjeW6fgNDKeFpu
	 aTOwetzDGGA6jWFnoM+ZLUy1Tbh1WtPtuzmrOmnwxEoXmyF7Y2ZHEJK2CJSz0RcW4MNrD
	 2bM1SUa113feG5/WBW2pTzLVWN8LwWqRE/DjZnQ/DKDxx3hbAvwc5xQD6FpOGWH8BWlrn
	 wZb8j0wvvbm+IW9VCBDz7y2nU+7Rm8AGtYZMOy+hPElzS0up9VQDeZqrGL8rDvilywDYr
	 SsIheY/9qwDNM+qdUjf/b7mB3nQ2gPgOYaRz3JaLDLptZdoQetYV/WoHuLBsdFhdmOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=XTLw64RKSVxV+BjWRGwSN+nuKYoaYqbBJ+SYVqTuiGE=;
	b=K/7Gvggu37SnhtL0A7CNQHgbfNs67xni9eOZMVorTdrWD2W/0MPNIDYCRJnvf6QRkTka
	 k056lpXAdfaBFEGW2rqOVpNO//hl9DafXPrKsm1x72RAY66utMVQ4aR+DTMGOnfzTNm0D
	 iZl8a/O0qsWTTNdsmwXrF+aUKvP820SoVJioG6k4PoOcS/zD/Gw1ZL4Te+2yG1IJ3lu14
	 hbuPBxxLHVJZMhatjsn+jOBft2g926FqJL/HYyU71ciJSJ61MtWwu7n64mTQTKe6yB2uT
	 bXmp00Lg4xrfKX174Rj01fZi6QxpwdSvyHWHyiz7/20qpNZ4znMcG+4yvdnvgqSy2IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjd7c7pK;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBC606A33E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCBC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjd7c7pK
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8c4cc85a315so2053311b3a.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 16:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795393519; x=1795998319; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTLw64RKSVxV+BjWRGwSN+nuKYoaYqbBJ+SYVqTuiGE=;
        b=gjd7c7pK4i3+nh6JtJY7RitKRtT9u9eef/h67zxj1VLMnHlKg/uCK00l8HlLHEX7Fx
         E9aPCM1rhFesA2Mmc6m5O/x2oojCVsitL1rE+wlgXrVIfx+os0oei5h/klrzN25WO4Cx
         9DFu0J7ZEtLPkXWdAiup8SMxO3EXx+nwYOwkEdev3SIIIjwoAoUx71TpDlNvm9L3bB05
         xrMB8uwk9GsFcUr/Mca9xTjQd6yizLS/VNsN4d6e8f0w7INL/Wt0kigT2W05Gm1vdnmm
         UpfobRECY/WPDQQLshE8/mi5ZpkfEYfyRzcWqfOWxaw+eeuy0NRPsx+vmdm1wNfnrS4V
         6kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795393519; x=1795998319;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTLw64RKSVxV+BjWRGwSN+nuKYoaYqbBJ+SYVqTuiGE=;
        b=Vaa3Ly1GVA8wDOlm91QUn1NtB0neKngvoNb3Yjn37s7v6pTFVfgh7Tm8kgOXMvdwZx
         RxzlmhfpvSEYEO6YBNg1zVlPJquRfENYpHaTJZ+c6AAFf4ZyfvUHyA3wKtAkjWiJrVH7
         APe8c8Ztk4oePAT7qHt4VPKsPSfstNWNJ2tAiPbZJPUFVYSn+4usRFUekgMSV3F6K5S3
         r5bNiCL3LrBrc+4+RqV7TRDVGMoPBOKL4hRtz2EpgPu9rTMmTAruXk0hGPfCPazeVZsx
         n/Kf5ZaPgcycAdK5b95o95/nbWpnyQAhbnBcoRcxnTKkJtbpHkD79N6JgqJ1nZXKMb+G
         9j5w==
X-Forwarded-Encrypted: i=1; AL+hErGjdimG5s4CJYR9j6DLj3mu0yL8WI/fQXnxhUhVB7OdxRhGG+dqBkZ/S84gePAgcOrBs/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z87rR8haqEZDPYJU7kK06WUYNXUrU0bGJ77U1dTAR+UEyB78p3v
	n00EuvFBetfsOdlIkgmDv4mi0+3Clu2jtC9QnS6WbJM8lclWwWH7FPj8
X-Gm-Gg: AZFdTZcJ9V++UCMkrpmphQpoHAsbwvHfJ9s8R1GWGrSpzgLPjs/c3J/OOM+WTYnY41W
	8aH9xhHwfuo0esA0LpJxX+iYDXqTg6MLGq+eOhb7Zf00O5HvpYUn4gccW+/Evw4Pj3LwUBGoTAo
	K8wuo1jfoBCpQqACD8WPqf5GWdWL6eM2tHUMDRAcCclwqFhDNIwVKnQIoUcDOpE3tlBUSuWNQYc
	VOWYvXG01e0wqOn3pO3JHYnYEgI6Ybbvf7mkBkIBIPcJq5UbEOqn+bElPuoghVc6sGU+AwglIOx
	LFaQyszVx4Nl+qDalpuGuCeifPggoF9SlaMwF53E5AundpiPcx4NS/zdscZBM/SHARgFCQ04SAy
	2L29EJ69pzRc5I1zzuZtd8xoeOhkzXz49k53/yuzRSgnEml97EDATUEckfZLHRAtPErLK/HEzeD
	WUNfX/ybhWB1okVjMhMvnvUkVxJoJ1i70kYUGXpVUlkE5QwUPU3iKZ25FjVVcacVZy1Vtpu5+KJ
	4ZXAsx8pLEjolMEcqh0Qecmx2Q94MP67NRkT/yrCNZqUx6VW/AIDl9XUL3xG4qW2m6lylCCwpsI
	uGix0LYBN/0RqcJV+/FORhaxc1z54JkgZM2KelEMbr3qdQ0CyeeH4/drCXOC2XqaETSv8JAHJww
	rGh1oJxz6QIRap2q6/gWSwWPPc0Q83djYRQ==
X-Received: by 2002:a05:6a00:94e3:b0:89f:e64f:c34a with SMTP id d2e1a72fcca58-8c87ce33aecmr9086268b3a.46.1795393519113;
        Sun, 22 Nov 2026 16:25:19 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm4568106b3a.9.2026.11.22.16.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:25:18 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:25:18 +0000
Message-Id: <DN25VVZI22A9.1KXUP775JTIJB@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add bpf_memmem and
 bpf_dynptr_memmem kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Abhishek Khade" <abhishekkhade69@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261122143815.330528-2-abhishekkhade69@gmail.com>
References: <20261122143815.330528-1-abhishekkhade69@gmail.com> <20261122143815.330528-2-abhishekkhade69@gmail.com>
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

On Sun, Nov 22, 2026 at 06:38 AM Abhishek Khade <abhishekkhade69@gmail.com> wrote:

TLDR: nack

> 1. Writing a loop using bpf_loop() or open-coded iterators: Even with
>    verifier inlining, this executes 1 subprogram call per byte and

No. That's true only for bpf_loop().
bpf_for() has no call per byte since
commit e93347704878 ("bpf: Inline bpf_iter_num_next() kfunc").
Plain C loops load too. See progs/plain_c_*.c in selftests.

>    cannot leverage 64-bit word-at-a-time SIMD scanning, making it
>    significantly slower than kernel-internal scanning.

It can. Leon measured a bpf prog that scans a word at a time.
2048 bytes took 4557 ns in that prog and 7389 ns in bpf_strnstr():
https://lore.kernel.org/bpf/20260728145727.45153-1-leon.hwang@linux.dev/
Andrii's answer there applies here: such code stays in the prog.
This series has no numbers and names no user.

> +			while (n_idx < needle_sz && n[n_idx] == h[h_idx + n_idx])
> +				n_idx++;

This is one byte at a time.
memchr() runs only for a 1 byte needle. On x86-64 it's a byte loop too.

> +	data = __bpf_dynptr_data(ptr, size);
> +	if (!data)
> +		return -EINVAL;

This fails for the use cases from the commit log.
bpf_dynptr_slice() gets a NULL buffer and the full size:

  dynptr          callee                   fails on
  --------------  -----------------------  ----------------------
  non-linear skb  skb_pointer_if_linear()  len > skb_headlen()
  xdp with frags  bpf_xdp_pointer()        len > data_end - data
  file            bpf_file_fetch_bytes()   !buf

A filter that drops on ret >= 0 passes all such packets.
bpf_memmem() doesn't help. The verifier rejects data_end - data
as haystack__sz. See check_mem_size_reg().

No need for new kfuncs. The prog can do it in linear time, with frags.
This one takes needles up to 64 bytes.
dynptr_run() in prog_tests/plain_c.c feeds it an xdp buff with a frag.
clang builds plain_c_dynptr_success.c with this, I didn't load or run it:

diff --git a/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c b/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
index 2c1c4f7..1a47cb5 100644
--- a/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
@@ -173,3 +173,46 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
 out:
 	return XDP_DROP;
 }
+
+static const __u8 needle[] = { 0xde, 0x00, 0xad, 0x00, 0xbe, 0x00, 0xef };
+static __u64 mask[256]; /* bit i of mask[c] is set if needle[i] == c */
+
+/* shift-and: bit i of 'state' is set if the last bytes are needle[0..i] */
+static long dynptr_memmem(struct bpf_dynptr *ptr, __u32 needle_sz)
+{
+	__u64 size = bpf_dynptr_size(ptr), off, len, i, state = 0;
+	__u8 buf[256];
+
+	for (off = 0; off < size; off += len) {
+		len = min_t(__u64, sizeof(buf), size - off);
+		if (bpf_dynptr_read(buf, len, ptr, off, 0))
+			return -EFAULT;
+		for (i = 0; i < len; i++) {
+			state = (state << 1 | 1) & mask[buf[i]];
+			if (state >> (needle_sz - 1))
+				return off + i + 1 - needle_sz;
+		}
+	}
+	return -ENOENT;
+}
+
+SEC("?xdp")
+__success
+int test_dynptr_memmem_xdp(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 off = data_end - data - 3;
+	struct bpf_dynptr ptr;
+	int i;
+
+	for (i = 0; i < sizeof(needle); i++)
+		mask[needle[i]] |= 1ULL << i;
+
+	/* the needle starts in the linear part and ends in the frag */
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	err = bpf_dynptr_write(&ptr, off, (void *)needle, sizeof(needle), 0);
+	if (!err && dynptr_memmem(&ptr, sizeof(needle)) != off)
+		err = 1;
+	return XDP_DROP;
+}

pw-bot: cr

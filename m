Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795492045;
	b=fgjE8VgF5o1Yu9s5AZKwgGD2+TqUbV9ypyozmQwlvyDrGBjJxKfLnQj42/HeNh26aHj3
	 5smdMJtZI7rsjjckE9PDckMUkOFqdRRrNUtVEEhxdZCV1GIFPo0+P/cRLVnWmEqALqP17
	 OA+JX9ZOPord7AJPRPJtxrcFDOaaUnJDOOgOavqLH88vI6G+h5+LrLvKFJnSxUaYOYyHx
	 oJs+j3VE9IHHbm/DLyaKPfVncKmYRXUBYnCThBE7T7DBpyyMIoBmFYvrFyCVKlYUlplvs
	 YgQvmF5F7VUx+l1v+78dXedNkvN+Wz96NS/ea/P8b+AzYeiltBLhX0ONO3okxJ+wjmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=vroFa4iLZxRWqbaB0cWuZZItWOv3U+0cMDxhnQnhEdE=;
	b=gFwvHBVuS7CoD1AS+Tsmf45+KvgBJPjGaKV+1sJUlGLZq+TBnfCCMsOVEF/JWWhCL1Dv
	 3D8sRtThn9te/6O9XYaNivyLRpNT70d4euS8DISeRCoBwKYRIJmlG5hr0M6ZPEF0qK/j0
	 2hjmAPOY1Y0h+KUlorNu/ueNCRf2OR2A8AJnBNuT7WWZleRVQrZ593T7ZSjdMDHKUq+mg
	 as1l9bCBKKrJe1M73qqARreUV4K1LIB9Kqse6oW4uhY/8QW7mAp+FmftPNYiIjwq6ZQ7X
	 K1Dt3122dBqZJ2NCMvCbWZvYujBljPSI/5fiCapmK0zyZ0es/hVryaxA9u4Ybs9+LrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nymLzmye;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04A606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED04A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nymLzmye
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so2732355b3a.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795492044; x=1796096844; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vroFa4iLZxRWqbaB0cWuZZItWOv3U+0cMDxhnQnhEdE=;
        b=nymLzmyeeDVH6oCJ6OaSOBKbO/fg/ONnR+DeD529KtPiRl20LGx8uE7UYKb3C+d75j
         sYWl2rEtCxKzT4cVgCNphhbFfG7q+GctomhGZjNSFkyP3Fsmli18BqHGCXeBi3vH3DEL
         LpMFluGaDn5nkEiRGw6WH3oqUdRhz82EPikmv9FN4Xahg9Q+d5FabJ0Q3Et8c9dH72D9
         mkyhjwNuS3V6cva/JQF0xO3ykpkIrivma0gvTpe/5BHc5OHMgzQkECzIT1MmEcVFOaWs
         WJGFo7/PsPltuVNqr5Ak54x86leiYgcmbtIDcVXQYFAnLYAheE5k/UdoHuh2gOauRVeL
         5r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795492044; x=1796096844;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vroFa4iLZxRWqbaB0cWuZZItWOv3U+0cMDxhnQnhEdE=;
        b=Dty2aaGTIpj7vsY04oQvbOnHePgWOaArETD723eunFrx0de6uuTVKWLGamkWt9/Bsr
         vOS/Rw+cZj8ga3xnnbl5Rkli8otVmmBa5vBykNETnQVDzYetZ/U0pC+neZZ8qIUHsd0O
         DwA1vPQfyuhNSu7AHOOROwfNWWDf+FGv9lA4ZaTV2bHVJ4xytZtWcSe7uQDDIGPgg0F8
         Wrw1fgmsAJfLyY2inp5ox0Kso9TpJqUOH3+7MW50Te7XP9gIFGc2Gaotpa84KgRxOGLR
         LTzZryV0K2yYzwBbah9KPlUlyfyyLqtg/P+Z3jJdpwBBaHIoyQbrHvTyJhUaKsYFkdXY
         Bv+g==
X-Forwarded-Encrypted: i=1; AL+hErGa2p/fPlvXEzWxCPGmFfpaEOQ4meQw/xPm/u1LiViSD8nM8cvdLwrncMbc2yZO3qXPeSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8GtZ8Hl0PkApx2XC/dLCGUtI1TyYNAoUUkH1Dp08fXv2H8KtJ
	a/ixynR+Ad6BNbxuKasvSoWEb0WS9qpOnPiwJYBo9p5xG6jGhTS6ybK48X0mZQ==
X-Gm-Gg: AZFdTZdDmEn8pFnS5BLQWDuLkxjg9qIHwtf13HxPFJtHSBjoTcsruO+aX2EPBFIrPEp
	k9dC0Lfks7UvwykLv8JLu0ueSLpwHZx4WoBmvDbFo6EmW+gT0w++kteZyoCGcJ68wptZKOykesC
	mIOET+P6WXx8UHGdf8m14rCYV9Ud1ICt8GYwA2+eWzzGhgeY2HfKaMjynX8VYy4BTlPCdT41ZOd
	QR4bnKyJBVUAF+3/y1ikpu7izX8AqVO21Xtn1Z8ljXH6I+pgFWz3uBx/EwjudMVOFfmCXq3VsIe
	bWFry4wZEJeLjRxE58bQsL+L8cbnb9focOlrWOlyCt+W9omS+ReRPoqcLs2B/Tjpx+6bf39olAw
	R15cp1yPQFy6Gi9L1XvkV5wQLV5FB2SZURo6GdZwScVJM+zWOdAvQRxXLhFtN+aWM9eTA+O9QuW
	se9ydDR/Sud99r15e7tZVZ9pvWkG+HXIVyZITjyX8kAPyatOCdL7GkKSXBdrlKmDTLx0w2KyttC
	e9Um+dqxW1nxSgOEnuskZr5UiXD1dpttBuvHId1P8e7UZmcASOgoQSMhHl9TYA8UkHCKxopWY5t
	y9kgHyzVzEf3cBpA1HQyP2IqtaXED726gpdJgMz5ggX95D7qyXWaRpqMQWzoEZv4zdjmWbRfbS0
	OAbzYTJ/wODrxYzkj57Fqcl6tsrYLZOE2Sg==
X-Received: by 2002:a05:6a21:4d14:b0:3e1:d75e:651e with SMTP id adf61e73a8af0-4014b65da72mr13923571637.16.1795492044057;
        Mon, 23 Nov 2026 19:47:24 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm6132385a12.15.2026.11.23.19.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:47:23 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 03:47:22 +0000
Message-Id: <DN34T5GCESWY.12OL1L7C45XQV@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <revest@chromium.org>,
 <dingyihan@uniontech.com>, <bigeasy@linutronix.de>,
 <paul.chaignon@gmail.com>, <vega@nebusec.ai>, <sashiko-bot@kernel.org>,
 <rakukuip@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix scratch buffer cursor overflow in
 bpf_bprintf_prepare()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <bpf@vger.kernel.org>
In-Reply-To: <4b2d82631c485580b1f31da9bf9c7cccdf2626e4.1794974103.git.rakukuip@gmail.com>
References: <cover.1794974103.git.rakukuip@gmail.com> <4b2d82631c485580b1f31da9bf9c7cccdf2626e4.1794974103.git.rakukuip@gmail.com>
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

On Wed, Nov 18, 2026 at 06:42 PM Ren Wei <weir@nebusec.ai> wrote:
> unsigned size_t in later bounds checks and snprintf() calls. This allows
> subsequent arguments to bypass remaining-space checks, write past the
> end of bin_args into adjacent per-CPU memory, and trigger the
> WARN_ON_ONCE(size > INT_MAX) check in vsnprintf().

The write lands in buf[] of the same struct. The caller owns it.
"%s%pI6%lld" with 490 chars in %s:

     0  +----------------+
        | bin_args[512]  |    0  %s, 491 bytes
        |                |  491  %pI6, tmp_buf += 39 + 1
   512  +----------------+
        | buf[1024]      |  532  %lld, 8 bytes
  1536  +----------------+

tmp_buf makes one big jump, KSYM_SYMBOL_LEN at most, 666 bytes on 64-bit.
After it snprintf() gets size > INT_MAX and returns 0.
Each other arg adds 8 bytes at most, plus padding.
Only kernels without
commit e2bb9e01d589 ("bpf: Remove trace_printk_lock")
write into the next buffer. Pls fix the commit log.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260619205934.1312876-1-memxor@gmail.com

That's Kumar's series. The report is:
https://lore.kernel.org/bpf/20260619211930.5AFC51F000E9@smtp.kernel.org/

Ibrahim reported the %pI4/%pI6 half in March. Pls credit him too:
https://lore.kernel.org/bpf/20260319124901.9207-1-zeroxjacks@gmail.com/

>  			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
> -			if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
> +			if (tmp_buf_end - tmp_buf < (ptrdiff_t)sizeof_cur_ip) {

Remove this check instead.
The raw address goes to cur_ip[] on the stack, not to tmp_buf.
The shortest strings need 8 bytes for IPv4 and 33 bytes for IPv6.
So the new check after snprintf() returns the same -ENOSPC.

> -			if (tmp_buf_end - tmp_buf < sizeof_cur_arg) {
> +			if (tmp_buf_end - tmp_buf < (ptrdiff_t)sizeof_cur_arg) {

No need for the cast. Make the variable int.

Both changes on top of the series, helpers.c compiles, I didn't run it:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6ff0709..7fe702e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -859,7 +859,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
 	struct bpf_bprintf_buffers *buffers = NULL;
-	size_t sizeof_cur_arg, sizeof_cur_ip;
+	int sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec = 0;
 	u64 cur_arg;
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
@@ -987,11 +987,6 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto nocopy_fmt;
 
 			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
-			if (tmp_buf_end - tmp_buf < (ptrdiff_t)sizeof_cur_ip) {
-				err = -ENOSPC;
-				goto out;
-			}
-
 			unsafe_ptr = (char *)(long)raw_args[num_spec];
 			err = copy_from_kernel_nofault(cur_ip, unsafe_ptr,
 						       sizeof_cur_ip);
@@ -1084,7 +1079,7 @@ fmt_str:
 nocopy_fmt:
 		if (tmp_buf) {
 			tmp_buf = PTR_ALIGN(tmp_buf, sizeof(u32));
-			if (tmp_buf_end - tmp_buf < (ptrdiff_t)sizeof_cur_arg) {
+			if (tmp_buf_end - tmp_buf < sizeof_cur_arg) {
 				err = -ENOSPC;
 				goto out;
 			}

pw-bot: cr

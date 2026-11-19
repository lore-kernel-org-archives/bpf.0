Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056137;
	b=GdJp+mQiIZ1j0augACKemtJ1KYhwy+p0OyxZu5usD422GBacvURgHs3rcE5u9n1yTktI
	 tcNzyt4Ty4/kvjwe7dsC62k3AFt/fLqHIqMMKpo8kwfelfIfNRiH9Comb0FE6/MJyllQH
	 IF2NQa54HLRg7tyRI/soJj7ZsXe18jgg8R5dqVcpV0OJ/rk6HTcVbMcqcim2X6K+sbCr5
	 Uefd/21iQsIqimqGNO1eyZdsO7NNo0Jx97UlafpokxRJe5t1rK/78CB8LWc3iDg/xRia/
	 WKuwMmFO0sbjGzur6hgOuomVQk/tGyhPV9RUDOyVuaDhlJzuz0ToavesohZGK/EBytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7PrCGvnr7G/KmCreNp2UYPB6uS4z4RXQM4X6KtcUfX0=;
	b=kgWBnzXexqnmbPwl42d36YqpfwNyQoh7yRyDg4qxTS6NpyKY6ofj/cJ7VL1yhkwijvwi
	 uT2wxv//OcpJSgFY5I2bN0g2vjoNiFaK5zUdCLxRd9SujaZHDIMk0g6PdWFf/+7A3LVr4
	 0DzBo7raQyB7CtnbothcM2NsM1zPXB7EA1V2V2HcVoFDm7TRcfuGPXOuqTsyU0xib/IWy
	 kFfXKyU4SuloEYM4EBqd1JCq+kl2JrnfMCVogGipbMhH7dsl51KeldqvWlX/mSmCnUOYH
	 NcNJoz4igHTcYNbgrcSLsv6CwZL4Q39/ZlI4kpr4x6GbzjllZ6IcjgtW22e7IQEHtUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="DWL+A/eb";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A101606A32F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 02:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A101606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=DWL+A/eb
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1193061a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 18:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795056137; x=1795660937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7PrCGvnr7G/KmCreNp2UYPB6uS4z4RXQM4X6KtcUfX0=;
        b=DWL+A/ebi0fqz8t1xpVXfERBmFyezX4Xi/qxBh0dYP8v9bI5wHBll2vz7IDqvbiGVK
         AB58/O5bHd8x2QkvZtyfYDwy18Bbx0HffFanc7s9LJbRdrhn+NIztnD7aeFStjHH6M/S
         Y9cmOD9I+eoiZqKjXLeAsS4O9Pgfw5kahWZKrd0xWK6qdYlWsJSnIF7N5Uj7G17F5AO0
         I2lC7RKaZKK/dek/RkVQgqo7GoGlaV/wkZZZUcXBYFFJMTqezbqs3fiZ5cciiKEkfGjR
         +Q5HlZvmzIjm0hj4FrP4gTcgSQgoJna09c2nB30JBrwGauZJZ5cw/f4N6sgYpqn5xbXD
         aHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795056137; x=1795660937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7PrCGvnr7G/KmCreNp2UYPB6uS4z4RXQM4X6KtcUfX0=;
        b=DKzSZLqwilPcZDbQV2WUu+R1j6P0zchWACOYcLC3eLESLf6uPdjysEzn9u93mnrtHX
         fCkBDGdJ1C6a6eaN/T/IqTUy8rVzJ4PjwFlpIu4/Whc1Vh5uZBc1iEKcwjjVGFJpQzBO
         bn+wZ49g/DEIh48Hom6fhsbTcCqXu1CfTtYIcCcTIrjt7XKj8+NLC55bRBHH5YNlRjnV
         24/fhZON0LLcSrWLG1uxP6CjKkte4fasYiJ2OCVV/HJ3aPrjWEOJx5U8ViDHyxfpBz+K
         iDTheCszzAEiSa7wlVVgcrZaKxh2PYWJe1vqHFhdPyFvpMjwP+GgjGcPhx8b2/aXgqE3
         M+Sg==
X-Gm-Message-State: APuU4Z/SzJcjpgpvDlknY8GLF2eIsROAdG5veEi/8ESPvE7AnVVOjTga
	UKJk0YDa6v/VSPvGr/7U0udrexbv+rm470egDxSI+gWdfF/ytuEuT+E28EUxAsAUBpoi1ilU0+w
	zrhxzEQ==
X-Gm-Gg: AZFdTZe7bQfuXrJ+We/NW+IEyFsU/c4krbLBlDeNcF3fRk+eL5yow4yuvHMi03KuW0N
	8M9Mb4xCVdEBS12YDo2uetsJBu6qx77aMRBsTVHoY33asV8vgg2bwud2OoemumU8TobsGCXZYxG
	/1AAg3xgcPdYBRzmcngUIXSMEiN9eWAaC3DwQV67AS4tUSzifxlhPfS+wCEbk4445JcUOvVC8rT
	xW8Gxdmx3MXnrFztqoaH1vdPlYvLxIssZHVdWH8pCzM76LJaBdgcUJPsUvLTvkLjcyZG9XwD4IY
	k9Y1i859W+9QoMZK1y0+dGgorI/WVjAw6YLdSsF18+7o8hzBfM3UnrPkApnBEWHuQiDphdEyjNA
	hTOuFt7P9nsExx036oItFWK+lJr7QGe3fRPdZ+QEIGgJJQv7w+qU9p326dP8VKl7TmsJdJrk5H8
	aWuk8lUhLiXk5sTp5Et8Rlb1ghRqSoaKDbiJ2mdCtdw88HcZ8NSw0xoSO9kVIdGGzEmQ2LOYNnw
	LtfaRysHLCeaAqHncKWmUWGoO/wYl+gMuCcn+Zgpw1YneA1LW4rHE54SrzdeChNY+R2nom4WEaj
	TGlvbVcBprMpbnK7olB7iYXsIY+OGKjCbOYc
X-Received: by 2002:a17:90b:3e4e:b0:3ac:b145:8f4 with SMTP id 98e67ed59e1d1-3b3d07a7195mr4896956a91.41.1795056136622;
        Wed, 18 Nov 2026 18:42:16 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4028576e5sm242879a91.2.2026.11.18.18.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:42:16 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	revest@chromium.org,
	dingyihan@uniontech.com,
	bigeasy@linutronix.de,
	paul.chaignon@gmail.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf 1/2] bpf: Fix scratch buffer cursor overflow in bpf_bprintf_prepare()
Date: Thu, 19 Nov 2026 10:42:02 +0800
Message-ID: <4b2d82631c485580b1f31da9bf9c7cccdf2626e4.1794974103.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794974103.git.rakukuip@gmail.com>
References: <cover.1794974103.git.rakukuip@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

In bpf_bprintf_prepare(), the %pB and %pI4/%pI6 branches pre-format their
arguments into the per-CPU bin_args scratch buffer using snprintf() and
then advance tmp_buf by (err + 1). However, snprintf() returns the full
length that would have been produced excluding the trailing NUL byte, not
the number of bytes actually stored.

The %pB branch performs no bounds check at all, and the %pI4/%pI6 branch
only checks that the remaining space is at least sizeof_cur_ip (4 or 16
bytes), which is smaller than formatted IP strings (up to 16 bytes for
IPv4 and 40 bytes for IPv6). When the remaining buffer space is smaller
than err + 1, tmp_buf advances past tmp_buf_end.

On subsequent format specifiers, the signed difference
(tmp_buf_end - tmp_buf) becomes negative and converts to a large
unsigned size_t in later bounds checks and snprintf() calls. This allows
subsequent arguments to bypass remaining-space checks, write past the
end of bin_args into adjacent per-CPU memory, and trigger the
WARN_ON_ONCE(size > INT_MAX) check in vsnprintf().

Check whether err >= tmp_buf_end - tmp_buf after snprintf() in both the
%pB and %pI4/%pI6 branches, and return -ENOSPC when the formatted output
does not fit. Also cast sizeof_cur_ip and sizeof_cur_arg to ptrdiff_t in
the remaining-space comparisons so they perform signed comparisons and
never wrap negative differences into large unsigned sizes.

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260619205934.1312876-1-memxor@gmail.com
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 kernel/bpf/helpers.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2608..6ff07090468c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -963,6 +963,10 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 						       (tmp_buf_end - tmp_buf),
 						       "%pB",
 						       (void *)(long)raw_args[num_spec]);
+					if (err >= tmp_buf_end - tmp_buf) {
+						err = -ENOSPC;
+						goto out;
+					}
 					tmp_buf += (err + 1);
 				}
 
@@ -983,7 +987,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto nocopy_fmt;
 
 			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
-			if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
+			if (tmp_buf_end - tmp_buf < (ptrdiff_t)sizeof_cur_ip) {
 				err = -ENOSPC;
 				goto out;
 			}
@@ -1002,6 +1006,10 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			ip_spec[3] = fmt[i];
 			err = snprintf(tmp_buf, tmp_buf_end - tmp_buf,
 				       ip_spec, &cur_ip);
+			if (err >= tmp_buf_end - tmp_buf) {
+				err = -ENOSPC;
+				goto out;
+			}
 
 			tmp_buf += err + 1;
 			num_spec++;
@@ -1076,7 +1084,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 nocopy_fmt:
 		if (tmp_buf) {
 			tmp_buf = PTR_ALIGN(tmp_buf, sizeof(u32));
-			if (tmp_buf_end - tmp_buf < sizeof_cur_arg) {
+			if (tmp_buf_end - tmp_buf < (ptrdiff_t)sizeof_cur_arg) {
 				err = -ENOSPC;
 				goto out;
 			}
-- 
2.43.0


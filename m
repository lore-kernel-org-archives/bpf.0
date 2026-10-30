Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321367;
	b=4L2XYtmThCKYHJlCgscopNMZfLMEQIsDB064tmy9b4jDQ/sSkVptOwrVrmDXtbZ9XWYy
	 WmTHzmeThDDGmptuGmcL2A4CUxAsO6aH+GQzmNxNd6x/rk39hsUmspAaV1itrAvTXQiNc
	 w1Z1XRwSiGhgYm3tYUYwluWyBPFF/nEP3BTcaWLlYKmU8GTSRrxmRbqMckVpy9WOcUbDs
	 oyip4h0oNnYRh3doDEF5o6p/r1w84U4bvqgf6C4muv5l0e44NXGM6eNTRiGCZTnrNs2if
	 MriNhcWNk9KGJlY6Nb8GcyFi3lDk9B3Onk7G2QhKLKoZoF/SJdIFDIyt4EnG0ei54HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/+IAYNiOHDc9rDN2B0ARHcOpQbw29uklATQ0H6bcNjE=;
	b=sPshT1iHaehrnFjuex4dgwyF1PBMqfk03yfR0R+8HcfZIMw4dpWfYcIIlCNB+FkH6CPf
	 WogcJX36zU1skZgYa3OxWmJKYqEA58o51xgJ8giIizPeIuJvDHGdrc00baITSUCP2gIO1
	 6OWvb4xrizYSsXuv3eg4yZ5J5gsXdBRcNfCv9i1DMGEwiehRRpcOzIfYn5UIIiuUMSKuD
	 dGHx3Sqxfl0ACbfHeD/6onp1rrsBTyM80xKUxWnSN/6zY4Q5F8jQHGH6jaH9iouBE2kd7
	 riJDkcMrPqKM+FwQ1ZpZUTCSWqJqtMYsUKgsnsUkrnl0iT7xxQgnChSNLqDpenUlTlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6xlEond;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95950606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 00:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95950606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6xlEond
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ac8a2ac52bso2491607b3.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793321366; x=1793926166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+IAYNiOHDc9rDN2B0ARHcOpQbw29uklATQ0H6bcNjE=;
        b=D6xlEondfZYCzwVDWgpDWlae7Rc7A9q9oihcPJLDMwntPHWoXjfDX9FPdS2aDGxoNE
         pTjyqaOm5SuN2d1mDjM+oUtqE2ZToyAEHgGLWnTqExrPefVqGaQT+uDmHOsI/avy2PVo
         XJED0pMCzdKj9QkOT2W0PYAAoklPCFfcx+PrnVU9Q1GoFn8gvpfdR/8wdV5y5ckgkN3P
         mkmLUAxcYHnW/jC+VsHln3M2T1na2H804tHtDBy9utcyJPaZ3m2YLlrFUSqU36qZOOo3
         Ib9ix9Q89KvPA1hdA39sGdxD2z66OPXSrQxzcWCdJ1otutdR/166ZHt+G/7kTWDDe7d6
         Q6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321366; x=1793926166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+IAYNiOHDc9rDN2B0ARHcOpQbw29uklATQ0H6bcNjE=;
        b=ivpHnaU+OtvTSib6ZHK1qQ3O7BcwJMNXnQxYWO6aM3S3t6RePGih8O/gDbCsGEkfbD
         w7216OzFgR5iFWetuxLeI97OKpKyOkvzRyCzEEprvxIzD38ts0etT6jNYKaIuTcDH5FL
         d3+FIWXNTZ5XaM3NUuy/jjMV8Pn1eUA11qvOTBpIqmRCc7xFOif8OCWF3whE0oraCxFi
         MS1gIitJSf3Xzglo6WRCJRWheQDTq6m6oP2oLpKy1RmGLpArlUbmxh+FBIHZDNc9XSoZ
         LMpFQYMTBrtGvzwnDYbF72hmKhOGkt58GrvCcwobL0qAoRKNwfWGbI2AgO//XFsWcbFU
         di9g==
X-Gm-Message-State: AFq9FYJ7AGrqilnBNsNKnNDChxw0/6nKOeUVYKy86+qlwPhRLeXqoXjh
	5bgrgy+DBNzFAhmU5x0zPDI6tFP12cxtLiPIo15HwXSs0IJolWfjUrIL
X-Gm-Gg: AYBFou1WzteKJm46uZ6q0Li1dM0h/zI3/zpmgwFni2Fc5crit8i/aolb43X6gsimA85
	GKZ4yfHucWeC+Ep2kFTznq5lPiMDD640W1wVu1V/Sz3efQ3Rn2hLznxvqkn85HBpAHJof3TC5ae
	+lA0oXqyOCpEWkh2xIF61+l0YzLKlFT1MR7sgShcNuEneQ+Xi5dTsbbJlnEpgHvsdR8qIXdibKg
	pn8UHAeBGZEn2O1D8mD4oqXwHLNn1fY/0l+arW7LAvuhz1AOnzHpB0WmrORtBYIiwq4cL8UsrEu
	EouNiw+ObdmysvtHiIEZNl9BKaHhOxx1ylJlVXmmC/z6MXcWf74+U3eRThtwY5Yg7sN/gpLR0wV
	qMDj+7NdYDB3wF5W9WCPmx5PMATQuX7vWBaDnUjOXGkwp35n3Gi/HD5KLP/XseK4/ynSgJ/BM4G
	xzc5gQmxsjL8XsTM2CJNPJi5jk2t3PsxnIXKjrcbzkr1ZcaIu9xieHumkhthMj0aYK5XHYx0l/h
	RgfFMV1Yj0CeI9sd8kA6LaB5yEfd3C1NgdzE+Lc5jrCESEL4xt3uUjPcykUnCm2b1pf1ybwpOl7
	uh7pTJEPJx4IsYhO1S3G
X-Received: by 2002:a05:690c:c90:b0:81e:d001:e0ca with SMTP id 00721157ae682-8b2b6723231mr4562067b3.17.1793321365407;
        Thu, 29 Oct 2026 17:49:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714cfc1sm1922017b3.20.2026.10.29.17.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:49:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 29 Oct 2026 17:49:12 -0700
Subject: [PATCH bpf-next 3/3] selftests/bpf: Exit the pyperf frame loop
 once frame_ptr is NULL
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
Message-Id: <20261029-bpf-selftests-branch-order-v1-3-425cc1ef8581@meta.com>
References: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
In-Reply-To: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 vineet.gupta@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793321356; l=4472;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=cREUJ9dAwNFK86+Fj7tZS/WebfQSK5tJ06c9gE8RyEU=;
 b=hyyYnUjhoUnfrg2c4qhW0f9Gfw4Kklgh7cgdiX7d6RR0xSB56C0cxm30EaWPS903FTmkRjD3x
 /ufNv/kTkmZChMhRzRRfYg6y4GAXIhWgdVVwyW+foDrr/X3LdCqhPKE
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Once the stack walk reaches a NULL frame pointer, the remaining loop
iterations do nothing, but the path keeps coming back to the loop head
with a precise NULL frame_ptr that can't cover the paths still walking
the stack. If the verifier reaches the loop head with that state first,
as it does with an LLVM change that lets the BPF backend reorder
conditional branches, pyperf600_nounroll hits the 1M instruction
limit. Break out of the loop instead:

before:
for (...) {
    if (frame_ptr) {
       ...
       frame_ptr = next;
    }
}

after:
for (...) {
    if (!frame_ptr)
       break;

    ...
    frame_ptr = next;
}

Verified insns/states, before -> after (fail: 1M insn limit):

  current LLVM:
    pyperf600_nounroll   v3  466200/21935 -> 423469/10769
    pyperf600_nounroll   v4  460049/21941 -> 423390/10768
    pyperf600            v3  258015/16635 -> 235130/9485
    pyperf600            v4  255429/16630 -> 241749/9484
    pyperf180            v3    74395/5510 -> 61405/3705
    pyperf180            v4    83077/6310 -> 63528/4601
    pyperf100            v3    43400/3216 -> 35535/2408
    pyperf100            v4    42437/3216 -> 35901/2600
    pyperf50             v3    19218/1384 -> 18535/1258
    pyperf50             v4    19180/1411 -> 18570/1347
    pyperf_subprogs      v3    19288/1358 -> 19548/1351
    pyperf_subprogs      v4    18472/1341 -> 18648/1355
    pyperf_global        v3      3926/276 -> 3963/275
    pyperf_global        v4      3802/276 -> 3778/276
    pyperf600_iter       v3      2343/170 -> 2352/177
    pyperf600_iter       v4      2249/171 -> 2278/177
  patched LLVM [1]:
    pyperf600_nounroll   v3          fail -> 339856/15914
    pyperf600_nounroll   v4          fail -> 339634/15892
    pyperf600            v3  258015/16635 -> 235130/9485
    pyperf600            v4  400649/24467 -> 241679/9460
    pyperf180            v3    74395/5510 -> 61405/3705
    pyperf180            v4    77259/6130 -> 68618/5484
    pyperf100            v3    43400/3216 -> 35535/2408
    pyperf100            v4    44529/3580 -> 38618/3084
    pyperf50             v3    22475/1849 -> 20436/1584
    pyperf50             v4    21957/1849 -> 19868/1584
    pyperf_subprogs      v3    21628/1922 -> 20529/1578
    pyperf_subprogs      v4    21048/1920 -> 19952/1578
    pyperf_global        v3      4303/388 -> 4150/320
    pyperf_global        v4      4231/388 -> 4027/320
    pyperf600_iter       v3      2229/167 -> 2534/180
    pyperf600_iter       v4      2143/163 -> 2451/181

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/pyperf.h | 32 +++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index fd93a96e5901..5f093bcf6b58 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -320,21 +320,25 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 #else /* !USE_ITER */
 		for (int i = 0; i < STACK_MAX_LEN; ++i) {
 #endif
-			if (frame_ptr && get_frame_data(frame_ptr, pidData, &frame, &sym)) {
-				int32_t new_symbol_id = *symbol_counter * 64 + cur_cpu;
-				int32_t *symbol_id = bpf_map_lookup_elem(&symbolmap, &sym);
-				if (!symbol_id) {
-					bpf_map_update_elem(&symbolmap, &sym, &zero, 0);
-					symbol_id = bpf_map_lookup_elem(&symbolmap, &sym);
-					if (!symbol_id)
-						return 0;
-				}
-				if (*symbol_id == new_symbol_id)
-					(*symbol_counter)++;
-				event->stack[i] = *symbol_id;
-				event->stack_len = i + 1;
-				frame_ptr = frame.f_back;
+			int32_t new_symbol_id, *symbol_id;
+
+			/* stop at the end of the stack or at an unreadable frame */
+			if (!frame_ptr || !get_frame_data(frame_ptr, pidData, &frame, &sym))
+				break;
+
+			new_symbol_id = *symbol_counter * 64 + cur_cpu;
+			symbol_id = bpf_map_lookup_elem(&symbolmap, &sym);
+			if (!symbol_id) {
+				bpf_map_update_elem(&symbolmap, &sym, &zero, 0);
+				symbol_id = bpf_map_lookup_elem(&symbolmap, &sym);
+				if (!symbol_id)
+					return 0;
 			}
+			if (*symbol_id == new_symbol_id)
+				(*symbol_counter)++;
+			event->stack[i] = *symbol_id;
+			event->stack_len = i + 1;
+			frame_ptr = frame.f_back;
 		}
 #endif /* USE_BPF_LOOP */
 		event->stack_complete = frame_ptr == NULL;

-- 
2.53.0-Meta


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089619;
	b=UDZiASBiQrKgaexKz407S2AL7CzMZ2lR1azBWUS03k6NcwNkQgP7XAabWJACtakvSO1W
	 CUTgrO/IkraxSS+V2Os95dHd4AMXws5fI7Q2/QkE+5QlCn4c5KmTMkuVdlfub50ROzA94
	 aCTmvGlsep2x+t3nAF+XJQEobDds5RNL/tUnz/nO1ZX1+0L/r5P9ysUJ3x99oJ2cqXma/
	 3da5jZ2GVzf0cYxgfaWkzogXiK54hQP/cdZGgJ9cINxng1lBjGwA52FrtfYN5kUcmsB3q
	 8TlbKrdKFNgFg3GIjps0CT7Ssel3wVrq3c3Qzz74L+2VxAFq/RcWdtPuLWUyz0TK+CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9gIVlXgPEmkZGmA453gdpvq+MACAnZz6AjvCWRUAbDQ=;
	b=Xje/dfZL0lx4Y3/ilLUm1oIasNV4Mzrvp3IzqwUBmDMDIWRMG5MT29D+Xoe1Dia41/Hz
	 MJQbGqUqBv+UyuKFMTrwTd//xLqS4ri+raORF8ZFpVtNLuF+dHe/OdSnVXY6JpxugQwJl
	 FGF2Vk42f1FeLvsDq+FQFW2kpnVDncw0fJok+mO7BekuwdUHhrZ25xYY83JnDB24HUkhK
	 Ha5qK1J6pX66l5NiKJ2WFMkUxF1bS3c0KNWlhT9ZEOQOpFj4cdKOZwvJFIzBNcIE01VCV
	 PFmLBJ5M3HXgxxaUtD60BFjLGegzXT4AGtBHPkfjCWWEP62LPw9GP72nEXqCVNLlQGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MTPwBz/J";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369B606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 12:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6369B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTPwBz/J
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1301566b3a.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 04:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795089618; x=1795694418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gIVlXgPEmkZGmA453gdpvq+MACAnZz6AjvCWRUAbDQ=;
        b=MTPwBz/JY27HN3sgRWUZI0tlkBcWXxf7M7RAXN68cgdg1Am8p7kKnqmSmbk9i3paIX
         nxuGPCiyFzKnbLXHTcpkZL9Jl05xOmooAxQ4ClctRHIr5+ntBgvY4iRhOPPxeMYmnypY
         1SPlY1JPWNh72h0Le+gSG7pxiVUY6/xphqQkwjAhgBiRQ9xfq4MSEwQT4mtoTarBFDIM
         pA2OfASffwaYexAEuos0xfq9yHeB+zfhsnIZivL5ud55stPCuYqdAMDCI4dK5GuB2BAI
         rsecijok4RzXP6n9QVIouU2C2dsMFACTuLaYblKxFjsHNOIT7edbPt+7lOVID009Ys9C
         aFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089618; x=1795694418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gIVlXgPEmkZGmA453gdpvq+MACAnZz6AjvCWRUAbDQ=;
        b=Q+SfmsU3rbY1zY42WwyZxX0UfM3DoL/yIOeQSJ0oNuiXyT3LaD/gdXOR7S1fN02doP
         Q6+we8loKfcGqnebzGUaZMv+Y52dobMaU6tHBMOfKzuHmbSxxPHIeusJ9EX5eWSQ1FP8
         v4wKX0c8I+CAF3wwx9APpaS3BJOMUELjEZGVU5itlZlEihDOc0zazyEapzQ3iZQgE1pi
         W8Ou6GEONvkfTqLndrpviq2SPc5LY9JCUFQV4q+xQ/xbdy+1ly3FOD6KkAspMKD52HB4
         SFDWqHR2bhHbnKXIjj/jsXsN4/ta5t7j7lVWbq5GyjpujrE/ZfJKuoZcF6sOVZRF2qZq
         Hg0A==
X-Forwarded-Encrypted: i=1; AL+hErHCiftVvtOUm+L/F4rKcL04Ml1tuP2YFODZ0eul6uznFG5T6coUjjcN4oA5f/n+wH60DFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hp3CgG5I9+FDxksOJuXATPXCWnlCoxix0vCzZrCGePs0G19tS
	8+xlwBQJSGvrfHLmr9GHozXm0XGVFeUXY6o9aQhOEQeK9T2SNk99SS+csvz6LA==
X-Gm-Gg: AYBFou3ZCSF8xzGVXVgWh2JPpJc6hADQCaD1988DX/mJHMUa8bAeyobzTnLCGiBBpJZ
	eF9O1sqONzWkS+YrYawJiwlq+IpEBPD9LTcVDvwEOGaAmZ0EgqsFsV9iup9xEok+1VivEiKbb8p
	C7thbdR4qDK3TEEgM/89XyLW+UmokpNhkP4I0wrNK62mpvnT0+lpx629KMIt6Udag+syQBIjnXf
	vRzYhN4cm1slCGzZjdIqgoZ1unuHbNCzbs4HspyJ9tT1imh0p1VQoLrdO+enAI9JjT5HHbwyG4Y
	913dLXV6UalN0gpkT0X0GwWANzQoVIu+9kpb4ANMkouRRy5mvMBv6rvlLGIKsZ3Psshi0Hxk/8b
	eMKSafC67gF74MDVkWg+kSspHCJTSvsnnUKWgRGGFlOiFDtpwbUH5d0iQ/jkAXp3kxsoBOS7WXV
	Vn5wkEb+uy65TUnBxAFSkNaKwIrHwhZELr6Rw1MUhH+GmJuTjBUHIUNRuv0zLUadmFxKo3KIctP
	ltWJ0F9X5jCEJm4OvbwmPT4VDub0XkCH7B0hLAjl0IleymvhIp04xaabXkIxvFatfxK7bxPbUqk
	qbsLBAxzsrBGHm/VD20wWBaoI1OSzj1R5UQJn7oqiofqTk15+OWyu1A9lPxwS9No
X-Received: by 2002:a05:6a00:2d86:b0:878:3538:8f7a with SMTP id d2e1a72fcca58-8c5d51a37ccmr4621024b3a.40.1795089617602;
        Thu, 19 Nov 2026 04:00:17 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb93d04bsm2665088b3a.49.2026.11.19.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:00:17 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: asml.silence@gmail.com,
	axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/bpf-ops: validate loop_step before registration
Date: Thu, 19 Nov 2026 11:59:29 +0000
Message-ID: <20261119115942.3613868-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

A struct_ops map with only ring_fd set leaves loop_step NULL. The
struct_ops update path skips a zero program fd, and bpf_ring_ops does
not validate the completed value. Without BPF_F_LINK, the update then
calls bpf_io_reg(), where io_install_bpf() triggers a kernel warning
before returning -EINVAL. With BPF_F_LINK, the warning occurs when the
link is created.

Validate loop_step before either registration path. Reject an incomplete
value with -EINVAL so malformed userspace input cannot trigger the
warning.

Fixes: 98f37634b12b ("io_uring/bpf-ops: implement bpf ops registration")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 io_uring/bpf-ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index 6c2a587fb1bf..dfa93144b090 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -157,6 +157,13 @@ static int bpf_io_check_member(const struct btf_type *t,
 	return 0;
 }
 
+static int bpf_io_validate(void *kdata)
+{
+	const struct io_uring_bpf_ops *ops = kdata;
+
+	return ops->loop_step ? 0 : -EINVAL;
+}
+
 static int bpf_io_init_member(const struct btf_type *t,
 			       const struct btf_member *member,
 			       void *kdata, const void *udata)
@@ -269,6 +276,7 @@ static struct bpf_struct_ops bpf_ring_ops = {
 	.check_member = bpf_io_check_member,
 	.init_member = bpf_io_init_member,
 	.init = bpf_io_init,
+	.validate = bpf_io_validate,
 	.cfi_stubs = &io_bpf_ops_stubs,
 	.name = "io_uring_bpf_ops",
 	.owner = THIS_MODULE,
-- 
2.43.0


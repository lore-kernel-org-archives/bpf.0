Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067738;
	b=vYbopP/NYp3X11HFmT8/xtYQw0QW/m4Q4iOya1Y97qKB7/dK25G04EtK1mgPbaJwCRS7
	 XC5eG9OTKpZuolL2jtP+bXy1K8odlHtGfj5BU3gWefPviRsfMpIFDBtkC7G013WU+M7ss
	 bgVwwq4NdZh3C3ElYZz8ybnANJ0WmMW1ox/2IIp9/bOyLOXzu9djYXw0XNNpF9kOVEl3c
	 Ill0qJKZmSXl0LfNJhfD7vq3gNYd5PtUhoOAaO9y7sAvXKkvYLgNvT/dlHfYqStbFEhxG
	 OClBwS0pPIY+w3JY8LlTGTA1fRoOYQLrBRNkk0gFaROz6dnXyGiErMl3h00FkdPXjYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
	b=5a5wdGHEBdYQAff74SFXta0MOywBxvd1E3g7t1fgrzY/48Z+RrkT/ocskog2VCZSgfQh
	 XSIczqKWFHWbT3oggRhCjlB6qGIp0kzvsTmBhxgAgmI15ZbzOhvQIETFXxIjlTxwtCvOZ
	 NJYeDDRFZ5BzHBeidESbsUoCDNfLpsRiRmamgo6LSWJ6YTkTwhqHy7rZsX15cFANmpWZ9
	 UdQD70EXGjP7vJccFHAj4BF/Ox5Me/S4Hj155AI9PM19VSwqmU5NJ6wRFaw4GbUuJ6bYp
	 xr8KUUGJHgg+gH4FpXaRgZEn9XGXsXxgylMY5z2tZzCp3OhwHN4+qk9CxNyMtSzI/aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbuOgokn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CF606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920CF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbuOgokn
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55c4e670fc6so17351941cf.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067737; cv=none;
        d=google.com; s=arc-20260327;
        b=maUGBK8USSJTJ3sRmjUzLf9yPFQw1zmd8zZL5Dx1CaJ29L2ryWThpBs89RO+eJL9uW
         bUsSDeQd6gNKkiXIipENzB9lDkhpfrsXM+qJZkL9qwkWYEVC4UCqROSUnUmPK0+sfqQ6
         f705Xn/c4Ke8aFH/ON8YqmULKts6ukr/jA+j44w8sOMAmNnrPqDXMmflaiRfOZsW2/EU
         hqGPxzAYGYDORS+cD3VspdmsTn4Pjz+K2j+nI81sL9KILpSeWzIp9pL/X7nOy17q5PBm
         zmM+cotWr77oQyrBhKUcnCNVJsRjAphE2tIXELIx7pNVjka8gqJQEqIUYO5PFAmLUlSo
         wOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=ZlzmQlAv/fciOSF9Nku9oVYpVbuVznsRIhqZgJTXM+6f+qy32bo8ZD4Sb2O733hd9Q
         82PYFEUXnSVtclQKQjFFiy7tAw6sOcIAcQezE/yN6z3a6kDwdx/9PmTGqT9dLYBMMMAv
         LETCUjAH1TEf3EqrECjscaaOICFivim6LBj4N7X4kmF9x3EzVlJEK/pEjVbS7/wP2xvi
         YnYmJQF+XJVoXtNpHRK0nS23bixVjpFtv32JsNqitQWwLlFh7qAsknrTNDAgzJuYsszX
         ZuOgb+ZQQcR6Wvo661RUZrGWexTY5hlUQbIvhlzDP0rTJ8dENWmyyYV/ESj00JflzRIy
         4cSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067737; x=1795672537; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
        b=YbuOgoknImPI74dkeDko9dpj5c4Cb5rCJh+DtFAF1+VA5OoZsNx6xZ7ahto3GzLFj3
         Nfgd+11PhrZRn3OBt1TZZ3QunJv8ZhlbyZt6uqgH8AswyRUREOyfCUyM3j8vXKuXWGCf
         56dR3A91S0TTcCwV8dl4vTvXxLoloTAfyu9WzQOgiY1HFqE1BDdpRiRqHzJEOpY5yFP2
         YPDmXK2360I0/kUVaA6oy6fyTy/Y0eBGty845OASH/pKckqUPkO0KxaYsZV9IN5Dd2xV
         rA8CmzOYY4LEINVPttDRQ4OHja7FMva1I0+IkIOgMThd6nrb7EvnYvEgXhQF8lF+kumc
         c2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067737; x=1795672537;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
        b=yr0qVw59PFrykGXKmDE0jP2wMo4BhFxP5bqfKqbbETt5V+qqn9GhqPfYlw4H8WSORP
         Btix2PI6tbH3Qx6FaljKD8MJHdvTMbT/4u8mBNIlJ/X7YnaITF3tkvMY1UnX0vih8AL5
         3dozvhNoteidMjOrZW29kawCwHUDkrfc0vuzS6TJuH8k+w8rsdGSpofUR1J8j2Hri/45
         ehwrYlt9RKtJkkS3qi3T63Pb/HqVT4FHNthEhKn/76oDbHR9keDO9SLCN9vIuSNSsSkN
         RCqnkde43+b7B183ZygjkKWmeAwH0QLEQZWiTymTNPZlNOlNwH179RCpVq2Rr6CVl7v1
         N+0Q==
X-Gm-Message-State: APuU4Z+4LDO7o+v8sCTMVNgxk+9RkLR52LX26mbiKbyu452J2t9yk+2+
	VttVV0PW/6Mckt8MG/3G1afTwr7qs8BMfOQKRrtUp+0a3934qPvy+Qh79tGon5BM/bKDbQmOGN5
	Dh7jF5saHokN3KAAC2SSqqgWTUQMCP8k=
X-Gm-Gg: AYBFou1dLc3b0fjTvjulmO80uVUMTbSsjH2RiKbABrre7ZoHcM8et6ZBfSPeemAgvnD
	spfjJ6gEbUlv6tvdRfwOiGrF+0plJDDJ5YX8q6AFBSuEsSFH0TA1pVXz5BaAePgncMezlrSpZ+T
	jutYi7BJi68vGE1xI3uW4BFNDkOvaIfVuBVxTciTwP3XJEYL7VqRW/5IcCtAjMgl4TVEnLEZaPq
	YY74SvqbsKWYwJN4TN6GgxRG6nz/t2VFqfOnyPvpkABzgwDKYsA9Cdc/pXKun4Z+I87Swnk7Q7+
	R0Atx7ulbeoWjpYQCNZ4kEnlMKyraQbNGKFQ5qoFpBPCVMpwoEeAi8LQQCeKho6H2m7dEf1he0r
	wbnYEYUGe4jSu6D4NfexjEqMs0crNf4ZYY+RDmJXp/D4jW1OuFo71OSbXlYAbWd7gf4OQoczXyy
	7UUPm6QgSZsxKGn31KSw==
X-Received: by 2002:a05:622a:1a90:b0:536:352d:65f6 with SMTP id
 d75a77b69052e-55d5a62eb65mr76732251cf.64.1795067737385; Wed, 18 Nov 2026
 21:55:37 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 00:55:26 -0500
X-Gm-Features: Aa3M54pnSDUBBRf3lpLwcke7tzjfHBwFC7TFUZGPR-wTAHAk3o_xI9NvaAJLh0g
Message-ID: <CAMcAce8eFDXx_BqjMPd-94uX5Hk4KNxkjPtRXW7wOvy_hWjAHA@mail.gmail.com>
Subject: [PATCH 6.12.y] Backport request: 49b18315be4e ("bpf: Add NULL check
 for dynptr in bpf_verify_pkcs7_signature")
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  49b18315be4e590fae0fc39c87d46c87e9ec903c ("bpf: Add NULL check for
dynptr in bpf_verify_pkcs7_signature")

to linux-6.12.y.

In v6.12.118, bpf_verify_pkcs7_signature() dereferences data_ptr->data
without checking whether the dynptr is empty/null, which allows an attached
eBPF program to trigger a NULL pointer dereference in kernel space.

Upstream commit 49b18315be4e applies to kernel/bpf/helpers.c, whereas in
v6.12.118 this function resides in kernel/trace/bpf_trace.c:1403. The patch
logic is identical.

Verified on x86_64 QEMU v6.12.118: passing an uninitialized/empty dynptr to
bpf_verify_pkcs7_signature() loads cleanly under lsm.s/file_open pre-patch;
with this check backported, the verifier/helper rejects it safely.

Fixes: e917c6999a09 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,12 @@ __bpf_kfunc int
bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,

  data_len = __bpf_dynptr_size(data_ptr);
  data = __bpf_dynptr_data(data_ptr, data_len);
+ if (!data)
+ return -EINVAL;
+
  sig_len = __bpf_dynptr_size(sig_ptr);
  sig = __bpf_dynptr_data(sig_ptr, sig_len);
+ if (!sig)
+ return -EINVAL;

  return verify_pkcs7_signature(data, data_len, sig, sig_len,

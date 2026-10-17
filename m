Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE833E355
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200902; cv=none; b=haUGb8++x7WNnq9NBpHVCMuqV4wZ3Dpqa3e8QLw+o9m7QkrWvkTc+SbEwW63e3ukQjsbgAmdZGwsS0Rc+/B6no8N+p3gCqLqp/qS9TERT3wJLeyaocP0crt/ElNoNOWIGOQl7rsUaT9g/TccrFMhYJcL2+3ssPLDBJjzRydGgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200902; c=relaxed/simple;
	bh=LFQg+21msyu9OTgpui2dYEq+h9B6ZDaCiuwPnIXbwgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf97heqzoCYVgBUS/ytAi+C0akQ2K/91ly50G9FRqgW5K+YuxJd/uRsT9/7BHG9Npyhiwo/4vrVODZYU6hcvRajZoYLDti/mY1FB1LBIU0eGpjKP1W/DpfrRsXscgnHQeJPVQTT4jaoUBwtkCA+LF+w/fPFBFmNNpK8cIg/02T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cntBJ2z1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cntBJ2z1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso272296a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200899; x=1792805699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZsHuPe0VyhOxoSmJoae0tgGC6fG6Lk0otvXcNJu4JU=;
        b=cntBJ2z1AOU8D3jFJiN7W6lbJHrkfXMjgM8ggo1eBqUFjUyrm5VFyEksnUbiphsxIJ
         yMtHPkBzzNw9NL4S5HZS4OE2cdf6Jp4L/KZokEQvmSbcPOiFqeJZFC4SzXUIhshhaDRC
         O5EK5SEq+cRqiFOO8RwelqHlCtfsgDBokP3PYySbtIh61J8AsJu/nrQHuH2aSsVA1t0X
         LSjd2sDZEAoXL7pVGZqKLcaQu/J2ABPCZmsyxMagbvctwBACXBSR2vXidGBwkjHgsy/5
         GSkjZdfDF+sczlAeKTxhhAsaTs9uhLO4irfnNPOLRdGdWn/wMxIGBdb08dYDtxC0v9et
         uSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200899; x=1792805699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZsHuPe0VyhOxoSmJoae0tgGC6fG6Lk0otvXcNJu4JU=;
        b=fUESNEFtPSM5GLLdKHN5TRaUE818QO3GNc33drjJf+54NvoRItIyjDUoQmHeyxthOG
         zYnTC0vMSKmXH1m5u/zx56fy30jsEUSYsuXW44AbNoDSVuTOJjFF5iiItYu93nm4kakn
         80c6ZyDvuzz1+1WpC5WOqVGblMO9ZzrIhzs9gE1bzSc4KfJqycH0fj2qIsAfh9iVzejj
         DNjrr7a0AaCsU5BngbKDyXOxQiUZnb5FlGBRRjQX9nvUYjVhTti3e0CSdNvLCOk9hxIL
         nsQt4Wl+o7gjR79ofE+N94jo3aLJsmKM+nmDoz1zS/cat6g7a7iSATYbVTpDqTGc9ZF7
         Vmeg==
X-Gm-Message-State: AFq9FYJBlNytDzG0IiedtO4RQgrSre6/qCUyk7OBOdY9sw6mIzueSk0C
	KtnFTTIdbuzNUO1EGa+vV1huqy8RIFEa3j67F37K0zUNcJiUQ4kZkW+CkTDNiuE5
X-Gm-Gg: AYBFou2MoTWidxi0YZ0J0avpE1rh+0I6bW6Vm/OJcZRL/7kwSEo2V3PBGIQoe/uHFus
	1Eh1GuCLRZh56saiLFh3ohT4JiOERGiqwuUqFeDD4UpqIkCpSGvlvZyReR9Dm2E9buTlzdhQug7
	e66S9HUIs7iuY3tXjgMGHM0lGpydFNN6rZJGfgknXu8MiXd+N9P4IfmkKAyokPETkigCv2twIVp
	wv7yPP7Ffq4cetfr3fW3fVWurKSf0BNhbx3CjM3WXsqj0AFiQeRa3hD3r9a6u5DehrwH7sAXxh1
	QquI0XenYXMT09COBOp/E4beglRr6J3FRrGQPd/UbfkKsKuqCqiYSjh5j6pMKDnsWaFdzjRlNcg
	FOWiSkmv3wPB3tB7NAchn8OJbaHS1dz09N8yMhtr/hGN7gaRKR4EzEkwAvp/HU8WIDH2Wu8KUMz
	Xy1OxpzASs7td+3yheIwoYvYSkelPFKJ37P4xr9SMiQtSUiVI5JuSIzQYH0/82bmHauOJk2q7ml
	ND3a6cFReDJLg2XDAGfm9oGKUEYk8LzV/ky0JfieQpQVffAJEQPi1vxa3EQSUPbfSxMxoHMaYfo
	JnzyKMg8/4CGWbjDssznXtgro2e5EQ7rayn3iI3hXqw=
X-Received: by 2002:a17:90b:268a:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3acef5f1cd8mr1266174a91.63.1792200898849;
        Fri, 16 Oct 2026 18:34:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94794dd9sm11189575a91.12.2026.10.16.18.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:34:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 37/38] bpf: Use memmove() to store bytes in an skb
Date: Sat, 17 Oct 2026 01:24:50 +0000
Message-ID: <20261017012451.364800-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Through bpf_dynptr_write() and bpf_dynptr_copy() the source of
bpf_skb_store_bytes() can be a slice of the same skb which overlaps the
destination. memcpy() then reads bytes which it has overwritten already. On
x86 with FSRM it repeats the first bytes of the source instead of copying
it. The other kinds of dynptr are written with memmove() for that reason.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 54e9084b9263..0e3261f8d322 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1731,7 +1731,8 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpull_rcsum(skb, ptr, len, offset);
 
-	memcpy(ptr, from, len);
+	/* through a dynptr the source may be an overlapping slice of the skb */
+	memmove(ptr, from, len);
 
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpush_rcsum(skb, ptr, len, offset);
-- 
2.55.0


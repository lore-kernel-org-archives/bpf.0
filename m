Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808633;
	b=uWkjf3OSzhM1CXVnsXz+Pvybmg4rNs/4UBnpU+eollcJ3kr+N/lmxmGHVYa/DCM4Rg0d
	 a2kUbzcUsm6Ue0tQtKo2+EK6lLUJ49VNZHGfQwBhCsEPHr/wxOlkTlqf5c7YkQVm51to3
	 QvWbda9ZpAmLr/rhIP2pfWCar9eAGIBmjnAsMYY+OQajOpD83xGMEQmOWRdYj0aJRPA4j
	 nYEBmH1gEqu3fxjehRLAxDT9h+0Gc2+dqnQGRxQRo60jDAksZ2rIvFD3TTq7Hw2Olxz6U
	 mVdVIOjhGC8/C2WRA/YCRSDB8E8FHfBJJLKlUArUFwwxa2APWzOXNGIfLcBSsRfuStw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vfhumMux/RjToeTHYH53kaJsM5xq3VzGHoyTg9n++LE=;
	b=Fh+3v9vk23jOPh1k1EGRfppxQzZ/N1V+/20bLrqUXRe4kFs0mcddixpyUUL9AAg9H0Uc
	 WbipaF+XFrrQlkHGit8bpR4T27T8Dp0mieEIxbmDovKct8ZUE9Bo/eJJs9eycsnDJ7f4m
	 FGoBwqUwB1W2q5V0gL1GSc24ek3yFuGMHKUsra+TZGxUQDLY78g73ahBZVZoShkB9rlCZ
	 PSUqzh1J/34Hdrb2a+0YjW2awN7VT75dCM1+WQ59eCWQ0B47M8klVNaKAA8Q5jn5FmJo2
	 urPZ+EfqbK4DUM2HJMrHx18I2EIVNz8/Lge7J+E9l2tYwYVF1FklepUQ4RSzsoA4kWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJ8xC8ML;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE779606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE779606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJ8xC8ML
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1665009a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808632; x=1795413432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfhumMux/RjToeTHYH53kaJsM5xq3VzGHoyTg9n++LE=;
        b=FJ8xC8MLQrkyTMhvdSB9tirmQh/eAx01DXvvA2nyNDWkWXxjCS+fyQSd6G0D8m+3Go
         SwGx69t62Xpn5aye7tFRGd9/G15dgwy+2ypJmeSrOugvCspmZ8WH9MMbWNsys88Q3dxG
         M0y8Xwnsfyz4HDQ+NeBZ+m+8yQccUuPPL4nn/L3+BxRf+AcEkTusFFevbqRXUqwkewjl
         qGohImHLyryq8yW0NSVgw0odnp6h3ARQTItuaG1JjOrg2yGuphHomAcPG5sCDsfX1lK1
         ZTA7G4a4Z5eSmp2ykyq2VPMJ3NexOVPz3NBN3iTgLyr6ZQz1M+kY1crV/IHlteKuKeCT
         vVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808632; x=1795413432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfhumMux/RjToeTHYH53kaJsM5xq3VzGHoyTg9n++LE=;
        b=hGYTbrzz+7PkcaF8GkCP9JxpSaZ09BrX1oFZEyoJ08aZX3sOCWx++8JIuT8wyX99Ii
         ze8h8LUn8vWgIvHADVmhuMDHvoPy7vrNwrsNCeKvlukm3ACSoiEy/rCsYuoE756mHYBr
         tQw/tfK56iuc200VemwI6Ir+dypHStMdSMwtND5gC5qjE9zSVkXk1ILGgXJ6+eJbe3ak
         Jy1wqz9BFnrw5+4y9562sRmLVttf5EujaRWxuijTVuWQ2dfYf0CNpaaER65H4FNjeVE/
         zYxxQR4TrotqP36PvhnVsfT6IG4VEE6xoStrE2LUerstOrQrZ0c47IxPFB0gH60cvh4A
         F1CQ==
X-Gm-Message-State: APuU4Z93ym4YBPW0yCTF6R34kfSsgb82XhAhtEN9wGuD28q3yq9hg+1W
	l0V+WX18jp4eWaa0L5VsFP1plAbSHDh88kFC+82S9p9ykjbiY+cwSg0hGJstsA==
X-Gm-Gg: AYBFou3RwEWnQvxSV+4/SKt7Q8ohyvC5XAd9Pau3EFa+3+rwVdbNWPZlyeXsqPcnISQ
	VHIMBCrRUGigH/xar9YD5Vnq5FJEbR3BrBvrNym0SVLI9TtmLf5fD6JDhlt6Nuu6rMwrY5/Z123
	NKllc2va9cDBaWNMIuGVGZHBVcDxPahmYnL2GDPGjf5Bf+rF01+dZEC+VYIhH9VEBviT4pYa2qG
	bZQgBFUspvZb1K4nqwcaKNTdq6ndbrtESlLyXDEQ5aNdAOpyseiYZKyfpaQ7a5W67tr8arTnFn5
	sNBPxiMCN/pCokTa0HfIwhauMUW0Swc0JpcAgW4JW8ZCyI7SkDMONkVzbh8Lu7aPPP+kIHFurnm
	OJWofcsKizDzK4rV9lHHZJzOOwNaBybnbXHzoPQIQVTixd0spQkDkAyx7ldWR42uNSVYga52BsR
	9Q22NdOqeERkMIsD0cYLHJHAvVClZPoRy95lWmOQ5FcLSfo9/rWh9IVX3YBkaoWLhhBhsqx/LQ5
	KvgewqpZnzzyUhd5SQeO9x20SHDhcAsIjW7OKAqjDP3oliscLThGb4odsC5JDyAsjIooJUwNB3K
	WJ9sfzQmEhZBhXBp9k5mGyN96FbHas+wPZK0uoiE08PvynwjJQ9Jp6d1uJuo786RQibuinU07Eg
	EDDmvMO6xI1oee1EnifVoM9YPY2F6pra2h1rkaH/y/MIZnbQMSDJP0MOki/Sm4IPxKauKCVrfLw
	==
X-Received: by 2002:a17:90b:2642:b0:3ab:2737:3396 with SMTP id 98e67ed59e1d1-3b1b0b9cb54mr8536129a91.65.1794808631924;
        Sun, 15 Nov 2026 21:57:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm15508475a91.1.2026.11.15.21.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 05/21] bpf: Dump programs that have more than 524288 insns
Date: Mon, 16 Nov 2026 05:56:22 +0000
Message-ID: <20261116055638.4171529-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

kmemdup() stops at 4 MB. A program that loads cannot be dumped.

Fixes: c04c0d2b968a ("bpf: increase complexity limit and maximum program size")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 86e5c9c38026..a9fef8bb9dcf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5076,8 +5076,7 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 	u8 code;
 	int i;
 
-	insns = kmemdup(prog->insnsi, bpf_prog_insn_size(prog),
-			GFP_USER);
+	insns = kvmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN);
 	if (!insns)
 		return insns;
 
@@ -5252,7 +5251,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			uinsns = u64_to_user_ptr(info.xlated_prog_insns);
 			ulen = min_t(u32, info.xlated_prog_len, ulen);
 			fault = copy_to_user(uinsns, insns_sanitized, ulen);
-			kfree(insns_sanitized);
+			kvfree(insns_sanitized);
 			if (fault)
 				return -EFAULT;
 		} else {
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486197;
	b=l+crtNT5fBMT2x75D9Nwsja845Lwx7jNDFIps/uguMVdJ+yKaz7h0HSEpAtWesO6snKZ
	 X0/z7iiphLMQD8Pm6bFfMtGV6wflO11rTqlNDLKku9uSf4EKRoapSCTGzX5DZYcp/cRkv
	 bSU4GHAqQOQBXgTSz+xD/YlFd4q4YWuQZoM0wxpg6miifXnRFWvlLsWa9JIEvamDPQpwH
	 za6T4KKSAqMsMtVn5PV2A48RFHKAMjwLHPkBs+GW25TLbjAknOtEtvxOwpYhBatFidMCB
	 Xp748iC5OPpEbcSAQX6xqWnV+fCdRlkQLMawWUj95AOxrLGoDJzU27yvP6aSr+zPAuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bkpWIEHziPjnT8rJEJwToENhjzu687upk8/9/pEsB7M=;
	b=YzDiLvimD9DhaieIN9SnXjscWHpUS3kEsU6lU9pF53SFJW/fvES9XAfPKkUoXXJ0mySA
	 ohG0LsdQr04VxjoKVq9x1msJH2msVYbZnQCbsA0MUH6LWgTVYVeoyMi7xI7nu/aJP/G4X
	 xRw/3tFBYOj8stXHk6CWROzxgG6n/NFxgEtgrC0wddBLuAyiuUffXpaZeVyESiypMzzTB
	 Um3ORUwmj1/QKK5/t8vo5gamIlu/Lu2W4s5ueYxlr5YN6zKivZVKyCc3nSI2JKsKcNHFM
	 ykFyNsdCr37JgQ8s3PfC3noPiptvsZATxxsr0UMEqQHWXdH7HUjUinEtis0vTGvGiPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9N1huY7;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06414606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06414606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9N1huY7
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso2165229c88.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793486196; x=1794090996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bkpWIEHziPjnT8rJEJwToENhjzu687upk8/9/pEsB7M=;
        b=Z9N1huY7qFESMQyI5LNoW0gz2mla2DzjhJYIRSqot1aSHjD6tHBCrXorjvGTlGYNaG
         i7kqfy3So8cJxayW/LGjK4NV1/5D6wimZBSddgyiKKQXdf4QCn9LDt8lIqrCkVbgB2lk
         Nqgct6jsUWotIAI9U5HBZTNtkUGykMehFtNcrI34/b3d0QQLCQknUj79fMNgiyJ2sbBd
         ZgU/jUlnQHHXwjoZjBq//Bqcjf41eTvCoWjPgj0670NXLgrYGsh2Fy1N9y9JW7O8nT+M
         01EBMJ34bjcejSuMNmEj6q8v4z+AuZZ4QALv/jFtW2q9teW+6TwUU7TWLQo9Q6WHkDBb
         mwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793486196; x=1794090996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkpWIEHziPjnT8rJEJwToENhjzu687upk8/9/pEsB7M=;
        b=1qxgnl9XoaEPbDTfhEUcpPCPtJvQjsrG19WoPHgplNd2sheM7v8wiNIcIU07a+N9uW
         vvajx+UvqPW7ZhU09H/dawDW3zOaKA45BZRFOcHS+5muL+KV6pHpkO4MDrhXPQVQX465
         i54nTYlDcQKDXvkVc1uAyizmW2M+hoWIPAquIndMKyEn4GTox7y05UWGdl3ZLHWBzcG9
         tmblbbmgSwaZggVY1jvb8moD95U7p8IDgKTaGfL5Gq7ttPiYdYs486KqhA2SVWZ5Bh9J
         bvvLpglZbP9pwFpEYoBfmU15KFyWRSnU/loCHyHiL+mThxVuK7yMg4n9BQVJ4eLEtS6a
         kIqg==
X-Forwarded-Encrypted: i=1; AKwUvBzSHN/OzsOTOi5EJl2u6SDXBtM4YAqdcOG0YPE5V29vuV/wBzRmkdo9wAr+BDGu53usgOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+qDvHg6uLbR/v8LsdoldZzJZTu5nOAJRDtmBJRn/Xj0iPcjYi
	shVxngUwzy1zWrFEknzpomJS19SONW78DBtJI7KSzjt0tgEykT3oeuZgZ93z1m/gOb0=
X-Gm-Gg: AYBFou0kgb85y31YglM/zJaaPtzDlsdmrLk6rqD9LcoiRMeJ1jT2+ZlZCtZho6AfxoU
	Q9quaVrIWRg6/gxAs22tadmPdUp33FRblRDe+9cOkciMFsgRstQkCO/TlZ26zeoVt//4neFLv9u
	ohjCyqFKmYWfKVnvrC2nR87NMXYk9vH65sINQkScrvWAGAIEwq9TQfn/tzrp2B6cbKT5ySFHM22
	p+1TrPsyM/FvT3j+9lYo/9Qh1xV5SEQoKv7HrDmNfLkRP9DricBB/KTZ52exBRa/T5kI2YR1bXF
	wlHuUCbSjioo12DL+Fb/wzgS++8r/6zZIfc0WH70hd//IKo+hTRiauvob97FlTt2/+QFAvNOENJ
	i1c13EPsyXJx0wXFCqe75qrKb8jbJoZNIk5RXWq94P5lo5mRZEoPIcOdYAh66CH6L/0Yu+fnCdL
	TRKDx5H/MkRzn2hq5qoiBlCIPjP5SzquxHhhiClbi2qHqIFDJNh1CqlgmABpEADK2G6OBeQREXB
	U81EKF0BEfoRa1p271b0raHEuUcpY0wqMPH/t1l1VX6X/LKI01yu/mmNiP5Xuqk/ukCjXVTx+i7
	vaTRV8haTl8p944dSHYyTr6R8XhOVEpL35rmPqjNADjzRzqRZXEfi9+g
X-Received: by 2002:a05:693c:65d1:b0:36a:3407:26ed with SMTP id 5a478bee46e88-36a4243cd68mr9092660eec.34.1793486196026;
        Sat, 31 Oct 2026 15:36:36 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm19959967eec.0.2026.10.31.15.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:36:35 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next] bpftool: Preserve unsigned enum64 values in data dumps
Date: Sat, 31 Oct 2026 22:36:16 +0000
Message-ID: <20261031223617.367-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When an enum64 data value does not match a named enumerator,
btf_dumper_enum64() always prints it as signed. Unsigned values with
bit 63 set therefore appear negative in BTF-formatted map dump and
lookup output, in both plain and JSON modes. For example,
0x8000000000000001 is printed as -9223372036854775807 instead of
9223372036854775809.

Choose the numeric writer according to the enum's signedness. Keep
signed values and named enumerators unchanged.

Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/bpf/bpftool/btf_dumper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 3267163119dc..88c0da29f246 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -204,7 +204,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (btf_kflag(t))
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 

base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.43.0


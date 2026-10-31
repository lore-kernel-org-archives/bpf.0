Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487165;
	b=iHCpwV7wzQvwYC32oUn2jRbG3DohWynG9wnBSvORvZ7X0ASy+RNQ5ewR8Wrgt1Y5ydNb
	 VaaBmJ0JnTmnQJuvGYlHMh6m+uJ8yEx18gFdojGBZ555S4dmT+vQGLFD+lzOn1Q45qRmf
	 1S7K8UrIWaiA5cXuh4TBGjkgiTfNWqQUR712sLVstPGs4Gs+Sbdm1V3GkZruJTKgIEg3f
	 52dW5eTwpCCWYqMtxebOJwTEaUVUSuJtKD9b2CwTGcCABR6/8YsIcd8+EYhUhICTYW3Dj
	 Quld00EA/2DnDGHiU5aAVuP9xyyDIs3i3KFgi4vYFEkdqsfKz//gqdTWdCea2hbgWzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=+OzKgdaaBnPfV5yc0/wuuWajJJT+0oOzbHEMb7GwaoU=;
	b=f2vRnTMpbUtAUtAWTkDXmh9AXYaZwGfdLhT5NAeXn7aIY6IoF7ychUgC3fW2/93YgwSO
	 oN56CnIyqvlbMbm4t8VlEUB2UupQKtcAZdhva/ptAFsl9mQbCyobe47Jw4WVrolL/ooSA
	 ppDxKYX+S0MQHI8sv2WorqHE13oy8jMnyWY0athG1mB3Igdtm2Q9ZbC+hdS9b1QVli4vb
	 8MoAEPLMwkZ/wIu8A4L/00dUEA/oDycrOamGaVUO5JkK37c3bBpO9CAlyktkx2BUo0LNm
	 0MaltgcaFZsPTbXtr7vDnLeuQQ9UgHJGMt9uUw+1uLbFUmiP4K/dohqmofiaAmz01EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOv05ia6;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72E60A263B
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C72E60A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOv05ia6
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070781f63so786757b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793487160; x=1794091960; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+OzKgdaaBnPfV5yc0/wuuWajJJT+0oOzbHEMb7GwaoU=;
        b=jOv05ia68UaXzOGFYYheGtAmkHq+O8IkgQ8xSRv8VAoKgs8TE8QgNj29TqiX0b4GZ+
         BaVmJ65lrUkOaeAydV1x1dhkjf80dyTDNlVzWchF0N9RrTY8ryiHY4JBBVQccaQGPo29
         0C333Ovl3iF338f31XSjephfl8scKoz3NsWY1jtXejWHHoOCDWB/cUL/TFM895WL3Nol
         4H9AMv/hS0HSvpHsx7UpGIsUujQfcyPDJS5emTIrKKm9RfezbjBYWfmB1lZ3jFl9T2hc
         7o5Yx2Mq74Nvt7JcUNFqLhTVlesKoqIU6TGaXqnUHlhGxtJUJXjTcoLBRy1i/RlKrSiz
         v0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793487160; x=1794091960;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OzKgdaaBnPfV5yc0/wuuWajJJT+0oOzbHEMb7GwaoU=;
        b=yKbYuDddZ2/7RHfcEEoM+l3FALlQAtxAH5QA4yDAuRc+sxZOuKptqcybaqV3m+euia
         Jgc09Ic+fYs9NwGkQWsZQ4Fx/OmSi3eWCLoGp4QYd1nuMcg3e6h6jpbsmV1q4+g6FTkS
         VBou+Zaj8TNmzHGZgioN8MMdPLZcm3haBYuHIksEUACUUJbYJKKrW64MSTErY4loxwB/
         Pl00xS1xCp4oXM31QItauHTo+Rl/hUveEqicsREX6z4TfN0ZN9hZUc7rIoYszhYGG84k
         MBI7LFft82AEJjzBMNRd+QINpbOVVG+VFn5ZtBfGQHss9X+xS4/9Y6/2C2UIzbK721Nf
         y6Ng==
X-Forwarded-Encrypted: i=1; AKwUvBy3sLzTs5wjbJA9mrwoPvn7+BplbbRCPIpcFpNA5NyOuMkTnIvei8hzEV/h8q8m7KmVhMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDLMuBwJBViYVBRYJhD+a04u8QdOCuHvmBydV7fIaSaV+CAvQe
	z5qQ9sz4hzTXDO05+C8q36o4t3XaBr2by5ifjcwrCLfIc5FOpX04zVJD
X-Gm-Gg: AYBFou1eUeH8eQp5ED+RKWEmplyJM5xF9oQNDpg1HpbIp2yaevTmO5YtKoS5n0jGPS6
	jM+gYP4FAaEv+iU1Hh+85M7r+akebCEjzwH9U1bwS9A3YRMNyHL2x0tMpCJc70pMx1eR7/F7F1U
	SQJodYmQUl7veAeCKTUeDDW8di68UZFnXllVFlYw65E0iDzew1Hx+On6qUDMB5QxGyMbYWF6m8x
	nILjGBmOsheB297bVYjI4O0XiJczQ6Rj/kGCRTxwn9PHpAb1KY48sV/GtRiZlU8688uM6hCM+/v
	eTX2tiYmH4NtF+ET/rHij/1cWQp66EFDek+tcXxCwx1UJNq29h8HL76WV4DNTb0SEQD7yuM+C8E
	mFQOij6hU7h7u352Ls4HQiMhF3yrK/r+Bha03CRfIGcFcTmyYW3WL+E7ddS9hx+FS6B1bunP95p
	CIvMM5LMRZlLJW19KShyYnmckbz+sF8I8iddvQCu17ZCJmXeyLLiwOeYJUpvvzwS3UQiobzicV+
	vYgGiNY3vthZtInrI99park9N9D8hdanuUhFvBeEnOvpZb7PR6THuSH75YfJTIo6eL/ZHCrJ0zr
	34vDS2qS0F87haW7jH7GlQzhYpfcJN6UoqKQQsNYjDssvuGM6Xl4mn7Mv4XjwD2enquJrN41BYT
	fr2dGE10uvXBf8p7u6eJNykQVyCk4lYqU9gAwjYYW5zdk2bHumnuXhmE=
X-Received: by 2002:a05:6a00:22c7:b0:878:3705:2515 with SMTP id d2e1a72fcca58-8a9bf71a1e1mr5277325b3a.53.1793487159530;
        Sat, 31 Oct 2026 15:52:39 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8ac269b8805sm162543b3a.44.2026.10.31.15.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 15:52:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 22:52:38 +0000
Message-Id: <DMJE4YGAEGPX.2PIN4TJJ0AV0N@gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Preserve unsigned enum64 values in
 data dumps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>, <qmo@kernel.org>,
 <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <yonghong.song@linux.dev>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261031223617.367-1-dennylin0707@gmail.com>
References: <20261031223617.367-1-dennylin0707@gmail.com>
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

On Sat, Oct 31, 2026 at 03:36 PM Hungyu Lin <dennylin0707@gmail.com> wrote:
> @@ -204,7 +204,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
> -	jsonw_int(d->jw, value);
> +	if (btf_kflag(t))
> +		jsonw_int(d->jw, value);
> +	else
> +		jsonw_uint(d->jw, value);

btf_dumper_enum() has the same problem.

Fix all in one patch:

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 3267163..09dd428 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -149,7 +149,8 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 			    const void *data)
 {
 	const struct btf_enum *enums = btf_enum(t);
-	__s64 value;
+	bool is_signed = btf_kflag(t);
+	__s64 value, val;
 	__u32 i;

 	switch (t->size) {
@@ -157,20 +158,21 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 		value = *(__s64 *)data;
 		break;
 	case 4:
-		value = *(__s32 *)data;
+		value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
 		break;
 	case 2:
-		value = *(__s16 *)data;
+		value = is_signed ? *(__s16 *)data : *(__u16 *)data;
 		break;
 	case 1:
-		value = *(__s8 *)data;
+		value = is_signed ? *(__s8 *)data : *(__u8 *)data;
 		break;
 	default:
 		return -EINVAL;
 	}

 	for (i = 0; i < btf_vlen(t); i++) {
-		if (value == enums[i].val) {
+		val = is_signed ? (__s64)enums[i].val : (__u32)enums[i].val;
+		if (value == val) {
 			jsonw_string(d->jw,
 				     btf__name_by_offset(d->btf,
 							 enums[i].name_off));
@@ -178,7 +180,10 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 		}
 	}

-	jsonw_int(d->jw, value);
+	if (is_signed)
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }

@@ -204,7 +209,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 		}
 	}

-	jsonw_int(d->jw, value);
+	if (btf_kflag(t))
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }


pw-bot: cr

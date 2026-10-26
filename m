Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983927;
	b=1cL5XyaNSy3vqNZVVio1cu4TETVqiJN6WSoR/ft3k0xjcpodQS8MbDBwGSpi+gVmQhsM
	 Y/ajnDQ5SFsliZahQOL0YRYtl5qBiRxD+73i06HT/ZuROf6+EZlC89ID6E6cVrMvgmbhw
	 +xvE0XdKIXPpl9DPsgO1LK/1s6U/adzJDO67W6pqV6pbjSFq1QdZk4s9nn5VspurvR5E0
	 iY5vzi6/2arPKtRXXlhReIqksmHZgp6V9yiBD1KL/GY3+WMW0nX1uBBiNtubmNlpk5Iua
	 rPewrp1R70Xrq5uAMQCf+jehQNbod83lSclMv0q3Icu8kSxwEGhqYK4IdyUTZlbInEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jG3upgMBWkK2QfhlpI5beUeY/wB9VCpfp8ItfJsfE/g=;
	b=AACRPyuZ2LwNLcJcOWB6FJACjrS+T463p27Xq4WeFo89PNp8dS2D4Diav26iN5gO+1US
	 Nd9GZsGYRPT2fXH/sLGH5Fbta1NoNxCFCsnCJSq7moDdV6SuBDyUHce+Y3K6Pn6Gaf87k
	 p/GARjv+Fu7ll98nqO1SEBulq73pjsYK+mDVy4dz7hXLb7U6Ccu8nZaIve1K6vF44QGTn
	 Ww9zogXbVwYK9HFp3LTYWyPQiCSUidKtjUdOx/SnAP//+t3v8eRpQBQBwAKpeHMtPUxLE
	 hUv3GATgjcpClTn2iS2Z6HZDuOUxptifrbwc/JiPDu9R0EWdye6Nr/WZ5keUshkPoGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7Ld2NLG;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7491606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7491606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7Ld2NLG
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2328222a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983926; x=1793588726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jG3upgMBWkK2QfhlpI5beUeY/wB9VCpfp8ItfJsfE/g=;
        b=P7Ld2NLGYcC60p6lrElkENOZ/BUm7Z7FZ34JqzTug0tuaC1w12NpE8GNT0vrF8kSIE
         ffioj3C1GtIinLwlLBz7kSORKO2OMLZ/JMCaDo6URAa+CdNSZkVyjVBedid2qkYFFPQ9
         UrzIIafH5FtUYoucBMyquZI2Ij+ONvF1w8zD78gX3f/MEFltxIvYETPfyzArc5Eu8VbQ
         wErNb61BhYdmdv/v29WEd80sdabYqUuFXBm49+3hC+X3HdxFRTgQE5YeB/i63QvPtprN
         AXhxhlZkF6q03OhNdNwvMWnVnOIxG5HMHNyEQd4dS0SqJegnExhjiE/eNYcmbyIdGaM7
         7z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983926; x=1793588726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jG3upgMBWkK2QfhlpI5beUeY/wB9VCpfp8ItfJsfE/g=;
        b=CC+ykHPQ+h126N7Vh80JLgRE+1E/GC0EORz3B0CHc8IIY3WS/kCZewlSt1kbx65fgL
         WaxL/+jVIo5TnyK8TiMqtKKaTvrsRSVeuWEDPaxAiwvAmMfDoCrwU84Tlu0Lxjz1u/nk
         cnDSjTaTROoDWDISUqzQ2JBGfyrCXZw3qEEhBzknBhxa2PJSNwr1qeFBMVK/jjrY6edV
         hy64YEKKnSIjWcgLqteWxoKtKc8EyitfgatHbFWYCmm/fiyO1IoKgjedKIRdAKe5eGUG
         8UVilLcNtVHhB5ymagrY9axC42GCB/lg16Ic0j6caAPVqgDBva6PaiyWH+DQ1cZWbr1R
         sPVQ==
X-Gm-Message-State: AFq9FYLKefhyHFku8turPp7785KIPV8rcuA/L2mEYGC6PvE7weaIuA+3
	WhSjts3W27xU0XRg2bsW3kPXz2tN/9hXYG/3BPOg+8yNh+wUYkwkIq1R5j6DTw==
X-Gm-Gg: AYBFou05WqKE33BNLVKXqf+oVO/eZ6y3ufAojjT/FCue4MXshDSOk7+MBad94pym7a0
	EQH/AUoT+yMqpwugzG4ocIMdbV4KmlZfKBB3lDI/4LvOWzNrKpS1DrmgaDqJPQieWqdb2Yu97xh
	kKHMNEUh7PD9gwjuAvZMcu2TsRwJqfNeLJzDILuVbxmyMHM2xStc8fn388cyVDHGkkpyS+goEkI
	3j10O0dTdImEN45GLn1ogXkFHjbDk7XW4GSDETrsFLrJM53O7Q8MMSPBZa5vxT3srJO1aoO43Te
	YFQJY/Z27I/2s+kzFS9TUR/f64D1CbdFvhlX365Xj+6zX/gEoJqu58yNxD+gf+Z6qzhlRszXzPB
	ttyBG4/2g7IyrZuaovw7E5kOrd31/VSOw3DygMqdaVT8hJWiunTmvBdlMjmntCg93HhWOzmCYCW
	+rJWI3ZlmYNAg/9C2FY0rjSXY4EJ+fr4t1YqHRndXRQpUTFy4Tw/fkG39wGEOLOChH/0MCj3JAE
	eRxufuL5rDwV4K6so8wEfPQqr7s6IrFj+TIV78lff6EOqDJScqEI0SwFYl+ucEuofMd/6tZTaM8
	X1bW8Kb7QXW32m8JzZjsGrGkHMLd4pq/IXxBdWE+M8bey6poETXl/+EvhGfHX/CRxQ3LaGpYomE
	fsEU4ndMGZZ9D7bcmMPWhM4Jk
X-Received: by 2002:a17:90b:2f4c:b0:39e:6d82:dca with SMTP id 98e67ed59e1d1-3adead489b3mr5707907a91.30.1792983926073;
        Sun, 25 Oct 2026 20:05:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebbb1a13sm6171713a91.2.2026.10.25.20.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 58/81] bpf: Bump BPF_MAX_SUBPROGS to 1024
Date: Mon, 26 Oct 2026 02:59:19 +0000
Message-ID: <20261026025943.404450-59-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A prog that uses Rust crates can have more than 256 functions that the
compiler does not inline. The verifier rejects a prog with 777 subprogs:

  too many subprograms

Bump the limit to 1024.

Two arrays in struct bpf_verifier_env grow: subprog_info[] and
subprog_topo_order[]. The verifier allocates the struct with kvzalloc(),
thus the size is not a problem. A load from a table of functions can give
BPF_MAX_SUBPROGS different pointers. This limit grows too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6139e889c86a..51abcaead6b9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -974,7 +974,7 @@ struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
 						  u32 size);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
-#define BPF_MAX_SUBPROGS 256
+#define BPF_MAX_SUBPROGS 1024
 
 /*
  * A pointer to a static subprog in the value of a frozen read-only array map:
-- 
2.55.0


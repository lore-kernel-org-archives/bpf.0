Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160680;
	b=D5SK8ruF119NlJBZnWu3k6gfxOTD923+G+4BQrfq2UY0KO/C/WwsvOMh6ssKDOkJ3Mag
	 vv+J/lUBSuZ4oZuycKNlY/BljzQTs8luVkFiY109ByB2HxBn6gmEc4/T7HctmdKETyM3b
	 h8ydVJotFcKSEJpvTfiuwbQLp0yEA3uS9dq9lwgRSe4Prh8otGoAEcdFzRTMXD5/a3uQC
	 DGvgwES9ANiktgIJTOBYSW8uSme+9uvy9CM9DQT4QoRPJlnFvj16zT2/W8vUQyUQgCdBI
	 1ineVuLz953rSYNrnYakmhHKUca3N6SdCCtaboaMjpO/Xh0eTcfa1vN7t6UaDWXJGWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Srofq3rnSvHiMD0A9fgCb1ak+VYvZd07YgM2Caqjoos=;
	b=XsHEteakVmo5pmdnaz0if7sKgNB2EtMaH49ftBeJn10bCz/TKje/Tg5zYa0AgyqZ3eCS
	 OCJDFHwh3wVs4ey7H8rdmAWTECra0AGCWxAVfgxi/7T1nlVUBYK2oPUxK9NP2oWi8Un95
	 szV2mPY/qkOZ6/o1UUcgeKspEP4NCCTS37NmwYZ3BTYt0xvaU0eapEfsx0A/mhjaXlegP
	 tcMcCHgNkyWEfft+b/1aJynQC9Hukcc07p3RGBofjdmQWcmDvnmBnAC9IDu25hhJXLJ+w
	 1CW6jrdAoEwvxsP14zMhJxWfrjUUNlN7gqcTpAx7CoaLAR87a93cWqnG9PI+lwIMDwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTRbFE1W;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364C606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1364C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTRbFE1W
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9e53d011eso4601185ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160679; x=1795765479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Srofq3rnSvHiMD0A9fgCb1ak+VYvZd07YgM2Caqjoos=;
        b=mTRbFE1WaXEMxr/dj2HTRHj21wrImCjoKRH60w2i9HswHaQKGiZ6ZN/Jfd+e/6iOJy
         JywbhXgQMV/e7eLZXm/ygJCL+PEm2upMYjFgAX5Se8LTxDTjjMd4U7/rN3ftB2HNYVry
         XD3Z2ve8seMNp0GT7h7qy816dlLsMZVCXbGL0ngRw7tlyEZGE8iDSgt6tajafFSSWqH0
         KLXX1FgObU8WWHJTmZpPFEgI89OLTB/JY8BwkDb0lRsugYhXIbzrgmfD1JealtP74I+S
         9P+V7z14kJ4Y60hSN4Qth1+BCeYGoXV2Jdz9FC7ZRhe2Fw937GXwe/vA/iO7aHPwjDEP
         sQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160679; x=1795765479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Srofq3rnSvHiMD0A9fgCb1ak+VYvZd07YgM2Caqjoos=;
        b=ys1ixjqSJ+5Z2vFmpXc0VDXtvzJTva61Fdd4vXOz+4hdBIA3cQ3pSlGcNmySb39pci
         tPW7VDAjFJuCNyoFB28Zu5dQzw4aBWX3oAL8923shRDtcv5X58/QnYLIITGcyYjPO9ZX
         ZOhBEl1SwRPjAP/HmGGg2htdG2SrfoPy2Ptha1+CXQZ5Uo9YS4werVTCixU+WvIwE7jF
         m5o3EiHcsID5qNqsPC3GGNH996ICU7UjfGlls6waJB3KY8XW3KTIeISExUsblO/y2v4Y
         bBAoedsBQwh6x8vfKIOCsBxZtS2RuPWyFG/hNgU4UksHh5co1Hz7OzAb9Ga8CRpneglH
         c+YA==
X-Gm-Message-State: APuU4Z9T2HCG5srTVFsvAuZc1xA4Uh2OJ51ejeOa4mq2VyPmVGoBS4OT
	+OqhBfJNY/+NXU0+V2EaJiwzlR0GRoVbnjEP+GJvbEPOHeAJuiuaw+ptjx+Row==
X-Gm-Gg: AZFdTZdLL+NULQiCPAlbDulDyRJpusp5EHBcl09P1GYgvHaw9AYFY9FsLECOG8Tx2TT
	i2McNf8G5QVHFk9Ho7gIrhL/aPufx8PRckjmhvQUCLPwG3ZQnlq+dU8dydCC1MPYGxc0OgBnp/X
	nPFuZzMa/fdStX1ye8o36/Biii3HJSMJrI0KOXuFLoKExrfZ+/8ufkIsTWGLuiz0Nej2ENwc8BQ
	ADJWS+84CuEWQJdAD5o1xwjT3LN/74HQmKGZMwFAP9E7n52a94uKJ2fUAFTYdHRrF1kpTcVZkLY
	lvhrIFV6VvXcRD+q8xqY9EmaDoV3pkSRJBP0LOaZGwzkx7AYC7Ff/fxEwg0Jt2J4hdTyq2xC1Fv
	ykWBBnoCl6vaRTVBYOoVEWTPC+3Kb1duM9dL3Kf7bitP2wkWs2ZwcYWfNy1ubb1GVfoSqPdTX0N
	sFcX9bREVPEWWwbs7ozOWZasStlk8n9Tnc2qi0tDzPsiRl/rGk11JxNP4NlPKOD+kjbjS65HbiV
	gzaQ9mc5vwj3Z0zDa4FSzfjEgAscsJay9dxVtIsGQilq2jmvToWE5950NlU40s+O/ZGqbllcU5w
	Ax+ebIY3KMLPe0UQcqevz9vYHcwZIelmbqDP5TGQrVZh5MYcCxbJfoTbAvlrZKMjaz2315MNktf
	OmK/tnKy0GzItalaeZbQrqSL0EefebwNpB9rttfnZsU2MgdB5/GP3cSZH53gvQCEtDk5jdIFSiw
	==
X-Received: by 2002:a17:90b:3912:b0:3b3:b632:7f1b with SMTP id 98e67ed59e1d1-3b41c9b2be0mr1924746a91.12.1795160679208;
        Thu, 19 Nov 2026 23:44:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d2253d0sm1404173a91.3.2026.11.19.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:44:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 01/49] bpf: Look for bpf_clone_redirect() once in check_recursion()
Date: Fri, 20 Nov 2026 07:41:33 +0000
Message-ID: <20261120074430.2704488-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

check_recursion() scans all insns of the program for each recursive
subprog. There is no limit on subprogs now. So the cost is subprogs x
insns, and no signal ends that loop. Scan once.

  100000 static subprogs of 4 insns in one cycle    BPF_PROG_LOAD
  before                                            34 s
  after                                             11 s

Fixes: f7e93aa4a34f ("bpf: Remove BPF_MAX_SUBPROGS")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a8e5a108a6..48b8a790d6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5485,6 +5485,7 @@ static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog);
  */
 static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
 {
+	bool reenters = bpf_prog_reenters_datapath(env->prog);
 	int j, s;
 
 	for_each_marked_subprog(cg, s, CG_LIVE) {
@@ -5506,7 +5507,7 @@ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *
 				return -EINVAL;
 			}
 			/* It runs on top of its own frames. The half of the stack is not enough. */
-			if (bpf_prog_reenters_datapath(env->prog)) {
+			if (reenters) {
 				verbose(env, "recursive %s() in a program that calls bpf_clone_redirect()\n",
 					bpf_subprog_name(env, s));
 				return -EINVAL;
-- 
2.55.0


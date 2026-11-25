Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577400;
	b=gTw/H1mR+CmhezOWps15h1a1OOdsKaq8dVdOFBr+fdRhOeEO8txQ9rdJabjeD/VVyTxu
	 hsAtC2z1i/gL0uLoM9Lzm6r5ig47Zn4PmwIHWU8NiIGBYz0diK1wjHUH2H8FZQXLHFYUq
	 t3mWOT/vLfImeexvhWrccTbNTvNz8pOBWzWyHpwG/0GxgZHn3tz0EFdzgtj2Edt+nAYLl
	 +gSMq4qDLMqLSi6t8aM4cT6pRVTW8CgIx/tP8cipVqxSY+X8gNddbpfsphTZNEJXpL6cW
	 k1pThW2vJqPa1AH67Mmou2E0m/e5Me4hQPiF7MR/ySUeOLa9JtELd/RDClMco7uT5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fDByEYmsr8OoyCIWVGpIF1HiaoXPAr7j+xvsVo/Lwn0=;
	b=4GXcjLBE9kA7c9jVwAhiMHkhxW6xSG04d3LmS+0l8+dD7Bn452pvYjb1DB4+BsM8L1hS
	 SWm8TDxUHT11iCPc8y9qRX9q4VW/javwqHpwd+0Kz3sUqnczAfZcJNBojheFheHT/s7xy
	 iKFIPwwYXj/rkuuAqhOYkPgYyIHJeMQtxKIx9sFmkyyJntJjplwVITiNUyOwjPML4jeWz
	 7xTzrx5Tv3BGleVc37zx1hj0DQ2sGra4qnDPXLtZIyIaCvPmusLgbU3JvkhMdMr+7PQ0n
	 10NM6c0fePDs67dkDyxhv2bRNAan2IPkQ6Kt4IW7V7OINzlmVwe+j4uy5sR6llEKokQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nnGpY11+;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C040606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C040606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nnGpY11+
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso2655434a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577400; x=1796182200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDByEYmsr8OoyCIWVGpIF1HiaoXPAr7j+xvsVo/Lwn0=;
        b=nnGpY11+SeIqDKPI7MUsI594gstvKmbu5Mr+WArV1HGVCigY83wJFR9AcmUDZ2bsxZ
         cT/NgmHTIwtW9q5E202d1pDidPYZmbFciGg6Pon6JA3c8XvlN+1IxflPVgezh6ujk6Ln
         sxop/EzMdXq2mJ2IXzmucUvqZtZkzl0Ozv2TmDp5Tq/zfTcaZ3gu9CGeDGU9T9NhJBqG
         9S/iNfOwYfnPH51+YzGka0WOzByMnW/nljgVeGZC+UzG25LHmtg4E0CEbwATj+alZWtT
         Fz2UX5vbB3QTgG+jQUSYQDGRZwkku5gxW0vLzc97FqcFXqJsq6aiNO6jPL+hcVvfcigP
         19Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577400; x=1796182200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDByEYmsr8OoyCIWVGpIF1HiaoXPAr7j+xvsVo/Lwn0=;
        b=fdjTy5Jv9gTqiLjw4qj5cm1IsXdxmInaHYgwibKJNioMVw78Bnen8cuptl0QikSGXc
         uHeNZybKTtXIhl1Bnve9iwfSA1cwHXA8lf1S1/T1HsyFCEyfoycmvzPMXA4grShnBLUb
         rMjob5niabkhrkJ6yAtOEzjqEySt6TFazLLLf6T7jUiGH0JWnBtCf1ZqVK5SephSioNa
         G2C6YCsLCss+itBUrzelCvI1YiAMENW//Gvh61+4lQ4WTPPi/vXOzJK5zeXTKnBJm0eD
         Pzk/fdLTBhQeM/6iOj1Cut+2gYCiClMnZkhOQXSpvKwNpRwYA0AwNgc0PhvdWJszfhJK
         rFuA==
X-Gm-Message-State: APuU4Z+IDN0q8zy9KW5qAN8I0+ZknRfO7b7NMu+82UO9aK4r/qCKXJb2
	hx5lupoEir5QdK6DnbG/yQVGN6cQ4eMda7kPC1Gmg4A703x1/il9nzXb97feo2Gt
X-Gm-Gg: AZFdTZe4Zjw3MEc5hz/NEztAvSdh1+e6r2qCpYOK31mrfV5uwxmtMA9mISrd9L9sTeP
	li4J3L53t6gE1irNMD/NG8q+acDYD/Y1YzeD/Z5U/aZYm1OkgZ0VODNlmXJck4dvQkz0Hv5M18p
	rkVsESDmPksL3u0Ir3Ht6/kDiGIr4cbwr7PyXyXDt7zs1PaKjvwD93gRH0gjFbGb4uXIXYHj1t/
	QA1KwFrWR89FLnEZTMmWo/P6Cbmvmjh4EkIAbqlNk8yGi0kA4a9iWLrRKoRKPoqQMtQY8I+W6Vf
	6LSIFn2Vh46ILnW9c3v+0WqnBY14ggF1smYwQaDFdpvDZSySpyo0BwjUJbb4EDJzD6gxFb7oTsn
	oKpAQKmPWdvY6qMLlF/eypLsxTQXBfQQTH9PbZT3IbMcL43pxwKHPfS9SJIWamTb+yGdaomzF1+
	05OVaQvhLMt8uvjvcDfzKdUuRZInv9RijXz8ZtHTGmbaDEkaH5kwDkP1JceGZQmNvmMT/KIss8I
	q8LdSIq+HGwO/E6FGmc3cQuWrPjur3fYgW0Rd6r7KjwOuYCA5b390YCt7CNPfAHpRbLyeDPRQvf
	2/fkQ31WXWD1tx6JIUPrpeK12coBuKnV+686wg61zVwSNWrTL2w5ZRhARAmWA1MRG+tUW4nab39
	Iqx+P7KUUveEABpQ4bdSRjrXmCoYYnJDUvruCacLKYcO0hs3MFnASxMNiVFgvlDUWIDZML08fIA
	==
X-Received: by 2002:a17:90b:4a48:b0:3ad:eb15:aed9 with SMTP id 98e67ed59e1d1-3b41c7ac064mr14291724a91.9.1795577399705;
        Tue, 24 Nov 2026 19:29:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm8120192a12.2.2026.11.24.19.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:29:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 03/47] bpf: Do not take bpf_get_retval() of struct bpf_tcp_ops for an errno
Date: Wed, 25 Nov 2026 03:28:54 +0000
Message-ID: <20261125032938.670542-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

The verifier gives the result of bpf_get_retval() the range [-4095, 0].
In timeout_init and rwnd_init of struct bpf_tcp_ops it is what the
previous program returned, any int.

Do not refine the range for struct_ops programs.

Fixes: 5ac77ae32940 ("bpf: tcp: Support selected sock_ops callbacks as struct_ops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01a74e166e89..311c9f19b781 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12305,6 +12305,10 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
 		    env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
 			break;
 
+		/* It is what the previous struct bpf_tcp_ops returned, any int */
+		if (prog_type == BPF_PROG_TYPE_STRUCT_OPS)
+			break;
+
 		if (prog_type == BPF_PROG_TYPE_LSM &&
 		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
 			if (!env->prog->aux->attach_func_proto->type)
-- 
2.55.0


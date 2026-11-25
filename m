Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577442;
	b=RWFGv2NZ0euDcAXSaCxc1SLEs2fda1ygMvtzJ7/WjSsXenhzkX0BGGJ+j/Nlljc6/Yhd
	 FQnmLyTCNjGapHrfzKG91r9hDerOetrieGMq0vIEC9QwDuhVQKrFLIkO/jWqZuJXliSGn
	 VEvB+DfG6GrxvIVABD2OlxlutGBfYCtJGrycn+aivCIBfGvl1zIhB1S2FRFupiUCK6QM+
	 gL377UXhHnKqn3o4JrhzkB69D2P+6Yg0iQLuYdburOYAE3KoZQ+uPrSyQ+QhPuNaPyK0P
	 LR4aGS4jh3SPbXEeaju0AGGdSEthtiwrtCf1T9U1OFkM5ej97sGFVE8SzmDbCVIJ6bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kfcic9LM0mCH1+6OPnb/ZtZqcsv8N4+96IiKoW70UR8=;
	b=QPlH2jCFxZah86s7z/ysi45m2csKEeQdO0/9/OIyaX08lBfmpOuQefQYuMU9cbzQ9q6i
	 5wLD2tlMXhyJlJtGqVh35yKpb7TZF/ZGUzFmXBiVCWSsfx5krvTmJQ1XRTphFODnue+0T
	 NxCoeWdG1289Xxk6CtzPTVxNtdJ5Vw97oJ5ZUyXptiFDfIiQoAKL9sYPiPN2XARVlwKlO
	 YsMuz6guKhvHk7GAC9uxGVHd9H1gxg6g96SOJt0yO6XhkgtYJwb0EjR/nbMaLVzYYa8jb
	 WWCIcxjk9aK8GGaEYzqDnSfJrWM0Jec7CXRdnvrNm9WVJnok0iaUwNr/jsROe3sUJQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YFV0MwLH;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA56606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EA56606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YFV0MwLH
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso2066640b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577442; x=1796182242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfcic9LM0mCH1+6OPnb/ZtZqcsv8N4+96IiKoW70UR8=;
        b=YFV0MwLHAyRw+RxMgBGmoB26HaCP1+LBq/c4o3OBRJd+m82F2an7mMvWHHzqiiGrmR
         UUsEzBm81wDGylpzVYdZc6TuAEXkzcUWPiEJk84RMEXK8Jswjj8ZQGVU2WtRzi/5yOoO
         S4gNXIw+tEdPnAvQBEW0tWftb3zd2Z+/tvekgWz8/yFwVozkwmVZe2oK+BQ4koDHLjfE
         3bLXfGv8FyCfsgFR4bkTrXZzkTQqOVdZbd8Tp9z7SPyih/ZZ/Z4IdZcps7GXO0ko1JiB
         +YENEd73TNOgAudIJL4IpBSd7at0OlesecrGlt22ej14dqoiMEWBIJfhNb2X2u80sJIg
         Z0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577442; x=1796182242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfcic9LM0mCH1+6OPnb/ZtZqcsv8N4+96IiKoW70UR8=;
        b=xit5wh/djJyqT7xjnwEsH/JdzwJJG5g8kzg4UCjQ8shqSyN5K3xsVGlo179mPoHAZh
         yBOgrDauMZ7htdBkqWIRjQ9jsdsFNpgd5cN7uxuaFhMBVVNK7Ps4eIHuLdEbLCmWK7Zl
         kNfRB6E5oXIwT9zmBrCTb7+IUfQjcpW//lo94cbwi8vemxMss9Spb0VkG5GTNZAFHWpu
         1tiI8uUcZc933iWd6TxGZbWXPeU66A6pYEgYe4X76z1QBjb1ZephiLPE+FwOl37qlXpx
         s6f8wXH+JURnC0VMUTmulS0gq1wOgDNats9gnL+2Q78rzlqgwwp/xiot0XfuvCpBlk7p
         Cj+A==
X-Gm-Message-State: APuU4Z8uzdZpMtSUZwq6jpc/3r1dH6CC+Kms0E2z6JmG+f5ExrIG1qD7
	rs5afOq2Me99653UztbmoJFSmJeB1iAFl1yqbiYpGvuXncgK1Ye1UJxy5fjj1d1o
X-Gm-Gg: AZFdTZd7PGobOF86s/TxBhqDRJ2XW/hLsUoxgFO7SniReuzFrkpPh04YaxcrG4xW2U4
	RJa2iYx2orc2rz9ZWH/InmhJAeL8xKdTEmp2yaMgFL8CBQGWcuu6kjDiYyCaGtFr2l3NY2D66ks
	BpXGOtuaQciMePdBazAtcXS6UKzi34UGohrWqjFou3610iKfg7DV07p5ARfPuz8BlcKYlYl47ky
	8roLMTv0R5rJgRSPKrTSt1Xt0ZmUZ7+sqbqIqxcLPAGuCIafSbBi0e0YfGSqV0T/Nf/8aGvWbhW
	OsrSIDsqQ36xAHrjxepZtSPMQc2zOuqGlqH0rSd6Cfj3Jv4ATyCioqiadxWxXHsY+GgiWy60VgL
	DKL6WKGfiHzdRbvto5kSRI8uY5GP2naZUwldS8lNVZEHvOFt59cuUbOkqSbtPlfVsncP/wtwARd
	R9XStI3UUpLzNp6RAumpw6JMGtNYiqkz8Rryx+PLZFij11CaJ9Lju9ndxP9i0pahufbutCkFdnJ
	oIsJSxeZUzOWeOfIOONCvhfBMHndR45vlPVFnMvLA7rJahoHhfuJhxqnYhVXctmc6slMi6/np7y
	CgfC52FcGnLAPtbKvCRcL+7mQ/AY9FOQ3+6Vd1eKtQLfZKQBvt8Tt3NIx8ZmSI6cBIqSZOlEUmN
	BdimXdFCvO7RiNuVs6UoKTF0RX92Yu/2Kx5gqv6gx2DDDbWeBOWy1QAPaF1gcMD8H+R2FibIqRL
	4=
X-Received: by 2002:a05:6a00:b42:b0:8b6:12fd:7271 with SMTP id d2e1a72fcca58-8c87c38846bmr14082565b3a.25.1795577441700;
        Tue, 24 Nov 2026 19:30:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm7963568b3a.48.2026.11.24.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 10/47] bpf: Keep the names in front of a number in delegate options
Date: Wed, 25 Nov 2026 03:29:01 +0000
Message-ID: <20261125032938.670542-11-alexei.starovoitov@gmail.com>
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

The delegate_* mount options of bpffs take names and numbers. A number
overwrites the mask, the names in front of it are lost. That is the
order in which /proc/mounts shows them.

Fixes: 6c1752e0b6ca ("bpf: Support symbolic BPF FS delegation mount options")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index c6f328e4752e..50dad8a3936a 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1055,7 +1055,7 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		struct bpffs_btf_enums info;
 		const struct btf_type *enum_t;
 		const char *enum_pfx;
-		u64 *delegate_msk, msk = 0;
+		u64 *delegate_msk, msk = 0, num;
 		char *p, *str;
 		int val;
 
@@ -1094,9 +1094,10 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
 				msk |= 1ULL << val;
 			} else {
-				err = kstrtou64(p, 0, &msk);
+				err = kstrtou64(p, 0, &num);
 				if (err)
 					return err;
+				msk |= num;
 			}
 		}
 
-- 
2.55.0


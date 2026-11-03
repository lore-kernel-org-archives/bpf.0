Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749484;
	b=k2wQBmY9F9AvZrER/P2NN3dY9byls5uizGposnAtF3HhA6OjE5XtF/F3TB4p095c+feO
	 6OJCLUKN4bgZiJMOTz1kbbBJINzQp3DbSOnV2OWGHcpq9bLSGb+YcQ76eHkHq/DO4fIsv
	 JZ6E3iZ0BMuX1HGTwqIGRytVDYoDKFhtix/Vnjtq3txEYCy+iWEelZgwEZ/r3vUDL7NXf
	 QwpJnmJjPN1bBW9WtTyYAy3Ny3fYm+TLj90AeUBygBZG1WF45K83iG/47pLpO5Ou3pojB
	 C2vmXv4zNdn+ZAyJzhHIF1aKbvLDM9cItiwW6mfyV3d5hI4sALAO+v13ujOjUqMyl+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vbDHKRyR2R1wTPBtedB+SwZimS/VaXre0Uf8bjXv3rQ=;
	b=4qblrcq9vl1vGdjob4N0jkt1LYcjrhoQVFZ/Dh51GQ2aT9bE4fkscglz9MwrTJNoGJQB
	 XHff65eEjHYlmbeCkc/ViarH8PdK+cN7kbMGjAVl0MxlP2vN21rtG2hFFdUYGIIg+1Czw
	 ynYIQOZl2D+qF35Nr2BvyPtFTnLCqM13Jvdjk1A7igPVaBFXqAdd4j4AXT4+X+CmUV4/L
	 kWtLBHXiPXnTaXOUrvg7aEeBg/mAKqLVMyR1vdY81D9ZaXdeCG25SLBNuc6PXcWstIMhT
	 nFfyMI/VS6vRPEVgVKS8JoPlwLG5HvQMC4wtG9djaUds6EguLcb2+zEserzmFTR0RRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a28fe2kM;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90017606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90017606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a28fe2kM
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5378b281aso593965ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749483; x=1794354283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbDHKRyR2R1wTPBtedB+SwZimS/VaXre0Uf8bjXv3rQ=;
        b=a28fe2kM5oJNjGoyDG2BBYnZ+A0xoWhItROdzauitmyEN4jAtDSC9SgnPPUztwmtUo
         uj/8kJ9w4fv/coPbGumM323MJ2NouJMRpI6Z+7I1m5LY3lD6B8jriTi7U8oOmGLkENDP
         RctHZiCN/nqSRlb8uUdO3SyVvKqD/VFiXe/bebRNGDTPqOyf5AEtg0rAWIuCp8h13NPO
         HZpt5DA7ED/WJfTyI22AobGj8iXa+L66r+DQ0+7vQdxueFEqMiQHOse3o78pDamRtI9Q
         MK1W3mUtMth8BRa8mkX25ZYBSUpboi8T6kGjXdXYzIvC+AtFq3LbiItRDpXBrZHguP1q
         URKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749483; x=1794354283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbDHKRyR2R1wTPBtedB+SwZimS/VaXre0Uf8bjXv3rQ=;
        b=TFnmmU2I5lXSM6V1zoSTJ0WynvtiCwud2NvkWiffc69/Te+BFoyEjN/u8G1W7uQHOy
         GKhjqicIQbKDxCnlHKslkVlN8hOf1TJK1Fb5Z6cxDQwE9QU4fb2GgiMfjPMoTbttudtG
         69S0kKak7jN95XXI8ozYr9KCBP75FSJ0W0+DRvl+Lyhlr4FYAT0A45krytSft1JHkpAT
         yNU4+tITh5jFUP5K8GQGksJT3jVGAB6sJd7MXd74Ynqk4cdpmMiNF3jxUOJPv2pMwAGn
         luIU+og+2sHK/1ppYlPed9iDydBY9LRI+QjiYRpKIDSRHWNVifi71n4FwI6GX9nRcvIz
         UJvQ==
X-Gm-Message-State: APuU4Z/4AJp8mQ4FJ1ponGbpcqyDnn5ApdU5gJdBSM3tU5y+uLNFpFpK
	68K3ETggzl7IYRN5gse7UpJamDrYuLGUAFr7qw7w3jdzFY2RC2ifiv5AT7dThw==
X-Gm-Gg: AYBFou3zknGqPAjVkjQZ+nhlqsmJxCK3jLbL0TkpIANMtew4ajVQcSQjV5o1W6oRsES
	uuRUkArAZe9rZi0I9Egjk19vkKnGD3/F1W1Du2yKa5kSZZQoRlHKGh8QmrY4PkJfhC7RuZ+GZNP
	sJEse0bqbUkKhSjQOXP64KhNwIANQ/ofD5x6QBJyrLrF2bzsxdZRcdcdvurFwudl/O7qF5xK7C7
	b36om5L4up3ZMe7djoBmA0RyiRMW8oSzJI8IumqmqRg8QWQK3uy+tpB1RRYpevv/E0ixpS+/lqg
	IzV+WGDWYixecOituttV7Q2mLiAO0j3W8gWGuAL8JIqkjtuLxZ15K7p8+/uvQ6SubcMJGbUYpXN
	WaZ53gyGN6aVOpa0bSAIheZgT0eYItm+k62uxTEpPey0w6QaphZCoyKdjST7r2CBvPQcCmDkiQH
	Yr1w+YsX0Em1dPBPkkXsvTX8kbtXTGxaCA3N9/zBVNMBURd2hAV6KVsQH34uFzr9k4a58hhMEnI
	e6MEPEYCpBfus9JXWsqpKI34bTcrTOdeKWUf0bhGScCFVVBWuoD+aV3xpw2WoVhrfPMVJafg5la
	rD0ZFtaumXV8vn0lGEH3Nc/RB7grlwg4TcLtkbj5Nf3P2ZXFB/iaQcfNkEE/mr8N8npg8vVbMiU
	oDGRz1kWnlxSZmGWiSuyWEX5GdPaLgJl/TDwKG5GvUMvJ0b1J7RLmLsf5lZst6mhRpYhPnApl2A
	==
X-Received: by 2002:a17:902:ef03:b0:2e9:5714:6072 with SMTP id d9443c01a7336-2eb364ec890mr140452925ad.44.1793749482727;
        Tue, 03 Nov 2026 15:44:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091b5267sm416965ad.62.2026.11.03.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 36/37] bpf: Bump BPF_MAX_SUBPROGS to 1024
Date: Tue,  3 Nov 2026 23:41:01 +0000
Message-ID: <20261103234104.208239-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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
index 54d45407ac1d..1871d0c109d6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -936,7 +936,7 @@ struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
 						  u32 size);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
-#define BPF_MAX_SUBPROGS 256
+#define BPF_MAX_SUBPROGS 1024
 
 /*
  * A pointer to a static subprog in the value of a frozen read-only array map:
-- 
2.55.0


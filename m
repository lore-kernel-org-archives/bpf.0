Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577448;
	b=pv5UUSUUoxNbhdZbPfaktwX7lgsH0adA+dNG5k296h+nh7DPGOsPfFxZSxNPT4iniGIO
	 AbMapFe4WhVCVybHe5GKB0nIoe78RIDnwMK0vBb+sii5R58DxHYLA6O1l1cNlL8ueDirj
	 QNKyukTHC8EH1gplnEdeDQwsxEtbiAtZmNfYbdVExZ+G5elb1GsxCej+vbESyE8wQ6qM4
	 0xLngGdZgmRue5NiD1ptF8yCV66UCYbuSGypciFtiNClndexzPWMF05NRucnBgVoAirE4
	 QHGhaXPT7ekEQQoslSzzlXQI799x3VPfG5OimeATUr0fB2yl/uXpMvfrJn+0gt60EXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CNAZV4hsaOYpoc7G6eE/V01yFUey7tcWZS29nmcD83U=;
	b=HZNhrpy9suL+HIWcVypEClNZTsBEyiK+xecboSFO65REeTop2xzFlgmbBDV+A723yk0T
	 KTrIPmBvdCG4Oq7s5CaZgy1/A/eM7Zl+RvgPSQYG6GPc5e5tPib91O6x7gbnwrLh6rayY
	 ACxUsp53HlgSx9fWeA4nKx03DEEUG4EegJIxtv3aczXbDN0LaLpxUCe30z3id4gOmXszQ
	 OAMt9J6t+oG5LS9m2Ic6/ca0/DUNZpJmifTjEGzEQpyXXitwbn+8yqsVvJpiAytfW/VqU
	 84+TSqvZBgg1mHfbc4z6xrYjnljZo0vAvq+8SchLaMuxdMdYBPb5jl7yXsmtzI5XMOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cSqBYZ6+;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198C606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3198C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cSqBYZ6+
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso3527873a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577448; x=1796182248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNAZV4hsaOYpoc7G6eE/V01yFUey7tcWZS29nmcD83U=;
        b=cSqBYZ6+uCb97F5wJKvbTHRqa/ZjEb2YN/BwDtOYORajxBMMra5fsj1CQwSmSL5/uA
         Xp1WjSztERSyyzAhqI5H0xGcuJmdTIcJ0Xvrb2y4oLqJW6JjPZsXjVeFPULddK1vWgOA
         23QFU6BC1DQG+1ZSqUVn72ci8O96TFhLTfZYLrwmaxVfwMsCVTxYBQL0GNqkhjK2TW4y
         Ak9LylPCclWaOeDAGmw3fgYPb4CqoAFghPbrmBXtBa5Pxw66Zue0I7/7YH7dHSFD3Ezy
         Vq1k5orcTWKpY8kHQua4lHyfBPfrvGkBJADZSRxB1Zu3hA/PZ+c+ASM0JA1gZ7b6Jkso
         u/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577448; x=1796182248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNAZV4hsaOYpoc7G6eE/V01yFUey7tcWZS29nmcD83U=;
        b=LgOtmC0yGvoALZH0rKRq0ro3CFrVNhej/GxTc/S1l/AeBeSf9qGR9XjWm2g+TJJgrs
         AL+Ca3nMmAHrLqX7VYH1YPiCEGVKOrg61fDE7nKVX4jZ8+SEmsrWEkOhoeY3uYpMedBu
         3WZYVCU0wm8bOGt7liK/UGFLN/7yWx/lacXS72lJ7oY6g+Gp8YiIltFhP9pfpL/yuWh8
         Xi8Ow89IsR4cICT++uUTdjFhTfok4rW+Z58GHLgyzvxFf9Pye2VT3ytkCGzC+kISBkm6
         rNuHfJGMaijtJUXIULQQN7eNHeAPRIJoMTGMzi0888ZVwCt2ScO0CHviLWpgjFCQwqJS
         /ROw==
X-Gm-Message-State: APuU4Z8fa+9U6WNCO5ODVy57h1NafE8YWdi6azSU6lXItF2JVLrlmZhP
	+3jC1EaJxWpfEY2WiZ/eqoAs1NcPpyusMRNBcDPVtV7/qgxGv9IM13hYzB1UTJ8b
X-Gm-Gg: AZFdTZcB8vSXBEAZOYuJOzzup5qyQK0PWVkYpZBgsFp4RnoAuCMEAODkeh2z4Szq1kG
	1+Wq0gIYA6TQLj2G7g6eRa1J1h9TYxpMHbboYlXx+TC2mn38iFksXznJbzl4mneMVgEP7F1FV86
	4HrpMqjaz63jVwNAiCPuwDHeeHzZsY5KnCFFK1MlSdAw//C9qk7yTfnPNZ3c89UgNrZQ4uFtmfF
	8GzCUe8pB17gfeTzpMaeFGu57OI1Qe8A22Jeqo3KdtFz1dfeRGKPUJ0Xppkr/ljdFDTaH6UqYlZ
	1lsCIA5AAxqLSk0DpF3pdsvUdzsP0n84s3M9ZN7AK2HIhC1XwHwbU++Y5hDT4PfnCx2RcICAFQu
	e/sUmZ9sAULH+jD7vKEWc129dhQIASAKYjR4JHlBniDBYgU6d82NYyAp8j+io4RLhMrP3yK+04B
	Z0lsrcylb8GvtS82PH9CQjxq+9yzfv2pR268HmZUJF1RdUobx8XnfQ2E97/pzq7jE64sAzwk7O5
	vhukZH92kHu4VmWhOnVKjRsADLM6HLanVV/nkEfPj4cTGX50jHqUFxwPAo9K2HYasEtufcnvjmZ
	Tr3HXh3W1i0TwPdxhOh1DFBWJgUr4l4z406dLPnmr32N2VgRrVNK4KWWCfeIS7T1Dp8GG/+kjL9
	sd/yCKjF9rEyA6AVoamrq3mW1wULSKlMJaJsWMU+FOgH+92sBAL3Rd0y0wUmLmgpjHeIc1LQCpC
	A=
X-Received: by 2002:a17:90a:d444:b0:3b4:15e3:3a53 with SMTP id 98e67ed59e1d1-3b41cb53acbmr15569714a91.66.1795577447517;
        Tue, 24 Nov 2026 19:30:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b495035339sm12517623a91.0.2026.11.24.19.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 11/47] bpf: Do not trust the neighbour of tp_btf/neigh_create
Date: Wed, 25 Nov 2026 03:29:02 +0000
Message-ID: <20261125032938.670542-12-alexei.starovoitov@gmail.com>
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

___neigh_create() calls the tracepoint before it tests the result of
neigh_alloc(). It is NULL when the table is full. The verifier takes it
for a trusted pointer, and a load through it oopses:

  BUG: kernel NULL pointer dereference, address: 000000000000013c
  RIP: 0010:bpf_prog_56e3384dcafb1b5b_on_create+0x61/0xc4

Mark it untrusted, loads through it are probed then. PTR_MAYBE_NULL
would refuse programs like bpftune, which pass &n->parms to
bpf_probe_read_kernel() without a check. The pointer cannot be passed
as memory or as a trusted argument any more.

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d5e126dc5d3e..8c934aa8ad60 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7444,6 +7444,7 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* iptfs */
 	{ "iptfs_ingress_postq_event", 0x1000 },
 	/* neigh */
+	{ "neigh_create", 0x4000 },
 	{ "neigh_update", 0x10 },
 	/* snd_firewire_lib */
 	{ "amdtp_packet", 0x100 },
@@ -7656,6 +7657,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is the current arg IS_ERR? */
 			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
+			/* It can be NULL, and programs that do not check it have to load */
+			if (raw_tp_null_args[i].mask & (0x4ULL << (arg * 4)))
+				info->reg_type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
 			break;
 		}
 		/* If we don't know NULL-ness specification and the tracepoint
-- 
2.55.0


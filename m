Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592744;
	b=wKUPIser3jwSPLjEiDCRDlvAIV63L2OxIBkKf6xuXj+jh/FoPpz5j+2A2fBghpvcCRAp
	 yr1Ekf5jLg1vrI4wjMr4PXR9zjdKUUVqFRvvTvJgxrd+hBQuDfKeQglrdN32qj+EDKioY
	 mEUfV7cpZ7Q1hJpw9JHLV28EFJDGjMFjf9IPepnh7G8kZimlrRapsNTtZgLRpsRZsoMQq
	 CLdIvN2LIrizU6HntIQL2K20r9IrZEhwb41XAw8EVZ1PyEqHUS0zJA9gLJYd/lKQRCcqL
	 TL9QrF8ptOaAz+lJh+Zvdxa0G8LS8KYcr33SWs0cQ0qIDOc5qFcq29pcg6DJepzw6gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=pd/f0Jsox2fecztp5nkJEySHQjss3aWcBkSeEgsLWd4=;
	b=OEBSyESCkuhBR3YzAJUhp6//hBRiTv6QEb0aX8DQXlazbPcM3QYN8ONyH+eaIkT+cSeP
	 jZYppRdU/+eliQbY8oQGtwjNsa75ULao91BKULWr969MeB4JSdWI8vudCku/7HfCl1O65
	 bf77DbV3H/Je40cI0hna1kfyLKKyRbuEblhOSTfvgjVlkXze0btWC45Q2Za2oB5SNMtqq
	 V7Vj4az6qdrS9axSj8IyQUueNpbXtGeurDEGy50BPRu68HgIyM/CdibiE6vPAugdMzmez
	 GkXuwfxveg9LItNY9ixio9tY2YHEnIW6X5jccAKvEsPKkrvwdEeqDqpJVnvQCj+Xjug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5uNBgXX;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494AE606A31E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5uNBgXX
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67999045530so670120d50.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592743; x=1793197543; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pd/f0Jsox2fecztp5nkJEySHQjss3aWcBkSeEgsLWd4=;
        b=Y5uNBgXXLgaKLC31gcZHozuXj9GBAWt3BGESwnZ3YaRQw6X3ScOeHEEJqhBp1Yj762
         PG6PfZoakCw7w5DTTKu71gS/J/ZGpTfb+up9BCNDG7OPSjMZzcJj0dULf17SiACaR9CU
         qUjxV9P0HJpECdqzRjsK1gx35tawgC3F072rtxB0H7JJeJJYAoXtRJR7BLB3eK9DOZsq
         WTk/SQPrpIUAFTHCN5bBRpwYG78t9afuJK+MfmFty3yCMX2Aw8FpwPsKnzfOWcXW0ef+
         XE02PqutEY3qS+PyNVTV9qnNh+ZyQo3vwKBdQ0B2gpMEKtBsOnQdb9jX9eDep+Y+nY1N
         loNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592743; x=1793197543;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pd/f0Jsox2fecztp5nkJEySHQjss3aWcBkSeEgsLWd4=;
        b=oRXaAald9zyGg4dBLOxNdlfqJm6utpXrVVskBo2s3XC2Vb6dAs+MyIb/x07Id/h0R0
         d/aY5cbIf3QI19oc15a+f3jFweexjKBkj1BfHhdEzxR7BY/Yjq5sBwB2BSph9IIwH8wj
         2CZMNemjy75AHkKwHVNQv2guOzZt7bQEK+EIcfEAhJJBcCWE5hizPvnV9xH4H3lp4pMq
         bS+Lc09wwfd61nqFKnpdbv5MW2nalS/7FjaCjJ8PcBjBvuJ8uKoGHYD8A+NjwWuGaGp/
         hEztK6x7/l3r0RX53JKEMenPSJzq0Fov2jYsc+ebSQbD84MnbzTQRKkoF2bAPPy0/LFx
         B/IQ==
X-Gm-Message-State: AFq9FYL56ucb7cn66uhqcRz5sfrKlRv7P4Gwax/47PfHHxDYVIaWd0La
	qHiSLsGo+1tvUFrHJXMKg7h3sMlxqTpplzVA9nbQ19xsRJKHCJpnx1AG
X-Gm-Gg: AYBFou12AjZga26lXSzRDh7gKTKwWVRfrv8fVKEzPthJZ9PvVNZdDYAAHUFMR66Svoq
	3Cv/OtDZNTmLCMPMeQdFUHWQAjq1Nc8Z5F62ua06s56xs0zUvooPVffVahFxbSTz6Y6YqD0OYZU
	hqI6T0Y0p2prE5P0dnqhMcnwkxHQ3Xq/l4oExduEnn1gBIJx6v4YqHJu++KAzWwr/iEerDZmNAK
	TanqD9J7K905bQdCs16Dbk65Em8L5d98jDb+d/uQ6diOS1K3Ta7ta44CDJRXIV3pnTqfR908yjX
	zfOQnUzNUbN8GikczA+T6eZWjyqJhECwzANqXvQNvx1/pD8ta4CQ/08rLmFsdla1jGUGzXDe7Wq
	cr3qkQxcluhiRBIjXdpI89OwJzZdFkjyvWe14VeR7rYjLuyat9JwzryH+6F5XzAeb/LY25rSn8L
	qxJ93q4caTZr7FGpqKKF1aAst0Wd28M0gdY73W6y1d3xkp8knooij36yipxr/tRB3ggbNcll0h+
	dQ54gV0LN7FuOSbFOondHWLI56VUFxqWrMNaEjoPbOiwQ==
X-Received: by 2002:a05:690e:e8b:b0:676:9885:d2b1 with SMTP id 956f58d0204a3-67a0ddebe85mr1021117d50.0.1792592743280;
        Wed, 21 Oct 2026 07:25:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e501c01sm1132590d50.15.2026.10.21.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:25:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix x86 JIT stopping before jumps
 converge
Date: Wed, 21 Oct 2026 07:21:31 -0700
Message-Id: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzK2GoC/x3MUQqFIBAF0K0M9zshLaLcSkRUjjV9WGg85EV7D
 zoLODcSR+EESzci/yTJEWBJF4Rlm8LKShwswZSm0aXRapdrTPLn0UtWbqp0M7eu7syCgnBG9pK
 /rsd8ehU4Xxie5wXGPnVWaAAAAA==
X-Change-ID: 20261021-jit_size_fix-da316b8d492c
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792592741; l=1161;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=hCo2Asl/0ju04uJN63Ot/n2byMKWOMJlHR9OUTiH5bU=;
 b=e9sJtDH8qaSbmsNWiN2wcR3suOevs4syJEY+TcM2Dd9SgjKF3MgZm6z2JgFfbKgOS2oEZY6Fv
 GEIjrMAj84hDXE84QUiaRfUCxuOquMsjgPSCFugGfgqJ0c3xvpA5zTl
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

The x86 JIT stops its sizing passes once two passes give the same image
length. A backward jump can grow while other jumps shrink, so the length
may repeat with jump sizes still changing. The final pass then emits code
of a different size than was sized, hits "bpf_jit: fatal error" and the
program fails to load with -ENOTSUPP.

Patch 1 stops the passes only when no insn moved.
Patch 2 adds a selftest which fails to load without the fix.

This was hit in CI by cgroup_tcp_skb with the unpublished branch
inversion series, whose layout change happened to trigger it.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      bpf: Stop JIT passes only when no insn moves
      selftests/bpf: Test JIT jumps which change at a repeated image length

 arch/x86/net/bpf_jit_comp.c                        | 25 +++++++---
 tools/testing/selftests/bpf/prog_tests/jit_insns.c | 57 ++++++++++++++++++++++
 2 files changed, 75 insertions(+), 7 deletions(-)
---
base-commit: 59d77affc1dc56c992308038e68d7041abef1b8d
change-id: 20261021-jit_size_fix-da316b8d492c

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>


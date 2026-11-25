Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577472;
	b=dsXXIZSnsg/gYhJaWJ2KDY9hQuZmz8iBNozjYXfn35p01+bMNlQkXhsj8vw6PzPYgRxZ
	 iSTDiDmSq1v/rSNzL0A3dnQKXRrTdAXWUG41PWYccNfnYwAE+RcDohx5TDGrcigY64CPJ
	 DMzjfjVUlfkG3eZE1kg+VZ2VuUqBBA3mezEy+gjsMAERDM+VOzQeE337U5uWAbRZFE08N
	 3G1iEQpsgE3rspbDp11Ex+1rJ6Q+U6yiJ35EvjrGSDCwr8RsB3zt9CdOngoynNAQRiy4g
	 /Cv0u50WZd6flMz+JoQUIf22o/eNP8BTPiPUmEgK27Tbcmq3MnpjEggddxF48cwyTOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AH5fnMqI02M31nBbBb6vlGxHvk7Z+9nUL6CE0ryp7Ng=;
	b=L8Xh2uzFrvFNL9QSearHHOLqEwMKuMCX9/MrGvBhJfMlyREjOcw97XmG6ffDdrfCJyNT
	 /6c5gkCMC/6+W1fIzILLgV2Ev0oPJoZTg/vKy30aLZb14lxcn3kSJv+9WJyx3DsbOt60+
	 1vfb4jibzzmApacUBfNaS/67tB6ly63nE0kWV4VSbA60lUi1R3mabGlPUccVAj1+bbUYy
	 HopWHpTDflVEMD6BUfB+h2whYqkMXXuS7QfEeq31MYzsAvAZzqRVpyu95PQ9kZPmrdPIs
	 ABE4sUFjzrcA25UWEPaFhackZQKndj/U9+3vNTGZIC6jiFYmwq864YJQpxavEOMZIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHTtiZvX;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC20606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEC20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHTtiZvX
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f04e3bf46dso37566295ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577471; x=1796182271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AH5fnMqI02M31nBbBb6vlGxHvk7Z+9nUL6CE0ryp7Ng=;
        b=rHTtiZvXBWXl1HXBKbWJXw2ns9j0yCUr+bHfiucG/dYnUKYVEmXlbA5SZGYZ5Pkb0v
         R8bLdDEQXa1LC+xs/fB+Wjr8N1VvxTF67Jd68+40FHQs9jsbNQrp3janh5H6GyCoW7I1
         bzEO8Q6jYQdAiAjlg2QRKiPuOm94nW1uP2buKakn/MXNhRSpznuq6AYhPlJ0HmmySInt
         EVA6G7ZMz+fctTA+HQ1+fcPX2Uh1f2pvo7XV6PgOBoZC/bOUbwxFWbihjf5vK73U1SJH
         jGjJvB63BUhCYXSjq1N46beZxLNyMAvzQCH6uIznvgrcJ1LpchkfFgV+buitEhgNNfVt
         f4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577471; x=1796182271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AH5fnMqI02M31nBbBb6vlGxHvk7Z+9nUL6CE0ryp7Ng=;
        b=mndgNdQRAn4DPdEQWW2+yyO040Tueeq44WYuoxIR9p1poERejMfItb9VFyu6GEnZ1p
         vFV+MPgGblOuwFv4k6zG3i0397CNjgx9PuFln60TtQa4IIE76JuFV7MGPpOZw+195UkB
         LGucsJrIpA2PMaVwJyrj4Y3u5AU3oDYIazPE7yyYprftWGDIXv4WuLXZ7ZqP9kE9f5TA
         FOZ85EjFDE7C60x+yHh0sfY32WRl1ghHZYimEyZwoUeyYfZz44F0GdCNCAtYloH+ZTZd
         ys+t8TPc2SkUDFNNSTBgu+Vc/kb6c3O3VQgyRY+OHF6k1lBVC/y0oQHgjzZmpHYov7ZY
         2Dlw==
X-Gm-Message-State: APuU4Z8maCRRYNfdR+FBbtFt9EEO4lQqhN6xkZEqG3f+wTI+wG+WAWOl
	HjDgspoCgmULWumrxJL+XRg0599rAYy9XLRTtZezk5oSZfvTAn6ITJvo23bzfZpy
X-Gm-Gg: AZFdTZfXJjFh62FuRlpmwEQ9ARvbHzalb38ReeWZaJ1BoXE7DECFQuq2fMENlSzglHC
	5e1OG5o0WX5GgD1m/3p4Dd0YHJOsw8GhWPt3iVg/2QZnkvKWhfXpqo0ZeYIcuZrHlQ8DA4Til+V
	QlPIvFFzJm+53d3ohxI/VoxJ92kHPtlwwvjdI1kvRXFbF/Voz75V2Nx0VFMhQYnXkW+TsgDcNz9
	DDeQdNiZjF5f2GVWVMohBsNgPkc4XzQkMnRWTD3D1/AJR7VT4Z2unxR1As6vlzarulHIuBs/D4w
	PtXwK8BpWDyy5lVUyLcEHCAkOiAHUukDugOs2QOCH/dsR8jkG+oq1Qz10SzvTbROdBIKzY2muQa
	bEk/gVvpps2VZ5ZkEv3v+ocOT7uL9E10rTDC6s/09lUttGpG2/gJAA94r5HBDHDupMUmmUn9BFM
	qGc3oS72xuUG/ip7W/bbpXjmXVH7GNivwqqJi7nq+aECfS2y659tk3C3FsZg5+cKDx7zM8hyq+E
	ckqN8vGHNR1CPheEqhZMbLA7Ia3NPn0I/FZ5P2KnvtBajggRmbbfww7J9EsoFRCsbKWp+/H2H3e
	Aw1NwEA/+06SOiUBI3r09OGzt0QKiyH4q8mCXg3r/3PprSUSeOZRWdbk8zEXVoR1s4qTUCDgN9a
	j1jlX5d+M9+i6i+981Ozg6j83uhEEL/H2VCBO4g6sbW4P9aW2aqg6fgWprtE/uTPBWt+jvW/oGU
	8=
X-Received: by 2002:a17:902:e80b:b0:2e9:660a:7944 with SMTP id d9443c01a7336-2f03f2689eemr169634155ad.58.1795577471049;
        Tue, 24 Nov 2026 19:31:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm77092555ad.10.2026.11.24.19.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 15/47] bpf: Do not fill jited line info for a hidden subprog
Date: Wed, 25 Nov 2026 03:29:06 +0000
Message-ID: <20261125032938.670542-16-alexei.starovoitov@gmail.com>
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

func_idx of the default exception callback is func_cnt, and the test
for hidden subprogs is off by one. The address of the callback goes to
jited_linfo[0]. libbpf and bpftool refuse the jited line info of the
prog.

Fixes: 335d1c5b5452 ("bpf: Implement support for adding hidden subprogs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 06a0413da489..2f6392ccef73 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -233,7 +233,8 @@ void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 	const struct bpf_line_info *linfo;
 	void **jited_linfo;
 
-	if (!prog->aux->jited_linfo || prog->aux->func_idx > prog->aux->func_cnt)
+	if (!prog->aux->jited_linfo ||
+	    (prog->aux->func_idx && prog->aux->func_idx >= prog->aux->func_cnt))
 		/* Userspace did not provide linfo */
 		return;
 
-- 
2.55.0


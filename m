Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A72F6577
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959094; cv=none; b=SJlNhKdawQpM/T+GJSoCD1uG0e6Dg7hckZbobLlX5IAVUUdQ0mYT6uaRD+8aeqvZRt5YRiFaSQR7bV/cd9eK7vgxiJQsmYKYbMAyq6Yn6ybLCIzWlvImiNZvcrRnr/yW1PxOQXxLVY5OLlVURc1ACfr+jdfnMHyvFOl4vaB8Xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959094; c=relaxed/simple;
	bh=WoMKbK/shvv7dtB9ERHXZ7guafdnMz10qKnwMijY9w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etbYhQe6Uc0bxcvFhAyIARMNOhkF90welEb0BrnqsI6CncOjTTQi/xNUDLTVI4/ifUKBldzAhIrJr6p1GMv/jA+wwKKOwtIXPhY5uarIfKcK83QCTIQlfhDXOGOm56qZ+k/swEUDCvmuPVZGN7cE+tlT2gYc/b7rwxwlvfQDtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTMKpuOa; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTMKpuOa"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso287164a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959093; x=1792563893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9D8gIqXwpYYUxEnfLEa/uqumetlZw8cgYsoRE/cLh5k=;
        b=aTMKpuOaptzickO2yc3q08TvA4VNkZ5pIYthTrZjmmbNHe5YQ/O6IZo6iwPu9bctCj
         lR6qQSEnOYohXis90wHO9h5Fx7n9rQgQxRU4uQzsmmajBIpr0NRxPJTAM4GO/whke3oz
         0oXmn88zuPgzh7XI2pnwiP1hX5RBkFS2ehivT9jFzGz1YS1geXCTjnwvoO3lXVzjetr2
         gKZ41DsHAuinW/EySDEoNP4a23sUZIFi8WP07W+dxOGNr0Fu2dIqGaw93kYfAq+9zFMQ
         NFLU500b+O45zurtbzddBThMKSmV4RxKwHHfzSh9h2XNaXeyW5k1s6VP6SRML/12wU4X
         G5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959093; x=1792563893;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9D8gIqXwpYYUxEnfLEa/uqumetlZw8cgYsoRE/cLh5k=;
        b=tdizCR+LNiPsTP+yNbjH/wYyED9+Vlu3E19asheOdNPr96Va+HG9oSgnaaBFO+6x3K
         e0kX6SgyROaHaklAmC2mqpm425jwzBd3Z5eApO7fe8MAjlNxowahMIxAbZXQP5koRiaJ
         +xnQjxwuD0HUxfW8FOc5kgtHaHHwWvRU0TMxCxCvj4vsXTB00taXjeNZ0cDL6ON/nTFL
         GYkZnJmWtrHIU+fqZdETeyC3GpAV8iMPga0zUwJkIhvc2IXQZuOD4PWtMENHWj0vQjUs
         BY3uaVyhNeQ36ocOT0/wO8fmwAEcSxG6rW+GxyBa1JhfViKV0ifbpg4BlkcTinumYgN8
         vyQg==
X-Gm-Message-State: AFq9FYJ2T9agnJrgqo33U+5TfroLcKyCvvhV2T7woFLVI+f4fY7iK84u
	rqVRJ1QaGe8Rj5JxAgH1AOxz10k+0LBGfMwzcUnOo18hjnzeoXly61jlEz3opg==
X-Gm-Gg: AYBFou2P4nifRtCq2LfHa93EmsgW8Mmjj/XVEvjRrB8OzBxW0viC8k08nmf5Q5UqcLP
	YDC45jEkBQbqyLm8stkx4JnmJoh9GVRY20fkOBkbd5ypvnfxm0z6rte+Dqvvn6VUd1QpLVM4gz/
	T6eQMJdBBV/dknVo/sqiUJ6hi2RY10HWcdDbmMUqmeJMO/RsuAHHUSNeMUdqWbx6HAuqzHbe7tf
	niFtFHjYlWOz80geIkf/hvCOy/JdJWA72yULvXV3V8XNCF2WZywJ835v0dwQfSxwRg03dUhKFSZ
	QHQOpzNVxqHNW3xwlDmn5xgiMYlWvZR1b6LiyWOxKQ0W3FoZpiIBH5ErHL6WJHaj9T17xFudRYV
	Jw/6MMoGacZUihnR4esvtwCALPDnv7IATaln6w5iTKOv6uUlbY9kWuWaeUbsPUUcI3yQFKayGLm
	iPcSazMQklpnohxVajcykNJP5jR4CdXNF6WSP66JKJkUaYW5Jb+5VOQvtBb6Ah2fNvGR7wePL4A
	jkPFGnF8+/fGD4=
X-Received: by 2002:a05:6a20:3d1a:b0:3e1:bb65:7959 with SMTP id adf61e73a8af0-3e1bb657a4amr5191876637.46.1791959092625;
        Tue, 13 Oct 2026 23:24:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/7] bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
Date: Tue, 13 Oct 2026 23:24:37 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-2-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The "bpf: Use SCEV to widen bounded loops" commit introduced a
second (identical and unnecessary) definition for the
BPF_SCEV_REGS_NUM macro.

Fixes: 088a5477a9bd ("bpf: Avoid widening registers that hinder exact stack-slot tracking")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 54cb6d3d0653..791398e14962 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -708,9 +708,6 @@ struct bpf_loop_exit {
 	int to; /* instruction outside the loop */
 };
 
-/* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
-#define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
-
 struct bpf_loop {
 	struct bpf_backedge backedges[MAX_BACKEDGES];
 	/* edges exiting from this loop, includes edges from nested loops */

-- 
2.53.0

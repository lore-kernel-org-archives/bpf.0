Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB13B3894
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215599; cv=none; b=tjE+azP719dp6W2KDleITHSyVdcdcy4DqdpfnlUpRrwld/tKnRrFqFlklclbfjgzfSs/kN8dFIYfVMlo8kiMWZQZcNx84CQSWkW9DRme+D/F7JSvlNAMqGuN4o+RFa5bndde2rbbLVnEtOpl4qJwTQkxFn+9e2zgMdkoIXLeQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215599; c=relaxed/simple;
	bh=1AnJ9PNrT633okRZZHbsfUob+hUkyuKUfJ+x+QaIIqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsC7yfqC7eDCKFfm8KYUeFLMFklmNxCsL3WGg4Ucebb41zufz/RAJ77rVm9sWllHTc2HYifD3fFdHnOawmX1APX01zPiMN5sELr84GXUc3nwzFFEArhO94sRtzWleroV5B++CU/gQYu/yGor8t/3U4PAjTShoNCpzmI1scdXffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkahWEvF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkahWEvF"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8534d507f59so4463645b3a.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788215597; x=1788820397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FhLq11kRV4Uf786rNKyx4nCecX+BX2O4IlyTwAzgdeE=;
        b=IkahWEvF9oOWSxCIaBOwjpDCy52K0gSC+jHpmIp4dTEMrd4M2Z4oCXzPGxyEG5IIZj
         sPutxtT2++qFy8LXW1eUjssgGC/wFWzlRtREKXQDnriVAK5atzsyAsEJxL5p5bio27wI
         R4oQE6pMLh+sXMcPi7Q3qgN4VSgSefiX2ZIqRib/meJ9vskmbzjbIsX49W2wUkcvcG1e
         5S63pQclUPewaiqWFI1RJcW2dkktQcvyVAnl0mYkzGalcQcXCoLMV9bIJz+Fq3hdZdnb
         RjVo6N5pHR8ZKaOjorQi0eO1JSdIE3yHGaZKdsWwURQa+QWSGuHPFY5bBelO3em+m3oO
         4Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215597; x=1788820397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FhLq11kRV4Uf786rNKyx4nCecX+BX2O4IlyTwAzgdeE=;
        b=TgwqMeKjJ65NGVJBphAYE1RmoO5YM9af3ny6UJayz9XArAznGBN5wTAvIAOQXP3Sv8
         ewOF6m0JFxlUU1C77Kt5Nr/O+qmhSmBvUIMp1JbPfRi5EHvPjF6FOFOZ+3ytRKkF+a1g
         ME17KTbW/OXZg90vy20j+d6lKE02W9fIhsmBDMN53alCd9gmxULL798nCQk2SzQrSoSd
         khWz8t9QLtZeLFooLUBVpHKTEgGpzmZBbFoEPFBuxPCh0r/Z01LxyjedPXg63NLjxp9q
         mbSrkIWJ2R26/LZqJeP9V3sgn/eNM2hahF11TWm6Na8hFCYfc6DISbEXaKrOyGzENxVZ
         WVXg==
X-Gm-Message-State: AFuF++kS7HzGjjwaFGe/IEJxbdXDjjOFPAUz9lBfMbuS6BR/x/cfY9/g
	vTaD8gweV3gr5t1yJPxeCoFG8gOCou8lr4gMPMm3139JDTpVlyKzV3r3XzRgLw==
X-Gm-Gg: AR+sD106bJ202b2T2fCzhTCnu6twcRaqZZuDNoY4SObJkyVqA98yIuKpIA+dsuh/SHf
	hIlQqjx3mYpcG0goMkMf44a32ll3rgtmwL3T3OlCP9QW58bcTevyq1TxRsN13ZpqpzsDHZBkPrJ
	0E3kJt51B28lsIVBcegeMKS+C0+bfKxTRFT/HVQx6jDAN90Eov8krCO/qWZ7wlHaqR4K3NSZdbi
	ilWjfbO4CzDT/X8UyeJ8XMWhZdHZegXZD7v124x6lsJ91JyXAnlx/a8OXxWbHg4xvtMGeWGb8Qi
	qSUSRDBnz3XzBGMgkfVHpHIvi+55/kxMpunmD/qtQ8EwZibLs26Mj8F/9dGosUUeLeweivBNKrp
	1vi73QAl2K/ZELDWuQSeJoQnQDz3VCyTm6gkaCAh4ywojLGDlW0aZzz76ti8MFp4mgl+3rmFKbB
	SLrYtpCrjPojw+V0KgkJvXEVoqQD9DGWVS77b55Lqu8MvjyLXhylNmkIZgniKuh6Xp+xeYb+d9E
	vb+Kho5FswyqfgIyH9ttITsporkp7cWbqgn9eLyH3Pyn1OoTUSeOPMfYfKCnF5IBdazto744cLY
	5OGMzZhvFL13LWJV+mLxz5fM9Rwwawor3OLgmWT0puxzhKbVEPBcF4Xi8s4c2ruwz5V7NA8nI/Y
	=
X-Received: by 2002:a05:6a00:1ca5:b0:841:dca1:8b69 with SMTP id d2e1a72fcca58-856274eefeamr47709752b3a.5.1788215597275;
        Mon, 31 Aug 2026 15:33:17 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36ee01asm4795243a12.28.2026.08.31.15.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:33:16 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	rlmenge@gmail.com,
	hargar@microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v2 1/2] bpf: allow terminal gotox instructions
Date: Mon, 31 Aug 2026 22:33:13 +0000
Message-ID: <20260831223314.89787-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_subprogs() treats gotox as a direct jump and validates its reserved
zero offset. When gotox is the final instruction, this produces a
synthetic successor one instruction past the end of the subprogram and
rejects an otherwise valid program.

Skip direct-offset validation for gotox and accept it as a
non-fallthrough terminal instruction. Its actual targets remain validated
from the instruction-array jump table during CFG construction.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..44195ec1445d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3087,6 +3087,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			subprog[cur_subprog].exit_idx = i;
 			goto next;
 		}
+		if (insn_is_gotox(&insn[i]))
+			goto next;
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
@@ -3106,7 +3108,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
-			    code != (BPF_JMP | BPF_JA)) {
+			    code != (BPF_JMP | BPF_JA) &&
+			    !insn_is_gotox(&insn[i])) {
 				verbose(env, "last insn is not an exit or jmp\n");
 				bpf_diag_program_structure(
 					env, i, "subprogram can fall through",

base-commit: cd35e1b10182c42b4ae31ee49119463b17d8ba7f
-- 
2.43.0


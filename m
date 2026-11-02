Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622743;
	b=qCFM1tkWztFOIYvqmJMzyCO1UTt20I/cRSpaXXf8PuKup8puFi+lgRfs26nfYq3I/v6V
	 uAE97GUiFonaDGV7tFfukMDmMotmiMCXPiowGVeQZsZSWOMrSlCbV95dP3tmf9SbQV9YW
	 T+v0NFJ0PLzRjHuyXuwBhIHIw6gRJvgqH+JwkTXTsTUS2VcSCEDgp7bgR9GU/wn9G8HT6
	 cZVK5pSLZDTn1Wan8TS+O1Fhba1VkI9aiDfc+KE4I4y78iOAtMTwx3cA9Oxp3mejFxLV/
	 UfBXI4P6xTmR5fmgVShoqYRhiCzNcXmMrYB/Kghap3IwNY1e1Z1cAVHCIwWzqlg9Esg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=kqe+LXyHbZNd2DifYRp5LCbdDXkt1yMBwCvDevw6riM=;
	b=2qvv0cG/nmByalptN6NWN8bjsyQUuS64nAuT5N5Lt/eiBcunRQCmYu5mhikTlwCLzhX+
	 7lPF+Au2ou+QdVCyn46S/g6W6uKRs/fQmHzu8pZaaMuEY4DXBmsZ904A/pX/12OpRkyr8
	 ZLIAnMuhvLtI0apXc4CREzgo9ZpsSUm0oG91bWa3L+DT18pu8z8WIB9FcnWoPW6uqnbdV
	 9Y3m9D/IndF7xY4KQbaTbXZ6z5NjbP0ByVkMUV7GyucJ7FyIWlBstwsfMl9n4AYHfHFh0
	 LokdQDlFlXZtkUtNNrE8205B257D11t7iPvbhIEu+03kBPGCTr2vxNPgGZ3K0uJd38g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQ8qwhmO;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB54606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB54606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQ8qwhmO
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14fc585291cso2259099c88.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622741; x=1794227541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqe+LXyHbZNd2DifYRp5LCbdDXkt1yMBwCvDevw6riM=;
        b=qQ8qwhmOjvVw3NxAyTtnjTEdrS2eP/EsR8KQSskMSXBx+DGMIKnfYohOrc1ePhdiVn
         WZ19xRNBaQQqtyQxCAwsKXldt5GSiCR+uVXS6y3ISfH9mZD+rbeHKGt+CLH0lEJp1zdv
         R8f5ElFcDXulW/K7LYsZwCm/YnMwaDFYvxP7Nh/RlgmGCDq3xgqF1gTBpibmsc5E583Z
         auRqXYDNWMFVGb2lA/Su9toXoEKocSHRcOdwMNYKSHP4HNbFdkjSb4n1DgxM/pNiP9N9
         SZwCv66ItecoykQIC8yF6Z/Egq0ydCksMvx7bUUItvE2trHbszoS7hFexQt5P5yEfWpd
         hFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622741; x=1794227541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqe+LXyHbZNd2DifYRp5LCbdDXkt1yMBwCvDevw6riM=;
        b=WSZhMQ0xwUO9FqO3VtXC7KtXyE+3DZMF+Vnbt0fsUO/tj9eTvsePmVcTd2Owsh9/tN
         s3L9WqbbaGevi9sBQDxOdpZWSBmfbgQh/FNuQylxVPSxWUdUhJBtAZ9sdIX3Mkxsm9nF
         RILKw7KGRlVWuuf1NldwSbJUSpOQ+9n603mIwvZ4Y7iA7o+zvCr2JD1S/mwyU2PgMvwj
         PY4S5rNt3f42KFV5lCh1hAoC3t0vhI8CDNMkQSrW1jniECx5QQ/SJ0wecddLZRb94zxN
         06RUCLoZ/TJAcocwjuiIGpWYZj2/YoY35g2lSGbbUf1lQJQL0j9wQhLxWE+2gJ1Vnl5h
         gaUw==
X-Gm-Message-State: AFq9FYLinaY/uXMXQjuV3IRcIgZAiVnY9ZcXOrT68MQeUgEJsCbqw3Xs
	RKrH2nP0SfWPBsNkR+qSIHRDScPGJPVWwXZ1AplkIP6SoTm5qq3MpFBH
X-Gm-Gg: AYBFou09adhNdxNPri6/f+vpPF+Bp4uBKXBTBx4xPVruQ9RSG0N/XcmEeRZhIQafzh+
	OSxU9QZy812DuOkcPCyYH0C0n6sak+9To8U0QfT4yL12ZA5CfKSl+KaqFK69uOvq+AseKDFgKkK
	gjgEwuYceBWcz4tQdCEnXBT6z45cyVU3yQDJ8umZWOSru1xNbDKIGnUuFlmIz/yihmg+kBf9i/W
	kBUreABqtUdPtM61uXd1k9ZRVL+3pDrn/L6GZr7PGZR4Iqgv02AuaYHJca0eivJOmQsFuOlSrA/
	peKdPGvpVD7Enbx2YWgBs6Rb6VoOpPTWCJrUTPV3wXAD3tQLZ9qYLKwPZrTg+shK9LQg3heh061
	sJPgK13lICbDTb561gZfGtu4R0jz9ZlfNm4kn/kZGpdUeHZ/Q707qYBrBQewEvfsnM9PQ9kXgPT
	CK1rIkmnVmeMCcOf7cjnTB7g8WRyrhbQCGzNssAJkRBBaQStIMswbKV+qU78Agm5N+iuxks7utQ
	MFw9xlyoaAKIQmHh33v6YQREtS8K7d3R+tOn8mWtX7/Qkwh8dDm9T6CTKgR3jsUW+xw5ZIRzEeM
	So5xDZV8GnpBT5goBWLvcpDv
X-Received: by 2002:a05:7022:7f13:b0:144:eab0:9cbc with SMTP id a92af1059eb24-1ac5e8dea62mr13878426c88.37.1793622741463;
        Mon, 02 Nov 2026 04:32:21 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b2360d2066sm4950951c88.11.2026.11.02.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:32:21 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:32:11 -0500
Subject: [PATCH bpf-next 1/4] bpf: Document the aux data rules of patched
 instructions
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
Message-Id: <20261102-bpf-patch-list-followups-v1-1-ddc8ccf40f43@gmail.com>
References: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
In-Reply-To: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

The aux data of a patch derives from the aux data of the insn that it
replaces: zext_dst is always recomputed, the new insns inherit the seen
count, and a memory accessing insn that is not a copy of the patched
one is marked for non-stack access.

patch_list_adj_aux() and the in-place path of bpf_patch_list_add()
implement these rules without a word about them. The comments that
explained them went away with adjust_insn_aux_data().

Add the comments back next to the code that implements the rules.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ead78713e04f4..6d186a096634c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -203,7 +203,11 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 
 		*insn = *patch;
 		env->insn_aux_data[off].zext_dst = bpf_insn_def32(env->prog, insn) >= 0;
-		/* a new insn may access memory, systematically mark it non-stack */
+		/*
+		 * A non-memory accessing insn could have been replaced by a
+		 * memory accessing insn, systematically mark it for non-stack
+		 * access.
+		 */
 		env->insn_aux_data[off].non_stack_access = bpf_is_mem_insn(insn);
 		return insn;
 	}
@@ -270,14 +274,21 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 	u32 i;
 
 	*last = *old;
+	/* Recompute zext_dst: the last insn of the patch need not be the patched one. */
 	last->zext_dst = bpf_insn_def32(prog, &patch[p->len - 1]) >= 0;
 	memset(slot, 0, sizeof(*slot) * (p->len - 1));
 
 	for (i = 0; i < p->len - 1; i++) {
+		/* Expand the seen count of the patched insn to the patch. */
 		slot[i].seen = last->seen;
 		/* messages name the insn of the original program */
 		slot[i].orig_idx = last->orig_idx;
 		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
+		/*
+		 * A copy of the patched insn keeps its marking. Any other
+		 * memory accessing insn is new, systematically mark it for
+		 * non-stack access.
+		 */
 		if (i >= p->target && !memcmp(&patch[i], orig, sizeof(*orig))) {
 			slot[i].non_stack_access = last->non_stack_access;
 			last->non_stack_access = false;
@@ -286,6 +297,11 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 		}
 	}
 
+	/*
+	 * The last insn could be a newly generated BPF_ST/BPF_LDX/BPF_STX,
+	 * systematically mark it for non-stack access if it is not the patched
+	 * insn, otherwise keep the original marking.
+	 */
 	if (bpf_is_mem_insn(&patch[p->len - 1]) &&
 	    memcmp(&patch[p->len - 1], orig, sizeof(*orig)))
 		last->non_stack_access = true;

-- 
2.43.0


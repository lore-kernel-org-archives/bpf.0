Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153717;
	b=ebcdLGAXqgPnHHwFV4G/x59IK2WApGiEpsLh+N+u7Gph4JvUb24WpOfbtMbo+CQksUgd
	 jvpsDA3mZAOKR5s9bcmEu3w+Cjx0hv2eVqrKHFl/cklEYs29rrcHSuMnapa/+rW5Ox9fc
	 LQcC9VtpTyGdgDwEwn203Gbp7Inp/GG/30kfgoqjg4NKAGtldpx57KHOJvwq2TmvViQMB
	 GmRBnv1l9E9lI+CYymBYBTXuakiTTVH5/nCS6ir7QgG6wLuWAC2ENRLFIYsJHBXfnoNwj
	 szQGC5yU0nGaGi6rwX4B7Qf7tOW9nYp3aizOFqwcRwVjepFYlIRmvJ/MdwbxQem5ccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1ADfswGVxohj7MztiMYH5hOPTibA0w5eZMckRPKzLHk=;
	b=X44sg4FYYNboL5bm3N9txV8MOiDJm+IFKs/u43SL1THa38k8et1lk3+jPOhm++WxFTQq
	 sFRQma5OL9QFjklgMzUJG6v8b5tUb8OtASGODDVLtm/xeu1XJ2lLTDYWaAAQ6htZ3emXy
	 JguCRC71Xfk5idSbNp+0cTaJsim507hNgKobqEoIGXV9eBDKDp80s1Cha6BGu1cJqsCUm
	 ojUGPP6Kfn2COsOlfYnTkathtq2GI00P7hPB4kmHm1BD5/VZW6VhBDMf5rnuJJZXZ5bbi
	 pdA0/UYmk46liqSxIA7f1Tfyqnd7z6xE3JSf9U/czJjbi44/HAkXpTJxUVzdSz2ypeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhsUJ1VJ;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA7606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DA7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhsUJ1VJ
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so1972365e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153714; x=1793758514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ADfswGVxohj7MztiMYH5hOPTibA0w5eZMckRPKzLHk=;
        b=RhsUJ1VJny+XpygUe0N18+77DW9zZs+S6DXJBMOzEfWlkFgSN2AiY9c0fBggpQYMZq
         MsVOusgPt8IxW5q+HcvVkOa7Tzmr+mFw9Wh0QpN3qczyUd+cpoWFB2EQfuNipo8AoinS
         d3Wbsb/HzfFtvyH/Ey3DQ93h5fiNBjtbVhIPjRfj51qOHdwJrhW9kUG3mor/xvbpiw1/
         xh1Tgd6uBIptqzq8gWCIV4tj0J2SkEv3YCi0ovwFlBvwRyLRYZHWDuywIkrf1w0Cv2yR
         udIxvom+A/K5AB5aJOsoiCQ2iF80qyGMnBKQM3X/BJqU5Qh3hjhtPRiXjU1db5Yhf71r
         WO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153714; x=1793758514;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ADfswGVxohj7MztiMYH5hOPTibA0w5eZMckRPKzLHk=;
        b=RxeimHsk/NxRy2mQHkBQReWju4jlLGsTnWpK2fkJD//esFeGzSld9sAJvLZzPEjlNA
         IjiLt2quTERKjwExGjQaqA4e1L/POFcace+6vac5WgB3pLU1oVE5BnQSW9I+pT8oQ30k
         +Y36GtdJzr9AgV06MbUNwm4IULKQGfJyoYRCI/JxI0xakSd2qah+LG1mnLysjm1/CbHE
         nFv5zhhXLDQZYcVs/mTuc40PNnRM0VUFBopUmXVPolwJg3pCB+33EfpnrJwpTnxDD9iI
         /gQh3+ulmxpN8dQZZM5MtVWD7ajXQt6cqU4oGaP/KVBl7r1g4/ZGWv71HZJ+WpgiVSum
         PXqA==
X-Gm-Message-State: AFq9FYKa6Zymj83uD8X5GcPhrdgeMYdR64Makzt20rik/iId0n9086Nv
	Bv0URiiv/k1hwWoPbG9SD1ipXRFOeN1cP2yrwyZ8Rk0HH5gw7oX7gKmuIvtAc8tf
X-Gm-Gg: AYBFou3om1PjsR8dyAmyCGcSFz0S1hjr8bWx7n4jLr+6rHxzaSbj7rYdhWadB1Wtcwc
	xR9F5oq12q1c6KKzM//EjScecUlEhgFrNParnVokZpBL+nmkY75/31J1TKgOtFlei45Bpum3wmT
	ZG6Uiof1uEaGhIAvJN/qznTLhBy2Xq/HL5/WfzOOWun9BQmucNL+eban+Prj19tdrM/CAhfLGZ4
	adJGm7mBy1eiSOHwIH86bJdxadAv5KyqIBID0GzbaInHLh/tKK2anSTFPnH65q75qmmEcSyUvB8
	icXjYAooSu5NhM5IgkBOuBXSVlZEPu+sTIl8H73KrXKSm7oFnXu4LWT63J06KHC6veM4ltVMpNF
	9wegE47mKbKGGKseziipMxJmSs5NlKgquPjjM4RaLB60NQN2D2pRZYi8sMtDqZzasYXOoCueEfF
	WUGtN8PhdC2l6T7Fkz0cPMo1cD4dWFUlnMmzKxg0AWLkCQHSRU+Kwmrm+KeKpWqPhPv0c8ERruD
	i76cqgZLagm8PJFzHk8VFefvNae5vAeiVc0zoeaKVh/Lrq/CFe9sfgkh0qbSQZBFv9qmnWS7HM3
	VYj4fKSwiRPIPZNFfC8MDW4f1uZrj65dIasGYsttuXRCjLiuVxzvUGor6yzlykwR8CQfoyFdMyM
	pNK2K9nVMT+y1Ba9xwV7eAlbGisap2BMeKWl3JFcYm/YZiHvUGwDDseIsFjsyZx5zntyo
X-Received: by 2002:a05:600c:19c8:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4a966c418a2mr16252535e9.17.1793153714136;
        Tue, 27 Oct 2026 19:15:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb40733sm20105198f8f.0.2026.10.27.19.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 04/11] bpf: Give the inlined bpf_loop a pad
Date: Wed, 28 Oct 2026 03:15:12 +0100
Message-ID: <20261028021512.1203900-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187304@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <a9599f7ed1c7bbb5109d2a9e2c7135af15045738.1793147364.git.memxor@gmail.com> <sashiko-outbox-187304@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:10 AM CET, sashiko-bot wrote:
> [...]
> [Severity: High]
> Can this leave a live BPF_JMP32_A instruction targeting a dead caller landing
> pad that gets removed by bpf_opt_remove_dead_code(), leading to an
> out-of-bounds read in addrs[] or ctx->offset[] during JIT compilation?

Right: the pad of the caller is dead with a loop of no rounds, or with
an unwind_exit on a path the verifier never took, and the jump of the
inlined pad was left pointing into what the removal of dead code took
away. KASAN sees do_jit() read addrs[] past the end. The next version
gives the inlined loop a pad only when the verifier saw the pad of the
caller, with a test for the loop of no rounds.

> [...]
> [Severity: High]
> What happens if bpf_is_unwind_goto(&new_prog->insnsi[position + cnt]) is true,
> but pad is false (for example, when
> env->subprog_info[callback_subprogno].can_unwind is false, or when the
> caller's landing pad was not reached from this call site)?

The unwind_goto after the call becomes a no-op jump either way in the
next version, so it never follows the last insn of the loop.

> [...]

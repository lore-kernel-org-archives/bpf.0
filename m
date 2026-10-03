Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BC3BB115
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791030316; cv=none; b=fih+l00qCNhfBja9NADUNGQSlw0pwOl+PdRYiWkuRhwei9Be1EJwE3eWN0oA2iH7wnbbk5rczRdg18d70lgWYLjdGl9RIRL4LCbqAQ9O/EI1QWp72CuiWnkvhMqX2r525xfGqNoKRE/BawJHBB0cDhfTm5FOBmJ7chw3KKJPNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791030316; c=relaxed/simple;
	bh=+A3GNE7tqsZv28HzhpDiCNnRgOXTT9CDZ6zP/UL3BrI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=XoH6LsSpDVnll+trJE43LpOU7cnwyX/9/SjfjUqs5g/qPnAogfRnY2BQxO6vC9Z0igqw6qYM935PnSsPgRaAPvlhEGOPMX1D6FTDMiOIv1SsO6vRP9LzNlBQtPDCHZuHEDzcfmJ9vHc3hAoRoU2ionmCIKXKUgx6V5AqKub8ZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBWo3xu9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBWo3xu9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso226608a91.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791030314; x=1791635114; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXj6V61bBD5Ef+DtOgzHOBWIm7fZBlMSJaIw1fQhzrc=;
        b=NBWo3xu9bXKWaxsFO9NpEhjjCoXzlRavRw1Dv9BJGHLNEAWtJclPPqAce5PwlnFf3O
         8hgXlDffbhOZxZ3XZ0aNtm3A8lRAbKRdG0DBdwQX1NUKXUy32QOv4qk3YjjIzKcdEehh
         zIl3l4LwzUmSznYBqM8nVaMgeqkikl7BAUApYqCs0ciD/OCL3z1ljS6kqTR8otbDMSIM
         viPr31o3doBg3jOeXea6SenB3vi04L0xml6tuoBGvDjWKvoPjmcs4hoxnd2+NicPjxVU
         AxFFBzNyr0We7smpKHnBAXpHZe4SDRqtnqrfGZEkVT90Nk2Fs3l16wSZA6hIeVCy9Bn0
         iQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791030314; x=1791635114;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXj6V61bBD5Ef+DtOgzHOBWIm7fZBlMSJaIw1fQhzrc=;
        b=zGtjCJG8pYoIzLyQcv/YI3zAooj04jVJDakSt2bXECKRj68d4EEEoCAoAh9oNJX5Ge
         PQsXniFsfhvbunqnAud9KK5IvPuFP6cV7TLOlWI3ihv1VZBACAoKB9U7a7lIRSDelY/n
         Ufru6AFOdBSn6mpdVyGij2kFC3zrDQjOAWuntW82S6uOgTnCzsFiphBYkQbrjWrGonK0
         ICaXvcaOIaZer0GB8LPFrzY5O9oSDQ/O80I0l36kZRQb0hpBhCVfSufV7gKNYGtbnl7m
         ER2cIDOXutPDF/ksw7nM/7uPfY4dikFeXowXPiVFVHy2drfLBEssZiom1xNSXszX+DOs
         o15g==
X-Forwarded-Encrypted: i=1; AKwUvBxiyKhA+TLrmlbi/SrCxAh9EMQp1pYFufYgjvzZHg6emEE60Ve4oUszPsi+kxiAGz4BkHY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVAdW+sWV7htL4to1vChwQf0vFaif4d6EDnwlmHeqzrcSK3fRg
	93eJ8JwB4yCVBzJxmGf90Tmxucwwx5661u6RwsFoM8AcqShe0riaPD3m
X-Gm-Gg: AYBFou2Y9iym6VNIALk0iy7ejFbMTgbVNQCR1o4gBXYmz7DfPPxBaHj6EG4431nJDYg
	XWn9aMs+XmnOpgglLP7utTG8m3aJCJ6gSxIclQ7ArRWv3GkoWFGzTFzSs4r+Q+HU/n2XYaEVomk
	oeLIRxB0kMsmGI6Len8Pvk8tjzSZHltVDQ/eV1eM5ZNbu0wsZjOyJpWjJs+JAKFciRkxdISNgbp
	XI6HnJPm1lLZSBnDdUUZ1vIn5+vPXgyrUnM0DxcaScEP7eKO2P1v1IR3cBpqdcatXrdGQdwQw92
	Hxvh/5vWDZKKXv5f7ZgebRbdlCTG5fd2f+1IJjXFkt/SIcb79ECA1SXVWE1h+1O90yRJ5VSQXnT
	ZOgSwZbKftEPHY94/pDQVeWvTy5YytDYLEliuEvdG8Dh7UponLxAzVU7pMAm+rOuhSmcWbCP5WZ
	oPqlFYytusDPUFnstfgy328fQsHS2eGCjBuZIR9VK8fxrUBFDYKuCXTGd9zSdir/7iEmufG2JCQ
	xkwNCpDf1jMh8Y7bVy5cwCKenWnE7Wdp4eokfz0KrM76NvYNcZSN9PIKYHxMo89ekKnQbEZuNTV
	tyI=
X-Received: by 2002:a17:90b:528d:b0:3a2:af98:3c58 with SMTP id 98e67ed59e1d1-3a6ce10ed09mr4888497a91.0.1791030314181;
        Sat, 03 Oct 2026 05:25:14 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d7cdb31sm2735160a91.16.2026.10.03.05.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:25:13 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:25:13 +0000
Message-Id: <DLV79B84WZW4.BP3KA640VKGX@gmail.com>
Subject: Re: [PATCH bpf-next v8 08/22] bpf: Require an unwind to leave a
 frame holding what it entered with
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
In-Reply-To: <20261001133047.1339752-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev> <20261001133047.1339752-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 06:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> frame that dropped it. The rule does refuse a program that could be proved
> safe, a callee releasing its caller's reference and a caller's pad that
> relies on that, but compiled code does not do that. A pad only knows about
> its own frame.

Compiled code does exactly that. It's a move.

  fn consume(rec: Record) { may_panic(); }
  fn foo() { let rec = reserve(); consume(rec); }

consume() owns rec, so the pad of consume() drops it.
foo() has nothing left to drop and rustc emits a plain call with no
record over it.
'call consume' is refused with
"an unwind through this call keeps the reference".
With a record over that call the resume in consume() is refused with
"a resume does not leave the frame's references as it found it".
pad_drops_caller_ref_frame() in patch 19 is what consume() compiles to.
RcuReadGuard passed by value is the same.

[...]

> +	u32 entry_active_locks;
> +	u32 entry_preempt_locks;
> +	u32 entry_rcu_locks;
> +	u32 entry_irq_id;
> +	u32 entry_id_gen;
> +	u32 entry_acquired_refs;

The verifier doesn't need them anymore.
"Unreleased reference id=%d alloc_insn=%d" at exit already points
at the insn that acquired it.
Drop this patch.

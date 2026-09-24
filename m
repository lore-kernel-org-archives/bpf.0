Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9804C752C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284345; cv=none; b=pnTHfhb8tTailcQ8nsv6bUa/TtlkKcuFKgbP/L5qKUKRRw2fmVUh33nPaTmLGArG8l9wr12P0/J+cd8Em5394QCCyBswfT3grQ4S1KIddcbhznyT3F61T8p5OIT/CAXPAzhccbqTeXxloVGvaNOEXJMpblQk4ZBB+wBjkHOKKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284345; c=relaxed/simple;
	bh=gVNVbBsRznz3A2Gfj57BQdToRq2BITe8v2URhJXSyqA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=NbPFJFy/hfGoc9pMsuUKi6Iu/G6NbfJuzaqIXuQyXzkKqcDDzYjHA3gL9HcfvBvj0VKT9wi6h7JivQ8g1TC0ITC1sZUbcrY/XXNFsHC89dA3/3DrNdZbWxNKL5cUY52+V6EmzUwV3OjYzh0hp6FDBHzQNLdChq0Hm8DkS8cy2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmRSMe2D; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmRSMe2D"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87fd84c0bfeso176797b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790284344; x=1790889144; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZYDCkInBMxhi6cn8XFTtjGVuGCg9xHYumkN5mTF/ItA=;
        b=ZmRSMe2D9Fi6ef7xo/+ycrovcn2ksSHjxyiLJCak9C73HjbFxYHSL3I/cWbvOjcRpR
         szYxoYNcPFsX13QlGURjhK0ByNKTxzEWFtfu7oM1be0hCEED290vdrTYmIwSibD1HLfk
         jbuPjj/AoLHh4r47eFGpghPf8a/MCjessf/VaLL3/KIufoO2R9pbrRyBYJlm6VEajEF5
         /cL9BV7J5QHBtsEMrsGw02LqMPCmfMh6bJ07tkB2LggNdHVY+6bBoNg2nTyS1JMSq5Rh
         7r4H0MmNBCsGMu4bjPWlqaBK4MSPkffhYiTuEh3Vvc40K7gTyCkuAVEqCEbNjGw+OHMx
         Vr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284344; x=1790889144;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYDCkInBMxhi6cn8XFTtjGVuGCg9xHYumkN5mTF/ItA=;
        b=hNXExFXXK//Js6LeShqYYgWXqj/qih9JCdGxecg95ts3cDOa9WFM+o3MUfhTY35oz7
         EguXAf5bXDfL7kH1KWNrMOg3CV9uHgCr+8342w0rydMEBQG/X+YfGFdC6hDT+PhG/q0y
         n1TumLFp12XrnGjJKDb5E5P6G5XdDNE3Vs5fWI6ty+qGIpEWIuxKTVXKumBFJ4Yigc6y
         cmmD6RT9GUvpLKR1349wK3wlrzyTIHOS/fAxE8RtmOPfg6qvtOmx05CDq6LIAyNHBf5P
         e3dzZI01YlEsPc7TeKRtxIlv7+WMJ+57f3KnAwBJjoDSvRSBxHC6hEc+RHjWxJqofD3n
         dRJg==
X-Forwarded-Encrypted: i=1; AKwUvBxagIMGSwxQLDzmqXIg34uiGSPKhttYlj4dgbNfqhUF5C8uqcirLCu4RzP210GaxgPK9Ho=@vger.kernel.org
X-Gm-Message-State: AFuF++nHJmlQCCfY7vCtBUFeYeOQ/mWAm3vzZlJo4lwfMGjnjsqrODOD
	S6Qu0I2pnmTX/Un+VfeBCwEtYYnYlWZAJPDuog3zkvoBlhGCQA9baBI6
X-Gm-Gg: AYBFou2zvmc7gYqLYfB9nbc2POgq52xlEJKIA4/9lbQl9vN+T9P24Abuy3OGxQoB6ju
	CJo5gtXuisgMHbQDCtg6mVSfSHqXzfihjKTsyeZwqE0LpsUGwQuAx5Zm6AENECQZmDMbn9y1P5+
	P36QZu4B768ejz8qycbCxhkZ9Jkp6NebkQHkzSWPptM1d7QV0FMLaafHdZF0f+/B46yfrBgTHRq
	2yae+PN4ioDwGAM4RzIS2Z9lI+rVqVDkHClD4ow1knYjVrsRTW/kG2pZWYovj358eZp5SDpl0i6
	+RbrIXMZHxLVQqwNVxJMDuHjCd/KffyPBHIH5aZ0pvP7Ao3+ZjYZ171G53lHeGcjJqgXLPJR5YI
	tHmXozcLGILUuKG7FaiaeGTevijr4/d8BPaF6sro8xi9ILpfZiLqffxpwrtnP4vy/MYL/lv427M
	BXfoPqYCifQlVnBRMQGF7MXtUnX8c3p3+x85zKh6izMlmyPVmNsleChrgCUvybbhoIrKskhsnig
	+gt9eq9G6J1wFsoFRSrWECXNpYcuozPFEZ25CJZsCxYkqIDYsdUWFSy448AzWairSrMVNQ+zDEt
	53ux
X-Received: by 2002:a05:6a00:92a3:b0:878:34d7:6995 with SMTP id d2e1a72fcca58-87e9acf09cdmr3363037b3a.37.1790284343641;
        Thu, 24 Sep 2026 14:12:23 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea884749sm179605b3a.27.2026.09.24.14.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:12:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 21:12:22 +0000
Message-Id: <DLNUU0R42VG1.3P1RX5FK30FZU@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: Read program streams through
 file descriptors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260924162641.1922423-5-memxor@gmail.com>
References: <20260924162641.1922423-1-memxor@gmail.com> <20260924162641.1922423-5-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 06:26 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> Use bpf_prog_stream_open() in its default blocking mode when following a
> program stream. This lets bpftool wait for later output instead of exiting
> as soon as it drains the currently buffered bytes. Flush each chunk as it
> arrives so redirected output is not held in stdio buffers while the next
> read blocks.

So the same 'bpftool prog tracelog stderr PROG' prints what is buffered
and exits on old kernels and doesn't return on new ones while the prog
is loaded. Scripts that dump the stream will hang.
Probably should be opt-in?

[...]

> +	while (!stream_stop) {
> +		ret = read(fd, buf, sizeof(buf));

A signal that arrives after the stream_stop check and before read()
blocks only sets the flag. read() then sleeps until the next print or
the next signal.
exit_tracelog() calls exit(0) from the handler.
can we do the same here ?
Then stream_stop and save/restore of old[] are not needed.

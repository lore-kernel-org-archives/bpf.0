Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1025A645
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117507; cv=none; b=TyYcjcoWAXkNuBtDls43Ek+zoCKudGk9MVcUw2qUguEyAVNzUNPfErQRL4SLhbPfeesOhgF8jXM7S/IWswKpSDnUjL/7wDX6DVE7pKT+CLVU0B7zwPVIbJof2DPe0lePyD7G2Z8eD6mO8edfw1aIRe0P6RlNUypP4FdjA/SZxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117507; c=relaxed/simple;
	bh=AyterXBWCVPT7LWW00QKlA6CPhNcYODV1naWiLjndBQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=pJtNck3+zDlal44YcUkK2WQv03mAZ1hfAXnjRd8PArnKM5vQg8b75sFaTrld8aFFz0HHH/U7T5LrXaw55VfkmHEI3E3oRh28HIl4ENN+4YksfOeV7YFcihY+JUSG+zbFUrSVXmTvHalbuC5Tvs2u9wpdhcpzb0f49pvUH73SDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B40vBSux; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B40vBSux"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acd4850f40so37250a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117506; x=1792722306; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AyterXBWCVPT7LWW00QKlA6CPhNcYODV1naWiLjndBQ=;
        b=B40vBSuxAFki8+Spad1RLfyc/QjPdjaxKElIcAdNibS7LRYBDImoHBdazG5G/riGOx
         5QZ3kGoQB/wDKLliVDrH0/lpbguuXVJkI4cvn8TSJa5eV8SDBhqTKu1r7Egoj7uXf2hZ
         zf7kgGl9QtN6slSsuv1RnlI84Wb632Myp6oxKSYglhH3w48OGD918EzuyromyvOGl/bX
         +NeavTIP9LpUR4gQfTEuGPwKTltU7RbbrofiBVfoV8hyy62rf5UGkTglzbDciam/SZUF
         1aYQS9m7WdZ0Qir9tgpp3A1Vadw+baFhIlCWD4x/MjK2ZseH0IPFUKy6nVwJz/euGGtH
         3iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117506; x=1792722306;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AyterXBWCVPT7LWW00QKlA6CPhNcYODV1naWiLjndBQ=;
        b=PwdAhP35pmkZ9DaRkLMxtXKrS6kAQzh8kzmYU8zVW9Xo7yZ7Ig5VSOwZIvIcy3PYf4
         QAyBdofXVX29g41TC7eGx+hCo9TsPkWKDiqfKeQgbpJAe82HzuWzvh/JTjY+8WC+BKOu
         Dd96o/UeJRPNe+VoiNrn+WSG3wDGt5BekXF+muIOZnaqKMuH9ckaaaB4M6TjECACvspo
         oGhz1PQ2kqhtA4nP8Lp1L82oJQOaPQO4zPlm9Yi2Rq3rNM3lPsjKANKnBThtTFdu8H0+
         bdqJpXn/VBqrv7cbU+hwo35doHNbNdLty/ObffDbvwMWtb2/lhhmL/JFGefF1KY8uwAv
         wzCA==
X-Forwarded-Encrypted: i=1; AKwUvByJLsxT24cH4QZI77jHhqqCzX5IqBDbcEVteyeTA0eXYWpA20Wy6038p2lcWYlv2URJbqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7SuZ9FIuNInZbrSx+zlNxD7/jyRKQ+RH1moaNfWuTt6JDych+
	Mpuuh/Z3TKN1yijvqBlemgQLIlqOQB7oUqVBPmVKapuUTvmNEUF7Vbpj
X-Gm-Gg: AYBFou06d8USz1v9FsX8KRkU50xBlgKRWfJlatnyClJX7lIi/CA/aSjFjcmVSuoul1H
	aidMLMgnLQSxgFiskOGWnZHEVpjcXHLzMOcQtnmakuvIUqyHqoP8Wr2/IQgW7bXHyySuq+SqNp7
	KJZ+0V69J0Uk9DUG79iPI6lGUw85PZxl3Uq+QkRjO4tVgI22cWiRvumA1XgN0S+ipDH21gklGcK
	cjDA0DiwqobtohayMajxBAW4/tBDw0h+4C4t45tHSscfRwqNjId0LGvXkTEFtGAjLVk9FYBVllg
	nKon1COJiVwpFH0DHrrhuyUNwF7GO/CKRmlqGwbqBBsZXSoHoohnCBxJ+jD6tCSaUtbgNma1YFD
	Jq1kFgI47h3WDY+4CZVo3Cl19zdw2ag2F5jCoNWIHsHQhbRV4CftAR6MqzcalWkQjQzkbvr6Es1
	NhuT9qryJydczkvGU6C7AwPEsD16bW+hXmLwkmwiSO0vde/bdEgMS/MgRI34RO9xegZ9dnkb2m0
	T0/JJ93Ia3l+LgzGHvX6fQJLk3uftDTiAl8yRWLhl5aZ1srAb5XqXJ283LFMKKMwSf33JjvBPxN
	jTI=
X-Received: by 2002:a17:90b:1d4f:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3ab3a955988mr17668032a91.31.1792117505849;
        Thu, 15 Oct 2026 19:25:05 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc496f4basm1717174a91.14.2026.10.15.19.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:25:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:25:04 +0000
Message-Id: <DM5WMW2M6YYO.2X4FN4OPSQGJH@gmail.com>
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <martin.lau@kernel.org>, <kafai.wan@linux.dev>,
 <yhs@fb.com>, <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] bpf: reject unsafe pointers in TCP congestion
 control access
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhiling Zou" <zhilinz@nebusec.ai>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
In-Reply-To: <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
References: <cover.1791978740.git.zhilinz@nebusec.ai> <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 07:57 PM Zhiling Zou <zhilinz@nebusec.ai> wrote:
> bpf_tcp_ca_btf_struct_access() authorizes writes based on the BTF type
> and member offset, but does not check pointer modifiers. A BPF program
> can use bpf_rdonly_cast() to create an untrusted tcp_sock pointer and
> write through an allowlisted member, bypassing the read-only cast.

Not anymore. It was fixed in July. See
commit ac65c710cc64 ("bpf: Reject writes through untrusted BTF pointers")
and the follow up
commit ee9ad135b208 ("bpf: Reject a store through a fault prone pointer").
check_ptr_to_btf_access() rejects such store with
"only read is supported" before it calls any btf_struct_access callback.
progs/tcp_ca_untrusted_btf_write.c is the same prog as your PoC.
All of that is in 7.3-rc1, so net tree has it and this hunk is dead code.

The splat in the cover letter is from 6.12.95.
6.18.y and 7.2.y have ac65c710cc64. 6.12.y and 6.6.y don't.
nf_conn, sched_ext and hid-bpf callbacks in 6.12.y have the same issue,
so patching tcp_ca alone doesn't help there either.
Pls send the backport of ac65c710cc64 to stable instead.

pw-bot: cr

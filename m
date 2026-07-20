Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30B43F08A;
	Mon, 20 Jul 2026 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534566; cv=none; b=Q4mVBZcrvjVEcUH1YPiwiInnUt7nmdEEyOjlfO98bodeD3nyNjs2XSW1U7Bez7Z7Xuw5TQYN6nreKbvFfJ1hQuBJ2K2FOZK2CfkDHje+bC8LZCfYN0OO0LvW4E/8gJMrX2p2kq5omlwD0N1cOndUt1KM0/+Ekj44ugHOd2KAXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534566; c=relaxed/simple;
	bh=ktP/o3hQL++zbVHiKWX6v+B+j5okLRdU8+h7oSQ0O9U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SSjz3YDzISImPbpf1CrftaGr5CvrOksOitOpBP/qP4RgkwZvrhTv7dTMmfpViGJiRBX0wtlgaUKXJz2/y3xzVSCS0gL8/vjhiR4ZcuZmkbA8kBitDeYtFUO9STzT1gPGVfk+H2/mryC7ZV3ydP0XuM0KvSkw3nP+omtn1QS27Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw4eKuet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw4eKuet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F01F000E9;
	Mon, 20 Jul 2026 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784534565;
	bh=LcSvdhVAGbIOmq2XKsNJeHRCtsye58Dvydmli2o/2Ng=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cw4eKuetEuLh7AkKn3ggKm4U8ZsGf0dmD9NlQytSUaNsQR+CAa+kmYx3rTx8MdfPP
	 b/JHsghMsGXiCEv+FRmm0ScF8YHQNVJfaY3H3N0IEA5ppquJh5MdBNxY0uQtTz6Ojj
	 FgLuj7wTRVPQpRIrv0SOI6W9vmXWKwByWBQ4ZljJBeopucQtvsUJB62nyVQwunkmwm
	 afFq6SCD7impC7mI+A3tu6Kj8c199RVxwLrDDmpR4+Vgkg+sY+ydXGEK0VgEkVSt5k
	 DhaNIR1yhXKvZJdok2FvMnYX//kZvzMsshcg6wI731Q6VIIhXv63td33gXlk6rhj9G
	 KgwZ5wZilJlfg==
Content-Type: multipart/mixed; boundary="===============5307019956216830180=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4054b8846ea1b4cc0b2f5865891fd4add21499034aeb66adcd9e2fddf16cae83@mail.kernel.org>
In-Reply-To: <20260720071520.396363-1-jiayuan.chen@linux.dev>
References: <20260720071520.396363-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v1] bpftool: Skip prog/map that disappears while looking it up by name
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,qmo@kernel.org,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Jul 2026 08:02:45 +0000 (UTC)

--===============5307019956216830180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 084a91fc9c087ee9f5a2163da8368590cad6f121
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
>     bpftool: Skip prog/map that disappears while looking it up by name
>
>     Looking up a prog or map by name walks the whole id space. There is a
>     window between bpf_prog_get_next_id()/bpf_map_get_next_id() and getting
>     an fd for that id in which an unrelated object can be freed, and the
>     lookup then fails with ENOENT and aborts the whole command.
>
>     Skip such ids and keep walking, the same way do_show() already does.
>
>     Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This looks like a bug fix for the prog/map lookup functions. Should this
include:

  Fixes: a479b8ce4ed1 ("tools/bpftool: Move map/prog parsing logic into common")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29725108152
--===============5307019956216830180==--

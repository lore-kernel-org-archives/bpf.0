Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28B49DBAC
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305826; cv=none; b=Sh/ivVNAx3cKfHqU50QW58wVesqAazYopL3uxNyZh/DHBs8+PIwqvnCC9WZaRGWFS9q1Q/kbi9yS1yb1EjnJtDmdv62Ls6uP8CTFHXgQOH+NwU4K0YiKKlYVktTrqwabusB5Z9d/LS2/9U4XGT1kKtNUaAu5thQxmaMJgLPTDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305826; c=relaxed/simple;
	bh=2iJo9WF5vaqoUN6UGjOx69LFPjrRXH6eZvTQxfvbTOY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=V//sVqIRohc9VTf2JMuqV0HjWFULWXtrgd1cTQ8N3Y1lsa4Z1ZqZaCOIo1ZsZT7IBZVQc/j3whoPMCt2uBo5+tDIuarRmd5x4gug4xTgj9SsaHZLyUj2xwYcxtAP+jtWLNr78y/K1eBISkSxUOqef6kTlcbffmVXam2kmH2/T0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkcWGbKG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkcWGbKG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-884062f3296so562010b3a.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791305824; x=1791910624; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iJo9WF5vaqoUN6UGjOx69LFPjrRXH6eZvTQxfvbTOY=;
        b=UkcWGbKG+ili90+PMqAHg/RNm8HBm+PCxSGbfIpGyfTcTES7VOnDW53seNzNnjhlF+
         +ORQ6IMH0585mlEmkklqAtRSEjjFn2Z7YZBxYIEU5gh10etMZ8NygiPyLX90A3VMdtzO
         5rKWuM9AwRP7QDnIytvrWfx9ITTVLtB4a8GUOxJrgqaQRhuhhvAcFhQeuJgo42iFmPYS
         bDxBinSPyBF2DraKTXwBXawurW98jZ6sCWTb9lsxtVeNhGZuzJdgzigy9GWL+2XfnHKR
         /FrgzZfyfAuyVYHrue4Hr9qrZCC+rSrQEDdRMhDhmFLiXs2pXmfyUfJzxDkr/mpMdmHy
         jyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791305824; x=1791910624;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iJo9WF5vaqoUN6UGjOx69LFPjrRXH6eZvTQxfvbTOY=;
        b=rK/jcCAjFMv5GFgCVwogGWGie7v+yNTwRDsNdJXtOeglAQ8Aqds4egs3wcqus49YoT
         2toto+ADxGTZ1FcZ01GIzSqUHvWwL15XmD797ARpmlbVCLuxDviKBjPmjEBxUcBsPQi9
         h9Ao/jkrXtSO8QAmrL6I+KMpgipe2LMxQiKpGsNzH8CvA/h87Ziq9Jhw6ysy+ik2CXg8
         Bw9lFLfGOQJ3vdT/EkBOYzIWfrRnPGEkvs7AEaD2MCkuxQKt+iFo6T1fikhTO0GV5ntd
         Z76V/uh65gqP/kvOh9ff4bH3O718W4Fw9jL8etarofGChFP5ZbEdpioPb67hFPRq/W9t
         kTQg==
X-Gm-Message-State: AFuF++mLOGPxLv7bMMY38eLEZj/kQVDxDWMACgJ5wFPoaOe+8ylbWcAW
	8zxqMUbukbFcjWZPsx+3tetflbzS92hyCuyYXtDBt2nAagKqVVYbG/ku
X-Gm-Gg: AYBFou3J8AkBHphcFJhGTxPKClWl+6JdrPtd9CFit0JNuSnWCPgolPHrT9no+izOQJ5
	nNP7YX0XSGGGOs2QR5pr8r6bk3DlyLp2uYPuAbL9JXlqktyC/zaqbNqiz73X9xyw70uVMGaAdOf
	o592WG+F7S6YYNwoaHZfGK7EQp6IS+2/dL9v8f2s2DvEhgJmErLzHvwAArTNIHKcgj+Z922JbLq
	jAxZrW/bS9pi+fYKc9uyP8F9ZETUeRKaygCSw5oG+Bda5/K8lPteBgyxtHe5VfekZF25dADJJuz
	hGo8nYo8sX+ByrnQiEoWPht5gRIRGrcEzbVaEGxmSkg6Qi0UUakzo3VkbouyOi9yvXG/Qi5NP0H
	FAlOGoyBjSwWJYxVYygxyKPOKSOh8MMHCojqBypw43DMeGCkB6hOaMT3YIEesbV4Rx2TPwR069m
	m1/hQ5QFQf1mnsKxf2izOlvUQgA7V3BZw1mgD4gPOq3g+hUPIcieR4UW3pnzRaiuoZjkziwhhB6
	/LU/WtGj62wtaEHJAMmUFsXmWMjtftu2tvJsrvlFKN7Z70HAkwvGn0KFUE3PlABvXgdRQ6JpiFt
	C/vU
X-Received: by 2002:a05:6a00:3e03:b0:890:a777:1026 with SMTP id d2e1a72fcca58-890d8a4c09bmr1654501b3a.0.1791305824461;
        Tue, 06 Oct 2026 09:57:04 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89186ba2d17sm325252b3a.1.2026.10.06.09.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:57:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 16:57:03 +0000
Message-Id: <DLXWX2PFUOQA.2INDMK72TFKUF@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Amery Hung" <ameryhung@gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Reject bare pointer for __arg_trusted
 arg
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261006-a3-arg-trusted-v4-v3-0-4619daf30e1c@mails.tsinghua.edu.cn>
References: <20261006-a3-arg-trusted-v4-v3-0-4619daf30e1c@mails.tsinghua.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 06, 2026 at 04:06 PM Yiyang Chen <chenyy23@mails.tsinghua.edu.cn> wrote:
> Reject the bare pointer while preserving referenced, trusted, and
> RCU-protected arguments. The latter is used by sched-ext programs that pass
> the result of an RCU-protected kfunc through trusted-and-nullable global
> subprogram arguments.

Which programs?
veristat-scx failed on v2. The only one I see in scx repo is
cake_wake_place() in scx_cake. It takes the result of scx_bpf_cpu_curr()
as __arg_trusted __arg_nullable.
That arg was added two weeks ago. The last scx release doesn't have it.
On kernels without the kfunc cake_wake_place() already reads curr
by itself. Pls send a fix to scx instead.

rcu_ptr_ is not trusted. The refcount can be zero.
The callee sees trusted_ptr_ and can pass it to a kfunc that is not KF_RCU.
bpf_cpumask_acquire() does plain refcount_inc().
With rcu_ptr_bpf_cpumask loaded from a map it increments from zero
and the prog holds a reference to a cpumask that is freed after GP.
Commit e2b3c4ff5d18 says
"only PTR_TRUSTED flavor of PTR_TO_BTF_ID is supported".
v2 was right to reject it. Add the above to the commit log.

> This series targets bpf, which uses separate global-subprogram and kfunc
> argument checkers.

That's not an answer to Amery:
https://lore.kernel.org/bpf/CAMB2axNnY5wxkTrd3_tHyXBzXYyjJUkqRb1uNbUquwTJ_FLVMg@mail.gmail.com/
The loop in btf_check_func_arg_match() is gone in bpf-next. See
commit 668a51c4ed4b ("bpf: Build argument prototypes for subprog calls").
This patch will conflict when bpf is merged into bpf-next and the fix
has to be written again in check_func_arg().
The bug is there since 6.9 and the fix rejects progs that load today.
Pls target bpf-next and do what Amery suggested.

Also 12 chars of sha in the Fixes tag.

pw-bot: cr

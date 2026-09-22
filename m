Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F23ADB97
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045746; cv=none; b=kpJNDRGNO94A9Xi50CaxBp4QYdbdYyx0vP01Bg/nv+1Mc5FAYogX4F8FGp6GoqrZygs+B2bSn2sHKov21o9T+1NCQ4BPH34ZLoMcSPbrlxxk/q6yj3zX0O3lVqXJMXToW8LVrFt2uesBYmzL8bHrZYksFcMHbcm29pq+0LajnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045746; c=relaxed/simple;
	bh=zZ92i03h79PoqHPoPizMZtZB1vNGsoBGAvRByh4VDhs=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=tx506mWTBnMMdbNDEZ+BhGq0lvV4lUnvL2HvFdYTWPVtACC+9IF07NNrd4hI3MqS50NdXSIgMFOneamqpbj4GNnGCMuG7RXh6qgF+rsi117dEnf8Att2NRQ3JwnMYyLWhEZWqeyW+1DBw5CCosA4Hkq/LWKyhhcqTB4t+Iq0EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pB8HnmLD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB8HnmLD"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so43331595ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045745; x=1790650545; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++MI7xl6ooOv2DhkzIXOJndTPTzjhMItGLHAV4OrEVs=;
        b=pB8HnmLDy8gcwezEUEhME95c9iwVQzQ3kZ9XeVGD9WMgMI7Gzi6KK60PxJBTL5zU7m
         V/LOG1T5D7/9BYG3rXv45e7dr0TA2uAIHAOYZsvc9ymGssQp3JGNlCboeNz0oplhICQz
         nLlzzLgaLxGsIH8Ey5o9IrPHerEntz3PvnsXj2iMnX354tY4YjcG4rUJ0OYGI43qnKaz
         nGevdqoZZT5YY0IlWUczkgBxnEmvUDW4FQruHlgMihbf69a+1oeRDpbCa23AJ1kNvkVQ
         tvkImrqAJE96Qce/DHCEQxheElQ1ejlbzpdD0/dYVorQsegDmcHfZ3DBYzomp40mg3YU
         6Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045745; x=1790650545;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++MI7xl6ooOv2DhkzIXOJndTPTzjhMItGLHAV4OrEVs=;
        b=hXyXU8jZ3Oyfow6hRgeV+b5WUGF/U7xmtuGi0BRoJut+8W//SyaOyh1Bqkq7b6F+XQ
         6EIn8w+GdXYEN4rS16PaSlsF3i0g4FoJ7py43DvgUulf2w7YCRcqLabIBYtJTxRR1VYk
         E63F9XTBgGrXiYtlPgYyZFjars54okl/JbBfyUkSnKCWVzEPix3BtM0DQpZjHfGcqiuv
         805u1ZUuvFBYMehcD7WwsO7S7tjwCHxwV0pydYcfY+5ppIdpBuBGweJ3GT9GIhVK7H5P
         J1NYZtaea6Yu1+AfmdujfKHC5OvgF8ZkHN/T9TS5DfKKt3EHIKhNeC7xSmowN84QoqNC
         /8qQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjvGuL+gmZQ7LEH0GHITTPViR9xioYskMlzKIFSH8bR4k0JcMqPTbqRq/GNPgY5GqvAsw=@vger.kernel.org
X-Gm-Message-State: AFuF++mHrHMWfILUydbJFwFLDWHGLR/s7/bW1/drxlpwYqLxZKxrPSyn
	lYujFD7kGE6v9uxeSNwhwSkkeZTqS8G834nVVDnXq7vGThFFotkKou2w
X-Gm-Gg: AYBFou1QZb5c/A56ZZN+2LClmmRifbuqmjAuPxGGJjKEELQhVBZup0y+wZ614AXJpLw
	k+BguIo396YFg8Jlf6/+c5Vv34CGWwmAycT6ZCCF47bRrPZVnozSG7gUDwAM14CxuON2B6jV0YK
	wbroZtX13LUjSbh6M6K4l+SGasve3I3pOy7EFBL5u+c44aqzHKbVDK+GP/24+pVHlhRPc/UfBUT
	0b66AUsjiDFt97KUPWQVWkY/H8gIUcswKWCuB66sncsM4vtewx4Y0M/34e4Mnw11L5B4w4Grqj4
	tqt/ZiGBvO5c9YfLNR+4vGtze0BC7HtA5eu+Up6eH4//RyDwU2Y+rOacJ23l2PdiYyZtptWCtfk
	Me8e4tZBrPOLUW+Ro1+Cyl0JAndvJ8Rl3Oz4AUUcK/2Id2jLkHIazwRCgcSOLOxveOddjwqBLp4
	/W0tMiZ0Vb8lxHXhheDwYoFjBYFUxm8JznJSkua2zJMhg0FxtvLmZGW+ZkRdowwv8Rh7Rn/aXTU
	jlJH21yL+kRVKYF+j3lkUhN0OEGVQN5Tj7AcZx2ze9xoE4jb6gmJz27BTmbYFtgLWv6dS6EFyIh
	4ig=
X-Received: by 2002:a17:903:1206:b0:2dd:ad74:6d11 with SMTP id d9443c01a7336-2df5b1f7399mr12118535ad.23.1790045744584;
        Mon, 21 Sep 2026 19:55:44 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d047e6fsm1712565ad.61.2026.09.21.19.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:55:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 02:55:43 +0000
Message-Id: <DLLI9A8CU7NK.2X49U7VZNC4TH@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 14/17] libbpf: Support pointers to functions in
 read-only data in light skeleton
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <4e82b1131fc982d16aca9eb5628d15b0dca1891e30c298202b291383674c4219@mail.kernel.org>
References: <20260922011323.1298619-15-alexei.starovoitov@gmail.com> <4e82b1131fc982d16aca9eb5628d15b0dca1891e30c298202b291383674c4219@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 02:01 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +	if (gen->nr_func_ptr_maps == gen->max_func_ptr_maps) {
>> +		gen->error = -EDOM; /* internal bug */
>> +		return 0;
>> +	}
>> +	map_idx = gen->nr_obj_maps + gen->nr_func_ptr_maps++;
>
> Can max_func_ptr_maps end up being too small? bpf_object_load() counts
> nr_progs using prog->autoload before calling bpf_gen__init(), but
> bpf_object_prepare() can still turn autoload ON after that point.
>
> [ ... ]
>
> bpf_object_adjust_struct_ops_autoload() enables prog->autoload if there
> are autocreated struct_ops maps that reference the program (libbpf.c around
> line 1212). This happens for SEC("?struct_ops/...") programs that start
> with autoload = false but get re-enabled during prepare.

Not a bug.
Light skeleton doesn't support struct_ops maps. 

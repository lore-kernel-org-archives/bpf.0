Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466436654C
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940236; cv=none; b=ljfj0NPyKnCKRcsjMNriaSjI4JkbdbkJRUrWN6xOdlDLN8cwp/t6fTtOQKIzrQixAfauVhylCdl5xh/klqy4k52eW4FqyeZVisj8pnSJt8dVUlbew1tJugJ4wKFmkubhyH3RVJJqhn5MD2NGonbKhWsD+5itUYKbYyySe3Eul7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940236; c=relaxed/simple;
	bh=uWTyIrw3+J2wmrV8H6/EmYwes6ol8qrMbKD1n67/RQY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=T5TJSzgdGHtfqyMzWf0BnTSWmi7aev8C8YZiyzjCWE+gxfNrXzwUWUW+bou34TlY4XrmZt0Pnd0SV2GzfB8ht1SnoEdqcDRqy0VKw1B+em0x4FPI6yLkuyDYnHLx9EiSofIwPJw6wYsRWjqrTy+lxRdj6VlqWeXn45m9o8OR6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifEq4KsZ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifEq4KsZ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so2979413a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790940235; x=1791545035; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=miimb3EraPnCYPNbdRUj3O61Jimf2dupqweL2RsvTZc=;
        b=ifEq4KsZKnik7SWXDKvrDVGC8R3p2A9qqiwep+VVFYKSa2M2SRyeCNmoXR6WTKm99q
         WKKicv8AH8ddu56Ke0+gbNCQ6SPdHBq2iOFhw3kp12+lN9V8bayP++im+hh3WqoOrur2
         SHI7R7E47bSPVrKa50u1kguG37aLGXxRFWP9cJkaHCNiP34bgsEexiNBN21l++74AM7g
         dht/mASDFI0w21UeJcFVUt9mtRDEBDsAEkbAgaWtWOXacl4x5bVgnE15F1z7FpzmgGJz
         x0jHDLtI7eDbHU813R/2FtfQWX2+PaHaif1BGpxsjXLY1CiVbqYFsxP1b3LEFX6vocDa
         W2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940235; x=1791545035;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miimb3EraPnCYPNbdRUj3O61Jimf2dupqweL2RsvTZc=;
        b=qAnI6OERz1WJ+JZYe1kTz2z67BUB7YATL766XdMqnLWhHZcJR8/648vvP6GMvTixvN
         MGy55y7gqJ0vdU2wy1f2nE1whhAzzbLXvf0TsdIxTvFOIjJjt+sH/ccIhmO16toBwH3a
         mB9INKJSNIh0UUi+2TwJb54gn8EsomNyiQ++L1JvrO1/lMSxey3+r6liBqSFheWnE+Jn
         vi4i6oSKGxlSFzXuZZAnjEqME7MEZTbv08eSuw3IbNRmQTwkJotN4XAvlq1IWC8Fql+N
         Z9wxJjYspjZR2VlBnFP6kJFSu3+TF6gT3wml4A3Ih++xLBaMCGZ0J9byaoC2gSSn/BEY
         /quw==
X-Forwarded-Encrypted: i=1; AKwUvBy0qxQvFPNblmbyEzlnlNBm7VPwviLJJXwWFYxB486vAUpV4WSf5VUaGS09qKLXU7H//F0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvV/ThRXiTIGXFrHq7xrC91EfcUWAYNSoIHrN1xRN46nHPS+Sl
	ZbRx1eLGcjPnyw6ZmwkD4pSu0SJHRsmkbzOhIb/rsSRkxmqGLBFNVz5r
X-Gm-Gg: AYBFou3tj4Ar4UXJNZWUN/bQN62HDtOMmbbNKwWNbUiAMGlCw3orKCUCvCn359sFQwm
	AAVK3/zoq1aMsLX/NKeLDt3s8gKYoXTYmWqgjJcYU8O7mL7amgdLLw1D1S8LsA3gp8x45tQjJMM
	76vlWakdjhNmKv0Eh2Nn1+WpkB/AW1b8AHYqG+QnEIWDtcLnMavOtnzdJVK3Tp5dCQ92Wsup8C/
	HZM9PfPZqiTV1hm2Q1pVQ8Zo7fXIirBwHGXgqF7XqPp6iMLroQkejo5J/OJwhI5Qt6Z+1VCI9Ai
	+jWKFvaRTFpnWDkQ6j0EaNO/D8Xcv0V+0BJK36aLTuTCD9wvr0H3YCyols16+bJ2ix8vca4P7/e
	Vx6N0DzwRMS6bAbFBXf2pht6YHEw6S0FX/Z+ZYVWYve5O2xO5kYvI6KJbrEVEDsG2+KueeIgEsR
	Gfc+5VXssNn35QMxg9WoBhP7oixd1aQLR+hMPJZBNU0VbFVYbYwhna6AuKTtnvXtgR0uszhD5mT
	N0hthft9Gy0hKHy2TOEjfbxLoiXJxv4cYAYsDUjg5WiHxngGAyXv+cnvQkso44TXGG8CpEuSzzp
	CLtV
X-Received: by 2002:a17:90a:f94e:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3a6cddd3f6cmr2178403a91.0.1790940234675;
        Fri, 02 Oct 2026 04:23:54 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f47cbd1dsm9002948a91.16.2026.10.02.04.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:23:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:23:52 +0000
Message-Id: <DLUBBSS7CLQB.13TU52TZ9UYRE@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard" <eddyz87@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>
In-Reply-To: <4fc25ca5-bd57-4df0-a8e1-cf6bb9ba2fcb@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev> <20260910164635.459558-2-vineet.gupta@linux.dev> <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com> <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev> <DLH1MDZPU5G0.228555JR34D3N@gmail.com> <76ca0a2e-dd9a-41c9-90e4-5fd3c9171172@linux.dev> <CAADnVQKKWBV+pFMAStB_-POKveeO83RiXU+VKeua3odSu-Xrmg@mail.gmail.com> <4fc25ca5-bd57-4df0-a8e1-cf6bb9ba2fcb@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 09:03 AM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> 3. I guess you are referring to the patch to convert compound id to
> broken out id + flags (5/x ) is also technically a functional change -
> due to the state comparison behavior improvement that fell out of the
> seemingly mechanical conversion and is clearly called out now. However I
> verified it in isolation (on top of 4 prior of course) and there are no
> veristat or selftest changes with it (just a cosmetic name change due to
> base_id -> id)
>
>     === VERDICT CHANGES: 0 ===
>     === total_insns:  0 changed among 1247 both-passing, 0 worse ===
>     === total_states: 0 changed among 1247 both-passing, 0 worse ===
>
>
> I presume that is what you were asking for ?

Yes.

but 1247 progs is verifier_*.bpf.o only ?
These are tiny asm tests. Pls run veristat on the rest and
scx and meta progs too.

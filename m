Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB63E638B
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042515; cv=none; b=kaS9G20h5C1NLGq7P36394ZRqYtqkRQgtelSfHE5L6g631JVVFOl2Azo2k4hJSA7Bi1H5Cc+w8hrq9s00m5bQe2MZ+Su9pLwB/MNsu5IbWx9jL9KN8xzaCu+6kUoKynNKGXIwMtVtMSF2w+KrcRYPSRR5dkAFht3Oqv82o3l3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042515; c=relaxed/simple;
	bh=oAmwGBfC1XZd5jw6fYdLWLKuIRBVQ3XIl0fIzPCuEOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MZdvGq6B1MzChYFViH/Cj53ShevIGb/oIuObmCeFZbAReYkfIWTHuoOdvMQ3xm5pmdj0Qh7KRT3ZVdznyUsMd40td6x6paIYeDxbRQPK6aeuKo/GGIAbRuFcTxBuPmhgjvxQ0s2SipuJbiOeI8OzbtRkGBGefPVdDKcdHxa0jcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqvjGZPu; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqvjGZPu"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43d2ff651f2so4925436fac.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781042513; x=1781647313; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAmwGBfC1XZd5jw6fYdLWLKuIRBVQ3XIl0fIzPCuEOw=;
        b=QqvjGZPuwaWmb4H9PjRIDJrIjwN37tI6F2S40bdpEZH1Vlk+VEacTkkz/Hislaexrg
         H5q8UXPiv2nF8Aas3IoYwap/YdVK22rwWQOqurxht5RAD5URxroMY3/9latcIye+WWGo
         Q40iLrpdKb7ap7A0eBHf3LdB0FIldZFWqBYxbcmDMCwwQCku3zdhBQbSuivqU8gPMCOe
         nixvfqN10xGJuKK5HXMezBEwS6sW4qYvNaXP7mLMfngj6/KlCupuXWHSuks3diDgdo9q
         12oHonMsiENfpl4+YdcYRGEyiNQa3xfmxyP+SXJTh2AAU9i8K7kPanZAPnAzuRtFqbpK
         0pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781042513; x=1781647313;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAmwGBfC1XZd5jw6fYdLWLKuIRBVQ3XIl0fIzPCuEOw=;
        b=X82czmrlGl9NlWVmHHb9cTLWC9U1dgQuWl6pnTVkLvFqoR3i/OTvw4ZytX6YTZMArv
         x8EIgHpS90inEg8URUsxAovHEzNSTxFaRptcghQutFVHp8lgRr7+AMRE6GZZZMch/ujS
         azCuSq7FdTdfxNb2LfEslknnzyv7UYwvRj7jD48LkRiEFS2tWWAhqneMz/4Db91gWFUW
         rjSssSo1tqBVbSYTHYWzSiA0JorYwR6kQ4T+z1S0SKL8QAmMqAzAF7HA8juqljF07mGV
         YlkXP1+7X22IRpSf8qoKxUWaGLzxaUu5NmtYWWLbBq9BJqSZswQ6V1WK2cix1Q6pgP0i
         a/Iw==
X-Forwarded-Encrypted: i=1; AFNElJ/vdoYI2CzVkR0frkLUJMCLSkCMXDStWynUCoTwOwmxL9sOUu6g+SDCSCPA+1zT3AIrYb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTh3spETnqOfaCKdSILp98G7UF8WampY/wv9cK0S6xX/2X0gk
	1qsT19XJvW6UnQd4/c9R+ZEGXbuacf3Cfp3UlChigqMTLtPYWty8BA9G
X-Gm-Gg: Acq92OF2tYPUa9lLSLWl787m+KBwZHZQf67VgjPQSy2O5uwqbq8u8/zi/mQ48xN79Yn
	tXAXy3s4weW2xVeNnUW83X/g9sJ+4AR310/osTJPCF7T114kwgjfPEt+I6UntM1wmeoIs3ZkFLb
	NPDnkpuYecsPwbErwuJoM9l3VTqF22CQkqpxFhlXp3Vupos09q6Y8+mluLS2BPtg3lRDdUHKU7/
	2CgNbZWqTlzWkRqEsSS5j4O3A/eWwLnphQdFbzIXOEzwnxxavAYCRBgWhfGB0KQdPDG/7FRgUv2
	UM4JbUaiFBChGxbIQz/eL2Ej0wKLR/vxbW8LeUurCgeY9EnWpfCmJ9lVNdwjsHSEj8810dtU2F/
	sdcSxp9WXnvYgGXXGK77e9Viu1VM8V3QnQpM7BNG01xG5n1z2pz3i8i3JPblBHlVp4EGxOWAuN5
	cNHPUqfBkz8SrfOCJLsO0zw6uBOTHNwGmns2u6B5kvhDAF9f6u2+fcEi7rPquZ1qlzCaSJFQLZM
	l+OELsWYvRIVFJxSppKmWVimJY=
X-Received: by 2002:a05:6870:e12c:b0:43d:3ae0:ecc9 with SMTP id 586e51a60fabf-4413d8a24fbmr12770822fac.25.1781042513102;
        Tue, 09 Jun 2026 15:01:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8297395sm18208520fac.11.2026.06.09.15.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 15:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 15:01:51 -0700
Message-Id: <DJ4UVMEEOUIF.8C5PH54S5HSK@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bpf: Tracing progs on the stack save subtree can result
 in OOM
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mahnur A" <s.mahnur.a@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <CAJ-umGQ9edRUCnaLYTW1F2wbRDhxM7RRra545ZYbM+8++ModaA@mail.gmail.com>
In-Reply-To: <CAJ-umGQ9edRUCnaLYTW1F2wbRDhxM7RRra545ZYbM+8++ModaA@mail.gmail.com>

On Tue Jun 9, 2026 at 10:04 AM PDT, Mahnur A wrote:
> Hi,
>
> I hit the following case on the current mainline kernel (7.1-rc7)
>
> BPF tracing programs that allocate something and have a deferred-free for=
 it:
> Attached to any function in the stack save / unwind result in OOM.
>
>
> KASAN, slub_debug etc. all save a stack on every alloc/free.
> An example bpf program updates a map element,
> before lookup and retrieval of the timer object.
> It then calls bpf_timer_init().
> If this happens at every alloc/free event,
> a new timer object gets allocated with every map element update,
> while the previous one is deferred-free (via kfree_rcu).

It's a known design constraint.
A bunch of things in the kernel need call_rcu().
bpf is not immune to such requirements.


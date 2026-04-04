Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3128CF5D
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316064; cv=none; b=gclaTY4nRITUa+pdmdYq7jA2QNjJ3fC1sTSgJmu6OwTLwm3aa545/i2HTNIRkDr/HGuKKFsZ0ZgS+jchTe2WBfc3eU0C+DMDIy8AINIJfh+LeWyFEdUL7M+yrsyG8gFHR2nkp37FK2whyi4aXOjS4NoJt2z23peOez7HHfn/Lzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316064; c=relaxed/simple;
	bh=bwi3fwqRL2gMkBWbXUNgaSztWecB9cnkr2OnSeMSIqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqlenGHuW7rTgVv8kuxT1o0TpYPfd5nc5YxLCVNo3tRHWSNAXjO/Ja2dGd8U9cF+OfxN1zQyi4pnldZNmsox7Jtu+VMvROPxmIto1zYymEReZ3vDBbUt+2rvzmK4TfL1ZNkExbHGCXg5E1ltdRJ9G4hJJ9Yz3InX6iJbHuzMY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGanoOHp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGanoOHp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so27267035e9.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775316061; x=1775920861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya15IHYt9XPwJn5C1FMw2sI/phhivTNLETw1ZpFU9KY=;
        b=OGanoOHp1Zebwnc8FiqdpONklWtKx06Rr45qyxbCocloiS8fxa8iA2zxTmNm/Qu7Wf
         VN8M6Pr7OfHLyuyvXYEZ4EZ68bhyGem1zY6KrDcE7g7S6r26KeAiwEZo9b06n9Jtp6Rv
         BxxulVNC0YiKuI4s99+yQfYr2J7LNeSXHag3RDmeZlTJzrmp3L/ZfskOtQKnOr0mUmjP
         mk3iras8E6HQWO5Yj4VkGJcvDk8Qc3Bm1dACNRiz6mw/BXRt07cv/hkWsv0Fo+XMUyaf
         7u954wAEsv9AOISAchZoazK0ZpZI7/a939lfNU4++L4MkxWVyI7PFJ5OiaxNu7q+Mo8f
         s19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316061; x=1775920861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ya15IHYt9XPwJn5C1FMw2sI/phhivTNLETw1ZpFU9KY=;
        b=Cr6nZWbzMGMEdgTRkWXe3MPj43G79skF9XKaCWheUQkZPlcW1EtQrwPv5A/W9K59m8
         kp1uTJkx6wQtU0UZ82tYvNnfaPAlpIY8nDnXU1d/asf9N0oKEOBYN0JrqFDiZ1+A13Qi
         +cs/M+5p6zTluirwxJEmWyXMGGARMeOi/tGgyHK8z+AQsU39Nqx6bnuz/SRa4CPD1I/S
         uKKfDXwhvMjjM8t9mu4RTjLIIBhwxOm7kIkupKMY3chp4ivnKHTFRhiwTyzMKlW4gJl6
         KBmA2U/C5BVxx/fDU0p+5Bb4dN7qHSvroclogMA95wzAz99ATck1EU6NQz+1lhA9WgBQ
         NBcg==
X-Forwarded-Encrypted: i=1; AJvYcCWbr+qcLH5/cUBSJ/tqFX3pgJAzKLFLzDZOKEHhFvFNuEht1uxj5rfoc8VMLIQOTcYXBDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBJufIRb7npI0OXKxRU5xv1VIieBxMTfswL5HnWCgcfi4HzPD
	ZIKjpWZpJzrLxIM8mgAjLntd52s9Qm9d4diIDu5g5T4AGrPXl4sIEBm4
X-Gm-Gg: AeBDiestEooWf4b2Xsj+Sxy2zk1l8M7JJhyxwwZFg7tlkyj1332367+dIP06TllDF+z
	68rntFTFjYwTiMmo5oY8tV1LGxaovUQh/+QRFKnkCGI13QOPsWpfMuHRvQpMZjFrPiZ0uHioHE3
	dKX1Rg1faCq+5x0ZTw55o1g4n3hUnW+z1YrBwyiJb6FKrjNDyBKbvp3D+Ygy/0q5i6ifTRFieSB
	NdEEi3y2JzZ59MJnu3bIwD7t22DLs/eu304UzfZ0R6WJ/7NodKy0I/737h/sQoNgp+JtJ1U1cny
	r6wZJJmJf+OYw8EEwXxHzkYTvLv9/to1MzZ2IyLGpTBoSxQi2mqsTLRj7C6rxJlHUhTj0VEoXd9
	3Xf4vb6VB1ps8bPiFsgPTFEaOp3NcXGCFeGV3R7j1j6tumdnpGas/xPanz6VxhfdNd/rL00n+vM
	jOz7BrUZXzafZUEiVKz1tJK+eaF2Fq6A==
X-Received: by 2002:a05:600c:4650:b0:488:9e54:94c8 with SMTP id 5b1f17b1804b1-4889e5496acmr44565465e9.31.1775316061052;
        Sat, 04 Apr 2026 08:21:01 -0700 (PDT)
Received: from pumpkin ([31.55.121.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm25182762f8f.31.2026.04.04.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:21:00 -0700 (PDT)
Date: Sat, 4 Apr 2026 16:20:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov
 <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, Sean
 Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260404162059.34ca90df@pumpkin>
In-Reply-To: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Apr 2026 17:30:32 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> v9:
> - Use global variables for BHB loop counters instead of ALTERNATIVE-based
>   approach. (Dave & others)
> - Use 32-bit registers (%eax/%ecx) for loop counters, loaded via movzbl
>   from 8-bit globals. 8-bit registers (e.g. %ah in the inner loop) caused
>   performance regression on certain CPUs due to partial-register stalls. (David Laight)
> - Let BPF save/restore %rax/%rcx as in the original implementation, since
>   it is the only caller that needs these registers preserved across the
>   BHB clearing sequence.

That is as dangerous as hell...
Does BPF even save %rcx - I'm sure I checked that a long time ago
and found it didn't.
(I'm mostly AFK over Easter and can't check.)
A least there should be a blood great big comment that BPF calls this code
and only saves specific registers.
But given the number of mispredicted branches and other pipeline stalls
in this code a couple of register saves to stack are unlikely to make
any difference.

	David


Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FA25B30D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110682; cv=none; b=PVFI1B5F8DlnYv+0IMP6koIhjrX7VwGIjSC4/yB+ArFeSOp/8FD/SMF2fMfa/QgLZe135FomtYuAhclynRTwQrlCl2RBno3X2y9fdghPSD7fGqgTGM/mS8jg5+x96oFTxzDrzKx//hXKVbDlNOF/An2jfQRYAETdtvY+xKaZdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110682; c=relaxed/simple;
	bh=pPpVYZE37MEdXM4A+LvUAcPCWE74zNQfH8gS2u8rINM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=IFVglOI9orB8G8OpUe2hKD36PFxwYbMl9Txyl65OlXAarmrK6Na35VJT/uPoYgy7BnnBaYIBLBoQ9y90wg0rnmx8+xHRgFxArblSa5RCcPF3V9VT2xAuXJ/SctUn6omx9R0tmM7NVgMtzJIQSaFZ2qHk412b7Zwe16QgI91Oroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA54Ps/7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA54Ps/7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-885cd98d226so279822b3a.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792110680; x=1792715480; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pPpVYZE37MEdXM4A+LvUAcPCWE74zNQfH8gS2u8rINM=;
        b=dA54Ps/7pR0FU9wNDr9tY3+FpNTxC29Ck0g7Lx9551UcjbWRuergvCfYwqHsLcci0k
         psV0muIX38K/9zdQFoVCKZE1QuBHSNFSNJcHGrfhYSkHKdbgpAR/k+6dEMK4jXpl6CeR
         dfOsI3iMB0v9G3k+hGqStjHifMQklrv5V3tG7rT6Pbl9WQl5Nd747zoKFCwZvskD8vcx
         By3uujNiVzEnkZnMcewEvCnuM9nwy5SvP8+Z2Yr+/OE+OmmWeJ89NDzyy7U4r8Y25AKT
         3UJ8/pWZLrLw6U69XeNrydWYhGkvQHY9JPqNx6eNd5x+xdTMs/o2QPCc8f1Z/n9d8dHN
         PmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110680; x=1792715480;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPpVYZE37MEdXM4A+LvUAcPCWE74zNQfH8gS2u8rINM=;
        b=iYAdbTXXtiGwGwAA5UJBrdlmqQg03m/bfoYOVqfMvZrkO3zXc3mIZKgzG2ygL6+Jqy
         Rzx0RJlx8SYe/+pEJQDmiIsuFZ7XEGZbtLG0KUxGFMDgosdUo9uG6gMFW8QNmbdmb65d
         ySCdSslolKOomnLr7VF71iLwdImpK50C2l8uoJ9zuagQTmwmSs//hOx5I3L2RMbDynxg
         BUukAz3Z6C3OXqYwhv91Sh5hnabeJuOzJmWKQg8HkfaycV54+zHP4F2tikte9x2GtFtF
         nDkFbe4PXfQ7Uz3GUrOyvCjGUGQIsdClLf/3TMeEsdrYlqGXBX2Bm0UM7mViCdIE/eKh
         tslw==
X-Forwarded-Encrypted: i=1; AKwUvBxp9D3wU11i8WC5B37ewQbCbQmZJ60dAee0Lz9uc/RUTDh5rSt2QX+nYgrZ9PwNfhx07xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBBY4rTc7tsJWJEqfx+Yj9XcQgB9bU3SsqA/t/f3CJAATeRnXQ
	dqlfdKphvKNbxH1vvNZsiwT8huM4Zo5Cz1o9Fix0iEnPvZHkTrMGu3Wm
X-Gm-Gg: AYBFou1UdEgoAG7LjU75xzGY7Ds7fA4ZWNuHh9P1yqlIEo1upPlxDII19o+6OIXf2VF
	6/f4F7elLZGYVa+ZG5lveEDOqR3bgAmR3u354O/zQHXmU9Nt+qMQyg29/zmhecQ8olJYlkF2RO3
	Y6Qfh4+1KJEvJoLmxl5RqapzjXXYjZd7xBWV/vmtNm5n2rGaxrWN3+hTjtZF42yqgwNuNLLsKHQ
	WwdB0Ou6mi7jF6Cr5QozJ8VHmBQpZmcLTHWzqy9L8+hpZ7fUpnU4lomtcYuFRXNBzVOwHPXCvxn
	yZ4bZusig9K/qYQSBFl/8upEi7Vl0r3UEJHxWBUrGoCt3JAzXNzQcjoX+q6Ou0VccT72o1KkMHs
	pViDRcrgEVz3Fvmd52+pmz6duNf7f8i/w1wfpePsX9E/KgzTeUEToLQVW+PJsAvv+lz7YgxUplH
	HlBZuUQpFdYecHS5lf5pPMjuUt4lQuk1rF/E5LDOinBp+bOXepjCczC2mO4T+a2O29+hsGHOYow
	Tx4SWelRIMaIvM1yZ48Z6qXGPRzJY59R0jkopoCiUBVI3KHuubMjrrwpfAa3CCJlhVwvvWE1tRo
	WJw=
X-Received: by 2002:a05:6a00:230c:b0:877:ce59:bd6 with SMTP id d2e1a72fcca58-89f1e9a1c35mr1115329b3a.1.1792110679891;
        Thu, 15 Oct 2026 17:31:19 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947a64sm275547b3a.41.2026.10.15.17.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:31:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 00:31:18 +0000
Message-Id: <DM5U7S0WO4CB.72E73EAOUSGZ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <kuniyu@google.com>, <willemb@google.com>,
 <shuah@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 0/2] bpf: Fix iterator link update target validation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jan-Gerd Tenberge" <janten@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261008161309.8179-1-janten@gmail.com>
References: <20261008161309.8179-1-janten@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 06:13 PM Jan-Gerd Tenberge <janten@gmail.com> wrote:
> Runtime testing in disposable QEMU guests confirmed that the resulting
> out-of-bounds access can reach kernel-owned metadata of a separately
> allocated live map and cause a deterministic kernel panic. Corrupting a

Way too long.
The prog needs CAP_BPF and CAP_PERFMON and it writes past the end
of the map value. That's all that needs to be said.
See "Length" and "Impact Evaluation" in
Documentation/process/security-bugs.rst.
Trim the commit log of patch 1 as well.

pw-bot: cr

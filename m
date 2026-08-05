Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03519539F
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916864; cv=none; b=oaT2aKlRwmd/ZRHVsMN79IOyOUKvd+NpOwkhyxKWVs0eyBDuVY+yklYQYLDyGc404WizHftYNOMgAmn+/h+yztLj30ker/Vs5DzQZZSZ10DWltjtvUl+C6O3Ln1kUDsv21ty28C9L+qILhlWPUwTqgatrRX95LFXorutA5ErANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916864; c=relaxed/simple;
	bh=KpBrkuz0+y+GOm6SJSD67Psul4m1i6VFTUZAmNIfZOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CVS+zRfMYlcKY41xEju4RRt2f5eqsWDdYUKXLZypCKiqQ+37oQx8xLyAHFsyCEbJLzxVcmtHbMzO+1eB3V/fTXb595rsxYxfL5NydRWyVwWxMZ8ld/HGZDIH6+/WobBq+MnfN0lq1TUCvynEwFZ2h8yCFT4VUTAMgYDdl12FW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY0tVBxm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY0tVBxm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e88b60121so555900a91.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785916863; x=1786521663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KpBrkuz0+y+GOm6SJSD67Psul4m1i6VFTUZAmNIfZOU=;
        b=RY0tVBxmI2pryVKBvtwm+Ml9W21HWAe+IX1qqjiPLc3NYo4EMjJeYHMZT/6B2iO8F3
         13NJgtqlxbKByRixSHU4HgbJj9QXW80PpAONQfrHMFzCr8oEfuO98voIJBQ18jA8yd4H
         YNiX3Juan5yUNHDJsqV6C9HZ0pJjufMUpDtvvziaN9rNWWzuX+0L6Su8+EGLNyTs6/vD
         nOA6OLcxfgt5SRa/1x2q4Qav5INX1qXnQ9Qe9ke6Xg3cm9+uvEf+ptPkGrHoYm+Hj2GJ
         FSa5mQUi0UlHNlY8SArIPRjUFnlTMxgacLAwj0FWRBiB5o+OxUY1cWFam8Mn/BbdHjFP
         5Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916863; x=1786521663;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpBrkuz0+y+GOm6SJSD67Psul4m1i6VFTUZAmNIfZOU=;
        b=SMKRAjDzO+wcSZ0O90yTJTPL8GoxxZCL4wfRCW29Lz9r/B+TfnM0ULaS4rHYvGh0pS
         gFH2H3aMblylPrK7uRie4bopeG/XJWpvTk9lcQ7Um0qH/BH943itQq5fVcj5FbOakVRK
         Mn0DF4VUszJeAYjMWqN24RhPISqOEfifWpRR3nyNQoUyRLFNqc479tQO9ixjzda6Pnca
         lyuBcn/1tfMFpfMXrvREUD5+H74AfHC3MQWO+iSyoGb2sitwReKzxZ3uOhtCApNsmYK8
         5AXm0d5KkSEr8iQHPW+wimqPDRllxx3cQeZ2Cu8yNzHio/CJbFSlngNilDa2k+NytsUr
         aDCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNE1/pLD78IqsVofTke9ezLD0gkcOngGclL5L6hH+aPql7j9mW5IZlD74QsdSqU31Ives=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQhWTBNPJNxnCtBNZnR+sPomBfsyvLg/XV/YglrfKwV0wusw6
	ZEBHlR3JjOoWmw7XyksMThAlbews63ig3fw/Kj3ATJ92TpCUZ0IcaWPEtRLjOg==
X-Gm-Gg: AR+sD10EfXiFKJjgdvkSFBf4cswne/u3JKISMiO9CGoGLJIcPYZWiLxud6X02W8IDRA
	U+0prIP7ki7nhOMRPntToSiJh6GSpuzpxMf5sAKSJ8ZMHxEXk4nF8IyiI3vcWoRZS2jXzvfF5h9
	CWO8l5jTKBkfQOqFseUqFyZ4KdW6Tpx4I9sEu1rKYpXAYYu28+BiK7pV7C8X9DuTnJMRTIy99/p
	wXGDUL49YRDmMOAQ+Fmez7Ldzyom7ITiPWc9tPnPBc/RmIJNfcYpQxzcKJgn5QVC+5bjoQwrySr
	RCSfLkgeBW/J/N7TlgLenXKypjSeuq8ofaQP99h9TDPoiWWD2kysGstZacz9YCg48Mie/sHkb4d
	JAelFgSHam0+98WsZtp+hZQT+HuERDQLzYZ+Bdna+w0Up0BMAiUxgVmm4zleS/w5wYClbkOqgE1
	pPWvuerwUcz8KST1Lw5InGJq6Mxiu9/lskuaFt1gTvcGMXhEDG5moHOtuVAa8XVcLwy+xgFNDT1
	yHmJWzP3ZLpwijMhReZmPm+HXM=
X-Received: by 2002:a17:90b:57c3:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3903c5589e0mr5191966a91.1.1785916862933;
        Wed, 05 Aug 2026 01:01:02 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903917a5d0sm2441915a91.6.2026.08.05.01.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:01:02 -0700 (PDT)
Message-ID: <b94080a4d2804778a2bf6c4d588a5d2fa7860a6d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 9/9] selftests/bpf: Test stack-passed
 struct_ops arena arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 05 Aug 2026 01:00:59 -0700
In-Reply-To: <20260803125115.2264733-10-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Add a test_arena_stack member with eight leading scalar arguments so the
> arena pointer is passed on the stack.
>=20
> The callback validates the first and last scalar ctx slots before
> dereferencing the pointer in ctx[8]. This exercises the indirect
> trampoline stack layout and arena conversion together, and prevents a
> regression where stack arguments are read one slot late.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F138837E
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571488; cv=none; b=svPYFvdt/MQhmzqTq+F1XUmTIkPSyuh5+ZjSKcBu755iXnMOuQa/xDbLzTEUQEW0Gz3FzEK5a6yt4ltqTBTICkeU8yliQlVnxm64IJTnuiiNZ/zsZ3Nbtfu+Wm5g6y3YkFl3rP8ocjIkA+h22pObkyxrQf8QGV66kfDHQeplZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571488; c=relaxed/simple;
	bh=0rZEmBSB6RwYaXks5XbSZYkz0UouvgnUvN+DYo6N+Aw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k7/8L363J5dV2nVdhdI/NqjQRUk2TRrdAK6oq0LGnn75zELZgcQr0lOArL1mPxw5wjvt5fA1GTQv18qrS09fLH/BKjZSc2rrxlZ57KJc11XVCiO2DnAGlutWYiqNBdCsXWfOiGsJXe4gA99YdS/DoFfxbnokG7emXPTX5rT5HjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms4015At; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms4015At"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4871618372cso898173b6e.3
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782571486; x=1783176286; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rZEmBSB6RwYaXks5XbSZYkz0UouvgnUvN+DYo6N+Aw=;
        b=ms4015AtERzQhmRj08hB8S10i44OdE+ZQcr70lQAzwBEIfphV43Ccx6qLQnt5g9VxA
         Fhc/N7VbLHta2WG47X9G+hVJpOnMzakFSWepDP4gnIn/q5/hO3Xdhd5IkhvFwxo2RDii
         qgYkm0Jcj3BaXT5kd5JFVPvecoZQBM8xpmDB7KQI2V52SJ5eB/puI7pUlH8eb9sz5lpu
         88zvKtVO1Fmqe02M8+Puz5Kv2lcCV2uDAWxhsxnQYrJTEkIITuCGrijsRE/xLFC+zbLL
         Ifaq3aeW8FTEWpqCOo6Suq+GH4aLd6eIsaND1613F12gLeybQ1uvu+JSCaXDJ2SZdfGM
         CPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782571486; x=1783176286;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rZEmBSB6RwYaXks5XbSZYkz0UouvgnUvN+DYo6N+Aw=;
        b=BeiI8qC4sP4Ud06BHeE+VfS5c+1WU+bwkxZV0uPZVCisrq+1hEIeR6MkK/CVXRtjOr
         vgAA3NtAwr7yeQbWrNVYkDtMrn++pnKR+Dd+Aq0Ho4wy69eUFKtK2/eLmtC0YEto+G+X
         tQc3W085ylCSTs3Fq2FklyPzRNA03TQhJGLprD/dmJCr1xDoVgB0ue5Wzg2oV+BMEhyX
         0sU1oMoFtFNcJK0OJxkdsr79+5XjaeMpzZ3hGdqEcWiP7JZfD2L2l4FZeiwBbvjZoagZ
         8XWzqmr5msWqWQ6iP+touw279lSe867wlO1uMfukCimDUmSO/1OWUy+p7FgIzHVQfq5l
         8imA==
X-Gm-Message-State: AOJu0YxjMCte2BnyuQF0jS8VhTo0LrGm4BsX18fNszEes0Y/7GJVDFv/
	8IFr/EYB5tyM4Ln/Ur0wDdzfAt/8hZ/elLI7IQKquYrnCXXJwQvJUaz5Z3r7jg==
X-Gm-Gg: AfdE7cnVpCS2r1+FRKS46DvmYy3v+l72dFV4g/eSWq3FlyI2f7N7T8FKv3q6g6B6qu5
	/PP/tXsw3o0OhYyxn13wJN0xDlV2r3b6pNG8u/q98CYG/x1aiD2lXUVrMmOWF6fWyYPM4YuTduY
	f1pSNTpHo5p/v3gFlbhb77GMAyuyYvXXlNoWCaJV5YqKNyw7yON3QrGxHXjPI4FPwUbYl7AJ6DS
	hq/enqOGTWOsGsGkcOKHw6EBCn6z6eUdoib5z+a7zdYbCZrC0645IfE092sEktWP4GFwGtdel2f
	klRCQ6HqJd+3coIWMpYxuZFdeZnAHGarSZpZLWjByD9ku7grwjKLwj9sKx6mxe5pfIK24BVQKZL
	+INQysB/i1GHl5t5Wu6Sokj0tIUoB+cQmCUQa1yQkyaD4hwinmm20hujv6odBVOXWByihmEVYNZ
	umlj1BG7yrXJky1Dn7gf7lxdFtsl6FhPot0apd0ifYLeGmMGMXHdaB8NZlUuSKgfNTMj+YRLCXQ
	8r+dLQ=
X-Received: by 2002:a05:6820:1b05:b0:6a1:50e9:d57d with SMTP id 006d021491bc7-6a150e9d685mr3382832eaf.58.1782571486270;
        Sat, 27 Jun 2026 07:44:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa29a98fsm4395073a34.0.2026.06.27.07.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 07:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 07:44:44 -0700
Message-Id: <DJJWUQWQ6Y6W.2J1E1SKVHQAPO@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
 <20260626-execmem-x86-rox-bpf-v0-v1-5-45a0b0ed4fe9@kernel.org>
 <20260626185945.2F7BB1F000E9@smtp.kernel.org>
In-Reply-To: <20260626185945.2F7BB1F000E9@smtp.kernel.org>

On Fri Jun 26, 2026 at 11:59 AM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Pages freed from the ROX cache via vfree() are returned to t=
he page allocator with Read-Only permissions, causing kernel panics on subs=
equent allocations.
> - [High] The return value of execmem_restore_rox() is ignored in __execme=
m_cache_free(), potentially leaving cached memory as Non-Executable (NX) an=
d crashing the kernel when BPF programs are executed.

The pre-existing issues sounds real and probably should be addressed
before cleanups in this series? Or altogether?

Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918030C37C
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778756; cv=none; b=BebqaNny3B5Flw/bPPxuQJUjHPIIpCQAdoIjoLxbo4yKHxPXfeywqGPecu2hbL9Mra7GXaM/IHpPH3O4vZfCjyY2Jxtvh579HKMwh79tmOxsz4rRWWt6AhcSsOlVAWBktQJergZw0A2RAfnXCrgwEQ1l/8ha7pWN5FwxTAI4tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778756; c=relaxed/simple;
	bh=aTbxwJ0UYRw94tr6osLVIdvUNI6PubaF0vPsD7XB+s4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DcA2Qn5bS9EB+uU/RAVufY7RK/1cor4vL9wph+jG3uqbJUtgKgWR2KSncJ6i25ja1tb5Vgr96S3cBYMKg3SqSTtt3vUtOcP/SxwnjjNagsmXPyd1lvKqTPHgGYti2qjhWwXm0IvLkPWw2IeMl5jItZUOuobStWQZJ5DUHz6PXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF4en8Ws; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF4en8Ws"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so123113a91.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778754; x=1785383554; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FUKG7ICgd+GcU998vdcK6dX06k2jTdeBQRHxEC1Ia7Q=;
        b=UF4en8Ws/+ri4YPBhTICcLywiCl0cLlXMkNeN7DD9FbXpqGy7+lJwdzqnZTQvpFL3b
         yYB5bLGJA17XTC3nMdbuJwSWGWUw0oLSWBQDcyP1O6SHT07Xe38THvYtHweXJwricUo2
         C7c60uLt+eW/v5QnNRPAqhOgv4/mHBRLnV0fRXgPgiXXm+AcuBJnG7fGJzFnnRzCPLiS
         DxN+hpl9j+yy586YLEP0Em0h/6If5pitewTPtxF190rPBvk/h1SkrYI/JEZQ6a7SH7W4
         bii37QJ9KLa6z6V4m+5ismhRV+h7IoT8ChVVWTu5aqNAv9eBjYLuzEJqd2NL6FPnjBR+
         rgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778754; x=1785383554;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUKG7ICgd+GcU998vdcK6dX06k2jTdeBQRHxEC1Ia7Q=;
        b=rEqCoMiEZpBwCWKBFyeDx26O3MYlSYc5/6Dh9Mr2nG1lAnRGFmyj0R7LdzeeTpGkqZ
         MbKPwIv0d0hqM38eJ94mnX9AcOuIcU7Yos3xJCHkwG0h5oqpIPt2BPubMqwP8Iial3FT
         3nwBdrx7JqYAf4uNLWREaX6FyqKFHYRuL3nOjHTCn9bqvekVYOaYXvc9uSgOlvzEKLgp
         7FcRP6H1dvt/UK1kC3C8kwotc42drHNDlfxjRdbFVezCw9zcASC2bPN5B+HPmIUA4aMZ
         pd/3PFNd5fifOWPp3Hd6BZIwiqCku7YiYTooqyEsIN8XHGm71AEddt2ichFE0BdE1q7J
         DTdA==
X-Forwarded-Encrypted: i=1; AHgh+RrsOmMdbB3FUc7fLagENoYUYWMhmJAuBtcZkBl+sI4S4F6CiBV8If79SRBwX5YMsL1OGOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ESRhRa1NAN3gejtGzsdaNwTDOWLuOcrSj6CWqPpL2m2lt4n7
	GBKoIV7L3g0cSmjrdN9DA/x9QoK7p90AosDjKjNlD6dALeOcCksWGhqC
X-Gm-Gg: AR+sD13MyUhubmfmzOWeOA5XjrlbOdR6LpowPN+94Ihj5sWBLe2O901ORi1IatMRN81
	RVZ0bYr6rpPpWLdILIVwdWMWE+OUzx+bk3C0Evyq4YgqDo6NYwY3NUJpiAoo5OLZek7NwAF6tXJ
	cmm5vxGsPNkut84U81EyPA9EmBlxi+mpHnGwWEyrh83fJ9xqsXB+Jb2ME957s2Z42qeESEli8br
	hhh41icOupNVg+qLbUaoswpNJfJXGKFmg2ZMIWuML5yTpBta4GNyKikAjAhOt8o28HJt0fA8do8
	Z5dqlEoMwU+J40Riv/OIxjQf690VQjoYBfVzd7WH25oM5LLa3hPBBtyfA4n2CDdGQOJQLQApnzo
	6RbE9arnzFUtEJxBBg2kqCj22A+h//9tqo8rBJjoLP5LKbZ/KaJstruTKa/4rQ+mlpeMbgjjFtP
	ZllY6GHk134sdL1wAL
X-Received: by 2002:a17:90b:5650:b0:38e:cb1:8ec9 with SMTP id 98e67ed59e1d1-38ec661b520mr1404913a91.42.1784778753914;
        Wed, 22 Jul 2026 20:52:33 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/21] binfmt_misc: transparent interpreters and
 PT_INTERP loader substitution
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872729.254289.15918342296936455606.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:42 +0200, Christian Brauner <brauner@kernel.org> wrote:
> [...]
>  tools/testing/selftests/exec/loader.bpf.c          |  56 ++++
>  tools/testing/selftests/exec/transparent.bpf.c     |  57 ++++
>  19 files changed, 1823 insertions(+), 303 deletions(-)
> ---
> base-commit: 6cea93ff6fe97df34b63fe94487473e16c73b74b
> change-id: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8

Started to review (slowly); looks like the first ~10 are mostly NFC / refactor
/ documentation.

This b4 thing is so slick; I want something like this for GitHub now.

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>

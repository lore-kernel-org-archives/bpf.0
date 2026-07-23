Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03501B4F1F
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778757; cv=none; b=MBifi9lhhL0d9EiXPwtt65eASGbUGPsyn/hrrYNfCtHbisx9EE3io9ks0uYOqWUKHopJ1cqQEzPNUMtKT9k7BOvVAW4PZCYLjhAv6ufAD0GsdZe7aFXQIidojPkLU2H+iDaArWzUZjdiFox3d/FUnCe5wzKjl6FIBzjWCW9bt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778757; c=relaxed/simple;
	bh=ZK8ZdB9vqMtUGtjEuw7Wls8+QwjlMmCewXLKeFheOhg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=c6ZM2J65ro/S/EX4Cw8CsHMZ5aYszIbMupJZ/Wo5vPHkijfW+eFVaeI5Dfpw8cgZJ+xXXtFVbFUtoQ7RRU40QNTZ9C2e2yUxPT+9qzwa1H+RJsyeKnnlp9P5ScrnGWm2M5SGm31ju2JrEmB++9GL1Pgrr6rfOMRbuICbWWu0J5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8Hsce/d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8Hsce/d"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e7109321dso117374a91.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778755; x=1785383555; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xmQfb7RGeHqBIgAxcCBU2i2fNRwtMMc3p7Xugp36EHc=;
        b=m8Hsce/d5AHAG9pr/R/ZDwM5OK7cqEeVIxr+N4OXVUUhcVR4FekJ3YhMquc9jTf2Mc
         1nMv5B5KqH08xbwaMwq+20xklmqeiZMnNYc9C+ST+Zr2tYhVkCpwKemDIs2GqKOHCFCK
         2hgyGYR1ZbtqIbSXFO8Cl5c0hXHhnYQaLdSF6mAQ1JcFL2HXdKx8xVGfAywANK5VyDaa
         yo2TnJicSDgMWq/YSkWqMu5npppYOj8Vx80WlLeWE6oyKCQ3kUYI5xMoEGkycsT44chh
         wSGDOLczUJ/HeuzG54UZEYY82uMBsramfwkOcguEAiY/+3N7uv8L0g6oh20VXZDvH6qF
         cWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778755; x=1785383555;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmQfb7RGeHqBIgAxcCBU2i2fNRwtMMc3p7Xugp36EHc=;
        b=a0QW8eNN3WuE4bHeWbJlzCyyLRBWFQ20CxcZZIy3KvB4C2U3MFiN3bYnSacTe8X2hX
         jsl0cESaAHuZYdo5r7N8zpa+PXNrLGm+dlJK0an1BWrNoYC5MrbIxqp94ezDXqYv3sTO
         3wj7yMMczBHbjFgkoCDDKbF6Aqa1Ucg+vWGuprTnxS8gjf1ZLatz8ptEASda31++FEz0
         vVZlmEy9ldWSYBXio68Ns0IVq7/8oabEIgZ7eoCS+hrigolvRESt/YNNxCOTicUcq6w2
         t5nGhNbCxLoxXGXZrRpimgeVDeBPX+jWm0mcGZMcxIYGlKHTh7wsAKlGFTpzvCrFU81a
         bRvw==
X-Forwarded-Encrypted: i=1; AHgh+RqIAY7MGuKTYhFguiNCx29/DhyKu3VSHtQojzJffAqDJi2P+xyjrCvVBLHduoQKOzIa1rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVSami151HddSTwrZMAjyBSt7BzP7294N/msy/wuei6KRcuEI
	BTjvL6p7nPO0wwNlq+YoOMvwGMCIsWtUBqRQn1kwl9NvhuHa+AIB9l+0
X-Gm-Gg: AR+sD10q1LveEighEgVU8+3qS6pWQS7kdcVhu6xcl4CgiiKHmVLMY73Y5vK5iUKFGai
	QBT1UnyYcuQ8DwXLnOU/94bdXg6QzK1+Tk+3M+D3L05/puuSkrOz8gTtoMHFUfitYTyfzmCJvjk
	/Y8jPEi/0J8z1axNFo/BiVX2ssYD7QVgGq7Fdja1m08h9KZPNCcgmZsVGM8nrMDukEWe+yVXTHZ
	HpMSieDkeYqvv9Ts0E7RyWGOG+k8HP4zH91amo2Qqk/WmmlZFM8pIxm3YIvbhcAI7mLc5Y4j7Fm
	r8WVDaNprHbI/6mzakNJNwLpGaSnm+wTfyCB1NhN7SXGco6kzj00cRK4daiYIJ2onaRCHrvbfRs
	qNQH0yKzzvotbi8SDoltCWO0psIhCkos3xqC6ivdPtNZn3Zalxe6DQZXoS8hqLCF/JT992Y0Epb
	GinoSHYQ==
X-Received: by 2002:a17:90b:388e:b0:38e:bfe:81e3 with SMTP id 98e67ed59e1d1-38ec6495a20mr1338287a91.8.1784778755164;
        Wed, 22 Jul 2026 20:52:35 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/21] binfmt_misc: require an absolute interpreter
 path with 'C'
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-1-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-1-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872729.254289.514226158931792401.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:43 +0200, Christian Brauner <brauner@kernel.org> wrote:
> A 'C' entry computes the credentials from the matched binary instead of
> from the interpreter. So a set*id binary hands its credentials to
> whatever the entry names as its interpreter.
> 
> Without 'F' that interpreter is not opened until the exec happens and
> open_exec() resolves the path relative to the current working directory.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>

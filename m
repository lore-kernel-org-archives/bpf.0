Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7AC360EFA
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778759; cv=none; b=BzDN646ekQMfia3NGyooofGVD3ntI+jDAIBa7ADFFdjGcjEKkbcIZI0fB2RjfU1NEU6akXM76M4b+UIfgruo248V4dL8kKKlctF1Xjhoao7UcbXf0ngKtYsPgByIPoqd2n7RKd2Zgw+NGVpG2QtiaDDRs7dDwsLIhNNrXS+TyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778759; c=relaxed/simple;
	bh=IMGrK+TnUR9pboy1JitkUW4a7gpsQB9gdFxVF4XUu8k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fZvrwzzq+ZUnQIeLhb230Bn3Us1rL5Yz0JSmLJnVQ9oToTH34XImg8Askgk+6i3nK/prTBtvUQMvB6Vgr1caR/RGMdSM3LiISlQZeY+ceNiqJk2Ue5ZWfmtLoYAHqoxTciW6l96L6p3bJZj65eTT5fSCyaNnXEKrTiKb6Dg+Rts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG/2WBHo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG/2WBHo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e7109321dso117392a91.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778758; x=1785383558; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PWkIzav5w9B0mJTOhCHnbrafABGdOuy3WTC0cILRB3o=;
        b=TG/2WBHo/VhD1mX9sGjwBZumyllwLsybYXyvzLZ1s1owxXrDJLaH1vkcO9tkpQQhIV
         IIwW+XT4NHQFJ242hdOkLUAdNoLmdNn9CRPaV2t8j5ZVDwRpx0qIVTzIhajvSDu5cCnP
         +9NSqkPOjTrqRVWclETjb9ikef9F0KtrAHIeL3C4BSYu2E3h/i1O0UmOVzT3nTlkB6S7
         uHcMcxEUqGzFMVGcnC49vKrHRP+IpxxF5JauCriUgcgw7egnKIWGvockCN72WWsrg5AE
         Ed/69YFppku/9t3/PmBvhIn2QdB5/yIFGNIS3I/F3+lWKnDefk+T5nY4FXNK4x8Mq40u
         h+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778758; x=1785383558;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWkIzav5w9B0mJTOhCHnbrafABGdOuy3WTC0cILRB3o=;
        b=RFHpMGp+4wVTGZ8w0PsZpT5HsDfY5+b4ACbb5fOIERt4zuN+++CHbgtIxaU5bIAsA1
         g/ocs1Qa/2mUAChl2r6KQ1VG886+0ELKCbOHmTw6eS2EQfzaXSyp8X8sN/gs53sNR3D+
         faoBWoDrYiwVpkWsxzbkL8tl69EoVSCGfuJBDrBCAAlUASluJ5s0yqVGsAkNUQGd2O0C
         fPzmK/pngK5uW1mwQg6enoShrtr2/CZWTFZh3+bxZ16NNpshuKY9GqFsKiTzYYkjM0lJ
         KjGu8VEqrEVxlJRHVYNCRINH+BKU3NOgWLOIcM6sV7j81pBn+I82U/4DmIQTXW/qmoA1
         kUng==
X-Forwarded-Encrypted: i=1; AHgh+RpQT0TgnbwtcFNsLa9t6SoRMj+8Cj4dac2NUx29cS5jdPueATvi//oWAuHAkBEQ3XhwqIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAghSubaqjCSUi35SC7p6FMl68Jgtq8Kq1UKmIPvrD5hMnmZ7
	I7XXyNY2QfxymsNExY4WhbZnWYc2mVc1ZhYHWFgUMqmZI5SBVBHOZXj2
X-Gm-Gg: AR+sD10Tksi7JyBUtf9ZqCZItm0afqUSeUYAnWrU3w9MwAW99Ei1LWfmCGPhKJWmnBG
	6dT5Z7REEQs5YNzHytnakHNre+hKwVJZ6+nbdB81q4IH85L6LVy8EJsXEge03qHAj/zHS9GLlLd
	lFYbzsLDmSDPvps1qtaKLmgtqZ0k15d4TgSviPg/XbR0/tVEfHHzNjN2Wp1upL4Oo6DNwIPR/Ju
	64XAk44kSiD9Q+2tMtd5AxPtTwxCxscIoV5HCjE3Qt5gRvf+NDeGa5OhSQ+3PJOu1lykJFPbZNe
	oYY3niTUboNrFiCnZZGZ/20Ql5YtFD9CZyDLYyavEMG83wnBgPlyLp44PgUG9Y47QW0H9+PT+2u
	Y5CY3hKsHVXkAEjwkS9d5cQ3MHNXcinqFo503QI5YmGMe4Xy1YOanGtm4KryNetxL1fN/NDM+Zx
	5OcG7s/g==
X-Received: by 2002:a17:90b:3803:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-38ec64958f1mr1552625a91.6.1784778757821;
        Wed, 22 Jul 2026 20:52:37 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/21] binfmt_misc: table-drive the register string
 flags
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-3-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-3-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872730.254289.11746442109631976813.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:45 +0200, Christian Brauner <brauner@kernel.org> wrote:

Nice sensible refactor.

>
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index bfe30fe53..c0a3b42a3 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -51,6 +52,36 @@ enum binfmt_misc_entry_flags {
> [ ... skip 11 lines ... ]
> +	char		c;
> +	unsigned long	flag;
> +	unsigned long	implies;
> +	const char	*desc;
> +};
> +

I know this is a direct 1:1 of the doc but implies seems unecessary
rather than on a single flags field.

> @@ -749,14 +766,9 @@ static int bm_entry_show(struct seq_file *m, void *unused)
>  
>  	/* print the special flags */
>  	seq_puts(m, "flags: ");
> -	if (e->flags & MISC_FMT_PRESERVE_ARGV0)
> -		seq_putc(m, 'P');
> -	if (e->flags & MISC_FMT_OPEN_BINARY)
> -		seq_putc(m, 'O');
> -	if (e->flags & MISC_FMT_CREDENTIALS)
> -		seq_putc(m, 'C');
> -	if (e->flags & MISC_FMT_OPEN_FILE)
> -		seq_putc(m, 'F');
> +	for (int i = 0; i < ARRAY_SIZE(misc_flags); i++)
> +		if (e->flags & misc_flags[i].flag)
> +			seq_putc(m, misc_flags[i].c);

Should this check for implies?

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>

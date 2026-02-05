Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCB3ACEE6
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290843; cv=pass; b=s6zhiBIJUJNc5wPNboaGhS9QsvmHvH3jdJ2dRDszNLDBKHTkBEi6t/DFTJ0YEoImJeW2cRpwQTb92iu9wis/FIQg7tzWwymaTDIaXkL33wnR8Tf28dpD9ONEoXTazDt3UIokX5GBNqCCrSJqyPBTviuyHYfhs1PZ5iLjhlkU9l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290843; c=relaxed/simple;
	bh=VMZ7gH803ReScbBjYHJOeIUb0hkAuWgyGar2xBFxBZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0WJKdmMJ+Fhcs9sg1hExulWQpa+o7vrhZ9HwYb0kcB95ALHXIYAfn1H/OhZveuw3CNVsMJybGYtoKkeoYGVRExQ3DT4VLsemp+Om9EehHwYopV+tHgnQpQS0z/eSSbLlFqCIH+P2aFivlOkRyf0mheZ499vNu3vk45umCu+s80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=OqWZXLFP; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="OqWZXLFP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso992548e87.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 03:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290841; cv=none;
        d=google.com; s=arc-20240605;
        b=g1w6NQV0JBlevxu9uuY/YE6lB9VSG2LlabEHm7wg2kOsa9OZvT/oNP4NhROH9YLgqr
         vf1Bsde7tLRq/HCdQL5JumI8muGSnBog2ZEqxAot3AiNzqle36+/XL6KMqfvGiSVbzok
         3gmzl0lojjNJcbfsnjFGixc6hbp1jLvHn1QMFdDGg3vAtcifAKejwtR3NbTyH2Ja8xpI
         lDlbn3HLKBlRrU5xJnCZW2pSPr0Hbu9FPHUuHohFHfcJ1ZPtHvxJyNI3GPP83b9Qkk6x
         eY3GrD6qkvtKmGvcN/w4sl9a72RtGdANVqN0YE3XO411xkI76bNNV9EY/Wnr8xtkbZmE
         Ga8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wB2O+cKVYBqmoEW7vQIPmoD4iADQ3byabRucTrKUGwg=;
        fh=VNQUnM6+gN1G+tyZLlCncdn7yf3r5P0jWVi1tG5NrH4=;
        b=FPT5VjERy6NL9UcFnQsSRUaTKtCdMgU63k4tWIoE7DQ/ZgN+FIRJnOtddZh3cFpGfm
         AjUIbA0MqhvYR+36HSKyVMkbxgZrG+X7ul4kQvqUw8iDaJ72vjtbXNwC9UFtnlqCMe5k
         AB/fhFsWtY/Ce2dEjyqJp+OloGEa0/j3bDC5Jb/if5JJxTdCpg1ppsefUEAmyPquPhD3
         WlGCqZ37E0fyHu2NcDM37TE+IFyRvFC2ejn7Z1GHe9wctsR+9bwkDd/dneY1KSx3J3hS
         6LJlHBJjG7N+Ex3U0k59+BxrQjL9KJEB+TEP9WXxQujl2q2sy1oM3wLK6sOfKmqBdi8t
         OEUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770290841; x=1770895641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wB2O+cKVYBqmoEW7vQIPmoD4iADQ3byabRucTrKUGwg=;
        b=OqWZXLFPFuARHuoSt59LjiR8Zve6+DbrQSCRSqZRuiQNEGGciWQ9T+5uXLjPflIjoI
         MhLMPuewBpdBnm0GRvmv4uKDk8/N3wQmGWbcqBjLMIVuqm6BzO7it0rs8hZ3vbtLduWU
         ZgkC+cDuD4FDu4INE972C29qf8xqsG47SdIhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290841; x=1770895641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB2O+cKVYBqmoEW7vQIPmoD4iADQ3byabRucTrKUGwg=;
        b=csdvkDJ16wy1rXhcd2mv9nj0SU4YEbEOFxiWXAXhV3wGXLa4aeg5p0py23A/KRLouA
         42EY6xuzi1vIBfLpSKLyOQGyp65gsYMx6ZNNNjyNqTS2wnvX5wOrGGZfr0w9txwCPTET
         rVAuzMQfUogVvDgmbC/QJ/3BkzbbE46f400fzlqVMWzdB62zd3hYRzR8/K2CVyso9zeb
         9AJojN/1mzcaETZ0iQrOxByeQrdTr/RgQ2vEk9K35XXV3Z3ibVfzLuNYRAojHKEikzK5
         Nin+KCOw0X6f4rjg+Qi9gh9FJmty5X4CX6JPE9N5M1gRn8OFS8RP2RakAp2e0BDFjVCo
         RnWA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LGzCXHsj6J+52mut2z6tMXVFVfe1eKO9D51gUShw7IJ2KGHm/7Lsgf3Zt+w3xfX3Z/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEG8SQl4EQ1mwD77AQAsoPCSLglLyI0u28BOoEBEQMKuAL4LUU
	2CAPMbyTpqeNpRMS/U3d+YN8zIW9dk3bVHLFlHBUBMaHff8tb9MAwxgobYqE9PzGq82zqpCp5t9
	R81CtCYbcwIzdkn7lBcFCwqpYW7YMcMIaR7GT+HJOLw==
X-Gm-Gg: AZuq6aKJclVynai8xiHQgDM7Cy0B1Wg7LlCmHc+CWrQmeu/V/y1EvPtjvavnfcjpy0C
	Mu02oM0QEBKo7oLDcas0Dfh5Qgm508W2ekhXGdW3UPkNNtQBue5AMPZ1DRVgi7Ew7PDnxjeXTe1
	ypIJVRPdZhPct/IIp1DozF35inZ0nauwsGkO5KsS2TbLZkXqlu8zjZsLHVNu5NVJ4KQCwvT5PG6
	JAXERHCwPRBnuzGxHjrVAWVktDqRV9Ci+1RYst5KQLupqXM/aaq3H9HHkqAYBkQFwsbnEk6LJsO
	7hAVl1DLssn9DvFcJBdngf6zHUo=
X-Received: by 2002:a05:6512:3e27:b0:59e:9b0:165c with SMTP id
 2adb3069b0e04-59e38c4a4cbmr2386140e87.43.1770290840891; Thu, 05 Feb 2026
 03:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com> <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
In-Reply-To: <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 12:27:09 +0100
X-Gm-Features: AZwV_Qi3EfgySmXpzaYg6pmJ3PxLGQMqI9MaiDB1obuVcZkBWW47mj52bZU7S8Y
Message-ID: <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jlayton@kernel.org, 
	brauner@kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aleksandr.mikhalitsyn@futurfusion.io, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
>
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 005ea3a2c..c350857b2 100644
>
> [ ... ]
>
> > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
> >       .init_fs_context = bpf_init_fs_context,
> >       .parameters     = bpf_fs_parameters,
> >       .kill_sb        = bpf_kill_super,
> > -     .fs_flags       = FS_USERNS_MOUNT,
> > +     .fs_flags       = FS_USERNS_DELEGATABLE,
> >  };
>
> FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
> tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
> (at line 2268), not FS_USERNS_DELEGATABLE.
>
> The commit message states this flag was "recently introduced", but it is not
> present in this codebase. Will this cause a build failure due to an undefined
> identifier?

Yeah, this should be applied on top of
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-7.0.misc&id=269c46e936f3b5f2b6b567ca124d5f5ea07a371c
in vfs/vfs-7.0.misc I think.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21708956860
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit follows standard kernel contribution patterns with natural language and proper references, suggesting human authorship, though the undefined flag error could indicate incomplete context.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: The commit uses FS_USERNS_DELEGATABLE which is not defined in the kernel, causing a build failure that prevents kernel compilation.

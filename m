Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5435677C
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593965; cv=none; b=aqH693DNtUc3wsbvwQHt7uMUDDYaBY4u0/C1BIHiKuCf/QDS/7ttS5Cla46Sp90ywpl7Wf8Xh6xtksfNFjcpf+EH8qTgoQKO+rPTSa+AKFSmNbcichqr4gLkCQibUPQxIQWBrNTxEcsRD6jLGj7WPdYxhaQ7QwjlVnhCxQWERGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593965; c=relaxed/simple;
	bh=uoBOeJvXADzDPvI5u1ZmfgLEASn+vWRlnxID5a3jfNY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hjICqaJIb6V9DF1ULVctG/lrKDHUgacnl225JED222lMYslVimzTu62pyWWhbMhp++IlzR1GcnOM1Ua0iFadIhY4ifYBN0QmvyEMCKzjYNQUbe/I1eWLh/x5FNDT49az5evDoJEOIDNqcM91I+Nbtq5rT6t9qh0SYBfq18O54I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KshgPt9t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KshgPt9t"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso32712475ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781593963; x=1782198763; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0kWBRWl/5jgbXb8/Eea6q7yfci8a1d/gCewcMJDnTA=;
        b=KshgPt9t5QDGWPAJIr68g/lFpKEVp1JHjG4w/y7cuQCl23PThoHdcrUGDOZVGpwkG4
         e5Jtj/f1znbh7xY14AH/ejDRQXl5GVtnNfLgh0vTlSLdDY5sratHWEK4JZCfgwCyl3ix
         L+ikoK+ZL1sKmyqzBdTGftuYDb8UZbwjzdcc0GhpqD8p/Z9MtJnrnGLaCmd/4k10W5vw
         jcNPYMh7XPGwyShGhbFZY94pGMay8qFeMuH+UQh1jS1yAkugK+ZkKIpulIe3puatWwwf
         ir1lZSDdUXR+hfV0mYq/OQLG9Xd4L6brzKGn370MhVuQBmanQrqnO/cEjmao9Mb8R2DP
         XSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781593963; x=1782198763;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0kWBRWl/5jgbXb8/Eea6q7yfci8a1d/gCewcMJDnTA=;
        b=GPlpXSVPDeEyAn3SeEk9G1uylOGTuzggIiuBoGFGMAgzqVIXd8VjQ1/ZfWDdEz6c/Q
         rZZfxXal2Lkxdq2zFAKL898PHB7kVFV+lGDbZ1WhVMvaJvgGEwYImTyEu8snhXtL34x/
         stB/6REJheJ1GEJmFdRagTqxUI9skTIN+HgU55qYdWu2PYg0XeKD3vEAlbc5Zif2Qgyn
         /mtv49ASX9o+/YogG1vWDRykob0Hx9dtk2Oj4C4TZDcQp8dOrsCFbpmB3mpU+GhDkQCG
         Hu/x2nEUh4h1jKqaxFmoScoJlLiXT5Ru2Z0eJshvBRvAXateScpHUHjme3nw0IFMJ+C/
         nSsg==
X-Forwarded-Encrypted: i=1; AFNElJ9oGgZTh/6S8zR5H0Eso3SaX31eArgVlagNlhgHZb8HbtK+dm/rXWt6Nv0GftGOUTLKyrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9v+ZmmLG+/uCbUK/VOXnDZkG65PSWzI3fmsnR0Pj9IpBfpNa
	BV1Ul6VPRjkJviSp5obb12jyIt0MPqQfUXMyrzchyRoW0xyLytqGVZQVBf/9IqiwzjY=
X-Gm-Gg: Acq92OHxuiiTuJgLQc9BzqDdNXOsJFxeI3XUQFY96unPz4bv1I/F38NW5JMbwDE6bCH
	fRz7g+5CGUIFsYE6m9SoZlLDKaPtLpBZM0dPYnWIDAmrI/qvUWhZYyojUpcZ9Y1GjT7ObV4pSSc
	wbsAfmN6uWJqmPxi0XMf4n2+ZEQhwvKyYLW18pyJ4qGnaZNUsLR1IQQUXAnvGiGUkLvSIItVzT+
	Pv1U6vaj62OgRcNKi0eVxzPegCRDXAn9pxdMG0THBZxZ4tBfmMbsUUAeT48jWQs973u5vTVEunT
	shmVJuy1JEE77cSH+y+jnkA062m1lL82qAns3+VLLxB1sx5Vz6iwfvszXBjwCy4wTGtyq9wEyjF
	4XSUbcNgvqM28O/ICdx0kMub8eF4Pehf8dnwOUt0XrVa0mtYT/h38rZj2x59YzYhbQQZZ85fJQS
	UKYYYKS7djmrencSdRaV8T9C+t4UsKE0iEjd2oYJO6cK6t8bL09sys3cLp
X-Received: by 2002:a17:902:f64c:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2c69f6aa2d3mr8047175ad.28.1781593963583;
        Tue, 16 Jun 2026 00:12:43 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm122436665ad.46.2026.06.16.00.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 00:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 03:12:42 -0400
Message-Id: <DJAACNBCFZI8.Z2MZM0DP42G4@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <yonghong.song@linux.dev>, <vineet.gupta@linux.dev>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2] bpf: Allow type tag BTF records to succeed
 other modifier records
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260616061454.7869-1-emil@etsalapatis.com>
 <455ee1eb3aa70bc44f20e6adebe80905d2c63b17d8d3bb44e8eefc01870299d1@mail.kernel.org>
In-Reply-To: <455ee1eb3aa70bc44f20e6adebe80905d2c63b17d8d3bb44e8eefc01870299d1@mail.kernel.org>

On Tue Jun 16, 2026 at 2:42 AM EDT, bot+bpf-ci wrote:
>>     bpf: Allow type tag BTF records to succeed other modifier records
>>
>>     As of recently, Clang is able to attach type tag records to modifier=
 BTF
>>     records. This is useful for using typedefs that encompass a base typ=
e
>>     and a type tag, e.g.:
>>
>>     typedef struct rbtree __arena rbtree_t;
>>
>>     Modify btf_check_type_tags() so that it allows this sequence of reco=
rds.
>>     The function now only checks for record loops in BTF modifier record
>>     chains. Rename to btf_check_modifier_chain_length to reflect this.
>>
>>     Also expand the BTF modifier traversal code to take into account tha=
t
>>     type record can be interleaved with other modifier records. In effec=
t
>>     this means traversing all modifiers to collect the type tags.
>>
>>     Also modify existing selftests to now accept modifier records (const=
,
>>     typedef) that point to type tag records.
>>
>>     Cc: Yonghong Song <yonghong.song@linux.dev>
>>     Cc: Vineet Gupta <vineet.gupta@linux.dev>
>>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> This looks like it relaxes a constraint that was added earlier.  It
> removes the "Type tags don't precede modifiers" check (the in_tags logic
> in btf_check_type_tags()) that rejects valid BTF now produced by Clang.
>
> That check was introduced by commit eb596b090558 ("bpf: Ensure type tags
> precede modifiers in BTF").  Should this carry:
>
>   Fixes: eb596b090558 ("bpf: Ensure type tags precede modifiers in BTF")
>

This is not a fix. Circumstances have just changed and we must now
account for interleaving modifiers and type tags. The previous behavior
was fine, and the new behavior is fine too.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/275984=
43532


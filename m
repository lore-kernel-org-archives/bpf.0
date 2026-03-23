Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAB3090CD
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291341; cv=none; b=KAabpnmuMeMA2P4+t2Tw6aD01adgNl0dJzNz35KA2faCn1pz0Y+ia70vrghFlSnchfeCw6uxC1M57gfom8sNGh9xwIXAYTCN2uhmNpf2V+NxNMKztavqYaOPS0R0m1GqMfATXSbinzStpg871A+cFn0+22V//zOZcJz61CvKCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291341; c=relaxed/simple;
	bh=HaY7bKz1vH12gbhp1PtTn4vwQY93r9ABoNwuu9whDoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUBObV/GShFaFuSgj62YHC4LOYBdrqbIMaAV4ntUOz/2TiyCmGnVRdmOiZ9c7vqnxsdAmQcpu/WbomVobhK15WBP2R0Mgyhmdq6RGdzlUy/BrBUEEh/gzrLcCF68u02kaMk6n03LDFvukHsSoq5CUb8PXvlvYqNIBiNc6+xFYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoiSn7UK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoiSn7UK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso3038357f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291339; x=1774896139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dxdEUh4IB/1SO39Kw7tCUT3zJPN5Zqv8A5orXaxobs=;
        b=ZoiSn7UKh45Xs8DemRyGQkX6wg1wi/xB/mh0Nk2gb3C0VptpGXBRR0BljC4CxB3Uf4
         S1vWhmeInbmq+8TJAK8UBffc9uqtwCHdi/Mv7cuxYgVBxOcWqb8+N092P53um60emiOa
         EEr4Ioz8w1WW7Axoq7gIyfT/99VI8c8JUIFhFALos/DLk0YK57w38IuU6tC9uJevpLfo
         f2x/i6OetBO63uhtqt6pY4r07kuz92kUgVVbBh0iIL7kXy4ygg0Pukdjw9Uz03C+Xl6F
         Uj4feDBujI8Gr6TKnUoE+x6IT8oxhb1mS2SAx0ac3B1xt4TQDlcQn8TF9+hLAu81qyWW
         KVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291339; x=1774896139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dxdEUh4IB/1SO39Kw7tCUT3zJPN5Zqv8A5orXaxobs=;
        b=qlJtzDvytQO6QdNA0tS0v9jUalnEAaNxtNWRR8kf85ZIc2F3mVlp8rGV5NNGoJ+eGT
         v20sc09j+1kfrGSl27qDTqnZPwnZzogei0ygkqi+61gOG02rUoj3kuUL1ZP9ytAsasuI
         79uY1UJqGzTledOSdD3rhT58OXcDOFA+vqJ6VKjHXKOHGvSDqusDm9+MvdbTlQJzGwNq
         yq5KMpBb4BaG8nUGrmBFioq+sE09lgubAdxdNdZk+xNU7gTjjuOxf71SBzAnOzrALCp5
         l93W2obPDqasFySgSDgP6q5iARc8VVFJ8djmgiFALkW2cmHOlZcydzx6FV9sOEY8xpN8
         Z90w==
X-Forwarded-Encrypted: i=1; AJvYcCXqByzp8SwARBLU7gSf4DRig/bafCQ7xcNYsJ78hWRNtySrITMYyivhOZ6s4t/rTc28b1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeMyxIgzkol78Luc4y9Wwbam0xcOt3PXplvrAtcGVIXQKNvFK
	30necinei+8VYousdNtGIZ6D8Mi1V0gmms194lSsNXE077OqYQat/gI=
X-Gm-Gg: ATEYQzw5uXcDjKceLeNvuNz9Jg30NxlD1nYvXNskcwyKRvg0PZ2B00B7PzSer6NBm0h
	so3efnYVlSiOLcir82OcFSaYhRl9A2QqXxHXURbGaNnt+OBmdhfh01lx14QEA/GoWdRl7sSt23P
	ri/Xkeyubdyfd+1yPh+ODDvzM77UKHFf/9BTgzX7+CpBwWXUzOg7+nXxxPPXfzPyCQgR17OosZQ
	wfBuNrFoaVyhGAU5Uac8QLPEITUn83plTo6n1tw1fhuRteHVjp18U5VzI/I6yuaIGQqLB2DVOR+
	6pmQlPPet+cTtrkVGNgLqT3xIaM/ATVDzQfabQMcLo5eaTQMzNX61swYArGKrU+5WiyzTwXf7Hh
	AB1DC9mfYmY1xbGfyVKFxOkVUbLmCmNa0tOzPPPiAgW4q8oXvSSRoHp4wUGAE9gd8V4QPgk19ep
	Ex3gPXPN500xVs58kgZ6qjNg8780BghwZ4VbcKwyg/KxbvRX0fnppwuX/L2P463qkA0nU=
X-Received: by 2002:a05:6000:290b:b0:43b:576b:5dca with SMTP id ffacd0b85a97d-43b642442f9mr20708049f8f.16.1774291338529;
        Mon, 23 Mar 2026 11:42:18 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-188.brest.telecom.by. [46.53.134.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470b243sm32081677f8f.26.2026.03.23.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:42:17 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:43:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
	Kees Cook <kees@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Juergen Gross <jgross@suse.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Petr Pavlu <petr.pavlu@suse.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] kallsyms: show typed function parameters in
 oops/WARN dumps
Message-ID: <cdd61497-8d50-4fc5-aec8-47286e23d537@p183>
References: <20260323164858.1939248-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323164858.1939248-1-sashal@kernel.org>

On Mon, Mar 23, 2026 at 12:48:55PM -0400, Sasha Levin wrote:
>  Function parameters (paraminfo_demo_crash):
>   uts      (struct new_utsname *) = 0xffffffffb8ca8d00
>    .sysname = "Linux"                        .nodename = "localhost"
>    .release = "7.0.0-rc2-00006-g3190..."     .version = "#45 SMP PRE"
>   file     (struct file *       ) = 0xffffa0a3c250acc0
>    .f_mode = (fmode_t)67993630               .f_op = (struct file_operations *)0xffffffffb7237620
>    .f_flags = (unsigned int)32769            .f_cred = (struct cred *)0xffffa0a3c2e06a80
>    .dentry = (struct dentry *)0xffffa0a3c0978cc0

Should this be in crash's format?

	struct dentry ffffffffffff0000

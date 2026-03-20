Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75371399375
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004797; cv=none; b=GxHeAeLMsY/3tdhxPPtjxVaBIrIOjzxSzJuKkuxP3nHXk2OjQfrkMz5o23tAa+7WGY1KjsmCQRKBwwNGmsTPJGyWNQZ9teSjhuKpjbq2jt5qqCJlsf8IJ6VvQ5swRzuSu91oxGYBypghcHDlus6uEYF9UtHBPlLqoYX9JkjImiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004797; c=relaxed/simple;
	bh=f9/n6cLEsjoaDhDm067RUOXoWsDdnnF9fRjPSNmpaoM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7DQ7yhXSdGrIqqkjaP5z+6tL7PX7Pv5DY58YxJKWlW29GhKDs91DzCytgjyPmhlBcsP67pKlDqmP1dfagJGE11n3gzsSu4uPqM4xRWrBeT6jn2ZcNpypvfse+XW4VVcVApKXKF1ac5BkArZYmpKql5Z502HHsCONErG7Q5W1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxD4Skkn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxD4Skkn"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b4121c40aso1281607f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774004795; x=1774609595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sobtb7fPQzocLfNNaSVQw7ztnRNZHDWJCHUAvwDiOM=;
        b=cxD4Skknuj5zNFOtLL/jrNU5cy/7yId8fddrgvv1s2reDd1/JIwTifv+HxvYe4XA0O
         EQidf9PW8T+sS859BctxRj0oiRSXVbQTWli3/9LoBwHLE6j86XzE0/IgiXp+9prvEOC/
         WzYDA4X6MBqeEnYoBYKkcGJ5JJmyATHfg7LCWGaZmxGgsHWxT7Ft7j67TW1xVTwD4Nwm
         vrL/JGx+cys+BJwxlZJd9FIcvQjX7elg1pzG0FO6+JCTQqUDSDuXmBAKIWjIOgp7KyJ9
         /PbSjvWN3f8xLcdE3aMLq9VBcK91zdQOisKaVkZilyNfqYb0D8H6Cl2wOwfBiOZ4U33Y
         sKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004795; x=1774609595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sobtb7fPQzocLfNNaSVQw7ztnRNZHDWJCHUAvwDiOM=;
        b=dt49pUAqyobJ3xFlYLbufY/lh7jXVc+zN3RqkfY7FkeyZ5eQhPj2/YMlDEdFZ1Vz7W
         3fu/tKGj/uprjZIM3jEBdp4vyUdagUYPJ2u3z/bwtncz7AEn2RmyDj+EzxiO1qb/6JLR
         lpPcbKtIQB2BjkDnxYIlHRP2wYMwTlbas3Imts0b17Dfv+fu4yjRGGfNzb2qQOEr4DHZ
         bgaVuoCB87T8N1wW4I1VvxkgHW7w3mj+Lh4kerxTSq5+tW3KyhWjDsaheK78NDhZ43UJ
         kvVJi65FKCyVW9MAMSafTbE3mXoq5xxmFWrpv8u/za3pofqg3x8LPFW3Qxwb+EgZDa25
         w1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW097NwkvjiD+pvsUGD92TFpWbnLvuyZBcfl/PIevtFf+Xb65MOdulbDFKN48f2mCHQY3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC0RpLSjLsJ+vBgXCvVg5+tLu9kL5aMgACKzU56ApEV8/KmJxL
	NQyGHR+rACQ2zcmygt27pFlq/8hWLJfEswGhC7gj9op4HEPDFAOYUoI6
X-Gm-Gg: ATEYQzxOIhaEd1zjFFvJZ3tzXpuAsikDRwU+knCj09TIe7n0ttish/ubVrKCewEfCpR
	y6PnESbJSMSldkaoDmENAiZnVetixIjq3yI5J1OCzscI0SWJk37GN+TebyAbxTnseMgr8D7wkbS
	Oc0/BqG5rnXBI9W8ZWiJmbFVwCMKKvyvbhLBcCgaHwVUY1mwgij8v2j2jeqOa506TlPOAEOgMSF
	mlbyQMIc17pKJ8Aoqem9mTm2C4sV0fh8It8/0+Y+pFjQZ2xHmtUB90Pk5g53Rj0xllHL7uerwyk
	cINWP9luH2Vzl19i0rpqkxXMjYgylejIp6op12Y/n5Hra9wrlfvaI3ifJ9lAmwGmZw2t2OwH0v8
	7v2Y1lIr+PIa6lKazPYeRDxBQrz8K+V6a2QtCBjOBE2eux1oKC8ojPvKNpZ5tZEN/6+5kO7Ch
X-Received: by 2002:a05:6000:184d:b0:439:b203:7711 with SMTP id ffacd0b85a97d-43b642405cfmr4735292f8f.3.1774004794712;
        Fri, 20 Mar 2026 04:06:34 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0b0csm5232732f8f.15.2026.03.20.04.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:06:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Mar 2026 12:06:32 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Update kfuncs using
 btf_struct_meta to new variants
Message-ID: <ab0qONLv7TCHsqPJ@krava>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <20260318234210.1840295-2-ihor.solodrai@linux.dev>
 <abvscsnSAiLLWBTZ@krava>
 <2d654809-e57f-4316-9d09-31c6cfd25508@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d654809-e57f-4316-9d09-31c6cfd25508@linux.dev>

On Thu, Mar 19, 2026 at 01:43:35PM -0700, Ihor Solodrai wrote:
> On 3/19/26 5:30 AM, Jiri Olsa wrote:
> > On Wed, Mar 18, 2026 at 04:42:10PM -0700, Ihor Solodrai wrote:
> >> Update selftests to use the new non-_impl kfuncs marked with
> >> KF_IMPLICIT_ARGS by removing redundant declarations and macros from
> >> bpf_experimental.h (the new kfuncs are present in the vmlinux.h) and
> >> updating relevant callsites.
> >>
> >> Fix spin_lock verifier-log matching for lock_id_kptr_preserve by
> >> accepting variable instruction numbers. The calls to kfuncs with
> >> implicit arguments do not have register moves (e.g. r5 = 0)
> >> corresponding to dummy arguments anymore, so the order of instructions
> >> has shifted.
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  .../testing/selftests/bpf/bpf_experimental.h  | 156 +-----------------
> >>  .../selftests/bpf/prog_tests/spin_lock.c      |   5 +-
> >>  .../selftests/bpf/progs/kptr_xchg_inline.c    |   4 +-
> >>  3 files changed, 9 insertions(+), 156 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> >> index 44466acf8083..2234bd6bc9d3 100644
> >> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> >> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> >> @@ -8,156 +8,11 @@
> >>  
> >>  [...]
> >> -
> >> -/* Description
> >> - *	Free an allocated percpu object. All fields of the object that require
> >> - *	destruction will be destructed before the storage is freed.
> >> - *
> >> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> >> - *	program to set it.
> >> - * Returns
> >> - *	Void.
> >> - */
> >> -extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
> >> +/* Convenience macro to wrap over bpf_percpu_obj_new */
> >> +#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
> > 
> > nit, seems like a shame to remove all the comments which are still
> > valid, maybe we could leave those externs with comments and just
> > drop the _impl suffix
> 
> I assumed they were copy-pasted from somewhere, but apparently no.
> 
> How about we move the useful comments to kernel/helpers.c, where
> the kfuncs are defined?

sounds good, thanks

jirka

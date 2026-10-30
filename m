Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365708;
	b=XfLwCta4nvBycdqFftAl9skDe25nQvnwBE5sMSdAB5JkzzmL0gst2/LuNt8ycUVFcL/Z
	 lZqRrwLvRj4Z2mWHOkZMiATsY1SYw+yU+jL1HQYhKBKCWGIYDSDqoOxI5ELGOTIZwFnuN
	 PCFfVvWMS1Z/dupgmZsxsF5kWIfu3U3hB5n76eapx1c0prV2SQ6/AU6ona+cmNZVMwEPS
	 F2BG6vN+gnZLkvLgdGzBLU8gBS/wjDGVHBYNJaG2Xumz6l3aQcsMJMbo+AMvb31wb3yMz
	 K7gJE8TxAXwKBjxy49dV2WUEOSJbBRUlghmdrBBc3lAbKeZHDP6dwdWFCJ/nhle2ymQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kB4uf8nJGXdNhGjVXXj1WN5zeX8NQXSMnWRQjF7RjY0=;
	b=yrTIULOOdZmSTOBciVwaqisT7OQKcjl7+p7nj9t8VE9XDjRISx88TmhxssN2R8Dt6nf9
	 hgHU9x8iP5vONZ61oKGwvzOZ8RIT1uQJUJVqSEK8rMr/yvi1QkAGSi+J7aWgyNVns8v6A
	 71GrGNfSxRb+qvWLMssSuPAaMOLhjXn0ncTrRNHgAIjmZtA1z/H7k0VjBZaX5zdVEK4Z/
	 q0PhSX3k3Au1zuuDtUjEiXOb7YfS95vvmLJvEhhQ6e9jZThGcUudyflPQhz8Jdb0A4iQK
	 DVYVwIF00Boe79yft79DMTMuMqfJiQMsdCZrEJgYIxEYPeyIWCTQWqFbcvfbsB4kyOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCjU51La;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770D606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7770D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCjU51La
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e00eee27dso376209f8f.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793365707; x=1793970507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kB4uf8nJGXdNhGjVXXj1WN5zeX8NQXSMnWRQjF7RjY0=;
        b=sCjU51Laowuzbsn4+baPm5U4D1F1BksG0K9fvzi+/1kIpjjmHwZFXXS7QCMT9Ase9+
         DQpkHEStMsa+LPnOIGuc/PYKC7aa+Z6AauXcwRFobm8k+QVOi/IraPGpMsYYxjtZJMJ2
         E4M+36PZhqyUqFvdD5oX0BZi7bIVSkpNCLxITAOKyt+qBKnBMYb2FMEoeaAhsC560FUM
         K8T1wfXgXtAEeJDinzcPZ+IemNv4pxNlxeVvqIXlG9iuNMjRSoG/Jj5LDOkQQ68bL+/m
         sJYn3dW1pzB4WjDfYmnFQ6CiXnlcYE/GR84Iwr7lCJpNowiCOugpRr3gl/Ie11htp0YR
         UN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365707; x=1793970507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kB4uf8nJGXdNhGjVXXj1WN5zeX8NQXSMnWRQjF7RjY0=;
        b=UQ6yZJlPTRznbCc0zYmSasOQm2kyP3kRsk2jlDA3zfDyvRfJDKzmkJboPyWlMJUiRI
         weVskbMebLbGCJc1RvEzkdrwUyIaXrQkIACMZKJ7nPcSEB/W2pXYmfpIoyxa8WGgqHo4
         IuUEozDlm/Imty3Rfg5Mk/CKHggS2mrmyjzJhPmvS+mepQDbhNVRwXllFgtVpHdsnEwt
         vH7X04vN764+jWhZHAQ1Oou90RGmUIAcoNrUxao67Ar2XeyzcCfiqarbxjujrrIv6OO0
         a/sPBHSgh8BTUMfNMT9/OWTssCXf20rgrSMoqlTCQ8IuRpG/b957txpLq/pLyjfCykk8
         QYrg==
X-Forwarded-Encrypted: i=1; AKwUvByhANFn2O2GEbv1SFdO3/e17pELd0G2xsDXPFy2x7oy3fsubwb697dvs4aJBbi72qwIidg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC8cKtYXfsJjhzqsHD1HO9woH6FtAIGvMTgtJJxVeiLxFuGxqJ
	z8PfhiUoCRm+oTr27xGA98Ds897YoyLvkcU/pj3A+lrvqsTvDZ27BdUP
X-Gm-Gg: AYBFou28vnVdNpaNWJlbUdx2SoMGBf0nbazsyzuljO5iyK4P3vsHQ3KrnaqLMfGYDsv
	7EfgbO2cJqMhYlETeggc4097I43Y0xhv7hs/VLaxvq8iEcvdo5uZHlWpvDAtYPVhRfBW4lTxNg3
	GVDTeoUJP++LGVmN8l8Fbmpt3+41IyjOaI4SnPZSJwR1/2M3S9MeGttELuRxtWshdnnYjafRUOe
	ddM45mtpZC2n6UqKGVR414HK5ay4yicdxxiv2GtzJRnlStBDYHi2sw68oTWKq7PNfi4tkhy3l7h
	DqwvCmHK7DfCrKKGFqJFgp8Hvqqa78Yr2MHsQuFYMTzLjCOYuSdpW2uiL4yAR6CfO1TIK9i4bnR
	BzPK1P3d+F1h7Ef9qePBiB91iUHXhCJb0uIGJwFxcsTHyvdmcAGdDtHLjmxee5yzw6gBuaEUCOX
	dXuHSZcMy0PwIojcDftaF59EPs7QO2jyxqLz2iU2mz1tPGZoJixLq0o+eNsMcmBHoWDQKUZbdOg
	rQ9PGdAyTLzB+UD3Dxkt1hax7aVI9VWq+s0br1cpeLFrBi0EMMCowRnpKE+9/otL1zvV8Fkuhu9
	cw==
X-Received: by 2002:a05:6000:2610:b0:48d:ee59:3a30 with SMTP id ffacd0b85a97d-48e6e303b07mr6143806f8f.22.1793365706685;
        Fri, 30 Oct 2026 06:08:26 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm3353735f8f.1.2026.10.30.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:08:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Oct 2026 14:08:24 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, ljs@kernel.org, john.fastabend@gmail.com,
	nierro92@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: Test user memory mmap kfuncs
Message-ID: <auSWyJS1ORYApv28@krava>
References: <20261029212551.56964-6-jolsa@kernel.org>
 <18976b63cb396cdfaebc5c630c926d88544160ef2a4c034e8a290df2b428806e@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18976b63cb396cdfaebc5c630c926d88544160ef2a4c034e8a290df2b428806e@mail.kernel.org>

On Thu, Oct 29, 2026 at 09:59:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test user memory mmap kfuncs
> 
> TL;DR: Nits only: the changelog omits the kfuncs.rst documentation added by
> the patch, which may belong in another patch; also an unneeded
> <sys/personality.h> include and a never-used NULL perms path in
> check_user_mem_vma().
> 
> >     selftests/bpf: Test user memory mmap kfuncs
> >
> >     Add BPF selftests for bpf_user_mmap and bpf_user_munmap from a
> >     sleepable uprobe. Check that created mappings have the requested
> >     permissions and that unmapped addresses are no longer mapped.
> >
> >     Assisted-by: Codex:GPT-6
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This isn't a bug, but the changelog only describes the new selftests, while
> the patch also adds a "4.4 User memory kfuncs" section to
> Documentation/bpf/kfuncs.rst.
> 
> That section documents bpf_copy_to_user() as well, which is not exercised by
> the tests added here, and it states that seccomp filters do not mediate the
> mappings made by these kfuncs.
> 
> Could the kfuncs.rst section go into "bpf: Add user memory kfuncs" or a
> separate documentation patch, or at least be mentioned in this changelog?

yes, it needs to go there, will fix

jirka

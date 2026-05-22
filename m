Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2419CD1D
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475813; cv=none; b=lxcjxUddPo469pRC0AxvTMQQGMSBQ+bBArtBDnri0trzu5i5zY1msXcsILMfVIepGB3280QpcBEcy7t4rSbcExFj2oaFKKIht5AsPuTiJ7D8l7PpmNVbapRiHrZ71edFD71GC3izemJCuwN5gA9keMbGYqv0/zlK/MF8MTQkYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475813; c=relaxed/simple;
	bh=ofavK1PVAqUFCAcIHC1aVoiIOMIQvhtPW+FVwgQtP74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYdmN9P3UacY1wm3dlLCXbei+IoYX3RRHatJAyvzOnxA3ZYX5RD8+mjEHFpiW9mun0w9a6fsG2GZBgBT0m7HyGZc6GP45MeWjwOZ+XPfdFKRyvaLzryJSXAdiQZyZi0hlwGEGybOmcqmmaxFlvsGERsbGXzOZUOddy2k01Zk6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+mCS5PJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+mCS5PJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b46da8c48eso975ad.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779475812; x=1780080612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnI4zty5enT9uj3h9rD+OI5onY7BXanYIPuGhTHdGIA=;
        b=c+mCS5PJYDwIvRfgfsWaNADSACYLoR8ymHdxSDyh3Pcoeb/ESZe13iUbwGn/6jrQh+
         p5aTZ9CCU8KpBbj90l3esLbG2tNeU1+Ek3rdZZFOB+kYrk6InTs8XAeZNK8+gqNcjihU
         mqcxAW0kxxgM/dII4fnwyyEwJbEH/ABDWVz4kvQzNGbvhDJvW3UiVc4LbU944jXXWbde
         HLGZIKaxvAC60jYliTO03lBXU8Eqc3DlQmKwD9me4rxwo6ktpKmYRZDKsB8sRYth7RS2
         RGrPEcR/gg3B75bMhttWMUas7ENbGYFkv4oXkQDs9uJJatBnQRfIZn+1a2nTBtv3PAU+
         w30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475812; x=1780080612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnI4zty5enT9uj3h9rD+OI5onY7BXanYIPuGhTHdGIA=;
        b=FFR4U+PBk24lIUc/sBf3Gj8GgHaOFDwMl5p93VF57wiqmJEg2mE1czCZOnRMjMoaNH
         6NfEVfh7XxHGrMulJgRSmhGiZYJWxQAhGzZ6Pwfibzxethl4h11naIeCnIYb4DdO1a17
         k2dvYZQiPbA8LCZKIUhfcAJ5YVTzEwhI+uOACU51ynoEwhqK1Mih2URuKCOx46Vv9JbH
         hf1METXx/N46cVmaQ8McnTo1RG31STDrNCIttzE4vtgEB8VW6zjrSE2TTEoP1/OlDM1O
         N6BNoLqy6A2UjXGVOs2QpoS/Auf/wIohCvouEE6WgiCIZ+DUhiVaAUX3JtxX27XMtEqP
         QHTA==
X-Forwarded-Encrypted: i=1; AFNElJ/TkZL1ALFB0+/q7DqseM1eP3+TCbg9iTqdepVTn7lkuS1WvJVdRKBdKHyHi2qh521FNNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmhyqpz8Zn97PzKiElHmr/7KXCokRCyssPTMl8c3uHmViHDSa
	uX6ofwjirNiwJJBPlq8lSVxH5Fl6W6wW4vf162XfYwY3fOAmkEAZikz9aVBalB4QRw==
X-Gm-Gg: Acq92OEKOY8Nf8VUEf2Vvqsp0ozNgaWyALLzo3hEbMibsoNVnnROTO81IlRULhEByQy
	xblQtFwV/fGimBOrAR1Dx+Jtb087NZzkiyPGht6p0lDc635J1fJvnzc5XyvdsPXCO14bLEaLbtH
	i4ZhpxPeQp7EsTtKQJMGcS17yORacw6geFWE+7lg/zULFEImYLdZihmS18zhdcMF9jqJtdm9a9o
	jnqlEx2cwkCY33hvk0KyhPi5Qoq/m0gyO0KDBTCdR+q2/UaaCwYfZusgO+k54t1AJgoJ7zyw+Fk
	DMNesvktu6A2fWR/LemVZRxB9hQWns3r/JKzfDECJHQQoN1kEl1af5ljb3T8mzu9nVXSE5hCYOe
	0Yarb5eVW8/tUCIqZZ+s9wjlpZHDf9QIAuDjBEXgpoZjpE8sKVFz/hHzmU7kEGLBuGrzOCQdkVM
	j2U6Ej/+MilzEliEXzn+6ns1Ogq9QxR8yBo0Ltm0aQ8Nm+AUrjgQQcafrHjdWskHT5a2C3AXP0i
	sjHrbJ5LZ3rpLcqO3Yf9pEPEz1FQ0SPL9mljd+z8gisNGfdFwFIiGsK
X-Received: by 2002:a17:902:d481:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2bebf5c91b6mr272165ad.1.1779475811404;
        Fri, 22 May 2026 11:50:11 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm25963165ad.10.2026.05.22.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:50:10 -0700 (PDT)
Date: Fri, 22 May 2026 18:50:06 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mykyta.yatsenko5@gmail.com, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>,
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] libbpf: fix UAF in strset__add_str()
Message-ID: <ahClXrWcPgb4tEIe@google.com>
References: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
 <20260518050550.2600101-1-cmllamas@google.com>
 <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
 <CAEf4BzbX6DSD5Erd2wb2wE+=MFTfqgvVrpkysqrCKT0W7-n29g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbX6DSD5Erd2wb2wE+=MFTfqgvVrpkysqrCKT0W7-n29g@mail.gmail.com>

On Fri, May 22, 2026 at 11:35:58AM -0700, Andrii Nakryiko wrote:
> >
> > sashiko suggests to use uintptr_t for this detection to avoid
> > undefined behavior, let's do that then)?
> >
> > but other than that and a nit below, looks good, thanks!
> >
> > pw-bot: cr
> 
> Ping. Carlos, are you planning to send a follow up?

Hey Andrii sorry about the delay I got caught up with something else
here. I'll send a new version in a bit with the uintptr_t casting and
your suggestion. I would just say that it is a bit unfortunate that
we'll have to clutter the code with this kind of parsing to avoid the
compiler behavior that was mentioned. :(

Thanks,
Carlos Llamas

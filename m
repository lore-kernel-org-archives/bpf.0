Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20C374E55
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412527; cv=none; b=HoH5kbVS3nW/BtsfCIjNw658zKH/8/+Miu9ieA2wWRQgo5opC5ODAMxY6Ey1/qv136gtvDZBtZt6KfBoyVmpIsONy8eJ/HHBDRF7jtg4sYgMElMyfbu3go1wnHlq3VFEdblJklbJjTLTYXV1gQkaXrtqst4lYmgr3YoPyVVcOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412527; c=relaxed/simple;
	bh=i2xWIjBWMMOVLKbCj/nYzREkvlauUCEfh/FrJVY6uXg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=MxhvoEKvOov+6P6N4XV5Amor+/qL2Z0NGL8Jqrzekab7uuHfolRA+kpIOTbGGB2vQ9+qu8NKO6sjqfgSqlWJ+yfvv7szOW6kTvzViVoAUzc83l0tLnEa04K94th7/SpSJakXhTRWyOQIHz4YiuY2E50zDt3r6AHk/sIWtUJdAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewap6c1h; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewap6c1h"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso508145ad.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412526; x=1791017326; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=skrB7Scfqco7deYlQ1B5vx0XLHFYypa8aSW2piXb6cY=;
        b=ewap6c1h4vjyTtKQu1AWZgfaLc6RgOV6pbyiAT0uOkfCyn94y983iXb8xp4F9Q2+Sc
         bXHaPxrmz2SI9irU6nzVwAUl1yH1wD4ju6Ks8Z6wMB75YRL+MYohSti8pzVTLvPCwWha
         z/F+BFFwf8ZkcgG36ggZ8n/01QgiQdN20SqG04TvbC+c+s+xFMVBZa89kaBOngO3VxAU
         tw/xuiCboAfiFMyQcU+wTfnzofHO3k8CUb6w30ZmGvJ8oamoNlEdZKm4mjhbhhqQRfhS
         JGLrxM9bGchtvNFXlSAgURzGXQ5NfhahGVDjn1U9NC6JhF1Wg7fW4eg+xRhSckfvr4Dh
         Mnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412526; x=1791017326;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skrB7Scfqco7deYlQ1B5vx0XLHFYypa8aSW2piXb6cY=;
        b=mDNV4WRiR7xY/xejIqn9Prpyky81jTX6wRhF4UDW7Ir6HdPjHL2Xcr8gIF3uALjz3J
         wrlW+Qch6e+UD5/1Ki4B3SCeZAA8SbVyr2hCi3eztx+kpO1U4Q8sLaGLyrbEPOsGqtl8
         yUNmHoBR3/NVWS9s0S2JEVA9jK/1Ub4y/72uBqkRXxL0GEnoN+/U6bkhlZ98my2EICOh
         R9NCSlkkKPRbf2VoW23d9mtAy2Qg3EezcldbAJ84Dev/BUwfdbdsKARsQQy3fl8FdmIt
         zReIAu5IALZ+tq8dU8/VG2ybxGw0ZidLwVTHohxc+47MicSt9iC7XzGI1WCfx5iWPGQr
         aANQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsvBLs2YTc711Inydq91bWpr7/BYf6twOam53cXlGFkW+xv9R5O3mZse6JMwo+anS3uyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4dc53Xs+BzY1Cm50X57s8IBnanAd21qh5jIFp7XsWsIMben5/
	xlTfTGFyGDFi31xoXOqQykyFVyRu5AsJdjZw77isRZ3xVHkz98eArEP8
X-Gm-Gg: AYBFou1BHnQRCyeW9riLGwi163T/ehHDMqQApmgMT6zl4rnHQdbBSQIrZmBiD/R3Y8Q
	m1+wu9gOChh1XtQ1xQfL+0xDQ5STEkSXjvd8X7to7wnerNCmHYgDfY4ebzC0Ya0vDHcvLLRmDkk
	KNYk39MBfCCWgEUqYIBMVWEw2rXhs6ee2FqhYv+kVWcfibptlkPcfnIzzEzKACB5Hc/qeSTCjQ8
	QJPhz31NrHF+mYCpD90mWEZeoH1rfubj0M3PjcK/JEXHUioXn/inSpAUQDp6MpxjFKC9ki4P+0j
	+D2jUn9S6SPbQ2dQqPYIj/QaeLkuNeIZKh5Q1a8OuvcQ6ayIa6p9FrcwJ0MBJd2RxsytyUexqjq
	QE3Upz82i/CmqUgqg8z+pmIrhB03f+7/1pR0kXFL7JyhggoQqtmXeuJ7Owr2LN7Qicc91Dmr07+
	QpQc1atyFxGVwrLOkpMgdf+XJvh+3yglvXfNV8sdkziFY+n4jXEK9gInUoQF1oe9WIlueaSI+AV
	VI+l74fU/ilyWsS9SBlWrZ4GYvwwJMsRy8JGsImSmIqSiOo/hBL4OdiGe0YYr43hX8Ov+FVTezq
	cNdt
X-Received: by 2002:a17:903:3c6e:b0:2dd:ad74:6d1c with SMTP id d9443c01a7336-2df7da9ecdamr69207575ad.25.1790412525708;
        Sat, 26 Sep 2026 01:48:45 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9146edb4sm20134755ad.81.2026.09.26.01.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 01:48:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 08:48:43 +0000
Message-Id: <DLP49QC3FFYL.2255E96POZL9C@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 01/12] bpf: Fix kfunc nullability
 diagnostics after wide arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260925211256.1834061-2-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com> <20260925211256.1834061-2-ameryhung@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 02:12 PM Amery Hung <ameryhung@gmail.com> wrote:
> -		arg_btf_id = btf_params(meta->func_proto)[arg_idx_from_argno(argno)].type;
> +		arg_btf_id = btf_params(meta->func_proto)[arg].type;

check_func_arg_release() and process_iter_arg() index the BTF params
with arg_idx_from_argno(argno) too.
For kfunc(struct two_u64 v, struct foo *p) 'p' is param 1 in slot 2.
check_func_arg_release() reads btf_params()[2] past the end of
the proto and process_iter_arg() passes 2 to btf_check_iter_arg().
Let's fix all three in one go?


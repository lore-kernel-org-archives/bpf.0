Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6E3242D4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140858; cv=none; b=RzNMVExLIngEJ1mFuoIl77L3SXpyAw/4yNeDNiv+YnMXXjeneXgXJ78X4z/xdkWVOs1xFNIVhAlQvNpt8Wh8xda6njCTCDLx4mSUVApD/++hNSHb/ApVoYwxEfrPWGKrF1fmGUH0ZqB0G3rhs0aBstkIJ2ccldhO1lH5OfNLO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140858; c=relaxed/simple;
	bh=9aPlF+3MdLvHx+v5bQ2/2n1zfWG/ANp+9DIpS1keT9Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lbCyPS1oocGfKCyinK76dmpRDOZVUqyWRZdmqb6YPBkaXSdyLESQHrEl1xIwshn+BRV72xcR+CIPDs/7K17hrVNpTSuzy8IFJ5pee08KAvygQM36SblXlKY+ztCJC21HQTchjDwvXJSBaycaxFHJS9u8DDIaHqVSLpdYEfQTOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFQqkvTx; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFQqkvTx"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so667705e9.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790140855; x=1790745655; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9aPlF+3MdLvHx+v5bQ2/2n1zfWG/ANp+9DIpS1keT9Q=;
        b=WFQqkvTxyZ/NMTx/vYuiKIVZXHLC4/ids6nnG6lNHDqJehb6IAjfUwieIOcNKTuih3
         B/I791tgG7cAmBy0MdwefFJTnFqBkKfGbMjakZjNsD1uOeewRHeOhjAjn0vQAUx5S/KK
         4VC0jEhgRBPo4xwhEMMEI6RBLcJXBwwzNxSo8NjMYKwfLuHUKBKN7MzZ9s520vODE87a
         sLJcm9JLKHde8SnfHQEq21tYYsgZLhHIkB7R9LI/eWQdAxOllaN0gm6EqJv6tgdND9Uu
         fF5QjlUs8gtl4AQY8o90dHrabYHHbcRu7/oRXAHalnlLE64srdO6A4Ugwm3Q7uJQklRv
         8FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790140855; x=1790745655;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aPlF+3MdLvHx+v5bQ2/2n1zfWG/ANp+9DIpS1keT9Q=;
        b=xD3BF8jVMoMkNY7EQBF7GhHH8U45ZiWHlpap66c14V2fdARrG2TJ5ijoOo8g7+uQuR
         ipiB8zsD/bldgM/EFFZcg77SgKMg2CcC9+rU79qXFWbGw7Prj9N7S8ZkQNMvqD8YtdDT
         uwu1D8F5LJIt7/CYk4BdaK4frumCMvkvS6trlkExxU7BOARra7Kzy7sdRx4/Oa2EhQUt
         IVRbxcdXhSWmnjWSPU7qx/9yy5yMPmAYXYPTLhvV0We6W11IC+MNSiTk3UnNWPuRe9qp
         kcok7rEq78gyFZEwlXM8h3xU+kwrfIkerSJAGO7CmwGlvtK6jhvPLfEL1uoI3SyNmO0M
         6X+A==
X-Forwarded-Encrypted: i=1; AKwUvBwCRvoHlunXu87A+HpISARSo2Bb1/48PNov1fg03qMNB2hu2YaxDijBKXq1zTLf4C6n7OY=@vger.kernel.org
X-Gm-Message-State: AFuF++kYV6mBmwrj88KE2qAdqKM+ylxAJJ9qw/xwBMj5znPw8+dbuQQE
	alnEgRO7nuctsk6w+5IUVEAJucwPW6CvaRWsTAApAo0hGL9/7E3mLZpx
X-Gm-Gg: AYBFou0yyUS4nzoW6LaOdOPYMaJXi/bydxkUO0WzVBjJ/YDWC62DIZytOvr++eeTkft
	19ODkdb6qTWNUbg02Y+xH3qAu3v0kKi1nP+ku9Vp/ZHnOhlK6aaiAbN1lZLlOH9u+odjxla4ZcT
	RthlKzuOxXy6qZRJT+YM8tFZAtqaV24kX+EpDJKoWpwBSrZ1bAV1aj6iSHC7KBSTJXDEkUDNwq1
	N75uvK9ko8eL05HSI17StchFzBo2r//91YGcrBKdMmHzbNQOErse98Z72eaO/c83d+rc80YvJfC
	9fjHIRBDgr+Ee/Li3EcArUcIxoZIlhcqzhnCL+ze6/+HJMdSzyn4BCDtTNkik1x+mTRSNfVGtAL
	ssLV9AKr7STbSJM1SbPO4v06dNgF3OJJ/ZA9a6VpdpEnDisC7/9IhdWNk5Gq5deh+QzDIrHd8M6
	qOuC7SOKiAQWfdzsrG0NOO6YshQsLhVGrZiABHuNDGt+8iWdOsWmpVD3urqGjEdTLPIr4Ul2UrH
	bNJrZ0CKievyuDiAfA6NMDAGzfAvFeU/t01xNNyOXqcs66XxC3mewUoeB3Mh9VwSyswtExJnGoO
	P7U0+DXnsb1S/U+9NJ1nf+5dOvIEUIEFMhixtg==
X-Received: by 2002:a05:600c:35c5:b0:49f:ce78:356c with SMTP id 5b1f17b1804b1-49fdf0fb77amr18835845e9.29.1790140855086;
        Tue, 22 Sep 2026 22:20:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684864c8sm3964835f8f.13.2026.09.22.22.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 22:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 07:20:54 +0200
Message-Id: <DLMFYZBVQ1GY.2GBV7V92U0ABF@gmail.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>
 <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
 <CAP01T76JZUzzyr50dk0NzGv73p12v8E17Lbgy1_yZVqg3Qju0g@mail.gmail.com>
 <DLMFEI43TYVI.1KNMAQLNWT2JC@gmail.com>
In-Reply-To: <DLMFEI43TYVI.1KNMAQLNWT2JC@gmail.com>

On Wed Sep 23, 2026 at 6:54 AM CEST, Alexei Starovoitov wrote:
> On Wed Sep 23, 2026 at 4:36 AM UTC, Kumar Kartikeya Dwivedi wrote:
>>
> [...]
> We're not going to support rust panic=3Dabort for the same reasons.
> If rust-bpf prog is compiled like that it will likely be rejected by the =
verifier.
> Accept-all-rust doesn't mean accept rust that can leak resources.

We might find ourselves in situation where panic!() is present in code invo=
ked
during Drop or unwinding, in case any runtime checked Rust primitive is use=
d
(Rc, RefCell::borrow_mut(), indexing into slices, etc.). That usually trans=
lates
to complete termination.

Code is written in such a way that it won't panic!() at that point due to
various invariants, but the call would still be present.

I am not sure we can simply blame the user in such cases, since mere presen=
ce of
panic!() does not mean the panic!() occurs in practice, even though the pat=
tern
compiles down to it wherever that primitive is used. We will simply end up
rejecting the presence, and in turn rejecting the rest of the program.

That said, we can still tackle all this later, so it's fine to continue for=
 now,
I think.

I am not even sure what actual programs will end up looking in practice. Th=
at
said, it is something to keep in mind instead of being dismissive.

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795406247;
	b=G4yE3OZ1SMiGe7Ml1mUcG6S5eZGkYm1IgpWiLRm06+GaM4WOfZSBqb2feVPD+0FYVVNv
	 l3sDpOZwlQ6YcwiKCOJfvs1rXZB6FxRRVj5C2ewbt2fgncVB7Fq0PqTT53uLvTBpzUE0w
	 6qKy3Co64NhpbLJQUQo1QQ/ELTFJtWT94oJwMzoN/PZOfjyf1AjQ1Lxaq+TJebaydTddK
	 vvsXk5Y/HTu7MybDfhV2uyqYAnWzM93GIQG4NnwhoRUmcfJP0ZbnRECp8ifkseF4qHF9H
	 I3cUaN5Xn+EaremrzcMf8OSy22/3QWh9RAbHgABGBedKyga13ad1+Rv3R/p7oS3hsKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=7qRxvbmJ28nrk2rOHhxSyhx4jr06fpL9CDPWnKHiTxk=;
	b=UkUFa0Tt5QHU9FXm+iGIn9xfHljxh5+wj0sTDkn8Hu/NNqGJUQTDzd73q7joMTJTTh1n
	 bRNjiRMAspllPn5DiV3uPldfldfmWEe3139Bonqg0bSghzj23NlZiX8nifuhjAGFuov+X
	 a4UOiYuU+zWlsCmYSAztG69RCCDGV3uCny2syDC1uKM1Kke5apCTnzbXQv4wrYrpA5IsJ
	 uBmmT2azMbk7+YPh5K8YzE7Lj2DUQn3QlQ47tIOOEFVpnQ6Y1vpWvEfaksZ7KmNNUlPj6
	 F7GbxtGJeBcAiXFP7zrt1zsXRhXedZZd/fGzBi59+6aD/fGLNbY0tBcoYU3jsaN91tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCWfvhjg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC3606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 03:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCWfvhjg
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48fc51a37f3so500810f8f.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 19:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795406245; cv=none;
        d=google.com; s=arc-20260327;
        b=KisJDAlcGsKcPgOPw3PWiyM4d7rs74H8lMYgcBtY9Mt/GFGEsezYIIw5bIoS28DQFs
         cD9csOHt8FqrSfq1McEIICoIXPMS0grax0n8yhDrqxljLVQwITO7uxll0sXOqpWXCJEy
         6yT778MhrmNhpbpOHbGbNv3p9WBNWiB7nLyI3TjPXCW9MFDs9w2vXZ3ExeSsqdB2/LJn
         hPrJXdoImTN8erNs7/q3CEhA8oVLN4RYyUVOxRMINUAfqHrV+tpqVdr+GnmV/+9wlVoG
         RdZhj0JNpZpmLAS9TMb3Nq/QmTigGUwJNqbUwyRkYY0QK5ne21xJZLSpqMktxK3CmkRy
         Il8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7qRxvbmJ28nrk2rOHhxSyhx4jr06fpL9CDPWnKHiTxk=;
        fh=egDHTYiRlWEhjX79I8tyYfgSLjlZiSst1N6eRvPbXzA=;
        b=nDFrK40VDrvG3csFq7fjcZTCn5cc9H8XlB5tpEqLjMx/1GqXaRT2q9zEelAO4PJcE+
         xnoEhLUroSJ1hKQIPDi2u/gPv8ey0B3n+EzW3cAaZRotbZbYtS9ce5fj/U1Pw400p8gm
         fpPfjr3F1jEs092PD3SbbtkqJYpjxVfLC/Y6hazLAVoV5dP/vTvzQzJp3AiiDrQkltKU
         ut3LS/YN8x43dFDYGmN+UUfEMrcl6TZCVC069liGmd9xSDlt5Lls9EP3lTyKH7xR1lHD
         TPT50ZreN5bju+YOg3HaVQ78/VFV3F3n/cZ1DFW1gFJrT+uzFmSHW7PjUy7ftL3gyFYq
         vnpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795406245; x=1796011045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qRxvbmJ28nrk2rOHhxSyhx4jr06fpL9CDPWnKHiTxk=;
        b=QCWfvhjg1m9QtL8T0G+h+zEd6lBaR/9OWJHUPxW4XfWPVxY9CDbMA4baszoRmDLzOS
         9R9BH81IXYMM6Zj4mURHSPNHRUpBQQ0PsNrD1wNUeZebYRaJ9MR3VuXJhBLjeufojYVY
         UGBVjb0eiBfVc951zq09FZcqJGhEohQq54iPOLWHR99LgnBlRuSVomsvKsfPetews4oX
         qH7qgmJ/IZq+UPb8+BXDqubM+DiNHXTWHp1oSs7YN809G4An4Xb5c03lyzvIU4493SYV
         PGoLX2+I0GPDO9XpTritwSGSBIkWpDPmAncXDayTEWnqoV89CvDhUUM6HEX8EbWxMflj
         ochQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795406245; x=1796011045;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7qRxvbmJ28nrk2rOHhxSyhx4jr06fpL9CDPWnKHiTxk=;
        b=JOxMM9cz4SB/dWo0li54QgIvyBOhECqDv8l5HS+creYEOPR7dlNFDcAdMOrOLw5XE1
         YtKlHpPqVmdU0zP+DETkJDJVMsehckILsXQCO7MEtgIn+BDjkZIiq2vXyGaNlLWsl3Jz
         f/Z55zKGqze0OAwPD1D4g1v0504eajnbXlMHwPWkyyiBZHOKDOMPave2H4nxeykI+haZ
         ab/8OBdpQBvFXz3PzHh+++yRqRsmB+z6XtZDlcIBseIBpudZfMSu6j7bZ/S7xrjuBZeN
         /0H/1LnZvevJzynFkSGU0FOiTz54BZENYPj2UVFwH7/8+KYGcdvcHNhMykVAhcQf/Aic
         ksZw==
X-Gm-Message-State: APuU4Z+YEKj7FAdbF/T+uusl6ybc2eE0XUvQtPmrbFDiadSYDNcrEO2A
	NW3SHQc+EgMzpHUMAFmouTk6c71aUtofTtshcEkwjOWuvjtzpbTMZwwyKt+mukgQLAxrjlFN6Vi
	6S1pw0HsZ/fX1gZlXBe7ri+81RYiy2Q8=
X-Gm-Gg: AZFdTZcVUw0vjn0c+xjMqxluMbKX2xTLsDNvWXkawIRMvN0TDENX0BWNUVNYev1IZCk
	3DJokiy6kLs8J9dTb50VluQ67sQwaq+f3TztvBl3nt9SL6JiDobZcrvLYJGnJBMqbrjTAX82PXL
	0zAxLXbRIQ0jJ7oO0OCku+L4rrkaJz2tJRzkFKtYEZrFw+TIUb+xRu9+Nq/5+uiVv6bbxRbGue3
	lKnaps62+mNbxKYyKKB9lfhNAktZzLnYKasmH6SOh0Bda2G7Al0jPDHhKEnnRaIeqPclFcLfKzo
	kYdTspXpv+edWQV6HB8ckGgyDhccWAYRyMCgK1cFT3KxFroHTjXNjFlao738KbfL/uqcbtKVBBX
	83FnI5oRE0dLrYfkAMywG7/T3OQAB8GA7259xrXh4wFxXpqVWsKtmnxdZkuGNz/qYsNPsQkALyG
	OcB+KoAfOI5bO7Mj4+xLIn31poAlAS69O5I0dn31UOBjUAvtwRQLKCMuEe2Vqn4UXScgfgvUDbi
	f8G7F6klEhOB2Ng
X-Received: by 2002:a05:6000:4a07:b0:4a7:14d0:9c4c with SMTP id
 ffacd0b85a97d-4abab02c4femr18518479f8f.6.1795406245121; Sun, 22 Nov 2026
 19:57:25 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local> <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local> <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
 <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local>
In-Reply-To: <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 23 Nov 2026 04:56:46 +0100
X-Gm-Features: Aa3M54qn3A-QVn6NC3O24c8qZLQ9Y3TsEAAFoy_M2WjIHYuU1yPw-r9md-0eGAI
Message-ID: <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
To: Borislav Petkov <bp@alien8.de>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 03:55, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Nov 23, 2026 at 01:59:32AM +0100, Kumar Kartikeya Dwivedi wrote:
> > I also don't understand your security concern.
>
> Was:
>
> "the only line of defense is for is_bpf_text_address() to really DTRT."
>
> not clear?
>
> Do you want me to elaborate?

Yes, please elaborate, because I am not sure why you think that is a
huge problem.

You're treating that function as if it's an unknown, untrusted black
box that can break anytime.
It finds out whether the fault originated in a BPF program. What does
DTRT mean apart from that?
If it starts firing for normal kernel code, this would be the last
place to break. That would be our bug to fix.

In fact, for kernel address faults, we already invoke it for exception
handling. This change would simply extend that to user address faults,
optionally for BPF code; otherwise, we panic as usual.

So I don't think it's a useful argument, except if it stems from "I
don't trust anything BPF", which is not productive.

I am happy to engage with any actual material concerns. So far I
haven't seen any except you being constantly dismissive.

>
> [...]

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614969;
	b=mwKgScBMs7rXTe2/7ybb3u0UMG/h4+PJEGQi7Apo3tUcY9/bQHOoFm+xPkBzfq6VCJky
	 44CRZ2taFmHHqVIPtyC9EAgHmUWhp9TBi2M0AXDOsxUvawkZnw02VJNDhOg4plF7YwVkB
	 +luMVJcL/zGkv+s/9L9KbX/Rac/Tpf0htuhcUWAgnSsWkVOXAVr0FWbRTVumKdxFQXESZ
	 R/RRDaYC19AJx1mh1+XpFRypvnIT65Pz25ytAmqsEBW7O6OxBYKrR7ZpPrcO/uX+/3xv4
	 U6he41MBVtWeFryDsqjJWe3w0UAHTaJDk/TGk7QkjJoPILUVfmMoL8ZUMkJHUQMm/tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=4yrUMiwU74ePoC7CS3ielRLdXk2a6q9S0udjjWNbE8c=;
	b=aBEyyPLSqetiUv73mLTbJGrHy4TF7eScOnFvCO9QKqrZ6tMd5NGh9Bdn54KHx67jsqi4
	 gPZ8CVGmmTIBbY2wSzWgLRbu9HMUt2kxxTFJjWBunrXXcxUeS187t/QXkcCwTpt4j1cPH
	 byD+rUV2KmLBZHn6QiuQepXCsGR8kWy5PMTRItqs+F4FppeTzkRTcsVBOBcCgpIXvWz2i
	 TAljsvJX9zv0YRdbUvx4FY0ZjN7wrMsV1xSmjLPjpncxfj0j6py9eDOo0/gBtGXSKZQHM
	 0k0dZktsKCpwaZQEe1Mntqo8FD9JvCHi0LhFFD7HEaTYSFRqzmivY/EI7L+SMjCS+0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v5iZSFw4;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F582606A335
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 00:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F582606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v5iZSFw4
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so1307557a91.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614968; x=1795219768; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yrUMiwU74ePoC7CS3ielRLdXk2a6q9S0udjjWNbE8c=;
        b=v5iZSFw4q0Wg2W/n/fCZuIckUPY1gHJe9x3xA9P5y9Anc+oOLqjmyo9uRUeazV1pcY
         2rSNuN7+P5ozU9+Ck9y0Wp/Ei8/yypbtowwn3bHCpDJruG1s/rZOphXLl0AqYQvUovcx
         CZCd1epsTL+5nUrT3cxc6e0m1QHeQPD0DVeW+RyYI19cVCS36o9a0xw05S6UeXjnfow6
         v9UeY+BV4AiDRcns/iiCnk660SOnXNCJPiDYCWXlD8b7HKvx2JM0r+qJdaCeAhEulz+T
         EkMKgCppNCjS4RAuEJrHnF6nWwFCsIG4ZZcbEvh/o82SNhHgkEeARl8E0ETCpWGGFnij
         KK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614968; x=1795219768;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yrUMiwU74ePoC7CS3ielRLdXk2a6q9S0udjjWNbE8c=;
        b=MB9B8d4eGTBgL4UuhNZ+mefaF5v5ol53lvZOaNxBcNdZ95AQB43ah1VFt+gjNql6e0
         v+XOj8h64JOl7I2CpM5eRyNKrMNCslI6E/qz9wAedpgrqeAWNtFO9FmNVSfNLFQMAAQU
         a7Vo3zXW7uOnR3OVG/+kutXECuyQd+s170+K07kk3+HKBhT0gOqX99mwpOwvuDFVgvv5
         yY+5QK9L1hWYIhxiG4SYnVW2Q8IGWDC0aiv/HMSzRydfPPq48Lk36wAQh3KGOry1xYhK
         3OGEWIhFVzYD+LPrwEHLLl+SvqmCYe/a5S+p24BentaSqOyrqdclBCD3Y56qoV4A1nuS
         9RYw==
X-Forwarded-Encrypted: i=1; AL+hErHu+ix1LaEhw10QcL3Hdj+RaMU5dRcgAidG9VwN9R1zB4qjBVBajzyBG+9PFcecomi5c4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pGvCuPZKm03P2lC9utNpXJ0s0guXprD9EFbA7U83hsEM/DFeC
	Wvcy1SzmvK5TvWd47K9TAtAq8bpMzYEWjCbiHoqjm5t1v+kkaBswOyx6
X-Gm-Gg: AYBFou2wuZUSHzsNvhhaJ04lAyMRNIKQRlxNHgnFV5IZJjCNEt5/bohyft1wXMLPdZc
	4Si85ESFi2SFf8zGAkWlLdujeWHKW2oNWoCEoCWK4cUbXhe8F8n8TWuvZzQUq8V7MEbSfKRj/kG
	wH73ivI14zf/GA2B7bkOvh9CaiobK0cOAJuu+IBhQ635dq27MTzy3FXi89UCOe1rA0wfajgc4Ne
	YVysQobBCYzFWunW/nomLUr71g/UAsFLnxH7e45Pcj+Hfe1hh8KMXKoMPZSyyJ8gQ/WHO2TQkrf
	E1E9Lh2WsGuJThi8WrrUO5UeYNloQjx2bay/TawUEAZtIWmueWLRunVPMYavs7EWSNW1xcK3Kyu
	AN5blskunA30hgwxHsszlVnwqkthfOei+bWiGNpe2eIvpbwfKiC+o6jgFiPcVYFJcjl6JmI+DBs
	+8Pef4wbu0LnJdVgn5o79RBLxmCiBLFAAeQ0euEsOK40oBs8RSsrU1s3pMJ4uchYrXCzvTtnqtZ
	ysl5r3KNDF/zYOFTQV02efbLDfIh4QRzw13fGx3xd2KdISkJ5eeMjoOw8lKjmWJJposPuLpWTCS
	iPv4jsNE7qIrpbIl8QUsD3lSe6SP7/GM79AJGtp2b/yew6FAF5zh0eUBd2wA/rrnNJjyTLwZIlS
	QTcMRE38U1q8MxyVyEmcG75t8fTG6bh+HjCY65Yacfx2DlUQTZSUaNHk=
X-Received: by 2002:a17:90b:5546:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b1b0a46d3emr3997899a91.35.1794614968390;
        Fri, 13 Nov 2026 16:09:28 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39d73c9sm3046893a91.2.2026.11.13.16.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 16:09:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 00:09:27 +0000
Message-Id: <DMUHWUF1OF82.3VM2D2YIBY40V@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 00/20] BPF kthreads and waitqueues
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 09, 2026 at 04:27 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> A syscall program parks the same way, in the user thread that runs it.

I'm missing something. What's the point of bpf kthreads if only syscall
progs can do them?
It feels less intrusive to start smaller and allow parking of
user threads from syscall progs only... for now.

kthreads have no limits it seems. memcg is probably not aware.
I didn't check all release mechanisms and cleanups.
I'd think syscall prog can signal to user space to create a new user
thread and start bpf syscall prog there.
It's less flexible, but at least the ownership of threads and their
resources are clear and contained.
We kinda do bpf_wq() already, so one car argue that bpf can consume
a bunch of cpus too, but wq is really for short term work and
the rest of wq machinery will yell if bpf is abuses it.
Here kthreads suppose to be long lived. It feels too amitious
to let bpf lose on them. Let them be user threads for now?

pw-bot: cr

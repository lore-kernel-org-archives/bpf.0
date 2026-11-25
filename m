Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579340;
	b=DwoZ5cHRWv0QJ/kHEVTyV4iWmEvMRpjiefL8iwfVlL4Mr5dmz9ZSppNDkLq4Wz220E78
	 DWD7PkXn8YdXSefQBPo7zGQzxbas487fQIkuHMgL/qD8D/MGk/ifj3sPMMErRHxgFf7jT
	 EAO3F7eVX+mSGSG/9VdlB+iwaxbHhz9YIG3O5nTnj76xrm/0h20QYKFw9fk8CR+9ph+3z
	 GxmJvMAkByVYrEaBdlz9WkQzvJmkhKwpBv+VQ/XebmYz8mTWnwl+YIlchp1NN3L9cFQl+
	 czfe/LPFU3gw8wE90Q1zR1CnyHnynH0AYwjTpqWIis1hR9Enq+EAzkloNAgyLhAlvpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=b5t7kT/F/kUHuHqqdf7OGhwe+jg/XQAt4FVRvgQFTFM=;
	b=WeZKgbMOOCqL+I+lnUFuuk7UqjiWw1fFXlzY6YZGZh44A9qhTYfTaU/Yvl4RUwpSevS/
	 WeDK1rxDzGQTp4aYItYA1qM4EH+QJqvkEIH+Ygx4kFWXyxlkqwWg7ZtaRnmyIXU/3LTqd
	 oU1G6EK50VV4Bw0vF09RBXHp0hJdfTTOm4fWZgNdZpq542M1Vnjprvwqb/W7A/3HaiIDY
	 asSUNYNPZfSOqLXJPFLuVVWpLjUgV8cOiJ6k/OQNOr+D0PCOzO7Zym199hKMxzmBL/qOq
	 f2b4hmVooBWymLm22DJfHvdzuDL/XYH2lnEgrNZJLkPZbS2UWXh5ZxU9+ZBVH2xKkkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmUGcFTr;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD6606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67BD6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmUGcFTr
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cddc250d815so2074835a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579340; x=1796184140; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b5t7kT/F/kUHuHqqdf7OGhwe+jg/XQAt4FVRvgQFTFM=;
        b=qmUGcFTrSFIX5w53DMBY9t5NDLbT2ffVFUIqR9e8b+NYuBntScGuFsq6u03S0Cj9yL
         zAoke3NBJsIg0FUTzu/6hCvixZqaN3uZarKeAPeG1hnMVEDQ2jQQ8pq9oI4AkjLBd2Xs
         vwVj1E2c7rh89Qic3KEQk/m7YiDLYLk4tA6BGapSLVa9KhQ85oZVCQoxq9BCyHPHCS/q
         oUYtbqGO4nT1PtgxTiec2U/CaZRTLhp9HAN7lYtDu7gm+YNqou7O+IICYK2Qu0jRbgLP
         xCQtkWU8trttJFbcLUPjsWoelPhSR6imrKeqEYwDPLLFa9eiPnoPMBuDSA+wXdvnHi8T
         lTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579340; x=1796184140;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5t7kT/F/kUHuHqqdf7OGhwe+jg/XQAt4FVRvgQFTFM=;
        b=CdQZYVFl+GLcC3B01OZBGk70TWRk0ziYKBnrhskHljyQ+fmrEEJMBDDxO+l1NchprS
         VgASTLj/5zjGK7QiTNJW6Je+ZlZVh6gNuAleq4akOhd1nNgGUCf5sE3cv58T6XVmNAPx
         gdCyixha/rVckmH17cD3lZrim0hnv3w5Q2VkvE+tHOcYHkM6EviFRUdY5Fxfn5GJo/+q
         daFT/jCdd78RsMKwKTFG+NRWFWG+v15D2ULsVvhw7ee8sBkyV/aJ2iPdu7pYgZ1zuTW3
         3FpdR4xm2tmvv3HPvORoKMFyjsdkLN+Din2Fwf8fn5p9a5VFbckEx+R4dldCRYeMkklC
         oWTQ==
X-Forwarded-Encrypted: i=1; AL+hErFbXXmv/Zr1DWBh/h3t1zd/6V3OfDNSf1WODO818+RG+gk3I5A1lAX90RhosYVH0txD6tc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tNGqCMy+bitRF+MRnmPC+i2SgBwSwTBgox54hbbqWVp+7Jokt
	jwKn8mAvMyDN332jOIYmEoMN741SxH7bCAg+H4r77neIlHF6pYePhuh5
X-Gm-Gg: AZFdTZcUM6t41yO2AXky+xN0IUBcZGdwa06fBFyFj825F06tC0UmcuITYMFkcfonOif
	siEUaf7d0QaRbgZk0a0Qr3+wfgM2JDKv8BX71dO2Ucayp1O3UHyDUc2w9U5NgqYXyBFOg6ZrSji
	Cyi2qMuk3czJ49I/dhUpmoILjKrUqQW5IxCVrUa1REj9DAeTK5diplSaxXRLyqXsV4iy74t2fJP
	LZ3LaBS5kYTa7gV852yeulyR6noxNMrYZSbQWGfkgDidFF5068lN3ZnHGwkc33rwJeCufliTZhu
	USmibdefnv0cgqt+R+YGEbRRGtEdDUp9dYJMDIY2PhKj+ZPMYkVameypWO726eZa4me9CvJkq/U
	ypaf5mvUFGD4hZ/1C4TnY8K3040pYo4YA32hxC/xPi6tDqsA2aMM3GndW1ECEIpKtxOT50jUhjb
	/ishJWeIfMsMxfiE4ZGssQqLuLpmC2RWY8wFqicDSA2hsKMBBiV+f9OwYXS7hbRUN3GO/QnMfvO
	RWhbSsTIKtEaCDWtAyehDNJB9W4Az2weoQqSdBxVfwHOZHtrOnFySs8cveq1lISF6DVsYgHsOTw
	hFqShFEk/NyWOa4X0EAoyTCP6bM52JOF2G4aQLAB49omenMkt14akOOUJD8mLAr/8VGFpKqf9pT
	4TagJtv79Ya1NOoR46rknywVwoqX5ROnJG9w=
X-Received: by 2002:a17:90b:288e:b0:3aa:f875:3385 with SMTP id 98e67ed59e1d1-3b41c907e21mr15006021a91.26.1795579339396;
        Tue, 24 Nov 2026 20:02:19 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm28765330a91.2.2026.11.24.20.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:02:19 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:02:18 +0000
Message-Id: <DN3ZR4IBQUKK.2KZHQUDH3ZRAC@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>,
 <mikeba@sentinelone.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Martin Kelly"
 <martin.kelly@crowdstrike.com>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, <tyler.wilson@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
In-Reply-To: <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
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

On Tue, Nov 24, 2026 at 06:06 PM JP Kobryn (CrowdStrike) <jp.kobryn@linux.dev> wrote:
> The patch below is a proof of concept scoped only to x86_64 trampolines.
> It was validated with the bpftrace prog that precedes the patch, along
> with jited assembly dump to inspect the new private frame API calls.
> Overhead measured was roughly 60ns, but this was just a first take and I
> believe it can be optimized especially in the JIT area. If it makes
> sense, this could be integrated into the series or sent as a follow-up.

If you want to redesign private stack please take inspiration
from insert_arena_stack_get(). Much lower overhead and no artificial limits.

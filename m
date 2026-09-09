Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD039C017
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978557; cv=none; b=ffEwx9I/jdoMqK1ZIFLI9BfZb9cNS2Oa56MTLXBXTKnhauHuwDPAx9oGHGo+bv8bqWeldoe0HA1ka3yaAzUwSreIOnEhBm+vU3/1jhmY33PfwbLyiIIBtvlC6OWcM5zvqpm3Wr7ftu9h45oO4hkR0ppQPI0mKTIojmJLrobGjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978557; c=relaxed/simple;
	bh=4D/mn8F2dB3f8vcdPsHU1tAUaAcT/+4x9VACwuiFHwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lezKD9l7fw1OANrpnICgZza131pvd/pGJn6dhgPh0acb7SlUoefCvgOhULLjTPjrhVb3UtmZdVrJrGxvoJ4DWYEnnKJM6YWwhnEpg6spbF/B5xd+G/0BnpsHkdAkBPX5W98PR6q1dm6HVB3TpQOM1BmuI9r8gKTtrQz6BWTnva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hbT+3/qH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hbT+3/qH"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0220f2so449463a12.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788978555; x=1789583355; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1oUEgD/rN41C0bVeA3gI1cpMDgX5748s/d/3oZ5kHgc=;
        b=hbT+3/qHCQkvm4u4JN3ZbE/Fwed7LwI7C7lmOZ03xuD3ZPXBfC+v/JzENV9LJbBKyC
         C4YHGQBcZYJAg/ZOKLHEldIRwvXrDjJ30YAt3RtwLb4ZlXrBoTZBQfX17hFpylOFo6cR
         hAk+8LKldNCkPondeiBCLLKBOeIAX44XZPjr2GDfUXgP//Ujo1/zqzonepatCHSZNT9I
         JTxj0lKMhGYcTEkohFI1j/4j0ubNgb6n/3Nl7jk3NwYjzcRm/QoVNwlbnqUcvXEMlYq3
         NS8GoBxJ9t42NCThDVhbpL3MjTlXCazIxy2wKih4pKFeC6ZrSICnm5DcvDko+Ad/sU9u
         qLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978555; x=1789583355;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1oUEgD/rN41C0bVeA3gI1cpMDgX5748s/d/3oZ5kHgc=;
        b=XIBO4loHwa9nx5/GWkwVWI8UsLhLHyg1AKTZphOOyXZgVAfYOFrSKb6HVebjVQSsvq
         0bUFu4aWRJr4vWXtOB6LBInZBIiWCW6DqbZt2diZZSIsYyhCvsmIUBW9cmy08tmD4FF4
         Q52Qt8UdE3AeM+Pc+5kK/EEU/dzSWSYRnwe6wxAKKth4VPtxOzAVSoTJkZZXR2EHZruI
         UpQOP6Ek4zHeD+uH81aJ+PRetywGC++6Z0zB4rezHtSQVekUyfHKDFPlvQIlZdqWy5A3
         j54c8UySHJ7rmzkkQ/oVn+3bKSY1EjPfHwsIooOAQq2gzkV6HYzawWXL4XwP2Q7NxyBi
         ci+Q==
X-Gm-Message-State: AFuF++mvp04zqAG1ZWUHf5X1RhHEChB5puyZRf5c6pHTgbSP06B4XYg+
	cbOxzAJ8PBYUcNAtomh+MMVg1DMI3sA0U9W5sDBcJmttJs/G65RFgg6CoUqpu+nMIeM=
X-Gm-Gg: AYBFou0AUAICZyTTMBtHdJU5iL2BILifaHlkHYEGZuUlJCB2ELZse2kg8SiW1Zi5sfd
	LRdkh5bsr9CDMHcjGEMJrnMBhCYO9zScqPh68v5ykNvzT2yjUtsVun1p+O6/v3jVXX86UWRlyho
	JrEZM5wKOr4Cmu8CVHmOIYzPzzGBCm3bYDFVus4OOdEDNTRwLj0pFzBZI8vIb2eN/3wuLkm3tdf
	N3lwmv8vEqKJyl0IRbmpcPRBB1fEKmnw1qSGpCgd9dbZVKSGIid7Prcjrxk0kQuDfuwERKc4cy0
	o7WdpnlO7sf/xJwWXCcZe/PTQJf2QpxY08QG4AKZiKepYFPkhZMctF3sfB9fo3+DqbnQSa6GKCP
	vwzYxdJ+CvKo4jTRguBkBUwb02VJrsztylpojEwmoip03iBdwwSWIsmyIvMHt8IYlYqHgwTrTI6
	LvAYjPvDSaEzqgW0b/mo4m93smwoWuQgYff2OyOUf1iMXRQutuS+T3h0GKlN8L+AVHmwVJFq+uy
	VdKYfTsXQEA0nmISctWvKlHKTjz
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id 98e67ed59e1d1-39b262e28cdmr58011908a91.22.1788978554953;
        Wed, 09 Sep 2026 11:29:14 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39cfa5b2fffsm1727085a91.4.2026.09.09.11.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 11:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 14:29:12 -0400
Message-Id: <DLAZYXG7B54C.23SY9Z6V3JRT1@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kselftest@vger.kernel.org>, <sparclinux@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 0/7] bpf: fix typos and repeated words in
 comments
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Hemanth Selam" <hemanth.selam@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Russell King" <linux@armlinux.org.uk>,
 "Puranjay Mohan" <puranjay@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Hari Bathini" <hbathini@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Naveen N Rao"
 <naveen@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>

On Tue Sep 8, 2026 at 1:48 AM EDT, Hemanth Selam wrote:
> Fix misspellings and repeated words in comments, found with
> scripts/checkpatch.pl using the misspelling list in scripts/spelling.txt.
> Comments only, no code changes.
>
> Changes since v3:
>  - rebased onto bpf-next.  CI reported a conflict on v3 and asked for a
>    rebase and resubmit; the tree has moved on since and the series
>    applies cleanly again.  The patches are otherwise identical to v3.
>
> Changes since v2:
>  - moved from mainline to bpf-next, which resolved the earlier conflict
>    in stream.c where the typo had already been fixed upstream.
>  - renamed the selftests patches to the selftests/bpf: prefix used by the
>    rest of that directory, as CI suggested.
>
> Hemanth Selam (7):
>   ARM: net: fix typo "arithmatic" in comment
>   bpf: fix typos in comments
>   powerpc: net: fix typo "upto" in comments
>   selftests/bpf: fix typos in comments
>   sparc: net: fix typo "evalute" in comment
>   libbpf: Fix typos in comments
>   selftests/bpf: fix repeated words in comments

NACK, this kind of churn for no measurable gain is not productive.

pw-bot: cr

>
>  arch/arm/net/bpf_jit_32.c                                    | 2 +-
>  arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
>  arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
>  arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
>  include/linux/filter.h                                       | 4 ++--
>  kernel/bpf/reuseport_array.c                                 | 2 +-
>  tools/lib/bpf/btf.c                                          | 4 ++--
>  tools/lib/bpf/usdt.c                                         | 2 +-
>  tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
>  tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
>  tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
>  tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
>  tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
>  14 files changed, 17 insertions(+), 17 deletions(-)

